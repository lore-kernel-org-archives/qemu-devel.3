Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8AAC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZShs-0006Es-TO; Wed, 09 Jul 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZShp-0006AI-8n
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:11:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZShn-0001eH-Gh
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:11:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45310223677so33749555e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059473; x=1752664273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5S0h5Cx+KVjDK71MEiyCA2N8Noyn8wpTXq5V1tkWuIY=;
 b=AAlP/0/RYiGPog+4fBn94KJ/3YRB7SHPxFjPfYwiT5tPawomem3uQDLDpioThsxS0X
 bkHUTljOTI48LsG3JYY6+UnlztyeZAI/iWvXa64B1IfOlsZhqFEo8xcA2FNzIa2x1jA6
 0hyY5Z4V0hlcIA7/8lNnhmntLcH/c2KgNC6bfwk1uixXtNvHk5JAA5CYuUM8hER1ahPR
 dOf+aVFGQ5fJVwC0cX/NEpybuUsyEx6H0DJ21+OBrFnYXNIO4a/Pf/AvNGqGp8dVxBYx
 BI8s2QAW01UmB44GdhYOuYdd0Y6ZTE3fHmUalrQoOE/zIFhkyb5hsCFQCOGHDwd7tByI
 YKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059473; x=1752664273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S0h5Cx+KVjDK71MEiyCA2N8Noyn8wpTXq5V1tkWuIY=;
 b=TML27tuDkeRP+CZmX/sWDqXMd/mpqKYyTP82flpiZ6Q629J70twnfAfWd2neL6IPWF
 jOvGq3f74BQnL3NIckfFdLFMeit3LGGp+tLY8i19O7RYNJBhkNjVQPrIGgL+VJzWkiqt
 rONWSebxkh4sOIu0Jalz2XzVQJeR1tMGbdf9q4ZGPSLJok+Gw2vX1Jf2BO+3jcU+4ji5
 VavN4wXARfW/LZk9oLrTcQC8VH9EZB4wEzTPpNjMnaGfy0aMBejOUMijpZLCmqFFyJpZ
 wL0jrw/w/aLDv7YSimivHOVYg9sADz/jiW6xm56520IZlnDBdBIpZgu3wwE49INLSz8N
 yriQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXplvkBI/W6eXeuLTvvQeYHuvZJFT22ib3sBJou3CD3p4XdEt2nXqvSdbB/pDIgkE/OiyB7zsWvt/nX@nongnu.org
X-Gm-Message-State: AOJu0Yyv2ZyeNYE6LXdUvMuWohpR8Qm2vZBrfvofDn9hq7b7iU/w/vZT
 8QN7zvvUNnZyy34mP5MWUODhf3LdSdVvS8rLaeqzLySGLYov5wfsoXVIhdRAsWgj5MAxF0/4Wt1
 RkiO4
X-Gm-Gg: ASbGncvMsYGTCdZc06o32mZzU8IQNa7F7yUhtAv4k7NqBW5h1qgQ4lH/uR3/7X+ReBi
 xaTjQNFx4yi4/dfXuV+UkYaxfPNCHkSrxA37tnsiKmA3M3pE9lc+gfDtTT+xDJtnwN8dXtnT0Ns
 pdSDZ5SrrKfY1ZyHEQD+VClR1CV1GpD0VTV6nwwXpWXDslna63ojFx65rS3xxvKObyp/cRWJ7s9
 S3PtzyjPhtr+N3XFfTvBqcvE17N2j7eJD7TzK3MewNTMzlpjwUr8jsFnAJayfYg8Dk/V5WzZHWU
 Q+udNM8zZ4X56HXnFk2bhTFqxnGDk/6Q2P/iXYOIGrjDGR8UIwzhXVOenrpcnBtCQQmuVWSu2gh
 II5xhtw0aBt5XJIxx+aPu98Vev4HaqpGFpw4q8WvI
X-Google-Smtp-Source: AGHT+IGgKU6TLbMDXyKNyi3PGbfg8oVP+QKS/gpS7MNMYWds5HHIrM1jGUY5Q4lob53964OyUzpksQ==
X-Received: by 2002:a05:600c:3ba6:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-454d53da0eamr16728495e9.25.1752059472999; 
 Wed, 09 Jul 2025 04:11:12 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50616dasm20292975e9.21.2025.07.09.04.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:11:12 -0700 (PDT)
Message-ID: <4880d3ce-48a7-4d36-9646-8c6e40fafe08@linaro.org>
Date: Wed, 9 Jul 2025 13:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] esp.c: only call dma_memory_read function if
 transfer length is non-zero
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-5-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618061249.743897-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/6/25 08:12, Mark Cave-Ayland wrote:
> In the cases where mixed DMA/non-DMA transfers are used or no data is
> available, it is possible to for the calculated transfer length to be

"to ~for~ the..."

> zero. Only call the dma_memory_read function where the transfer length
> is non-zero to avoid invoking the DMA engine for a zero length transfer
> which can have side-effects (along with generating additional tracing
> noise).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


