Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56206CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kBJ-00058R-HS; Thu, 25 Sep 2025 07:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kB8-00054X-B1
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:30:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kAs-0007nW-Mh
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:30:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso5870965e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758799802; x=1759404602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8Vup0Q61M8S6hCwZhwkkM5Ub4PCL6HuDPo5o7nxj7A=;
 b=vb2+/D4gQ1eLefHUh2j14oLVw/lN+2gwc4+m+vT4h9+Qw9NLYM2r1sb/xqQXE/2/C6
 8ahkJJ8B25aXQtacJyu+UB5YVwe7RP/Vr3c4EZEvDF5drsUQVPSGS/jFKoYJB96mwCE3
 bVYsch2YVLxIz7SJ83bW/dPk4i2fD0ZipF/XmS9CnWcvWJPUV5j6luu6SciLQCrnalpc
 EM4eWvihh46TeMk1lGDGS28dzap8PlSDZbMURC72mxWhNF2X8stsBmRLK4s/cGflxMWQ
 l9kJT6hzqF1RzoF8wYIihsgmfgzZMVMdyuYJU7w9wzHWNHFMTuloG/QB4tg9xyOVX1aN
 Gr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758799802; x=1759404602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8Vup0Q61M8S6hCwZhwkkM5Ub4PCL6HuDPo5o7nxj7A=;
 b=pvJ6Mk1R8PVs3c8BDx1UoTkEfipiQVuZVo1+PbaM4XU+sxr65yxsXwgF8xwrn5fnKd
 I4G1tnJ2q/Q+ahLg5tIH5NWZSNz00JcHUHdA4Tdi/qh8jlIi1B+6hmzCGug6FzVYtR/7
 OxMJRRPVravFC4F0uQ/VDYbTDtipZA3/gLoUdtKBfdBwImNhKyvYiz/be2dmZnDcKgAb
 k82ZINQV8oUoduHbc+qPeNBiRXsU+vMoyXABPFmTerecYS4itFYw3moGJhN8UWHe+lVb
 OftrGHMup83wkM4eWlPS4SyELvy7Naf4f39FivVeAuBsR7SZPpaQIaaoWiiGjj7OUO2a
 MLNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5jMxJCXNIDeOfZ72EvhxO2oXeEK11cpqih373IDiCI3QtUD3hor39oCr7qHJpOdm0sdFGuLW1ZoCD@nongnu.org
X-Gm-Message-State: AOJu0YyJbt80GvhAwRHry45s9QIfKMIR86sBu6eTKdfB95qJN8+bdWJD
 cBgquGmPO69g5Xij8AR8N5Ais4+h6p8yZB7K6MSdlogfEnHecp5U9chN6bw0REUL//g=
X-Gm-Gg: ASbGncu+C/AOLme4GuQoE1zIdFM3CRzg4ymtnkviiZ8294FjiNc5Ya5wT7JCXsYMlra
 wdQ+tznBqIXXDZNH44dQEt179b26gPtPkqu4BS8AC5JjMVZVUJ7Q39oXtl3qepgsSafmZ6mQPf9
 Sgbiit7SkyfOap9FFwKKfbsGVkxD6kGXu3CUqL/nu1Fi7NwCqGRuHj06QIDehaIwY0ZeFpG/8Bd
 pHikNogOUCRgJBwvSuMg5SvccwYe1so6Xz/Z3GwfgRr3LzzmyKySgmZVauHfPUaR8mwVRnwMvWA
 KCZkOaQSIfOLnRdYLzLmWusR4HMSHzc8sDKj5pZPZu0eXo3aqPLa4nVoZlQ2G37I5NuFMhqaobR
 A6BwqEnRxqkQoAj3MCZN4rx4mPt4gWjjfxkpkGLyRrk+NLA+GtefvrVxDlwXd9VmaxA==
X-Google-Smtp-Source: AGHT+IFtsyyRfhYblHgq6axwXWt7/za+nAbvZGw6pjwI7AdX11Hy1UVGDZ+XIL7WyQUP+SmYcutlmA==
X-Received: by 2002:a05:600c:1d01:b0:45d:d9ab:b86d with SMTP id
 5b1f17b1804b1-46e32a0bda9mr38571885e9.31.1758799802114; 
 Thu, 25 Sep 2025 04:30:02 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab62233sm74011505e9.21.2025.09.25.04.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:30:01 -0700 (PDT)
Message-ID: <c61a120c-e196-4815-9f27-0a5c763cb36d@linaro.org>
Date: Thu, 25 Sep 2025 13:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/36] target/arm: Split out redirect_cpreg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

