Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D3E6C5F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJpe-0004VI-Ux; Mon, 02 Dec 2024 22:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIJpc-0004V5-LR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:44:12 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIJpZ-0006ON-SU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:44:12 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3971be41d8so3795554276.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733197446; x=1733802246; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zf/BwJBIrnkDG4VEhfzPRt2SF2SOPPxUQJgok2Cm1RU=;
 b=NHucGiNEq2so8uLtKmNvweQyAlPzjnVYlwpnd42cU/ZN1UqvevK2siH1ePwspX9Jnq
 +MvFXYluortZ54B07ELQW7+huZEJxS0+DthaiSvgO3IgxRzfkcaQbP5vjZlJJh8AcpIX
 s53ECulv4931loPgJWl4XFpyEr+iRoDNu3eDgF8/ryFyeUs3ueCYDz7KHwGtSPDPmIYe
 R9R+WA7RpQR7qdwGaZ0LNt0uvIiQIYeGj7gI85YbbsEJGhBvZw3wdD/4wE758vZ6xHwq
 wP8WW+d1TXIoq800RoRAPjPSF5CFTabs0X3gXjxcdo3LOxi07Q9/y40+7pOZ/TUYu1iQ
 M4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197446; x=1733802246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zf/BwJBIrnkDG4VEhfzPRt2SF2SOPPxUQJgok2Cm1RU=;
 b=cfDGRKw9OUKcQLcDh3DTCWJi9kkA6xAVl2OZSyaSD+RJHwlmp32vaw7rKsBlSwJshV
 gMYvnOxdmEfZmOHGAPRmRxXbGl9GXINzXUBskseYY++xcxegTbSOYkHw1zpdTxEMDXp4
 Z7Fo/HZeqLk4xZCK/1ehUJjUtu90fnH6r+mEobNx/mIaRyV44pJ8RuVEudprjUWwa3+J
 TQwOyNyoGL67ujSn22/ps0qmK9fBooHVSA45ZgvaPr8gRyvoY5ri8zEYZ+zD234dWIXF
 RlCgTXLCEV7pByGAQLuqcyHSiE4qcc85SYcbGy1BG/xZty9/eFzdZZYTMHssY5bxCks+
 C3kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLcG9iEV1BBE1e5y2BfkYhP6zHF5pIOSMxO146eH9MFqCsLrLk9xe/DAntFKbtBMcda4dQtU+SDR2d@nongnu.org
X-Gm-Message-State: AOJu0YyfuMNo5jyDyw98K4WzbQTpRtxK1j+UP2QACo+UQACK+3hhRS0o
 k/jx4GntSeXD5ZP34pC7sGNgHlByj/0FVO7LzMXnf8wtIE965oqklkwj99fcMx9FmB+Yr7Iqrk8
 OODF9B06ygo764rPFkTVlNh2URdDaHsF6kFdzlw==
X-Gm-Gg: ASbGncsPCs51M55AX9eNp1mxlrgZsuoeC8dhY89lLrr7QtJo9YX55nhPUomQINglo0j
 otyU2nDoWVIZH7CnyiRArwXvWGV8UNLGhRttvoLDnIACBsGEVjc30CWgaZaKc
X-Google-Smtp-Source: AGHT+IF7q2sOZpYagAW3TzmmB30vy77iqO5gHFzr8xVhkcunjejNke8uRjpuhYdTagy9xsj3bDCkxVpRF+hNfcpM2KQ=
X-Received: by 2002:a05:6902:e0b:b0:e2e:440e:d29f with SMTP id
 3f1490d57ef6-e39d3a2a68bmr1198151276.20.1733197445610; Mon, 02 Dec 2024
 19:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-10-yichen.wang@bytedance.com> <87iksgpb02.fsf@suse.de>
 <CAHObMVZvNcQcF41TB+tXK9hyPfaFV3tQM90bU2hVku5y-kXPYg@mail.gmail.com>
 <871pyynnbl.fsf@suse.de>
In-Reply-To: <871pyynnbl.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 2 Dec 2024 19:43:54 -0800
Message-ID: <CAHObMVbBBYsSbs0YMB2Of=DovKvKgAztBa6T3Ns6Ne8C0+OOCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 09/12] migration/multifd: Enable DSA
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb35.google.com
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

On Tue, Nov 26, 2024 at 5:23=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
> > On Thu, Nov 21, 2024 at 12:52=E2=80=AFPM Fabiano Rosas <farosas@suse.de=
> wrote:
> >>
> >> Yichen Wang <yichen.wang@bytedance.com> writes:
> >>
> >> > From: Hao Xiang <hao.xiang@linux.dev>
> >> >
> >> > Multifd sender path gets an array of pages queued by the migration
> >> > thread. It performs zero page checking on every page in the array.
> >> > The pages are classfied as either a zero page or a normal page. This
> >> > change uses Intel DSA to offload the zero page checking from CPU to
> >> > the DSA accelerator. The sender thread submits a batch of pages to D=
SA
> >> > hardware and waits for the DSA completion thread to signal for work
> >> > completion.
> >> >
> >> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> >> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> >> > ---
> >> >  migration/multifd-zero-page.c | 129 ++++++++++++++++++++++++++++++-=
---
> >> >  migration/multifd.c           |  29 +++++++-
> >> >  migration/multifd.h           |   5 ++
> >> >  3 files changed, 147 insertions(+), 16 deletions(-)
> >> >
> >> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-=
page.c
> >> > index f1e988a959..639aed9f6b 100644
> >> > --- a/migration/multifd-zero-page.c
> >> > +++ b/migration/multifd-zero-page.c
> >> > @@ -21,7 +21,9 @@
> >> >
> >> >  static bool multifd_zero_page_enabled(void)
> >> >  {
> >> > -    return migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION=
_MULTIFD;
> >> > +    ZeroPageDetection curMethod =3D migrate_zero_page_detection();
> >> > +    return (curMethod =3D=3D ZERO_PAGE_DETECTION_MULTIFD ||
> >> > +            curMethod =3D=3D ZERO_PAGE_DETECTION_DSA_ACCEL);
> >> >  }
> >> >
> >> >  static void swap_page_offset(ram_addr_t *pages_offset, int a, int b=
)
> >> > @@ -37,26 +39,49 @@ static void swap_page_offset(ram_addr_t *pages_o=
ffset, int a, int b)
> >> >      pages_offset[b] =3D temp;
> >> >  }
> >> >
> >> > +#ifdef CONFIG_DSA_OPT
> >> > +
> >> > +static void swap_result(bool *results, int a, int b)
> >> > +{
> >> > +    bool temp;
> >> > +
> >> > +    if (a =3D=3D b) {
> >> > +        return;
> >> > +    }
> >> > +
> >> > +    temp =3D results[a];
> >> > +    results[a] =3D results[b];
> >> > +    results[b] =3D temp;
> >> > +}
> >> > +
> >> >  /**
> >> > - * multifd_send_zero_page_detect: Perform zero page detection on al=
l pages.
> >> > + * zero_page_detect_dsa: Perform zero page detection using
> >> > + * Intel Data Streaming Accelerator (DSA).
> >> >   *
> >> > - * Sorts normal pages before zero pages in p->pages->offset and upd=
ates
> >> > - * p->pages->normal_num.
> >> > + * Sorts normal pages before zero pages in pages->offset and update=
s
> >> > + * pages->normal_num.
> >> >   *
> >> >   * @param p A pointer to the send params.
> >> >   */
> >> > -void multifd_send_zero_page_detect(MultiFDSendParams *p)
> >> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> >> >  {
> >> >      MultiFDPages_t *pages =3D &p->data->u.ram;
> >> >      RAMBlock *rb =3D pages->block;
> >> > -    int i =3D 0;
> >> > -    int j =3D pages->num - 1;
> >> > +    bool *results =3D p->dsa_batch_task->results;
> >> >
> >> > -    if (!multifd_zero_page_enabled()) {
> >> > -        pages->normal_num =3D pages->num;
> >> > -        goto out;
> >> > +    for (int i =3D 0; i < pages->num; i++) {
> >> > +        p->dsa_batch_task->addr[i] =3D
> >> > +            (ram_addr_t)(rb->host + pages->offset[i]);
> >> >      }
> >> >
> >> > +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
> >> > +                                  (const void **)p->dsa_batch_task-=
>addr,
> >> > +                                  pages->num,
> >> > +                                  multifd_ram_page_size());
> >> > +
> >> > +    int i =3D 0;
> >> > +    int j =3D pages->num - 1;
> >> > +
> >> >      /*
> >> >       * Sort the page offset array by moving all normal pages to
> >> >       * the left and all zero pages to the right of the array.
> >> > @@ -64,23 +89,39 @@ void multifd_send_zero_page_detect(MultiFDSendPa=
rams *p)
> >> >      while (i <=3D j) {
> >> >          uint64_t offset =3D pages->offset[i];
> >> >
> >> > -        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_siz=
e())) {
> >> > +        if (!results[i]) {
> >> >              i++;
> >> >              continue;
> >> >          }
> >> >
> >> > +        swap_result(results, i, j);
> >> >          swap_page_offset(pages->offset, i, j);
> >> >          ram_release_page(rb->idstr, offset);
> >> >          j--;
> >> >      }
> >> >
> >> >      pages->normal_num =3D i;
> >> > +}
> >> >
> >> > -out:
> >> > -    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> >> > -    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_nu=
m);
> >> > +void multifd_dsa_cleanup(void)
> >> > +{
> >> > +    qemu_dsa_cleanup();
> >> > +}
> >> > +
> >> > +#else
> >> > +
> >> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
> >> > +{
> >> > +    g_assert_not_reached();
> >> > +}
> >> > +
> >> > +void multifd_dsa_cleanup(void)
> >> > +{
> >> > +    return ;
> >> >  }
> >> >
> >> > +#endif
> >> > +
> >> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> >> >  {
> >> >      for (int i =3D 0; i < p->zero_num; i++) {
> >> > @@ -92,3 +133,63 @@ void multifd_recv_zero_page_process(MultiFDRecvP=
arams *p)
> >> >          }
> >> >      }
> >> >  }
> >> > +
> >> > +/**
> >> > + * zero_page_detect_cpu: Perform zero page detection using CPU.
> >> > + *
> >> > + * Sorts normal pages before zero pages in p->pages->offset and upd=
ates
> >> > + * p->pages->normal_num.
> >> > + *
> >> > + * @param p A pointer to the send params.
> >> > + */
> >> > +static void zero_page_detect_cpu(MultiFDSendParams *p)
> >> > +{
> >> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
> >> > +    RAMBlock *rb =3D pages->block;
> >> > +    int i =3D 0;
> >> > +    int j =3D pages->num - 1;
> >> > +
> >> > +    /*
> >> > +     * Sort the page offset array by moving all normal pages to
> >> > +     * the left and all zero pages to the right of the array.
> >> > +     */
> >> > +    while (i <=3D j) {
> >> > +        uint64_t offset =3D pages->offset[i];
> >> > +
> >> > +        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_siz=
e())) {
> >> > +            i++;
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        swap_page_offset(pages->offset, i, j);
> >> > +        ram_release_page(rb->idstr, offset);
> >> > +        j--;
> >> > +    }
> >> > +
> >> > +    pages->normal_num =3D i;
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_send_zero_page_detect: Perform zero page detection on al=
l pages.
> >> > + *
> >> > + * @param p A pointer to the send params.
> >> > + */
> >> > +void multifd_send_zero_page_detect(MultiFDSendParams *p)
> >> > +{
> >> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
> >> > +
> >> > +    if (!multifd_zero_page_enabled()) {
> >> > +        pages->normal_num =3D pages->num;
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    if (qemu_dsa_is_running()) {
> >> > +        zero_page_detect_dsa(p);
> >> > +    } else {
> >> > +        zero_page_detect_cpu(p);
> >> > +    }
> >> > +
> >> > +out:
> >> > +    stat64_add(&mig_stats.normal_pages, pages->normal_num);
> >> > +    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_nu=
m);
> >> > +}
> >> > diff --git a/migration/multifd.c b/migration/multifd.c
> >> > index 4374e14a96..689acceff2 100644
> >> > --- a/migration/multifd.c
> >> > +++ b/migration/multifd.c
> >> > @@ -13,6 +13,7 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "qemu/cutils.h"
> >> >  #include "qemu/rcu.h"
> >> > +#include "qemu/dsa.h"
> >> >  #include "exec/target_page.h"
> >> >  #include "sysemu/sysemu.h"
> >> >  #include "exec/ramblock.h"
> >> > @@ -462,6 +463,8 @@ static bool multifd_send_cleanup_channel(MultiFD=
SendParams *p, Error **errp)
> >> >      p->name =3D NULL;
> >> >      g_free(p->data);
> >> >      p->data =3D NULL;
> >> > +    buffer_zero_batch_task_destroy(p->dsa_batch_task);
> >> > +    p->dsa_batch_task =3D NULL;
> >> >      p->packet_len =3D 0;
> >> >      g_free(p->packet);
> >> >      p->packet =3D NULL;
> >> > @@ -493,6 +496,8 @@ void multifd_send_shutdown(void)
> >> >
> >> >      multifd_send_terminate_threads();
> >> >
> >> > +    multifd_dsa_cleanup();
> >> > +
> >> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> >> >          Error *local_err =3D NULL;
> >> > @@ -814,11 +819,31 @@ bool multifd_send_setup(void)
> >> >      uint32_t page_count =3D multifd_ram_page_count();
> >> >      bool use_packets =3D multifd_use_packets();
> >> >      uint8_t i;
> >> > +    Error *local_err =3D NULL;
> >> >
> >> >      if (!migrate_multifd()) {
> >> >          return true;
> >> >      }
> >> >
> >> > +    if (s &&
> >> > +        s->parameters.zero_page_detection =3D=3D ZERO_PAGE_DETECTIO=
N_DSA_ACCEL) {
> >> > +        // Populate the dsa device path from accel-path
> >>
> >> scripts/checkpatch.pl would have rejected this.
> >>
> >
> > Sorry. I will make sure to run checkpatch.pl, unit test (both
> > with/without DSA), before the send-email...
> >
> >> > +        const strList *accel_path =3D migrate_accel_path();
> >> > +        g_autofree strList *dsa_parameter =3D g_malloc0(sizeof(strL=
ist));
> >> > +        strList **tail =3D &dsa_parameter;
> >> > +        while (accel_path) {
> >> > +            if (strncmp(accel_path->value, "dsa:", 4) =3D=3D 0) {
> >> > +                QAPI_LIST_APPEND(tail, &accel_path->value[4]);
> >> > +            }
> >> > +            accel_path =3D accel_path->next;
> >> > +        }
> >>
> >> The parsing of the parameter should be in options.c. In fact, Peter
> >> suggested in v4 to make all of this a multifd_dsa_send_setup() or
> >> multifd_dsa_init(), I think that's a good idea.
> >>
> >
> > Will fix it in the next version.
> >
> >> > +        if (qemu_dsa_init(dsa_parameter, &local_err)) {
> >> > +            ret =3D -1;
> >>
> >> migrate_set_error(s, local_err);
> >> goto err;
> >
> > Will fix it in the next version. But here we can't goto err, because
> > the cleanup() function will be called when setup() fails, and it has
> > assumptions that a certain data structure is in place. If we exit
> > earlier, the cleanup() function will complain and fail.
> >
>
> Which data structure? Is that multifd_send_state below? You could move
> those before qemu_dsa_init if that's the case.
>

Yes, actually the whole below code including the for-loop are expected
to be done and cannot exit earlier. For example, inside the
thread_count loop, multifd_new_send_channel_create() is also not exit
earlier, and the whole data structure will be referred to in the
cleanup() function. I also thought to put dsa setup function post
these original initializations, but "p->dsa_batch_task =3D
buffer_zero_batch_task_init(page_count);" has dependence on DSA and
dsa setup needs to be earlier. So I guess this is the only way...

> >>
> >> > +        } else {
> >> > +            qemu_dsa_start();
> >> > +        }
> >> > +    }
> >> > +
> >> >      thread_count =3D migrate_multifd_channels();
> >> >      multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
> >> >      multifd_send_state->params =3D g_new0(MultiFDSendParams, thread=
_count);
> >> > @@ -829,12 +854,12 @@ bool multifd_send_setup(void)
> >> >
> >> >      for (i =3D 0; i < thread_count; i++) {
> >> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> >> > -        Error *local_err =3D NULL;
> >> >
> >> >          qemu_sem_init(&p->sem, 0);
> >> >          qemu_sem_init(&p->sem_sync, 0);
> >> >          p->id =3D i;
> >> >          p->data =3D multifd_send_data_alloc();
> >> > +        p->dsa_batch_task =3D buffer_zero_batch_task_init(page_coun=
t);
> >> >
> >> >          if (use_packets) {
> >> >              p->packet_len =3D sizeof(MultiFDPacket_t)
> >> > @@ -865,7 +890,6 @@ bool multifd_send_setup(void)
> >> >
> >> >      for (i =3D 0; i < thread_count; i++) {
> >> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> >> > -        Error *local_err =3D NULL;
> >> >
> >> >          ret =3D multifd_send_state->ops->send_setup(p, &local_err);
> >> >          if (ret) {
> >> > @@ -1047,6 +1071,7 @@ void multifd_recv_cleanup(void)
> >> >              qemu_thread_join(&p->thread);
> >> >          }
> >> >      }
> >> > +    multifd_dsa_cleanup();
> >> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> >> >          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]=
);
> >> >      }
> >> > diff --git a/migration/multifd.h b/migration/multifd.h
> >> > index 50d58c0c9c..e293ddbc1d 100644
> >> > --- a/migration/multifd.h
> >> > +++ b/migration/multifd.h
> >> > @@ -15,6 +15,7 @@
> >> >
> >> >  #include "exec/target_page.h"
> >> >  #include "ram.h"
> >> > +#include "qemu/dsa.h"
> >> >
> >> >  typedef struct MultiFDRecvData MultiFDRecvData;
> >> >  typedef struct MultiFDSendData MultiFDSendData;
> >> > @@ -155,6 +156,9 @@ typedef struct {
> >> >      bool pending_sync;
> >> >      MultiFDSendData *data;
> >> >
> >> > +    /* Zero page checking batch task */
> >> > +    QemuDsaBatchTask *dsa_batch_task;
> >> > +
> >> >      /* thread local variables. No locking required */
> >> >
> >> >      /* pointer to the packet */
> >> > @@ -313,6 +317,7 @@ void multifd_send_fill_packet(MultiFDSendParams =
*p);
> >> >  bool multifd_send_prepare_common(MultiFDSendParams *p);
> >> >  void multifd_send_zero_page_detect(MultiFDSendParams *p);
> >> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p);
> >> > +void multifd_dsa_cleanup(void);
> >> >
> >> >  static inline void multifd_send_prepare_header(MultiFDSendParams *p=
)
> >> >  {

