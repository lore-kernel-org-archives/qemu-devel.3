Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BC1C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUvD-0007tJ-Uh; Mon, 24 Aug 2026 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wyUvC-0007sx-Aa
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:41:06 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wyUvA-0004Nr-Lz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:41:06 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso6024429a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787578862; cv=none;
 d=google.com; s=arc-20260327;
 b=IbvHdamLWOyeTiSONyt9Y9Dq10i/s2aUTznNTD+MR89JEG1ROMalD+kMZ6Xm0wmVTt
 qqvXfIwsGpKBX6hKS7gLyDVMWUJlq5hsNAXRhGK9bDzLjtLTFlFfxbJ2hRomCsTzscZ+
 6dWvqOYCFG4Bptv/jyCz3W07ZEm7q6plL5q0of6D2uhpYd4wk38J82cGbcxjfucm7LAn
 Cqxi9XyDnnp1PH/ErA0S9PEnuxdM5rOKrHzgYsvDRepfmrjceM5x1+8s4B1r+K4GSz0W
 LnrsV7T8+4etlr0rn5iguRBGoO1DlW83ypEefMlsIvfspSOBXp7FTQTOO/k3aieEL8PG
 NLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oVyygP8CdjNTH1G556zvNN6wMF+UwzyoIyo28Wfk3kI=;
 fh=wd9+36LUuvCeE6rBaVrg146NYhYZbCeWkxV5JLkEazk=;
 b=MuaUZkAC2EhZX88dZz0/XtEIrah+18GzQAK0RrVfH1fHrLiWU7nbL2wYgvRJnGBnM5
 RtYHwBttakndPAGVR40hlmvTwTLCCmXgkjuwCN0F8viszJZSBz4suDkPk/oNpMiY290R
 3Lj2qjmTiuX5Idt3kSKKjqCBpLNweRXBdvrdHfeOaOzDEj3wl6l50Vsfp03ljVx+OAKg
 jWQXmh8oiww5DQ4s5gHd27ZN/ScC1+M7p1rHdIVaQEmdyv6Gmmagt3TFiM6ctcQPlTvC
 +aLnXMJR0jyLm5iC14yTaS+hmpjnmCFkYWAKJodp8hdwtXxXejs82oFt0rMNXmwl2yrr
 MPnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787578862; x=1788183662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oVyygP8CdjNTH1G556zvNN6wMF+UwzyoIyo28Wfk3kI=;
 b=gfIYQdEmWWRcZa2N+76YajEmQMWS8GchWJVF0svxd7r90Sik1uSt99se27M58D0XfD
 5mZluYcKMeZRtIDy/VtwwbMlT70YBiLNM6pnxm0zB8K5MIqWNGv4rqU7N7/Bw2d+kBeG
 VVKp8+cGT0u1isQtFwXnuwDV8HoPlchW9pKRNF4swAw8+A3Oj9ly+o6p8KoX8ngJ2Nti
 fE8dFlaeB7cTRG3BSgitpk2o3+M80hEYnL3vNe4T+O6jtD9S8tTqFaIJPimVpal+gs5V
 pQ5vRU/jn7aGeXO7Ign9B2inqPbwPQzEhkPU86fUqeDyAf8fJOnSNhhPK9Pbxv8OMmdq
 rpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578862; x=1788183662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oVyygP8CdjNTH1G556zvNN6wMF+UwzyoIyo28Wfk3kI=;
 b=YiBEgYLM1DCadxHFfJmm1uiKP1BM5sAQ/rCm8oUxdznDbAqQe5dhnmI9rrcs+uAU7N
 avLLnpoGq86OnMff103Q82BjJBmf7wA052e1RPFPGAa/u1Ww7g29zYfTshRPBo4NmlXv
 2PGTpkNZO8eG/U2A6pN6i5xyJ8FNvynmxKEb37el+uqF3OEgS1Xu+2fd6MNt6dXduo4a
 Px8b/UUbfqtoWrYFKchEbxPhwAMs1FzhWTQZgYi+nwUMknH32kw9DMGDh/EwmEQkJNGn
 B1jw3xkphcae5EcmgqW7CG7MEooEqljLk+oB60Riu876YZoZ32Waa89KZurigZp1jyms
 PVLw==
X-Gm-Message-State: AFuF++kBBVc/dHBybwgZqoHdIyRasEdIkA+cldQnPBIgblq8GgK9A6TN
 m1E6Y8t6nQz4QsOcMHRQFQv/ovGU/LuMAoib3b0vUFddqO17nwTSrxWxbqgpk7UpqDD8kf7hVhe
 yW5LuTZC9ERqJgJH0xw+UrQMdPZwjvpM=
X-Gm-Gg: AR+sD12iZ+HehKBaIgrZuFRqdT0VxGn1KeEcc5HmrfIB8rhdoiyk/KS0QWTMq+V/CUr
 zDDv1BVyuJkSJKyWS6nFpaoPLxRMzrewwky1uEeivTQh9nlQRd53nGXVlnO6fVzH9ICjGFKORab
 Q5kPZnPx6VRKJy2nBGT83gJbYFQYvl6W2GKQ31PZBys70JAKMfv02SwcVN0SqlZ7UDE7KoP5HHg
 jh4jZRPnXtoTp+TIdJ+nH5q2Gmm7e+JExoezAodGZLckgk6NpJY68JR0a3p+496gPg0tSueKOYv
 uhGRriHr6iaoqSqUAe4CjBPNKyysJHJJtyXh9xxsPPo3SorU/SRmmPEUImAiCFYGFLuisZZeYok
 qRQ==
X-Received: by 2002:a05:6402:43c5:b0:6a3:8652:a373 with SMTP id
 4fb4d7f45d1cf-6a42f184819mr31205459a12.3.1787578861870; Mon, 24 Aug 2026
 06:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260816043451.2547-1-narimansayed28@gmail.com>
In-Reply-To: <20260816043451.2547-1-narimansayed28@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 24 Aug 2026 09:40:49 -0400
X-Gm-Features: AcwNN1VhONrWW__JFRH9AXjMCxLL9pcNSCJ3CeZrgilTDY_Av6wO_MzRHIzLGa0
Message-ID: <CAJSP0QX1LMfmcPCPN1MY61JcJb05Uy0C3szKhmMFGN9CPoOSWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] net/tap,
 virtio-net: auto-detect MTU from host tap device
To: Nariman Sayed <narimansayed28@gmail.com>
Cc: qemu-devel@nongnu.org, jasowangio@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Sun, Aug 16, 2026 at 7:50=E2=80=AFAM Nariman Sayed <narimansayed28@gmail=
.com> wrote:
>
> This series adds automatic detection of the host tap device's MTU
> and exposes it to the guest via VIRTIO_NET_F_MTU, addressing
> gitlab.com/qemu-project/qemu/-/issues/3155.
>
> Currently, host_mtu=3D must be set manually on the virtio-net-pci
> device, duplicating the MTU already configured on the host's tap
> interface. This series adds a new mtu-from-tap boolean property
> (default off) that, when enabled, automatically reads the tap
> device's MTU via SIOCGIFMTU and uses it for the guest, avoiding
> the need to specify the value twice.
>
> The series is split into three patches:
>  - patch 1 adds a helper to query a tap fd's host MTU (Linux only,
>    with build-safe stubs for BSD/Solaris/stub backends)
>  - patch 2 exposes this via NetClientState for use by device models
>  - patch 3 adds the new virtio-net property and wires it up,
>    including a note on a config-space sizing timing issue
>    discovered during testing
>
> Tested manually with a tap device configured for MTU 9000 and an
> Alpine Linux guest, confirming the guest correctly negotiates
> VIRTIO_NET_F_MTU and reports the expected MTU.
>
> This patch series is part of my effort to get more familiar with
> QEMU's networking stack ahead of GSoC 2027.
>
> Nariman Sayed (3):
>   net/tap: add tap_fd_get_mtu() to query host tap MTU
>   net/tap: expose tap_get_mtu() via NetClientState
>   virtio-net: add mtu-from-tap property for automatic MTU detection
>
>  hw/net/virtio-net.c            | 12 ++++++++++++
>  include/hw/virtio/virtio-net.h |  1 +
>  include/net/tap.h              |  1 +
>  net/tap-bsd.c                  |  5 +++++
>  net/tap-linux.c                | 30 ++++++++++++++++++++++++++++++
>  net/tap-solaris.c              |  5 +++++
>  net/tap-stub.c                 |  5 +++++
>  net/tap.c                      |  7 +++++++
>  net/tap_int.h                  |  1 +
>  9 files changed, 67 insertions(+)

CCing Jason Wang, network subsystem maintainer, so he can review this
patch series.

Stefan

