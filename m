Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F6010F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAZ4G-0006TD-2V; Wed, 08 Apr 2026 16:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAZ4C-0006RV-9v
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:00:00 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAZ48-0002i6-Ax
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:59:58 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-38e0ef48ac0so1201951fa.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775678394; cv=none;
 d=google.com; s=arc-20240605;
 b=V51+P3ggkvsRfXpC2tO5FV4AA3kQUWNMlUOhBhTe52ApNQqoraV7nrpCD7h3xGKGGg
 jlW4m7Zbw5m5j3SCx5AotmcR+Ncmsukcg/9Mydma67HLeyWvw5z5l/i8WZfnS7R0gwEJ
 BcScU4mlOKGktlfHK4gOxARZez/aC9pWmr23zP6J4xERLKMK8ikmvuDQVBNoEFrS/vjB
 wtozAy+hPEm3GU8sTHrRLCJyKvYDoXzwQVWtzH5QFNydZASJtFXIk4Jt0NNhMo+L6SAk
 /kENTN9vm/EZLgeQjKk60pETh+/+CE0oiJSDLSJb32S/1+t5HEt2nWo2K84/ObsMcUxq
 pGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=84cVfq5aTpm3Jzo2OEjXm3a8on3kSRW/F7pn55PUXDw=;
 fh=/7jWUNeDaJJ0vvRe+hRkGpmxwEV1m3a0wXbVBM2FU6E=;
 b=ROUeZlADQoWgPdjn3W3cCxq82rKKyg1qSLQZjJ1tcQr0oG8Si82W4lzABXHIDXUVzF
 iq+wJjBdI1IXeEmA3R8WPMvrmAVwTOTzZnfEN4E1K4huO+7UWkoPtjZ+6toZM9oCJMiv
 ZIycC6qB43zKwrEAECpwX87lvT3jLSQ/c5KE6Qnlm16ofKEwgTP/sUSniLTh/dK5QPwE
 46R0sDMN7B6ip2wkZaxucNHbpcxlr91Wtzo9glwELqgwjI6ojZuq3LTs0vF3mzecaadH
 ZNvguSWCCCoVwyrmGaDJw6COFfbyAc1FU3gL1cb42mLBQo+zx/fEhrnsbXGm5xHt8vAG
 agHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775678394; x=1776283194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=84cVfq5aTpm3Jzo2OEjXm3a8on3kSRW/F7pn55PUXDw=;
 b=C7yaqUEQBNaksGdq/Sde5pLOE1xTe2+O7WAhsSvS2GpJMbpqLreYQp0nrpWw9DBlhV
 Su6buec51YjCgD7p88xI4F9BoLxr9ZrFEfbbGICbxBy/wkmtFc6Pa61hnlDbIOVeH2CS
 NI32kzSPedfhGJXkveytxcUXxdWiTvhon06vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775678394; x=1776283194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84cVfq5aTpm3Jzo2OEjXm3a8on3kSRW/F7pn55PUXDw=;
 b=n64dk3U1wYGa0K1LAp4Qp3gG0cEYSOAHn3JlGorOPKqYlClM+zibaV7RYt1SW6YBS9
 io7VL8rn/Lub5W/rQEBK04goLMNiXVQL/Eqv+w6oU0adpUvH0SSMsbErwa3YICM+BFRw
 YIzFPp5c/hFzcIoEJjqRJk0EK2lHCLf23KaE1HtPqxxa0d5KKfkLml7yrUDeIKF5P01X
 lLGFhGtj9Pylf/5TGiupcdabkhgEHvTNM9kqPK/vsE1gl7mTUrvV0I4P/8RgeGo42heC
 wMlcINtjJYWJt6xwiEShtVDWCj8aiAbNfXGeTh8lEAz1frWnhXOuK49EE6hygaNM3I2A
 hYCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUir0W9l06Ba+Fna+qa4ihELLuT+dkxuezB+ThhV9h73pVnQxtFpU2Sv6d5w8J8ltrqP5Ja7a3zshRl@nongnu.org
X-Gm-Message-State: AOJu0YzjsLuBz2ilxnS66R9C2NuFwBqcAuFjZvz7v0ovpdkQspaaEhZU
 KDMP/OhsdqkM7MdVFdBD4Mo9Lm/l+G0yJ8T/lfDMZlkMH23ibipT56dm9xBabI8dzjfugoO3NpB
 mqavJeAq6jqNbs/zzSOuEuc8oCe6TX5y7mf7mzmWTWQ==
X-Gm-Gg: AeBDievpoL3Xv+DQwRf6zmQmFes5sirffhbeHeB4gfC5Z+8+cckgCgcSuxdFSwzf5qr
 US9nuwdFA6S83kiVMcEGrVxbhQKz4TgzdP9R/jbu8aPCfrS4b0Pt/glQ8oBNtCW7kexCnr7TkLQ
 tB0Qn8j1U/iLIu9mAVeog6wIR9iKbjBKSX+JThNx5s8MjoeeEtNsA2O/syiOdp1ZCJ0QcK0gyvM
 RnfZcjBNdYvQh1wdChV5OHjVu/2WVH5DdZ2yz4Gc+9Gt9eDXBpQwnPzjiWNrKdUyBjtyWAN7wIc
 LEYzC/THzVlC40fEI6lYA5zpsnTdY/W1xm1TUq4=
X-Received: by 2002:a05:6512:1386:b0:5a2:7d1a:4043 with SMTP id
 2adb3069b0e04-5a3e7a4fa7bmr257902e87.20.1775678394069; Wed, 08 Apr 2026
 12:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
 <adX4oSW5u1k0nLOk@AALNPWKJENSEN.aal.scsc.local>
 <CAJqdLrrBosYRyh8A75bJv9tvgQx5VWxgZuS_E1G=-28YpaBSyw@mail.gmail.com>
 <20260408183529.GB319710@fedora>
In-Reply-To: <20260408183529.GB319710@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Apr 2026 21:59:42 +0200
X-Gm-Features: AQROBzDYt-wAJ8B-FmklZx8UBFLlLloZuNWEunRapcfUgpJSuqU0fW3Qzuo39Jo
Message-ID: <CAJqdLrosTSv+YUo6BSOZ8pFUtoC7dVY8+uYEBaeEa4fgzhed7Q@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x22a.google.com
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

Am Mi., 8. Apr. 2026 um 20:35 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Wed, Apr 08, 2026 at 01:31:33PM +0200, Alexander Mikhalitsyn wrote:
> > Am Mi., 8. Apr. 2026 um 08:41 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
> > >
> > > On Apr  7 21:02, Alexander Mikhalitsyn wrote:
> > > > Am Di., 7. Apr. 2026 um 17:48 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
> > > > >
> > > > > On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wrote:
> > > > > > +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed */
> > > > > > +    for (i = 0; i < n->num_queues; i++) {
> > > > > > +        NvmeRequest *req;
> > > > > > +        NvmeSQueue *sq = n->sq[i];
> > > > > > +
> > > > > > +        if (!sq)
> > > > > > +            continue;
> > > > > > +
> > > > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
> > > > > > +
> > > > > > +wait_out_reqs:
> > > > > > +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> > > > > > +            if (req->cmd.opcode != NVME_ADM_CMD_ASYNC_EV_REQ) {
> > > > > > +                cpu_relax();
> > > > > > +                goto wait_out_reqs;
> > > > > > +            }
> > > > > > +        }
> > > > > > +
> > > > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->head, sq->tail);
> > > > > > +    }
> > > > >
> > > >
> > > > Hi Stefan,
> > > >
> > > > > Emulated storage controllers usually do not drain requests themselves.
> > > > > They rely on core migration code (e.g. migration_completion_precopy())
> > > > > to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. Why
> > > > > does NVMe busy wait for requests here?
> > > >
> > > > I rely on core migration code to stop vCPUs and drain requests, *but*
> > > > a challenge here is that
> > > > a concept of "in-flight" request in NVMe is not that simple and we
> > > > have a few different types of in-flight requests:
> > > > - request was written in SQ (sq->head != sq->tail) -> this I don't
> > > > even consider as in-flight, because we just stop SQ processing
> > > >   and these requests don't require any special handling during migration
> > > > - request was taken from SQ by nvme_process_sq() and it now lives in
> > > > sq->out_req_list - this means that
> > > >   we have also initialized req->aiocb and submitted IO for processing
> > > > in QEMU block layer. After request is processed, completion callback
> > > >   will be called (for read/write requests it is
> > > > nvme_rw_complete_cb()), then nvme_enqueue_req_completion() will be
> > > > called and remove
> > > >   NvmeRequest from sq->out_req_list and put it into cq->req_list.
> > > >   I expect, that by the time when we enter nvme_ctrl_pre_save(),
> > > > bdrv_drain_all_begin/end() were called and
> > > >   all AIO is finished and sq->out_req_list is empty (except AERs).
> > > > *But* to be on a safe side I also added busy loop on
> > > >   sq->out_req_list.
> > > >
> > >
> > > Correct. When nvme_rw_complete_cb (and friends) returns, we still have
> > > the completion laying around, not posted on the CQ. That is queued up
> > > for a BH to handle to coalesce CQE posting.
> > >
> > > > So, I tend to agree that this busy wait is probably not required, but
> > > > I believe that we still need to verify that sq->out_req_list
> > > > is in fact empty. Because if we messed up, then it's better to crash
> > > > on assert() than to have silent data corruption.
> > > >
> > > > Then after I have a loop cq->req_list, and this time it is absolutely
> > > > required because we need to write all NvmeRequest
> > > > results to CQ and free NvmeRequest structure, cause I didn't want to
> > > > deal with NvmeRequest serialization.
> > > >
> >
> > Hi Klaus,
> >
> > >
> > > There is a subtle catch here. There may not be room in the CQ to post
> > > all CQEs. For example, in the extreme, the host has allocated a CQ with
> > > room for 1 entry (size 2) and several deep SQs all associated with the
> > > same CQ. If the controller has nowhere to post CQEs, then we need to
> > > either abort migration (and try again) or migrate the CQEs.
> >
> > Exactly. This is why I have a next loop, where I ensure that
> > cq->req_list is empty
> > and also check nvme_cq_full(cq) to ensure that all CQEs can be posted.
>
> Hi Alexander,

Hi Stefan,

> nvme_cq_full(cq) will never become false because the migration thread
> holds the Big QEMU Lock while calling .pre_save(). The busy loop will
> hang forever. See my reply to an earlier email in this thread for
> details.

Yep. That was really stupid bug. Sorry again.

>
> A qtest test case would be useful here (see tests/qtest/nvme-test.c) to
> fill the CQ and live migrate. It might be tricky to deterministically
> run .pre_save() (via the `migrate` QMP command) before nvme_post_cqes()
> gets called, but then you'd have a test case that covers the CQ full
> code path.

Sure, no problem I can add qtest here. Thanks for pointing to the
particular file as I'm
just doing my first steps with QEMU development :-)

Kind regards,
Alex

>
> Stefan

