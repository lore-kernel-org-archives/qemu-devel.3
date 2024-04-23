Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85858C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKU4-0000Dn-OH; Tue, 23 Apr 2024 14:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKTx-0000DX-8B
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:03:06 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKTv-0000kY-Kt
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:03:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C367603CD;
 Tue, 23 Apr 2024 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713895381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL9L6FTXgY/Iqmvs7QAAGt2oss0Nce4qBDNnzUpgF1M=;
 b=q/C4NRG6Hj7Xg7Nhxs30Hqrj301C99/MW1CZlRv2CXcbxCacqa/w3/vNOD3hJyJf7ZFMKH
 FUGKtYkn3+Psnxs/UyxC1hTHDt1xHVR7OpYQeQIcLmEWub5wa4iDn1PYV60NUv/kSdu/nA
 wknOfH2ANjaMkPET3Ga5mO0l8XSHMOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713895381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL9L6FTXgY/Iqmvs7QAAGt2oss0Nce4qBDNnzUpgF1M=;
 b=ji44SblikYyB6ryja1zkonJr5IgrsEqQQmRF8MnRD+WvHF7zyBpOlC5yXptaX4BwvE/XKf
 m8pqZY2H/sNuYXAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713895381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL9L6FTXgY/Iqmvs7QAAGt2oss0Nce4qBDNnzUpgF1M=;
 b=q/C4NRG6Hj7Xg7Nhxs30Hqrj301C99/MW1CZlRv2CXcbxCacqa/w3/vNOD3hJyJf7ZFMKH
 FUGKtYkn3+Psnxs/UyxC1hTHDt1xHVR7OpYQeQIcLmEWub5wa4iDn1PYV60NUv/kSdu/nA
 wknOfH2ANjaMkPET3Ga5mO0l8XSHMOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713895381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL9L6FTXgY/Iqmvs7QAAGt2oss0Nce4qBDNnzUpgF1M=;
 b=ji44SblikYyB6ryja1zkonJr5IgrsEqQQmRF8MnRD+WvHF7zyBpOlC5yXptaX4BwvE/XKf
 m8pqZY2H/sNuYXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129B313929;
 Tue, 23 Apr 2024 18:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3+6mMtT3J2Z0PAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Apr 2024 18:03:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: Re: [PATCH 03/22] arm: switch boards to "default y"
In-Reply-To: <20240423131612.28362-4-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-4-pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 15:02:58 -0300
Message-ID: <87mspkhs8d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> For ARM targets, boards that require TCG are already using "default y".
> Switch ARM_VIRT to the same selection mechanism.
>
> No changes to generated config-devices.mak file.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configs/devices/arm-softmmu/default.mak | 3 ++-
>  hw/arm/Kconfig                          | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
> index c1cfb3bcf75..31f77c20269 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -5,7 +5,8 @@
>  # CONFIG_PCI_DEVICES=n
>  # CONFIG_TEST_DEVICES=n
>  
> -CONFIG_ARM_VIRT=y
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_ARM_VIRT=n
>  
>  # These are selected by default when TCG is enabled, uncomment them to
>  # keep out of the build.
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 893a7bff66b..1e7cd01087f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,5 +1,7 @@
>  config ARM_VIRT
>      bool
> +    default y
> +    depends on ARM
>      imply PCI_DEVICES

We lose pci.c when building --without-default-devices:

$ arch
aarch64
$ ../configure --target-list=aarch64-softmmu,arm-softmmu
--disable-linux-user --without-default-devices
$ make
...
libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function `kvm_arch_fixup_msi_route':
../target/arm/kvm.c:1548: undefined reference to `pci_device_iommu_address_space'

>      imply TEST_DEVICES
>      imply VFIO_AMD_XGBE

