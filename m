Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E27DCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpPy-00009y-3t; Wed, 04 Sep 2024 08:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpPl-0007j5-PF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:47:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpPk-0006Q1-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:47:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA39D219AE;
 Wed,  4 Sep 2024 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725454030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3FCTzzNrNuH+VyQQHDECt+smwsVLNbG44gGZmSnKYI=;
 b=t9z6+OWvAFOiQg6iYp+vAjdwoava7vv9Ol+KCFc+NRpxsA1z5bPlssIqVOXTDIO6MRgXDD
 hETrUrvY+C/tvVAj0AWwjO+LwW0O36bvaMmNkHUz9JiLtw6wTkuNjkr4ikEiQNTK8s8CHB
 fSjP4uByQn02RU3oobEWQ4cMZ0Nc5s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725454030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3FCTzzNrNuH+VyQQHDECt+smwsVLNbG44gGZmSnKYI=;
 b=NTTNsV+yrXtJ4R1Jed9YK20dBKDFNuiJwlVWShyb9KcDAZWohTeU9WtQkHdDAdaCpPBjKg
 012oBrY+e2FVvbBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ihiUEwZl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IhLsqCHX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725454029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3FCTzzNrNuH+VyQQHDECt+smwsVLNbG44gGZmSnKYI=;
 b=ihiUEwZlt9fIJaveTNWXO0Op80CC+5l8GLEcSugJ5fmTAM+8vc/GiPXtK+Gf9DSTWp7dPj
 rnoxVHDp4GnncJ4EQ+fyEM5aF3FSYPzsan9DYxnpSSxE2V5EHuOx5fIlDzV9J4h3R2ZyQA
 T0+l8i26/7SsLEhNRxLvTsqfwhGpNjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725454029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3FCTzzNrNuH+VyQQHDECt+smwsVLNbG44gGZmSnKYI=;
 b=IhLsqCHXn0KxpuVnRIIvqf/jf0NfKL4ZkpKYjaMJhX//EadEp8rBN+64CwQlKDmSPW1Ht+
 vZqGXP00IoU1eyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35536139E2;
 Wed,  4 Sep 2024 12:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PM4xO8xW2GZlVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:47:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jpoimboe@kernel.org, Babu Moger
 <babu.moger@amd.com>, Dario Faggioli <dfaggioli@suse.com>, Fabian Vogt
 <fvogt@suse.de>, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH] target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to
 the guest
In-Reply-To: <20240805202041.5936-1-farosas@suse.de>
References: <20240805202041.5936-1-farosas@suse.de>
Date: Wed, 04 Sep 2024 09:47:06 -0300
Message-ID: <8734mfmvqt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: AA39D219AE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> According to AMD's Speculative Return Stack Overflow whitepaper (link
> below), the hypervisor should synthesize the value of IBPB_BRTYPE and
> SBPB CPUID bits to the guest.
>
> Support for this is already present in the kernel with commit
> e47d86083c66 ("KVM: x86: Add SBPB support") and commit 6f0f23ef76be
> ("KVM: x86: Add IBPB_BRTYPE support").
>
> Add support in QEMU to expose the bits to the guest OS.
>
> host:
>   # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
>   Mitigation: Safe RET
>
> before (guest):
>   $ cpuid -l 0x80000021 -1 -r
>   0x80000021 0x00: eax=0x00000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>                             ^
>   $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
>   Vulnerable: Safe RET, no microcode
>
> after (guest):
>   $ cpuid -l 0x80000021 -1 -r
>   0x80000021 0x00: eax=0x18000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>                             ^
>   $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
>   Mitigation: Safe RET
>
> Reported-by: Fabian Vogt <fvogt@suse.de>
> Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> More info on this thread:
> https://lore.kernel.org/r/68f8b8b1ca1bf58b059f52afbd1c9c51108a074a.camel@suse.com
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..d33401c922 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1221,8 +1221,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, "sbpb",
> +            "ibpb-brtype", NULL, NULL, NULL,
>          },
>          .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
>          .tcg_features = 0,

Ping, any thoughts on this one?

