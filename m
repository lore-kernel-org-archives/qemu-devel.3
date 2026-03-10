Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC2EF41808
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztjH-0000lN-6s; Tue, 10 Mar 2026 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztjE-0000kw-6R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:50:16 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztjC-0001pW-1O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:50:15 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-662b933f8d1so1677155a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773136211; cv=none;
 d=google.com; s=arc-20240605;
 b=a7vfoXotpDVA3ooAryY+3j5njCNhwJGf0FWPF/abmIvDdUiXJgqHRFx8p7YEjFnr2g
 hs9cvaV6+SsBE6gPWgabAIzGYSf4FlGDwFPN+T6oDq1gcjh2NLXp7kMp6kCDzPW10PmV
 gYpXk5WclIINXJLCRvoX/BxokERHf1IzUuPNQKgnZyLlduWKVZxqLl44LKbQwluJOGRJ
 m2kpsevHL7OIWBJ6FAlJ/hnex3KlOrxumzWUkAHdoYVk4zxFuVbiQz780yyefq/qsh1s
 lnGpF4OxWLaLkW6sQ69DhPbsRZbLjps6gHKF6IRw5U68DhqdlIWWnFDAa/mCkNvMVjGg
 SrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J/+gYB7EWaZWmJ8zT0546TEdznqBT2H0GqDVZGHC9Ow=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=Raf8FEPvBDz1otlFRlxAceTtqtnNIKyk7abaJptvdFsAqDCRYmusVRN+M++ux2LQnX
 8A2+mnhz8Cj7p8D9YZ5xs0Cl6jb2lXXpmhEquYmvYvMrWfRDOKPP9Lhe3sksnHhXTCFs
 yvhesZAUcA55/ihyPc5FDBoojoVvq4tir4l9sZ9UFIvbO4AbukDCSEM1IZTeI2AAgRUc
 PpB2jhhA1myVsZIx/29K1bj6Pxi+7pLF4YcX0RqMb946kb2hnIluPD3qn+8JZqmslLV5
 vQ2MlB0xYqHSaum2VRA6SAcqGxV0Gfokzw4/Z5uIVT5cahnRpcqRwLNuAHzP9lMgy1ex
 w0yg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773136211; x=1773741011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/+gYB7EWaZWmJ8zT0546TEdznqBT2H0GqDVZGHC9Ow=;
 b=aldTgaS1vaCOStRD+RPFp3LtIPtx8vkRlij4wksmPOGWe9wxgqWjVDMLd2Iem49xeN
 +F5Gk2n+Toib9RxsjBCXGi/kksff/eZYDW329Fe1sNSNSpjolqxXGP/yShIAmLc2LAdx
 xBhEhGHyi1mpbQYLA4qJRU3K868HipwBZ4Kqu46/ZuDrfYeRgK5DoaM8HmkVc5NlSVr6
 xIPiSKQkK1wCowAYmPO9hg+7QL0W7CAh9c5oqjopE+s9VUCfoJEK7w3U/0r3GD3z6SPe
 gK3g0ZME8YWnBEzWyHzS0uaF3DrBGa2Kj1Mf3HZKiE9OOG32IUZ9QGQj2Hb11lZStjus
 gzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773136211; x=1773741011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J/+gYB7EWaZWmJ8zT0546TEdznqBT2H0GqDVZGHC9Ow=;
 b=CF1jsYjYj7CkCFXz46mtJZmymg5akj7BCNCU9JxN5D3p4CQWSrfFZhrfjBKnsaO+LV
 8JsXoQzxeA8+zSRn8tMFlmQOMLMWAxp/kfFh+6h/ILtzMzBD4l9RvMz+sBI3cSRZBzUV
 Zx4A6sCmnfSOtXbsPYHVUldLiRi0WBWAR9f0tb953J7xkKnCk3RIJ+AOouhWeAhIU2SQ
 vY7IooBaq0zaOAcsvFTDPMe7x++4LK7tq4OlsAPwhrxw+rq4F81qxrR/UhYya2imG9sO
 Lxs1hHqTqCi40HcA11FDbs2Qnt0ISOexjQGtNN51evMw5YLPltKLvbL2QNkfY54mn2Fr
 XbHg==
X-Gm-Message-State: AOJu0YyxvA8aZK6ASJdaCyDWldgGL9StnQlDJ7t1WWfnjAS1xIwHiFht
 LUrVlFr8uTOCasamV98beEKsFJroSeEOpbCNZrnSYhSO1lGOdFj7Lg5Qvgl3qT7lypq20iAYbof
 7trYiS+SoW/5/u0rW+WgDz3TFGSbfKi8=
X-Gm-Gg: ATEYQzxmEEnhkhg0ceyw5zhdpQX4zx9RBe9RPBZBqxIWceoM7T9tG8lu5gqO0wc1s1w
 taxhVAaQNP8LcBHgK/gGmmET5iMRCfFPXCNZ8UySqFvcyJjFXonsqfJ2OnaHvPB+rFa9AF7pCV2
 eId83KCMEgMonx7F+47Hz8WkfY5bmgJrbrwMytdJ0kfGMx9T7BNb/KggkvhD4HO2YrKAnJvsoZ6
 WuQ7+0i2Emz01yHLZp5jSJ2K8G4f+BYyB7PV+9Eq14JRruojjjAJZEd2Qay7aErY2phqsmOzcoB
 MN2TfKU=
X-Received: by 2002:a17:907:a0a:b0:b93:51df:dd23 with SMTP id
 a640c23a62f3a-b942dba8d1cmr798581766b.16.1773136210530; Tue, 10 Mar 2026
 02:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-3-zhangckid@gmail.com>
 <20260309074935.GA39949@fedora>
In-Reply-To: <20260309074935.GA39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 17:49:33 +0800
X-Gm-Features: AaiRm50e5hIOKUdMsGTRSOJmWEwSTEJn3mlmwVLTyiKsxlvgi7944FQGuKOZ7yU
Message-ID: <CAK3tnvLmniSm=aYkJt8dYZ+iMKvQdVmx+UDa-XcBaR=zTq53Vw@mail.gmail.com>
Subject: Re: [PATCH V5 02/13] iothread: introduce iothread_ref/unref to track
 attached devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 9, 2026 at 3:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:48PM +0800, Zhang Chen wrote:
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them. This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Prepends the device's QOM path to a list.
> >   Note: The IOThread takes ownership of the passed 'holder' string.
>
> This is outdated, the patch duplicates the string and the caller still
> owns the holder argument:
>
>   iothread->holders =3D g_list_prepend(iothread->holders, g_strdup(holder=
));
>

Yes, will remove this "Note" comments.

> > - iothread_unref(): Searches for the device path using a custom
> >   string comparison (g_strcmp0), releases the associated memory
> >   upon a successful match.
> > - holders: A GList storing the QOM paths of attached devices
> >   for runtime introspection.
> >
> > This infrastructure allows management tools and QMP commands to
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  1 +
> >  iothread.c                | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index e26d13c6c7..21a76bd70d 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -33,6 +33,7 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    GList *holders;             /* an array of QOM paths for attached =
devices */
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > diff --git a/iothread.c b/iothread.c
> > index caf68e0764..80a8cf4b32 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -36,6 +36,34 @@
> >  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
> >  #endif
> >
> > +/*
> > + * Add holder device path to the list.
> > + */
> > +static void iothread_ref(IOThread *iothread, const char *holder)
> > +{
> > +    iothread->holders =3D g_list_prepend(iothread->holders, g_strdup(h=
older));
> > +}
> > +
> > +/*
> > + * Delete holder device path from the list.
> > + */
> > +static void iothread_unref(IOThread *iothread, const char *holder)
> > +{
> > +    if (iothread->holders) {
>
> g_list_find_customer(NULL, ...) returns NULL rather than crashing, so
> there is no need for if (iothread->holders).

OK.

>
> > +        GList *link =3D g_list_find_custom(iothread->holders, holder,
> > +                                         (GCompareFunc)g_strcmp0);
> > +
> > +        if (link) {
>
> assert(link) is usually used in QEMU instead. If the reference has
> already been released then the program is in an invalid state and it's
> not safe to continue running.
>
> Please also add assert(iothread->holders =3D=3D NULL) to
> iothread_instance_finalize() so that leaked references are caught.

OK. will update in next version.

>
> > +            g_free(link->data);
> > +            iothread->holders =3D g_list_delete_link(iothread->holders=
, link);
> > +        } else {
> > +            error_report("iothread_unref can't find the holder %s", ho=
lder);
> > +        }
> > +    } else {
> > +        error_report("iohtread_unref iothread is not held by any devic=
es");
>
> iohtread -> iothread

Thanks


Chen

