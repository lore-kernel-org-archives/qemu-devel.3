Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DCD7833D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAOf-0006pu-8S; Mon, 02 Dec 2024 12:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAOd-0006am-6n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:39:43 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAOb-00042a-2b
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:39:42 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d89dc50927so10746616d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161180; x=1733765980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EveaphyC8kzcAK5D+3Gv8PqGMEK3fAj40a38FpcIYVY=;
 b=MXnWTXzHqYrct4wYAHyHPhRznfRJY3Vi+P2dEN5Pow5VK0ojckdQS5rexxBZVExeiX
 JtwiU9DfIUl4S7qKOiBRVGYA0qPrKvEHBiRmgFRfK/3qBKNqM/s4mLjJaSJptAawZ4T+
 0i1XjTrKnJJv6XO4CenG9aFmWoqW4I9OVfHVA3lnFytJIffaJiJGmrVqx6WovK6XmeIx
 e4zd4+u5WWO48UWHstgyIxlBDehWOF5yrPVGqKseyxVDTJ8ThEZ+MP7o1Gti+pTPb3WG
 Nc9/amPN6gaWrK59S178fCFfKk3mbdzaWZPro4zPYoBkThWtm1gkakOTcwhizPmrQzgQ
 N9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161180; x=1733765980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EveaphyC8kzcAK5D+3Gv8PqGMEK3fAj40a38FpcIYVY=;
 b=gNFizcaMw7EBCspyZkCdKsMU5B2I7JWEMsdMSg3vpGagl3qCQDNIpc1O76cn+rfPLh
 /SBJvdvFku5nuK/pSG2fNxHfIJPvH0dPmfuNHWXJ0iRR0xR6AKExV2bTJmTwmPBUPuNq
 CpdQpQVaisxsij3NIV3NnpoHpnTNEa0XyitrOssJ+n0xgx4IAu23llcKIY+DoR8FrGSL
 SV7v8NWnZkfSIydadOL6lGnfbyLend0lNb151MHtJWGeZ++afFfECKEC+LK14rhHzCpq
 J4loM59JCYKB1pu+sJ7vg8kIst7st4J97AgkKJ6OaHRrQjbwjrv5eZfPhVrcmpsmtbHA
 yGww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRvrCE9aSzSNGpuF/e2O/GtTbuMfmhSxkfLxmXIOv3NXsXXsectLNkGkqNwX543B46ZyCCcPOe0OVp@nongnu.org
X-Gm-Message-State: AOJu0YytZ/tRA6fyEE0yUf+Cj439L9ymDDNAMZ9M7CacCJ86lw2RvROP
 Xb8KsjUfG473xrAr1Oti310bNTH0Qtqlc2Gq6KdxakTxjRT3ur4KFnvh4SceA2M=
X-Gm-Gg: ASbGncsvhH8oBVqWKwSDWTay+97S5i80zgBQ42Cictc9N2al/bLLE5GKizlBaUbmFbC
 hrugTRUDXv6TDJA4lo3pLoR+s0s/X81jFUUCLvycTyzIH0fcX4MugFk4ZkIHPDRN1okdJDUfrn1
 St1gFxn5SyIwL6ERR5/L52N7RFunn0IbY+qBiYVYHQGkiiOIJxus0Ni7IuKXKQu9dB+x8/NaImE
 xTzq8r09D34hKURHwz8uLHEYhszvM2z0tZITDK/rYXRD6qBEdF5S9ctFz3x9TWUTKJmDe8=
X-Google-Smtp-Source: AGHT+IH3aDDwGi53EJvN9cbWj/xaIQowT5xgTJ/JFzFTtX2A1EDV7lJF/BBUGCXr4SXChM7JMMlFMA==
X-Received: by 2002:a05:6214:2424:b0:6d1:9f29:2e3b with SMTP id
 6a1803df08f44-6d864d1f1a2mr300543836d6.13.1733161179860; 
 Mon, 02 Dec 2024 09:39:39 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8752224d1sm50648086d6.98.2024.12.02.09.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:39:39 -0800 (PST)
Message-ID: <cbc72a56-30f2-484a-a422-0003f9ae1b90@linaro.org>
Date: Mon, 2 Dec 2024 11:39:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 54/54] fpu: Remove default handling for
 dnan_pattern
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-55-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-55-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> Now that all our targets have bene converted to explicitly specify
> their pattern for the default NaN value we can remove the remaining
> fallback code in parts64_default_nan().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

