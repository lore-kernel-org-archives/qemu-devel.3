Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC97ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYar-0005xI-Fi; Wed, 07 Oct 2026 16:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEYam-0005wl-BV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:50:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEYai-0005VQ-Te
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:50:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso2683119a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791406219; cv=none;
 d=google.com; s=arc-20260327;
 b=WNOjjPxmW/8QJH+agW9Re52LTtSZlvbWzdRbxaqnNiREuWtTwdfNsUYMQTLCyWVuHr
 xslvcNw20boU3rz13V3aQwRa4sLM6MIE0m1FuvrxPhYIEzokXAG089lyhkea2B9ss84e
 igGMOXbAwqesuxR05tT+eksPpncIiOXPlzAU1hvNScchQyO2VNdPEYY7bIXMBP7vo7/s
 3AMSwJrv8mbEFk8qavucp5CmbXsZRJj3UVi79cuhUeby43XUqHaZ1ano0mrfSTo0Y7oW
 ePWzvZLcSDoPl/HxefaK85JwQiTScj2UaqQIjGakvL9wBBcl4Yr/AvtemcRwLohLWPT5
 Ymsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=TJ4jkUWFTCfZVR9xXVV6RT4cScHQ9uYu6NOq08HuMso=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=F5hDlvBMqZvfA6ywr7+2b+mcGoKMyDqk1QUZgLVA8ivhBhFv083ZyILZlMBtTpAKe7
 wINZrEpQcVJsEYfizFMm4/vjYGQZjBKsKbfxwY+ly8ishoC/0no9BBgXSgWskgOUC+B8
 OzQapZWMiZAbmd5D4YN6kWC0KFRCRn4MwLPWF11vLvK9vg3Na+WUak+iraXiOc/L9oKe
 dgXshjW7LfnZvuQXaWJVwHR76RT2p8RwTGzQ7Y5XJxKTN2XKciUJnxhOXIulyHvbwa7R
 HEPtqmRQF2WMAmj+4HFEm6zW4NwDvpCPp+zKiYGANlb+jRS/zmkipe9Eeqf5xsNzy9yK
 nnWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791406219; x=1792011019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TJ4jkUWFTCfZVR9xXVV6RT4cScHQ9uYu6NOq08HuMso=;
 b=i3q2KsWeQJLuX/AJPhe4QgC3tMpcztMTCXzZXSoVyPS2nddGpkaq/KHY6Vy+k/+Ib1
 o6hjz5X5TxqXKdC1fX2wRe3vrxG8xngrahua5t0Rc6Q3WXR/Bp5F8FlWw+Gx+XxFaz2g
 O7QoF4loJ1eHVEx0NLZZcWhTE7o3zy4hKyc8HEm8CWFEyalHgWJGrgBzrIF8bCL5m7uC
 ahR40qU/yOkdCQwp51euCs33OABhW+miMpZZBNJk1l1KY3gglAjoJSihiqIuuY8d0gH4
 99eS+Hi2Cu/AyBuLXg+rnjjVJtUMf1W0hs9Kdp9ctbSiiwPp9eKfaMj+j1kioXS3BxjH
 eEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791406219; x=1792011019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJ4jkUWFTCfZVR9xXVV6RT4cScHQ9uYu6NOq08HuMso=;
 b=cpneEWd63uRG2Xde+NsjY7zu+A4mPgi6T7JCArglFmztczjmC5lENH/k//ImCDTYE4
 w7AwKKrmA+khZS9XPrCYvFHpy6a/CLcV/9ANgzCq1FKLWmB+7Ga7t8HoiheI9GEIGf06
 GottS8aSlZqnGsm1y9NYy/2nsgV4WNhRvMhK+6flQ6FMUg1HWOgWYrub8XVT8p8dwcss
 OkmH+ngbnKB0Mt84JSh0+5dIhAtAYCk+wEUcVoo+caDR4ylUbR2w/+yAvV/zIJZwgluQ
 FShvTvJm6pAZIOzoWhXx3UzrOPaLjSml6IuPiYF9DWLPI+T7II2tzSL/RRgdC+J/j+Fi
 CbGg==
X-Gm-Message-State: AFq9FYITO3xcVdpTaM1oacOH3jlJfTmzp8fLzb7P8wUnL/GeJ2lWw3n/
 O6BxRYNuxvZHUKuxuKTdh1s6RQtc049EClsc9hCyGLDyJjNRK6vPVM7A0szbzYvsXApuv4uJWv/
 23tlZ4/1mI4kVkI1xbECmlsZFDYIEdOw=
X-Gm-Gg: AYBFou04W14xIpnW28Z5RBcmvo56O9M9vwN69Acn47KMTXWry0iULygAUCgGiNDrQpK
 Tuo2a/DSpV3actEDHqZ5YXGDvZUht5cVdscBDVNG7ZROdRo2dnLpzceE5CMi1AaVLtGdRL/1WQ9
 VMj8mtCCGCw3pbzef7Rn5PE8twW4o5TJIL6UOgbX13EzMDOF5GWyR8KuFT1CglDSNK2vXN3bPhk
 EjlzdOfdIDOtgsLBeO+Bam1adtr6jSeDJ8x+Hxp9/2wkE+qKXnjOga6b1+rizz1w7g0IYseFHU0
 1l6jXwQ9hCIHTJQ7fWkNkKFzW4Pu46/TlY1NX1nBYzSsSDohZCSEfGQ=
X-Received: by 2002:a05:6402:a0d4:b0:6aa:734b:1a2d with SMTP id
 4fb4d7f45d1cf-6aff4575b77mr2791791a12.39.1791406218932; Wed, 07 Oct 2026
 13:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
In-Reply-To: <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 04:50:05 +0800
X-Gm-Features: AclHuK9MxsL8JYnxf00H6d8XmG9AGJkIDPOcHxv45UdNwcWLvmH2PFtRgT5Tsrg
Message-ID: <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 8, 2026 at 4:29=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> > Register target definitions through constructors instead of
> > MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
> > available on entry to main(), without explicit initialization or a
> > call to module_call_init(MODULE_INIT_QOM).
> >
> > Keep the target list sorted by target_arch and default to its first
> > entry. Provide an unknown TargetInfo fallback for target-independent
> > tools such as qemu-img and unit tests that link no target-info-def.c
> > objects.
> >
> > Remove the obsolete QOM target-info registration infrastructure and
> > update the multi-target test to inspect target information before
> > initializing QOM.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/module.h           |  1 -
> >  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
> >  include/qemu/target-info-init.h | 53 ----------------------------
> >  include/qemu/target-info-qom.h  | 31 -----------------
> >  include/qemu/target-info.h      |  9 +++++
> >  meson.build                     |  6 ++--
> >  system/vl.c                     |  4 ---
> >  target-info-def.c               |  1 -
> >  target-info-qom.c               | 60 --------------------------------
> >  target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
> >  tests/qtest/fuzz/fuzz.c         |  3 --
> >  tests/unit/test-multi-target.c  | 12 +++----
> >  12 files changed, 129 insertions(+), 168 deletions(-)
> >  delete mode 100644 include/qemu/target-info-init.h
> >  delete mode 100644 include/qemu/target-info-qom.h
> >  delete mode 100644 target-info-qom.c
> >
>
> This approach (custom list based) was considered before implementing
> things with QOM Types. The rationale I followed was that if everything
> is in QOM, we might better follow that for consistency sake.
> Yes, the compromise if that we need an extra init step, but it was not a
> problem to add it.
I have issue to add the init step for unit-tests, and hard to write the -ta=
rget
parse procedure and get it right. Not means this won't work. but for
me, too much
coupled.

If we treat target_info as a QOM, but QOM needs target_info to set
up(is_avaible). That makes
the init sequence too much of a burden.


is_available is depends on target_arch
And before this patch, target_arch depends on QOM, pulls user/softmmu becau=
se
target_info_init. By moving target-info to be a custom list based, we
can decouple
target-info from qom/softmmu/user. and target-info will always
available once "main(argv, argc)" is entered. We also have the
advantage of doing all sorts
of tests against it.


Tools such as qemu-img and unit tests may link target-info.c without any
target-info-def.c objects. Their target list remains empty, so use this
fallback.


static TypeImpl *type_register_internal(const TypeInfo *info)
{
    TypeImpl *ti;

    if (!type_name_is_valid(info->name)) {
        fprintf(stderr, "Registering '%s' with illegal type name\n",
info->name);
        abort();
    }

    if (info->is_available && !info->is_available()) {
        return NULL;
    }

    ti =3D type_new(info);

    type_table_add(ti);
    return ti;
}

>
> Is there another good value this list approach brings compared to what
> exists?
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

