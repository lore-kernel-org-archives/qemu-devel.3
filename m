Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DB7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKn8-0005uN-Aa; Tue, 23 Apr 2024 14:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKn1-0005s9-St
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:22:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rzKn0-0004GJ-50
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:22:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8F5D60409;
 Tue, 23 Apr 2024 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713896564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtTCY/4lZOi2KGTzGtjXyHJj93NPhjDWnu60RWOUlQY=;
 b=coo8UrJzp41HZwf+DnUoAWGyKGWYAJOz8qhfrubGgro0UghIrl3qzN8bzIqZVYpjBAXmpz
 f62eVVY3SdWAfZHeFEAn1eFBxR0kPoWpKCnkIiYGW8C1AsIhuyRg9U+XPau31/ex8PIuCl
 rGIqqvrX9pkoE1AHZPlOxetnASFW994=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713896564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtTCY/4lZOi2KGTzGtjXyHJj93NPhjDWnu60RWOUlQY=;
 b=wg4nr8gyOsP4Rai8Uhcx/1SZWb0DkxgsIxw7wxzBQ2/Jw0afH/CUiVd07m7rP7VzOtcnWI
 PAq3WTb9J8r0NyAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kvAHCHFp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="RlWoZ/GU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713896562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtTCY/4lZOi2KGTzGtjXyHJj93NPhjDWnu60RWOUlQY=;
 b=kvAHCHFpyj6aIvrb8SznCYE+t9Jr1tLkDdeAqShfxtauM0/Ia8EChP5r5uIaBHl355XUFy
 ciDEFblLtRDs7/YBOdJhnp5LUeBz5cywYog9AEAfkuX0HmQkBVdcYDSGmMJMGiwbVmZjwa
 U9jVPsW+YuTj+Oe9WqKE3t5S033E0TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713896562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtTCY/4lZOi2KGTzGtjXyHJj93NPhjDWnu60RWOUlQY=;
 b=RlWoZ/GUExI+znKBinovMlL+M8Y7NTTrWFC95G4Ke/uNV48uOOsTMkedf9zX+JRS4g827e
 zRuOsU9fNCk8vMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72CB2139A1;
 Tue, 23 Apr 2024 18:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b3yqDXL8J2adQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Apr 2024 18:22:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/22] arm: switch boards to "default y"
In-Reply-To: <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-4-pbonzini@redhat.com> <87mspkhs8d.fsf@suse.de>
 <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
Date: Tue, 23 Apr 2024 15:22:39 -0300
Message-ID: <87jzkohrbk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E8F5D60409
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Fabiano,
>
> On 23/4/24 20:02, Fabiano Rosas wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> For ARM targets, boards that require TCG are already using "default y".
>>> Switch ARM_VIRT to the same selection mechanism.
>>>
>>> No changes to generated config-devices.mak file.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   configs/devices/arm-softmmu/default.mak | 3 ++-
>>>   hw/arm/Kconfig                          | 2 ++
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/=
arm-softmmu/default.mak
>>> index c1cfb3bcf75..31f77c20269 100644
>>> --- a/configs/devices/arm-softmmu/default.mak
>>> +++ b/configs/devices/arm-softmmu/default.mak
>>> @@ -5,7 +5,8 @@
>>>   # CONFIG_PCI_DEVICES=3Dn
>>>   # CONFIG_TEST_DEVICES=3Dn
>>>=20=20=20
>>> -CONFIG_ARM_VIRT=3Dy
>>> +# Boards are selected by default, uncomment to keep out of the build.
>>> +# CONFIG_ARM_VIRT=3Dn
>>>=20=20=20
>>>   # These are selected by default when TCG is enabled, uncomment them to
>>>   # keep out of the build.
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 893a7bff66b..1e7cd01087f 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -1,5 +1,7 @@
>>>   config ARM_VIRT
>>>       bool
>>> +    default y
>>> +    depends on ARM
>>>       imply PCI_DEVICES
>>=20
>> We lose pci.c when building --without-default-devices:
>>=20
>> $ arch
>> aarch64
>> $ ../configure --target-list=3Daarch64-softmmu,arm-softmmu
>> --disable-linux-user --without-default-devices
>> $ make
>> ...
>> libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function `kvm_arch_f=
ixup_msi_route':
>> ../target/arm/kvm.c:1548: undefined reference to `pci_device_iommu_addre=
ss_space'
>
> IIRC QEMU isn't yet ready to be built with --without-default-devices
> but without any machine, you need to explicit at least one. For
> example you can use --with-devices-aarch64=3Dminimal, or define a
> config with only the Virt machine.

Could we detect this kind of breakage somehow and report it properly to
the user? As in "you chose an impossible configuration, select a board
and try again".

I see this comes from kvm.c, perhaps on arm CONFIG_KVM needs to depend
on VIRT?

>
> Regards,
>
> Phil.

