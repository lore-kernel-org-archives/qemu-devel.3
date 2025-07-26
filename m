Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3D1C87FCE
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufU11-0002ZQ-RV; Fri, 25 Jul 2025 21:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufU0x-0002Xh-Rv
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:47:56 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufU0w-0004ik-6w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:47:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-313a188174fso3008365a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753494472; x=1754099272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHuObIU4zQC/0PnVvns6zUIVNWw4JQrTiljkW4LygzA=;
 b=SRtCxy8w7w9sp0np2TbIEKXWwLRyxZVuUBPAP4XGKCkU91UyfwDBg9R2/yPfthYZ80
 ehw/bFKRxXGa1JfzZlx0qOMfnue2GtQ0ClOjj5iEygz2SpwHN8tTS1Ifex+2M587+mUz
 gDxJwndooMel+JDsgD/HUzYAVoqe85N567c+7iQ34gAy/TBsw39yv2VYO6eq9sNilXpb
 NsGMce4yzJkZdoVeIQBLiDC/MNPn02mJ1ie3DbZt1Dyy7OXsx38TRvPLAP9lDWpkXrJY
 trzCE8AXO5Eufry9USPKXngT2Hxy/I1JKs7ACEQ8iAP0QHaadmaY4mCt7pMAOf34tmGq
 n9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753494472; x=1754099272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JHuObIU4zQC/0PnVvns6zUIVNWw4JQrTiljkW4LygzA=;
 b=jCQ8PZMB3e5cJARVKVsNDwY+ccRYh1keQzAz6F8bagOOQVgJxSwmLxyAm8K/cqX8Cf
 m+opvbKQOhsvAhjpPQZ8hdA/oR1hYzWoy1WmzPl9i9cLRcxCe5fikGO/Q5ErlfODyzzt
 jJK7XoDCrYXnO6nmXTWxENXO1KkaY3GzV5N+3QHQh6+ujhoGfdVg6YzNkiiLxH0R14DJ
 yYuaPa0P5+Co9VBbTmscw76Abjhu0CwSt3oGj8IdOLV1cLmM+0BBc1h+v198dpwtv3JI
 QdswRQYzGXrOx0QtwgDd7dTHfDk1zAi0MlPLPOW6+olIi7xqcgy5YyD3oq234PiTzvH5
 gEQQ==
X-Gm-Message-State: AOJu0Yyb24HgGoekoF7Q1Y0nfpr4D2BI8NWhMqkSKbtO4Wy47wdFXKsT
 1d6D9LClE7UzongWaIpxgjNkpeBQGGFok1ou9GhyhkjaOw1/st+jv08wPsvAwD7mmxyoYDQHXhP
 N03Vz
X-Gm-Gg: ASbGncv+cc77HvqG4Z/dad5+s8Ums7Phw6/vNA+KisyJEXmvByQjl8UxqSrCHV7gOMl
 +L5D0Z+9t/Pr8X7MjDUGMUPwwo8kmlGIWPiuA7/wDZMLLrAceo0k44oWAAcLNBWaUXUCZ/8OPNl
 pE/EgOxYaiD0g6+I6pz8sCMA3l3rzw/Yw3Xj5N2cd7HuX07d5zlh3Ybr93/5WKEu9bL9HbFshv4
 4NYgfyha3QxfoXpLHvkY32tROh904eltpfwnl+DzwuIm8mfFDU4ZrzC5Ir5h1V58IATHsQrg1yJ
 mjufSbycaTdlfd6zhtqpXiPcdreguyNzzVIULA/KZmX4rh4PGiZ1BzezoKMpXqbwz/ncve140Fx
 //l1b7v3YG82yS4Fr6NLY75eANJE9JsK8si5xao4H41DhhODDy1TcHmzWq537qyTbf8nt/WWFXv
 IpdaKVUABUjIfd
X-Google-Smtp-Source: AGHT+IE/ewEnS8Dk5cFfX/kSnGLjzP3JWPzfUpovc4VEYRQAcxv+0l5nLAtb4/0xRKZnje5YtshMXQ==
X-Received: by 2002:a17:90b:4a0c:b0:311:1617:5bc4 with SMTP id
 98e67ed59e1d1-31e662e8481mr10300092a91.12.1753494471635; 
 Fri, 25 Jul 2025 18:47:51 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635f095sm4436120a91.25.2025.07.25.18.47.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:47:51 -0700 (PDT)
Message-ID: <756beed7-74f5-4ad3-9fbe-6a88ef006306@linaro.org>
Date: Fri, 25 Jul 2025 15:47:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] target/loongarch: Add parameter tlb pointer with
 fill_tlb_entry
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725014711.1025794-1-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725014711.1025794-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 7/24/25 15:47, Bibo Mao wrote:
> With function fill_tlb_entry(), it will update LoongArch emulated
> TLB information. Here parameter tlb pointer is added so that TLB
> entry will be updated based on relative TLB CSR registers.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


