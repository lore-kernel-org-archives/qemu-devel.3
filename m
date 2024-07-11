Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B566C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwvX-0008ED-TP; Thu, 11 Jul 2024 12:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRwvM-0008Cz-1o
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:45:40 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRwvI-0005Sp-Np
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:45:39 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-79f323f0898so67743385a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720716335; x=1721321135; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwQi8LcVHnumv/0YPTSX3fcS0Wc68AmyCeKbugtTAEk=;
 b=GAUaWGDG7JymVUNtDLskB44bTNGInB2bViwPiPD4+J1AiAcJr1NRVPdke65QMmJlCg
 w7p0uAozERVQ/J5CzvzoVhxRS9NSrwKU18pgFPAYVLzwibcz4gid2yvdUrXy738BvRxm
 wLm2ybLHurIQ2u7lyknTMJPkbsb4o19YaofaY45MbyFeI5gcHhRy3/1xESFpM7c1yhhZ
 5SAkCsCsXCZl2mXq6w+T3SoVs1z1t/7Nx1PHqfyyy+9cQP1b6kfkstcxH+00DbV0IUq+
 BSIBIJsp9HbTt4keD3g9zS9oA5DV4XNvohXps1jh5XFKdmfPejxprT+5j0qFJr/WBMgO
 5fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716335; x=1721321135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwQi8LcVHnumv/0YPTSX3fcS0Wc68AmyCeKbugtTAEk=;
 b=l3qjUbjj+n1c9zVOUztZZ0aYTWkTPQEx77jA/Un20zVk1TP22mVVNhQSeUdLAAp4/g
 0LrAdRtlPpmdiCO6PgkcLxxiOwu3ex4E/xfudUk/v1xAqPGC1ulwAoz6ou1gr9fiPGeI
 ZWVnWt+RasAtShzoajyJD4wF+LVAdfdfow57bpW3Z7+734pMdjQ3tUuLd6jy6lXely/C
 chMARixfA5V/vkQclGXnydT7hDfH0s/maj/CNjqgOdlPZ4k/IexFIXEWatXboygkNDX7
 EaK3f5qh13uR1n1C3VZFedCt9Vb/WQ54BWWjPXtDJIhYmXvbaDo1p0KzjySnyRcjNtZy
 3nJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEkS9mFLm3yDEWjreWA8OVcCZsx0hwqJ/ycUJkd+P8eZQsEDLr3uCi6mHUcLKcbWFn1oKyDpGHJPL/UcZCjoEdwPhKR14=
X-Gm-Message-State: AOJu0YzHRki1v84kjPAE0c8mDOi2f84jFPn3Tiznsbt7Z8qVvh7a75zC
 4edIK6oZ6tmESKLpMKwmstwhyzttotkFMLbgaakcYXZ5RNz61GaCfRGNIoD3NQixhzcwckaueRK
 rYDgIYWQwMMQMORHMT1yqnjYGGJv2GfXmQdiKqw==
X-Google-Smtp-Source: AGHT+IFFqbRzCimu9LKg1Sqgg1ECjDbforPRhnZ5ou+IHjIdxxGrBwR6LrmUg13a/6aujtcsTwB3d30E2IoIMk7NNpE=
X-Received: by 2002:a05:620a:1913:b0:79f:b72:fb30 with SMTP id
 af79cd13be357-79f19ab9515mr1287464785a.59.1720716335416; Thu, 11 Jul 2024
 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
 <20240711025229.66260-6-yichen.wang@bytedance.com> <Zo_q0UKEwEi3KWsJ@x1n>
In-Reply-To: <Zo_q0UKEwEi3KWsJ@x1n>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Thu, 11 Jul 2024 09:45:24 -0700
Message-ID: <CAHObMVZCbAe3ff-p2A-h2+3PBNydYe3vXgUojOR72ruPQvLmCg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 5/5] tests/migration: Add integration
 test for 'qatzip' compression method
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 11, 2024 at 7:23=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 10, 2024 at 07:52:29PM -0700, Yichen Wang wrote:
> > From: Bryan Zhang <bryan.zhang@bytedance.com>
> >
> > Adds an integration test for 'qatzip'.
> >
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  tests/qtest/migration-test.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index 70b606b888..b796dd21cb 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -32,6 +32,10 @@
> >  # endif /* CONFIG_TASN1 */
> >  #endif /* CONFIG_GNUTLS */
> >
> > +#ifdef CONFIG_QATZIP
> > +#include <qatzip.h>
> > +#endif /* CONFIG_QATZIP */
> > +
> >  /* For dirty ring test; so far only x86_64 is supported */
> >  #if defined(__linux__) && defined(HOST_X86_64)
> >  #include "linux/kvm.h"
> > @@ -2992,6 +2996,22 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTes=
tState *from,
> >  }
> >  #endif /* CONFIG_ZSTD */
> >
> > +#ifdef CONFIG_QATZIP
> > +static void *
> > +test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
> > +                                              QTestState *to)
> > +{
> > +    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
> > +    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
> > +
> > +    /* SW fallback is disabled by default, so enable it for testing. *=
/
> > +    migrate_set_parameter_bool(from, "multifd-qatzip-sw-fallback", tru=
e);
> > +    migrate_set_parameter_bool(to, "multifd-qatzip-sw-fallback", true)=
;
>
> Shouldn't this already crash when without the parameter?
Ah, my bad. I tested the features manually with two machines, and
didn't run this. I will fix it in my next version.
>
> > +
> > +    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qa=
tzip");
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_QPL
> >  static void *
> >  test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
> > @@ -3089,6 +3109,17 @@ static void test_multifd_tcp_zstd(void)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_QATZIP
> > +static void test_multifd_tcp_qatzip(void)
> > +{
> > +    MigrateCommon args =3D {
> > +        .listen_uri =3D "defer",
> > +        .start_hook =3D test_migrate_precopy_tcp_multifd_qatzip_start,
> > +    };
> > +    test_precopy_common(&args);
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_QPL
> >  static void test_multifd_tcp_qpl(void)
> >  {
> > @@ -3992,6 +4023,10 @@ int main(int argc, char **argv)
> >      migration_test_add("/migration/multifd/tcp/plain/zstd",
> >                         test_multifd_tcp_zstd);
> >  #endif
> > +#ifdef CONFIG_QATZIP
> > +    migration_test_add("/migration/multifd/tcp/plain/qatzip",
> > +                test_multifd_tcp_qatzip);
> > +#endif
> >  #ifdef CONFIG_QPL
> >      migration_test_add("/migration/multifd/tcp/plain/qpl",
> >                         test_multifd_tcp_qpl);
> > --
> > Yichen Wang
> >
>
> --
> Peter Xu
>

