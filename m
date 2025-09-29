Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2936CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 07:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38fy-0000nh-MZ; Mon, 29 Sep 2025 03:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v38fs-0000mx-Ba
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:51:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v38fd-0008Nz-MY
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:51:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so15460225e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759132290; x=1759737090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byL6+IWWE+maBPLd/ApthsbRatCtLzLcVRyQGwiLiGM=;
 b=fPCPuSZZlXBfdumGXqYMCoLWOxIQM24gMTPg8RTCuOh4/uYkVfW5g6KPe4/lm6jb/A
 Q1WGn7PBkEzBCdsmOnusmN+XVqAOHk32YrrpmITOnKgMuaq1CSco/Wdwjy+m7uUnbcgj
 7a0y/KNyZs5kSVk/RLV2qIp250CZDXHSJ22zmDNcFyoQuJ+cPyKmaAU6kXNM6uuy+rb3
 SvoX2iya/0TPlGUrsymtcgzpmpMdfQtu74Tf2CunSXCZCiXm9BRuJk/brsif2giXM5PB
 2RV6lhnKoJwt8uvS8LjAANtdkiIEbDhu1KX3GG7eqR9ghOm+ApuFixT4K5MFjjF9Pw5k
 zSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759132290; x=1759737090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byL6+IWWE+maBPLd/ApthsbRatCtLzLcVRyQGwiLiGM=;
 b=K/3bjBcDDuxZ4+cOVCuSdoA43lHFt24ZXS+NIcyi8G/DCzwE11peP5p0RZPzdwCzQK
 l3UnYSedeD9QOb0208fF/LXIIMfpzqodOR4sd823jjNgDNoXGFsoOdzLZPoyYzhZUTtW
 ZZQudzg/Wq7nJLmqPvcJP2ennnTfXtFUP2Tbd33UMsiPFc7qBVhZTYN1A2V7RX2eqmO2
 MHTZ/ypCgR88hOtF0K9Z7P27e62qHSccyFJtIB36UY4OK8bZch7C8U2bbdVJ83PjGEo3
 kBwVLymgng15KN/UQTdB7qYvwYpFdIGWT+w/6yg4kGEzySR7khQlpwopV7jnY5HwPEic
 R58Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7wkVmnG2Yq7gfbvShKNnVSD92QRZ0rKNC22Myw+j7gN1s+eRXmN4EpilyyR61TcfFuoc/0hVbJa+@nongnu.org
X-Gm-Message-State: AOJu0Yz7ohZpghWUKAyQOUWW39eHs3n95UyrhXdQn8sjzCEDCu7x0Trr
 yJyuQiyQT4xQFycqtYrzIOxD6jhC3xdEcSP1wlIlwakY27rT3dmC0osAqgfO2DuMU54=
X-Gm-Gg: ASbGncs+TS7M/fmcAFoH1d1zR2ot0oIECq6nsAuUShuhqLQHVGwoBatlF0dPq4UV1gv
 3+ztsQyXwKL+uqY+e/3FJSc1S53tIma0N0TZVjGfNNYuGdwtIUAv9ptZVghUNoTAqLm36MtrroH
 GtY6NKe+UaxZxMfMUuy/9XilCVXeiPpoXmADvaGSkxrdEEl8lQq2M476VrCTKo7rGlcPHC4jhnq
 D0d5RARMFifsf605vbVp7giUPW2XOoGAoFzmmyLVhm5XiJssThtLb+UEGc9rstopPg5ZnBS1yYC
 6zrg+SzRokstN5t5U+/vb6zjy62AKmx+Ayz78t9+KDsH4bI56eBbwWuk6j7A2+2uV68eJdLM9Ou
 6hb/eT6Lkim9zQst1g0dtHw0uidD84B41inZKgLgSnO0ivsps3Ddf+C4IxMqOgJgS6DatQn001t
 57
X-Google-Smtp-Source: AGHT+IGUp8TPfS1jLLsIH4WzUrM41eCu4M7L+HGWPJnJfrQ8HVAJRXDZrBXpxvybUsTigQb+QPssxA==
X-Received: by 2002:a05:6000:2601:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-40e4886e045mr14343864f8f.36.1759132289750; 
 Mon, 29 Sep 2025 00:51:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2ff6sm16989762f8f.56.2025.09.29.00.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 00:51:29 -0700 (PDT)
Message-ID: <8099d09f-029d-4562-b035-7b832ac27ccc@linaro.org>
Date: Mon, 29 Sep 2025 09:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Have gen_pause() actually pause vCPUs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-3-philmd@linaro.org>
 <4b0138bc76c60385de71c26eb55a4aecd8d1786d.camel@kernel.crashing.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4b0138bc76c60385de71c26eb55a4aecd8d1786d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29/9/25 06:28, Benjamin Herrenschmidt wrote:
> On Wed, 2025-09-24 at 19:30 +0200, Philippe Mathieu-Daudé wrote:
>> gen_pause() sets CPUState::halted = 0, effectively unhalting
>> (a.k.a. "running") the cpu. Correct by setting the '1' value
>> to really halt the cpu.
> 
> What will resume it though ? The smt_low() case isn't meant to *halt*
> the CPUs permanently. smt_*() levels are about SMT thread priorities.
> Using a "pause" that just gets out of TCG (and back in), is a way to
> "yield" to another thread, thus enabling more forward progress when a

What you describe can be achieved with a helper doing:

   cs->exception_index = EXCP_YIELD;
   cpu_loop_exit(cs);

Is that what you wanted?

> thread is spinning on an smt_low() loop. This happens in firmware and
> in some spinlock cases.
> 
> This isn't about stopping until some external event resumes it.
> 
> Cheers,
> Ben.
> 


