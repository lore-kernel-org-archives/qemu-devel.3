Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E6EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglhL-0005v5-Cc; Mon, 06 Jul 2026 11:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wglhH-0005uj-74
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:57:27 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wglhF-0007ne-8z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:57:26 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664db84f074so3675307d50.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783353444; cv=none;
 d=google.com; s=arc-20260327;
 b=LGOioWIQahvDGBV9lxtN3sjHgoLs1ZlEIWIvb5RcYHqQzxLh+ZdUKrGzdbDkFAsx4R
 kyHQfHdfrhiKOcjciXDFcd6rQqbEo0G1QReze/B1LkP3HZvIaLNbU02xxrEct5VzYz2X
 9p3S2fOQkgUMSn7IvBFAkr2v7zpXj62e/jJGps0soDR3EKPfpedp6yTtU86+Mc8QvRrM
 KMZ8zBUL+tVfZ8flPq+sugBy2+dlpG9+lAaPNCxgTxS0Mwe1C6jGAMVGTKqCbYUr5YjO
 uyna+fc1xkcS66R2DfPtZlgInHL2yH/FLkA7b7kmZ+um2IvUlh27wExl7Tx5YEzm6NZh
 L5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XHMK11sn2xcOUC3ORuS9gAKlJwygajoOmdtUiJ93OFc=;
 fh=MzamvxXwUTR7dHYyd0S+NxCuFahI9MSoRpNt5he91fw=;
 b=rjmgvkqkLJ5r6HP+tJkRz5vCdSGkw2exg2D9IWrTGjB9u52NPVbv1qUZHZ5VwuoRIU
 ahjt52/yGn9wCtmRziFLeECh1pI0SxxR6V6Vwlc8K6XZUcLJ4egaFK26b4G6+aj5iSVJ
 Y/WZR1kAQu72legz6oCwLpv6xhQWKE52dWu7EF5+5Ho7cGkbucmh943OnqDyyCRcuQv/
 jEJcxeQ+AYeH7bokR7ReDJ9whze05zLFmP9c/zrUriXKZpIqpAAh/z9h01tpaPWSMTGp
 IuKi4ZyJwBrKdbul5tsaU0JBlDqQsXhXwAVTK0Nfb4OtE32uznuCU1DXlZPzKZh+yzQM
 zsBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783353444; x=1783958244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHMK11sn2xcOUC3ORuS9gAKlJwygajoOmdtUiJ93OFc=;
 b=PxtQiNSP4ePggc9blhxxPWbjmEdAWiyj08EdalE5JScQ3B6mOzy5q8MjlguOzXDkZs
 s6dXTRoeUpkMQ/D8cTep7y35TsTqd1sgFbMFgcdDPrWE9zFfa/3xzE/vq5Y5FPclkpKC
 KiHNsDpUbE4q2PLgpp1vtWNMRpnft6bNVgqKVNXeWSSZuj4rnVzTCm4qybH+YDaPbJvz
 uwXLvK/WCauig9rVNNY3KrSFzt0A7pwLpclQk5uVb9CdFO6EBDItHjH5V6HLRwLQGHna
 oPDW5CoA8lrbxE7G/kXS2EixLspkc3kBEDx6aUQpzyEidAUUxjLzAHKPoZ7hD2DR+ZFP
 EzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783353444; x=1783958244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHMK11sn2xcOUC3ORuS9gAKlJwygajoOmdtUiJ93OFc=;
 b=VCBm2RXhuyN56uRYsBctyHhmgw2ybSla3GAvMtdF23PQ7kuB01A0462FutdyuTS+OF
 2wcRNBpMzZn+0fT5O6bQYdmYqNFaJZxuCG239z/ZEW8ptSEm2chYITBCZKTqThXHYp2e
 gG9gC6sgwQ6x8czfV1NL/oiM5hkr69JIo4Kopf510P5li3GsO3RcNog77FoJT4WTeNcf
 bMscNEL2hGHuQ6Lf266okB2Tz4tfpxv0LisSN+8qs5tAUjK86+o9qSsPoSseC5ejflpF
 Sig86dSJDn5uYSfHKs2q58CjxYLgioMl3+Uz7y8BrD2IILh30z6PJB0rd/hUofTVkewz
 qQVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqyySKHEEpUuNcreA9wmqgyTKp9k3zYM8GlxkGgXvjl40d1vOnMlCY9Xax6l5nnTI6nz+A+MeDXqSP@nongnu.org
X-Gm-Message-State: AOJu0YzHNT50a5jiUYY3H6yfgIIdOND04H1a+lSzmzwHjSFxRtsG6zoU
 J/c0oUV0fum6AAqHvGbMS2Y5CVsvKFiNNVk+mleE47FT7QbTzlQZ874zeMlsE3u9IwPD8x9wrfh
 OlBMd+0FQt2T2rHfkwMH/qNoAd9/y4aE=
X-Gm-Gg: AfdE7clFm+tls/mgp7sHV49ciQoEl4XMuu8SkFYWQID9Md63GwKxmQoOMVXo2SiS5qP
 S0kwTBTXl+07WeytpTgrSRVKd2zB1q2G47v0f/RKgTRTah86NPQS+pN/V9881SDlljwGJr73s02
 5dcoWaaMV1PFrIhZuzk7YOiFrWq9pk7VDweIaeohgb0w88jij9hfalEg28NONo4fNtbceM/nZsi
 ln8Y+KWG0thx+2yBTeQeaNkOjwV/CizkkYwrUQECkAQum+Ay+acuh1IRwT/HyRSevjXOlVABOjk
 EQ==
X-Received: by 2002:a05:690e:1a06:b0:664:e429:dd2b with SMTP id
 956f58d0204a3-6677fc83c05mr817257d50.63.1783353443993; Mon, 06 Jul 2026
 08:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <5be16244-7148-4691-8ee2-669a71b0a1a4@redhat.com>
 <mhng-FD339FD6-9FC0-4E9C-9303-6F4211BB5A7A@Palmers-MacBook-Pro.local>
In-Reply-To: <mhng-FD339FD6-9FC0-4E9C-9303-6F4211BB5A7A@Palmers-MacBook-Pro.local>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 6 Jul 2026 23:57:12 +0800
X-Gm-Features: AVVi8CddUBhw_3oONW6F37Yp80CXBcZd5hHzZdQhSBHmsMc9p4JIU49NNBDH-zU
Message-ID: <CAEUhbmVFZW3CFNxYKhoiVg9Xz_ZtOCJZR==Bf_4jjpbZX9hRfQ@mail.gmail.com>
Subject: Re: OpenSBI docker image RISC-V crosstool gcc URLs 404
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: thuth@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, 
 philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb135.google.com
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

On Fri, Jul 3, 2026 at 12:27=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Thu, 02 Jul 2026 05:12:47 PDT (-0700), thuth@redhat.com wrote:
> > On 02/07/2026 12.30, Stefan Hajnoczi wrote:
> >> Hi,
> >> The docker-opensbi job has started failing because the crosstool gcc
> >> URLs in .gitlab-ci.d/opensbi/Dockerfile are not working:
> >>
> >> #8 [3/4] RUN wget -O -
> >> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8=
.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
> >> | tar -C /opt -xJ
> >> #8 0.510 --2026-07-02 10:11:48--
> >> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8=
.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
> >> #8 0.511 Resolving mirrors.edge.kernel.org
> >> (mirrors.edge.kernel.org)... 142.0.200.124, 2605:f480:58:1:0:1994:3:14
> >> #8 0.579 Connecting to mirrors.edge.kernel.org
> >> (mirrors.edge.kernel.org)|142.0.200.124|:443... connected.
> >> #8 0.643 HTTP request sent, awaiting response... 404 Not Found
> >> #8 0.805 2026-07-02 10:11:49 ERROR 404: Not Found.
> >> #8 0.805
> >> #8 0.805 xz: (stdin): File format not recognized
> >> #8 0.805 tar: Child returned status 1
> >> #8 0.805 tar: Error is not recoverable: exiting now
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/15145227587
> >>
> >> Maybe it's time to upgrade to a newer gcc version that is still availa=
ble?
>
> There's been a kernel.org bug that dropped some files, so maybe they'll
> just come back?
>
> https://status.linuxfoundation.org/incidents/3y1k8b4ky71t
>
> > Remind me, why do we build the openbsi image in the *QEMU* CI at all? W=
e
> > don't do that for any other subprojects in the roms/ folder, do we?
>
> I remember messing with this at some point, but it's been a long time so
> I don't know why we'd be doing it this way vs another.  It's possible
> this is just because there's no standard RISC-V platform, so we have to
> build firmware images for each (which would make firmware distribution
> more complicated).
>

The CI job to build OpenSBI was suggested by Philippe, with the reason
to follow what we built EDK2 bios (commit 71920809ceabed) at that
time.

https://lore.kernel.org/qemu-devel/f92f1ec7-ac03-a012-f232-32c533beb9d2@red=
hat.com/

Given the EDK2 job has been dropped in commit 690ceb71, I believe we
should drop the OpenSBI job too. I can prepare a patch.

Regards,
Bin

