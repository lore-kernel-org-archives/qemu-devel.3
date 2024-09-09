Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60204ECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snnrI-000384-6j; Mon, 09 Sep 2024 19:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1snnrG-00037V-B8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:31:46 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1snnrD-0006qm-A2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:31:46 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e1a819488e3so4184246276.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725924700; x=1726529500; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkYfzfGyXJD8YauKtj0YayPpwkKA3uz5oCx2iU0ebiM=;
 b=lMVoW/xuuFVT8rhaiSPzuEFqOFB7Yjrs29D1NUJyiVE6xr0q6GaDLctemEOulJ898Y
 Ww2Un45IFzLR+jGOhO06e3/z5NvrmTOUmc/ZGxhiY582LCREXIsODv5X5ub0co4uMLet
 43ywCtMMM+mRrYHkKc2LiDlX3Xu24VTWy30uB0T0WyXjg8Keiormr8XRrYSv6zcwbWVS
 SYUZ+L5VB2wOZS9rq8CmrWbPGSZe6XDlg87Y9pTcj9SN8C0h1bl1/R6vwij59RPmIWuv
 s0FagXp643+wfap4fI045rciyfiEFEHifGfovF5EObJPuBxV0aQa7+ohc1oRGBcwNsVR
 uISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725924700; x=1726529500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkYfzfGyXJD8YauKtj0YayPpwkKA3uz5oCx2iU0ebiM=;
 b=YO89XN4WFFk/g5rqCwWwdbsxNjCOlBb/mm61mT0mjuMeYCaOTyR9IH30H8qnUN6lM+
 ahYW5J80RYRnYInLaglNhLv2QAi+lUl4HSKXd0AAUEOAKfFaIARaI2K6K8inotN4+daj
 QD8mqkPpB/Y0wAbCNIiAuT6znHEbu0uRxuGlcwSm38QJQ5dfzPl2NchVB0Ow/D2Ta5D2
 W9VxjvtQ5mxvc04PIYkr8W9sKOii3U0nmasU17aT2TIynLjNmciAyvxQus9lqiG1MR6W
 2YCFcND9G8GDGVXH2UsSOwkhJpFHuF39gJUeLbbEd0uzuxHP3INaOC8FMvyioM408O/s
 uwkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLzfXB/Zm1gg2grjGRLsiCg2/8KS2zRxHXRzmybTP4cPeC0nFIsHw2rViTkL9AaOxOqPbOcJm4kBBu@nongnu.org
X-Gm-Message-State: AOJu0YxhL2Yk503U4h2alaxbz7MsiarnNd5wAZnAcZw6sz0CpKp3s2ts
 C6knWMvm8Lnc8r72InMDFBc+7rurg27qnjSmpoucvfZfkLsAduN0/t5Lhc9m1vnfoGMO0YWDeAB
 H7pRbV8fZYQfKGDGcTdwNO06l4EqAR0VPnrVAXQ==
X-Google-Smtp-Source: AGHT+IEsdtmDuMEp0D53sxzIlpkHhhgrGHA4RFH12EyWe/ouIiC8/LyAMdFHt9Vm+ZaXwFrdkvN5P8VMrM1mS/b60O0=
X-Received: by 2002:a05:690c:ec9:b0:627:24d0:5037 with SMTP id
 00721157ae682-6db44a5f76emr118720287b3.0.1725924699953; Mon, 09 Sep 2024
 16:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
 <87plrc2i9c.fsf@suse.de>
In-Reply-To: <87plrc2i9c.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 9 Sep 2024 16:31:29 -0700
Message-ID: <CAHObMVZEYUE5hsBB5FnoQWYRVoWQRq723tODz8zvr-gnEdrRgg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 10/13] migration/multifd: Enable DSA
 offloading in multifd sender path.
To: Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2c.google.com
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

On Wed, Jul 17, 2024 at 7:41=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
> > From: Hao Xiang <hao.xiang@linux.dev>
> >
> > Multifd sender path gets an array of pages queued by the migration
> > thread. It performs zero page checking on every page in the array.
> > The pages are classfied as either a zero page or a normal page. This
> > change uses Intel DSA to offload the zero page checking from CPU to
> > the DSA accelerator. The sender thread submits a batch of pages to DSA
> > hardware and waits for the DSA completion thread to signal for work
> > completion.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  include/qemu/dsa.h            |   4 +-
>
> This patch should have no changes to dsa code. Put them in the patches
> that introduce them.
>
> >  migration/migration.c         |   2 +-
> >  migration/multifd-zero-page.c | 100 ++++++++++++++++++++++++++++++++--
> >  migration/multifd.c           |  43 ++++++++++++++-
> >  migration/multifd.h           |   2 +-
> >  util/dsa.c                    |  23 ++++----
>
> Same with these.
>
> >  6 files changed, 150 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index fd0305a7c7..a3b502ee41 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -83,7 +83,7 @@ typedef struct QemuDsaBatchTask {
> >   *
> >   * @return int Zero if successful, otherwise non zero.
> >   */
> > -int qemu_dsa_init(const char *dsa_parameter, Error **errp);
> > +int qemu_dsa_init(const strList *dsa_parameter, Error **errp);
> >
> >  /**
> >   * @brief Start logic to enable using DSA.
> > @@ -146,7 +146,7 @@ static inline bool qemu_dsa_is_running(void)
> >      return false;
> >  }
> >
> > -static inline int qemu_dsa_init(const char *dsa_parameter, Error **err=
p)
> > +static inline int qemu_dsa_init(const strList *dsa_parameter, Error **=
errp)
> >  {
> >      error_setg(errp, "DSA accelerator is not enabled.");
> >      return -1;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3dea06d577..085395b900 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3469,7 +3469,7 @@ static void *migration_thread(void *opaque)
> >      object_ref(OBJECT(s));
> >      update_iteration_initial_status(s);
> >
> > -    if (!multifd_send_setup()) {
> > +    if (!multifd_send_setup(&local_err)) {
>
> This is interesting, probably more correct than what we're doing
> today. But you need to hoist the error handling out of
> multifd_send_setup into here. And put this in a separate patch because
> it is an improvement on its own.
>
> >          goto out;
> >      }
> >
> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-pag=
e.c
>
> The way git generated this diff makes it hard to review. When this
> happens, you can use a different algorithm such as --patience when
> generating the patches. Compare git show vs. git show --patience to see
> the difference.
>

I tried with both --patience and default, it looks the same. So the
code is basically to implement a new multifd_send_zero_page_detect()
which calls zero_page_detect_cpu() or zero_page_detect_dsa() based on
the configuration.

> > index e1b8370f88..ffb5611d44 100644
> > --- a/migration/multifd-zero-page.c
> > +++ b/migration/multifd-zero-page.c
> > @@ -37,25 +37,84 @@ static void swap_page_offset(ram_addr_t *pages_offs=
et, int a, int b)
> >  }
> >
> >  /**
> > - * multifd_send_zero_page_detect: Perform zero page detection on all p=
ages.
> > + * zero_page_detect_cpu: Perform zero page detection using CPU.
> >   *
> >   * Sorts normal pages before zero pages in p->pages->offset and update=
s
> >   * p->pages->normal_num.
>
> Probably best to carry this part along as well. This is the public
> function that people will most likely look at first.
>
> >   *
> >   * @param p A pointer to the send params.
> >   */
> > -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> > +static void zero_page_detect_cpu(MultiFDSendParams *p)
> > {
> >      MultiFDPages_t *pages =3D p->pages;
> >      RAMBlock *rb =3D pages->block;
> >      int i =3D 0;
> >      int j =3D pages->num - 1;
> >
> > -    if (!multifd_zero_page_enabled()) {
> > -        pages->normal_num =3D pages->num;
> > +    /*
> > +     * Sort the page offset array by moving all normal pages to
> > +     * the left and all zero pages to the right of the array.
> > +     */
> > +    while (i <=3D j) {
> > +        uint64_t offset =3D pages->offset[i];
> > +
> > +        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> > +            i++;
> > +            continue;
> > +        }
> > +
> > +        swap_page_offset(pages->offset, i, j);
> > +        ram_release_page(rb->idstr, offset);
> > +        j--;
> > +    }
> > +
> > +    pages->normal_num =3D i;
> > +}
> > +
> > +
> > +#ifdef CONFIG_DSA_OPT
> > +
> > +static void swap_result(bool *results, int a, int b)
> > +{
> > +    bool temp;
> > +
> > +    if (a =3D=3D b) {
> >          return;
> >      }
> >
> > +    temp =3D results[a];
> > +    results[a] =3D results[b];
> > +    results[b] =3D temp;
> > +}
> > +
> > +/**
> > + * zero_page_detect_dsa: Perform zero page detection using
> > + * Intel Data Streaming Accelerator (DSA).
> > + *
> > + * Sorts normal pages before zero pages in p->pages->offset and update=
s
> > + * p->pages->normal_num.
> > + *
> > + * @param p A pointer to the send params.
> > + */
> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> > +{
> > +    MultiFDPages_t *pages =3D p->pages;
>
> Actually use the pages variable all over instead of dereferencing
> p->pages again.
>
> > +    RAMBlock *rb =3D pages->block;
> > +    bool *results =3D p->dsa_batch_task->results;
>
> I think we had a suggestion from Peter to not carry the batch task in
> the channel parameters, no?
>

Yes, I saw that. I followed his idea and used a much more concise data
structure. We will still need to carry the task data structure in
MultiFDSendParams, but that is a pointer to a single data structure.
And I also moved some DSA specific function to their own .c files.
Will post the in my next version.

> > +
> > +    for (int i =3D 0; i < p->pages->num; i++) {
> > +        p->dsa_batch_task->addr[i] =3D
> > +            (ram_addr_t)(rb->host + p->pages->offset[i]);
> > +    }
> > +
> > +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
> > +                                  (const void **)p->dsa_batch_task->ad=
dr,
> > +                                  p->pages->num,
> > +                                  p->page_size);
> > +
> > +    int i =3D 0;
> > +    int j =3D pages->num - 1;
> > +
> >      /*
> >       * Sort the page offset array by moving all normal pages to
> >       * the left and all zero pages to the right of the array.
> > @@ -63,11 +122,12 @@ void multifd_send_zero_page_detect(MultiFDSendPara=
ms *p)
> >      while (i <=3D j) {
> >          uint64_t offset =3D pages->offset[i];
> >
> > -        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
> > +        if (!results[i]) {
> >              i++;
> >              continue;
> >          }
> >
> > +        swap_result(results, i, j);
> >          swap_page_offset(pages->offset, i, j);
> >          ram_release_page(rb->idstr, offset);
> >          j--;
> > @@ -76,6 +136,15 @@ void multifd_send_zero_page_detect(MultiFDSendParam=
s *p)
> >      pages->normal_num =3D i;
> >  }
> >
> > +#else
> > +
> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> > +{
> > +    exit(1);
>
> g_assert_not_reached();
>
> > +}
> > +
> > +#endif
> > +
> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> >  {
> >      for (int i =3D 0; i < p->zero_num; i++) {
> > @@ -87,3 +156,24 @@ void multifd_recv_zero_page_process(MultiFDRecvPara=
ms *p)
> >          }
> >      }
> >  }
> > +
> > +/**
> > + * multifd_send_zero_page_detect: Perform zero page detection on all p=
ages.
> > + *
> > + * @param p A pointer to the send params.
> > + */
> > +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> > +{
> > +    MultiFDPages_t *pages =3D p->pages;
> > +
> > +    if (!multifd_zero_page_enabled()) {
> > +        pages->normal_num =3D pages->num;
> > +        return;
> > +    }
> > +
> > +    if (qemu_dsa_is_running()) {
> > +        zero_page_detect_dsa(p);
> > +    } else {
> > +        zero_page_detect_cpu(p);
> > +    }
> > +}
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 6f8edd4b6a..014fee757a 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -817,6 +817,32 @@ static void multifd_send_cleanup_state(void)
> >      multifd_send_state =3D NULL;
> >  }
> >
> > +static bool multifd_dsa_setup(MigrationState *s, const char *role, Err=
or **errp)
>
> You don't need MigrationState here. You can call the function only from
> multifd_send_setup() and use migrate_zero_page_detection() to check for
> DSA.
>

Removed and refactored this part.

> > +{
> > +    /*
> > +     * Only setup DSA when needed. Currently, DSA is only used for zer=
o page
> > +     * detection, which is only needed on sender side.
> > +     */
> > +    if (!s ||
> > +        s->parameters.zero_page_detection !=3D ZERO_PAGE_DETECTION_DSA=
_ACCEL) {
> > +        return true;
> > +    }
> > +
> > +    const strList *dsa_parameter =3D migrate_dsa_accel_path();
> > +    if (qemu_dsa_init(dsa_parameter, errp)) {
> > +        error_setg(errp, "multifd: %s failed to initialize DSA.", role=
);
> > +        return false;
> > +    }
> > +    qemu_dsa_start();
> > +
> > +    return true;
> > +}
> > +
> > +static void multifd_dsa_cleanup(void)
> > +{
> > +    qemu_dsa_cleanup();
> > +}
>
> Hmm, these two functions seem to fit better in multifd-zero-page.c.
>
> > +
> >  void multifd_send_shutdown(void)
> >  {
> >      int i;
> > @@ -827,6 +853,8 @@ void multifd_send_shutdown(void)
> >
> >      multifd_send_terminate_threads();
> >
> > +    multifd_dsa_cleanup();
> > +
> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> >          Error *local_err =3D NULL;
> > @@ -1156,7 +1184,7 @@ static bool multifd_new_send_channel_create(gpoin=
ter opaque, Error **errp)
> >      return true;
> >  }
> >
> > -bool multifd_send_setup(void)
> > +bool multifd_send_setup(Error **errp)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> >      Error *local_err =3D NULL;
>
> Remove this and use errp instead everywhere.
>
> > @@ -1169,6 +1197,10 @@ bool multifd_send_setup(void)
> >          return true;
> >      }
> >
> > +    if (!multifd_dsa_setup(s, "Sender", errp)) {
> > +        return false;
> > +    }
> > +
> >      thread_count =3D migrate_multifd_channels();
> >      multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
> >      multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_co=
unt);
> > @@ -1395,6 +1427,7 @@ void multifd_recv_cleanup(void)
> >              qemu_thread_join(&p->thread);
> >          }
> >      }
> > +    multifd_dsa_cleanup();
> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
> >      }
> > @@ -1570,6 +1603,7 @@ int multifd_recv_setup(Error **errp)
> >      uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_siz=
e();
> >      bool use_packets =3D multifd_use_packets();
> >      uint8_t i;
> > +    int ret;
> >
> >      /*
> >       * Return successfully if multiFD recv state is already initialise=
d
> > @@ -1579,6 +1613,10 @@ int multifd_recv_setup(Error **errp)
> >          return 0;
> >      }
> >
> > +    if (!multifd_dsa_setup(NULL, "Receiver", errp)) {
> > +        return -1;
> > +    }
>
> Is there a reason to call this here?
>

Removed.

> > +
> >      thread_count =3D migrate_multifd_channels();
> >      multifd_recv_state =3D g_malloc0(sizeof(*multifd_recv_state));
> >      multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_co=
unt);
> > @@ -1617,13 +1655,12 @@ int multifd_recv_setup(Error **errp)
> >
> >      for (i =3D 0; i < thread_count; i++) {
> >          MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
> > -        int ret;
> > -
>
> This is a separate cleanup patch.
>
> >          ret =3D multifd_recv_state->ops->recv_setup(p, errp);
> >          if (ret) {
> >              return ret;
> >          }
> >      }
> > +
>
> Avoid introducing extra lines for no reason, this leads to git conflicts
> sometimes.
>
> >      return 0;
> >  }
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 027f57bf4e..871e3aa063 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -18,7 +18,7 @@
> >
> >  typedef struct MultiFDRecvData MultiFDRecvData;
> >
> > -bool multifd_send_setup(void);
> > +bool multifd_send_setup(Error **errp);
> >  void multifd_send_shutdown(void);
> >  void multifd_send_channel_created(void);
> >  int multifd_recv_setup(Error **errp);
> > diff --git a/util/dsa.c b/util/dsa.c
> > index 5aba1ae23a..44b1130a51 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -116,27 +116,27 @@ dsa_device_cleanup(QemuDsaDevice *instance)
> >   */
> >  static int
> >  dsa_device_group_init(QemuDsaDeviceGroup *group,
> > -                      const char *dsa_parameter,
> > +                      const strList *dsa_parameter,
> >                        Error **errp)
> >  {
> > -    if (dsa_parameter =3D=3D NULL || strlen(dsa_parameter) =3D=3D 0) {
> > -        return 0;
> > +    if (dsa_parameter =3D=3D NULL) {
> > +        /* HACKING ALERT. */
> > +        /* return 0; */
> > +        dsa_parameter =3D &(strList) {
> > +            .value =3D (char *)"/dev/dsa/wq0.0", .next =3D NULL
> > +        };
> >      }
> >
> >      int ret =3D 0;
> > -    char *local_dsa_parameter =3D g_strdup(dsa_parameter);
> >      const char *dsa_path[MAX_DSA_DEVICES];
> >      int num_dsa_devices =3D 0;
> > -    char delim[2] =3D " ";
> >
> > -    char *current_dsa_path =3D strtok(local_dsa_parameter, delim);
> > -
> > -    while (current_dsa_path !=3D NULL) {
> > -        dsa_path[num_dsa_devices++] =3D current_dsa_path;
> > +    while (dsa_parameter) {
> > +        dsa_path[num_dsa_devices++] =3D dsa_parameter->value;
> >          if (num_dsa_devices =3D=3D MAX_DSA_DEVICES) {
> >              break;
> >          }
> > -        current_dsa_path =3D strtok(NULL, delim);
> > +        dsa_parameter =3D dsa_parameter->next;
> >      }
> >
> >      group->dsa_devices =3D
> > @@ -161,7 +161,6 @@ dsa_device_group_init(QemuDsaDeviceGroup *group,
> >      }
> >
> >  exit:
> > -    g_free(local_dsa_parameter);
> >      return ret;
> >  }
> >
> > @@ -718,7 +717,7 @@ dsa_globals_init(void)
> >   *
> >   * @return int Zero if successful, otherwise non zero.
> >   */
> > -int qemu_dsa_init(const char *dsa_parameter, Error **errp)
> > +int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
> >  {
> >      dsa_globals_init();

