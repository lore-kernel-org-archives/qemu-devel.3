Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CA7C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURUt-0002vF-Jx; Wed, 25 Jun 2025 10:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURUp-0002sw-T5
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:53:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURUo-0005qa-2m
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:53:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2353a2bc210so60168235ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863184; x=1751467984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ao8oplomwiu38rd6Pk9qufQ4srfg4UhUHzgpgTkoH7Q=;
 b=ON78WxQSA2IEk0L5fYSOTiCLl9/YHkLQIcKe+/APOYuA5fUta3zzTisDmgiLzat7U0
 W2NCE2kxulXU/gr2HtRBQQbD3ywoDPzPtF16KfTpKLRCr8qPfYByywgwmc8muj73OGRM
 dDkEZSD8HKTgG/2q/WWLLM0uLcVg6VVHZfRQ///qOZzYW0d3065JWdjZ51SppqYmhCTr
 kG7oQ4Ewr+owlyRuCMViEyB+WwysB9R2iZ6+s0ogVkcshkSkV2Clddm7v02Sj62pgYUC
 CKHv9ZnQRT5aXFQqshe9Mf7Bhl12ZHCIn7N9HTlKyltLqqmBvsxXfiUadp9hMd9O+qZK
 hLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863184; x=1751467984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ao8oplomwiu38rd6Pk9qufQ4srfg4UhUHzgpgTkoH7Q=;
 b=iRggRnNeGOIVYg6yUcxD6PV1GAsLV2/AamOifKaQvu/bpDd3dXX1/knYjSnF10wr/1
 NtwA2gcuyQw3lb+5s0nEdRKaEtjEuuZYNWQ8dRVeVjH1LxG2m0ootedtWTVSmPMjev7L
 W6LQvfw8+Y4hAenyHTKD3n2t3kUqTTXMFL4M4t8OVjCHAofFbvTWIsIcb/u6vJGhyZsX
 8CWMhpb9tNJaZ+Mx/lykMBOa7kyyVP+uTBgBax+g8I/7COpZH6Oq2NfsU/PLMTlLytAF
 rPCnmtK4031AhibHqrAs4HBcP3wlUACTZsph3998YonjcIPm3/UpIFueiIXq7xPjXYxg
 e4IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwKSaVh0Pkgiw3VWb6dwfy8RRsB9VAC5KrfXmMij46/Fn6gv4tHqTB6sENjOH+pkyW013dm8WEV+Nc@nongnu.org
X-Gm-Message-State: AOJu0YwKYT0CmBIN+pU/oCKY0hrd1f1uChjdw0rplXN7HlS6OQI4bBZB
 PKvx1er3eodvKAIUtHVolavWUzaB7aRqoSJgsS/f23hk6jc7/fmfNiXRlFo6z80VU7k=
X-Gm-Gg: ASbGncvYN2y9zJ/1/WUieqKL5OD3iPgbQSnbb2Yrv2OjfSQ6VL2/ajfBHuir1sKN/gB
 IK8RBuYYDxohwdq6Ubxh1hLaKTaw2IlHm1Cv8ZIC7n8FZkDFmtZSQbEpOCdlcBs4Fpu+GtlRxFH
 n0ZNR4P5+Th7m4bmm4CV7NhDqtH2sh9zRTgNyaz9NEnFCbTSwvNh6g+MdMpsiarn6//j1ZKW8Yu
 71bRFHrymjWnCwMuvZjbBdZc9oyjasMxf4+HX5vJX4mzqcwpLKX/ZmPjjdbk+o71fhS8wT+hBHp
 yVdnHjLhdnNVeFoOih5R4gDjlU26UTVb/+/JJOWh6U2NxlzLfHoxTbIADtuPcfZjWdkrnvboAxQ
 =
X-Google-Smtp-Source: AGHT+IEMrK49QHFqXksOXjNPnF+gnBvDqnSPmQXTcUCxRMJJZA06glKhiuau0XNMRkXvCo/mzHff3Q==
X-Received: by 2002:a17:902:ce06:b0:235:eca0:12d4 with SMTP id
 d9443c01a7336-23824095671mr67015035ad.53.1750863184647; 
 Wed, 25 Jun 2025 07:53:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8607c96sm133909905ad.138.2025.06.25.07.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:53:04 -0700 (PDT)
Message-ID: <d5cfcd64-1004-4e43-a84e-ff6247458bc5@linaro.org>
Date: Wed, 25 Jun 2025 07:53:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/27] tcg/optimize: Build and use o_bits in
 fold_deposit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


