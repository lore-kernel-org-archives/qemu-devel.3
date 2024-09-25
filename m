Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE19C369CA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 10:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPBy-0007T5-As; Wed, 25 Sep 2024 06:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1stPBu-0007ST-Ih
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 06:24:14 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1stPBs-0005Ma-IG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 06:24:14 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5dfaccba946so3616188eaf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727259850; x=1727864650;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BcYxG48VHJ8CFNLldQd9O9l/coWDklnL64Nf2pQz5M=;
 b=TVdGtqxla5eVo9Av5qLwKUUIpRgrOBsExPpggSPhO71BtNmPUHKElzPi5f4Tom9p3z
 H40LR47RsQL7VNfb/ESTaVsU8vUDLaDe6dj0tnZaYjUjOvysU0i5xv3UFUG+VBaRUFaR
 kkjTlkZW0jYRKdQrecKLJKKXMstgh/0TFI7OY61P7R9rmDe+nXgkvWfm56Z6xgqMowt0
 K7V6ZdEZ0ZnJjV0xbULNrnlcjNkiEpHpLKfAfIroFS/R6U2a53htNdLf/6sp3dxAxYY4
 KfM7h0NyJnVRe1ta+nq5B8LaO3ETSTLFnvO7Glpe9DrJxf7Qk/j28UGC7bHfoXlBVrIs
 3AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727259850; x=1727864650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BcYxG48VHJ8CFNLldQd9O9l/coWDklnL64Nf2pQz5M=;
 b=aI9lHcWpjCRQDXDi83QWT4iSMZgYa8X6/66QNL07SWZA6S3vtN4cPC4seHYJDGeoNn
 YHvZMx50RMSW0XvBNH/gTluE9GQIfnomzO/UbHvbNIlCsFl8XvQ/pjHa5r6WyTTrsEtg
 BVFMqDtZA1wZWEFl2Zb1gdxe4JnikUKxOFWexHAeB4JMbWiYoXr7W0Gs6g4cmcGIi171
 LAzHowEuseEKfQGzb/iXXZmMGzKKq7m3hHT6hLsDf7+cyVc0GrCXmqWKh86dpZr2Be+C
 euIYfDzRlt7SJ6dROfIVO115cvOTwXLPJEGKTaugiQkdGUkIRjxXv2hbbCXjOoo0gt6A
 UNAQ==
X-Gm-Message-State: AOJu0Yy77Su7+2EBy8RkNyPN5JI2HjMymMubp1Dqk4ATG9/YomcuiOUe
 4EklPg67Auk8xgdtG42J/5Mdq1xUkVQOLEhAcp9nzeX5miYUTMQH8rBPO2mE3GbaF9slYowACVd
 12MyDPr0ZS6Ef52Il6d+iuvG9W6nL8DNYv2eonA==
X-Google-Smtp-Source: AGHT+IGOCQD5cni/e4FPJCuf3PafZ3dNHOjHretvq9tKkpQ/bP4hpWmaZZOtrtyF+KWxarTzzgqbFnQ0ixWtdsrdPgM=
X-Received: by 2002:a05:6820:1ac1:b0:5e1:e65d:5148 with SMTP id
 006d021491bc7-5e5c6a4a98dmr1287473eaf.6.1727259850231; Wed, 25 Sep 2024
 03:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <6c94975d-2c8e-4698-a035-1e62549c2d4a@tls.msk.ru>
In-Reply-To: <6c94975d-2c8e-4698-a035-1e62549c2d4a@tls.msk.ru>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 25 Sep 2024 12:23:59 +0200
Message-ID: <CAGNS4Tbw_JSfzyir2TKBN59n6jkrerGoy6E9hEW8xcq0y3tO4w@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc32.google.com
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

On Wed, Sep 25, 2024 at 12:03=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> 19.08.2024 16:54, Mattias Nissler wrote:
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> >
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >   * net devices, e.g. when transmitting a packet that is split across
> >     several TX descriptors (observed with igb)
> >   * USB host controllers, when handling a packet with multiple data TRB=
s
> >     (observed with xhci)
> >
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardwar=
e
> > errors from the guest perspective.
> >
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> >
> > The total bounce buffer allocation size is limited individually for eac=
h
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
>
> So, the issue has now become CVE-2024-8612 (information leak), with this
> commit (v9.1.0-134-g637b0aa139) being the fix.

Interesting. IIUC, this is triggered by device implementations calling
dma_memory_unmap with an incorrect size parameter as provided by a
hostile guest. Shouldn't the device implementations be fixed to
validate the parameter as well? Maybe this has already happened? It
would seem the more targeted fix to me.

>
> Should we back-port it to previous stable releases of qemu?
> (it applies to 9.1 but not to 9.0, and I haven't tested it even in 9.1.
> If anything it needs some work for 9.0 and before)

FWIW, I've been running with earlier variants of this since at least
8.0.50, so a backport shouldn't be hard. Note that if we decide to
backport, we should also include "mac_dbdma: Remove leftover
`dma_memory_unmap` calls", which fixes a bug uncovered in mac_dbdma
uncovered by the concurrent bounce buffers change.

>
> Thanks,
>
> /mjt

