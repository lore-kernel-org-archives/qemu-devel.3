Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFDF10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYYG-0002TL-W8; Wed, 08 Apr 2026 15:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAY7j-0007re-F2
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:59:36 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAR8N-0000VP-ML
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 07:31:49 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a2c77c62d7so5388901e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775647905; cv=none;
 d=google.com; s=arc-20240605;
 b=h8rDDgsWutjzk8fXeiDn6Zt0Wlkf1GP2Tz8CxCm2XNEVBjDWPAaGMgc23R/5vA96/o
 7DxRBI720ytaVR/3I8yRvKglsjA1fSP5W5eTGkZv1BLRo6TcpNlL++SV6ayG6fmBVdC1
 czuQvbNS7E0yZHQm9Y+Ij84AZ7j0b47KfoktmaTqe0087KeAK3I95MpObWLuEkNalpPJ
 IROC6WVJFYwVSlUm66b/1vuE8HpJrqYBEytX1dSCDbbA+M7v38JTjSNixR1G+rAwuj3v
 bUZ0FMFU8Nc37iTSozOoveUXW3Uxnr+kH8BHLWmDCXGG+PmlUpQRe3kQTxWldUYVzTVH
 Paww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J7tV/Zb8KcWe900IUjNmYTQaaafj8od9ElYKyEUoD9M=;
 fh=PoJnjkVY0BiJ084C/0ISqcXdoZyr4t3VTMYGRE1s/Ug=;
 b=MCAGlPmdrIKxT7z5jn/buzWs69FyqgCWkj216SkyTPRFh3ofUpaRqRYO3OnoeHSaed
 3l9AAWiqF6Te8t8CGy8O6kCxkAQ+O9azBuQKYyAaCS3Y3ZPfgmWDEoi496H3kdvnvyZP
 jU0a6IFKDhqQvl8J25l59yRtwiSxhQCWcegsymNcGbitnIf58fQv2W/Z5f46y4vC3JOD
 +OkEZny5M38Ql2iUB6eaCwsSY1Wd4ouAEBSJQrfPJ2n+lr25RyaO5Cx6K/4YRI11nffK
 xizDCnsfs0i5T3himKxztTTCh3NA3/8w1KLqyowJsxreQza+sfQrzQfnEZF6SA9vbgpI
 Ebrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775647905; x=1776252705; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J7tV/Zb8KcWe900IUjNmYTQaaafj8od9ElYKyEUoD9M=;
 b=iEgJ8eXmhcBau2mzMU/9/M89TTlon8u7xuy8FcAHgUs8Fg5PJxnibVI1a1e3ZqKZfK
 aHjZUxA3Xs031N5Xx9B1Q+Ei/xnP2xOzuh+4JXr3Zq8ILwRIMasxPj9ozrZrNQFnPSQb
 TWK2P7SJgVacJgrU1qVTQfHDM8MTFtNSAZj9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775647905; x=1776252705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7tV/Zb8KcWe900IUjNmYTQaaafj8od9ElYKyEUoD9M=;
 b=kxQwEU/ZpUAatA/p/wO+dm6t+lYItO4bKfvj0p1l2i9P9A04aER85f2JI8F6IE1ZcT
 d7z9Yd8CnMF6f3pd+BeuAbYCa4SM/GbGDKHZqXmd0Zb3rapjK+W6PTSiAYj6RXZRQvwA
 l6BJ2eKqt16pCHeWS4wxtIbnHADTTzLc2tyv6IXrMACZwbLs6bDg5AH9DCMGBzKbK/ZR
 60b5W2JqpUvt+bTcYLShm890soYHsMimQkeAWqm/PRgl2GJCOm+QKk4TvT+CsiU6Nktr
 n7GpVGfzYwNkKNW3cAyoOhfIoOhQl5WoDdcMEj2xLhtvkdsfURcpkJTSuyhCTJ/dBX03
 3Cog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhbKMY2MD1BTXr8oYO0iMevaAumdolSUjNtc+NLB2f1M57UFy9EXFA5yXxDArd2BfCbjq3IBKNyruq@nongnu.org
X-Gm-Message-State: AOJu0Yz9GSZuQ6y6MYNi76KGb7fEQBhpwKBDFTs7nR4SGNJEE3roDg4S
 I4zHCsXOoNkNOUfOTSRnYME8XO+gZh+7xhRVfUaR1x2zZkw0b+4YDHxg+JfNyj7VU8Dl9N4Ivrw
 vNFnOb1tmvfhWB0YILlQQnp+BlmUhy6I4QhrJg0iYYA==
X-Gm-Gg: AeBDieu3NFHS8wvsEC5hKLcnpQl6AUYn5ET4lHaBhl0YDA7sOxbUZ9sjxMyvm91LWO3
 9Eb3pmQxO0XRi9UtaY4Ol2Ydv4VwB5ovc5ot21etf3k0r5CnOVqq6JytcoQ5UmPNvaSiQZlQzq3
 mcLS3ff9GWlj6hszYa3swfPwB+zS05Z7hiXUHn2EWNhweqbCe61YhIrCIvrndUMRHvUIF7ECE1Q
 xZ3BYy3XW1kabdSWgfxlFmyyCYgbpPUBDNZggf82V0sKtQ3Iqj4axHo1hWCPayu9Lp4H5peozKj
 bWqEQvKfVLLVo+2OH33M/bC/q/kZLhJ0oROOIg==
X-Received: by 2002:a05:6512:1589:b0:5a3:d175:7f8a with SMTP id
 2adb3069b0e04-5a3d1758100mr5159085e87.19.1775647905227; Wed, 08 Apr 2026
 04:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
 <adX4oSW5u1k0nLOk@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <adX4oSW5u1k0nLOk@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Apr 2026 13:31:33 +0200
X-Gm-Features: AQROBzASmj5oWVrs0sWfNtT2YH10CBcd7IUwGRxGchiHKMGs8tek9awXvQDCmCE
Message-ID: <CAJqdLrrBosYRyh8A75bJv9tvgQx5VWxgZuS_E1G=-28YpaBSyw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
To: Klaus Jensen <its@irrelevant.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x131.google.com
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

Am Mi., 8. Apr. 2026 um 08:41 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Apr  7 21:02, Alexander Mikhalitsyn wrote:
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
>
> Correct. When nvme_rw_complete_cb (and friends) returns, we still have
> the completion laying around, not posted on the CQ. That is queued up
> for a BH to handle to coalesce CQE posting.
>
> > So, I tend to agree that this busy wait is probably not required, but
> > I believe that we still need to verify that sq->out_req_list
> > is in fact empty. Because if we messed up, then it's better to crash
> > on assert() than to have silent data corruption.
> >
> > Then after I have a loop cq->req_list, and this time it is absolutely
> > required because we need to write all NvmeRequest
> > results to CQ and free NvmeRequest structure, cause I didn't want to
> > deal with NvmeRequest serialization.
> >

Hi Klaus,

>
> There is a subtle catch here. There may not be room in the CQ to post
> all CQEs. For example, in the extreme, the host has allocated a CQ with
> room for 1 entry (size 2) and several deep SQs all associated with the
> same CQ. If the controller has nowhere to post CQEs, then we need to
> either abort migration (and try again) or migrate the CQEs.

Exactly. This is why I have a next loop, where I ensure that
cq->req_list is empty
and also check nvme_cq_full(cq) to ensure that all CQEs can be posted.

Kind regards,
Alex

