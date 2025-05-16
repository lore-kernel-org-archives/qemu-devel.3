Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EC4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFie4-000227-9g; Thu, 15 May 2025 20:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFidz-00021h-KF; Thu, 15 May 2025 20:09:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFidy-0002mB-2S; Thu, 15 May 2025 20:09:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-231e21d3b63so260795ad.3; 
 Thu, 15 May 2025 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354180; x=1747958980; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocnvwW71WARKLiiMKZ8ACXqzutCJ7NX1ER8C/6g3n4Q=;
 b=ezb+9UT8BaLizS/tWk7zr2QsgYwtOu8H30KObIh8Sl/vfPhvri8fKI7ZPNi/QxIQOI
 SEvN6wsDJkl5Lu/+1/y+s12h5Xe6gd91iVOc4G5fHuR20yDgnKQYX4sb1PVirSmwQx+A
 eBL7RQLENJIJv/CneFnASsJAkZGDU5VmZJWrVuugazyY2CpYJw3MW2xQYOVBATb7mOeH
 ZtY4ww3M8lwUoMubkAO7aCDRyfIlqm9NJcYL8/7x90WnBHUJC+0gEfe1k7QRlu0VvTM4
 Q+bhh2LroCckKJPjSH8UxyPOg6Q1DALlHQ5WVsizkzW2w6AMPyfHerwRWYVKWaAHCOdQ
 ndyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354180; x=1747958980;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ocnvwW71WARKLiiMKZ8ACXqzutCJ7NX1ER8C/6g3n4Q=;
 b=OfOfWcZhyQ2YMIbXXMCb7atC4k0SeysUsRblfhRkENj3o4eMJNfNuJV5/yMFI53V1N
 Mh/G9wulaW7nbrsWvKwtWaN/NRoN747ysP9jUTH9LY4pvru1tn4FigRSV9c/zj+YwmSS
 JuaB2HoG7Wy6rhoEb5TV/Se0Ub8pMcWKZt1XgvEVK5VYhp2Sl+pprnGhbPtlHoWt+Mrs
 nUoe7CvFO3cjiH1oj02fiNwgiWciV/hHFLK6ZAkTm8dmI70cvlblp9aPpdW6ooLa8mSU
 zeHmcK7PC33VQ0He5Yt9/bFsazI36z0hOYK5z9UY9HKrnYGVhm5uZc0mEQgqs32LerUf
 HhjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSEarQgvXMLAI5tiKgVPSF0e+aIa2l6BhXym1Bwlr9KihLYF7LkVsquyyJw0ntcKZfbX4suCtunw==@nongnu.org
X-Gm-Message-State: AOJu0YwfCJHwRGHW22Yaxj2MPVUAJsYAft+cnRmSOnSra2Ka111k+87G
 YxcIs38Qfj2AXTYEe2CTqv4cW0MKP6c4zjqWlDQXCKEi2IwUyPUbIzCe
X-Gm-Gg: ASbGncsYaDVfB4FV/ZTK605N+vMH/hcyFOFZOsBAVl6HF4haXiNjC/oHReX1ybd1eLd
 lDxZ8dNiwsQkVLF3Xxxhant8XNqsxmKiUx6zt4aARuXlnb4j2nYXJWq1/3BuxfwZoJXZ5s8/pqP
 WCXMlBkOCAUHM+7Ux4N4aI7fHfbIX2iVZw19EhrTTWnvJtRKmlh33SQUok9wRktGSuae0HEOX7O
 kFi9czrf7+JITK2ih8IctCmhot1Qy/+Mc88lT+xXkgm7Uz0IemBcqwQLj3glfg0i6VW94Xkf0bA
 Up+Pnuq6+cbn/oePS0PERiXVfPxvkC/ycVZr/DNQRBV9sFRWiifHZgLPJw==
X-Google-Smtp-Source: AGHT+IHbRWAq7fqK9vWjb0yncfOz5IteslYgjKDXSJ1Yy85xkydHDm99CkUrAzXAIM/gOMqCaywoqw==
X-Received: by 2002:a17:902:fc46:b0:231:bf74:e1df with SMTP id
 d9443c01a7336-231de3515demr5421705ad.7.1747354180167; 
 Thu, 15 May 2025 17:09:40 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adbf5esm3496315ad.64.2025.05.15.17.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:09:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:09:34 +1000
Message-Id: <D9X5CY1IQZF4.28L6OUCI185IW@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/50] ppc/xive2: Reset Generation Flipped bit on END
 Cache Watch
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-8-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-8-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
>
> When the END Event Queue wraps the END EQ Generation bit is flipped and t=
he
> Generation Flipped bit is set to one.  On a END cache Watch read operatio=
n,
> the Generation Flipped bit needs to be reset.
>
> While debugging an error modified END not valid error messages to include
> the method since all were the same.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 3 ++-
>  hw/intc/xive2.c     | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 30b4ab2efe..72cdf0f20c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque=
, hwaddr offset,
>      case VC_ENDC_WATCH3_DATA0:
>          /*
>           * Load DATA registers from cache with data requested by the
> -         * SPEC register
> +         * SPEC register.  Clear gen_flipped bit in word 1.
>           */
>          watch_engine =3D (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>          pnv_xive2_end_cache_load(xive, watch_engine);
> +        xive->vc_regs[reg] &=3D ~(uint64_t)END2_W1_GEN_FLIPPED;
>          val =3D xive->vc_regs[reg];
>          break;
> =20
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4dd04a0398..453fe37f18 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t=
 data)
>          qgen ^=3D 1;
>          end->w1 =3D xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
> =20
> -        /* TODO(PowerNV): reset GF bit on a cache watch operation */
> -        end->w1 =3D xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen)=
;
> +        /* Set gen flipped to 1, it gets reset on a cache watch operatio=
n */
> +        end->w1 =3D xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
>      }
>      end->w1 =3D xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>  }


