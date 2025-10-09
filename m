Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAE8CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yKR-0003xU-4e; Thu, 09 Oct 2025 17:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yKN-0003wx-Gm
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:37:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6yKL-0007Q5-Ay
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:37:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso8363805e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760045851; x=1760650651; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOiVfHvJLTWKFT5cd9kXslkC3OOmjDCzvnPlGAylBms=;
 b=NB1n0H/wVOBuDEwCHCTLpBmkBtCfKMn7JYNvGGavPO+HZ9e4ViiJqVzW03q2fSOvLp
 5wHEx18oi3N/eEBTMnaIyh/A5Bh7edcQa38unY5VD5WbY3up82LXWF2OjEJIGVjxaRJ3
 v9ir/kdFU4ZodLcZDP79xIO7uGaqWHOgVgS3Xsj1Q4tsLpI9xAkfbEiTXgfIili580JT
 cauoA5n5Xfe/yfQYdJhYz2HUh0yRY3mwWdGxz2fNhUC/eUyZhUmvRawXlyFslDhSCAN0
 VW9TDX5/YbPjjhBlsIAFA5+C9rI2oqFWWdSA6G1hHb683FtKWEJVnvPADB8etm6vV7GG
 XqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045851; x=1760650651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOiVfHvJLTWKFT5cd9kXslkC3OOmjDCzvnPlGAylBms=;
 b=CdVOsx58/k2VshPBmqZNQD4bPLoPzxszDgXXmV2rE/TpjvsCA+vAEUSlZkKeojsnyj
 KB2twsjnfjYJEKAu/vIKYpQjkY6A5vNid8fLVxAn2Z6DD4dU9Byb9TU34lP2BSdzDC5G
 z1aV9HDRr7kfEESgh3oncWUp2j+jbC2kt3Bv5Hqhzd+6ge+rg5rVwRovzthRsleUeqRj
 jIyfHRkczZi1+jrmRiqldR90IGVeP91Vg/c9VfKaLWoZ7QWy81GKTJRlFkgQVKHl9VA0
 nlsnU8FqPKBK6NPT/2PVM87mwMSNpcSg1n0G8yi9MAeZuwPtXwdSnhVKJBZl/GsFaQmA
 jMrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWg46NjI5TZSiIZ20Tjke1RlhV4MiYIoO1JlMnd1gfwqBI0SjJK/MFVuHfqe4EVAxH5uR5BnDQTxTe@nongnu.org
X-Gm-Message-State: AOJu0YzIcUcuxGJs32mDnauJUj36p8lDN25rhCVPMKJQLgi6DPpEMKRx
 LJr+KP+xVX9j0jCBVBNF/RJwgjyptL/jSmmZEtYLrvWdH5cxIwyQ+JvQyLhAuk8H2mEFjR9DsOM
 5So/bTLb0Z/y6TRuHTN0opou2+mqM+8k=
X-Gm-Gg: ASbGnctxXHgQbOA5OM47xSdLdAZpfyYbzrzl3nSESdWPWHy8cIELpkQlNU7GoxkaiTE
 ZfYkvqtG6DOd1/O01Z+qZxJyBtspVup0dKKzxQfGJJLaQo2Kgv8z4QluqX0ND+LEehmICNNEWzv
 hkx242a6xB+m0QrRaAhIZtve/4HrjqMlWWoiS6qOHN4m5vibc91HJhXFNffnewRhOvy2MSSA8Sj
 7YxFSMmJd1FQAvAC5tEoOSHmUd5kp6XxCEohSxvovq/dpv1I268lLkFVb8kYeE=
X-Google-Smtp-Source: AGHT+IEAQ8qNd8DOYr6eNnXk9rwnGqjnEdwR8O/uOAhp45H+GNZ4SIBzfhBNE2PaZubwFfM9eHIjnac9tqNiC09XC/A=
X-Received: by 2002:a05:600c:810a:b0:45f:2805:91df with SMTP id
 5b1f17b1804b1-46fa9af8338mr56646395e9.20.1760045851314; Thu, 09 Oct 2025
 14:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-3-brian.cain@oss.qualcomm.com>
 <e61d9cbd-62eb-43f7-ad82-904ae4ba9ee0@linaro.org>
In-Reply-To: <e61d9cbd-62eb-43f7-ad82-904ae4ba9ee0@linaro.org>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Oct 2025 15:37:20 -0600
X-Gm-Features: AS18NWAOiWIiVxptEWiSJK03OsMF3GEdYCuAMDGGbHJvFaAgM4kK9OAs9SW7U_4
Message-ID: <CAATN3Now7mYz0Xg=hu5d7EzR54EGx7XPSdqhwLBv+urWAuhNeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] linux-user/hexagon: use abi_ulong
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-wm1-x332.google.com
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

On Thu, Oct 9, 2025 at 2:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 9/10/25 21:59, Brian Cain wrote:
> > Change the user_regs_struct to use abi_ulong instead of
> > target_ulong.
> >
> > Link: https://lore.kernel.org/qemu-devel/7bf3d8c5-df07-4cbd-ba62-4c7246=
a5f96b@linaro.org/
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   linux-user/hexagon/signal.c | 52 ++++++++++++++++++------------------=
-
> >   1 file changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
> > index 2847952216..e5514b2bec 100644
> > --- a/linux-user/hexagon/signal.c
> > +++ b/linux-user/hexagon/signal.c
> > @@ -24,30 +24,30 @@
> >   #include "linux-user/trace.h"
> >
> >   struct target_user_regs_struct {
> > -    target_ulong r0,  r1,  r2,  r3;
> > -    target_ulong r4,  r5,  r6,  r7;
> > -    target_ulong r8,  r9, r10, r11;
> > -    target_ulong r12, r13, r14, r15;
> > -    target_ulong r16, r17, r18, r19;
> > -    target_ulong r20, r21, r22, r23;
> > -    target_ulong r24, r25, r26, r27;
> > -    target_ulong r28, r29, r30, r31;
>
> Yay!
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

