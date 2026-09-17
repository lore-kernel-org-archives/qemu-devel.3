Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E08CC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7IUC-0004EW-EG; Thu, 17 Sep 2026 16:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7IU3-0004Dl-E0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7IU0-0001P5-Iw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789676001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sT7ZXu7aEut3ytCdh89tjweYSTEfKLIplAEWTmk3Csg=;
 b=QVfZyfEIvp0USyPeWuG+3F0Xa+mKpquf4o5pIv0vGATKREWmFfCTQAlKoWSVO/mhMTG0am
 01oUymX8vocpU39tEY/hGuBNe1G9/xI73UTp9tXshIGKDs3pMluze7m9ykNEWYhqcyUi4L
 JmwvUlxlrq/STzcR200LvTP5wkqqIAM=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-s4JuZYGdPb6YxluRqPdIZg-1; Thu, 17 Sep 2026 16:13:19 -0400
X-MC-Unique: s4JuZYGdPb6YxluRqPdIZg-1
X-Mimecast-MFC-AGG-ID: s4JuZYGdPb6YxluRqPdIZg_1789675999
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66f8ab159abso67892d50.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 13:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789675999; cv=none;
 d=google.com; s=arc-20260327;
 b=hdQiaR8KABiAtVzpmC3/wegv6iLqx8oN5CruwUUV7+6Zyd2VzzcoWlkDTawUF5wWJV
 KMAR53zHtPydHDB+I0EtIClGnNdZsHAcakD2ToxALnD8UAWKpxDyHAA0O/i/ayq9hJD1
 jer40fPkjROVchfw6CiwhwcjsUNwQBnG+fLAYI1//vqiyqiBKF4xC5TXEG0YuWE0DuSL
 gu8V3xOwqp3LNUrWX1G0O72r2Z3v9FhLXtMXrGhR7UKQhi0fzxUSi84PnRbDJ3cH/JvB
 xNRTsBM5ApCfjABr/tvJNRlvUKdKwgOAjOyEblmIrlJnHpoVNVFOD3pjYi3aSB5k09Yi
 /o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sT7ZXu7aEut3ytCdh89tjweYSTEfKLIplAEWTmk3Csg=;
 fh=6/3MBLY771l9Tjbp9sIrjfuM3gYSL1dAxCLrcHqISag=;
 b=X8NWXA+GmqoMJHI2D4xlI+Zdh+dapiN0WOW1cEDE/+Jj2jl/vhwgZLsO1T/j2Xjqe6
 k6nl8jJ8kBxGRLvAjCqc5m9nMmzD3jVBhx6+ZFXM5tZlxOVNXhuVXu6af68tar8/G/Qv
 BoRulfWwwMEPJl2uSjvVNL1DF2i32TSjrIRogVVzTJOgrQW2wqfa0ZgOzq96vqciQn6U
 RxEuFD+eGBn0FPbRNNcGxmuf5N3MXrEyrMuvyHb18L/BLTFTVVZIsIYwBV8FPhwDtRns
 SXu7nnrY1AnkrFt+Xz3IL6QAqfI+ajlymIRNVen30eG9eHR5HCAi0V189NfkQtSCKcoR
 9IxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789675999; x=1790280799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sT7ZXu7aEut3ytCdh89tjweYSTEfKLIplAEWTmk3Csg=;
 b=ntFUP+rlMfxQyFyYDgg2JxbEb14X1vfnnyYe2/q0rP5A+Cj20XMj9HaNsIlyEzV1ae
 bQXO+dy+n+Z2pFAbICyxwebrdPxfD+iEI7i+aJAac6djfQkPHl21pgr6Q8wvzL9wlrip
 FyPlK16KHdiH4Eu7ANDHzGiF/scwMJg1ONfZaIN+RNwTRAYaxbtPBUlMfjbNFoQdWWnn
 c9GYb5hZKIsduhK0Qoe//geqkk2Yl9WIGdO2yaTdKxkKTYAfORJNX6UOIyzOZRMQVYKE
 C2AWZeAQvZpDd4aJDhGfkzwzyesLFyIHN6WOtn3acK5A+c2X6PyKSGlqvT48TyB1RJPW
 ib7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675999; x=1790280799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sT7ZXu7aEut3ytCdh89tjweYSTEfKLIplAEWTmk3Csg=;
 b=XIv+ap+rf6dvz5epoB45JPn7xTtbTxmSruRYXXSu6IVEHjKXOrK32xZEQhZCKzOIXi
 yZ4k9zolT7RV49rp0k5IgLZM8CS+Pj0j1867shmi9N+OGq1IfZHqZyYNWg64bdz628Zn
 0yBu6MAvQTkBcn2xns/uv7VXvpKGabuTVicoyklfGHV+cJfeLQnWr+OIqb9a14yNuIol
 x0J17XxBM3K9jZPmBQk8vi6lG+rc//ipVgtZGAcSR+oFe4QQ8AAQ8eGVZBEwgad/Stb7
 xYcGroHRLvBqpf8WGYB7+K+T93vKihn+GfnEt8qLQ42JlfX1W91exCpBt7Us0omPyWzM
 JCyQ==
X-Gm-Message-State: AFuF++k4K1lBGyC7jwIEXGK4p6Mb6lIPR5ZZDw9TawtwRhbbdzB+sOIz
 Mc7HuyqkWdOwwgJH0EaFk4SqW2m2jLstmquMReBKVTEvqUtRqnOjlMevIfJp9mRzW2J0EsIHoqS
 ZaSXJgz5nxvAvDERNsJ00wCcHULP60Y2rZzDQAt9qGgtiY0aPEaGzOLmo4qNFTa00Bf+YELI7aD
 gFse0bC6LP6Ec66ws7Ob9lU1Jxi5TDlP0=
X-Gm-Gg: AYBFou06dxS+pzHsBASuhRNebvXyW4ocQFOiAKSeihrG96iDKlCjF2S8fVTM1ruDEmm
 EDf7YrqAdG9G7hAS98dKU7m+lEwKP3pqQHHcd4HvLWnJtz9dPee7fOOP7Qoj1By6F7dRuT+jS03
 XRvQ9ssL3GLu8dVyrarEzLVgo0VjAWdfV0AVuB6ZamqTF6CTXsGi9C0CT+chmJXbseBg3cRtm50
 /nlB7/V4J4mGjxg
X-Received: by 2002:a05:690e:4411:b0:671:4769:62b5 with SMTP id
 956f58d0204a3-6717fcbd733mr69524d50.36.1789675999121; 
 Thu, 17 Sep 2026 13:13:19 -0700 (PDT)
X-Received: by 2002:a05:690e:4411:b0:671:4769:62b5 with SMTP id
 956f58d0204a3-6717fcbd733mr69519d50.36.1789675998738; Thu, 17 Sep 2026
 13:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-4-jsnow@redhat.com>
 <87zexhbk8t.fsf@pond.sub.org>
In-Reply-To: <87zexhbk8t.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 16:13:07 -0400
X-Gm-Features: AcwNN1XdEOB7AvS6asFzZ94aMDS8NoELEB2c9NesoYcE4i8hDsWdJ5bs1SZmk_Q
Message-ID: <CAFn=p-Zzz0FFMeRgd7_7G0if5-CS7Trk=nX0P2w1i9NxfQ-mPA@mail.gmail.com>
Subject: Re: [PATCH 3/9] qapi: convert multi-paragraph intros (enums)
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 16, 2026 at 5:47=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > This patch converts some slightly-non-trivial intros with more than
> > one paragraph, but doesn't create any new intro/details splits.
> >
> > Review notes: The "See also ..." texts here are prime candidates for
> > moving into the details section with a ".. seealso::", but like the
> > last patch, as these are for enums and not candidates as an inline
> > source, I left them alone for now to keep patch sizes and motion down
> > until after initial review.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine.json | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 0516112f8e8..710b638b3bf 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -608,12 +608,12 @@
> >
> >  ##
> >  # @HmatLBMemoryHierarchy:
> > +#     The memory hierarchy in the System Locality Latency and
> > +#     Bandwidth Information Structure of HMAT (Heterogeneous Memory
> > +#     Attribute Table)
> >  #
> > -# The memory hierarchy in the System Locality Latency and Bandwidth
> > -# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
> > -#
> > -# For more information about `HmatLBMemoryHierarchy`, see chapter
> > -# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
> > +#     For more information about `HmatLBMemoryHierarchy`, see chapter
> > +#     5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
>
> This is one of the "see also" you discussed in the commit message.  Such
> references tend to belong closer to the end, not in the intro.  Moving
> involves a split.
>
> More of the same below.
>
> Not splitting now keeps the conversion simple, which is a plus.  It
> reindents the entire unsplit intro, and if we do split it later, the
> part split off gets reindented right back.
>
> I'm happy to leave this decision to you.  I'm adding to my notes on
> future work:
>
> 8. Move "see also" out of intro
>

If you believe the ultimate destination for these is below the fold,
I'm happy to do it now. I just *didn't* because I wasn't entirely
sure. If you are, let's get it over with.


