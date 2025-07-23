Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CB9C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 22:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uehph-0008S5-5z; Wed, 23 Jul 2025 18:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uehpe-0008QQ-6M
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 18:21:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uehpb-0003ST-Ly
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 18:21:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3E1A219F3;
 Wed, 23 Jul 2025 22:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753309256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7Q2cK7oQ45kcos80OvlJtsq8OxV7bl1HvbJKk9uba4=;
 b=oPb4g66/+4Tzw9Avo1p0G4p3crtcJkyQvV1MX81wup/5ZYzzELIRgwRurFmEzr1eouQfna
 oRP0qe6x1igXgA4am2UutDnxy9wYtKOrIybvZNIf/DJWMseqyAoyznjPbtABNcfuc0NB2b
 1bJUGZ5NVClJyLAwP48z2ChIpukJbIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753309256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7Q2cK7oQ45kcos80OvlJtsq8OxV7bl1HvbJKk9uba4=;
 b=8k+w9hH+YTcvVy/1vzPN+Hd4yPMzSo5HQql1VLgU42VR6Ini3SlolDR979Y6lZ1162j5Vm
 wLZuQCFjWF1PjLDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="oPb4g66/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8k+w9hH+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753309256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7Q2cK7oQ45kcos80OvlJtsq8OxV7bl1HvbJKk9uba4=;
 b=oPb4g66/+4Tzw9Avo1p0G4p3crtcJkyQvV1MX81wup/5ZYzzELIRgwRurFmEzr1eouQfna
 oRP0qe6x1igXgA4am2UutDnxy9wYtKOrIybvZNIf/DJWMseqyAoyznjPbtABNcfuc0NB2b
 1bJUGZ5NVClJyLAwP48z2ChIpukJbIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753309256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7Q2cK7oQ45kcos80OvlJtsq8OxV7bl1HvbJKk9uba4=;
 b=8k+w9hH+YTcvVy/1vzPN+Hd4yPMzSo5HQql1VLgU42VR6Ini3SlolDR979Y6lZ1162j5Vm
 wLZuQCFjWF1PjLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBBE13ABE;
 Wed, 23 Jul 2025 22:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XLAYEUdggWjILQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Jul 2025 22:20:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 02/20] target/arm: Correct encoding of Debug
 Communications Channel registers
In-Reply-To: <20250721132718.2835729-3-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
 <20250721132718.2835729-3-peter.maydell@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-arm
 <qemu-arm@nongnu.org>
Date: Wed, 23 Jul 2025 19:20:52 -0300
Message-ID: <87ms8uh7ln.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: F3E1A219F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> We don't implement the Debug Communications Channel (DCC), but
> we do attempt to provide dummy versions of its system registers
> so that software that tries to access them doesn't fall over.
>
> However, we got the tx/rx register definitions wrong. These
> should be:
>
> AArch32:
>   DBGDTRTX   p14 0 c0 c5 0  (on writes)
>   DBGDTRRX   p14 0 c0 c5 0  (on reads)
>
> AArch64:
>   DBGDTRTX_EL0  2 3 0 5 0 (on writes)
>   DBGDTRRX_EL0  2 3 0 5 0 (on reads)
>   DBGDTR_EL0    2 3 0 4 0 (reads and writes)
>
> where DBGDTRTX and DBGDTRRX are effectively different names for the
> same 32-bit register, which has tx behaviour on writes and rx
> behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
> register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
> registers.
>
> Currently we have just one cpreg struct, which:
>  * calls itself DBGDTR_EL0
>  * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
>  * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
>    value for AArch32
>  * is implemented as RAZ/WI
>
> Correct the encoding so:
>  * we name the DBGDTRTX/DBGDTRRX register correctly
>  * we split it into AA64 and AA32 versions so we can get the
>    AA32 encoding right
>  * we implement DBGDTR_EL0 at its correct encoding
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20250708141049.778361-1-peter.maydell@linaro.org
> ---
>  target/arm/debug_helper.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 69fb1d0d9ff..aee06d4d426 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -988,11 +988,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>        .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tdcc,
>        .type = ARM_CP_CONST, .resetvalue = 0 },
> -    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
> -    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
> +    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
> +    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
>        .access = PL0_RW, .accessfn = access_tdcc,
>        .type = ARM_CP_CONST, .resetvalue = 0 },
> +    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
> +      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
> +      .access = PL0_RW, .accessfn = access_tdcc,
> +      .type = ARM_CP_CONST, .resetvalue = 0 },
> +    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
> +    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
> +      .access = PL0_RW, .accessfn = access_tdcc,
> +      .type = ARM_CP_CONST, .resetvalue = 0 },
>      /*
>       * OSECCR_EL1 provides a mechanism for an operating system
>       * to access the contents of EDECCR. EDECCR is not implemented though,

Hi, this patch breaks migration. I'm leaving for the day and will take a
closer look in the morning. But since we have timezones, here it is:

$ cd build

$ sed -i 's/-cpu max/-cpu neoverse-n1/' ../tests/qtest/migration/framework.c
(sorry about this^, I just now got around to looking into it)

$ make

# v10.0.0 -> v10.1.0-rc0
$ QTEST_QEMU_BINARY=./build-10.0.0/qemu-system-aarch64 \
QTEST_QEMU_BINARY_DST=./qemu-system-aarch64 \
./tests/qtest/migration-test -p /aarch64/migration/precopy/file
...

# starting QEMU: exec build-10.0.0/qemu-system-aarch64 -qtest
  unix:/tmp/qtest-4328.sock -qtest-log /dev/null -chardev
  socket,path=/tmp/qtest-4328.qmp,id=char0 -mon
  chardev=char0,mode=control -display none -audio none -accel kvm -accel
  tcg -machine virt-10.0,gic-version=3 -name source,debug-threads=on -m
  150M -serial file:/tmp/migration-test-GXLFA3/src_serial -cpu
  neoverse-n1 -kernel /tmp/migration-test-GXLFA3/bootsect -accel qtest

# starting QEMU: exec ./qemu-system-aarch64 -qtest
  unix:/tmp/qtest-4328.sock -qtest-log /dev/null -chardev
  socket,path=/tmp/qtest-4328.qmp,id=char0 -mon
  chardev=char0,mode=control -display none -audio none -accel kvm -accel
  tcg -machine virt-10.0,gic-version=3 -name target,debug-threads=on -m
  150M -serial file:/tmp/migration-test-GXLFA3/dest_serial -incoming
  defer -cpu neoverse-n1 -kernel /tmp/migration-test-GXLFA3/bootsect
  -accel qtest

qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
qemu-system-aarch64: load of migration failed: Operation not permitted
Broken pipe
../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)

