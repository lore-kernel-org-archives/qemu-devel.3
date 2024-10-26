Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C433FD0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4l0k-0002hM-Kd; Sat, 26 Oct 2024 13:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4l0e-0002bb-4x
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:55:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4l0c-00042T-1k
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:55:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c805a0753so29558445ad.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965328; x=1730570128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8iaYxHeBs9DQ6rjsGSBSfC3gqL47ENyDEW+pnN7ImEQ=;
 b=XOfQMvvmnazFCbAr2TkpOxIuU2LOCEdTsPVMliPR6uf4oC0pPNjeyuI3COCG3IcdIU
 gVeTaI5UA+W2YK9yKBTuUNRhBu9jSbPsFysmyreBPR8XYhBPVebUFPatPCnghyat7eNe
 uWOjQMGSuGrQo7APuHVGLL6X5bbcXs894hPR8UPlNgQLnASRj+ibIFGTwq23fqsl64/X
 oLT8Wgm3HCMAZG+dKpO6WQrZw7a/K9uKvTsm2gaE6LCSraVtWE0e0c0lha/kbUt1kisw
 m1UqQlO9PyA9GxBGpETtK+pkaS7KQW9WPCRGjgJRzyxkz4N2ckgym2GLxZ5lgqM/LvUE
 Vh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965328; x=1730570128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8iaYxHeBs9DQ6rjsGSBSfC3gqL47ENyDEW+pnN7ImEQ=;
 b=pka9xQxaIh8aqIFN+LvH1B+Gui5BJT+wb+oNY8O435zKZoCw7YO8OKeVTe98ovteKy
 UuP26kojfzrYYpD5MMemx8hsqhLpoyD7/y/UukjfO8A1qWtrQhIdOowo1+I9KJvSn+vm
 SSYnqTvkqxBXPNXybZAEOcCUyd31CZx+qxsxSJGg0QC2Rngll6FfJ+PqtH5NmDiOVqHz
 pfmoSkEwEknlQDaCQzZK5SscQyH2pZ/zDGZhgUR8Vb58lqfCP5pLZfBp5/znnrPPdHY/
 5RMFG9F7dMm519Cy7CHhSfIDAx0AiozUr75Hf1QSreMzmfZPd9JdQd5yv1sSAFug/f3D
 HiEQ==
X-Gm-Message-State: AOJu0YwFHyT/dvUY/JPTihGf4+xsEEGQR4tzuduIQg36YiR+Me4mTFk6
 UscpSR0Z0gc+lMRMzw1KFVIpGCKi6zlXedTpcLmNUMfLkDfmeDqZXOTz9QS/0aHYiHOak9ZY+3m
 C
X-Google-Smtp-Source: AGHT+IEVOzGoWpFZ2VCoyFGoIYslHdGiJIyw75kH9Oifg1SnXhUfAxITp+tZbw1JYO7Ll/1jt9sHTA==
X-Received: by 2002:a17:902:d543:b0:20c:7661:dcbf with SMTP id
 d9443c01a7336-210c6c95170mr35353335ad.55.1729965327699; 
 Sat, 26 Oct 2024 10:55:27 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8679ce9sm3011095a12.29.2024.10.26.10.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2024 10:55:27 -0700 (PDT)
Message-ID: <1327c220-e7e0-436f-a04e-840be8a04845@linaro.org>
Date: Sat, 26 Oct 2024 14:55:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] target/mips: Convert Loongson LEXT opcodes to
 decodetree
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20241026175349.84523-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/10/24 14:53, Philippe Mathieu-Daudé wrote:

>   target/mips/tcg/translate.h       |   3 +
>   target/mips/tcg/godson2.decode    |  27 +++
>   target/mips/tcg/loong-ext.decode  |  28 +++
>   target/mips/tcg/loong_translate.c | 271 ++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.c       | 271 ++----------------------------

Amusing diff-stat =)

>   target/mips/tcg/meson.build       |   3 +
>   6 files changed, 348 insertions(+), 255 deletions(-)


