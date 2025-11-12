Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843CCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ56A-00038y-G6; Wed, 12 Nov 2025 02:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ54D-0001Q1-53
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:14:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ54B-0005d2-Ic
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:14:56 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711810948aso2907555e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931694; x=1763536494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Rut/nRnvwL2ZP6wW7ld1iTjQqI//SAAwPnCfO4q95o=;
 b=rYaWxRK9rjUfjyA4PQkqyIEmIfkZURhLSFz+ldTl/SjjnPjS/IqLR/n/E12G1IahUt
 MORARnCw0iFcs9NzTzHJZ8by8Ocpyml70nde4708WRj8lgKecrY+a/FpUIIrcSuj4Qo8
 QnsMYUtviclkDgaI3a4G+D0oL6k0gMZPctOXRqsaCyDp7ghL+EiRJ5PxDSzp4SlaWq5T
 mu/hT4U/ZDhfCKdKrKYNrDROm8c1YV7XXWSPrDMr+ZEpFUhwHuDVNFyWU3Dy135Xlna5
 tTZXiefPYZSqRYOIa411JqqyCP1w4Y4wvkUxQ8gXCT+UGy82ITfR0D8cR5nUeWJEvSpu
 oGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931694; x=1763536494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Rut/nRnvwL2ZP6wW7ld1iTjQqI//SAAwPnCfO4q95o=;
 b=ahnk7ekHUSZ8yHrF32rBsh5xYi40lnUGRpKYWLNSG1VmjE0lV1CZYI0Ml5DXXUddra
 hfcdW1LV9CHakuKwJ2tGU+vy7MTqaOxmaXduP2zMXT1F36KaGPUV2R2L1T3f1U+GIfRi
 Af/hk+MnNCkuFarZgdjvRmJR1qEwNZ7eHVWVFW+UdemwwxN3fca9HSaLzoEG+zBKsYtU
 mxRPCVJwE8SBpBchw5V2xPB34vAA01oolT/VTnM4hv/IaUtMqkXCmmTlV3KOREcdwkW8
 zxQfHIFU32Bd9qfC5cBTWU7sEIf4VIEEJizcZ2RsMxMgjIOn7pLIX4QrWUw8FvEbWOA6
 wM2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8TUhQ+V87eadA9FutNHPQy+eByYlI7Is+SX7+68DdlFkaS6wVO3q96eEQ1VX4DAgSeVT52Ym6xOi5@nongnu.org
X-Gm-Message-State: AOJu0YyLJDLbuP9aZuZDyPx10W+lsqG3d5YkBkBHaFWoGtIiSgNpDo8M
 RJbDeeydmsxnhMhcLkFa6G8JMkUrnDTrEbq6+Z2fzL8iRwysHpLZHW2P6qTZfx8K62k=
X-Gm-Gg: ASbGnct9m1sC5AMd2iyY0YU1CB6j0tzYkaSzkVk6CFhrv4SpbB3AM9Rh15zly5Oxeve
 17qtw/FMw/+BMTR5bc/MLdYfihSHjQRzVrsEIDQp82zd264Bj4QBCBDL2BV0iG+rM470t1eeoAH
 lul3smDHSiaWs4DskC/hEFTBtxHJsvH/F3f1y68aIwAIoY2o2y5T4eSeJ6f6rCm3AGBN1E92fru
 5IEIFBrUxYS+oEsZskThFbispRp57qrdqKZmirjqKgRA163KNxrFyQ9MoKQo0aG6+aG2v6FCOjg
 NZ61ah9KrssVMtrS78xthrvPOZl3icfyDJjIzfvCRCJZj+IWTd6/xsxgj/qpf9qWtBkEeHJC4RY
 T+l8JrxCZVqLxOSJNOuw9DRbLMypkzL6Jn+1QiwtYdujh9bPesRcBfjbs+BYj4y46M6d265W4EL
 rt6Ep1dQws3Xml3wcd+rRcNQiOeNVAgfGMLoutYhLxFTAAZotuTTcqBzc1Pgo=
X-Google-Smtp-Source: AGHT+IEQRIXjklu5kIt7vQNus1CaEu/EoX5LfUlH/1pG1PlGzZ5htAnTHKOCq7SUudiau5AmtRvNBQ==
X-Received: by 2002:a05:600c:350d:b0:471:989:9d85 with SMTP id
 5b1f17b1804b1-47787095d77mr17391855e9.19.1762931693967; 
 Tue, 11 Nov 2025 23:14:53 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e953e3sm19272975e9.14.2025.11.11.23.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:14:53 -0800 (PST)
Message-ID: <11781df4-ef38-4ba4-811e-8da50aa586a9@linaro.org>
Date: Wed, 12 Nov 2025 08:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tcg/svm: fix comma operator typo
Content-Language: en-US
To: Nicholas Mosier <nmosier@stanford.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
References: <20251111-i386-svm-vmexit-typo-fix-v1-1-49f0414472cd@stanford.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111-i386-svm-vmexit-typo-fix-v1-1-49f0414472cd@stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/11/25 22:57, Nicholas Mosier wrote:
> A comma operator inappropriately terminates an expression
> in svm_helper.c. Replace it with a semicolon.
> 
> Signed-off-by: Nicholas Mosier <nmosier@stanford.edu>
> ---
> As an apparent typo, line 742 in target/i386/tcg/system/svm_helper.c
> ends with a comma operator, rather than a statement-ending semicolon.
> This doesn't introduce any functionality bugs as the code is currently
> written, but could easily introduce bugs in the future if a new line
> of code is added following the comma operator.
> 
> This patch replaces the comma with a semicolon, as the original author
> probably intended.
> ---
>   target/i386/tcg/system/svm_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


