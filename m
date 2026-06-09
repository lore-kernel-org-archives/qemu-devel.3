Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B16CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtWH-00085r-6g; Tue, 09 Jun 2026 06:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWtWG-00085b-4N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:17:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wWtWE-0006iC-Jm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:17:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6924a68e3f3so482566a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 03:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781000233; cv=none;
 d=google.com; s=arc-20240605;
 b=Vkq5PXkjd/vPCzNS6hlgSQQMYfj6ehDyHvoxNi1npPDivfB2wG0DDc+eT9e4JQPdEN
 TzoFP1SZK/JGPlFHKsXk4ZPZwF7FdYitA3X/s/Sea0XAUwhYX3K3BziBEWDxxxUty2/d
 dk6thnF8nmiiPOvy6XmnJ0Fz8JwUEUCc+oAz6w74V8TefMuksqfCk+cHwpXmZrYvNXJ5
 ISb1z8+woItpt0iTkGsGFAyMYl/Mfdf6Hwry7CS9dGeIwpe1/BtD4A6bnfFWyVs7g/ja
 uNvE8NHinZsY0YJMJNIhKGd4IKgCLhKtOpBnGR0xXzuaviEm1wLT8EKxWyV2XOtmLuc3
 ru9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xehyUbJH+6vfLh121IWYfpkrzLzPHIxzfkuyAdwR42o=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=UPbej/GB2+ifJ6juq0pc6bPpEsYZX2+9GvdIOopbzx5zD3fh302R4h2387QxIjrFDY
 cUhyX8GlNpbQqcyi0hBxzK/jTpc1EMdBJqM0SFs7hlbLUtK8UouDNyR27ldKj9ILRsrE
 TQ58k19dPtPflisefoUrdFvsdr6plvdnM3smzRBafhOoAsaE29UdGfxPXupxeN5cMbMN
 UKlZe1Vsh0F5cW4Uo1mq/860JoPfhZEtMuGtG9sb0cYDkNwQbstO+o9kQY2pIGRPlzVM
 oi07JbgdZPWjmaLGHtg6c7C6ZRkyMlq3MxJjvf6MWv9cbteB7Mv1e7KzAAnqQNwdMT3J
 YBhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781000233; x=1781605033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xehyUbJH+6vfLh121IWYfpkrzLzPHIxzfkuyAdwR42o=;
 b=CaEviArHMB6R/MYQuBk9OsE0PeAKGMV5H6m3JsRgKOm63YuT4MBtLWE7i2+3OkEas9
 Ahy6trafC+wySrlxEk0a08XZ3xhuoehaeHGOKyyfJlD8A3skLvcysgTY9Iraramv0snD
 GgOltAJ5frwIAy+DK10iPNrWTfBI7iu8Ikt6EBm0BSXVv9pZTsD8XJw1hsi+isnr9wnD
 NfAjCOVzYrRH3yZlyL91Vk7WigdRhFYJVzx1B6vvjpzBRmKmJtfkmx4f6XLNGPhrcTVQ
 5g0/9FdGkIeqCJwnFTrVpKZWiiiQkObmBLk75V9xGsyyuPope9XlF0E/EowcxCM9FB/2
 hH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781000233; x=1781605033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xehyUbJH+6vfLh121IWYfpkrzLzPHIxzfkuyAdwR42o=;
 b=K/+f3CfoDZmGuea8HSygkhWcgIBm8x570K3j3wMTcrrQaFGjtnC/WyyMx0MkWVrarG
 2EVmAfNkujcb0a0NS6Z61nhJ/i12XE4K4KCvsuTlvAhajgB+Ys7uFpiZOzQTVIgd1pUH
 8DcGt/I1jYUevd3hhVCN8xhR0WmD2HlYBm8dk6aMtw+/hgnSb+53xpOFilmcA08dDg6G
 Oa7MR2gWBynEWa9s8Ox/h2N9B0rs1ZkfBf4iHHg4GWTmi4VEfZWj0AYhlBD64QhFW1E0
 Ybqn2LVQreecs6DYBeEB5j+4bWtsvIe6tPJWV8u+blaMWliIrliE0SyxjiEMzBJP63fT
 vQBw==
X-Gm-Message-State: AOJu0Yy3FjfNttYAjBlKKRQ4uNr2Hu4tVgmwUDcHjJ6m3Zg193PFZvDR
 fS3gDAv9bTs5Q0UfP4moB2qWyTWwErqZRw79Dy93159uPBUn5FnpdWkgZazyie480OzjbOQb145
 c9YnpXRX+LMPacs2q2VanzLAUfRHuX1k=
X-Gm-Gg: Acq92OH0i4PDFLqGo2PRVDhtDg5NIYEn3znLZOAfQQ1ma3s/aV5H8bZamRFzniS+5r2
 e0SKE2FQNqBnWHhYYkOXMJgjnE996mzIBjaOTMO1CA7NaIx/8Hr7/I+BDt3vmix5NptjL47VTU+
 JwGsbQegspWDnFJ8P4CQg6UdPufin++LjG7lY5FXiYpKC88mszPyWcouvIdAaQ2X2WT6fGx3rje
 LDr3Upi/uczuP5rjw2X78+Tm5DnUDS+vwZ0o7J1Kuuw7GJ7xY0coJaTNjlRPq3XLPgfDPI2O1QQ
 l7oqFSYdfbpHhWvO/us=
X-Received: by 2002:a05:6402:3554:b0:683:75ec:c17c with SMTP id
 4fb4d7f45d1cf-68fa4f29faamr9487086a12.10.1781000232816; Tue, 09 Jun 2026
 03:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-8-zhangckid@gmail.com>
 <87qzmorh9j.fsf@pond.sub.org>
 <CAK3tnv+okGDVvEL+rDrMrTbJfCDmnttCbQyXYeQ-b7bO99ZODw@mail.gmail.com>
 <87a4t5l6mr.fsf@pond.sub.org>
In-Reply-To: <87a4t5l6mr.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 9 Jun 2026 18:16:36 +0800
X-Gm-Features: AVVi8Ccii5XboV_lQ9G-BfKIU1UCQD5LVxNECJDPDwvspPSKmh3Zk-HYhTASujE
Message-ID: <CAK3tnv+3ZO2zit4dp5hCp_1HNjYsgik3W1EkiKY075EgRYDSLA@mail.gmail.com>
Subject: Re: [PATCH V8 07/15] monitor: Update tracking iothread users with
 holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Mon, Jun 8, 2026 at 6:42=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Wed, Jun 3, 2026 at 1:20=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Based on monitor ID tracking iothread users with holder.
> >> > Introduce the AioContext in the Monitor struct to avoid repeated cal=
ls to
> >> > iothread_get_aio_context()
> >>
> >> iothread_get_aio_context(iothread) returns iothread->ctx.  I doubt
> >> avoiding the call is worth the complexity yet another variable adds.
> >>
> >> >                            and ensure symmetrical ref/unref during
> >> > monitor lifecycle.
> >>
> >> What do you mean by that?
> >
> > As we discussed with Stefan before, the iothread_ref/unref need to
> > call in pairs, for example the virtio-blk. But the monitor implementati=
on
> > is special, it have the monitor_suspend/resume with iothread.
> > So I try to introduce the mon->ctx to simplify it.
>
> I appreciate your attempt to simplify things.  I'm having difficulties
> seeing what exactly becomes simpler.  This is likely me being dense.
> Can you explain it to me real slow, perhaps with examples?

In the original design, a module (QOM object/monitor/block node) call
the iothread_ref() means it will use the iothread to do some jobs.
And will call the iothread_unref() when a module does not touch the iothrea=
d.
For example the virtio-blk in this series [PATCH V8 09/15].

For the monitor, the monitor_suspend/resume just want to get the context,
It's not an action of never touching the iothread or ctx.
But would it be more appropriate to change it to
'iothread_unsafe_get_aio_context()'
for the monitor_suspend/resume?

Thanks
Chen


>
> [...]
>

