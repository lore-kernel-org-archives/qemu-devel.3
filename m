Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC6CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNYn-00034D-8N; Mon, 12 Oct 2026 17:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGNYi-00033U-U7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:27:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGNYf-0002pw-J6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:27:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so2112222a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791840464; cv=none;
 d=google.com; s=arc-20260327;
 b=CcWRE8gEYaqF9CDryNhk0PPq/8VnyKGu5Ood0Izu4S+ANYDIXsy8lJebzD8n7AiCmL
 gG+QwIUj2Rk7uTIM08/GnCcUPxzuC1TXiVW649P6JVH6ZzGg9OxFXcKKwv7svIDt+j3U
 yWp0zUAngxjVcqLLZFgXjA7nh14IpMqMn0qbJwWyHgYdPxQVxdDN6h0WaL/p6YkGcysR
 7/PwpDRv9gSIJajnvOmb67D897zL34EDDNsYH062cnoIyIPt2aJR523lWY1OEBQQwu5y
 hm7Ila18FWRUUQWbhXj0sFVglGstaE0rkSEqBpgLtUlNee4eTsNFromOlzMhMiuUndnM
 ulSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=uqbisoNvF8YC45u/QRqnn3KuqbucZ0iwZAe3/6dhwyc=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=Pi2yZin+F3w30kkyIuFiWBLcOqX3qTgDzCc4Ae1icd787pPQZzltYy4psagR+DvMbI
 6RYzeVtCZ/dcxmVbUMtbVUWQUinuVDdgWNGgWxDlS5STKNcjfmjzPH+TPLXEACWuimrn
 DyYeRhrQw3qHxdjBHfXQCt3VMoMxCs0g8BB9iEzkojdsfzJOXCHKKIpvmV2dzCreTBaD
 xakmXMbELeQ8wsraChmUulFpqnCMG1paT/Up0ZVljJACGgJeP+QfE2Wbvh55eBBukstW
 4Wdo4c13xuXJmMVQvnNvjgwN+4H9V5QtCXsjqjPoZprV8jaGzawM5vuzkGMnQPSoKIIA
 bdcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791840464; x=1792445264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uqbisoNvF8YC45u/QRqnn3KuqbucZ0iwZAe3/6dhwyc=;
 b=J+kaK18fuVPdFf9698IrEKKaZx8tsOgEdEgeVKZhREfo98mZApx/LJFBds4G9gtkje
 vzhA9fZxUlzvyjPDscir+iKSVXJWgbBVGopFZ/AjFzhN3VOY1G4zvI60AlckjFRXiy79
 xMuzntZD6l5/MJ/0cYTuCX78mtDguA92tNnNL7dGwc9pZrpbv6Yf6S/A5QuuF4W2e7of
 n0Yqmb82BZqbk7i02c7P7GFKqDc4119bfSBxuT5bAWO9MZfTDjntkA1eFAYRifvQqGqq
 70KOO1ndzu3u/ruQhBWNs3Rgdacv47NYTjwctA48VFjMkZxKMGwgiONfnH+Vy+IftU47
 o5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840464; x=1792445264;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uqbisoNvF8YC45u/QRqnn3KuqbucZ0iwZAe3/6dhwyc=;
 b=1nCga15fmewxil3sF+juwyXmVzChpWh8a7braLnUM5d8cczuKZRgpd0oghvK5De/La
 6Y3h4OhL4mh3nB/uS2ekmVJeSXujeF4ZN1R4V4ZXOzJWLOnlwC85uREmdo5PZrYEyYhV
 068DmblgH6c8Sgl5tlJk1OiQsVPAIauEDUBRoYfS086QUCS3mfjBlieEUdwB9Xt5H6qV
 p0nGEudgzZXd7czYD3CpFLhBm/4dTYp/G0XLpt+fqmA2joJn6ZRMMZ+14+XrKcDwGXG/
 M+25ofjtfA911dKv4TlsLBEaTMl5xQ6zJKLc9BzQhuBjRfKnXo1GPl2d96dRbWitCyF+
 ph8A==
X-Gm-Message-State: AFq9FYKgrMxRbeL4nP41UJyDqUoR1kfc3vTQSmQDPDPpo3ZZyUPugxSY
 eE1dyevf9JOlFlumazYeYp5s6HDLgUcw54rDH++EDIr4ihbgeTpkdqPeuF5RAKd0vxsjQSXQ5rb
 x3JooSU4+vWpD69nrfo/xoCwNGQ4nqqQ=
X-Gm-Gg: AYBFou2kiMIfAqdWIvBgi04svk/AgQnGe9Pgo3zXfVyWv97dIiSBlOU3z32d3Ed19MK
 U5050tP/e0SRnu5HqCY0tfreTyFQKshvtLV1ffmvZR9tgBJGz0cvqnPkeAVjlGDk/ciVvMOxv/6
 xWZvvWmFa6eGAuvx9haUG1P1H2DbIt1Qp03npo4oexwbtBR1IqU3z/BI9shanshYpRQDNLdv8L7
 DD+3IN72oolMbJJIYxu4SXxHrU7PTmSuxIbfBsK+ccK4sRekNWjY2bXx3ztkUebjFZxflD/TKX/
 sPc9G9NzFzq7G0Vw0Bt8WP5uZ+hpYB6E7Bf2sn2jk3iZr/6ix5NZ8eXN
X-Received: by 2002:a05:6402:249b:b0:6b1:d2ee:392f with SMTP id
 4fb4d7f45d1cf-6b1d2ee3e39mr2167059a12.25.1791840463390; Mon, 12 Oct 2026
 14:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
 <CAE2XoE-XeHnywvAGOCgxO30a_qCMgxbnBF5kjtStGa9=5D=Rkg@mail.gmail.com>
 <72ed88c4-5f31-46c3-ab48-fdaa7c2743b7@oss.qualcomm.com>
In-Reply-To: <72ed88c4-5f31-46c3-ab48-fdaa7c2743b7@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2026 05:27:31 +0800
X-Gm-Features: AclHuK-MfhO_BYu9rV-P-U-YhJaclZ4m6UvujBNRNNnqnIO9YohDpsRNHPseXio
Message-ID: <CAE2XoE8mHnaB8rgcE-ZsetpyK6dWSmU9dzRbdVJPb_w4F+1OWA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52f.google.com
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

On Thu, Oct 8, 2026 at 7:28=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 4:02 PM, Yonggang Luo wrote:
> > On Thu, Oct 8, 2026 at 6:31=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/7/2026 1:50 PM, Yonggang Luo wrote:
> >>> On Thu, Oct 8, 2026 at 4:29=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> >>>>> Register target definitions through constructors instead of
> >>>>> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info(=
)
> >>>>> available on entry to main(), without explicit initialization or a
> >>>>> call to module_call_init(MODULE_INIT_QOM).
> >>>>>
> >>>>> Keep the target list sorted by target_arch and default to its first
> >>>>> entry. Provide an unknown TargetInfo fallback for target-independen=
t
> >>>>> tools such as qemu-img and unit tests that link no target-info-def.=
c
> >>>>> objects.
> >>>>>
> >>>>> Remove the obsolete QOM target-info registration infrastructure and
> >>>>> update the multi-target test to inspect target information before
> >>>>> initializing QOM.
> >>>>>
> >>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>>> ---
> >>>>>  include/qemu/module.h           |  1 -
> >>>>>  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++--=
-
> >>>>>  include/qemu/target-info-init.h | 53 ----------------------------
> >>>>>  include/qemu/target-info-qom.h  | 31 -----------------
> >>>>>  include/qemu/target-info.h      |  9 +++++
> >>>>>  meson.build                     |  6 ++--
> >>>>>  system/vl.c                     |  4 ---
> >>>>>  target-info-def.c               |  1 -
> >>>>>  target-info-qom.c               | 60 -----------------------------=
---
> >>>>>  target-info.c                   | 61 +++++++++++++++++++++++++++++=
+++-
> >>>>>  tests/qtest/fuzz/fuzz.c         |  3 --
> >>>>>  tests/unit/test-multi-target.c  | 12 +++----
> >>>>>  12 files changed, 129 insertions(+), 168 deletions(-)
> >>>>>  delete mode 100644 include/qemu/target-info-init.h
> >>>>>  delete mode 100644 include/qemu/target-info-qom.h
> >>>>>  delete mode 100644 target-info-qom.c
> >>>>>
> >>>>
> >>>> This approach (custom list based) was considered before implementing
> >>>> things with QOM Types. The rationale I followed was that if everythi=
ng
> >>>> is in QOM, we might better follow that for consistency sake.
> >>>> Yes, the compromise if that we need an extra init step, but it was n=
ot a
> >>>> problem to add it.
> >>> I have issue to add the init step for unit-tests, and hard to write t=
he -target
> >>> parse procedure and get it right. Not means this won't work. but for
> >>> me, too much
> >>> coupled.
> >>>
> >>
> >> We already have such a test upstream:
> >> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/unit/test-mul=
ti-target.c#L35
> >>
> >> The init sequence is quite straightforward:
> >>
> >> ```
> >> /* initialize target types, and only them */
> >> module_call_init(MODULE_INIT_TARGET_INFO);
> >>
> >> /* we can get the list if we want, for -target or any other purpose */
> >> g_autoptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_INFO, =
false);
> >>
> >> /* set the global target info from any element in this list */
> >> TargetInfo* ti =3D ...;
> >> target_info_qom_set_target_info(ti);
> >>
> >> /* register rest of QOM types */
> >> module_call_init(MODULE_INIT_QOM);
> >> ```
> >>
> >> It works fine to implement -target (if we would like to do it), since =
I
> >> implemented it myself. That was also my initial motivation by the way.
> >>
> >> Also, I appreciate that target-info is NULL by default, it crashes
> >> loudly when it has not been set, and make it easy to find who depends =
on it.
> >>
> >>> If we treat target_info as a QOM, but QOM needs target_info to set
> >>> up(is_avaible). That makes
> >>> the init sequence too much of a burden.
> >>>
> >>
> >> See sequence above, the solution is to initialize TARGET_INFO first,
> >> before the rest of QOM. You end up with the same result than with a
> >> statically initialized list.
> >>
> >>>
> >>> is_available is depends on target_arch
> >>> And before this patch, target_arch depends on QOM, pulls user/softmmu=
 because
> >>> target_info_init. By moving target-info to be a custom list based, we
> >>> can decouple
> >>> target-info from qom/softmmu/user. and target-info will always
> >>> available once "main(argv, argc)" is entered. We also have the
> >>> advantage of doing all sorts
> >>> of tests against it.
> >>>
> >>
> >> Which kind of tests are you trying to add?
> >>
> >> For now, the exact list of places where we need to do this initialize
> >> target dance are:
> >> - system/vl.c:    module_call_init(MODULE_INIT_TARGET_INFO);
> >> - tests/qtest/fuzz/fuzz.c:    module_call_init(MODULE_INIT_TARGET_INFO=
);
> >> - tests/unit/test-multi-target.c:
> >
> > # Multi targets test
> > if multi_target_objects !=3D []
> >   test('test-multi-target',
> >        executable('test-multi-target',
> >                   sources: [multi_target_crates, files('test-multi-targ=
et.c')],
> >                   dependencies: multi_target_deps,
> >                   objects: multi_target_objects,
> >                   link_depends: [block_syms, qemu_syms],
> >                   link_args: multi_target_link_args),
> >        suite: ['unit'])
> > endif
> >
> > I see this test, I am trying to add tests that do not pull so many
> > multi_target_objects, as it would be huge.
>
> Agree, we should not add more binary.
> If you need truly multi targets test, this existing binary is a good
> place to start: just add a second test in it.
>
> > Just pull qom only.  And I am trying to call target_info() in
> > object.c, as inspect machines with
> > qemu-system is rejected, so maybe that's not an issue anymore
> >
>
> Seems like a good candidate for the multi-target.c test.
>
> >
> > I means Subject: [PATCH v3 00/10] machine: uniquify virt QOM names
> > https://lore.kernel.org/qemu-devel/20260926081551.29-1-luoyonggang@gmai=
l.com/#r
> >
> > So the current design always rejects types that do not belong to the
> > current target. Listing them
> > all is not an option at all. With this restriction, then these are
> > indeed not needed.
> > So I'll wait for your work first, otherwise it's always conflicting.
> >
> >
> >> module_call_init(MODULE_INIT_TARGET_INFO);
> >>
> >> If we want more tests, I'm totally ok to move this init code to
> >> target-info.c, and replace call sites if needed.
> >>
> >>>
> >>> Tools such as qemu-img and unit tests may link target-info.c without =
any
> >>> target-info-def.c objects. Their target list remains empty, so use th=
is
> >>> fallback.
> >>>
> >>
> >> Why should this tool get access to target list? qemu-img deals with di=
sk
> >> images, and is unrelated to targets.
> >>
> >>>
> >>> static TypeImpl *type_register_internal(const TypeInfo *info)
> >>> {
> >>>     TypeImpl *ti;
> >>>
> >>>     if (!type_name_is_valid(info->name)) {
> >>>         fprintf(stderr, "Registering '%s' with illegal type name\n",
> >>> info->name);
> >>>         abort();
> >>>     }
> >>>
> >>>     if (info->is_available && !info->is_available()) {
> >>>         return NULL;
> >>>     }
> >>>
> >>>     ti =3D type_new(info);
> >>>
> >>>     type_table_add(ti);
> >>>     return ti;
> >>> }
> >>>
> >>>>
> >>>> Is there another good value this list approach brings compared to wh=
at
> >>>> exists?
> >>>>
> >>>> Regards,
> >>>> Pierrick
> >>>
> >>>
> >>>
> >>
> >
> >
>


Hi, the cycle dependencies issue happened again, deal with it's a bit
nasty, there is workaround, but I think
the constructor list is the best, here is the rationale:


# Target discovery during QOM registration

## Problem

Machine registration needs the list of targets compiled into the binary.
Currently, it obtains that list through:

```c
object_class_get_list(TYPE_TARGET_INFO, false);
```

Despite the filter, QOM initializes every registered type before checking
whether it implements the requested type.

During `MODULE_INIT_QOM`, registration is only partially complete. A device
may already be registered while its parent's registration callback has not
run, causing failures such as:

```text
Type 'sys-bus-device' is missing its parent 'device'
```

The parent is linked into the binary. The problem is premature
initialization, not a missing library.

## Option 1: cache target-info QOM classes

Enumerate target-info classes once, before device registration starts.
Machine registration then reads the cache instead of enumerating QOM.

### Demo

Declare shared helpers:

```c
void target_info_qom_init(void);
const GSList *target_info_qom_get_targets(void);
```

Implement the cache:

```c
static GSList *target_info_classes;
static bool target_info_initialized;

void target_info_qom_init(void)
{
    if (target_info_initialized) {
        return;
    }

    module_call_init(MODULE_INIT_TARGET_INFO);
    target_info_classes =3D object_class_get_list(TYPE_TARGET_INFO, false);
    target_info_initialized =3D true;
}

const GSList *target_info_qom_get_targets(void)
{
    assert(target_info_initialized);
    return target_info_classes;
}
```

Initialize it before other QOM registration:

```c
target_info_qom_init();
module_call_init(MODULE_INIT_QOM);
```

Machine registration uses the borrowed cache:

```c
for (const GSList *l =3D target_info_qom_get_targets(); l; l =3D l->next) {
    const TargetInfo *ti =3D TARGET_INFO_CLASS(l->data)->target_info;

    machine_register_virt_type_for_target(info, name_suffix, arch_mask,
                                         latest, ti);
}
```

`target_info_qom_set_target()` should also use the cached list instead of
enumerating QOM again.

### Advantages

- Preserves the existing QOM-based representation.
- Avoids enumeration during incomplete device registration.
- Requires relatively small changes.

### Disadvantages

- Every relevant executable and test must initialize the cache before
  starting QOM registration.
- `object_class_get_list()` allocates list nodes.
- Callers borrow the list, so it cannot be freed while they are using it.
- Cleanup is possible after all consumers finish, but requires an explicit
  lifecycle policy. Keeping the cache until process exit is a lifetime
  allocation, not inherently an unreachable memory leak.
- Target-info types registered after cache creation are not included.
- Target discovery remains coupled to QOM class initialization.

## Option 2: constructor-populated TargetInfo registry

Each target registers its immutable `TargetInfo` pointer directly.
Machine registration later iterates the registry without querying QOM.

Use a statically allocated node per target so registration requires no
heap allocation.

### Demo

Define a registration node and accessors:

```c
typedef struct TargetInfoRegistration {
    const TargetInfo *info;
    struct TargetInfoRegistration *next;
} TargetInfoRegistration;

void target_info_register(TargetInfoRegistration *entry);
const TargetInfoRegistration *target_info_get_targets(void);
```

Implement the registry in shared code:

```c
static TargetInfoRegistration *target_info_targets;

void target_info_register(TargetInfoRegistration *entry)
{
    entry->next =3D target_info_targets;
    target_info_targets =3D entry;
}

const TargetInfoRegistration *target_info_get_targets(void)
{
    return target_info_targets;
}
```

Each target's translation unit provides its own static node and
constructor. For example:

```c
static TargetInfoRegistration target_info_registration =3D {
    .info =3D &target_info_stub,
};

static void __attribute__((constructor)) register_target_info(void)
{
    target_info_register(&target_info_registration);
}
```

The constructor must run exactly once per node. The existing target-info
initialization macro can generate this registration code alongside the
QOM registration code; user-mode target-info behavior should remain
unchanged.

Machine registration consumes the completed registry:

```c
for (const TargetInfoRegistration *entry =3D target_info_get_targets();
     entry;
     entry =3D entry->next) {
    machine_register_virt_type_for_target(info, name_suffix, arch_mask,
                                         latest, entry->info);
}
```

The sequence is:

```text
Target constructors register static metadata pointers
    =E2=86=93
Startup constructors finish
    =E2=86=93
Machine registration iterates the completed registry
```

QOM target-info classes can remain available for introspection.

### Advantages

- Makes target discovery independent of QOM initialization.
- Removes the explicit cache-initialization step from executables and tests=
.
- Avoids premature initialization of unrelated device types.
- Uses static storage: no allocated list nodes and no registry cleanup.
- Does not require ordering between target constructors.

### Constraints

- Constructors must only register metadata, not enumerate or initialize
  QOM classes.
- Consumers must run after startup constructors have completed.
- Each registration node must be inserted exactly once.
- Registry order must not be treated as a meaningful target ordering.
- This simple design assumes compiled-in targets; runtime loading or
  unloading would require additional lifecycle handling.

## Comparison

| Aspect | QOM class cache | Static constructor registry |
|---|---|---|
| Discovery mechanism | QOM enumeration | Direct metadata registration |
| Explicit startup initialization | Required | Not required |
| Heap allocation for list nodes | Yes | No |
| Cleanup policy | Required if releasing the cache | No registry cleanup |
| Dependency on QOM initialization | Yes | No |
| Registration-order sensitivity | Avoided through explicit sequencing
| Avoided by consuming after constructors |
| Late target registration | Cache needs updating | Requires a defined
runtime registration policy |

## Recommendation

Prefer the constructor-populated registry with statically allocated nodes.

`TargetInfo` describes the binary's compiled-in capabilities. Accessing
that metadata should not require initializing the device model or
maintaining an allocated cache of QOM classes.

The QOM cache fixes the immediate failure, but introduces an additional
startup contract and ownership policy. A static constructor registry
removes the underlying dependency and avoids heap allocation for the
registry itself.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

