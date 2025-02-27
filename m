Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FD6C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 00:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnRwx-0003lF-Un; Wed, 26 Feb 2025 19:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnRwv-0003ko-UZ; Wed, 26 Feb 2025 19:40:25 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnRws-0000nc-Rl; Wed, 26 Feb 2025 19:40:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so5664715ad.1; 
 Wed, 26 Feb 2025 16:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740616820; x=1741221620; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nC35rUSHxde2fsI9rDS/mGVvfiZlI+Run3L9Ml5OZC0=;
 b=X9cDvglDeqzOyQfecmV5WnNgR/b4Q7diTQqY8PxUBrHaj43hWkVDOUmGUU0m+HsDCE
 8YPuYQ3hbrizDrYxgkMY01bSjuOwBJRYFcIK6pnEvvA15kWYR2Amzf4xu06Hme6XNqwH
 Ry1n3+vIhdaA5JDj93keOcXfCLNNlpPyw+R/TCn/KKcdfLFH4Av/kz9d/yCN2JgambA/
 uZZdzH+DK9aGL0u6m1RxPpK1BzUrK72YMijDq2AjVUtIxq8jAIxUzoWnJq2HmwImNcS8
 h8hQP++lWQRZSaaPfL0D2XTnB6WI/8Hen0Nl3p2PeXa4m48mwkGJWgFDQgd4ic31zGQ0
 yalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740616820; x=1741221620;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nC35rUSHxde2fsI9rDS/mGVvfiZlI+Run3L9Ml5OZC0=;
 b=v/ZlsK3ruqvuCNYQr1nyXDfxLB0kQjRzxacPFEcc51p92AKg8hiD7hQ5gxzWEIZBoa
 z/7TmPLoKEkM7hCxcRvGhLqtRTmJNc9v2BBTVUHBsBnIrvw9i+TAxMaZTVxtvaKQ8jbR
 N4vbEYtA/V0gB7UP7V7XibDcvuX84FJoIRceTlLaasVG+UsQCNDaS95gweocyaAXOJYv
 eu9XgzXZHAHC9IP5tTGQh/MAGsrpnMLa6XPFrjlSZHeDh2+o1uapwdnJvYoZxvqzYxSr
 CRjAEvD+pDjzVsLq93BNzBsN2tEsb/BSta+AP7J4Amnesly24exuevRZZAdO9Wd4Vfq9
 Yw7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOVQTLJ7iuxa4u8qHMS2qP5UGHCLB/OjaxjwKgCi9MtuT1wOP17RjUVX8WtDHNMH0QdiDkU8GiOJYa@nongnu.org,
 AJvYcCXyE7kEpaI6UuXD+Z+12qAU2Cuz2N2rp5+YVPalhLBFsXMuuIHWNCU0ALL/lgSy503nj4Qg+lxcQu4=@nongnu.org
X-Gm-Message-State: AOJu0YxhI+6H3/xE1+UK8rTttInprPBXUgoK2cHZhEMOsFIit2tYVosT
 4M4hc/16wFJh6/vbWsDXVzc6khxPq67sb2lRT2R14k9x+3crVyX2
X-Gm-Gg: ASbGncvizyJY4S3AZ15MpjnYuCPyXMAWo3OrDSpbQGDKUL9XXYf0SionB7JU7n5ZiGk
 BanLQAsfHpst5tan1JZu8M+bAeTh8ZpJDQIn7ZUCVCmR4S8k7xMnhjUC5Np1FNt+LuppSSN7S1c
 Wr5iDTPJYMfA5tO2uMESCCHdFYKRfsIIlpkSiF3aCsUQuiW+N+EvP03JQpCbUBCeBy2vCyXJC6y
 /2/BwXZPw8SG+/AOD1BAnlakJ4Q2rU7aQ4RJaIr0gDDkHO5KcvfbvNPHqwG87+3r6PPGM0+JPtY
 rHLczpa+QYscTvcV9Q==
X-Google-Smtp-Source: AGHT+IFCHgTmCLyi5RuBRu6SK6yA7H/NHsnYhWpOqdWuy69l9yHw32Yi1LAY0zU0ADJEq16aHA2WAg==
X-Received: by 2002:a05:6a21:900a:b0:1f0:e6dd:ac16 with SMTP id
 adf61e73a8af0-1f0e6ddac1bmr23433265637.25.1740616820415; 
 Wed, 26 Feb 2025 16:40:20 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7ddf2ac3sm164451a12.1.2025.02.26.16.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 16:40:19 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 10:40:11 +1000
Message-Id: <D82T5WDSNBE9.7KGMTED2XJG1@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Igor Mammedov"
 <imammedo@redhat.com>, "Richard Henderson" <richard.henderson@linaro.org>,
 "Helge Deller" <deller@gmx.de>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, "Zhao Liu" <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/4] target/ppc: drop ppc_tlb_invalidate_all from cpu_reset
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-2-alex.bennee@linaro.org>
In-Reply-To: <20250225184628.3590671-2-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Wed Feb 26, 2025 at 4:46 AM AEST, Alex Benn=C3=A9e wrote:
> The vCPU parent already triggers a tb_flush so this is un-needed:
>
>   #0  tlb_flush_other_cpu (cpu=3D0x555556df8630) at ../../accel/tcg/cputl=
b.c:419
>   #1  0x0000555555ee38c9 in tcg_cpu_reset_hold (cpu=3D0x555556df8630) at =
../../accel/tcg/tcg-accel-ops.c:88
>   #2  0x0000555555bc29e5 in cpu_exec_reset_hold (cpu=3D0x555556df8630) at=
 ../../system/cpus.c:208
>   #3  0x00005555558932c3 in cpu_common_reset_hold (obj=3D0x555556df8630, =
type=3DRESET_TYPE_COLD) at ../../hw/core/cpu-common.c:139
>   #4  0x0000555555d480b1 in ppc_cpu_reset_hold (obj=3D0x555556df8630, typ=
e=3DRESET_TYPE_COLD) at ../../target/ppc/cpu_init.c:7200
>   #5  0x0000555555ef28f0 in resettable_phase_hold (obj=3D0x555556df8630, =
opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../../hw/core/resettable.c:162
>   #6  0x0000555555ef24f4 in resettable_assert_reset (obj=3D0x555556df8630=
, type=3DRESET_TYPE_COLD) at ../../hw/core/resettable.c:58
>   #7  0x0000555555ef244c in resettable_reset (obj=3D0x555556df8630, type=
=3DRESET_TYPE_COLD) at ../../hw/core/resettable.c:45
>   #8  0x0000555555eef525 in device_cold_reset (dev=3D0x555556df8630) at .=
./../hw/core/qdev.c:239
>   #9  0x00005555558931ab in cpu_reset (cpu=3D0x555556df8630) at ../../hw/=
core/cpu-common.c:114
>   #10 0x0000555555d1ec6b in ppce500_cpu_reset (opaque=3D0x555556df8630) a=
t ../../hw/ppc/e500.c:785
>   #11 0x000055555595c410 in legacy_reset_hold (obj=3D0x555556e6bbc0, type=
=3DRESET_TYPE_COLD) at ../../hw/core/reset.c:76
>   #12 0x0000555555ef28f0 in resettable_phase_hold (obj=3D0x555556e6bbc0, =
opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../../hw/core/resettable.c:162
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/ppc/cpu_init.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 062a6e85fb..f987b75c4f 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7242,9 +7242,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetTy=
pe type)
>      if (tcg_enabled()) {
>          cpu_breakpoint_remove_all(cs, BP_CPU);
>          cpu_watchpoint_remove_all(cs, BP_CPU);
> -        if (env->mmu_model !=3D POWERPC_MMU_REAL) {
> -            ppc_tlb_invalidate_all(env);
> -        }

This invalidates architectural TLBs (software-loaded TLBs) as well, so I=20
don't think we can get rid of it.

Thanks,
Nick

