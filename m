Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E910F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYzv-00084S-2L; Wed, 08 Apr 2026 15:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAYzr-0007z6-9a
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:55:32 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAYzn-0001OS-5G
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:55:30 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59dcdf60427so109765e87.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775678122; cv=none;
 d=google.com; s=arc-20240605;
 b=kD91m1YVQYgzX8aywEhx32njrc7ctjUrNQZ6lUglZIiesgN2SzM9mo3kdrkINtIZkT
 rcBbKcaf58/gJoOe09ptLMvg3n6HVjoaXM3amJY0MMs/HUTqO7iCzXAvcpGgwIPKH3WL
 mkucuSnkXfddisHXvUyoDFlV66EHax1AUbfRKKXetOX3JIrRxXEj9bVcd8me4onql+nG
 B0cCLx/C3EpnrKhA5/I1f9fi3NPMGP0ybMKnZhGd3njQlekYbPd55NCs8lrenfIqKPZ0
 6Yysc+Sx/YKsHV5vdB5f5NmjgFpw54+3RjAtOl/Lo2tu/HzTv57KBXPwBPBAb83N2Hld
 mGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tEw8Xt+f/1S9jFqAT/fgFNQ7IBoFuTUL9/F0qN1cwsg=;
 fh=j8cjR5BSdb9oxrjVMaCJViji+r96qovWS4bV9/nXBtU=;
 b=F+WcmbJhs3FYWTvtLABiAhoVcL64upRakmTbvXAWXKn5HCouL45fq0ttKIkowllEdN
 tOheuetc9D0XXGKy7CNyea93bmUVqkZplc+WEYGUAJ7dYCH98q55Sr5xtAY5tw/b+qyR
 eXlmnUR7pOjq3g13xZpN+fHUsC15EDPz98p47EhOpO/kfoR3KUh02oXDdN8kk34vQa8v
 YnRtFxGzRYkiH/66n4ZA9VQ5FPP5p24+Rb78+KVrPsYgr9lGKoIpr+isN2wjgDh3Rd+8
 m5iMmIMbQLfQZDQIX55896yo81lnkHyOPzw45zIDXFbQl9iVw6Rxgi38nE6OsS2UW98w
 7ePw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775678122; x=1776282922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tEw8Xt+f/1S9jFqAT/fgFNQ7IBoFuTUL9/F0qN1cwsg=;
 b=TeSOfOYGn7sSWC68bfq1+bpDYGX1Eu9hxHyi8Kn513aCV/Fn44+X6qHYdPnH5Ab59Z
 Hz4ThTF5I2boUDh2P6Pb7bu0r2CA8V1+hrgDxAuj6GjQnnLX6m/mrOuyoNetdxzK6tMN
 fkSjepaSZvnLNF77g4cTulYR2bRAstbUxOsp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775678122; x=1776282922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEw8Xt+f/1S9jFqAT/fgFNQ7IBoFuTUL9/F0qN1cwsg=;
 b=j4SJAB8nw4gEFb+WmdnVSXuKeN9ihKZjhXkNbL5CX4mmf7QCTKi6rVZqUu02iZBUl4
 8MgTzTiR52WGvNwYbcRNUN63h7eWAjyfsZJcUYlCcR/qHy/4cSM6XfU0O4scOhyZp9rB
 xcQev7i9JRlIRrKuva1UJsKoxJjOsjVVwiu5j34rG+YJbALP9x9pNO6K+vPkBMB3cC3q
 RE3BjkCXxgLvrjHJfSS7sFTbGgBDhxKVsYAiN5ujuhcTIxBZ184Epcmwo1DhPDLjBWIj
 lt55kcZzmDFKD+qaNobbheN62Oo2nSON8a03ynMBya8UYkWomj2RwotMnUvXp84aYIVK
 IRyw==
X-Gm-Message-State: AOJu0Yy1m9zP7/320CaBSMBSC28WD1b70gvm0rz4z1HguHzl6emDL7Ha
 kKiIXiB9uAFRB4GdOwzfgQiW5CWai58NfaBIXHtVuPMOhTV0Mh8uf5USlAv04LbqRNXiCUv3iZn
 LCuCZZC4GnRhrvfxnmqQfXenzwdRmuVGq7QvC+3XJhA==
X-Gm-Gg: AeBDievm2KTOjk9XLUb1QSfhq0G2Oxo8fCm2rhGDc1nHU6Ro+unw894yH1jaA/lOmW4
 ZVbGX5mdqJKuy0570KV2biOCxjwoil/Lks7xUzGyvnQwzT48okqcGDx5z5xgKs0KGhrKMs/Ubgt
 Osz9ZBugUjes5rYPVkkr9R6as7nNT7KvH0g6Q+YuWtuaugOr3DOB7V34lbHm3Evx5+xaXwVcH/e
 ZVQbzwqnyJhj+YmeDbXYrbGvbYVqpxeJG0aL+rC6cjNbCMiOEr5fKlgo5njjqFegrDYINP4DqFj
 QVs23rc1fwvddNKHKo8c5CJm1uKjC0A7gIclFbw=
X-Received: by 2002:a05:6512:3047:b0:5a2:c289:3337 with SMTP id
 2adb3069b0e04-5a33758e47emr8669390e87.42.1775678122054; Wed, 08 Apr 2026
 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
 <20260408182708.GA319710@fedora>
In-Reply-To: <20260408182708.GA319710@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Apr 2026 21:55:10 +0200
X-Gm-Features: AQROBzBtePHYq62TlMRCnVGV1MwzrYsUHHpcM6kmOc6ijNpyeXTvcYRVGbXls3M
Message-ID: <CAJqdLro7E0mhdanbaE-xQUAzk1W7qYKN1QoEe8KH4VhsitiUmw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am Mi., 8. Apr. 2026 um 20:27 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Tue, Apr 07, 2026 at 09:02:26PM +0200, Alexander Mikhalitsyn wrote:
> > Am Di., 7. Apr. 2026 um 17:48 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
> > >
> > > On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wrote:
> > > > +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed */
> > > > +    for (i = 0; i < n->num_queues; i++) {
> > > > +        NvmeRequest *req;
> > > > +        NvmeSQueue *sq = n->sq[i];
> > > > +
> > > > +        if (!sq)
> > > > +            continue;
> > > > +
> > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
> > > > +
> > > > +wait_out_reqs:
> > > > +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> > > > +            if (req->cmd.opcode != NVME_ADM_CMD_ASYNC_EV_REQ) {
> > > > +                cpu_relax();
> > > > +                goto wait_out_reqs;
> > > > +            }
> > > > +        }
> > > > +
> > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->head, sq->tail);
> > > > +    }
> > >
> >
> > Hi Stefan,
> >
> > > Emulated storage controllers usually do not drain requests themselves.
> > > They rely on core migration code (e.g. migration_completion_precopy())
> > > to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. Why
> > > does NVMe busy wait for requests here?
> >
> > I rely on core migration code to stop vCPUs and drain requests, *but*
> > a challenge here is that
> > a concept of "in-flight" request in NVMe is not that simple and we
> > have a few different types of in-flight requests:
> > - request was written in SQ (sq->head != sq->tail) -> this I don't
> > even consider as in-flight, because we just stop SQ processing
> >   and these requests don't require any special handling during migration
> > - request was taken from SQ by nvme_process_sq() and it now lives in
> > sq->out_req_list - this means that
> >   we have also initialized req->aiocb and submitted IO for processing
> > in QEMU block layer. After request is processed, completion callback
> >   will be called (for read/write requests it is
> > nvme_rw_complete_cb()), then nvme_enqueue_req_completion() will be
> > called and remove
> >   NvmeRequest from sq->out_req_list and put it into cq->req_list.
> >   I expect, that by the time when we enter nvme_ctrl_pre_save(),
> > bdrv_drain_all_begin/end() were called and
> >   all AIO is finished and sq->out_req_list is empty (except AERs).
> > *But* to be on a safe side I also added busy loop on
> >   sq->out_req_list.
> >
> > So, I tend to agree that this busy wait is probably not required, but
> > I believe that we still need to verify that sq->out_req_list
> > is in fact empty. Because if we messed up, then it's better to crash
> > on assert() than to have silent data corruption.
> >
> > Then after I have a loop cq->req_list, and this time it is absolutely
> > required because we need to write all NvmeRequest
> > results to CQ and free NvmeRequest structure, cause I didn't want to
> > deal with NvmeRequest serialization.
>
> I don't see how the busy wait approach can work since
> migration_completion_precopy() holds the Big QEMU Lock
> (bql_lock()/bql_unlock()) while .pre_save() is called. The main loop
> thread's event loop will not be able to make progress while .pre_save()
> is busy waiting.

Yes, my bad. Good catch! You are absolutely right.

This is especially stupid mistake from my side, taking into account
that I *knew* about that we hold BQL
in this context, cause in my first version of this patchset I *was*
taking this into account:
https://lore.kernel.org/qemu-devel/20260217152517.271422-5-alexander@mihalicyn.com/

see comment before qemu_bh_cancel(n->admin_cq.bh).

Thanks, Stefan! ;)

>
> Based on what you and Klaus have said, how about:
> 1. assert(QTAILQ_EMPTY(&sq->out_req_list))
> 2. Call nvme_post_cqes() from .pre_save() to write CQEs back to RAM.
>    Whether or not cq->bh is cancelled too doesn't really matter.
> 3. Full CQs need to be handled. It will be necessary to serialize the
>    remainder of cq->req_list them. Failing live migration for this
>    reason is not acceptable from a user perspective.
>    (virtio-scsi and virtio-blk have a mechanism for serializing failed
>    I/O requests that need to be restarted after migration. There might
>    be a nicer way to do this with vmstate nowadays, but they are at
>    least two examples of how to serialize a storage controller's
>    internal request state.)

Ok, I understand. So your point is that we should find a way to
serialize information about
I/O request completions if they can't be posted to CQ. Let me take a
closer look into this matter.
I did something like this for AERs.

Kind regards,
Alex

>
> Stefan

