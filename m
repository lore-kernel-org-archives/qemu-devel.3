Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DB3D1CDB9
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 01:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQyAx-0001xf-Cf; Wed, 03 Dec 2025 20:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vQyAu-0001xB-RG
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 20:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vQyAs-0006Xv-Tk
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 20:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764811825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKI2JRdqW86MiDwE76sILApaXpcT4o+8q1KOG6/+JhQ=;
 b=L5qvLQR28bdpjX7UW/ILO/5ys+4Oue55+NL7b2Ht6mKrR4GZRsklpVcoZ044ZSHtabyuLj
 Oi8yO93TNfutMDG92Npc6ylYCzrw3lQTUuxsg6aGaz0NfpKNxyTV7GHw7nWQTtobKIESnu
 bnqJCV8S4Zb+NIGn/b1SonBXJGNLGh8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-D1ppdVbuNsWhErCZbIEgFw-1; Wed, 03 Dec 2025 20:30:22 -0500
X-MC-Unique: D1ppdVbuNsWhErCZbIEgFw-1
X-Mimecast-MFC-AGG-ID: D1ppdVbuNsWhErCZbIEgFw_1764811821
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-787e31befddso6211387b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 17:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764811821; x=1765416621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKI2JRdqW86MiDwE76sILApaXpcT4o+8q1KOG6/+JhQ=;
 b=ahv7aupusfFAmspWmyMfpfnJPMIP4JMvlvAGC93Ii9YMmF8j1+alHcyPcCw/4eAIDB
 IV4hrn+e2Urrc5RPxUj2bGVI9RSF2tBH4hjVaiY+Omlj5MI/tnwKkRdrWKWgPs4amhqR
 sJVJW7rFWs8eWz/ZN10jezZxTwIsg3Ch8Y5SCzWDfQ2E3zOWgRdttX1Btpr7ZtNtTKgK
 o1rup4UFqAYajXxon65GUYdyOXI55fpD1Yicfceh66nORPAQUSAkqCWmh+cLw6pQOS5i
 lOw9LAw6NmEdMllxRcYH2vRnxp7KHmtLDQRIK8sqAfdpos2DjquwUBYtchsTlprdDuIq
 3eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764811821; x=1765416621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKI2JRdqW86MiDwE76sILApaXpcT4o+8q1KOG6/+JhQ=;
 b=FdAnt9QLPGJj+Dp31hjQUUGfeHVyXn8e2XYY8ahMhyrl809ViT69KubnvzExQmaj8q
 D4m0iHrrjHFHsezXuHelt/v6UD6ACwq/xjSTsq5dqSLdZDQbQ+P6cMxP+RVgoScAH895
 GkS3QeTr1HdDhgxKv34j8HulbR33KC6Du/H2Wk+lEDvMRCQ/1UUOoR5g0v1o5pETGrPy
 6A8juCD5iWhg/+hsOXRhKj7kbFMnYmq+p9JyhBvR8IzkKbqjQ23YpF3vvhxwCQT5ZLxi
 85xKY8nguBkW8vUWn640TkGulGubZ/6VtkNd6KOXb060MejQI15s1bX9QzqIfWtJrNCi
 WhTQ==
X-Gm-Message-State: AOJu0YwMlKWYULeBbPliZBfzYwoufEaTARC6umVnrmUCJ6uR/2jzl61g
 JqHNVkiF5ZImXgQL/gTaerfu45u+uMQamH6QAB3AP90Izmf8VmH2ElEzfymS7T5znPyXHOE0biN
 nUPv3nJkiOUp36L41Tkq4H3EGHSR4g9X3IKLjzpvpWa0tzhsFku3ur38kRvxnoNrFNqNJsBUESv
 6oPoWyeypBJyVZ76Qr5v3eZbJM5DkoOgM=
X-Gm-Gg: ASbGncvGG1cFD9nfqS6aoIYTdgzidjNOgZnxgH0ykLuI3ik1bkHmqEZLDusQaOIQREv
 8801030Uh4Yr13t7Fyjp9Zv0CSjY4rlz4PFLFbAf5r5qFIKkz96112I7dzv01ljn3x9TIUYVFS6
 mi2QQEZUqYhWTeAK459HLnuBfZxqLM/j/+5cPA7ak40du/tq/i1DHVh/3mS3uYwnYlaJ0DgX8w6
 FRWhmRaYO4zvSDPV5oYVSRyLA==
X-Received: by 2002:a05:690c:f82:b0:788:65:6dd4 with SMTP id
 00721157ae682-78c0c030816mr37044137b3.22.1764811821461; 
 Wed, 03 Dec 2025 17:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/rrtr1X3FLwUvvb833/PP30KCCrpqNOySEkcMuVt2x348sUbYR3GAY7Xx88891e3TjlulGUmrAwY9MtbBa2w=
X-Received: by 2002:a05:690c:f82:b0:788:65:6dd4 with SMTP id
 00721157ae682-78c0c030816mr37044007b3.22.1764811821130; Wed, 03 Dec 2025
 17:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20251125040045.461148-1-jsnow@redhat.com>
 <20251125040045.461148-11-jsnow@redhat.com>
 <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
In-Reply-To: <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Dec 2025 20:30:10 -0500
X-Gm-Features: AWmQ_bnaehe0m60SAGGmjaWrbZdNtum5e_ohoZvjroz2TvkgRdv0IsmffCLQiUw
Message-ID: <CAFn=p-axAi5zewtfkDFxEpNADs-RH3Jbuoj0sGu7oBkgKLrN0A@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tests: conditionally run "make check-venv"
 during build phase
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 26, 2025 at 3:16=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 25/11/2025 05.00, John Snow wrote:
> > Some tests need test dependencies, some tests don't. Instead of running
> > "make check" manually, use a CI variable for the template that allows u=
s
> > to front-load the testing dependencies without needing to incur another
> > re-configure command.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest-template.yml | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildte=
st-template.yml
> > index d866cb12bb1..cfa123d3a10 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -32,6 +32,10 @@
> >         then
> >           pyvenv/bin/meson configure . -Dbackend_max_links=3D"$LD_JOBS"=
 ;
> >         fi || exit 1;
> > +    - if test -n "$SETUP_CHECK_VENV";
> > +      then
> > +        make check-venv;
> > +      fi;
> I'm not sure, but I think this is likely not quite working as you intende=
d
> it. The above code hunk is added to native_build_job_template, i.e. it's
> executed for the build-* jobs, but in the next patch, you only set the
> environment variable on the crash-test-* jobs. I don't think that the
> environment variables propagate backward from a later job to an earlier o=
ne.
>
> Looking at the output of another build job, e.g. build-system-alpine:
>
>   https://gitlab.com/thuth/qemu/-/jobs/12211712932#L2156
>
> ... it looks like pygdbmi is now also always installed there, i.e. someth=
ing
> else triggers "check-venv" on all build jobs now, and that's why you were
> able to drop the "check-venv" in the crash-test-* jobs in the next patch
> now. No clue what's causing this now, but IMHO it should be fine if we ju=
st
> unconditionally do "check-venv" in all build jobs anyway (we also need th=
e
> venv in a bunch of other test jobs anyway), so I'd rather do the "make
> check-venv" in this patch unconditionally here, and drop the next patch t=
hat
> sets SETUP_CHECK_VENV in the crash-test jobs. WDYT?
>
>   Thomas
>

Yeah, it wasn't working. Oops, and good catch.

I moved "make check-venv" into the build-system-debian/fedora phases
instead and that works like I expect.

However, the pygdbmi bit is still confusing. Apparently both of the
new ensuregroup targets get installed with "make check-build", even
though they aren't used for building anything. I'm trying to sift
through the make system interplay to figure out why it's part of that
target...

--js


