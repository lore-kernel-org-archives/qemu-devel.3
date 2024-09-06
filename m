Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BA3E6FE4B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 22:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smhT3-0000yH-F7; Fri, 06 Sep 2024 18:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1smhSz-0000us-S3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:30:10 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1smhSx-0003VN-PK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:30:09 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6d4f1d9951fso24157867b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725661804; x=1726266604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiHJplFRuRTOgNl77UncVfOiERQri7ijfay5XLXszKk=;
 b=XeOsDPi3yCdobUdTuJfrsBZUDCDlpqSSdeKwUFE4q474Pal+Jt9ersKT4JiZsPaNy5
 hfU7W/WcUZLFOrjQXGIyDCaVmELDtC44dsVF3tkeCS09Qq4R6nwM1m68KiEfTUWD7xOi
 jhhaQumXroXVpr2FfDzMOCXGDFur36eMnnF5rx56qKU8/kAQ2G7tjXOKt94i+FE9J6mq
 FyLMa1knTZ/j8j9XTyN2H68YrjeVxAytq8/pZ7TfK8NqyB0GsSAfOlUbs9R59RccpSlb
 P+2FgRunRmZRiSs64rhhblQ4mSJgXAzGozmxRbS9yJkwK44WEoHytMNvhhhuP03yG5vY
 b6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725661804; x=1726266604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiHJplFRuRTOgNl77UncVfOiERQri7ijfay5XLXszKk=;
 b=KTpNDR3jZlKcKPjLc2SiCe/9PFnQ9ss5OVug4fBN5ioUUoAVewoNMkmaC0G5psTbgp
 Vq1Yl2OgGrHHmwj2AVzGKqVySbMqPd0U1v0ke8tnnC6n5BI47CXreAljC1d5k8EV1Tyj
 UHUA4k3assvk4dN1Ll31ycQcKrtJ6XCqMdAVcTphpyyEg57wqUBf0git2P7tJQVqCp10
 A4mpoAbDtRnorhqEhgsrXky64dAeNENAfsEK2i0AVxZxN8GyZZeveXUrLpkSzCwvZbb4
 2NZ3SH7G51tS0AI8bK5N7E1EvpkyFUoa6VuS2U0GdAWgYLg42BBuiymPtYnIYFZz8eXo
 2OpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHoctnipK5NLaHBPZHsmjvCfkHn1vwjsC87zCielqaonPevUfL7S8kgfkSj50uDQsUwuuU9fA4Lnz@nongnu.org
X-Gm-Message-State: AOJu0YwvQ/m41L5aKyQW3uo6Vr+WB6nmwHKJlGkFDgFmiZW3Y3yCw/SX
 RbIuKjmN72GjqcVmgB36VIIlbquZ+oqhgcsHWfI/Un//5st7JKpi15abPh3qiBFRu/hlQs79qyM
 OJ/Fm9cdXVIzbUJLrTxHk1ZPsw/XuEsPuo2qyyA==
X-Google-Smtp-Source: AGHT+IFsidNPJCkcUbHw+7sLAugoqK9hBdH/9613YmIlgXe/HkCRRzd4Aj5df/bQo7J7290IAxwgsOG6Xol1gwrPfpk=
X-Received: by 2002:a05:690c:6202:b0:6ad:9550:7617 with SMTP id
 00721157ae682-6db4516c9c0mr59757547b3.32.1725661804338; Fri, 06 Sep 2024
 15:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-9-yichen.wang@bytedance.com>
 <CAHObMVZ1rifLMe-6R_Lttu_aOWDPvqv29sa6p_gz_7HROn00Tg@mail.gmail.com>
 <87y1603n21.fsf@suse.de> <87ed7iyhci.fsf@pond.sub.org>
In-Reply-To: <87ed7iyhci.fsf@pond.sub.org>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Fri, 6 Sep 2024 15:29:53 -0700
Message-ID: <CAHObMVYuo8qtXgPhZqR6+pb6yVjjUAJTiW=urU+84iW4NPRpsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 08/13] migration/multifd: Add new
 migration option for multifd DSA offloading.
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 24, 2024 at 7:50=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Fabiano Rosas <farosas@suse.de> writes:
>
> > Yichen Wang <yichen.wang@bytedance.com> writes:
> >
> >> On Thu, Jul 11, 2024 at 2:53=E2=80=AFPM Yichen Wang <yichen.wang@byted=
ance.com> wrote:
> >>
> >>> diff --git a/migration/options.c b/migration/options.c
> >>> index 645f55003d..f839493016 100644
> >>> --- a/migration/options.c
> >>> +++ b/migration/options.c
> >>> @@ -29,6 +29,7 @@
> >>>  #include "ram.h"
> >>>  #include "options.h"
> >>>  #include "sysemu/kvm.h"
> >>> +#include <cpuid.h>
> >>>
> >>>  /* Maximum migrate downtime set to 2000 seconds */
> >>>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
> >>> @@ -162,6 +163,10 @@ Property migration_properties[] =3D {
> >>>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", Migration=
State,
> >>>                         parameters.zero_page_detection,
> >>>                         ZERO_PAGE_DETECTION_MULTIFD),
> >>> +    /* DEFINE_PROP_ARRAY("dsa-accel-path", MigrationState, x, */
> >>> +    /*                    parameters.dsa_accel_path, qdev_prop_strin=
g, char *), */
> >
> > This is mostly correct, I think, you just need to create a field in
> > MigrationState to keep the length (instead of x). However, I found out
> > just now that this only works with QMP. Let me ask for other's
> > opinions...
> >
> >>> +    /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
> >>> +    /*                    parameters.dsa_accel_path), */
> >>>
> >>>      /* Migration capabilities */
> >>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> >>
> >> I changed the dsa-accel-path to be a ['str'], i.e. strList* in C.
> >> However, I am having a hard time about how to define the proper
> >> properties here. I don't know what MACRO to use and I can't find good
> >> examples... Need some guidance about how to proceed. Basically I will
> >> need this to pass something like '-global
> >> migration.dsa-accel-path=3D"/dev/dsa/wq0.0"' in cmdline, or
> >> "migrate_set_parameter dsa-accel-path" in QEMU CLI. Don't know how to
> >> pass strList there.
> >>
> >> Thanks very much!
> >
> > @Daniel, @Markus, any idea here?
> >
> > If I'm reading this commit[1] right, it seems we decided to disallow
> > passing of arrays without JSON, which affects -global on the
> > command-line and HMP.
> >
> > 1- b06f8b500d (qdev: Rework array properties based on list visitor,
> > 2023-11-09)
> >
> > QMP shell:
> > (QEMU) migrate-set-parameters dsa-accel-path=3D['a','b']
> > {"return": {}}
> >
> > HMP:
> > (qemu) migrate_set_parameter dsa-accel-path "['a','b']"
> > qemu-system-x86_64: ../qapi/string-input-visitor.c:343: parse_type_str:
> > Assertion `siv->lm =3D=3D LM_NONE' failed.
>
> HMP migrate_set_parameter doesn't support JSON.  It uses the string
> input visitor to parse the value, which can only do lists of integers.
>
> The string visitors have been thorns in my side since forever.
>
> > Any recommendation? I believe all migration parameters so far can be se=
t
> > via those means, I don't think we can allow only this one to be
> > QMP-only.
> >
> > Or am I just missing something?
>
> I don't think the string input visitor can be compatibly extended to
> arbitrary lists.
>
> We could replace HMP migrate_set_parameter by migrate_set_parameters.
> The new command parses its single argument into a struct
> MigrateSetParameters with keyval_parse(),
> qobject_input_visitor_new_keyval(), and
> visit_type_MigrateSetParameters().
>

I tried Fabiano's suggestion, and put a unit32_t in MigrateState data
structure. I got exactly the same: "qemu-system-x86_64.dsa:
../../../qapi/string-input-visitor.c:343: parse_type_str: Assertion
`siv->lm =3D=3D LM_NONE' failed.". Steve's patch is more to be a read-only
field from HMP, so probably I can't do that. Markus's suggestion seems
to be too heavy for the patch and I took a quick glance and it doesn't
seem to be easy to do.

So should we revert to the old "str" format instead of strList? Or how
should I proceed here?

