Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6966BC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNTw-00020H-SD; Thu, 16 Jul 2026 10:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNTu-0001o2-Po
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:54:34 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNTt-0001rX-6L
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:54:34 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80e24970f1dso27245497b3.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784213672; cv=none;
 d=google.com; s=arc-20260327;
 b=fnJjhUY1jbWoopgbft1S82YJSmltNwBv2ZjLoaPFlElN3InmZ4rjrCpKcQMwh3vi4O
 L83rMUxFpjDG1CdUa94vuOpe1TqdnzxLg8VBdDk3uONPGbl/3Ys+GmwSpEgTy+2J4V5C
 BwSOr0QPf2Clx3r0pK7mLG9ybP/saCfK78e7+RggEuUpgBB0IvpVcSbcAKagnFG4S+MI
 spMfCk1H4LI7oLFggzaMZ539AmC2BdK3dXWfAZzFqXh2LWCy1sgYAOiM6UVqPfVLP5ua
 XR8xiWje+bW9PxbHma4U5JyOMrjTPsZMZktG1yG1gnUNMPuBQLnXWPqGx/UdKHocsFXa
 44Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JToxajq5ZH1vSLCWTN9NJBxR/6nVWGhA53YwXQOTcu8=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=MUNZ41TmNBQKGB9onx2ksvsBL06LdmSv9rzpz6X45Bj2ZBFE5oYmq2hRITvzAvr6KF
 6Xr2uioAU/yUSNaDfs61/W8b4CMkwfvi7iYC2M3qyXEzy3hTIHg0mqEv59VMeDhwpSNj
 DMD/EmNovDq1vl9fs6btq0nLOyLgDOwArcWMB36ihc4QH3qOqqrJkAqqpuU6U3OiqQZ4
 +vk5t30QCYC71kiiLfP8knOBXXW5Eqdm1otBC0wrSuvULq9Cnbsxgvqx3H4/QX/SipxJ
 OLBhdl2hMk0bl2N40YgqpT1uIc9zdgoCJY6fW4/n5f2Z+Rbwv2orqrSKBVELG4lJCkJY
 HQVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784213672; x=1784818472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JToxajq5ZH1vSLCWTN9NJBxR/6nVWGhA53YwXQOTcu8=;
 b=tLJxIlQwoH8E4UpGQNgn8NKGmiboigWcfH7y8ESq86IiyJM8wIwlBqJtE7vC5fsmB0
 9CR/Guv4+A4DUaa1ncK7ZcOD4T89sfLA5QI0LNq0qCv8gDq8fKG3G8GLZ5YxBor6mwI/
 7H0L6ELxtdqmxIo/yFSx6Xu3gkVnvJ2fB6802acVQUPslWYwRCmIjVlEGeZaBcn16i3c
 Be+fUMCXuBGGFM7+Pz1isoxj0Tq5J8fTlr4ikuHLooAdd7MBQCa68dNr6WH7ZGZSOvDG
 Rv/pKXvUeVvn5QvB6RmBuTyNg5sw1cTWtIU8nCaGF9+Jts1fXO22u6aZr4SeEcCWAVs2
 GHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784213672; x=1784818472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JToxajq5ZH1vSLCWTN9NJBxR/6nVWGhA53YwXQOTcu8=;
 b=Rr9hl1yTVcEx50sZd9DBhGm2l32TUxZXsfUuM1UOq7D2ZyRKCh/aVf4r+g7ocPy0eo
 PBjCNnGNXT7iklMLYGZ2SL51dL7scyHwfJQTHcIxBlljG2TvJ74c1fVOvBRNKW76pSuY
 tEXNlWABf6FRwgyWBnyXugJJ1/eU83msG4lgamElVBAN8zd4GJmpGhgKMNXGy/aAPHgf
 kHcwbeqUoG9k1MM/TAO8iwoLCPMWGRR0YXGIV6skRYtu1B3DZ3/rwW9pqdQt8mtS0eOH
 772U9xO/PoMbJQSHydI/qz9xDPxY/qLm2zn3FD5Ze9vXYvS9pqk1f+eX0dgstOusL+SE
 SstQ==
X-Gm-Message-State: AOJu0YwSUHV9t2dNiBmDw2OgNe/aE5g0iwHAJy4bohdefEj+47dKx+GO
 wBLr6Pvb11oJr2NKyI+wB5YZ4LWICvtb613ZoTBGBxqdNICfnf1I+msZs/+C4NA6tBFMzBuzV30
 424r1x4m6ne/FLyV3oYlH8f4oWnL5qgY=
X-Gm-Gg: AfdE7ckVGo0dojH/7U/hMk/o6iQp2xZTqsV/zUGNPv8dPxh535FsaBqb2dZ+620ISkX
 2cf0w9qABy+1ht02gKCC66//u9MjzfrlMpNLIk7uh4Cs3p+pGU3bcFs90Yac6gGSMLh07IXsfb7
 wTWbufRQ4V2elokBv9q4t/EJsGiN5S4srcxKQaQRPMUWnJw8J54lIhgRBw1E4ayjqWSAFHvTYZx
 SU2mCV5GmIGU5fMuhyE+Q+sX1fS1Czt66qS/gFy+I8wVPjbordNG/bak9srLOgT0TjAnw0m
X-Received: by 2002:a05:690c:2605:b0:81c:fc30:a35c with SMTP id
 00721157ae682-81e901104ecmr177259927b3.42.1784213671794; Thu, 16 Jul 2026
 07:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-9-zhangckid@gmail.com>
 <20260701161642.GB413397@fedora>
 <CAK3tnv+qwj9=rgg3-pF-GYDQm9LbxCOrcr9EkO1dNtk0kBw8oA@mail.gmail.com>
 <20260716092207.GA741667@fedora>
In-Reply-To: <20260716092207.GA741667@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 16 Jul 2026 22:53:53 +0800
X-Gm-Features: AUfX_mxuYoIkOO9LixMuJlQzW0YLyB1gA82JbJCCH00ChM4otVn1j-q_Bxg_qyc
Message-ID: <CAK3tnvLFOwgdevMRk8wzO5wBFD30gzgb4W3SXJivy+4TPe0HpQ@mail.gmail.com>
Subject: Re: [PATCH V9 08/17] monitor: switch to
 iothread_unsafe_get_aio_context()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=zhangckid@gmail.com; helo=mail-yw1-x112a.google.com
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

On Thu, Jul 16, 2026 at 8:46=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Jul 06, 2026 at 04:59:30PM +0800, Zhang Chen wrote:
> > On Thu, Jul 2, 2026 at 2:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 03:08:42PM +0800, Zhang Chen wrote:
> > > > Since previous patches introduced explicit monitor tracking and ref=
erence
> > > > counting via IOThreadHolder during initialization, standard global =
calls
> > > > to iothread_get_aio_context() are no longer appropriate for raw con=
text
> > > > fetches.
> > > >
> > > > Switch the remaining fallback sites in monitor_suspend(), monitor_r=
esume(),
> > > > and monitor_init_qmp() to use iothread_unsafe_get_aio_context(). Th=
is aligns
> > > > with the new safe ref/unref lifecycles introduced for monitor track=
ing.
> > >
> > > Why is the unsafe API used here? monitor_data_init() now takes a
> > > reference and gets the AioContext. Can you use that AioContext here
> > > instead of fetching it with iothread_unsafe_get_aio_context()?
> >
> > Because we have some comments from this series V8 patches:
> > https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg00375.html
> >
> > If OK, I will back to the V8 code and follow the [PATCH V9 06/17] comme=
nts,
> > https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07323.html
> > based on Daniel's series for monitor parts in V10.
>
> Markus had no objection to using safe ref/unref APIs. I think he didn't
> like the additional AioContext pointer that the caller needed to manage.
>
> Using the safe APIs is important because the risk of bugs is high with
> an unsafe API. If the new safe API is too inconvenient to use, then
> let's find a different API design.
>
> Here is a variation of the API that requires the caller to hold just 1
> thing - the ref:
>
> IOThreadRef *iothread_ref_get(IOThread *iothread, const IOThreadHolder *h=
older);
> void iothread_ref_put(IOThreadRef *ref);
> AioContext *iothread_ref_get_aio_context(IOThreadRef *ref);
>
> The caller can call iothread_ref_get_aio_aio_context() multiple times,
> so they no longer need to store the AioContext pointer.
>
> Since iothread_ref_put() takes IOThreadRef, the caller doesn't need to
> build a new IOThreadHolder when releasing the reference.
>
> What do you think?
>

The monitor parts based on Daniel P. Berrang=C3=A9's series:
    [PATCH v7 00/35] monitor: turn QMP and HMP into QOM objects
    https://lore.kernel.org/qemu-devel/20260706135824.2623960-1-berrange@re=
dhat.com/

This part has undergone significant changes; please refer to V10 for
the latest implementation.
https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg04823.html

Thanks
Chen


> Stefan

