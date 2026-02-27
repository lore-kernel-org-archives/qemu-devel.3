Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81010FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvysn-0008MP-4s; Fri, 27 Feb 2026 09:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvysl-0008Kv-9p
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:31:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvysj-0005Sg-PT
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:31:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48318d08ec2so53345e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772202711; x=1772807511; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=shCYqmSdXCxn23sCD8oFt+dd0Uq8uFWP4FigwjZC8/o=;
 b=EOAxkdrD85aXrc8DdG5y7V+VUneBW6ualGMwlnG3ERqHLEL7uMe7tcT39JpWKa9/vT
 UbKDk6apDQoLXDi4VQmstMo8W/moUi274GmIK3B4iR2RDie4SV8fxQN8iUW2ptvHOuEq
 6VAf7A7hfoYmb0Jte3OCZfIL/TmvGG+fb3A1mdk7gCtJWvkPUyJ8JSJf4cp7Lwv6AbPA
 tPhQhpqsQ7CYU0n9fE18pk83GdPYQo/gFYMIsaS3tU5kthhbCj5IgYGmTvpn7btRnC7A
 4Cx16C0ETIqWxHpGpyeJ6qGq2wPOS/2EAGbAOdRGaDsJ7MceM9wSI8u1y8DG/04PK68A
 5idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772202711; x=1772807511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shCYqmSdXCxn23sCD8oFt+dd0Uq8uFWP4FigwjZC8/o=;
 b=dfmqwTMyPvQPGfnDazN/Co/kDaZIDiSWxICwOG242r7Z01SGX39wHTgPYoqE+fJ9ag
 DG1+FzMtNmRCg4xBSfh61YxL9nfRSjstm6PJbeKPAazYmVqzIlVGjB3XzIj1/ZDFFIR6
 iPkBXV06F/jO5F/RW9jqeUUU2QNHD4esBrn0upq1/d9rBCTsUfYD3LtMh+gL5uQHgYXT
 YlX25/KM81B4HgvMxfQ5KFUILHfKMT3YeiyN1N9/OT3iN5csYaUGenGcc2EPlgESW7ZV
 ghMgEC1C5EPY8CGfZf4GPpoh+pF62iZI7ozfaMu27ig4hm03BHSVA9s/m6N+xQv1pdsm
 nKPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdSyP/3/Q7Rtsam6KT1d0hDbEQFaXzc96AjxOkKaOBK4KNMQsBmbHcZV+t4JTYR4gEzuZjOU2XHPfH@nongnu.org
X-Gm-Message-State: AOJu0YzIHA/fTurgjGWMxZvTwNa1g2WFFvb4abDp8PIO8tvhgpwbJgVZ
 WrzOhG43AMaBLTlGRjGOYbXFwQss/s3qYf9qwis2B4D87V9ckq3lsDv+W3wu4GDVwQ==
X-Gm-Gg: ATEYQzwki1+5QqiwYJHzFeNMAeODkfAjBXR8SiYG2FPvDOQczfl80P7uBSYSpuZ9f7l
 3Udjm7C8nfvwgMh0Nmnt7KxLGNSM4mWkpUhIYssm20TfoIIOG8fK95D4qI+RNvbTcOD/GGmaZan
 +hvOPYox9u+C/qP2VS71xy1KGtTk4+ag3OjGrm5SoJace3YzhQ6Dn3I2JZULuz8I0BbbyThnbwM
 966BlKBXI3LLVJ/1yeJfJcph3fmGRJrpPdQ+7sN7TkAW5pAVnMFrGbhd043W6nvmmaSqM832QP5
 zGuaHE+pEiFt1MWtH89Wi7H9ytvO0AyCcNBkTjlpuxhfLnzfqUn932WW4/tUQa5v3Y6gUpAVHOH
 xUKWodtLwmkrnR87vbEKbX04LIN7RzNJ2jo64B7KY2MIUh/nZEihG/N/fniqgQ6zpqTqdMqpY51
 /n5gRLpL/FLabfpk53gZJl8RfW4Fbz4sGQ6Q7NaUeyE2ubSRCgV4nzC9w9kOgeJ12Y
X-Received: by 2002:a05:600c:6a19:b0:477:563a:135c with SMTP id
 5b1f17b1804b1-483c3127805mr1471775e9.0.1772202711197; 
 Fri, 27 Feb 2026 06:31:51 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm199871075e9.0.2026.02.27.06.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:31:50 -0800 (PST)
Date: Fri, 27 Feb 2026 14:31:47 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 02/31] hw/arm/smmuv3: Correct SMMUEN field name in CR0
Message-ID: <aaGq07xFsR6FoRhS@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221100250.2976287-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=smostafa@google.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:02:21PM +0800, Tao Tang wrote:
> The FIELD macro for the SMMU enable bit in the CR0 register was
> incorrectly named SMMU_ENABLE.
> 
> The ARM SMMUv3 Architecture Specification (both older IHI 0070.E.a and
> newer IHI 0070.G.b) consistently refers to the SMMU enable bit as SMMUEN.
> 
> This change makes our implementation consistent with the manual.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01270.html


Same comment about fixes.

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  hw/arm/smmuv3-internal.h       | 2 +-
>  include/hw/arm/smmuv3-common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index a6464425ec3..ebdb4ebae67 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -41,7 +41,7 @@ typedef enum SMMUTranslationClass {
>  
>  static inline int smmu_enabled(SMMUv3State *s)
>  {
> -    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
> +    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
>  }
>  
>  /* Command Queue Entry */
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 2df54ba60f9..9f78bbe89eb 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -351,7 +351,7 @@ REG32(IDR5,                0x14)
>  REG32(IIDR,                0x18)
>  REG32(AIDR,                0x1c)
>  REG32(CR0,                 0x20)
> -    FIELD(CR0, SMMU_ENABLE,   0, 1)
> +    FIELD(CR0, SMMUEN,   0, 1)
>      FIELD(CR0, EVENTQEN,      2, 1)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
> -- 
> 2.34.1
> 

