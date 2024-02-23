Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80241C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdN4o-0003bY-2a; Thu, 22 Feb 2024 23:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN4m-0003bM-Gn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:22:20 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN4k-0006ya-MG
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:22:20 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3566c0309fso48850366b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708662137; x=1709266937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dujOaVMuVnBjIdun19nhNdkOrYNurs3v7HFGER9xfs=;
 b=RXQcXv7Ybklxpy4gkymz0nKwFXt7SDqlEWiu9sk92gpmCxcn2mIukbU5jC4XdL4rQg
 HEtGUWTGpKlsLxhwqEA33TfmHzsXVSpQ4bJdy/S3KhauHrVLf0d5x0YQvuNNDxyUFIzq
 8EIUhG1N6Wnm4FH4kBI1ouAd17sNpV7tqCrAbMfyctlrWN6QG5sKfKINjYI5YpJ/ywIG
 UZw1exymHnAoS/cdAGV9ta1ymlXtunN+m1ffP2plRpaZg81rwPOG0+PFu/dOtuUMEVhb
 oETqqQyunsTXRyiQ9zS62UtTzAImmI64ZP4OgmxvZzmrvWDt0m6twa/+niXfV3LjbYTn
 UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708662137; x=1709266937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dujOaVMuVnBjIdun19nhNdkOrYNurs3v7HFGER9xfs=;
 b=ld769d4+nqbC9V+V5AIGZVlgs8OI8aSH3LgQbsW6vUVlIZJUA0PJN+0usOJj72siVR
 Wf7aB1NrWBvyDIN5sgZzZWKJy790T79iiEEjW0mj5MUT3EIpQcOtP0nPE9QJQ6/YFx12
 kYQVrzpk15jzwiaHF74I+yom1LTqR1xJjWR/V0SNAQRDagniMKNrhKsZ3F/D+NCbPzOf
 FfYFa2KTQ6G/LaJn2SMklC+eA5j1UiIAJQkbWjykSjUXMfOVNDoM5NEtP6ESly0aCaRx
 B7pTAKXQ8CuEjMdIJlEhBBhM/K5O3qJxL27aisLb+S+d0qGPaYxF2Sz1t7Yi3DEl+YMf
 IdXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwcERqgedhvBJNLqbOyMxwt6wVe33cVFIz6W8WlfNMcmcWiul9vWzPUduEHSyQtXwEAKvU/dItjt1l1KfJPEpzInQODDk=
X-Gm-Message-State: AOJu0YyRsULV4nl9B6sXUr1f1LV+YX7CSXuRetbmZwPYwgkFHvc1La1M
 bvFdNSitdYuH5uzqJcMsIJkHUNpPJZf8CCnJrONHOo0dh6bVc1iaQMlKhQn97XsGPVK35tvi+TO
 FawlzHq6qiqYutaSR/IrIY437puwhfCw3RK1eVQ==
X-Google-Smtp-Source: AGHT+IEqv6Q/qQYmH+Z4qMdQ2MeNEcWBluORlO3OwXIYhM3sg8QmWeL/bwLVc3yiGlkVMGORDh79JB1mJEE+ni3QU9c=
X-Received: by 2002:a17:906:34cb:b0:a3e:a736:fe60 with SMTP id
 h11-20020a17090634cb00b00a3ea736fe60mr387669ejb.77.1708662137078; Thu, 22 Feb
 2024 20:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
 <87y1bet47a.fsf@pond.sub.org>
In-Reply-To: <87y1bet47a.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:22:06 -0800
Message-ID: <CAAYibXgYRzr_gzO00R6dfgikDK4njjyjtxDRK2yEWwwAjb0jzQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/7] migration/multifd: Add new
 migration option zero-page-detection.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62d.google.com
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

On Wed, Feb 21, 2024 at 4:03=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > This new parameter controls where the zero page checking is running.
> > 1. If this parameter is set to 'legacy', zero page checking is
> > done in the migration main thread.
> > 2. If this parameter is set to 'none', zero page checking is disabled.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>
> [...]
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 5a565d9b8d..99843a8e95 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -653,6 +653,17 @@
> >  { 'enum': 'MigMode',
> >    'data': [ 'normal', 'cpr-reboot' ] }
> >
> > +##
> > +# @ZeroPageDetection:
> > +#
> > +# @legacy: Perform zero page checking from main migration thread. (sin=
ce 9.0)
> > +#
> > +# @none: Do not perform zero page checking.
> > +#
> > +##
>
> The entire type is since 9.0.  Thus:
>
>    ##
>    # @ZeroPageDetection:
>    #
>    # @legacy: Perform zero page checking from main migration thread.
>    #
>    # @none: Do not perform zero page checking.
>    #
>    # Since: 9.0
>    ##
>
> > +{ 'enum': 'ZeroPageDetection',
> > +  'data': [ 'legacy', 'none' ] }
> > +
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:
> >  #
> > @@ -874,6 +885,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @zero-page-detection: See description in @ZeroPageDetection.
> > +#     Default is 'legacy'. (Since 9.0)
>
> The description feels a bit lazy :)
>
> Suggest
>
>    # @zero-page-detection: Whether and how to detect zero pages.  Default
>    #     is 'legacy'.  (since 9.0)
>
> Same for the other two copies.

I will fix these in the next version.

>
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -907,7 +921,8 @@
> >             'block-bitmap-mapping',
> >             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstab=
le'] },
> >             'vcpu-dirty-limit',
> > -           'mode'] }
> > +           'mode',
> > +           'zero-page-detection'] }
> >
> >  ##
> >  # @MigrateSetParameters:
> > @@ -1066,6 +1081,10 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @zero-page-detection: See description in @ZeroPageDetection.
> > +#     Default is 'legacy'. (Since 9.0)
> > +#
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -1119,7 +1138,8 @@
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> >                                              'features': [ 'unstable' ]=
 },
> >              '*vcpu-dirty-limit': 'uint64',
> > -            '*mode': 'MigMode'} }
> > +            '*mode': 'MigMode',
> > +            '*zero-page-detection': 'ZeroPageDetection'} }
> >
> >  ##
> >  # @migrate-set-parameters:
> > @@ -1294,6 +1314,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @zero-page-detection: See description in @ZeroPageDetection.
> > +#     Default is 'legacy'. (Since 9.0)
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -1344,7 +1367,8 @@
> >              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> >                                              'features': [ 'unstable' ]=
 },
> >              '*vcpu-dirty-limit': 'uint64',
> > -            '*mode': 'MigMode'} }
> > +            '*mode': 'MigMode',
> > +            '*zero-page-detection': 'ZeroPageDetection'} }
> >
> >  ##
> >  # @query-migrate-parameters:
>

