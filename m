Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41419CFA45F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hK6-0008Su-HE; Wed, 23 Oct 2024 15:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hK1-0008SN-Mg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:47:10 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hJz-0002SD-Ex
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:47:08 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso11203266b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729712826; x=1730317626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjeWek960NcUIgiohtPXB+Vg0rJ92eP6xQNpgT2ubOU=;
 b=zU99zd3tiJg6haeDQlVXtBgDIkV5hMk8VELHFdyHsh3FA6tIjQ60pQam/VXPRaHovl
 d+mP6oeZQhWiw9gnm/7d8Gmn+yQaI3lVr6tonLcsDbAqvtwSmUEuRBi6cn4N4cAaikMY
 x+PZTorh0s0b9xuVUu3WAJidn9z1qkUPnxbzbahx/x0BLFDPIEmIkNFI9szpUshccCaZ
 S5TqO9jqRt616JkR9jCuPV3iEke5ZImwOyVftpJIG8I02cHCOtdDOCJlkXzLXVQxZ0Dd
 hAi0/0uGClGgHMZJ++k8UwpgY9eMfzpJxmn+CNTSPMDC0cIU365YdvI2ifJ+fIubVGP5
 n07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729712826; x=1730317626;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjeWek960NcUIgiohtPXB+Vg0rJ92eP6xQNpgT2ubOU=;
 b=rnrLVmdQLcSqKVgT/tMvWOCCNct+K3Lb4k5RTP39qYWsLdZXNJnnruCl2FLhQfOWIF
 VKwMR25TtNXdWtoVeIxFDstB7DFZrF9BwPDqUQMNGZq3VEkqt1dBSSH0BNtwI3F1h7aU
 NTuDnJ3gWAsNvArkSRnFTVyXzLIlBT5Fani2yvwNNbxJzG41Bysneb75i5PkaydEXBx0
 8LYtTxwqNekITKGp/nv5v0QGuc0ZpWkQgwzrKKIHFLXkf9FtMdG30bWh+clyq3PBV/8L
 yR8YKXccm82SQe49qeNAcVbWBOW9VcHUg5y5juij+ztd9zsizkfRVEnxsLPNF37+7y7Q
 SPaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXWUsEKp5nwfihkjhO9cx+lA5InD8Ixq+OYOkBjX1emjBw5PkGdribbsqq2ixYZjKZku31LcnjzlqD@nongnu.org
X-Gm-Message-State: AOJu0YwCoFI6evhZhgXncJWP5eq7AEcB31lK6R1ZFRDn0ez7kAGPS4kz
 vtZYrZ77zpiE9BeoPwB4g710XktnUrrM5MZu8ZIH1ApSlA+J0LBcp6/5/YOEuY0=
X-Google-Smtp-Source: AGHT+IEIA9rIJ04+Qcp3TzNgVJAqmBz3KuIj/pMJ7zakUwT1dcG/rm3pZHFabLhpGBrqDgGq03uVBQ==
X-Received: by 2002:a17:907:980c:b0:a99:a9b6:2eb6 with SMTP id
 a640c23a62f3a-a9abf53587cmr351767466b.0.1729712825573; 
 Wed, 23 Oct 2024 12:47:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d62efsm513496766b.44.2024.10.23.12.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 12:47:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 082235F897;
 Wed, 23 Oct 2024 20:47:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,  "open list"
 <linux-kernel@vger.kernel.org>,  "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>,  lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 qemu-devel@nongnu.org,  "Mark Brown" <broonie@kernel.org>,  "Catalin
 Marinas" <catalin.marinas@arm.com>,  "Aishwarya TCV"
 <Aishwarya.TCV@arm.com>,  "Peter Maydell" <peter.maydell@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,  "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>,  "Thomas Gleixner" <tglx@linutronix.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
In-Reply-To: <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com> (Arnd
 Bergmann's message of "Wed, 23 Oct 2024 16:24:43 +0000")
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
 <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 20:47:03 +0100
Message-ID: <87bjzalhzc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Sun, Oct 20, 2024, at 17:39, Naresh Kamboju wrote:
>> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>>>
>>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>>> The boot log is incomplete, and no kernel crash was detected.
>>> However, the system did not proceed far enough to reach the login promp=
t.
>>>
>
>> Anders bisected this boot regressions and found,
>> # first bad commit:
>>   [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>>     vdso: Introduce vdso/page.h
>>
>> We are investigating the reason for boot failure due to this commit.
>
> Anders and I did the analysis on this, the problem turned out
> to be the early_init_dt_add_memory_arch() function in
> drivers/of/fdt.c, which does bitwise operations on PAGE_MASK
> with a 'u64' instead of phys_addr_t:
>
> void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> {
>         const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
>=20=20
>         if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
>                 pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
>                         base, base + size);
>                 return;
>         }
>
>         if (!PAGE_ALIGNED(base)) {
>                 size -=3D PAGE_SIZE - (base & ~PAGE_MASK);
>                 base =3D PAGE_ALIGN(base);
>         }
>
> On non-LPAE arm32, this broke the existing behavior for
> large 32-bit memory sizes. The obvious fix is to change
> back the PAGE_MASK definition for 32-bit arm to a signed
> number.

Agreed. However I think we were masking a calling issue that:

    /* Actual RAM size depends on initial RAM and device memory settings */
    [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },

And:

  -m 4G

make no sense with no ARM_LPAE (which the kernel didn't have) but if you
pass -machine virt,gic-version=3D3,highmem=3Doff (the default changed awhile
back) you will get a warning:

  qemu-system-arm: Addressing limited to 32 bits, but memory exceeds it by =
1073741824 bytes

but I guess that didn't trigger for some reason before this patch?

> mips32, ppc32 and hexagon had the same definition as
> well, so I think we should change at least those in order
> to restore the previous behavior in case they are affected
> by the same bug (or a different one).
>
> x86-32 and arc git flipped the other way by the patch,
> from unsigned to signed, when CONFIG_ARC_HAS_PAE40
> or CONFIG_X86_PAE are set. I think we should keep
> the 'signed' behavior as this was a bugfix by itself,
> but we may want to change arc and x86-32 with short
> phys_addr_t the same way for consistency.
>
> On csky, m68k, microblaze, nios2, openrisc, parisc32,
> riscv32, sh, sparc32, um and xtensa, we've always used
> the 'unsigned' PAGE_MASK, and there is no 64-bit
> phys_addr_t, so I would lean towards staying with
> 'unsigned' in order to not introduce a regression.
> Alternatively we could choose to go with the 'signed'
> version on all 32-bit architectures unconditionally
> for consistency. Any preferences?
>
>       Arnd

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

