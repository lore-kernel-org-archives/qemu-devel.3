Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D81CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBaHH-0004X5-VH; Tue, 29 Sep 2026 12:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaHE-0004TG-Oh
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:01:56 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaHD-0002hG-4X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:01:56 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 d2e1a72fcca58-86efece610cso2219209b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790697713; x=1791302513; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2j2rx9qGfEP+/oVC/ZzL0eiZboFVJO2eNdfIf4+jMOU=;
 b=CSF9AW36VNz0DBaicbmc9ne+ww0cvHsjfuthh9y/0J0U//jZikv5G5hwERBXpPrf+f
 J7jt/SEVYsSFwvQD+E4w5PQHLRjhheriCqSA6RYoRy9RUhaVLMGk/F+T/Rd9MB4eK3X/
 gKEdt/hXA3SPj5jW1gc1EYcwCcYfAmlfFXNqC3/poTdeu1OwArInn1WRJZc0yjWgWvxq
 6zyM/6zbjgFkBIoucGoC//hj8PNaTCBcjs7kjO/6giotWvxl1g7stxhC/79Ge8zICfpp
 WDSZGNrs8tMcyrz2imL1/2NApDogNk8C2vNeztK+oVr6q9fL20qr5c0RC5HqiV4qkyoI
 qPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697713; x=1791302513;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2j2rx9qGfEP+/oVC/ZzL0eiZboFVJO2eNdfIf4+jMOU=;
 b=EJqFpADXoLz+nxLn/cciHtzU5TNnF5c/imLxzTagnt4YeKi/V0XvqloOP6RIqRR0+4
 mthdm6aW7JXtHAvpZGihOGLUX8jBg/aY1FURaCUgjbFL96OmL1Wl7aaLYr0hkdEB6JyK
 E+J8kx9C63OOaXOB0PvcrUPh5gXPP6SQ0OR0WhgFWEb3atbNi9SrE4NLw8iTaKGGhXQC
 QqnrADsxsz1bZrnlCA+87Y9wte2mImNbR6iI9tDFX74SqrI0UWpMsRK8bSGugTT/YDC5
 lfw8tUaQLWESnSawzLkTmEiCRvcHpV6mPfKq0wQ2Hm21l1AqJNWWCQc2HcsEVq63I6P2
 om3A==
X-Gm-Message-State: AFuF++muWDAzxn2CWOryMgu1mY4VOJrh6zXcddg65wXYJvFYRq0VLjHQ
 wfD0J61lB0BUmnHLIsJv9hw/e2WvwF96g9JbFKSv3D52OFIC/kNqv2D9DlTQ2jZdoko=
X-Gm-Gg: AYBFou1LKz0bG4Crbqyc3GC9UHvvoGfogr+IT47SRbZhJH0qo8Wg2BeFKsw9p7kNiLr
 F89oyyTDqT/SIpWHTyG7+kDSgiZHHInxwSZWZL3Y2MyzxYVY0DEtVQtLJhGlD2+1ojUrUKRuXuK
 ciK9KrhI0MDOpB9+GB1XFVOiEE9QTsB6q4HEO9rTPW+g36OMAFcLIcBX8ZlKqhF0gS3xkvdM70K
 NulOP919ypnRo7n/Y3B8L3b5lqBR7w7qNjati4pfbTxWMD8cVeH/MJvA82Dpz7cQ8WGmiOmIyqm
 Ws680FshyMIbkUMNqJpKDw+GodqRBYMTEGPBq/iAQli88Xj8VfMfjRspdS2iqnpzxev1YLuZKn7
 JRaWVLybaOv/fxiIT9M5gi4nICAKTgiDMCbq0H4u+CvotkT82cAhrCf61M/PwrUsLqLJ44EEeKd
 3tOC1AYRF3UorgXfzSkQOFySiMnGHMZFp6+Gl72siElPXlxmNglIw+X/nqLUJ0uveQNqQJQoyrJ
 ADyiIKAjTTlC/2J6CDkNyI=
X-Received: by 2002:a05:6a00:408e:b0:87d:430:1437 with SMTP id
 d2e1a72fcca58-87e9d8da674mr14163594b3a.38.1790697713107; 
 Tue, 29 Sep 2026 09:01:53 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868d1d3fa8sm162115b3a.57.2026.09.29.09.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:01:52 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:01:49 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 08/11] tcg/riscv64: Return success from encode_bimm
Message-ID: <arvg5EdpRRCfqrUz@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-9-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-13 14:08, Richard Henderson wrote:
> Centralize the range test for this encoding.
> Directly OR into the insn value.
> Assert success in encode_b.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

