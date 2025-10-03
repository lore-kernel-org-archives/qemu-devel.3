Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF449CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4mXj-0003GQ-87; Fri, 03 Oct 2025 16:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mXh-0003G8-Kn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:38:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4mXd-0007uP-1R
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 16:38:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so2773789f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759523886; x=1760128686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cX49b3Xv8OFufuY1+9Mg4NE2B0qE1q6Mjtnav6igoBU=;
 b=fk6Edi2Cm4qtBauTw09VzzhUpu947s5xueLTlCyZLAS2mEhsVFCWMD9343GaFw1m/z
 ADgyV1z6gdhNJUnmwSgLcd8jcPOGyMqDyEQk8ydZpomWnTA+Be4rRegOH3oDmGQTX6cK
 OYVkIOZxNHZvxUiJdcPX7CvqLUti7wLjTbwCQgSEZZtwt4QnAU7BPc2OEpAW+FAXFzq1
 nL9SRsA4XTfW+O7s+ADSrdgHvsncUlvio5Zjy6IxUR9bygq0cvmbrHtDc8FfthmFqLQi
 6EFAkd7pFtga0+NFWFTVcn7ghLXo56UjWNzNH0QxxPVE1bL0IStXGyKdR8e3eSLbjEES
 dSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523886; x=1760128686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cX49b3Xv8OFufuY1+9Mg4NE2B0qE1q6Mjtnav6igoBU=;
 b=qLGyLM0TRsl9DXaVR/03y9z0jQ5kkySzwp5vaWl5s/TdyHs7YMRqVqjyUNSBZ7uHQ+
 usJ8haSl7+BuuErpFVODyCyP2ph63gaXCrQQ8WmVFtSdF32GKJqvP8CKLa/aRGv2/i6k
 G+W5awHGP5aYDfB4Dc4vZfJPojUxEcaDWQbqG2jvoDajKNuwRihTkyCPIrGZIj4cOpHZ
 /Lj8n6O9mliNlxmQLmvTVxx5fksDtgqg9Vdx/eK/mJATTS/g3ZPoveopSvYKDRJh6Nhl
 xKwzJnmtTD8u1KGHYD1UkPsU3jTuakVZPHu0jsxJetrz73hzlbqrpq5u2PgfdA97KL+B
 7+kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURsEYJiz/myyuaxX4nQfS8Nt3xP3cLvQ4NqQotpKnWi/uP8Q7X/EDNnUGrHJOvxBSYV+BFH4MOOQo4@nongnu.org
X-Gm-Message-State: AOJu0YwhN7CRSw+PwaBvi/uVJgBmjtdPMMsCQwXKeI0ZhgeYMTJqxJED
 3UN637KXZ61eqGpOvQLomDCdzCpaFUByU79vtu0+Q+dVsqoQmOcccuUR2Fiol8CPxHE=
X-Gm-Gg: ASbGncsKfWcARJfMtSxOKJ9gVr1T3KbmXsr09K6GuAK4TnMV7VHb4wJCxM8B0mHVhnp
 a6f2ZU9l0xmroeLLg1UvP+5eWbrdxldpZOgz7YxwCWL3be0EO/LsKmV1a291sFI1bAmyP2iIQO9
 Quq2AlDNrNMGiwFdSX53Em2xELC6ui2cdLDL/kRFKQqK5BXl7R1HPcRPX2ulKWX80+H51bLrgcT
 bSpfcOPLwQZxleO7NA0IibeC9CXNNT4KadA4p+C5vY66XFT2AJjLR+s3ZW/Fcf2WDYth3b47OU8
 uWquZUrCw/rpE7Lv8FdzNFIxZwOsBcFCBbseXMzFPFsaL0Yb/wBFWGqnG1IsQ7NnP9vmXhJ0H1S
 gGZ4xVuIqFheo2Jy46DoaNW/KdaLfaO7fPMhxFrLp8dunKUHABWR/Kx4J9XUk6muT+4Bfe7Kydu
 5JSp88phluysdE5Nzbfw==
X-Google-Smtp-Source: AGHT+IFc329i1S5tLR4OdTw8lYD6AdKOf79pGdxQEviC1pO8kWbtehzA0CqRdnyAyhQX/3DUDsjjyw==
X-Received: by 2002:a05:6000:428a:b0:410:f600:c35e with SMTP id
 ffacd0b85a97d-4255d299f1cmr5437284f8f.8.1759523886086; 
 Fri, 03 Oct 2025 13:38:06 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4cc3sm9356383f8f.55.2025.10.03.13.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 13:38:04 -0700 (PDT)
Message-ID: <6a55f058-a475-4548-86a0-c379bf0412a7@linaro.org>
Date: Fri, 3 Oct 2025 22:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Split address_space_write_rom_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20250922192940.2908002-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250922192940.2908002-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/9/25 21:29, Richard Henderson wrote:
> In 2dbaf58bbe7 we conditionally skipped the increment
> of buf because ubsan warns incrementing NULL, and buf
> is always NULL for FLUSH_CACHE.  However, the existence
> of the test for NULL caused Coverity to warn that the
> memcpy in the WRITE_DATA case lacked a test for NULL.
> 
> Duplicate address_space_write_rom_internal into the two
> callers, dropping enum write_rom_type, and simplify.
> This eliminates buf in the flush case, and eliminates
> the conditional increment of buf in the write case.
> 
> Coverity: CID 1621220
> Fixes: 2dbaf58bbe7 ("system/physmem: Silence warning from ubsan")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/physmem.c | 90 ++++++++++++++++++++----------------------------
>   1 file changed, 37 insertions(+), 53 deletions(-)

Patch queued, thanks!

