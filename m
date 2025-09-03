Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28438CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfgr-000498-14; Wed, 03 Sep 2025 01:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1utfgm-00047O-6C
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:05:44 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1utfgh-0005Pa-Sd
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:05:43 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-333f901b2d2so55493631fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1756875938; x=1757480738;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ib9u/RWcWtB7qs4O3aAA2T+kJkFuNoqvCTJqodVm7dA=;
 b=hxD+oJfRBYqxqUdOG5LP4L4OJBxsyIVyKCbvsxZp/EZhYNICd8ByyK6GqwsdcXA/1m
 f3ieF+gAa9En8dJ8tLy9I1CmgQPXk8MTPvGmFruSSK1qc2kdP0X/i03iYRdNqb6gV9Xd
 B9C/d9vod6SqNSfmJc3zjhfFoyKm63OBKc6ddeMinhdNMBLyv2YW7nCVpXmhOfWtyDFX
 zZQyYU4Jm4OMoqvpL8Mu0u86+lsqWkmWBqF3J0eCij2D6ngqG1P+6Ch0WCsXpGWCqI/i
 YSUUMFbp6c3Bh5wlYSLfHr6lzIhELRPqqbwunuHB7XaKlloBD+U1TPRH8eGVdTazoP6Z
 hU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756875938; x=1757480738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ib9u/RWcWtB7qs4O3aAA2T+kJkFuNoqvCTJqodVm7dA=;
 b=uoiNRmwnzuNvtQcGXwGJiER73sF/klddAASVCo6sCrntaiPy4md8nuJKd3FCqj6hnP
 6TL2Uex5q+BI5+nntWY6sisTbYcg14vbwta9BTzHeFnsmJkkPq9QQZHO9RD9XeO+TE0n
 3ghYr44mtDGG8BDZWm8v3SqH4msk1+2wWf2x6LGpc2sXZ+Ox4dZ0BW99XD9kzDZGIdRV
 N+4yJSIUoaO8yRQfymBF1yRWra604dce+kiPaeXvSh5IBbhokRDWz9Hzs9WjqgJlGzkB
 BLud9Ci3iRa8EnTEnku7YJH38Y/C6G1miBh6H7qkO9cy7IGjprTIYQd86k3w5PLT+irW
 WSiw==
X-Gm-Message-State: AOJu0YzzRQ2XtMPUiaeFluLL967WJINNaOm1XAwTA0H3WnANqDwzzynI
 sKXkX37N5mC2EyJ+7ouHmkoc85HfBcZM2f4QcrUyXsko+3dbHSyUeY75CQtJZs+HN77rwPoMw3W
 eMTGQD4IxXRMXtnaHkpPPlXS6ZCOUwup9bRLVV20Bqy1SnCrw9zKtM3k=
X-Gm-Gg: ASbGnctCL/EfyqFlRX662QFveCYM03X4HeuXvjB8vrXI5R4ItvSqzhqFVJIxybGMINb
 +2Z1qE0VwUPWfr946YSppeOLftNxCWYXBwI75iJdWhC4H4ngEazYnoGi8pABEySOUkWvkrnOhjl
 g2gqXVc8vmLWL4J6DShOeQl/F7gBAMahl8eQbejTGyZ2kNDMtzlF9ZrL0VewfRYrWVd4YdW5eZF
 C1JTyp/waBDP8KtnwOq
X-Google-Smtp-Source: AGHT+IEIUm+T3beLWZtswbWjovL+h32ltEPW4IhY8SbLiMJ9uA1j6newxjg3QPzd+zpVemsBW8ZdGu20JezMGle82uQ=
X-Received: by 2002:a05:651c:e17:b0:336:a702:768 with SMTP id
 38308e7fff4ca-336ca8de4c5mr38503421fa.9.1756875937687; Tue, 02 Sep 2025
 22:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250901092043.28722-1-cjchen@igel.co.jp>
In-Reply-To: <20250901092043.28722-1-cjchen@igel.co.jp>
From: chen CJ <cjchen@igel.co.jp>
Date: Wed, 3 Sep 2025 14:05:26 +0900
X-Gm-Features: Ac12FXz6gaQW93uNbH-NsEogMcMG50si492Pa5mNcBymz7kuu7Ut-I806wMVLQo
Message-ID: <CAAMq-Y9p1Sy7koo6L4ESm-RQbxpY17FWtWRn279zvb6hiT1cgQ@mail.gmail.com>
Subject: [Withdrawn] [PATCH] block/iscsi: fix crashes on session disconnect
 and I/O hard timeout
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 ronniesahlberg@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=cjchen@igel.co.jp; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I would like to withdraw this patch series.

Sorry for the inconvenience, and thank you for your understanding.

CJ Chen <cjchen@igel.co.jp> =E6=96=BC 2025=E5=B9=B49=E6=9C=881=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> When an iSCSI session drops or an I/O stalls past a hard timeout,
> requests could complete after teardown and coroutines might be woken
> in an invalid state. This patch clarifies task ownership and hardens
> completion paths.
>
> Changes:
>  - Add a per-command deadline (I/O hard timeout). On expiry, cancel
>    the libiscsi task, detach the coroutine (co =3D NULL), and let the
>    callback free the task safely.
>  - Track inflight tasks and fail them promptly on session disconnect
>    when fail-fast is enabled. Throttle reconnect attempts and drive
>    them via the periodic timer and NOP keepalives.
>  - Always refresh the fd event mask after state changes. Tidy event,
>    read, and write handlers, and remove unused labels/duplicates.
>  - Arm deadlines only for heap-allocated tasks (read/write/flush).
>    Stack-based helper paths continue to wait synchronously without
>    deadlines.
>
> User-visible effect: under error conditions we now return -ETIMEDOUT
> or -ENOTCONN instead of hanging or crashing. Normal I/O behavior is
> unchanged. Internally, a 5s hard timeout with fail-fast is enforced to
> avoid indefinite stalls.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3067
>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> ---
>  block/iscsi.c | 449 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 358 insertions(+), 91 deletions(-)
>
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 15b96ee880..094b51c47c 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -49,6 +49,7 @@
>  #include "crypto/secret.h"
>  #include "scsi/utils.h"
>  #include "trace.h"
> +#include "qemu/timer.h"
>
>  /* Conflict between scsi/utils.h and libiscsi! :( */
>  #define SCSI_XFER_NONE ISCSI_XFER_NONE
> @@ -74,6 +75,8 @@ typedef struct IscsiLun {
>      QEMUTimer *nop_timer;
>      QEMUTimer *event_timer;
>      QemuMutex mutex;
> +    int64_t next_reconnect_ms;   /* throttle repeated reconnects */
> +    bool last_logged_in;         /* for state-change logging */
>      struct scsi_inquiry_logical_block_provisioning lbp;
>      struct scsi_inquiry_block_limits bl;
>      struct scsi_inquiry_device_designator *dd;
> @@ -103,6 +106,9 @@ typedef struct IscsiLun {
>      bool dpofua;
>      bool has_write_same;
>      bool request_timed_out;
> +    uint32_t io_hard_timeout_ms;
> +    bool fail_fast;
> +    QTAILQ_HEAD(, IscsiTask) inflight;
>  } IscsiLun;
>
>  typedef struct IscsiTask {
> @@ -116,6 +122,12 @@ typedef struct IscsiTask {
>      QEMUTimer retry_timer;
>      int err_code;
>      char *err_str;
> +    QEMUTimer deadline_timer;
> +    bool deadline_armed;
> +    bool hard_timed_out;
> +    int64_t first_submit_ms;
> +    QTAILQ_ENTRY(IscsiTask) entry;
> +    bool on_list;
>  } IscsiTask;
>
>  typedef struct IscsiAIOCB {
> @@ -185,7 +197,9 @@ static void iscsi_co_generic_bh_cb(void *opaque)
>      struct IscsiTask *iTask =3D opaque;
>
>      iTask->complete =3D 1;
> -    aio_co_wake(iTask->co);
> +    if (iTask->co) {
> +        aio_co_wake(iTask->co);
> +    }
>  }
>
>  static void iscsi_retry_timer_expired(void *opaque)
> @@ -232,75 +246,148 @@ static int iscsi_translate_sense(struct scsi_sense=
 *sense)
>                                 sense->ascq & 0xFF);
>  }
>
> +static void iscsi_fail_inflight(IscsiLun *s, int err)
> +{
> +    IscsiTask *it, *next;
> +    int n =3D 0;
> +
> +    QTAILQ_FOREACH_SAFE(it, &s->inflight, entry, next) {
> +        if (it->deadline_armed) {
> +            timer_del(&it->deadline_timer);
> +            it->deadline_armed =3D false;
> +        }
> +        it->err_code =3D err ? err : -EIO;
> +        it->hard_timed_out =3D true;
> +        it->status =3D SCSI_STATUS_TIMEOUT;
> +
> +        if (it->task) {
> +            iscsi_scsi_cancel_task(s->iscsi, it->task);
> +        }
> +
> +        if (it->co) {
> +            replay_bh_schedule_oneshot_event(s->aio_context,
> +                                             iscsi_co_generic_bh_cb, it)=
;
> +        } else {
> +            it->complete =3D 1;
> +        }
> +        QTAILQ_REMOVE(&s->inflight, it, entry);
> +        it->on_list =3D false;
> +        n++;
> +    }
> +}
> +
>  /* Called (via iscsi_service) with QemuMutex held.  */
>  static void
>  iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
> -                        void *command_data, void *opaque)
> +                    void *command_data, void *opaque)
>  {
>      struct IscsiTask *iTask =3D opaque;
>      struct scsi_task *task =3D command_data;
>
> +    if (iTask->deadline_armed) {
> +        timer_del(&iTask->deadline_timer);
> +        iTask->deadline_armed =3D false;
> +    }
> +
>      iTask->status =3D status;
>      iTask->do_retry =3D 0;
>      iTask->err_code =3D 0;
>      iTask->task =3D task;
>
>      if (status !=3D SCSI_STATUS_GOOD) {
> -        iTask->err_code =3D -EIO;
> -        if (iTask->retries++ < ISCSI_CMD_RETRIES) {
> -            if (status =3D=3D SCSI_STATUS_BUSY ||
> -                status =3D=3D SCSI_STATUS_TIMEOUT ||
> -                status =3D=3D SCSI_STATUS_TASK_SET_FULL) {
> -                unsigned retry_time =3D
> -                    exp_random(iscsi_retry_times[iTask->retries - 1]);
> -                if (status =3D=3D SCSI_STATUS_TIMEOUT) {
> -                    /* make sure the request is rescheduled AFTER the
> -                     * reconnect is initiated */
> -                    retry_time =3D EVENT_INTERVAL * 2;
> -                    iTask->iscsilun->request_timed_out =3D true;
> -                }
> -                error_report("iSCSI Busy/TaskSetFull/TimeOut"
> -                             " (retry #%u in %u ms): %s",
> -                             iTask->retries, retry_time,
> -                             iscsi_get_error(iscsi));
> -                aio_timer_init(iTask->iscsilun->aio_context,
> -                               &iTask->retry_timer, QEMU_CLOCK_REALTIME,
> -                               SCALE_MS, iscsi_retry_timer_expired, iTas=
k);
> -                timer_mod(&iTask->retry_timer,
> -                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry=
_time);
> -                iTask->do_retry =3D 1;
> -                return;
> -            } else if (status =3D=3D SCSI_STATUS_CHECK_CONDITION) {
> -                int error =3D iscsi_translate_sense(&task->sense);
> -                if (error =3D=3D EAGAIN) {
> -                    error_report("iSCSI CheckCondition: %s",
> +        if (iTask->hard_timed_out) {
> +            iTask->err_code =3D -ETIMEDOUT;
> +            iTask->err_str =3D g_strdup("iSCSI hard timeout");
> +            iTask->do_retry =3D 0;
> +        } else {
> +            iTask->err_code =3D -EIO;
> +            if (iTask->retries++ < ISCSI_CMD_RETRIES) {
> +                if (status =3D=3D SCSI_STATUS_BUSY ||
> +                    status =3D=3D SCSI_STATUS_TIMEOUT ||
> +                    status =3D=3D SCSI_STATUS_TASK_SET_FULL) {
> +                    unsigned retry_time =3D
> +                        exp_random(iscsi_retry_times[iTask->retries - 1]=
);
> +                    if (status =3D=3D SCSI_STATUS_TIMEOUT) {
> +                        /*
> +                         * make sure the request is rescheduled AFTER th=
e
> +                         * reconnect is initiated
> +                         */
> +                        retry_time =3D EVENT_INTERVAL * 2;
> +                        iTask->iscsilun->request_timed_out =3D true;
> +                    }
> +                    error_report("iSCSI Busy/TaskSetFull/TimeOut"
> +                                 " (retry #%u in %u ms): %s",
> +                                 iTask->retries, retry_time,
>                                   iscsi_get_error(iscsi));
> +                    aio_timer_init(iTask->iscsilun->aio_context,
> +                                   &iTask->retry_timer, QEMU_CLOCK_REALT=
IME,
> +                                   SCALE_MS, iscsi_retry_timer_expired, =
iTask);
> +                    timer_mod(&iTask->retry_timer,
> +                              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + r=
etry_time);
>                      iTask->do_retry =3D 1;
> +                    return;
> +                } else if (status =3D=3D SCSI_STATUS_CHECK_CONDITION) {
> +                    int error =3D iscsi_translate_sense(&task->sense);
> +                    if (error =3D=3D EAGAIN) {
> +                        error_report("iSCSI CheckCondition: %s",
> +                                     iscsi_get_error(iscsi));
> +                        iTask->do_retry =3D 1;
> +                    } else {
> +                        iTask->err_code =3D -error;
> +                        iTask->err_str =3D g_strdup(iscsi_get_error(iscs=
i));
> +                    }
>                  } else {
> -                    iTask->err_code =3D -error;
> +                    if (!iTask->err_str) {
> +                        iTask->err_str =3D g_strdup(iscsi_get_error(iscs=
i));
> +                    }
> +                }
> +            } else {
> +                if (!iTask->err_str) {
>                      iTask->err_str =3D g_strdup(iscsi_get_error(iscsi));
>                  }
>              }
>          }
>      }
> -
>      if (iTask->co) {
>          replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
>                                           iscsi_co_generic_bh_cb, iTask);
>      } else {
>          iTask->complete =3D 1;
> +        if (iTask->task) {
> +            scsi_free_scsi_task(iTask->task);
> +            iTask->task =3D NULL;
> +        }
> +        g_free(iTask->err_str);
> +        g_free(iTask);
>      }
> +
>  }
>
>  static void coroutine_fn
>  iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
>  {
>      *iTask =3D (struct IscsiTask) {
> -        .co         =3D qemu_coroutine_self(),
> -        .iscsilun   =3D iscsilun,
> +        .co              =3D qemu_coroutine_self(),
> +        .iscsilun        =3D iscsilun,
> +        .deadline_armed  =3D false,
> +        .hard_timed_out  =3D false,
> +        .first_submit_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME),
> +        .on_list         =3D false,
>      };
>  }
>
> +static IscsiTask * coroutine_fn iscsi_task_new(IscsiLun *iscsilun)
> +{
> +    IscsiTask *iTask =3D g_new0(IscsiTask, 1);
> +    iTask->co              =3D qemu_coroutine_self();
> +    iTask->iscsilun        =3D iscsilun;
> +    iTask->deadline_armed  =3D false;
> +    iTask->hard_timed_out  =3D false;
> +    iTask->first_submit_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    iTask->on_list         =3D false;
> +    return iTask;
> +}
> +
>  #ifdef __linux__
>
>  /* Called (via iscsi_service) with QemuMutex held. */
> @@ -371,17 +458,85 @@ iscsi_set_events(IscsiLun *iscsilun)
>      }
>  }
>
> +/* Try to (re)connect, but throttle to avoid storms. */
> +static void iscsi_maybe_reconnect(IscsiLun *iscsilun)
> +{
> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (now < iscsilun->next_reconnect_ms) {
> +        return;
> +    }
> +    iscsi_reconnect(iscsilun->iscsi);
> +    iscsilun->next_reconnect_ms =3D now + 2000; /* 2s throttle */
> +    /* After changing connection state, refresh event mask immediately. =
*/
> +    iscsi_set_events(iscsilun);
> +}
> +
> +static void iscsi_deadline_timer_expired(void *opaque)
> +{
> +    struct IscsiTask *iTask =3D opaque;
> +    IscsiLun *iscsilun =3D iTask->iscsilun;
> +
> +    if (!iTask->deadline_armed) {
> +        return;
> +    }
> +    iTask->deadline_armed =3D false;
> +    iTask->hard_timed_out =3D true;
> +    iTask->status   =3D SCSI_STATUS_TIMEOUT;
> +    iTask->err_code =3D -ETIMEDOUT;
> +
> +    if (iscsilun) {
> +        qemu_mutex_lock(&iscsilun->mutex);
> +        if (iTask->task) {
> +            iscsi_scsi_cancel_task(iscsilun->iscsi, iTask->task);
> +            if (iTask->co) {
> +                replay_bh_schedule_oneshot_event(iscsilun->aio_context,
> +                                                 iscsi_co_generic_bh_cb,=
 iTask);
> +            }
> +            iscsi_set_events(iscsilun);
> +        }
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +    }
> +}
> +
> +static inline void iscsi_arm_deadline(struct IscsiTask *iTask)
> +{
> +    IscsiLun *iscsilun =3D iTask->iscsilun;
> +
> +    if (!iscsilun->io_hard_timeout_ms || iTask->deadline_armed) {
> +        return;
> +    }
> +    aio_timer_init(iscsilun->aio_context, &iTask->deadline_timer,
> +                   QEMU_CLOCK_REALTIME, SCALE_MS,
> +                   iscsi_deadline_timer_expired, iTask);
> +    timer_mod(&iTask->deadline_timer,
> +              iTask->first_submit_ms + iscsilun->io_hard_timeout_ms);
> +    iTask->deadline_armed =3D true;
> +}
> +
>  static void iscsi_timed_check_events(void *opaque)
>  {
>      IscsiLun *iscsilun =3D opaque;
>
>      WITH_QEMU_LOCK_GUARD(&iscsilun->mutex) {
> +        bool logged_in_before =3D iscsilun->last_logged_in;
> +        bool logged_in_now;
>          /* check for timed out requests */
>          iscsi_service(iscsilun->iscsi, 0);
> +        logged_in_now =3D iscsi_is_logged_in(iscsilun->iscsi);
> +        if (logged_in_before !=3D logged_in_now) {
> +            iscsilun->last_logged_in =3D logged_in_now;
> +            if (logged_in_before && !logged_in_now && iscsilun->fail_fas=
t) {
> +                iscsi_fail_inflight(iscsilun, -ENOTCONN);
> +            }
> +        }
>
>          if (iscsilun->request_timed_out) {
>              iscsilun->request_timed_out =3D false;
> -            iscsi_reconnect(iscsilun->iscsi);
> +            iscsi_maybe_reconnect(iscsilun);
> +        }
> +
> +        if (!logged_in_now) {
> +            iscsi_maybe_reconnect(iscsilun);
>          }
>
>          /*
> @@ -605,7 +760,7 @@ iscsi_co_writev(BlockDriverState *bs, int64_t sector_=
num, int nb_sectors,
>                  QEMUIOVector *iov, int flags)
>  {
>      IscsiLun *iscsilun =3D bs->opaque;
> -    struct IscsiTask iTask;
> +    IscsiTask *iTask;
>      uint64_t lba;
>      uint32_t num_sectors;
>      bool fua =3D flags & BDRV_REQ_FUA;
> @@ -624,21 +779,27 @@ iscsi_co_writev(BlockDriverState *bs, int64_t secto=
r_num, int nb_sectors,
>
>      lba =3D sector_qemu2lun(sector_num, iscsilun);
>      num_sectors =3D sector_qemu2lun(nb_sectors, iscsilun);
> -    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    iTask =3D iscsi_task_new(iscsilun);
>      qemu_mutex_lock(&iscsilun->mutex);
> +    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask->err_str);
> +        g_free(iTask);
> +        return -ENOTCONN;
> +    }
>  retry:
>      if (iscsilun->use_16_for_rw) {
>  #if LIBISCSI_API_VERSION >=3D (20160603)
> -        iTask.task =3D iscsi_write16_iov_task(iscsilun->iscsi, iscsilun-=
>lun, lba,
> +        iTask->task =3D iscsi_write16_iov_task(iscsilun->iscsi, iscsilun=
->lun, lba,
>                                              NULL, num_sectors * iscsilun=
->block_size,
>                                              iscsilun->block_size, 0, 0, =
fua, 0, 0,
> -                                            iscsi_co_generic_cb, &iTask,
> +                                            iscsi_co_generic_cb, iTask,
>                                              (struct scsi_iovec *)iov->io=
v, iov->niov);
>      } else {
> -        iTask.task =3D iscsi_write10_iov_task(iscsilun->iscsi, iscsilun-=
>lun, lba,
> +        iTask->task =3D iscsi_write10_iov_task(iscsilun->iscsi, iscsilun=
->lun, lba,
>                                              NULL, num_sectors * iscsilun=
->block_size,
>                                              iscsilun->block_size, 0, 0, =
fua, 0, 0,
> -                                            iscsi_co_generic_cb, &iTask,
> +                                            iscsi_co_generic_cb, iTask,
>                                              (struct scsi_iovec *)iov->io=
v, iov->niov);
>      }
>  #else
> @@ -653,41 +814,62 @@ retry:
>                                          iscsi_co_generic_cb, &iTask);
>      }
>  #endif
> -    if (iTask.task =3D=3D NULL) {
> +    if (iTask->task =3D=3D NULL) {
>          qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask);
>          return -ENOMEM;
>      }
>  #if LIBISCSI_API_VERSION < (20160603)
>      scsi_task_set_iov_out(iTask.task, (struct scsi_iovec *) iov->iov,
>                            iov->niov);
>  #endif
> -    iscsi_co_wait_for_task(&iTask, iscsilun);
> +    iscsi_set_events(iscsilun);
> +    if (!iTask->on_list) {
> +        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D true;
> +    }
> +    iscsi_arm_deadline(iTask);
> +    iscsi_co_wait_for_task(iTask, iscsilun);
>
> -    if (iTask.task !=3D NULL) {
> -        scsi_free_scsi_task(iTask.task);
> -        iTask.task =3D NULL;
> +    if (!iTask->hard_timed_out && iTask->task !=3D NULL) {
> +        scsi_free_scsi_task(iTask->task);
> +        iTask->task =3D NULL;
>      }
>
> -    if (iTask.do_retry) {
> -        iTask.complete =3D 0;
> +    if (iTask->do_retry) {
> +        iTask->complete =3D 0;
>          goto retry;
>      }
>
> -    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +    if (iTask->hard_timed_out) {
> +        r =3D iTask->err_code ? iTask->err_code : -ETIMEDOUT;
> +        iTask->co =3D NULL;
> +        if (iTask->on_list) {
> +            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +            iTask->on_list =3D false;
> +        }
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return r;
> +    }
> +
> +    if (iTask->status !=3D SCSI_STATUS_GOOD) {
>          iscsi_allocmap_set_invalid(iscsilun, sector_num * BDRV_SECTOR_SI=
ZE,
>                                     nb_sectors * BDRV_SECTOR_SIZE);
>          error_report("iSCSI WRITE10/16 failed at lba %" PRIu64 ": %s", l=
ba,
> -                     iTask.err_str);
> -        r =3D iTask.err_code;
> -        goto out_unlock;
> +                     iTask->err_str);
> +        r =3D iTask->err_code;
> +    } else {
> +        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_=
SIZE,
> +                                     nb_sectors * BDRV_SECTOR_SIZE);
>      }
>
> -    iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE=
,
> -                                 nb_sectors * BDRV_SECTOR_SIZE);
> -
> -out_unlock:
> +    if (iTask->on_list) {
> +        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D false;
> +    }
>      qemu_mutex_unlock(&iscsilun->mutex);
> -    g_free(iTask.err_str);
> +    g_free(iTask->err_str);
> +    g_free(iTask);
>      return r;
>  }
>
> @@ -733,6 +915,8 @@ retry:
>          ret =3D -ENOMEM;
>          goto out_unlock;
>      }
> +    iscsi_arm_deadline(&iTask);
> +    iscsi_set_events(iscsilun);
>      iscsi_co_wait_for_task(&iTask, iscsilun);
>
>      if (iTask.do_retry) {
> @@ -801,7 +985,7 @@ static int coroutine_fn iscsi_co_readv(BlockDriverSta=
te *bs,
>                                         QEMUIOVector *iov)
>  {
>      IscsiLun *iscsilun =3D bs->opaque;
> -    struct IscsiTask iTask;
> +    IscsiTask *iTask;
>      uint64_t lba;
>      uint32_t num_sectors;
>      int r =3D 0;
> @@ -856,22 +1040,28 @@ static int coroutine_fn iscsi_co_readv(BlockDriver=
State *bs,
>      lba =3D sector_qemu2lun(sector_num, iscsilun);
>      num_sectors =3D sector_qemu2lun(nb_sectors, iscsilun);
>
> -    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    iTask =3D iscsi_task_new(iscsilun);
>      qemu_mutex_lock(&iscsilun->mutex);
> +    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask->err_str);
> +        g_free(iTask);
> +        return -ENOTCONN;
> +    }
>  retry:
>      if (iscsilun->use_16_for_rw) {
>  #if LIBISCSI_API_VERSION >=3D (20160603)
> -        iTask.task =3D iscsi_read16_iov_task(iscsilun->iscsi, iscsilun->=
lun, lba,
> +        iTask->task =3D iscsi_read16_iov_task(iscsilun->iscsi, iscsilun-=
>lun, lba,
>                                             num_sectors * iscsilun->block=
_size,
>                                             iscsilun->block_size, 0, 0, 0=
, 0, 0,
> -                                           iscsi_co_generic_cb, &iTask,
> +                                           iscsi_co_generic_cb, iTask,
>                                             (struct scsi_iovec *)iov->iov=
, iov->niov);
>      } else {
> -        iTask.task =3D iscsi_read10_iov_task(iscsilun->iscsi, iscsilun->=
lun, lba,
> +        iTask->task =3D iscsi_read10_iov_task(iscsilun->iscsi, iscsilun-=
>lun, lba,
>                                             num_sectors * iscsilun->block=
_size,
>                                             iscsilun->block_size,
>                                             0, 0, 0, 0, 0,
> -                                           iscsi_co_generic_cb, &iTask,
> +                                           iscsi_co_generic_cb, iTask,
>                                             (struct scsi_iovec *)iov->iov=
, iov->niov);
>      }
>  #else
> @@ -887,70 +1077,119 @@ retry:
>                                         iscsi_co_generic_cb, &iTask);
>      }
>  #endif
> -    if (iTask.task =3D=3D NULL) {
> +    if (iTask->task =3D=3D NULL) {
>          qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask);
>          return -ENOMEM;
>      }
>  #if LIBISCSI_API_VERSION < (20160603)
>      scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *) iov->iov, iov=
->niov);
>  #endif
> -
> -    iscsi_co_wait_for_task(&iTask, iscsilun);
> -    if (iTask.task !=3D NULL) {
> -        scsi_free_scsi_task(iTask.task);
> -        iTask.task =3D NULL;
> +    if (!iTask->on_list) {
> +        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D true;
> +    }
> +    iscsi_arm_deadline(iTask);
> +    iscsi_co_wait_for_task(iTask, iscsilun);
> +    if (!iTask->hard_timed_out && iTask->task !=3D NULL) {
> +        scsi_free_scsi_task(iTask->task);
> +        iTask->task =3D NULL;
>      }
>
> -    if (iTask.do_retry) {
> -        iTask.complete =3D 0;
> +    if (iTask->do_retry) {
> +        iTask->complete =3D 0;
>          goto retry;
>      }
>
> -    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> +    if (iTask->hard_timed_out) {
> +        r =3D iTask->err_code ? iTask->err_code : -ETIMEDOUT;
> +        iTask->co =3D NULL;
> +        if (iTask->on_list) {
> +            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +            iTask->on_list =3D false;
> +        }
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return r;
> +    }
> +
> +    if (iTask->status !=3D SCSI_STATUS_GOOD) {
>          error_report("iSCSI READ10/16 failed at lba %" PRIu64 ": %s",
> -                     lba, iTask.err_str);
> -        r =3D iTask.err_code;
> +                     lba, iTask->err_str);
> +        r =3D iTask->err_code;
>      }
>
> +    if (iTask->on_list) {
> +        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D false;
> +    }
>      qemu_mutex_unlock(&iscsilun->mutex);
> -    g_free(iTask.err_str);
> +    g_free(iTask->err_str);
> +    g_free(iTask);
>      return r;
>  }
>
>  static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
>  {
>      IscsiLun *iscsilun =3D bs->opaque;
> -    struct IscsiTask iTask;
> +    IscsiTask *iTask;
>      int r =3D 0;
>
> -    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +    iTask =3D iscsi_task_new(iscsilun);
>      qemu_mutex_lock(&iscsilun->mutex);
> +    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask->err_str);
> +        g_free(iTask);
> +        return -ENOTCONN;
> +    }
>  retry:
>      if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0,=
 0, 0,
> -                                      0, iscsi_co_generic_cb, &iTask) =
=3D=3D NULL) {
> +                                      0, iscsi_co_generic_cb, iTask) =3D=
=3D NULL) {
>          qemu_mutex_unlock(&iscsilun->mutex);
> +        g_free(iTask);
>          return -ENOMEM;
>      }
> +    iscsi_set_events(iscsilun);
> +    if (!iTask->on_list) {
> +        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D true;
> +    }
> +    iscsi_arm_deadline(iTask);
> +    iscsi_co_wait_for_task(iTask, iscsilun);
>
> -    iscsi_co_wait_for_task(&iTask, iscsilun);
> -
> -    if (iTask.task !=3D NULL) {
> -        scsi_free_scsi_task(iTask.task);
> -        iTask.task =3D NULL;
> +    if (!iTask->hard_timed_out && iTask->task !=3D NULL) {
> +        scsi_free_scsi_task(iTask->task);
> +        iTask->task =3D NULL;
>      }
>
> -    if (iTask.do_retry) {
> -        iTask.complete =3D 0;
> +    if (iTask->do_retry) {
> +        iTask->complete =3D 0;
>          goto retry;
>      }
>
> -    if (iTask.status !=3D SCSI_STATUS_GOOD) {
> -        error_report("iSCSI SYNCHRONIZECACHE10 failed: %s", iTask.err_st=
r);
> -        r =3D iTask.err_code;
> +    if (iTask->hard_timed_out) {
> +        r =3D iTask->err_code ? iTask->err_code : -ETIMEDOUT;
> +        iTask->co =3D NULL; /* detach */
> +        if (iTask->on_list) {
> +            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +            iTask->on_list =3D false;
> +        }
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        return r;
>      }
>
> +    if (iTask->status !=3D SCSI_STATUS_GOOD) {
> +        error_report("iSCSI SYNCHRONIZECACHE10 failed: %s", iTask->err_s=
tr);
> +        r =3D iTask->err_code;
> +    }
> +
> +    if (iTask->on_list) {
> +        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
> +        iTask->on_list =3D false;
> +    }
>      qemu_mutex_unlock(&iscsilun->mutex);
> -    g_free(iTask.err_str);
> +    g_free(iTask->err_str);
> +    g_free(iTask);
>      return r;
>  }
>
> @@ -1086,6 +1325,12 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverStat=
e *bs,
>
>      data.size =3D 0;
>      qemu_mutex_lock(&iscsilun->mutex);
> +    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
> +        qemu_mutex_unlock(&iscsilun->mutex);
> +        acb->status =3D -ENOTCONN;
> +        iscsi_schedule_bh(acb);
> +        return &acb->common;
> +    }
>      if (acb->task->xfer_dir =3D=3D SCSI_XFER_WRITE) {
>          if (acb->ioh->iovec_count =3D=3D 0) {
>              data.data =3D acb->ioh->dxferp;
> @@ -1176,6 +1421,7 @@ retry:
>          goto out_unlock;
>      }
>
> +    iscsi_set_events(iscsilun);
>      iscsi_co_wait_for_task(&iTask, iscsilun);
>
>      if (iTask.task !=3D NULL) {
> @@ -1282,6 +1528,7 @@ retry:
>          return -ENOMEM;
>      }
>
> +    iscsi_set_events(iscsilun);
>      iscsi_co_wait_for_task(&iTask, iscsilun);
>
>      if (iTask.status =3D=3D SCSI_STATUS_CHECK_CONDITION &&
> @@ -1415,14 +1662,24 @@ static void iscsi_nop_timed_event(void *opaque)
>      IscsiLun *iscsilun =3D opaque;
>
>      QEMU_LOCK_GUARD(&iscsilun->mutex);
> +    /* If we are not logged in, use the nop timer as an additional recon=
nect driver. */
> +    if (!iscsi_is_logged_in(iscsilun->iscsi)) {
> +        iscsilun->request_timed_out =3D true;
> +        iscsi_maybe_reconnect(iscsilun);
> +        goto rearm;
> +    }
>      if (iscsi_get_nops_in_flight(iscsilun->iscsi) >=3D MAX_NOP_FAILURES)=
 {
>          error_report("iSCSI: NOP timeout. Reconnecting...");
>          iscsilun->request_timed_out =3D true;
>      } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL)=
 !=3D 0) {
> -        error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messa=
ges.");
> -        return;
> +        /* Do NOT disable NOPs; treat as connection problem and try to r=
econnect. */
> +        error_report("iSCSI: failed to send NOP-Out. Triggering reconnec=
t.");
> +        iscsilun->request_timed_out =3D true;
> +        iscsi_maybe_reconnect(iscsilun);
> +        /* keep NOPs enabled; next tick will try again */
>      }
>
> +rearm:
>      timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME=
) + NOP_INTERVAL);
>      iscsi_set_events(iscsilun);
>  }
> @@ -1559,6 +1816,8 @@ static void iscsi_attach_aio_context(BlockDriverSta=
te *bs,
>      IscsiLun *iscsilun =3D bs->opaque;
>
>      iscsilun->aio_context =3D new_context;
> +    iscsilun->next_reconnect_ms =3D 0;
> +    iscsilun->last_logged_in =3D iscsi_is_logged_in(iscsilun->iscsi);
>      iscsi_set_events(iscsilun);
>
>      /* Set up a timer for sending out iSCSI NOPs */
> @@ -1894,6 +2153,9 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>          warn_report("iSCSI: ignoring timeout value for libiscsi <1.15.0"=
);
>      }
>  #endif
> +    /* FORCE-ON policy: 5s hard timeout */
> +    iscsilun->io_hard_timeout_ms =3D 5000; /* 5 seconds */
> +    iscsilun->fail_fast =3D true;
>
>      if (iscsi_full_connect_sync(iscsi, portal, lun) !=3D 0) {
>          error_setg(errp, "iSCSI: Failed to connect to LUN : %s",
> @@ -1905,6 +2167,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>      iscsilun->iscsi =3D iscsi;
>      iscsilun->aio_context =3D bdrv_get_aio_context(bs);
>      iscsilun->lun =3D lun;
> +    iscsilun->next_reconnect_ms =3D 0;
> +    iscsilun->last_logged_in =3D false; /* updated after connect */
>      iscsilun->has_write_same =3D true;
>
>      task =3D iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 0, 0,
> @@ -2007,6 +2271,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
>
>      qemu_mutex_init(&iscsilun->mutex);
>      iscsi_attach_aio_context(bs, iscsilun->aio_context);
> +    iscsilun->last_logged_in =3D iscsi_is_logged_in(iscsilun->iscsi);
> +    QTAILQ_INIT(&iscsilun->inflight);
>
>      /* Guess the internal cluster (page) size of the iscsi target by the=
 means
>       * of opt_unmap_gran. Transfer the unmap granularity only if it has =
a
> @@ -2387,6 +2653,7 @@ retry:
>          goto out_unlock;
>      }
>
> +    iscsi_set_events(dst_lun);
>      iscsi_co_wait_for_task(&iscsi_task, dst_lun);
>
>      if (iscsi_task.do_retry) {
> --
> 2.25.1
>

