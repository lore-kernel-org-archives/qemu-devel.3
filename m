Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66FCC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOw6-00063k-BG; Wed, 28 Feb 2024 13:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOw4-00063O-IZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:45:44 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOw2-0004OK-Lw
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:45:44 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso211740a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709145940; x=1709750740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adOEWGsF8RJgcosuwQS6sn1a1qfk1y0pZpoY4ISf0MQ=;
 b=P/dZ2tgij85qAu+HPmvte4+JTYshk4pXHUwbF76A/aXhs8s0bCPE2ed3oejjIbmHWH
 tyDhPfpZHNGPc3EnGP1qaRvLo/Vah0/GMVZ+ovIFj0ikx9pNFqMe9nw9hdd1v6ZzBCyG
 wKj504OQ+5ubjzLnhLn8dxvd6c4+ZtUphE6PBD9RSNQmNoZKJ9irawo47vTamsGEBhjq
 QpSvps6XqcAO2FwOOaDMmeBZG9xmQrPNlLj7kdcPQau2TJ5A8P+swmks4GCUXNHJIkkh
 FjEvSJghVwZCUl3LhAjxFH8R8fknqjiZAt6v5mTq0x08gdY5lV9EkWfmreIojo58GPbd
 I1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709145940; x=1709750740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adOEWGsF8RJgcosuwQS6sn1a1qfk1y0pZpoY4ISf0MQ=;
 b=RGlpjw5Z6SNGFhNDTWYG/mTtYMGH2LS0pwl/qAfq3w3tmIoiry2oz89+ZXa3QMEJEq
 UIB+mqElFloeuHPelaDhY9OAFP4x/58+BWVq5fdneUuMMiQMZIbNInbEEwROeeywM0eO
 e3Q4svPhDDso3BPbX8l4d1Bzn0pU8EatAQIrCnypckGrqBWtI2cJ9b/DF3XJnkOuuQBN
 MR8iHKolo7XcVEfF5rNBjrUez8x4O/7M3LYScQe2Yr94NICDkeq9IYZ9I/XuIRpOD6Lw
 dA+nBPTHXu9LKdIB6XioxLKKzmhh3/Ha70jRkG4+Im+K1O+AJfEXEdCLj5jqEbZyDWai
 aJRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwT2i2BP/xWMXpo1pd1ACfWY0CgUapusWUAHDrFbT3KAr6JTWytFHBYzUHtJ7moN3uu8TT5iV+apk8BtGOUT+YLDVfOSE=
X-Gm-Message-State: AOJu0YwmGyulciXkJ3j1E6KGqj4KC4eeL6hiVGUoZ5uuh1SzQw5W9Vu+
 3GdM4GFs/Z9FMKQG1ZN4SgduaNbpemeQe1+axJQ01ISeVju+B7WnnAfDwZknypOqsC/qcKXlRq2
 qpq/Ej4BnxNtvDzZ7uv3zcZOtPbmDHCvh9aBBNA==
X-Google-Smtp-Source: AGHT+IH3YXwpQVsI4nhcMO7GlJHZgL4fa2viPOR49LVLqqrO4dn7wuvoj3RPCLg7+8rselR9AtFoaqJXJm8zRO457DU=
X-Received: by 2002:a05:6402:14c6:b0:565:50f8:bad5 with SMTP id
 f6-20020a05640214c600b0056550f8bad5mr189234edx.30.1709145940269; Wed, 28 Feb
 2024 10:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
 <871q8w29zx.fsf@pond.sub.org>
In-Reply-To: <871q8w29zx.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 10:45:29 -0800
Message-ID: <CAAYibXgdaH_=JxswvKaz9qaXRFuRncmkrrSpkqSMbFu=3ypfLQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52a.google.com
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

On Wed, Feb 28, 2024 at 1:50=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > 1. Add zero_pages field in MultiFDPacket_t.
> > 2. Implements the zero page detection and handling on the multifd
> > threads for non-compression, zlib and zstd compression backends.
> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> > 5. Adds zero page counters and updates multifd send/receive tracing
> > format to track the newly added counters.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>
> [...]
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 1e66272f8f..5a1bb8ad62 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -660,10 +660,13 @@
> >  #
> >  # @legacy: Perform zero page checking from main migration thread.
> >  #
> > +# @multifd: Perform zero page checking from multifd sender thread.
> > +#
> >  # Since: 9.0
> > +#
> >  ##
> >  { 'enum': 'ZeroPageDetection',
> > -  'data': [ 'none', 'legacy' ] }
> > +  'data': [ 'none', 'legacy', 'multifd' ] }
> >
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:
>
> What happens when you set "zero-page-detection": "multifd" *without*
> enabling multifd migration?

Very good question! Right now the behavior is that if "multifd
migration" is not enabled, it goes through the legacy code path and
the "multifd zero page" option is ignored. The legacy path has its own
zero page checking and will run the same way as before. This is for
backward compatibility.
>

