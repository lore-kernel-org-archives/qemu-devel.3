Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A139C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HTv-0001BF-8M; Tue, 07 May 2024 05:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HTa-00012o-3c; Tue, 07 May 2024 05:51:10 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HTX-0004K0-CL; Tue, 07 May 2024 05:51:09 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-23f0d7d2ce6so1659707fac.2; 
 Tue, 07 May 2024 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715075465; x=1715680265; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TiMMWoKIHumqK/XUPSQgWDFSfAVDNvuNNXSCJAkdlUA=;
 b=meMP+hvjZPtz2oMoEp0D4oTju0XqHDh+18+ishC7sKF4Z4ehp7h/jG0VPyr1JjD0DA
 rE85pLaUzXgYYRnG21q/NXM2EpSuDqxKHlq0LsHldiXc+WHL2u+xYM+e1RzzHOwAtzCO
 kLwqRNQ18ZVNdXhgTskz+SL+r5thTgdA4J06uqJu2j3J8V5Qk6ik1US3vNlpc7utgfBY
 Rbm3ip0izG9d6Xt6VlTgLsp6vNed7kqhO2l8AjXWtRszluA4TFA6w7PPIl1oPHjBp7Xw
 iDTkn3M5JBlX+qZ0ATmMhxy6Tw/Aqwbwb43bTxv/NY3rkvTFXyqTGZYYduioTEO1kVvr
 Y7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075465; x=1715680265;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TiMMWoKIHumqK/XUPSQgWDFSfAVDNvuNNXSCJAkdlUA=;
 b=BoBZOdMV6SAeVCtRQ2VWr4sog8t9bQjcpWXbrOcg9Fps42sLiLybcoTgsBJsjHKfUw
 YPOhyY4WJfkwX/qwyMkgr8xNdiu1yDgSprwHb00RkMDeZEJpBvNvVYE+q005Grnn7Co5
 ttW+th5uIbCRUjzU5vv+mLO5uNaf8B9w5Azdy53ChfA0NBQg1jg+ia/HkeV4QS/naVO1
 u6Y5MqyA/ULL9AIIBSqOHQgxgmNOC1OZ516qT4tWlYev/9G1QJ3uU8fAbUpA1QM0xNXF
 vQaymiqWNZbzB4pd7MAjFknanDa7qO/DuSe9K4zkggHdx53PId5m9A2a49KC/uHvCOe3
 dqIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWsQ6W/zZziAvOWbd6cVMrrG/BmTO9kNkoozFHTbjSgnpqFBfX3J6ch4/DXUHG0yDK53hMApCjUGX8TGUGBUqF5JknjB90I0ylHg4NODJnpFCJhtDkEjYPTo=
X-Gm-Message-State: AOJu0YwQiWVfR6nDnqOdA4VDniZmTtn9Ehs7A6lc06J1uYV36SrPBnTd
 oDeAC8GLfoZlPV0R+zJpbzfRwXDKQ//3I2UZZR719MPRWox4iREk
X-Google-Smtp-Source: AGHT+IFTCmLre8MtIgT54i0ojke7z/TMJ8Mq1I+eTp3ruv5bowULlWVQmbjQ2EEeTRjPHihoBkimbw==
X-Received: by 2002:a05:6871:409a:b0:23c:e635:8db with SMTP id
 kz26-20020a056871409a00b0023ce63508dbmr15506070oab.15.1715075465585; 
 Tue, 07 May 2024 02:51:05 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a63d405000000b0060c5179a0a5sm9428921pgh.50.2024.05.07.02.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:51:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:50:59 +1000
Message-Id: <D13BID6N11W0.34G4IGO8KCEPO@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 12/28] target/ppc/mmu_common.c: Split out BookE cases
 before checking real mode
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <6e9441212a1146fde2bd3a120d6c426cd2a1792e.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <6e9441212a1146fde2bd3a120d6c426cd2a1792e.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2e.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> BookE does not have real mode so split off and handle it first in
> get_physical_address_wtlb() before checking for real mode for other
> MMU models.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index a069e4083f..24a9b9ef19 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1191,6 +1191,13 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>      int ret =3D -1;
>      bool real_mode;
> =20
> +    if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE) {
> +        return mmubooke_get_physical_address(env, ctx, eaddr, access_typ=
e);
> +    } else if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
> +        return mmubooke206_get_physical_address(env, ctx, eaddr, access_=
type,
> +                                                mmu_idx);
> +    }
> +
>      real_mode =3D (type =3D=3D ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR,=
 IR)
>                                        : !FIELD_EX64(env->msr, MSR, DR);
> =20
> @@ -1211,13 +1218,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>              ret =3D mmu40x_get_physical_address(env, ctx, eaddr, access_=
type);
>          }
>          break;
> -    case POWERPC_MMU_BOOKE:
> -        ret =3D mmubooke_get_physical_address(env, ctx, eaddr, access_ty=
pe);
> -        break;
> -    case POWERPC_MMU_BOOKE206:
> -        ret =3D mmubooke206_get_physical_address(env, ctx, eaddr, access=
_type,
> -                                               mmu_idx);
> -        break;
>      case POWERPC_MMU_REAL:
>          if (real_mode) {
>              ret =3D check_physical(env, ctx, eaddr, access_type);


