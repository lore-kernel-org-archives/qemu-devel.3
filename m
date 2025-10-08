Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800B2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wh8-0006ZW-V1; Wed, 08 Oct 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Wh3-0006V9-AS
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:07:11 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Wgs-0003Ya-CQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:07:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2698384978dso55014085ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759939610; x=1760544410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/KzeMzMaVebiMpJtZArWw7Rt8GAfiL1jUV3M0iqnQLI=;
 b=ajNIysRLCLPJ2zoGLZTw1saaNvxZnmh9PA9FBXveun4c+y3UzkWBYUQrLvTmt593R1
 23iE/QOjdtXqsoaYHIaEa/hFGdddO2s5g8WO8fXhtxNzolJzHKAC0uiSqQwVfk3VaBPy
 nfBD7zkgpWK9yVMAPA44sNVweY/nhNGDveZjb4vC+2durt0vKexFQet+pAE2yYF+XOSF
 MVRCBYWAQuFX3+alBu4npH3HmWFDrTH5jUHTb/Sen8B1AEJ44L3TnjX3WY78SmWa+rJA
 ZAtWpUD4n8fUzjCsUnszT3gJXG6f7KfFfLvVD3p9JKFdOGSzo6XDpwfqpQpPs5N5Pl85
 cSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759939610; x=1760544410;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/KzeMzMaVebiMpJtZArWw7Rt8GAfiL1jUV3M0iqnQLI=;
 b=IWD1+0mLSYNFEgNltul//mzqqGcmYXNPyd12nZxrsfqltdQ88mhfjxsq3JcEsYbYit
 nW4kIR3jilYnD0AYPjjCfVleC6L0T4O2hQDfSGD3uCl7XGzZMzvQuR8YrgPa6yRD0Qcs
 owU7aHtvISLmT8ynn/aCPgoC3deXl9lAUw56NTR7dUyn+d8pkcRFM5EJKCO1YZE2FpkA
 wQ8TnfYJs2HYFhKrpb1aDbaB7IsBEPw7zLvlilZx8bUPwAy/Brb1MiROSfUk+VB/B1ju
 4S1T7xaMKQA88f5Hynku7IWg8FRteHeGF2rXU3HuQiEIdRk1IuijAVQDxEkmbUUC6AlM
 Nluw==
X-Gm-Message-State: AOJu0YyQ6SHddWzJn57413xcvdLDylLdTnW92vwp0hzecFpOA+EjOzMD
 ui8BghlrSjMOJwsMW9GMVkP1m8pEkKqilcGy/X2q7r8zj2KxT6xLimmy3urLaL8vtGf1RqV1mQK
 M3O/DVZM=
X-Gm-Gg: ASbGncvv4rhwg9n+dBt8DBRSzf8MzxgnADmHZNlahVRJBUY2i179lZ43MtFEsnkcN4D
 Ww9M5XdOXR88sy4fLxGaAX7uI6TMwkcLPBbLXtVCO0EgJnH2ioCkgiWMMPsdSwsZtzryDPNSb3t
 eeheADor0xtAN+0MYFPMo4S6HsIIC8jl9lnZ/XslgTaL0bUQ07YEJJRqkyIbbsgpeyJRaqjYhkX
 Vl2E5EzFvNCg9h91vFByElO7gBh4qVomj8Z/5Cb+uir7PeTM1ttrZSUbQnG+Bw8Sr4oV0ziYeBW
 QAAI7sxrOdnVQ2dR+gbPLThPpa3ZlfavbTJa+yp4nBYBkDFoEexCxyc+WE6qgmZ4AHvTS3FcWPP
 +UbEWTB3amz/47Caac4SuJ2x36YaHqFiCzFih3wpEPA0fSjf2PvaSPy9/xVM2zScw
X-Google-Smtp-Source: AGHT+IHJIH67G11+nvh6Ggd2l3IdrvSP3ks5pHEGcGPZpmmKzfVV4veRrG7Z5GBoyXAmrfKHKWRKnw==
X-Received: by 2002:a17:903:3c4d:b0:269:b6c4:1005 with SMTP id
 d9443c01a7336-2902730331amr51087375ad.55.1759939610243; 
 Wed, 08 Oct 2025 09:06:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f8f9e0sm1164655ad.120.2025.10.08.09.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:06:49 -0700 (PDT)
Message-ID: <50578062-8b7a-4286-a154-eebf05f3be3c@linaro.org>
Date: Wed, 8 Oct 2025 09:06:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qobject: make refcount atomic
To: qemu-devel@nongnu.org
References: <20251008152701.411964-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251008152701.411964-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/8/25 08:27, Paolo Bonzini wrote:
> @@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
>   static inline void qobject_unref_impl(QObject *obj)
>   {
>       assert(!obj || obj->base.refcnt);
> -    if (obj && --obj->base.refcnt == 0) {
> +    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {

qatomic_dec_fetch lets you compare against 0, which makes all isa's happier.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

