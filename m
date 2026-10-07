Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF42CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEaXb-0003Oa-Mu; Wed, 07 Oct 2026 18:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEaXK-0003Ny-Tk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:55:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEaXI-0006tX-0c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:54:58 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6aff0c4bda3so2877585a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 15:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413693; cv=none;
 d=google.com; s=arc-20260327;
 b=lg6NGwiPEAKEO6cMJMHp5I1lXVyxu4Mk8f6QYrHBAEIkSaaspl+XKhoKUwLDh4wI4w
 tZATqKc4lrwEM1ijwBAGosmfB9/jRBnlgNtSN/ktTqW3zFfMbVqRPAEJ5bYFfTA1XQNi
 XXaI9xzslEIeH4nlIwEONNLHPu7n+qfxKlsp9rQqXcIeR+DkZrHtcidCA1f5+alQkffm
 A0Hg0mp+58Cdvlb8wJpuhdDLY/sSoujPDLk0fLbgGg+GvViY2QEksnQPz5Axe/3fSmN1
 ZmGhhKW4ocuZCDsfUDQ51rl7hMifMxZi82mjSXLemuhsooxfw6hCeB3OGo2IDONE2c8k
 hbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=zSjVc/tu+Y9ukXAP0Ef1p9qDGK6Rj596TGAY61jYM6s=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=olK66IkqOrQfHRoquAqvMTUvdY1CQGI85MWfwUyDT7cO8n8JSHJMDBHWgtGGseJdUl
 n+FceCwC4uI4w2QaHsI8J9HCqsSkqKVV/WtzhoGFS6ClsJ3SfhXUHwxTn9YSAZzajPey
 Dr5hbiw5uc95cpwPs9u/1uK7px+yoIx8hSgt2S4a7jQK3KgSXJWklxkcj+jCmAN01rqD
 PvqwyEddRbw+80w6nh5FYKrwVr/8/fMeD7tCm/x/T0iumzXIoNm+vl/DJOwoSZ/o/v/t
 HHqVYeangeDpmgG5fACk2vF6l9Kx2BX2RN1s9pjxqCm70rwS0cVYtcjCs/VblqGvcsU8
 jLrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791413693; x=1792018493; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zSjVc/tu+Y9ukXAP0Ef1p9qDGK6Rj596TGAY61jYM6s=;
 b=rU5C6yavrYJpmY+IjCkG6QUYpe2rDCULUHmHBbOqXyTEcq+PrKHPEGxeSlszmOsAt9
 1GIn68d18ifakU2rlJxO/uHNFFjtbAbj8/wz3vYJqQfZIWH602cm+aWp2m2grg7uf3I8
 +6HLgIoxQZtfq4CjEVDYzhYx+n3mVRLFBS5O2wTX7DhWVQOy9kN9RVcLSTURQStukiee
 AqmrZ/2p8ca1IceAwG6qzQ+qTN+LB1iDyLlbI2MBL/w9cIY95cCt3W83gT7vbdol379g
 Wv/iTNpbd38cjWrtZiJyfehNnQ3pIgcxucNkvXYnnw+rrTyXPTIgGmawDg/Jn0QQyXn1
 9RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791413693; x=1792018493;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zSjVc/tu+Y9ukXAP0Ef1p9qDGK6Rj596TGAY61jYM6s=;
 b=N5BwW08TWRMRTOPgvdUKENp1Wqxv+CPBMgJY7Yeef2HLxaBquSk3+Qv5o06ncEhztC
 SHthgtjCu5bRlIOVjIGZ+ScLvirlrCM8JKscAnDmx+HU5VB6qDEQ5tP9acEF7HZXTj3l
 1XvxfjNtrg1HkUfEE+Q1jq9/k3JWNteMQaQftD1X3hoHs8q/sOih0X85+NZkqq5ZBrkr
 1aDHALUocCGCR7DMCk0fq8CI1OH0zBB/xUG+Q8xresp8CIMKlyuot8csA+r2cz421qYl
 DF6rY8bbQQnChlipDxVnrC3XYP6uKj4bhQmirE4i5sdX8RH9WOrzFwd2ELebXwmbchoe
 0AxA==
X-Gm-Message-State: AFq9FYLpguj+2GqXICHyk4S25QMJWlhu9nWEdCeNXLhTYFQ9lXn0HcpT
 uS/5RGwhJ7RtgGdvcXJOhbQYXGwCCtaqfJzI4Q8puEG23kChhQbrX/4qM42Pb3dwoEs9klXnDj8
 +2IuFdR+JaaqFXm4f1ASvIDxoA8L9mQE=
X-Gm-Gg: AYBFou3uxzGnu676zkYnEJO3zeq52NlbQ+qpw+Jp+galoXEVlV9hyj1iO4DSF7yXRpz
 jE1IdkGrtvgaV6tTsDZFRfYkFsgVh9X5UIV46xSGdIM0QOH5qO13xnwM7b5OTyTmPu3OuVW9KCJ
 5HIoz82+oeIJ8fcdBUjus2/GbnxNz8WU6wjYsT1yUkbxv71YT0prls4e2zECDigaBb+X0xq7dhb
 B8yBHZDTQSfPFDirtmd3/WiEFPnNGa9hSCihuEPGGuQme/WQ3cPiBiLqWqxNSjNFMeJh2NlTY4t
 oqHQJFHjhHQxjH07t5rDOXNx7u4WRYvkliFLzsKrT4V+mLXlr50ohus/y4ZIak7ndw==
X-Received: by 2002:a05:6402:440b:b0:6aa:f937:106d with SMTP id
 4fb4d7f45d1cf-6aff4551bcfmr3512929a12.36.1791413693172; Wed, 07 Oct 2026
 15:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
In-Reply-To: <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 06:54:40 +0800
X-Gm-Features: AclHuK9kE16liw36x5Raqabdi5GZ-fn5rleuW_Jul-TKJagPE7aEBvcLgBxSY9o
Message-ID: <CAE2XoE8G7Pyu-UaoW0BRxHqEX2aef_ak29mAkwwssSS5Rf_y5A@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Oct 8, 2026 at 6:31=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 1:50 PM, Yonggang Luo wrote:
> > On Thu, Oct 8, 2026 at 4:29=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> >>> Register target definitions through constructors instead of
> >>> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
> >>> available on entry to main(), without explicit initialization or a
> >>> call to module_call_init(MODULE_INIT_QOM).
> >>>
> >>> Keep the target list sorted by target_arch and default to its first
> >>> entry. Provide an unknown TargetInfo fallback for target-independent
> >>> tools such as qemu-img and unit tests that link no target-info-def.c
> >>> objects.
> >>>
> >>> Remove the obsolete QOM target-info registration infrastructure and
> >>> update the multi-target test to inspect target information before
> >>> initializing QOM.
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>  include/qemu/module.h           |  1 -
> >>>  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
> >>>  include/qemu/target-info-init.h | 53 ----------------------------
> >>>  include/qemu/target-info-qom.h  | 31 -----------------
> >>>  include/qemu/target-info.h      |  9 +++++
> >>>  meson.build                     |  6 ++--
> >>>  system/vl.c                     |  4 ---
> >>>  target-info-def.c               |  1 -
> >>>  target-info-qom.c               | 60 -------------------------------=
-
> >>>  target-info.c                   | 61 +++++++++++++++++++++++++++++++=
+-
> >>>  tests/qtest/fuzz/fuzz.c         |  3 --
> >>>  tests/unit/test-multi-target.c  | 12 +++----
> >>>  12 files changed, 129 insertions(+), 168 deletions(-)
> >>>  delete mode 100644 include/qemu/target-info-init.h
> >>>  delete mode 100644 include/qemu/target-info-qom.h
> >>>  delete mode 100644 target-info-qom.c
> >>>
> >>
> >> This approach (custom list based) was considered before implementing
> >> things with QOM Types. The rationale I followed was that if everything
> >> is in QOM, we might better follow that for consistency sake.
> >> Yes, the compromise if that we need an extra init step, but it was not=
 a
> >> problem to add it.
> > I have issue to add the init step for unit-tests, and hard to write the=
 -target
> > parse procedure and get it right. Not means this won't work. but for
> > me, too much
> > coupled.
> >
>
> We already have such a test upstream:
> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/unit/test-multi-=
target.c#L35
>
> The init sequence is quite straightforward:
>
> ```
> /* initialize target types, and only them */
> module_call_init(MODULE_INIT_TARGET_INFO);
>
> /* we can get the list if we want, for -target or any other purpose */
> g_autoptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_INFO, fal=
se);
>
> /* set the global target info from any element in this list */
> TargetInfo* ti =3D ...;
> target_info_qom_set_target_info(ti);
>
> /* register rest of QOM types */
> module_call_init(MODULE_INIT_QOM);
> ```
>
> It works fine to implement -target (if we would like to do it), since I
> implemented it myself. That was also my initial motivation by the way.
>
> Also, I appreciate that target-info is NULL by default, it crashes
> loudly when it has not been set, and make it easy to find who depends on =
it.
>
> > If we treat target_info as a QOM, but QOM needs target_info to set
> > up(is_avaible). That makes
> > the init sequence too much of a burden.
> >
>
> See sequence above, the solution is to initialize TARGET_INFO first,
> before the rest of QOM. You end up with the same result than with a
> statically initialized list.
>
> >
> > is_available is depends on target_arch
> > And before this patch, target_arch depends on QOM, pulls user/softmmu b=
ecause
> > target_info_init. By moving target-info to be a custom list based, we
> > can decouple
> > target-info from qom/softmmu/user. and target-info will always
> > available once "main(argv, argc)" is entered. We also have the
> > advantage of doing all sorts
> > of tests against it.
> >
>
> Which kind of tests are you trying to add?
>
> For now, the exact list of places where we need to do this initialize
> target dance are:
> - system/vl.c:    module_call_init(MODULE_INIT_TARGET_INFO);
> - tests/qtest/fuzz/fuzz.c:    module_call_init(MODULE_INIT_TARGET_INFO);
> - tests/unit/test-multi-target.c:
> module_call_init(MODULE_INIT_TARGET_INFO);
>
> If we want more tests, I'm totally ok to move this init code to
> target-info.c, and replace call sites if needed.
>
> >
> > Tools such as qemu-img and unit tests may link target-info.c without an=
y
> > target-info-def.c objects. Their target list remains empty, so use this
> > fallback.
> >
>
> Why should this tool get access to target list? qemu-img deals with disk
> images, and is unrelated to targets.
>
> >
> > static TypeImpl *type_register_internal(const TypeInfo *info)
> > {
> >     TypeImpl *ti;
> >
> >     if (!type_name_is_valid(info->name)) {
> >         fprintf(stderr, "Registering '%s' with illegal type name\n",
> > info->name);
> >         abort();
> >     }
> >
> >     if (info->is_available && !info->is_available()) {
> >         return NULL;
> >     }
> >
> >     ti =3D type_new(info);
> >
> >     type_table_add(ti);
> >     return ti;
> > }
> >
> >>
> >> Is there another good value this list approach brings compared to what
> >> exists?

Sorry, I have to wait for your work to be done first.
I have too many patches depending on this, and it seems hard to
convince you. Let's just keep it as is.
Maybe you can work them out in an easier way.

My work is here.
https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?=
ref_type=3Dheads
I am afraid of posting 300 pathces into threads to flood it(and
disturbing yours). So I'll wait for your work first. and resolving
conflicts later, that's really time-consuming.

I did many explanations before. seems my explanation is too bad and
not to give a clean picture for you, let's delay these first.

I only sent these 8 patches for easier review. because too many
patches won't be accepted either.

> >>
> >> Regards,
> >> Pierrick
> >
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

