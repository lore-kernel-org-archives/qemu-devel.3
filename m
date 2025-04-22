Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD4DC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77lB-0001Eg-P3; Tue, 22 Apr 2025 03:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77l8-0001Cx-75
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:09:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77l6-0002EL-6g
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:09:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a823036so37746895e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745305770; x=1745910570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XBC6fDWIXt27CNQ0lTmbS+JScIfJZV1/JKvrsox0Ho=;
 b=KkIFV0x4JDIM3WeT8dnhqERkdeasmsUXL3ipk8S+Z2XEujhmUnHmi7S5q7Fzlj4ICP
 B8Y3VarVjexSbVuMI35VK+95WGS7DchHcH34LSI95YNs9B6iT3Bd/USIQRnzody6SCKU
 7ksiTEKWM9B+qA2cffa0YqUdjZbMQwoJGB/z13Y+t1ugiqtih7JO2ihvy1yF2QHMBljy
 a4XexZYGyyUlQ5hVv9y1P1toB9y+5HI1zolP2fLEhAlftWNwd9DomtPxnY6PJ6gHNEUr
 xDv/kzTkKNd97CDh2oUUg1YwrY4qOSi1OkM1V0cddHU1wvb09jKdAWdo21J59pxipiB0
 9+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745305770; x=1745910570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XBC6fDWIXt27CNQ0lTmbS+JScIfJZV1/JKvrsox0Ho=;
 b=fmDDx6wnoaZyboy9Hhus+INAmlEFOuu8StgNY0Cmx/p56hFiEXpJdoGKUIIPfBooic
 ukBrjVOxTKq0tipBkUi8IqjaQj1YwM9GdbQ/2fL3OJ1HtLe4uW+pmQa8N6zube6dwHwx
 iU7vSJs8J9s852i1b4DZ4ByiVU+EsHaRMTO2mNJBdcy/EyZ6ictjewxCEYid+UrQCCyD
 9ikdfvxDglgoSHAvSHATISdBCgX7M+i6yrptKMNZboBLc7fJztkP5UALw825O4T3wrTi
 OsajyzfaFi6DE69+nR+7bSDebqYHDY26H6wzYBJJRczTKJc5sNv7XQtRxUIC8AHHda+B
 9OJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnJ9fLQiQoXm+Fnp8VadcPJdzJ7r4VH7M2k00Ez1ey7IPz1ZhPkSDtY/a+V863IE0eSwxay7/RgFn5@nongnu.org
X-Gm-Message-State: AOJu0YzHbclZU5C/QbmjmbU0ZXKnTsG90XI3H/3F7ztkV9r+B5pU+DXQ
 T6L3R8qOrMDxitVeZJYTzDk2TnjZiUQvbRLoE63mygsaIhB1i9pXyPJmX3UauvU=
X-Gm-Gg: ASbGncsiMsOGXft2gHqn0NXmX6HJwzJQUrOZs3k5rC2y30O5Syn8qGSR2dI9ZZUZnQK
 6702Fcn2SybRRWsLwNPDbw9bb6c2AAxNtlE6PM4XGMd/juIJbFpPmKYY89tb02Al8axroC5AHfh
 vOecaD6pK8f3/CbUMm45oAJONcjZ2UGNd1Q8WSG695IxDgtnY+RbccvsGmf1PPbfQAkmxdF2jgQ
 bUWnsRIHqNYMmpswL0zBRCYjH5fdbwasJOnLqS8pK7XbbLZM/+ITDDWXc4G94fG3Dfb369DFpPy
 JV1kfm3s+jZrFCzxNlGgVOnnSSw+YRnXSxRAt7uGbyyfK6c+8g7WFx4se9TMY2udTthEknJjrkM
 +vCwYNDhF
X-Google-Smtp-Source: AGHT+IF6YsC55cNRE79Ll0uF8F/8mu0E26bMVj8ti7aHsEuNrBN0Rsk59EmDGnzSS4TLV0iZdwbA9w==
X-Received: by 2002:a5d:64e6:0:b0:39f:884f:d994 with SMTP id
 ffacd0b85a97d-39f884fd9f5mr1238910f8f.52.1745305769974; 
 Tue, 22 Apr 2025 00:09:29 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d071sm14308064f8f.60.2025.04.22.00.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:09:29 -0700 (PDT)
Message-ID: <c901543c-57bc-4bfd-b742-4dc302126eb6@linaro.org>
Date: Tue, 22 Apr 2025 09:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Remove unused callback function
 *bdrv_aio_pdiscard
To: Sunny Zhu <sunnyzhyy@qq.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org
References: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
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

On 21/4/25 20:21, Sunny Zhu wrote:
> The bytes type in *bdrv_aio_pdiscard should be int64_t rather than int.
> 
> There are no drivers implementing the *bdrv_aio_pdiscard() callback,
> it appears to be an unused function. Therefore, we'll simply remove it
> instead of fixing it.
> 
> Additionally, coroutine-based callbacks are preferred. If someone needs
> to implement bdrv_aio_pdiscard, a coroutine-based version would be
> straightforward to implement.
> 
> Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
> ---
>   block/io.c                       | 22 +++-------------------
>   include/block/block_int-common.h |  4 ----
>   2 files changed, 3 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


