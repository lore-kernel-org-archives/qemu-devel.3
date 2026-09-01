Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDACC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1P9H-00033z-Mh; Tue, 01 Sep 2026 10:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P9G-00033i-TY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:07:38 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1P9F-0006BC-7E
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:07:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a5dce0aacdso11016a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788271656; x=1788876456; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AEt1qZR6SklRukD117ZdbyRQvFGvQ34bNaz4f4Ccpyg=;
 b=VjmlkAxTZqKdOJl4BpWWJGIHhveX8+OktmdYjxJ40IoZhGMIWA4mYslrjb8bC6CQP5
 ZLbwsxJxOz13gk6MYdEjQn2FQJjmAR8ABZTXgyT/YWCE/3cA07yLE/iC2tnyzLIzdZdm
 kTdCT6z9HURHFaXzAdSgAVd8VnOZZKx3p+OBnPekxP+PiiGi9GupAchP6yBGOVGnA2vq
 CTPZKYOCQPn3Pw5TEiv/toAOIa+UZ3wvSHNSqQAoX4ngoo/O71YNnT4CFgWjCQVUeFNH
 jDfuyc8z6FdFFNSXWCAhHugRQjFIJ4MkUicGJt7SoZBXpig4jCFgYhbgXcynIx9FmQHV
 t4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271656; x=1788876456;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AEt1qZR6SklRukD117ZdbyRQvFGvQ34bNaz4f4Ccpyg=;
 b=ZAS8nkFkFrD7KDlBa8iZWvE4MnhOETUGvi1az0jJgjTrqyi31hb7P23MQtpXliBUcl
 vtZiYRSkqoz20/rhrY2MenoeJ3zuI7ZNM4Y8+qP4NCErNvxopO41j0RgmoMPg5xr6fv9
 bMpfjKS5Cbt2+MCc5aXL6IzQlZp9VrnmSNWZGBuLK0rQL/YHtk+tsB+D7FzcotT5p6/n
 e1wXJeZy740KwSHDBmcQPGqLoZWG4bioTQlm3OwAlpmCjOsG8SkylMZa7glkr+mI3hE6
 w+1tdmLHu37TxDC4EgBUgtCUKTeo6IeK9bck1iAXdVkZF8JTO8r8h+NR8AcFBdMCuVa+
 W2PA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUYZ9xKPxY4TL3aLEFCtRAX7g9gw1foQbGjPdvArg+5i84V366lZLLePT2aBOUR5qghxFVeuq9gGMl@nongnu.org
X-Gm-Message-State: AFuF++mmnajvVR4iIYKTMBG3yAaTFmtI8PxanK8AE1o4whlF8ZB2hnrZ
 vAIP3/HuhCXHDuCz3YyoPlPZnRyVife0r3z8OQPGnMEym1wrhCjfA/HR8a7JQZ9jLg==
X-Gm-Gg: AYBFou3W8LMosMOehPhX7jlREthp1bjLhwXgfD8mxMYBqgli5JHWtpQSlP7tE6b+o1u
 nG6ERkP2tZS44z7QXkloF/zk5fkb7Xlk5fPwavqlquEUShKAS2G/xHKJ+5gk4MlwEG0zTg7BnWV
 9T5d/6D18e86qGtR5whHKCkJbeTlW31OU1G3SbAAShwh0hZlV5HDY4bWIGgitR18QX9oNHF2pCw
 NmnPW7Zt477ycCxMvueU/5+zwv3aRajqmsxz89x5ZefsHpbdkDPHwv3L1fJnvXlu+lpO4J9+dv4
 3OA19KbQ2dhfLXvfdeAPz5kBupCOpyHzryh4BBsXz6ucxrXrQd4/rgic7TC1r+AL/D3DpbfL0XO
 YMy2r1uHzhllrnOHCpUp+8xQLHxNvMdojy3P38JxHXoNNbymkqZWNY69Ko9YxE2VOkpAxjYXdXp
 2Aj+1qQYRiNJH4mNCFyEmybTtlOcoRu9pWfMgoh3LzAZzFQjtE7iMfrQ85q+FQQWCePg8bptusU
 nQzRNSEYB0S/9Z0bGu2Ju5NGuFbJA==
X-Received: by 2002:a05:6402:a2cc:10b0:69a:df95:f1f8 with SMTP id
 4fb4d7f45d1cf-6a66a11c4e4mr41527a12.2.1788271655366; 
 Tue, 01 Sep 2026 07:07:35 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67c74bf97sm262117a12.30.2026.09.01.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:07:34 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:07:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 10/28] hw/arm/smmuv3: Store CD NSCFG in TT info
Message-ID: <apbcI5qqD6UX5Als@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-5-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-5-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=smostafa@google.com; helo=mail-ed1-x52b.google.com
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

On Fri, Aug 14, 2026 at 12:24:46AM +0800, Tao Tang wrote:
> With NSCFG definitions in place, record the per-table NSCFG bits
> in SMMUTransTableInfo during CD decode for later use.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  hw/arm/smmuv3.c              | 1 +
>  include/hw/arm/smmu-common.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a01175cc672..6b34f76f11b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -881,6 +881,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>              tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>          }
>  
> +        tt->nscfg = CD_NSCFG(cd, i);
>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index bd83648b14c..1aa4e3208da 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -83,6 +83,7 @@ typedef struct SMMUTransTableInfo {
>      uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
>      uint8_t granule_sz;        /* granule page shift */
>      bool had;                  /* hierarchical attribute disable */
> +    int nscfg;                 /* Non-secure attribute of Starting-level TT */
>  } SMMUTransTableInfo;
>  
>  typedef struct SMMUTLBEntry {
> -- 
> 2.34.1
> 

