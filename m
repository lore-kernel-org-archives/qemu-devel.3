Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF7FD7833F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPgx-0007CO-3B; Tue, 03 Dec 2024 04:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPgu-0007Br-RS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:59:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPgm-0006t2-NX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:59:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a2033562so43323335e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733219967; x=1733824767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jn71q+BYmRY3Un6hrVzIXXO71Ml4MawXlVXT1Vh5wTI=;
 b=u9W988u6QaZxwYYX05nB0h0RRm/SnIBD4QE+WMGRiknoSFO3oIDv1YFeBZDiC9xVGW
 vVWeMxpTuw2S1EvIBIJkLfa6ufkIC74taASOLtXUzPasnLVMF78uNGS8+Z6NpHxXpeOl
 TQ1SqqyReGmGIGOwezoFhAEeQKhastk9Niuwz1T8U68nFxWJ/d55YXtBWTroK4NYEggf
 bWf9vFTbCoHYPw2o0RbxsThXGS//oRr2n0u5JK9p+vHvmytmGY4rFHegHNSG/t5uzYzi
 N6aIlhY2cuNMyFsKu24smWKjSKNPq+dipxaP/n15BogCwwzMIhXMpo5g32uwaXp7qGh0
 eyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733219967; x=1733824767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jn71q+BYmRY3Un6hrVzIXXO71Ml4MawXlVXT1Vh5wTI=;
 b=MJUFS7splgmLkMR2IkpE6LvVbq7U0DEEUlbNFMM6y4h/jwPmEC/qzddCpXEgSVwTsF
 DLh51g9uHL4r3V0n6zASwYAuolu5qACR5kmrqdeaJbWXL03URCZQAZU0fXB6aKURhjF9
 y1YPXSAKlztr7nTYCeQykCpCZ/NmfZqG9GzuCSP0QD65z+BjBA4Vmc4o6AnVhksiO0UA
 yPV0DVYfTf/jPLMIig87iNtbmcNcZwvfUoyUll1WwHE6XO0nydVWEpZ4ZeInCD+8FoJq
 wiuHRRQ/tnjGTO+/YHbXFh91hykgrMWnHl3wfpsWj8Fmy1YlYCsgY2xaN2GAQStrA+J5
 /IZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1NOTJ0Qa1fpSg5MeZPV/dT4mkREmScsWOy/SnoV6yQ3uTl34JTUHi18yizuXY9R3KWw/QxMym1n+@nongnu.org
X-Gm-Message-State: AOJu0YyhvABqOapgImPT8JYhKxT+c2FO+oxIzcpMvC8wysQ3znJ9oPlO
 8z8hngUp+SiZo2T4riYm1lguyV6uzLUL9kxHmV3ctIx7QdPgzhsiTi8oz7Rv+wQ=
X-Gm-Gg: ASbGnctcAdIyIaL1yKcYxbDlIF69wLxtZoo6VQkrqbdF/Kj+k6RkzQLYaFRQ2zSkNkR
 KcdUtsjfdf3JlGluVKDUwhi8eENT2RlXAnDFbN0mZtGcuUEpkqan6yvq1ZtItD41f4SwfiH1pN9
 qsjZwU/LqjjNFcZUHdye1M7dmUZ4pV1tLF2q7O4O2UN9sV+E2mEudihEI8ylnsABr7O1Tr0ent+
 AFm2O/NF/ZVb8h6nYIqxS2EvOXG8L6sBuuDwj586oiAy2Jv7IsJAXjkP0YttvLLLw==
X-Google-Smtp-Source: AGHT+IGihepYzmjeq6nk4ZmcjGTDlGqlZVonMtA8Ntv9cpeSveskm+Grswfj/AbJFEcgR6GiW44zdw==
X-Received: by 2002:a05:6000:1446:b0:385:f092:e16 with SMTP id
 ffacd0b85a97d-385fd54df09mr1393301f8f.55.1733219966725; 
 Tue, 03 Dec 2024 01:59:26 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e0d4778dsm11412369f8f.45.2024.12.03.01.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 01:59:26 -0800 (PST)
Message-ID: <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
Date: Tue, 3 Dec 2024 10:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,64} part of the same
 family
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Corbin <mark@dibsco.co.uk>
References: <20241203094702.124748-1-abologna@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203094702.124748-1-abologna@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Andrea,

On 3/12/24 10:47, Andrea Bolognani wrote:
> Currently the script won't generate a configuration file that
> sets up qemu-user-riscv32 on riscv64, likely under the
> assumption that 64-bit RISC-V machines can natively run 32-bit

I'm confused by the "machines" description used for user emulation.

> RISC-V code.
> 
> However this functionality, while theoretically possible, in
> practice is missing from most commonly available RISC-V hardware
> and not enabled at the distro level. So qemu-user-riscv32 really
> is the only option to run riscv32 binaries on riscv64.

We have definitions such ELF_ARCH/ELF_PLATFORM/ELF_MACHINE to
parse ELF header and select the best CPU / flags. Maybe RISC-V
lacks them?

BTW we should expose that for linux-user as target_arch_elf.h,
like bsd-user does, that would reduce all these #ifdef'ry in
linux-user/elfload.c...

> 
> Make riscv32 and riscv64 each its own family, so that the
> configuration file we need to make 32-on-64 userspace emulation
> work gets generated.

Does this patch aim for 9.2? Otherwise FYI  I'm working on unifying
32/64-bit targets, maybe for 10.0...

> 
> Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> Thanks: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   scripts/qemu-binfmt-conf.sh | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 6ef9f118d9..e38b767c24 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -110,11 +110,11 @@ hppa_family=hppa
>   
>   riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
>   riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> -riscv32_family=riscv
> +riscv32_family=riscv32
>   
>   riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
>   riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> -riscv64_family=riscv
> +riscv64_family=riscv64
>   
>   xtensa_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x5e\x00'
>   xtensa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> @@ -168,9 +168,6 @@ qemu_get_family() {
>       sparc*)
>           echo "sparc"
>           ;;
> -    riscv*)
> -        echo "riscv"
> -        ;;
>       loongarch*)
>           echo "loongarch"
>           ;;


