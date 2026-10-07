Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03427CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEafB-0004e8-Q9; Wed, 07 Oct 2026 19:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEafA-0004dy-Un
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:03:05 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEaf8-0007d2-Pu
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:03:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so19512066b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791414181; cv=none;
 d=google.com; s=arc-20260327;
 b=D2qb0oDiNJ9UcTJndn+RuChft/76AuMJQWS0vg3Qnfnh5/sxGGLsX48BEwUdTbB5Mp
 3pBwH+eks6UVN74F8sc+uzFw7aRkDsho1YlkczeCKY7xCEEMaFquIEHzfINxcxlx2Zem
 ud/O8jXGy4uz0atTj9CB1jFBpkpizy2WzwOnG3BVWh6JMMqrgH6DE+vvTRO/w8Fg/vkj
 RfhMSq6pHAyC2qXcmQH6dQw8ncyPDWEtlfYH7x6e6E06LGqFt2xQA0qJK4XJRFj/k1kM
 bF1juqu93SG1AvxhMjODvgQPuMnPRPy2g5ivO5FeVVnApsW0Qwi2c4/iXeVnJqqNp7Jm
 I/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=eZGM6Bm9f+pChsYBGl3aR4v3S8XlttTKcga5IZaRWho=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=LvoIqsAnlmuoFrJ+sfr7UNji1eimsZaEe/+FjCJPix0DiRSBCi1zWkF9Ozz+HRxGPb
 e7ffLk2d3Ro2NS3p/yx7GDxEJFJurdZMK568m8xPK13ImPqytWMGw8jY9spKuO4IHFUn
 F+yuC8mKCxL7mpoJZw8l+B0EM+YF77jyNsEs0e/IisQBpFADGKpzYQk4MJB1McIJ+gLU
 CA+jXloTKaYKlNombKaU+mJmyv+9YXJBBpQnxllLzXx/cfeNyuOPj1Wr0jRpU2zcQoH0
 DfcWeomXfbm040l94KjY7tb+L/l3Dn6pjcjYTKxgoCVDB8nqaq/Ko8f56ZkE9vwr3QSo
 MSZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791414181; x=1792018981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eZGM6Bm9f+pChsYBGl3aR4v3S8XlttTKcga5IZaRWho=;
 b=nstUwDjG3PYXqDgE0gnXgmJRv8Zgj/ClfydJawPZylYn0g9UfJ91oJqBspmip1Ld2S
 t0y2Zv0//yL3dtv9X3QNSThTiU0GlC8rCacR18eNSRKoul1dUSw2+QEsGSRvHXyVgKWk
 FpymQPgUuQuTtBIZ6xzIdx6pUtIQApgDN7MUtuY3bHTWd/vd49FxuiFHBzBZ6fdFoQvK
 80yjfgxQUF5W6/VsbQ33pugqZ0F48PHGl7o2Ag87qCtC/6qVrX1A0PFxZVmBFUukIbNy
 BlNMIWPW/oG29TNWkshok9e0OAO3sRgEKFDNCXmwqZWm41UfBLVJWD45nXt+Lhdb/0UP
 wnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791414181; x=1792018981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZGM6Bm9f+pChsYBGl3aR4v3S8XlttTKcga5IZaRWho=;
 b=pTE94EqgKtIA4tNspQCBnHjmHK/O09oQiTNj78NyIRct+J//8l/f/HzzxdzjePVke+
 8MCq3zwzsIJLJO0mJ1AstRlv6t2wsJj66TgpoVvmlu5sR4BUZUcQiPQB7qblLrbbG0es
 hVvzCVPKE9po/XWjCAfutrC9x4ciUI1W3Kj+0+2fzDBIbQoCbOKfYrIRlLNFtIDwnJt2
 KSu7OPKLoQtBb9PsrTwwkrlus2JHJMUB2kpmaYKETTES8WembfdeYmn631JMhNnth3zB
 XE5ZLzwPLxVYPNEy58b7RY2xT4EA1bUq9igrwpiHmyVGV9F3HgfuI9aX+E4P1mbCuvHL
 nkFQ==
X-Gm-Message-State: AFuF++nMMzFI8XT9We0M+7cNAn1Ss3I4F/NS8btKcoW1UB/u+dWgeqek
 5nlIPaRzE4XeEer3Y0lxN8tkJG11i4KoK8SNNE91JRqsdXq5Yt3/R1EW92bkCLgv1H9yWFyTVkh
 HN7mQux9pM87qIlgBSaNnN5pqm2GSgxo=
X-Gm-Gg: AYBFou3INR4Z7pB7F3mn28ZC//dlcVdpkQmIxAMI8dbO8WMVoLmG7IEZkbtJ/PfkkKj
 IWYodK1NVmF6aBdL1qJhA1VANROAqQ19Lg7LJXWZMx6GNyT3BO3x7vlIvF4E15ItXJLL9MhJf7L
 f1jnvfLetmtH3Qcouo5pfR8xdqm+pYKIbRqFaITVIFNd95Vq2fPHV3dGIvWMAjZb7LGbqUClsfU
 ZUXIjbsPcnt5N+SpgzJqnDK77SpUQmDeUzchW8hroyBAMtzPJUYx4G1V4ugbGXu6FscnIn/hpRI
 p+kUBM2YKSTn7o+i/Vvducz7bHb/sKuGYFQH7fOavo4COVEIXcm/IDc=
X-Received: by 2002:a17:907:7211:b0:c2e:6570:6882 with SMTP id
 a640c23a62f3a-c3191aefe1bmr47550666b.10.1791414180719; Wed, 07 Oct 2026
 16:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
In-Reply-To: <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 07:02:46 +0800
X-Gm-Features: AclHuK97-4__VE_gu5Q2LVEVdudJU9WZ8bBVXNKl4QsfC6MqTigc3wyfr_Y9CLQ
Message-ID: <CAE2XoE-XeHnywvAGOCgxO30a_qCMgxbnBF5kjtStGa9=5D=Rkg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x635.google.com
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

# Multi targets test
if multi_target_objects !=3D []
  test('test-multi-target',
       executable('test-multi-target',
                  sources: [multi_target_crates, files('test-multi-target.c=
')],
                  dependencies: multi_target_deps,
                  objects: multi_target_objects,
                  link_depends: [block_syms, qemu_syms],
                  link_args: multi_target_link_args),
       suite: ['unit'])
endif

I see this test, I am trying to add tests that do not pull so many
multi_target_objects, as it would be huge.
Just pull qom only.  And I am trying to call target_info() in
object.c, as inspect machines with
qemu-system is rejected, so maybe that's not an issue anymore


I means Subject: [PATCH v3 00/10] machine: uniquify virt QOM names
https://lore.kernel.org/qemu-devel/20260926081551.29-1-luoyonggang@gmail.co=
m/#r

So the current design always rejects types that do not belong to the
current target. Listing them
all is not an option at all. With this restriction, then these are
indeed not needed.
So I'll wait for your work first, otherwise it's always conflicting.


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

