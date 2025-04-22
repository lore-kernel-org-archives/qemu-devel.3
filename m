Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D676C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FTT-0004jl-AC; Tue, 22 Apr 2025 11:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7FTQ-0004j5-Mu
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:23:48 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7FTO-0000TA-WD
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:23:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3014678689aso4150479a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745335425; x=1745940225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcYjd2IYzi9WfeHOcm4gyHmdk9tbn6fXnkTqkTM2vMI=;
 b=FPhjeg50qjji78+BFHM6ZWtOuCW2Vgv1cMmtt+7b21gS101r10L8pA9TQTS5LWvrgY
 pd4Se84G8C8M0gA2ur3lL/pyLDgO4vrpowDMlx2zWeuyiT8wlQcTZbPbFH8k3EBpxyaL
 h8zC8dXF7XqBSVdCeaaHZ1Y9WEbiTIv8VCMqxkex2Grs/LAfDixt/vIM7Xe8PqiBKpdA
 AbdGiScDJW+Fls1jiTWO8hTIVP2a+lvooxCy3gaDITIphc6qv6fgXHY3oHqM8hfoCqoi
 b47FDtwK5AsMNs5o1gBL0f1sISZe4Fp1OBmfFq+ECvNXsWe4OSz21XyWY+ytN0PdTWPS
 uzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335425; x=1745940225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcYjd2IYzi9WfeHOcm4gyHmdk9tbn6fXnkTqkTM2vMI=;
 b=PCp3iLGgtpL4bMnKHWrwnO39lPzT4kpj4aTHA+MfMxlGnEMH10lXz30uvPHvyG0x39
 MzCuKxTQ+VV/1HlhyXZo8/0s5Lv5md/aaB6kcXYCZURwcDaCtQmJiHX5cxNGedtp3XbJ
 jaW2FAp6MMX0t0e+BX+Yt7SM3lSF7iim+3MFpx5wGKrW1p5dhnu8sfAmuFXpuuVwLb8P
 VTdoK/K9CvRFn1BZ5jU8rOhrXCjxwVXRpo97oo9MLzu/nB6qJujS+CEYea8iq69B9U/4
 JR31JAH2l2E6qiTLvX5rhG/tHLNE73AdKhtjfqr6qmNw7sLJQnfuaA+nPBbs1zq13LSB
 dGnQ==
X-Gm-Message-State: AOJu0YwVKOtNz8qsnRkMbAO7V82Ece7SuOahgYxJFq3gxl8AnPatRqk8
 k5AML7bSiQvUjbkZE+0XY/vgmbdloiuqIHU25ZDFP6ofo1tu16mOw50vCgYVKVVsLjTizMoWcsj
 7
X-Gm-Gg: ASbGnct57R9BPG4VwQIn/yEIWaoVqOtrIrPTHU0Jgv3v3apUD/fvIaeQXBwJ2N+l5qr
 d88yXeD8N/yLNR/tOZZ+0kR8/4Pl0BISuU8KjGAlHW4K2J5XnAjfAjhGmtbrWjjNi4X2HJpthSH
 /bI0BJcTHYh1QL/R71efocGpLvEYOZwxBL7CJRyC8T5FXo38q2Cq7D/GzdQxVQkArKIu5ivmuZc
 XW3wlNu0NHwJM7DQzRuU1OZP+gPSuml4b7iZKyiR5W+az4vxhX+9Td9+JkpuJkHf8aVEUViJNZU
 isKzExsKW7eWTa7sEFFJPJi9HAXssVfb1yoGEGQF6jiRo1R0t/kSI9xjV0GiCKA35YL5Nd0LraI
 +ASnPqhE=
X-Google-Smtp-Source: AGHT+IFelQ7zHBjinq6vArOUstwxQL34xSEcO+Z9ngjoOi14vlHmFaDJMAPsHDvMkauNBvuD5EOjmQ==
X-Received: by 2002:a17:90b:540e:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-3087bb3e7bemr24572351a91.7.1745335425125; 
 Tue, 22 Apr 2025 08:23:45 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee3279sm8758810a91.7.2025.04.22.08.23.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:23:44 -0700 (PDT)
Message-ID: <09f3eaeb-f610-42e6-8b64-905513c11c18@linaro.org>
Date: Tue, 22 Apr 2025 08:23:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/i386: special case ADC/SBB x,0 and SBB x,x
To: qemu-devel@nongnu.org
References: <20250403092251.54441-1-pbonzini@redhat.com>
 <20250403092251.54441-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403092251.54441-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/3/25 02:22, Paolo Bonzini wrote:
> Avoid the three-operand CC_OP_ADD and CC_OP_ADC in these relatively
> common cases.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 20 ++++++++++++
>   target/i386/tcg/emit.c.inc  | 65 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 80 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

