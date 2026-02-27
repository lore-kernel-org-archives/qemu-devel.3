Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB69FEFB58
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyum-0001X3-5k; Fri, 27 Feb 2026 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvyuk-0001WZ-GM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:33:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvyui-0006Bg-8Y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:33:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806b0963a9so71925e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772202834; x=1772807634; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zhksgfBBekPXJxvWmNFhtqq8ITn67s1ZAi/srfmIvRY=;
 b=f3UGci8cE5Pvlfdm/KDce6wXH1FebBMGuWI+NFw2QFwnjFqQBeIoZtLnb9YrnF2WrZ
 FS2SWin/c5Jpi4Es/v9DEM1Ib28RxB+I3BPlpQRjjBgXqpu63/23M2sRfNvpwg2EiHfp
 G+NGTO27b3uA2zs1od80pAmfSULy4e+3z/timD2c1pNbZuWSo+IVp0hGZrkf16owj1Mz
 sQV4o7ZMcmKMawQYLQmfjokoXWOEhDXP/wiiFYyq8PniqziY6F4dIh9q1vbUZ3ClFtlB
 PLXQC94wgtza3+VpZDIa5u8AeY+B5Mg7aNSIDyldkJdgB019miKkUmwRNqJ8UT9ZFWm1
 vZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772202834; x=1772807634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhksgfBBekPXJxvWmNFhtqq8ITn67s1ZAi/srfmIvRY=;
 b=kxQCGqmk6HocaTmxTGZnVQRHI07KOZYbsYnSfUk+JMwS/+7wg5jt4da9g583v5YfkX
 eYddYLrOshBdzOgX+iswVfpcW8bumMW1lfYb38oR9KKGWhZb6+nSnMoYANGTAroWJapB
 Up0/WMuHkt7aIxxGoVxqFMrhmrFsJQ3MV6Z4mGqIZVYyVl3LLa8Ehb4VU6LtXBHD7lYJ
 xLEzwdjnzw6HSYBANyBaBQSmyE10FipJs/Zg+F6tgf/inF3IB9IXpV5mjt3eUg4C9qMk
 ApHyMpQSzConG22ONxAmqqhMXlHrskEGHmLOMoXLfJlTgdQub533zmb26oTJkgV8S2CY
 0Z5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUnhF22drbJwLqtYYiy+C/gUcy93FK/I8cSXLzW1aalHg+IhGktNrqyFbk+sdoLtYlQUJh/H7Ev9W@nongnu.org
X-Gm-Message-State: AOJu0YxcUrKpf66FUYFnCMG6My8Q/+T/sIuMOrEXZ5QSEWCsKkTRy+Eh
 JY/Cr3z+3r5QdCQdNXV+EWs6qtFHfyPpoUG5VwrapjRyv25EhjpEvlAAmceVb0KAIQ==
X-Gm-Gg: ATEYQzw7F1xP9Nu4lVSpzLZNgUeRMWdHUtjavQu605022Rg18ZQECzpP4xZgGWBMZI3
 CfhwypwKbKUcKovotk9JLeTbhCvaej+or2l/2MgBw7LX4b0cRmP3RpZuNNIg64azRByxsSk5Sod
 RQBg55gIgG7hXS/KF/pAGCH5JQA0wcn/9+BzbUq6LUMhxT93v8OBnquBEBnqd0G9xA1LTYARHp+
 xv7q/5ZZcYu78oFJJKZzDMF/qg5WJv/Y0CA+lrDLtkqZmVpq39L94+/Ull8hHEnZKQ/guhHw4kg
 zUkYEhnv8u7WzzQSek+b2rBuT7NK4U70MVBi7G4tkigpeRPW2kUjKW739K5IvxKgjtD97M8CaJs
 R2G9GXpZwMH4WrORHDuUATOvFM2LAyuI4nW5Nr1+Ckfnj9nQHBJOS2++jW6zIn+OIHj+eFE3hni
 FBk6SvvQLTJ6Puy3vr9E1DRj4/DBmjOcyimVfpf9OnkkDV8QtPnUl9pmogcZrd4NJZ
X-Received: by 2002:a05:600c:556e:b0:483:1093:f29b with SMTP id
 5b1f17b1804b1-483c318881dmr1468245e9.8.1772202833932; 
 Fri, 27 Feb 2026 06:33:53 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b4410bsm118970925e9.6.2026.02.27.06.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:33:53 -0800 (PST)
Date: Fri, 27 Feb 2026 14:33:49 +0000
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
Subject: Re: [RFC v4 03/31] hw/arm/smmuv3: Introduce secure registers
Message-ID: <aaGrTayVy-m2Ttf5@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221100250.2976287-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:02:22PM +0800, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers for managing
> secure transactions and context.
> 
> This patch introduces the definitions for these secure registers within
> the SMMUv3 device model internal header.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/759ec110-365f-488b-802d-c7bb1efe30bc@redhat.com/

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  include/hw/arm/smmuv3-common.h | 70 +++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 9f78bbe89eb..c40fa46fb88 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -269,7 +269,7 @@ REG32(CD_5, 20)
>      ((sel) ? ((cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, NSCFG1, (v))) : \
>               ((cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, NSCFG0, (v))))
>  
> -/* MMIO Registers */
> +/* MMIO Registers. Shared by Non-secure/Realm/Root states. */
>  
>  REG32(IDR0,                0x0)
>      FIELD(IDR0, S2P,         0 , 1)
> @@ -356,6 +356,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
>  #define SMMU_CR0_RESERVED 0xFFFFFA20
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>  
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)
> @@ -414,6 +415,73 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +#define SMMU_SECURE_REG_START 0x8000 /* Start of secure-only registers */
> +
> +REG32(S_IDR0,               0x8000)
> +    FIELD(S_IDR0, STALL_MODEL, 24, 2)
> +REG32(S_IDR1,               0x8004)
> +    FIELD(S_IDR1, S_SIDSIZE,          0 , 6)
> +    FIELD(S_IDR1, SEL2,               29, 1)
> +    FIELD(S_IDR1, SECURE_IMPL,        31, 1)
> +
> +REG32(S_IDR2,               0x8008)
> +REG32(S_IDR3,               0x800c)
> +REG32(S_IDR4,               0x8010)
> +
> +REG32(S_CR0,                0x8020)
> +    FIELD(S_CR0, SMMUEN,      0, 1)
> +    FIELD(S_CR0, EVENTQEN,    2, 1)
> +    FIELD(S_CR0, CMDQEN,      3, 1)
> +
> +REG32(S_CR0ACK,             0x8024)
> +REG32(S_CR1,                0x8028)
> +REG32(S_CR2,                0x802c)
> +
> +REG32(S_INIT,               0x803c)
> +    FIELD(S_INIT, INV_ALL,    0, 1)
> +
> +REG32(S_GBPA,               0x8044)
> +    FIELD(S_GBPA, ABORT,     20, 1)
> +    FIELD(S_GBPA, UPDATE,    31, 1)
> +
> +REG32(S_IRQ_CTRL,           0x8050)
> +    FIELD(S_IRQ_CTRL, GERROR_IRQEN,    0, 1)
> +    FIELD(S_IRQ_CTRL, EVENTQ_IRQEN,    2, 1)
> +
> +REG32(S_IRQ_CTRLACK,        0x8054)
> +
> +REG32(S_GERROR,             0x8060)
> +    FIELD(S_GERROR, CMDQ_ERR,          0, 1)
> +
> +#define SMMU_GERROR_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
> +#define SMMU_GERROR_IRQ_CFG2_RESERVED   0x000000000000003F
> +
> +#define SMMU_STRTAB_BASE_RESERVED       0x40FFFFFFFFFFFFC0
> +#define SMMU_QUEUE_BASE_RESERVED        0x40FFFFFFFFFFFFFF
> +#define SMMU_EVENTQ_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
> +
> +REG32(S_GERRORN,            0x8064)
> +REG64(S_GERROR_IRQ_CFG0,    0x8068)
> +REG32(S_GERROR_IRQ_CFG1,    0x8070)
> +REG32(S_GERROR_IRQ_CFG2,    0x8074)
> +REG64(S_STRTAB_BASE,        0x8080)
> +REG32(S_STRTAB_BASE_CFG,    0x8088)
> +    FIELD(S_STRTAB_BASE_CFG, LOG2SIZE, 0, 6)
> +    FIELD(S_STRTAB_BASE_CFG, SPLIT,    6, 5)
> +    FIELD(S_STRTAB_BASE_CFG, FMT,     16, 2)
> +
> +REG64(S_CMDQ_BASE,          0x8090)
> +REG32(S_CMDQ_PROD,          0x8098)
> +REG32(S_CMDQ_CONS,          0x809c)
> +    FIELD(S_CMDQ_CONS, ERR,           24, 7)
> +
> +REG64(S_EVENTQ_BASE,        0x80a0)
> +REG32(S_EVENTQ_PROD,        0x80a8)
> +REG32(S_EVENTQ_CONS,        0x80ac)
> +REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
> +REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
> +REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
> +
>  /* Commands */
>  
>  typedef enum SMMUCommandType {
> -- 
> 2.34.1
> 

