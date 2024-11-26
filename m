Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BECD5A6E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFnLP-0005vC-8z; Mon, 25 Nov 2024 23:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tFnLM-0005ui-QS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:38:33 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tFnLJ-0005WN-DB
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:38:32 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3882273bdfso5539713276.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 20:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1732595903; x=1733200703; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KimeLdDRMmlLzMp7KkRWZL2utZgQ78HGnVQAjOPEOwo=;
 b=gqalSmqG6JIQbKsbCz2NLi+vGs0gRvcC39R5tx+WUDL8A+qR95+4o2Mnd/bVEy9b68
 IWhbY9+oQu1CrX3yayZzB0ZeTwmnx60o7VCfJCyNoAjAHlkFDuEyXtq3knE2ciNoeLp+
 uh/Zwaz2SqUplplHDYbECpmstrQBgpR2L8I59VbpUGpmQe+Ob2QSTeMbphrcPPjQTEe9
 wDCeXlXhwxJVq88mOIpT8OmqPncYFdTcyqJzFrhpB8f1nwVva/UUlx3x+Js7YFawgkVl
 XH0VFIxWds1PiQmS+Doe+GhhtO3Wnz55aJ0t0hlQa1nPU3QVVtADXuPnGPuTAZmMfSoI
 Bwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732595903; x=1733200703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KimeLdDRMmlLzMp7KkRWZL2utZgQ78HGnVQAjOPEOwo=;
 b=tuh364PMnojFocgmMcCPWgS5j63jW7S9JtYkKyt0pGhviBXHFc/LmD/ccYaOgW1pfn
 K80azIaYNNctrz1jJxhKODBy9THWcgtlQ+yDxSYgxF8F+6nb7opfysY021m03ggAtix+
 6JN124+E543fmp9ZOSGAPakP+pYK6w5CzePf5lhsz7lzhC/QkX2zz2NBzFlGV9ySPrDr
 dTxU3EgckmNlUVkWSu9cMuOb5tlHE8b0c8Th00wBoeswDiMwhErRu8FXSrs1o14Qgm+D
 YSaYDelyeqjk69k3qjQENnPm10XMqCxGjY9Ha9vuNKNAhHDBHNEzH6c+EI4wdL2NgjZ+
 P0gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXErj3bO3fvWlqAwYDRF8n7t8EKpCCI6WJnzpyug5MBcxg2aQGOw7GM2LeyEMr86lnXXmDOLNTA14uc@nongnu.org
X-Gm-Message-State: AOJu0Yzj+owp1V2pfdiT02MiIuCrtBL4H9nXB013cY+px+H5/jSI3aIk
 j7oYy51E+ipMKO2N2jgqUtVIkNuqxYItaz741JPMHMnDOWZeOtoTAs06LsTrxU1PaQrM0qkXJZq
 Y0Vu/W6T/R39JhsG9sGfRPPpzn9Hed4cOJAPYVw==
X-Gm-Gg: ASbGnctlTjVxQjUkg+JnqnY6RJ7Aw7gUiiyo89viwg9limFE4e8nFw7APeThZ5Gqi58
 aFtABjoUpTK/4fIbr6vZW1RhrGvtCoYcyuT1gaFyD3By/TghkcD0WHiKTklfGV+A=
X-Google-Smtp-Source: AGHT+IHg2Wb/t1edoVGBzgNH3o4Sw3BiIcnvH4itqAtjrYx+siYp/KfZu5FvUiDbLirvCk+avO5GS0J5X3S6YrAl88Y=
X-Received: by 2002:a05:6902:1101:b0:e28:f0e5:380b with SMTP id
 3f1490d57ef6-e38f8ad7081mr10142868276.4.1732595903223; Mon, 25 Nov 2024
 20:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-7-yichen.wang@bytedance.com> <875xobpax2.fsf@suse.de>
In-Reply-To: <875xobpax2.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Mon, 25 Nov 2024 20:38:12 -0800
Message-ID: <CAHObMVadZDzXSY2HUJPh2=OYp2euQQq+MUKakiDXLcAgZ-82UQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 06/12] util/dsa: Implement zero page
 checking in DSA task.
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
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb34.google.com
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

On Mon, Nov 25, 2024 at 7:53=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
> > From: Hao Xiang <hao.xiang@linux.dev>
> >
> > Create DSA task with operation code DSA_OPCODE_COMPVAL.
> > Here we create two types of DSA tasks, a single DSA task and
> > a batch DSA task. Batch DSA task reduces task submission overhead
> > and hence should be the default option. However, due to the way DSA
> > hardware works, a DSA batch task must contain at least two individual
> > tasks. There are times we need to submit a single task and hence a
> > single DSA task submission is also required.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> > ---
> >  include/qemu/dsa.h |  44 ++++++--
> >  util/dsa.c         | 254 +++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 269 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> > index d24567f0be..cb407b8b49 100644
> > --- a/include/qemu/dsa.h
> > +++ b/include/qemu/dsa.h
> > @@ -16,6 +16,7 @@
> >  #define QEMU_DSA_H
> >
> >  #include "qapi/error.h"
> > +#include "exec/cpu-common.h"
> >  #include "qemu/thread.h"
> >  #include "qemu/queue.h"
> >
> > @@ -70,10 +71,11 @@ typedef struct QemuDsaBatchTask {
> >      QemuDsaTaskStatus status;
> >      int batch_size;
> >      bool *results;
> > +    /* Address of each pages in pages */
> > +    ram_addr_t *addr;
> >      QSIMPLEQ_ENTRY(QemuDsaBatchTask) entry;
> >  } QemuDsaBatchTask;
> >
> > -
> >  /**
> >   * @brief Initializes DSA devices.
> >   *
> > @@ -105,8 +107,26 @@ void qemu_dsa_cleanup(void);
> >   */
> >  bool qemu_dsa_is_running(void);
> >
> > +/**
> > + * @brief Initializes a buffer zero DSA batch task.
> > + *
> > + * @param batch_size The number of zero page checking tasks in the bat=
ch.
> > + * @return A pointer to the zero page checking tasks initialized.
> > + */
> > +QemuDsaBatchTask *
> > +buffer_zero_batch_task_init(int batch_size);
> > +
> > +/**
> > + * @brief Performs the proper cleanup on a DSA batch task.
> > + *
> > + * @param task A pointer to the batch task to cleanup.
> > + */
> > +void buffer_zero_batch_task_destroy(QemuDsaBatchTask *task);
> > +
> >  #else
> >
> > +typedef struct QemuDsaBatchTask {} QemuDsaBatchTask;
> > +
> >  static inline bool qemu_dsa_is_running(void)
> >  {
> >      return false;
> > @@ -114,19 +134,27 @@ static inline bool qemu_dsa_is_running(void)
> >
> >  static inline int qemu_dsa_init(const strList *dsa_parameter, Error **=
errp)
> >  {
> > -    if (dsa_parameter !=3D NULL && strlen(dsa_parameter) !=3D 0) {
> > -        error_setg(errp, "DSA is not supported.");
> > -        return -1;
> > -    }
> > -
> > -    return 0;
> > +    error_setg(errp, "DSA accelerator is not enabled.");
> > +    return -1;
>
> This should have been fixed in the patch that introduced this function.
>

Will be fixed directly in an earlier patch.

> >  }
> >
> >  static inline void qemu_dsa_start(void) {}
> >
> >  static inline void qemu_dsa_stop(void) {}
> >
> > -static inline void qemu_dsa_cleanup(void) {}
>
> Where did this go?
>

I will add it back in the next patch. Actually in the non-DSA patch,
this function is not being called. But I agree it should be back for
the sake of completeness.

> > +static inline QemuDsaBatchTask *buffer_zero_batch_task_init(int batch_=
size)
> > +{
> > +    return NULL;
> > +}
> > +
> > +static inline void buffer_zero_batch_task_destroy(QemuDsaBatchTask *ta=
sk) {}
> > +
> > +static inline int
> > +buffer_is_zero_dsa_batch_sync(QemuDsaBatchTask *batch_task,
> > +                              const void **buf, size_t count, size_t l=
en)
> > +{
> > +    return -1;
> > +}
> >
> >  #endif
> >
> > diff --git a/util/dsa.c b/util/dsa.c
> > index c3ca71df86..408c163195 100644
> > --- a/util/dsa.c
> > +++ b/util/dsa.c
> > @@ -48,6 +48,7 @@ uint32_t max_retry_count;
> >  static QemuDsaDeviceGroup dsa_group;
> >  static QemuDsaCompletionThread completion_thread;
> >
> > +static void buffer_zero_dsa_completion(void *context);
> >
> >  /**
> >   * @brief This function opens a DSA device's work queue and
> > @@ -174,7 +175,6 @@ dsa_device_group_start(QemuDsaDeviceGroup *group)
> >   *
> >   * @param group A pointer to the DSA device group.
> >   */
> > -__attribute__((unused))
> >  static void
> >  dsa_device_group_stop(QemuDsaDeviceGroup *group)
> >  {
> > @@ -210,7 +210,6 @@ dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
> >   * @return struct QemuDsaDevice* A pointer to the next available DSA d=
evice
> >   *         in the group.
> >   */
> > -__attribute__((unused))
> >  static QemuDsaDevice *
> >  dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
> >  {
> > @@ -283,7 +282,6 @@ dsa_task_enqueue(QemuDsaDeviceGroup *group,
> >   * @param group A pointer to the DSA device group.
> >   * @return QemuDsaBatchTask* The DSA task being dequeued.
> >   */
> > -__attribute__((unused))
> >  static QemuDsaBatchTask *
> >  dsa_task_dequeue(QemuDsaDeviceGroup *group)
> >  {
> > @@ -338,22 +336,6 @@ submit_wi_int(void *wq, struct dsa_hw_desc *descri=
ptor)
> >      return 0;
> >  }
> >
> > -/**
> > - * @brief Synchronously submits a DSA work item to the
> > - *        device work queue.
> > - *
> > - * @param wq A pointer to the DSA work queue's device memory.
> > - * @param descriptor A pointer to the DSA work item descriptor.
> > - *
> > - * @return int Zero if successful, non-zero otherwise.
> > - */
> > -__attribute__((unused))
> > -static int
> > -submit_wi(void *wq, struct dsa_hw_desc *descriptor)
> > -{
> > -    return submit_wi_int(wq, descriptor);
> > -}
> > -
>
> Why is this being removed?
>

This is the same as submit_wi_int(), so I feel like there is no need
for another wrapper.

> >  /**
> >   * @brief Asynchronously submits a DSA work item to the
> >   *        device work queue.
> > @@ -362,7 +344,6 @@ submit_wi(void *wq, struct dsa_hw_desc *descriptor)
> >   *
> >   * @return int Zero if successful, non-zero otherwise.
> >   */
> > -__attribute__((unused))
> >  static int
> >  submit_wi_async(QemuDsaBatchTask *task)
> >  {
> > @@ -391,7 +372,6 @@ submit_wi_async(QemuDsaBatchTask *task)
> >   *
> >   * @return int Zero if successful, non-zero otherwise.
> >   */
> > -__attribute__((unused))
> >  static int
> >  submit_batch_wi_async(QemuDsaBatchTask *batch_task)
> >  {
> > @@ -750,3 +730,235 @@ void qemu_dsa_cleanup(void)
> >      dsa_device_group_cleanup(&dsa_group);
> >  }
> >
> > +
> > +/* Buffer zero comparison DSA task implementations */
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */
> > +
> > +/**
> > + * @brief Sets a buffer zero comparison DSA task.
> > + *
> > + * @param descriptor A pointer to the DSA task descriptor.
> > + * @param buf A pointer to the memory buffer.
> > + * @param len The length of the buffer.
> > + */
> > +static void
> > +buffer_zero_task_set_int(struct dsa_hw_desc *descriptor,
> > +                         const void *buf,
> > +                         size_t len)
> > +{
> > +    struct dsa_completion_record *completion =3D
> > +        (struct dsa_completion_record *)descriptor->completion_addr;
> > +
> > +    descriptor->xfer_size =3D len;
> > +    descriptor->src_addr =3D (uintptr_t)buf;
> > +    completion->status =3D 0;
> > +    completion->result =3D 0;
> > +}
> > +
> > +/**
> > + * @brief Resets a buffer zero comparison DSA batch task.
> > + *
> > + * @param task A pointer to the DSA batch task.
> > + */
> > +static void
> > +buffer_zero_task_reset(QemuDsaBatchTask *task)
> > +{
> > +    task->completions[0].status =3D DSA_COMP_NONE;
> > +    task->task_type =3D QEMU_DSA_TASK;
> > +    task->status =3D QEMU_DSA_TASK_READY;
> > +}
> > +
> > +/**
> > + * @brief Resets a buffer zero comparison DSA batch task.
> > + *
> > + * @param task A pointer to the batch task.
> > + * @param count The number of DSA tasks this batch task will contain.
> > + */
> > +static void
> > +buffer_zero_batch_task_reset(QemuDsaBatchTask *task, size_t count)
> > +{
> > +    task->batch_completion.status =3D DSA_COMP_NONE;
> > +    task->batch_descriptor.desc_count =3D count;
> > +    task->task_type =3D QEMU_DSA_BATCH_TASK;
> > +    task->status =3D QEMU_DSA_TASK_READY;
> > +}
> > +
> > +/**
> > + * @brief Sets a buffer zero comparison DSA task.
> > + *
> > + * @param task A pointer to the DSA task.
> > + * @param buf A pointer to the memory buffer.
> > + * @param len The buffer length.
> > + */
> > +static void
> > +buffer_zero_task_set(QemuDsaBatchTask *task,
> > +                     const void *buf,
> > +                     size_t len)
> > +{
> > +    buffer_zero_task_reset(task);
> > +    buffer_zero_task_set_int(&task->descriptors[0], buf, len);
> > +}
> > +
> > +/**
> > + * @brief Sets a buffer zero comparison batch task.
> > + *
> > + * @param batch_task A pointer to the batch task.
> > + * @param buf An array of memory buffers.
> > + * @param count The number of buffers in the array.
> > + * @param len The length of the buffers.
> > + */
> > +static void
> > +buffer_zero_batch_task_set(QemuDsaBatchTask *batch_task,
> > +                           const void **buf, size_t count, size_t len)
> > +{
> > +    assert(count > 0);
> > +    assert(count <=3D batch_task->batch_size);
> > +
> > +    buffer_zero_batch_task_reset(batch_task, count);
> > +    for (int i =3D 0; i < count; i++) {
> > +        buffer_zero_task_set_int(&batch_task->descriptors[i], buf[i], =
len);
> > +    }
> > +}
> > +
> > +/**
> > + * @brief Asychronously perform a buffer zero DSA operation.
> > + *
> > + * @param task A pointer to the batch task structure.
> > + * @param buf A pointer to the memory buffer.
> > + * @param len The length of the memory buffer.
> > + *
> > + * @return int Zero if successful, otherwise an appropriate error code=
.
> > + */
> > +__attribute__((unused))
> > +static int
> > +buffer_zero_dsa_async(QemuDsaBatchTask *task,
> > +                      const void *buf, size_t len)
> > +{
> > +    buffer_zero_task_set(task, buf, len);
> > +
> > +    return submit_wi_async(task);
> > +}
> > +
> > +/**
> > + * @brief Sends a memory comparison batch task to a DSA device and wai=
t
> > + *        for completion.
> > + *
> > + * @param batch_task The batch task to be submitted to DSA device.
> > + * @param buf An array of memory buffers to check for zero.
> > + * @param count The number of buffers.
> > + * @param len The buffer length.
> > + */
> > +__attribute__((unused))
> > +static int
> > +buffer_zero_dsa_batch_async(QemuDsaBatchTask *batch_task,
> > +                            const void **buf, size_t count, size_t len=
)
> > +{
> > +    assert(count <=3D batch_task->batch_size);
> > +    buffer_zero_batch_task_set(batch_task, buf, count, len);
> > +
> > +    return submit_batch_wi_async(batch_task);
> > +}
> > +
> > +/**
> > + * @brief The completion callback function for buffer zero
> > + *        comparison DSA task completion.
> > + *
> > + * @param context A pointer to the callback context.
> > + */
> > +static void
> > +buffer_zero_dsa_completion(void *context)
> > +{
> > +    assert(context !=3D NULL);
> > +
> > +    QemuDsaBatchTask *task =3D (QemuDsaBatchTask *)context;
> > +    qemu_sem_post(&task->sem_task_complete);
> > +}
> > +
> > +/**
> > + * @brief Wait for the asynchronous DSA task to complete.
> > + *
> > + * @param batch_task A pointer to the buffer zero comparison batch tas=
k.
> > + */
> > +__attribute__((unused))
> > +static void
> > +buffer_zero_dsa_wait(QemuDsaBatchTask *batch_task)
> > +{
> > +    qemu_sem_wait(&batch_task->sem_task_complete);
> > +}
> > +
> > +/**
> > + * @brief Initializes a buffer zero comparison DSA task.
> > + *
> > + * @param descriptor A pointer to the DSA task descriptor.
> > + * @param completion A pointer to the DSA task completion record.
> > + */
> > +static void
> > +buffer_zero_task_init_int(struct dsa_hw_desc *descriptor,
> > +                          struct dsa_completion_record *completion)
> > +{
> > +    descriptor->opcode =3D DSA_OPCODE_COMPVAL;
> > +    descriptor->flags =3D IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
> > +    descriptor->comp_pattern =3D (uint64_t)0;
> > +    descriptor->completion_addr =3D (uint64_t)completion;
> > +}
> > +
> > +/**
> > + * @brief Initializes a buffer zero DSA batch task.
> > + *
> > + * @param batch_size The number of zero page checking tasks in the bat=
ch.
> > + * @return A pointer to the zero page checking tasks initialized.
> > + */
> > +QemuDsaBatchTask *
> > +buffer_zero_batch_task_init(int batch_size)
> > +{
> > +    QemuDsaBatchTask *task =3D qemu_memalign(64, sizeof(QemuDsaBatchTa=
sk));
> > +    int descriptors_size =3D sizeof(*task->descriptors) * batch_size;
> > +
> > +    memset(task, 0, sizeof(*task));
> > +    task->addr =3D g_new0(ram_addr_t, batch_size);
> > +    task->results =3D g_new0(bool, batch_size);
> > +    task->batch_size =3D batch_size;
> > +    task->descriptors =3D
> > +        (struct dsa_hw_desc *)qemu_memalign(64, descriptors_size);
> > +    memset(task->descriptors, 0, descriptors_size);
> > +    task->completions =3D (struct dsa_completion_record *)qemu_memalig=
n(
> > +        32, sizeof(*task->completions) * batch_size);
> > +
> > +    task->batch_completion.status =3D DSA_COMP_NONE;
> > +    task->batch_descriptor.completion_addr =3D (uint64_t)&task->batch_=
completion;
> > +    /* TODO: Ensure that we never send a batch with count <=3D 1 */
> > +    task->batch_descriptor.desc_count =3D 0;
> > +    task->batch_descriptor.opcode =3D DSA_OPCODE_BATCH;
> > +    task->batch_descriptor.flags =3D IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_C=
RAV;
> > +    task->batch_descriptor.desc_list_addr =3D (uintptr_t)task->descrip=
tors;
> > +    task->status =3D QEMU_DSA_TASK_READY;
> > +    task->group =3D &dsa_group;
> > +    task->device =3D dsa_device_group_get_next_device(&dsa_group);
> > +
> > +    for (int i =3D 0; i < task->batch_size; i++) {
> > +        buffer_zero_task_init_int(&task->descriptors[i],
> > +                                  &task->completions[i]);
> > +    }
> > +
> > +    qemu_sem_init(&task->sem_task_complete, 0);
> > +    task->completion_callback =3D buffer_zero_dsa_completion;
> > +
> > +    return task;
> > +}
> > +
> > +/**
> > + * @brief Performs the proper cleanup on a DSA batch task.
> > + *
> > + * @param task A pointer to the batch task to cleanup.
> > + */
> > +void
> > +buffer_zero_batch_task_destroy(QemuDsaBatchTask *task)
> > +{
> > +    g_free(task->addr);
> > +    g_free(task->results);
> > +    qemu_vfree(task->descriptors);
> > +    qemu_vfree(task->completions);
> > +    task->results =3D NULL;
> > +    qemu_sem_destroy(&task->sem_task_complete);
> > +    qemu_vfree(task);
> > +}

