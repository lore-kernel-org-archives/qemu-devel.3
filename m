Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D646E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 05:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOVqn-00012k-G2; Fri, 20 Dec 2024 00:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tOVqk-00012Z-Ql
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 00:46:59 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tOVqg-0001ZB-3V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 00:46:58 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6eff8289d0eso14668097b3.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 21:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1734673607; x=1735278407; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HmCbW4cbYGRh6sWnELe0P12Q8AqFw2UZNKcD46rN0s=;
 b=PwfR9BUiGaVP3ODAFfOM16hInMlzxJ4GMJC1NAFPLZRzjlRP6KOT0Cf83bBq4L/yyw
 Q+yKg3GuMWHlY6aRLfb6WA2IY15B0RCsVuB9jsehAcnF101190nwBiyjhwfrTE/VEbXs
 wmG0OCdxnJHPKKaFnHowcA4u+nrDTL8CX0+37yxCgOZBwFZiKyPfqlqHwFJmviZOTvsz
 18YoOCRFIMEeUZl6VWDEF88TuPBDW2vRPAGc/y7FxHAJnaG8L1SEXJPmofIrnv6BCcnJ
 QAWBJWde2mvu8vrMrv+CL474f7Wm74OyF7Dh2iWdqzaaP0bT3eut6tWVLsnwYadl0Plu
 geIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734673607; x=1735278407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HmCbW4cbYGRh6sWnELe0P12Q8AqFw2UZNKcD46rN0s=;
 b=Y6KnWlrxWA6lLMSYz6yuPeiNP6DZ82E4Xf8etUF2TmnUl3ElF/L3bAXosEfZvvacTp
 7JiCCfsuuuqDHCdQ4xakZKasTFRfftd5XEUhK1Abvfg8Vg1oEGoroXGxy801K8pBwTsX
 /Ob2sH44UMqXJjAKEdkjwjtndf0sEFcyTNKAP1+mxIzP5judMmjEjhGiNeXfWVXfyupc
 iaJl4tl0HJywJwyxKHx7nLLNTnrzZZnL9/n+3Y3qwF91Xnu7QcKtfka3StsqsM46a/3V
 Gj1tE6bo+gvcttgPTG+Zw/5fZa7BQCs2wma9+nAzRxbZMQLhIjBQL+zE0GiJFWPc9jgI
 mf8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHEFYf2WPQmP5u/npzLgHLChbqDCoqKE1DAQHZyJK2Pvamjf3At/4P8p8V6MvWpDyWJPpD0T28tcCv@nongnu.org
X-Gm-Message-State: AOJu0Ywk3wPfKSYTuYBAJzu4ICo5gMqzrwGQn9ZLPoZUypgyoAMHXifQ
 RY/Ol8xBhx+Mr33eo97GkEEvR56ouM2i3E4My5LG/enJmpZXhiZQv7xN5H1fhm3p3CVmJgGJY5G
 hIMH2Euq+dbpAaTdSLY/P5OlAa7Nx488P8OQpFw==
X-Gm-Gg: ASbGnctJN3LP0mK7dOwWAIga0Ve5fUGhKORPNWvW3JpKyOLKP0vt5fEBQW9vVHwqSbY
 vwTwQaC/VEfMM4/BI12tnlkvYa7x3/WZKmsf6oJ9eOhxOnHmDS8vOuZAFQhrWKS8ZZOX/Z4c=
X-Google-Smtp-Source: AGHT+IEh+06kg+5Z4pi5IbpZs63KAqAT/viBOkFeu3TUc1qix+Te7dKFq7QVsVUos32SDQPui3OW3zLojRBKdwDn+N8=
X-Received: by 2002:a05:690c:7007:b0:6ef:6536:bb8c with SMTP id
 00721157ae682-6f3f8141cc8mr9798517b3.21.1734673607399; Thu, 19 Dec 2024
 21:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
 <20241204021142.24184-10-yichen.wang@bytedance.com> <87wmfyurat.fsf@suse.de>
In-Reply-To: <87wmfyurat.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Thu, 19 Dec 2024 21:46:36 -0800
Message-ID: <CAHObMVZWAToy9b=OhMPwFOkRdz9e01JB1fgG4g3jnMeOOGKdMw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 09/12] migration/multifd: Enable DSA
 offloading in multifd sender path.
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x112e.google.com
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

On Tue, Dec 17, 2024 at 9:56=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
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
> >  migration/multifd-zero-page.c | 149 ++++++++++++++++++++++++++++++----
> >  migration/multifd.c           |  15 +++-
> >  migration/multifd.h           |   6 ++
> >  migration/options.c           |  13 +++
> >  migration/options.h           |   1 +
> >  5 files changed, 168 insertions(+), 16 deletions(-)
> >
> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-pag=
e.c
> > index f1e988a959..08e7fc3d92 100644
> > --- a/migration/multifd-zero-page.c
> > +++ b/migration/multifd-zero-page.c
> > @@ -21,7 +21,9 @@
> >
> >  static bool multifd_zero_page_enabled(void)
> >  {
> > -    return migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MU=
LTIFD;
> > +    ZeroPageDetection curMethod =3D migrate_zero_page_detection();
> > +    return (curMethod =3D=3D ZERO_PAGE_DETECTION_MULTIFD ||
> > +            curMethod =3D=3D ZERO_PAGE_DETECTION_DSA_ACCEL);
> >  }
> >
> >  static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
> > @@ -37,26 +39,49 @@ static void swap_page_offset(ram_addr_t *pages_offs=
et, int a, int b)
> >      pages_offset[b] =3D temp;
> >  }
> >
> > +#ifdef CONFIG_DSA_OPT
> > +
> > +static void swap_result(bool *results, int a, int b)
> > +{
> > +    bool temp;
> > +
> > +    if (a =3D=3D b) {
> > +        return;
> > +    }
> > +
> > +    temp =3D results[a];
> > +    results[a] =3D results[b];
> > +    results[b] =3D temp;
> > +}
> > +
> >  /**
> > - * multifd_send_zero_page_detect: Perform zero page detection on all p=
ages.
> > + * zero_page_detect_dsa: Perform zero page detection using
> > + * Intel Data Streaming Accelerator (DSA).
> >   *
> > - * Sorts normal pages before zero pages in p->pages->offset and update=
s
> > - * p->pages->normal_num.
> > + * Sorts normal pages before zero pages in pages->offset and updates
> > + * pages->normal_num.
> >   *
> >   * @param p A pointer to the send params.
> >   */
> > -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> >  {
> >      MultiFDPages_t *pages =3D &p->data->u.ram;
> >      RAMBlock *rb =3D pages->block;
> > -    int i =3D 0;
> > -    int j =3D pages->num - 1;
> > +    bool *results =3D p->dsa_batch_task->results;
> >
> > -    if (!multifd_zero_page_enabled()) {
> > -        pages->normal_num =3D pages->num;
> > -        goto out;
> > +    for (int i =3D 0; i < pages->num; i++) {
> > +        p->dsa_batch_task->addr[i] =3D
> > +            (ram_addr_t)(rb->host + pages->offset[i]);
> >      }
> >
> > +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
> > +                                  (const void **)p->dsa_batch_task->ad=
dr,
> > +                                  pages->num,
> > +                                  multifd_ram_page_size());
> > +
> > +    int i =3D 0;
> > +    int j =3D pages->num - 1;
> > +
> >      /*
> >       * Sort the page offset array by moving all normal pages to
> >       * the left and all zero pages to the right of the array.
> > @@ -64,23 +89,59 @@ void multifd_send_zero_page_detect(MultiFDSendParam=
s *p)
> >      while (i <=3D j) {
> >          uint64_t offset =3D pages->offset[i];
> >
> > -        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size()=
)) {
> > +        if (!results[i]) {
> >              i++;
> >              continue;
> >          }
> >
> > +        swap_result(results, i, j);
> >          swap_page_offset(pages->offset, i, j);
> >          ram_release_page(rb->idstr, offset);
> >          j--;
> >      }
> >
> >      pages->normal_num =3D i;
> > +}
> >
> > -out:
> > -    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> > -    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
> > +int multifd_dsa_setup(MigrationState *s, Error *local_err)
> > +{
> > +    g_autofree strList *dsa_parameter =3D g_malloc0(sizeof(strList));
> > +    migrate_dsa_accel_path(dsa_parameter);
> > +    if (qemu_dsa_init(dsa_parameter, &local_err)) {
> > +        migrate_set_error(s, local_err);
> > +        return -1;
> > +    } else {
> > +        qemu_dsa_start();
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +void multifd_dsa_cleanup(void)
> > +{
> > +    qemu_dsa_cleanup();
> > +}
> > +
> > +#else
> > +
> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> > +{
> > +    g_assert_not_reached();
> >  }
> >
> > +int multifd_dsa_setup(MigrationState *s, Error *local_err)
> > +{
> > +    g_assert_not_reached();
> > +    return -1;
> > +}
> > +
> > +void multifd_dsa_cleanup(void)
> > +{
> > +    return ;
> > +}
> > +
> > +#endif
> > +
> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> >  {
> >      for (int i =3D 0; i < p->zero_num; i++) {
> > @@ -92,3 +153,63 @@ void multifd_recv_zero_page_process(MultiFDRecvPara=
ms *p)
> >          }
> >      }
> >  }
> > +
> > +/**
> > + * zero_page_detect_cpu: Perform zero page detection using CPU.
> > + *
> > + * Sorts normal pages before zero pages in p->pages->offset and update=
s
> > + * p->pages->normal_num.
> > + *
> > + * @param p A pointer to the send params.
> > + */
> > +static void zero_page_detect_cpu(MultiFDSendParams *p)
> > +{
> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
> > +    RAMBlock *rb =3D pages->block;
> > +    int i =3D 0;
> > +    int j =3D pages->num - 1;
> > +
> > +    /*
> > +     * Sort the page offset array by moving all normal pages to
> > +     * the left and all zero pages to the right of the array.
> > +     */
> > +    while (i <=3D j) {
> > +        uint64_t offset =3D pages->offset[i];
> > +
> > +        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size()=
)) {
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
> > +/**
> > + * multifd_send_zero_page_detect: Perform zero page detection on all p=
ages.
> > + *
> > + * @param p A pointer to the send params.
> > + */
> > +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> > +{
> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
> > +
> > +    if (!multifd_zero_page_enabled()) {
> > +        pages->normal_num =3D pages->num;
> > +        goto out;
> > +    }
> > +
> > +    if (qemu_dsa_is_running()) {
> > +        zero_page_detect_dsa(p);
> > +    } else {
> > +        zero_page_detect_cpu(p);
> > +    }
> > +
> > +out:
> > +    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> > +    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
> > +}
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 498e71fd10..946144fc2f 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/rcu.h"
> > +#include "qemu/dsa.h"
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> >  #include "exec/ramblock.h"
> > @@ -462,6 +463,8 @@ static bool multifd_send_cleanup_channel(MultiFDSen=
dParams *p, Error **errp)
> >      p->name =3D NULL;
> >      g_free(p->data);
> >      p->data =3D NULL;
> > +    buffer_zero_batch_task_destroy(p->dsa_batch_task);
> > +    p->dsa_batch_task =3D NULL;
> >      p->packet_len =3D 0;
> >      g_free(p->packet);
> >      p->packet =3D NULL;
> > @@ -493,6 +496,8 @@ void multifd_send_shutdown(void)
> >
> >      multifd_send_terminate_threads();
> >
> > +    multifd_dsa_cleanup();
> > +
> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> >          Error *local_err =3D NULL;
> > @@ -814,11 +819,17 @@ bool multifd_send_setup(void)
> >      uint32_t page_count =3D multifd_ram_page_count();
> >      bool use_packets =3D multifd_use_packets();
> >      uint8_t i;
> > +    Error *local_err =3D NULL;
> >
> >      if (!migrate_multifd()) {
> >          return true;
> >      }
> >
> > +    if (s &&
> > +        s->parameters.zero_page_detection =3D=3D ZERO_PAGE_DETECTION_D=
SA_ACCEL) {
> > +        ret =3D multifd_dsa_setup(s, local_err);
>
> This leaves the local_err set and will cause an assert if the code below
> tries to set it again. We should at the very least report the error here
> and free it. But that's not ideal because it allows the code to
> continue.
>
> Can you move this whole block after the channels loop as suggested
> previously but this time take the p->dsa_batch_task along and put it the
> ->send_setup() loop?
>

I am trying to make this change. If I put the p->dsa_batch_task into
the multifd_dsa_setup() in multifd-zero-page.c, things are a little
tricky. I will need to pass thread_count and multifd_send_state into
multifd_dsa_setup(), but multifd_send_state is a multifd.c only data
structure/variable. I have to make the whole struct into multifd.h,
and not sure if that is a good idea?

> > +    }
> > +
> >      thread_count =3D migrate_multifd_channels();
> >      multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
> >      multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_co=
unt);
> > @@ -829,12 +840,12 @@ bool multifd_send_setup(void)
> >
> >      for (i =3D 0; i < thread_count; i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> > -        Error *local_err =3D NULL;
> >
> >          qemu_sem_init(&p->sem, 0);
> >          qemu_sem_init(&p->sem_sync, 0);
> >          p->id =3D i;
> >          p->data =3D multifd_send_data_alloc();
> > +        p->dsa_batch_task =3D buffer_zero_batch_task_init(page_count);
> >
> >          if (use_packets) {
> >              p->packet_len =3D sizeof(MultiFDPacket_t)
> > @@ -865,7 +876,6 @@ bool multifd_send_setup(void)
> >
> >      for (i =3D 0; i < thread_count; i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> > -        Error *local_err =3D NULL;
> >
> >          ret =3D multifd_send_state->ops->send_setup(p, &local_err);
> >          if (ret) {
> > @@ -1047,6 +1057,7 @@ void multifd_recv_cleanup(void)
> >              qemu_thread_join(&p->thread);
> >          }
> >      }
> > +    multifd_dsa_cleanup();
> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
> >      }
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 50d58c0c9c..da53b0bdfd 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -15,6 +15,7 @@
> >
> >  #include "exec/target_page.h"
> >  #include "ram.h"
> > +#include "qemu/dsa.h"
> >
> >  typedef struct MultiFDRecvData MultiFDRecvData;
> >  typedef struct MultiFDSendData MultiFDSendData;
> > @@ -155,6 +156,9 @@ typedef struct {
> >      bool pending_sync;
> >      MultiFDSendData *data;
> >
> > +    /* Zero page checking batch task */
> > +    QemuDsaBatchTask *dsa_batch_task;
> > +
> >      /* thread local variables. No locking required */
> >
> >      /* pointer to the packet */
> > @@ -313,6 +317,8 @@ void multifd_send_fill_packet(MultiFDSendParams *p)=
;
> >  bool multifd_send_prepare_common(MultiFDSendParams *p);
> >  void multifd_send_zero_page_detect(MultiFDSendParams *p);
> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p);
> > +int multifd_dsa_setup(MigrationState *s, Error *local_err);
> > +void multifd_dsa_cleanup(void);
> >
> >  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
> >  {
> > diff --git a/migration/options.c b/migration/options.c
> > index ca89fdc4f4..cc40d3dfea 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -817,6 +817,19 @@ const strList *migrate_accel_path(void)
> >      return s->parameters.accel_path;
> >  }
> >
> > +void migrate_dsa_accel_path(strList *dsa_accel_path)
> > +{
> > +    MigrationState *s =3D migrate_get_current();
> > +    strList *accel_path =3D s->parameters.accel_path;
> > +    strList **tail =3D &dsa_accel_path;
> > +    while (accel_path) {
> > +        if (strncmp(accel_path->value, "dsa:", 4) =3D=3D 0) {
> > +            QAPI_LIST_APPEND(tail, &accel_path->value[4]);
> > +        }
> > +        accel_path =3D accel_path->next;
> > +    }
> > +}
> > +
> >  const char *migrate_tls_hostname(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > diff --git a/migration/options.h b/migration/options.h
> > index 3d1e91dc52..5e34b7c997 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -85,6 +85,7 @@ const char *migrate_tls_hostname(void);
> >  uint64_t migrate_xbzrle_cache_size(void);
> >  ZeroPageDetection migrate_zero_page_detection(void);
> >  const strList *migrate_accel_path(void);
> > +void migrate_dsa_accel_path(strList *dsa_accel_path);
> >
> >  /* parameters helpers */

