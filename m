Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB798C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6DP4-00036o-Tc; Mon, 14 Sep 2026 16:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x6DOv-00035T-OE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:35:43 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x6DOt-0004BE-Uu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:35:41 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9ab2a135dso3400724a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 13:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789418137; cv=none;
 d=google.com; s=arc-20260327;
 b=edgWE9v1ryapuJorkbZp1uFaEAB/uPoA/wtOgtOcaAsoDQc5kwbzIDTZWyjiqS8o+9
 ghazXUOIcTTgk8ZsQFwL+RZMPCdHnG0ozsmdrAIeVvU7FJEmzALPeHq9g9u0/NM5tZpG
 Q6cK/tNwF+WX2+Soe10TTqsCh9KjYdvu/8WC86lPEp8UF1CsNuqZ54JzruzZnHSzdjgt
 UMzefgDgmDGr1w8RESXGtDVk3h86YP8feXj2euLk6RYzEMxbdL7CD81KeFJQJ0hQalwb
 yEo+x7n6ZmhFRN9C7RQIPjHodeTf0z3M2UoxjnOsTvgORdn3+AOYgm3+38mymwMtogvr
 DOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q2HSfvexAPZNroEsVlSCngsAzFSZXBdg2mMRnCR0HME=;
 fh=9sic9NYhnKLM7mZVJYq9/DKYLPrHRQhpX+023FQ1vMA=;
 b=NCjjB0afzweTG6C8B0c1YdEd+tf3kwe5okrPON4vPaPhcDgcJv4E9Fjy4iYnWf0PjC
 Jbs0L4DQhVTf4na34TvLuyxye1dRmQ6AOzsog0Rr6SxK0/sfjauYq1fGwk3HIxHCPoOF
 p9XtJ0FNjNNJ4jQT9QT3q6VzthaXWAFXr1Q3gICwvsqn4fbqWPQv3XX7L2n7sR2dIoFL
 Ewi8cRF7DGKDyd17jfdtHXUEe6PwfvivVk2/nQlZJiT5EKBFkvqEHuZYO2QICUv5ehXD
 DDwnF3YBmIuONnd6UsPRUi6/2gQTRtwYriYF0kNa2gf04HR/usjgHKO5IwN9YyXtrISW
 ZygA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789418137; x=1790022937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q2HSfvexAPZNroEsVlSCngsAzFSZXBdg2mMRnCR0HME=;
 b=AU29n3dGksTYkJFOeETC5QRg/4Iy1gN0NDIO0m7w7uMkVRoyi9vaCNiS/XPTDGvFgf
 REQ9n81D4RNGMRzbfTudsNUqNGWiyYQDskZ7a4706PwopQkEIk+5BaDjPEONS+R55All
 54P+KhxE8LOlSkEDW9u1ZLgyvj0N4pqtiJ/Hr+4pDhuouhUUSJ1DqXtEHh9mE8LqPUcb
 q17BOcLSPbSl+NNXHatr3zhD2EUKZlP5awE8RH8W6vAMMOZbtHWDklyECkp+q8cWJGqt
 jAZSddU6HqcfaYKVseCEJIhQuqdIKFZZlX6T0TzUOdhYxBNZcGC1LmKxfw12syzfC2QT
 +LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789418137; x=1790022937;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2HSfvexAPZNroEsVlSCngsAzFSZXBdg2mMRnCR0HME=;
 b=HPV46KhLRUdTtnTU8L3LHcbQJltM9+geMxnbPnFVssnzltUsEreA8VfvZ6pim3eW6l
 +MQ8xVPw2hAEAZyefzwdrpFeOXiGTTrrGCcRPJSltMtYuwc8RaKajxRzMmcSThkaPIjO
 hxjkCDc1Sxj4DGmtaj2rzWNASqRRnLcX2fots7gBI4Iet3Y4WO5QBxFe6uV0odqXTpEI
 n5Wm8VINDHsMB24TCCBL8DA89seacJdUY3nsTK/DoM8LL2tSxccvv6OHLT9Zko7Im7UL
 GMs419DZ7cTVKIvesZQHJDZM5AEKvGl4xXg3T/tMsFzZu+pSNKrwInloxASTzyTXj7j/
 psTw==
X-Gm-Message-State: AFuF++kllrIFm2QHYKHCmFfNMTM7T5QkPyHNyLVdqB/7cNFRBFQ5PZox
 mb9GjbDG2HXj8rKAqachmeUCG9Gk3HQw+tkshiv6T4+Ykrokp2FrFlcIqX7MIQI1fzRKJnoVCVA
 1uKu6MIveN47dkD4yvJZyDc2XhbjGHPsLhDZK
X-Gm-Gg: AYBFou3rP/koz/dJtC9nW6DQNg6khz5+pthzSCUKWgCdk5JpUR6Vl1mJSlyDkPyCmA4
 Fma9sfKkmWYyIHglFLzxO5NXvXKKjK/Ak0cQ/lZh38MBpnvt9EDgi1PjMaHjnHqDDExu2UuH8m1
 2vawmt/dt84JXz5iJmeEqL+6cRf5rsZcfoakecYpjjpAPfo702yR8l7PBNrMpkIw3z/IumyfnE1
 9LAEFu4jp36uFGKVy6ymhnA/vJHvtoNL3IKbk4Uh7tgjGVBxmVDy6NY8DrpQQU0rxG9ADqt5p7c
 nvLMw0cHl30kgjivLRz3/WwxP/u9sYj6UZRXWe4WUVmdGLnzLHsG38nkX6zedEij0u5pVqs5wmG
 8MeB7tSiQ6S4d
X-Received: by 2002:a05:6402:324f:b0:6a9:a3a0:5988 with SMTP id
 4fb4d7f45d1cf-6a9f63f1ae6mr2029795a12.39.1789418136952; Mon, 14 Sep 2026
 13:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAPF+SGdq9yngvDxCM+YeeaF0HKSkN4TgE0KK09DpCdEqPczYOw@mail.gmail.com>
In-Reply-To: <CAPF+SGdq9yngvDxCM+YeeaF0HKSkN4TgE0KK09DpCdEqPczYOw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Sep 2026 16:35:24 -0400
X-Gm-Features: AcwNN1VUHluRFHH7xRazUOe5EsXgcHwcrLgWXvphpy_8_843Y01T5wQQfzTQwtA
Message-ID: <CAJSP0QUMjJ7J+_=jDO7Ek353-DnShz0deRDHi-WQ4SVMwp_rpw@mail.gmail.com>
Subject: Re: Deferring FD read/write to worker thread while vCPU remains halted
To: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=stefanha@gmail.com; helo=mail-ed2-x10.google.com
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

On Sun, Sep 13, 2026 at 2:37=E2=80=AFPM Irtaza Hyder
<irtaza.hyder@10xengineers.ai> wrote:
>
> In the [QEMU Internals Overall Architecture Blogpost](https://blog.vmspli=
ce.net/2011/03/qemu-internals-overall-architecture-and.html), the following=
 is stated:
> > Although many I/O operations can be performed in a non-blocking fashion=
, there are system calls which have no non-blocking equivalent. Furthermore=
, sometimes long-running computations simply hog the CPU and are difficult =
to break up into callbacks. In these cases dedicated worker threads can be =
used to carefully move these tasks out of core QEMU.
>
> The blog stated example implementations are no longer available in QEMU 1=
1 to gain insight on how worker threads are used.
>
> For my use case, I am trying to trigger external file descriptor writes a=
nd wait for the corresponding read based on vCPU instructions (i.e. registe=
r/MMIO rmw operations). In my current implementation register read/write op=
erations are redirected to the following function:
> ``` C
> MemTxResult fd_mmio_rmw(hwaddr addr, bool is_write, int bytes,
>                         uint64_t wdata, uint64_t *rdata,
>                         CharFrontend *fe)
> {
>     int chardev_status;
>
>     if (!qemu_chr_fe_backend_open(fe)) {
>         /* Charbackend is not open */
>         return MEMTX_ERROR;
>     }
>
>     chardev_status =3D qemu_chr_fe_write_all(fe, (uint8_t *)wdata, bytes)=
;
>     if (chardev_status =3D=3D -1) {
>         /* Unable to write to socket */
>         return MEMTX_ERROR;
>     }
>
>     chardev_status =3D qemu_chr_fe_read_all(fe, (uint8_t*)rdata, bytes);
>     if (chardev_status < 0) {
>         return MEMTX_ERROR;
>     }
>     return MEMTX_OK;
> }
> ```
> But this function blocks the main event loop due to the blocking chardev =
frontend APIs. How can:

Hi Irtaza,
Doing blocking I/O in a MemoryRegionOps .read() or .write() function
is fundamentally a problem. I say blocking because your code example
suggests that the rmw function not only needs to initiate I/O but also
needs to wait for it to complete. That can take an unbounded amount of
time. The vCPU is blocked during this time, which is a performance
problem and can cause problems inside the guest if this takes a long
time (e.g. Linux can complain about hung tasks and Windows can
bluescreen).

The first thing to do is check whether it's possible to avoid this
altogether. Can you write the device emulation code in a way that does
not block the vCPU? The answer depends on the MMIO interface your are
implementing.

In some cases it's unavoidable (e.g. out-of-process device emulation).

> 1. The function be deferred to a worker thread as mentioned in the blog, =
while keeping the vCPU triggering this request halted but the main event lo=
op running?

The issue here is the Big QEMU Lock (BQL) that protects most state in
QEMU. The vCPU thread running the rmw function holds the BQL and other
threads (including the main loop thread) cannot run during this time.

There is an API to avoid taking the BQL during a MemoryRegionOps
callback: memory_region_enable_lockless_io(). If you are careful when
writing your rmw function, you could write blocking code and use this
to prevent the other vCPU threads and the main loop thread from
blocking.

hw/ppc/spapr_rng.c:h_random() uses a similar approach but without
memory_region_enable_lockless_io():
1. Initiate I/O
2. bql_unlock()
3. Wait for I/O completion
4. bql_lock()

> 2. The worker threads be synchronized with the main loop (i.e. how would =
it inform the main loop to give control to vCPU executing instructions ONLY=
 after the FD read is completed)?

This is probably not necessary if you use the BQL techniques mentioned abov=
e.

Stefan

