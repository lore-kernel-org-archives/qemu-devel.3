Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOhY-00009r-71; Wed, 28 Feb 2024 13:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOhW-00009I-Rc
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:30:42 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOhT-0007Dn-5Q
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:30:41 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a441d7c6125so11617866b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709145035; x=1709749835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RFypXQ3BBJIjuIyOU4J/RMmaoxT3ProJqii1MZaUTk=;
 b=PSFBqzoh4d+jpTlvzV1XFP5tJY+bO4eHUrfJXUKTdU2Jp+MjQRRH1EKKJ8nFbD5pBY
 wXWSFQPhI2Ncba5IOzqGTz+AAbyIIKTUX+tVO23WunBXPnG0Y+MzBWnrV6QST96WUn39
 pWzOD01t1Oj/LIGBBCD1rxnDJKxYW/H7vID5FbppabxtKiVNMGjzNJCMBwJjVjHCcgeE
 PKuVjADxYj3k5SKBUgI4fCopABxQhfSfupQ7reFckW7hmxOR4pt412vDb3ebiEju5wCi
 3nfUps7rkKXq9KRYZXm7xdGtIh/9j85g8fAHO68N5jMRmkh5HD3Nleg9uRGuD2/wsgLf
 aBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709145035; x=1709749835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RFypXQ3BBJIjuIyOU4J/RMmaoxT3ProJqii1MZaUTk=;
 b=Y/JqGvxn4fcseBRFBWfkyqs2B7NTUVf9xxKuyCpAMs38iwdUhUUrcCdyIv2B6vdt+F
 RwA2C1t9KlulJVdEVB5hfcZg3OVI/kBGise5aS/H2pvt+peDCsmhCVchPnXP0jJJdUqz
 5JxqPwKasjH5tIWPOjsoxOl990aoBSE/WHUX7020NnBXaZvx55tUGh/tGgJFiqTnPWaE
 KE63HD18w+jJWUiVhVm8EZkx47rcm/0CKIUfcxlMENQzWxXfvto6M0LylmS9Bvv4OHG5
 V1gJr0s4WezWXWfpv/p8cj+2FOHLMkCnXAOoTop7YqY2/UXKx/TwcVq8/YJljdzhTRJp
 Ylqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjKIF0B7CiZQ4K6d0xNsUsRZ9LCOd5HM2S/JIQ4QvrSLg2REexN4uAvN/xIHrmCynbfwbbOGluupW0bRcaFypDNiYyFJE=
X-Gm-Message-State: AOJu0YzWS/h5/E5GjC0Fg0TQLLgi58SZ+lEmn0OSW2+PuyEMeBf3w/s2
 HNsZ49Cr+L5BgzcPCPMiA/bTLr9C2wGJJznNIcYI8bDfB8G1ptGxmYZkpe8XdskRKItpjPZ3Boh
 ShiX5CfNyVm4+rCrF4Jph+0oevyg+sC5TYeBz8bOU3Cv4pFLHpyM=
X-Google-Smtp-Source: AGHT+IEMBv5xmF4mvNzZUAwibfR5SKglrBEaavmY4IcdwbRr8VYpgORx8LJhnxJWpuf6zzcdc8YFk83IXvQmxtzISBY=
X-Received: by 2002:a17:906:5785:b0:a43:f927:4432 with SMTP id
 k5-20020a170906578500b00a43f9274432mr352145ejq.77.1709145035171; Wed, 28 Feb
 2024 10:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-2-hao.xiang@bytedance.com>
 <87msrk2abr.fsf@pond.sub.org>
In-Reply-To: <87msrk2abr.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 10:30:24 -0800
Message-ID: <CAAYibXjwBTcBFmUUs=L2BfTKgxi3Pym5S-5w-JOsZDmGdb9sgg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/7] migration/multifd: Add new
 migration option zero-page-detection.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x634.google.com
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

On Wed, Feb 28, 2024 at 1:43=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
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
> > index 5a565d9b8d..1e66272f8f 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -653,6 +653,18 @@
> >  { 'enum': 'MigMode',
> >    'data': [ 'normal', 'cpr-reboot' ] }
> >
> > +##
> > +# @ZeroPageDetection:
> > +#
> > +# @none: Do not perform zero page checking.
> > +#
> > +# @legacy: Perform zero page checking from main migration thread.
> > +#
> > +# Since: 9.0
> > +##
> > +{ 'enum': 'ZeroPageDetection',
> > +  'data': [ 'none', 'legacy' ] }
> > +
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:
> >  #
> > @@ -874,6 +886,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @zero-page-detection: Whether and how to detect zero pages. More det=
ails
> > +#     see description in @ZeroPageDetection. Default is 'legacy'.  (si=
nce 9.0)
> > +#
>
> I'm not sure we need to point to the member's type.  If we want to, we
> better fix the prose: "For additional information, see
> @ZeroPageDetection" or similar.

This is mimicking what was done for the "mode" migration option. There
aren't many enumeration types on the interface I can learn from.

Existing code

#
# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
# (Since 8.2)

>
> Two spaces between sentences for consistency, please.  Also, limit line
> length 70 characters.
>
> Together:
>
>    # @zero-page-detection: Whether and how to detect zero pages.  For
>    #     additional information, see @ZeroPageDetection.  Default is
>    #     'multifd'.  (since 9.0)
>
> Same for the other two copies.

Will change that.

>
> >  # Features:
> >  #
> >  # @deprecated: Member @block-incremental is deprecated.  Use
> > @@ -907,7 +922,8 @@
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
> > @@ -1066,6 +1082,9 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @zero-page-detection: Whether and how to detect zero pages. More det=
ails
> > +#     see description in @ZeroPageDetection. Default is 'legacy'.  (si=
nce 9.0)
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
> > +# @zero-page-detection: Whether and how to detect zero pages. More det=
ails
> > +#     see description in @ZeroPageDetection. Default is 'legacy'.  (si=
nce 9.0)
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

