Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F16C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MQ9-0002BM-OB; Mon, 14 Apr 2025 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MPB-0001zy-6q
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:11:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MP8-0000WU-JL
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:11:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso30644955e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744647085; x=1745251885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WqBFC1T5vvtFmaKrfZy+y6npmm7hcx4NUKeeI8wQlmk=;
 b=rBMF3+sFBVP7HTPZGM15azdw41CrySc8otZPZjALRj/mTsJZEYKMWgN/jR5nyxbYFj
 TrctYwgL3N+xfenGJGpOa45T4mzPgM8Xg41lo/cCplMUtMETYNdWAEFIvu3Ixzc9Ki3F
 kixP7e49lv27OGwI32dNaoNxg1fiEO0BarYT7WfzRjQ06J17MGm+araNK5u60JSQ8hAz
 PVWT/dWswpMVEQM6TRwO84Eg52OrKdvCSAvbVSdui42fGGPMUDQlI3w2JBXjSVMEQ57w
 ivcTgeknY3CFjkYs1Jrpv5OEyqDivEmjEU5shLweJZK0VVWeCn2x4j36C6FRuhHYFkwc
 7CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744647085; x=1745251885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqBFC1T5vvtFmaKrfZy+y6npmm7hcx4NUKeeI8wQlmk=;
 b=mQJ5hbSia9pFqnmMHSBbWuG9nzFb2rnB9ag5XogVi/XR60QUllUxxE/Kb03xBqj3Fw
 GgXmJ6E31deObIKGwh+KE5yPvQDXjox5RtNU09iZVfk5rqjKj2Ofglij2eG4YDA29klk
 PKPva7dUmAKEMUgUcDj2LuR3b/dZDSZvS6LC2GqmjGKu6eeYFfyLT3qsNQrUDigrhNFY
 7e15tHbCUjf/1jJFwxlqOXACeO2PmvQ2rJ8yiSlHRmPCl9b4UYlIU01Ackd+PqX0hM5f
 2hXTptZF65AuxsEES2B/8ZaeYunEo575Ni9CUQ6/B6QP9BQg0v6ccVY/b7+SxprD5W9+
 9OjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8sIvUuheBp4FVOk6Z7BTfdGBNLsyoDzm6r2NEe5FRQ07v7O3ge1OSVSN08EIp4cbaj2rUR64In53O@nongnu.org
X-Gm-Message-State: AOJu0YwyN6AmeuyQidoxCSuKnkneVto8k5npVj1N6WpaPjDWjmxx0RLb
 hSM3TiSm8L3gum5Ytqle993Yb3CA9w3AlVkr+Kwz0lYewO1vR0aPgY3CVqVvlwM=
X-Gm-Gg: ASbGncvPD9hHoBjby6vOISVZcxeVClebMmBA/Q6ZQ6redzC9MSUXIjALwy9W+qbjKFk
 6sf/3kpTf9Kz/Q4X411FVNO3MK671ewUeGljnrv4mRFQs8UHbOIrTuxf/mU8a86B2TLlite7dK3
 wh/XCm3gutavFT97I37kRv0Jj2MusaqnatOcYzs5sxrmLCxg5/AfKlplIMOwiJ4rrvLHPImZLkG
 bNYRvPuXL3aoJAcnZqe8WofjKiuM9/cWtFo+dLP2pXB3HZRx69OsHfiSOExzHnhFXtzvKWuUcl8
 sMNSpHYyI+tlY1P4EyQcfOyWHGwhYovDJATRfHdY+iKZEtIm949GfrehLG5cBkz3Tke7Bo2O2Gi
 elsbt9l79
X-Google-Smtp-Source: AGHT+IE58QDSzxRSSij9wsJ1+McSibW5obJ715fI5C7s08F+e2CSRna8CL5p0vCRakDKH4mCwMGHNQ==
X-Received: by 2002:a05:600c:3b27:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-43f99889ac5mr232165e9.2.1744647084720; 
 Mon, 14 Apr 2025 09:11:24 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445772sm11501941f8f.91.2025.04.14.09.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 09:11:24 -0700 (PDT)
Message-ID: <a8d305e6-3658-4ee6-98dd-167b41a184cd@linaro.org>
Date: Mon, 14 Apr 2025 18:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add functional tests that are not covered yet
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-arm@nongnu.org
References: <20250414121520.213665-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414121520.213665-1-thuth@redhat.com>
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

On 14/4/25 14:15, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Some functional tests are currently not covered by the entries
> in MAINTAINERS yet, so scripts/get_maintainers.pl fails to suggest
> the right people who should be CC:-ed for related patches.
> Add the uncovered tests to the right sections to close this gap.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


