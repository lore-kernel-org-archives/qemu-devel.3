Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D92FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABhJ-0002qr-Re; Tue, 07 Apr 2026 15:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wABhG-0002qH-4q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:02:47 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wABhC-0001hY-QF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:02:45 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-38c620f1699so58549021fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775588559; cv=none;
 d=google.com; s=arc-20240605;
 b=Sg1vy5/XQK8h/tfeSPeZ3dn+w9gK73yn0mthMym8S3Cb7RUqDDdWcYvkr3h2POycpj
 /MMGOqrzIrPqtgLHOhi6O7WZMeg4Hi7/6gYWp5hTaDfwGOezFd/yadXkeaQmhTGXgua6
 pGWI4fwFYMxUQk3bZj/O9TebuGQjYQ9BCqjJoStAshNPD928JzgEJKOY/Emf7E14lKzY
 hXMPyzYDUGtBAj8SxmEfqqHw7x2uSchWt0TE/e6oPj09e1RIQ6hyYh1XnRU9bAoDumPs
 Aesa+NPe5sqAD5/7AxNT2Jh0z82eekF4R/vr/ZuEF55j1NGIibsHeF3fCQJ4R+9PuriZ
 CZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UEjgdeSqdhQ8WWdLnPFrUrsbxDAL/fXYJmBMQmlQufo=;
 fh=j8cjR5BSdb9oxrjVMaCJViji+r96qovWS4bV9/nXBtU=;
 b=SiV0nwNRPxVDVbWEeLq89vw1FdobQ2Z4QDWVAxGWN6KBk1/vvtl+5S02skZvQ5MMAM
 hmCPyO2uL/7EC29Af5syTNvbzDSbXHCtf9U8Ctg0JQi7qR2dAqNVJq+u3DQeGvn8xbV5
 e2VIMh8cPg9Q4jaPX0p96rsxBvI3Scrubi7HJF3GuU6/FgvqYeyqiqrL9udLb/675fm4
 bmREMVVfj5KnE6iHPfoOexE1f+wMz1Oj8hEA/ZEzbsPPwnSuvvXNlP8gCIxev/sEaJzq
 Rs6/VV4LOtdoVGrzAKQEn2T6yOenMvrkjCR/0TbLvC0DGllHbpS4iEEyVZlbpGUZSZb6
 7alw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775588559; x=1776193359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEjgdeSqdhQ8WWdLnPFrUrsbxDAL/fXYJmBMQmlQufo=;
 b=OLdoYJCirbMuM5gVcr0fpBL0xyf8SdN3rTufqpqc9W94zj4IlxYFC5BxncHNtxMeFz
 7ZdcTQfYb6+LwMdlw0DgYe8GHSh99Q10b90AIrgi1nyI5BAb4KzSrhGSKAm3BNKGR4UC
 VcTOVxHk4F3H4ew7M71D/LJkcRT/RugrKFmMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775588559; x=1776193359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEjgdeSqdhQ8WWdLnPFrUrsbxDAL/fXYJmBMQmlQufo=;
 b=F4OvTcDPMvGey21P4ziJTW8UQjNnEfg9jLj9b7EFq5cCaoZWrabye98szxpZg24RIj
 6SZUgs5im7r1xsenmHQMUy3soPe/KRLcxpsH9P7xpHY7L9Q7t0YRnkCgOm/e8gySOhUx
 PwPY2k66FCLQuSLu0ycEqzPkh4oCbmjczfqtFOwq/dTSyDQ+BCqJd8zUAm/AzAl3Af2f
 7UjTgXAImx6eh4j3zACPObOTCASK6P5/vEL23L8q+JvqSWlbJnew6xLZ/XuNV38i5lyP
 cuhmpXRl2JZNxRf0xHhykZ3jHnnwSweU2pkMS7xAanvfBTRn0bk65paXzyqGgK0Vv6Wp
 wLTA==
X-Gm-Message-State: AOJu0YxpjUvxOx4a9jbtJWAUdO14AhNkOu5jLf4xYCiqYmsaSBmYL7qI
 RN/4bPbEHQFS/1dr0OohFdxau238g8TSh8BD8PQ98REkn8bN0FCdt+8jlGiH67MP/tsItuRAkbi
 VwOkrRBJBLlcGlyAEILcB2i3y+O4L/+XyVCf6P0V/LA==
X-Gm-Gg: AeBDievqyPS1iKJsBDV32KL215cfl/4r/J1tnXJbzwjS+vO2iUR8jxroJ8dA5RZ7pe1
 PIiJbFnQAkcSfDfypSvcRNPhq7Qa438s5q/UbDRzOIwwkcSoVhSqiQvJOGD1GAmuQuOfqtd8uo7
 CsJDmkAeklH3FCoxfcTbLpJFPnCb/hs3qlvLHjdew4EVnzAmexb34E6UuXIOn9fI4vChvdkhjHU
 rFzJOk6Dy/7meoyNMNmGM9I7fJE5dsE4KST+oT9NU+V+xqRN6UzGDlp/yMUuMT3iNH5GGjAg29z
 +xWCqeDEBMP9gwIW1hQ=
X-Received: by 2002:a19:520e:0:b0:5a3:7528:6da1 with SMTP id
 2adb3069b0e04-5a375286e2emr3630924e87.0.1775588558509; Tue, 07 Apr 2026
 12:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
In-Reply-To: <20260407154803.GB238768@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 7 Apr 2026 21:02:26 +0200
X-Gm-Features: AQROBzApQ5T0CDV4uZA8n21F-i-6L7x2vdt-roT_JZAkk2aPH2XU2_Kq83LbVF0
Message-ID: <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x22d.google.com
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

Am Di., 7. Apr. 2026 um 17:48 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wrote:
> > +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed */
> > +    for (i = 0; i < n->num_queues; i++) {
> > +        NvmeRequest *req;
> > +        NvmeSQueue *sq = n->sq[i];
> > +
> > +        if (!sq)
> > +            continue;
> > +
> > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
> > +
> > +wait_out_reqs:
> > +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> > +            if (req->cmd.opcode != NVME_ADM_CMD_ASYNC_EV_REQ) {
> > +                cpu_relax();
> > +                goto wait_out_reqs;
> > +            }
> > +        }
> > +
> > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->head, sq->tail);
> > +    }
>

Hi Stefan,

> Emulated storage controllers usually do not drain requests themselves.
> They rely on core migration code (e.g. migration_completion_precopy())
> to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. Why
> does NVMe busy wait for requests here?

I rely on core migration code to stop vCPUs and drain requests, *but*
a challenge here is that
a concept of "in-flight" request in NVMe is not that simple and we
have a few different types of in-flight requests:
- request was written in SQ (sq->head != sq->tail) -> this I don't
even consider as in-flight, because we just stop SQ processing
  and these requests don't require any special handling during migration
- request was taken from SQ by nvme_process_sq() and it now lives in
sq->out_req_list - this means that
  we have also initialized req->aiocb and submitted IO for processing
in QEMU block layer. After request is processed, completion callback
  will be called (for read/write requests it is
nvme_rw_complete_cb()), then nvme_enqueue_req_completion() will be
called and remove
  NvmeRequest from sq->out_req_list and put it into cq->req_list.
  I expect, that by the time when we enter nvme_ctrl_pre_save(),
bdrv_drain_all_begin/end() were called and
  all AIO is finished and sq->out_req_list is empty (except AERs).
*But* to be on a safe side I also added busy loop on
  sq->out_req_list.

So, I tend to agree that this busy wait is probably not required, but
I believe that we still need to verify that sq->out_req_list
is in fact empty. Because if we messed up, then it's better to crash
on assert() than to have silent data corruption.

Then after I have a loop cq->req_list, and this time it is absolutely
required because we need to write all NvmeRequest
results to CQ and free NvmeRequest structure, cause I didn't want to
deal with NvmeRequest serialization.

Kind regards,
Alex

