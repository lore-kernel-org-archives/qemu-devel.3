Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC39CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 14:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1nKG-0003ui-Vm; Thu, 25 Sep 2025 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1nKD-0003uK-GA
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:52:01 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1nK4-0003XR-Aj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:52:01 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-72ce9790acdso13925467b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758811907; x=1759416707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOhxutFSrLyTPx0FAFjDtq4+50looaQ2sNQSQjEOdHI=;
 b=PQEkSRcqAwM+KrMHs3jpeCXyByJ1ClPEkDCFV3fdjKe3xHc2qMJN64nX/hZ+24OaB7
 gbjhhIKOfTsBtjAzloZQPoqXDA4JTrVEduJ6kaoGuIrRS7t61Rt0uKs4BQBBWqqwVyqD
 Ff+DO2BYlNMM2dcS5kNG391Rr8UUHDxsGEhazdeyLWu0b9jyNDtVqrTAsCJ8aKZnX5/p
 fujVu8j/eYvGl1oDEznhGB8SFdGD9Xd9hmJwoFpxgFxU7GdxeuDneKKF0HXPax0ZA3Cl
 NCJmOytA6Q3NQPyAT9UnsdScLefNX8bf1zao5AY8quX/EfKgCMG2/rANmIpHidCOa/Bo
 v9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758811907; x=1759416707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOhxutFSrLyTPx0FAFjDtq4+50looaQ2sNQSQjEOdHI=;
 b=g+fgL9+y0DOCFrHIGm6eUptrJ4dWriQw6NFo5cJhfxZ07tN02H+PgYKCYZVBxCpOyj
 I9s2wsQugQx6YrEtayZZAgnJ4xfC0qjbJsIcvj/UKP1TQv05rYwCMwXBdpBtYs+pJ4ZU
 5xdin1PF/5zAmwu/JJpCWNvEnknIpnrv50xfSD6e6Ory/6jEjD7aQSlRluYfqxMUk080
 Xbr6BFczwXVrp3ZVOJhzTHyG7AXLRkrRBfUPWUbp5OBRHTsRuy84BFFQn9ozcVEE/Gwr
 JbBq98jYuvvUTVqIWoZHwhozGwxN8V94DhMZlEpMoCu3wFwsMBTo3Wh3ieJHkhjCpCFL
 it2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlMlGrVOZmpbCVSztiLD7nrfHuGA1RWHU9y5Qr1GlJC93mCoS7jweK8yL1nB+i8Xn0sUdqXCotdcUX@nongnu.org
X-Gm-Message-State: AOJu0Yzg18w2dkJ3f7EHIo2mcOZhgjLiy/I6S9tXmMpqiHP3Fc5TkM2j
 Biy6CXnfR2kR7x/P6ge3C9jOKf2iFweWcC1IpoZglFVKZTyoEzExHrm2+Z0PLCBlIuUR+3ih2Lk
 C8s70+JoEazgoG05vNbQz9iz3KbVhqu3dxpmEtbgGAg==
X-Gm-Gg: ASbGncuqEbFA00SvrrIAnbFm2qrIL4Adm/335F8JsvvnV2xRM/SkKP0t/Dov7SBaGkK
 5KUEaqTzRPrZkkEbhNtrxzYyyeBtP3Ya0IA7CV82aqMOyYgHOkGyqJ1yzOmyni2ynJnXljIhdmX
 1W7dKDwjTswskioxT1Dy0VOGsMMiMvhERVQGwibUhYnD2BPnCDHpor3SRJK2bIRPmzpdJADOuaZ
 ubPkZRz
X-Google-Smtp-Source: AGHT+IFzzsnkjmt21TzrxrnBhRuDoYbYcJVSJrFeN5w81vntuylwyCFZBWB85rTzv4m4O7b4onfKyC5aNhteVH2ymdc=
X-Received: by 2002:a05:6902:1547:b0:e9d:6a31:d514 with SMTP id
 3f1490d57ef6-eb458cd6e2amr1142756276.44.1758811907064; Thu, 25 Sep 2025
 07:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-25-richard.henderson@linaro.org>
 <63a29a08-67ea-449f-954b-f62abbc39346@linaro.org>
In-Reply-To: <63a29a08-67ea-449f-954b-f62abbc39346@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 15:51:35 +0100
X-Gm-Features: AS18NWCk_ct5HIdPxC0D3Wx8xIbZP6PhiXRbS1LA_Z9oCpTdSedyxm3Vd90C848
Message-ID: <CAFEAcA86ruJ9R8OFCXd1LHhNffyNNC_N92oXunm6UgBh6yyYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/36] target/arm: Add key parameter to
 add_cpreg_to_hashtable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, 25 Sept 2025 at 12:07, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> On 16/9/25 16:22, Richard Henderson wrote:
> > Hoist the computation of key into the caller, where
> > state is a known constant.

> > @@ -7587,18 +7582,22 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU =
*cpu, const ARMCPRegInfo *r,
> >            */
> >           ARMCPRegInfo nxs_ri =3D *r;
> >           g_autofree char *name =3D g_strdup_printf("%sNXS", r->name);
> > +        uint32_t nxs_key;
> >
> >           assert(nxs_ri.crn < 0xf);
> >           nxs_ri.crn++;
> > +        nxs_key =3D key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
>
> This is new but not mentioned. While the CRN bit is know to be 0,
> we usually use '|' to set a bit, not '+'. Preferably using '|':

I thought so too at first glance -- but what we're doing here
is adding one to crn (there's a comment in this function that's
just outside the context of the diff that explains this).
Since crn is both in the reginfo field and also encoded into
the key, we need to increment both the crn and the bitfield
inside the key. As it happens, at the moment all the regdefs
with ARM_CP_ADD_TLBI_NXS have crn =3D=3D 8 and so whether we add
or OR makes no difference, but conceptually the addition is
correct.

I have added a comment
 /* Also increment the CRN field inside the key value */
to hopefully make it a bit clearer that we're doing an
increment operation here.

thanks
-- PMM

