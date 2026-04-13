Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E26F531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCR2B-0003W1-M4; Mon, 13 Apr 2026 19:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR2A-0003Vt-Sr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:49:38 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR29-00027j-Iq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:49:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f1dcd5886so1716994b3a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776124176; x=1776728976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjVBJtukqCJqyjqA0oPbau3gRSWeJyWGil0DHEVB0F4=;
 b=urFwmL2LhwjcSUiXBTmVcsjkLr8B+jCLkkZU9u5lPwzjkVsI2SbjWk5mp4Y9lQMnaj
 nT0IjFNFqejCfWLATdqXyzlcVQSR7vUdP5ZUNYsWnlvArunGFyTW4WIF+4ee0ONIyYs1
 ShS0gc4PYo53paY4E9S0JfhVkDoXtjCd49gdamdNP6DFLnmjafTRO9HF/WdVQOlwE0d3
 5vU4FLGHMsRhEs0gmQJ6zA/U6WZZtiHbALyTGjAPTjFZVZ3Lga56swCpg1J34A+8kH+p
 oY0CO8uOWtEszd7ayeJe3wrLh3rhHexmQ40zCib9rgmV7jVAl1l8Toea9S4rvlfq1rkZ
 3CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776124176; x=1776728976;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjVBJtukqCJqyjqA0oPbau3gRSWeJyWGil0DHEVB0F4=;
 b=HN2aPYX/Z4nfQhqmXWVCcVSH6Wfc3DgG7DrqCR0oyW9Zp9PAwDuuXEMrBFGFd7py6j
 D5KC9c7RxxF/Q9ZELBMFQfdfrpvJE60VTgNNwbBq5wdpzE7jHDFy9z+GA3B8LHqee0Zk
 2kt2bDaLRCFAs3rf2wdyyGKMrP5XT7eTUqB8LC+AXMmlqiHdbN5Hz5xLg/nKTuyOV92Q
 g98DivlhQM4gQRt8+C1oSi6FCGaKLLXGfZgxiyp8DjtXv3/YnxyLGVXccCct8e5e800R
 l0eQ09bb6NhtRiwKYUTEE2SNdQqKPmZBnI06ObI3J2VlLbGRl5vapHk6hzf3q6oEUwXj
 a7GA==
X-Gm-Message-State: AOJu0Yyinr3DQurGF0YSpBJflgh/ba6W9mxMEx/u8WyowiK/031vf/Fu
 /gMg0ZR+Q3ebfYy9QTuvFjVNW8zM+rWsNuFkvCfBjF481ORTL8Aprd9KK/fhMrSWs1AqoqxaIjo
 /b4bV
X-Gm-Gg: AeBDies3dA6VfCiaeGd/0zGsiNQNMxhwf4S66feOaSU9habQkWGsuxjuDOz+cPggRCQ
 lFw86/l2sKznzDaxg2eMprODAOu0QKuo8rMyU+x+xBSPZV96QUYgDcUJO8viJnPau9zxJhoIbFv
 BHz4DmKCSuspTnswRBi9yZYU2fgiCb7gD6KrDCOnQWG9fH+OeParPpTHBqjsbrhfL26IhwmrqEJ
 y1zi40krxefYjhaacnJVGo2vre4LAbxA8Iy0H7/HTgWfpg2aQ/yiJSQjVpCDQwkAx/H0Yixz/hZ
 snMfQX3KvipQp346ZslbRTI49T7b375y5YUk2/aDz7JRXFjijhLHqUmmbPG7eBKvH8PdkQS2SXx
 62wU3NCTUxj+cVGOvKTh9SAL2rSoHrmPhVa/4XapKRROSlrbZQOFJJoyebtUpi/Wy6rKslMFxhA
 35qTBeSLiXUh6t8G6FDHuyWJUxaCsPdLCxoSwvQtESQWqMfVtbsoDM93ubrXziaYETvZOlrRuL/
 LVAtPMFoY4FjA==
X-Received: by 2002:a05:6a00:2d1c:b0:82c:9897:70e0 with SMTP id
 d2e1a72fcca58-82f0c37f54bmr15192971b3a.47.1776124175610; 
 Mon, 13 Apr 2026 16:49:35 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c30ee4bsm13537388b3a.2.2026.04.13.16.49.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:49:35 -0700 (PDT)
Message-ID: <7aa07f01-d155-4417-80ff-6af863460d3b@linaro.org>
Date: Tue, 14 Apr 2026 09:49:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/arm: Replace MO_TE -> mo_endian() for Cortex-M
 helpers
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/m_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

