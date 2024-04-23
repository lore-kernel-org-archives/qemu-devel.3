Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0E4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 19:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzLTs-0007LR-PE; Tue, 23 Apr 2024 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzLTb-0007Ex-El
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:06:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzLTX-0003Rj-0t
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 15:06:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDBEB604C6;
 Tue, 23 Apr 2024 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713899199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBgkjGMrZRHm9Nyw5OgTzOtwNa1NlMLYx0L8WDvhnGo=;
 b=1jVoicd4ai8YoA6CHKugYk6/SlWUJIjfVq86wpO7sq+l6ZBWTfL/TVKdzSJhlrvEJEmE6u
 sc5mbKTxHoROyOevTJ2Rz3/so++ofUeMSttUaEgtf/WXZAOgk2Dz7REl6zAPbcO2En12d+
 9y3ZEWv1ElYpB5b8EVIZp+4tEs9yRpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713899199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBgkjGMrZRHm9Nyw5OgTzOtwNa1NlMLYx0L8WDvhnGo=;
 b=wl4uQfK3rag+edB+WJv8Nnxi8OJltxXZZAxxSGcy4dbM2fKfTgrYYsz1ggIPeUv6YJbEde
 H6VWTZ/wMTbxJyDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cv/MjDX9";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sy50kl8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713899198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBgkjGMrZRHm9Nyw5OgTzOtwNa1NlMLYx0L8WDvhnGo=;
 b=cv/MjDX9rl5qx/ox61uwnj9krxdpmM0iNrym1+ahF+Ywk9WtKhQUT6X52w/nYhqM3RIZBv
 Y6O0dQz5Y1TQxENGiVUd9E10iZ0IOrFSX/k9c5h4etulq5CGnikvY+HdSR8ItQUdhAwrhQ
 qARRcke4rAyS8HNs0xrb25Yqzma2PVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713899198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBgkjGMrZRHm9Nyw5OgTzOtwNa1NlMLYx0L8WDvhnGo=;
 b=Sy50kl8Cau1lFCVWjJK8/XhPHgyB//kL/beXehiD7sVnhYL3LccfpIGqkEkpF4I18366zm
 amPDL5UFEkHnxHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6938413894;
 Tue, 23 Apr 2024 19:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l6djDL4GKGZ2TQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Apr 2024 19:06:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 03/22] arm: switch boards to "default y"
In-Reply-To: <CABgObfZ-dUiBhjyL04vz8UoaZvkKCO-a+O63TxxgBEzOrCgt_Q@mail.gmail.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-4-pbonzini@redhat.com> <87mspkhs8d.fsf@suse.de>
 <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
 <CABgObfZ-dUiBhjyL04vz8UoaZvkKCO-a+O63TxxgBEzOrCgt_Q@mail.gmail.com>
Date: Tue, 23 Apr 2024 16:06:35 -0300
Message-ID: <87h6frj3us.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EDBEB604C6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il mar 23 apr 2024, 20:12 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=
 ha
> scritto:
>
>> Hi Fabiano,
>>
>> On 23/4/24 20:02, Fabiano Rosas wrote:
>> > Paolo Bonzini <pbonzini@redhat.com> writes:
>> >
>> >> For ARM targets, boards that require TCG are already using "default y=
".
>> >> Switch ARM_VIRT to the same selection mechanism.
>> >>
>> >> No changes to generated config-devices.mak file.
>> >>
>> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> >> ---
>> >>   configs/devices/arm-softmmu/default.mak | 3 ++-
>> >>   hw/arm/Kconfig                          | 2 ++
>> >>   2 files changed, 4 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/configs/devices/arm-softmmu/default.mak
>> b/configs/devices/arm-softmmu/default.mak
>> >> index c1cfb3bcf75..31f77c20269 100644
>> >> --- a/configs/devices/arm-softmmu/default.mak
>> >> +++ b/configs/devices/arm-softmmu/default.mak
>> >> @@ -5,7 +5,8 @@
>> >>   # CONFIG_PCI_DEVICES=3Dn
>> >>   # CONFIG_TEST_DEVICES=3Dn
>> >>
>> >> -CONFIG_ARM_VIRT=3Dy
>> >> +# Boards are selected by default, uncomment to keep out of the build.
>> >> +# CONFIG_ARM_VIRT=3Dn
>> >>
>> >>   # These are selected by default when TCG is enabled, uncomment them=
 to
>> >>   # keep out of the build.
>> >> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> >> index 893a7bff66b..1e7cd01087f 100644
>> >> --- a/hw/arm/Kconfig
>> >> +++ b/hw/arm/Kconfig
>> >> @@ -1,5 +1,7 @@
>> >>   config ARM_VIRT
>> >>       bool
>> >> +    default y
>> >> +    depends on ARM
>> >>       imply PCI_DEVICES
>> >
>> > We lose pci.c when building --without-default-devices:
>> >
>> > $ arch
>> > aarch64
>> > $ ../configure --target-list=3Daarch64-softmmu,arm-softmmu
>> > --disable-linux-user --without-default-devices
>> > $ make
>> > ...
>> > libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function
>> `kvm_arch_fixup_msi_route':
>> > ../target/arm/kvm.c:1548: undefined reference to
>> `pci_device_iommu_address_space'
>>
>
> I guess we can add something like
>
> config AARCH64
>     select PCI if KVM

Yep, that fixes the build. With defaults disabled the tests are all
kinds of broken, but I guess that's expected. I see issues even in
master.

With the above included:

Tested-by: Fabiano Rosas <farosas@suse.de> # build-only on aarch64

