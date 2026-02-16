Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B428E63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 04:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrq7c-00079i-NB; Sun, 15 Feb 2026 23:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vrq7b-00079a-EU
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:22:07 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vrq7Z-0007LN-TY
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:22:07 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso30724325ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 20:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1771215724; x=1771820524; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UPtvYvo3oBZAyRQ3R8uqN10Kj/HU2IQzarntP1HMPP8=;
 b=OZ1IPDP+VGDksiL4T0DWfowOKLTTzFVyazPvNkwNoEoYMP79oKHdzPKDgdOBqktxNv
 3NBp7cllR2qXu97f5tRQJEPmPDnxft9oF+ik7WkGXJFzjKz/DPXLcBy5BSt1LzHQKb/5
 3yboq6JEnziEn84VvI3C+jptqTLAXdBDpzaqxdp7VXme3ZSqT5rdw/uYNhNz/PKp+5Jr
 cul/3XG0HkOzltFNCHrKYQPfUYUhi4v5xGMsHNZtC1AKJUdZOlOQYLVR2F9LPy8bLdNE
 i1vX7tWruIHrLHiyEVUeu/fpPgl5uCFKWfqZAxgtX0wVhhEwKCLmvFjJ4TCorg0GfAPP
 n+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771215724; x=1771820524;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPtvYvo3oBZAyRQ3R8uqN10Kj/HU2IQzarntP1HMPP8=;
 b=DvltXJT1wwNSEtu6mhhtaYtDID0qyioZbB4+rs9Sn62k76fy4C7mS+BsxHh7+xDh7J
 GSno4OWIR8MBsjsm2q99XIMCjCIysVUtZoUrw3OscSaTvIcMbdvxgzWL2MOmli5a+EfE
 kaBknjwXDrvqOp1OtuE4LOnRC9AjXl9sBAxf7aQEy959gUsp/bdIyToRSjUFWZRZSY1u
 wRfexr35zYzUhtxFaVcFaQr8VO1nRU4Y45Fx6S1Sx4O1JWqRhMRsSLRxScgSThe/sghy
 slEUbdOaPkaVqwMo/7KKG9ta3YLC+TAiq5NTiPIpOodA/FVMZyZ7/81dzsxX2Q8ZzytD
 cqFA==
X-Gm-Message-State: AOJu0Yw8/ZiEOD9Eiohecxdq3wo7seQbmnZ96IaF4Ap8I/xL8QEDu+1g
 eMsTe34KOhZPoqKU42dBg9ZXXrDjZ04jw33A/WKvXd9o7NZk0y6MRv7kG25GLCCYims=
X-Gm-Gg: AZuq6aKXEP5ak6eksO3H86GitUFJIXm934TkuKjuSyxBAuj0RdGC52HiaIpsDoaLkEo
 FOhScajcZHmcJBJxVnaix55F9I1lqvmaUV7dI34lO5CVX7djM5lDdYsCo4NFXKEW1mWvZlyP1rb
 kCkk0iLkDhZMwgLnUScAKI6hKhbqUidKUPEl5r1v35TlrzSsGKtuBbAhjCRrHTPpklzMVcXdmjj
 +QarirBpdN4bhremuT3busBbeBXEbg2ah0QBkt/Nr4dAqH297fZLy7f6YELx32Cy5gb2jxvIKYd
 j98JX2dVyi1ZKeOIz2PLIs3fn2O3yivQJ5gV4zVvVP7G3fVGT15AgwYBBWtvfc4fTXjf3ENQQZ2
 eOLQ47nvN1Arh/j0tYaeCTub8q5GcdmUnyJgQel0Y5Qz9lifsOUjRDtBNoGAo3OFjwF/m2phuir
 8p8z+5bNJV0/NMLNsB9t3KthOv1wrnBs7mTyopZG612D1EGUFD4LwXpplt7dIgqJOS
X-Received: by 2002:a17:903:8cb:b0:2a0:8be7:e3db with SMTP id
 d9443c01a7336-2ab5050a113mr95895135ad.15.1771215723872; 
 Sun, 15 Feb 2026 20:22:03 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadbb9bsm53015975ad.62.2026.02.15.20.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 20:22:03 -0800 (PST)
Date: Mon, 16 Feb 2026 12:22:00 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
Message-ID: <aZKVxean7S9fkHHn@sifive.com>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205111622.461497-9-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
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

On 2026-02-05 21:16, Richard Henderson wrote:
> index 1e1bbb14fd..a45873c51f 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -360,6 +384,12 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>                  }
>                  break;
>  
> +            case float_expmax_e4m3:
> +                if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
> +                    partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
We need to sync local exp here liked:
+                      exp = exp_max;

> +                }
> +                break;
> +

> @@ -459,9 +489,18 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>              frac_clear(p);
>              return;
>          case float_class_inf:
> -            assert(fmt->exp_max_kind == float_expmax_ieee);
> -            p->exp = fmt->exp_max;
> -            frac_clear(p);
> +            switch (fmt->exp_max_kind) {
> +            case float_expmax_ieee:
> +                p->exp = fmt->exp_max;
> +                frac_clear(p);
> +                break;

Thanks for Chao's notification. Here I missed the saturate checking at v3.
We need following checking flow for E5M2 when when float_expmax_ieee.
+                if (saturate) {
+                    p->exp = fmt->exp_max - 1;
+                    frac_allones(p);
+                } else {
+                    p->exp = fmt->exp_max;
+                    frac_clear(p);
+                }

> +            case float_expmax_e4m3:
> +                partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
And we need to shift frac to packed format liked:
+                frac_shr(p, fmt->frac_shift);

> +                break;
> +            case float_expmax_normal:
> +            default:
> +                g_assert_not_reached();
> +            }

Thank you Richard for this v4 patchset.
I can pass Chao's test and other test with the fix modifications
suggested here.
Could you please let me know if you’re okay with the softfloat OCP FP
conversion v4 patchset containing the OCP FP classification functions?
(e.g. float8_[e4m3|e5m2]_is_[zero|normal|signaling_nan|quiet_nan], etc.)
If not, I could provide another patchset for these OCP FP classification
funtions.

Thanks,
rnax

