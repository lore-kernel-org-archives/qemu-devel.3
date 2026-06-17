Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F82CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj3B-0000y3-QU; Wed, 17 Jun 2026 01:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZj39-0000xg-Q9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:42:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZj38-00048T-Cx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:42:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b7866869so54184135e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 22:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781674970; cv=none;
 d=google.com; s=arc-20240605;
 b=UYbBrwhXd5FtUL7iLdIsJbkWEzeulIdVXd9Qli2wfH9PJtD4HM3/vevBJeQkxPW5XH
 pcywD3S4KgHhQCDll3csLrX7EJqN7UjvsMnVGcmwIiVm0uq23m2WpBjLS+b6wlZ5KWKC
 +pWRzUKuz5qDhl9KaUUOMyR4gOw/h1P1Htq6o47oVbxJ6hG/v4hJs9S6LbrQf/3KbicM
 Bb+2dj/uUlO3NIC68BuJL2mwuTfdUXHUQ6np0iU7qxQ6ZGgW9+TlL3Zs0xOXdJLfyXqh
 FOr6q+WSExSZJT06V1aQGTGOP/RdzNginSKl3xdgiiKIKXtvdxcIJPiSiBefF+k8q/es
 Mlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6F3uPOHVy++qZ0wLcXX2wjGVc8xGL/1YZ41PFaFbTp8=;
 fh=GgHUZAmYmLPw+9+mqfbhKDK+tAjulf6zBhny3cGQiJo=;
 b=lfuZI7gvQBUdj6mheBh7/E37KhyODsZpxd/AZU1IJin4VqCu9rs5FQFruW0W7GrVdb
 vQFHQ5F9I6Oj0IShHjokysEzeO79kYUUVzr+zwps/vtEC09j10G8nRoe4fZAV0Rblgfn
 3tMuXOBN9A4lU7btRU4Wl6JzzFmkiPXDLutTY4kJuQ4s3llHUM9V7yIExgA0CguUB7w1
 EfpN40I/6ykrG77FVACxCGX2DSKj41Td7G4RKjpDUUNwhdwLYpdp5vBWYwad4rFeLbdT
 aeVf+hS2sHq3KsIustAYdHE6NeOECdt+Oam5X0hcbLHuh3o+zc08xGcb2QrizOHdvH9G
 P+MQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781674970; x=1782279770; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6F3uPOHVy++qZ0wLcXX2wjGVc8xGL/1YZ41PFaFbTp8=;
 b=Znd9xy2jCPSgPJiClFD3R3F7UIatJA3urEgTa0Cf2MkR2PfGQ2SfmZjpINqdKCzOsr
 Md9HPvEVvc5dQHpi/29kV9K4e+NKEyTwChi0EDLIQKGyQGgOukQ+VQwwpQ/yApAyw2xb
 UFJjBlceePvgP/RaIag89Ft2m+9c1O009J4Eyr5g7dLthWMgRql1OFZed2dXKr+vwAEa
 nq2IIooEXN424N6uDpN7JTLIwNj2tYWFw+vVlBl0a+om5n/3+Vot2i50F1Am/umJSyP9
 AQRlJVpW+dwk5ZSMuEcmYtXAEyL2leYPiGdXx+kVvb1xhXmFi59HeULt/EVAtieUE8Dc
 5q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674970; x=1782279770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6F3uPOHVy++qZ0wLcXX2wjGVc8xGL/1YZ41PFaFbTp8=;
 b=dQSnpYMVaAwOFp5t5T3PcXvxDmzRTMJrwUL2ZUuq9kv506MSQy7FXA8J1IZDpXju90
 jTatx9JDbwIuPjPh3iASY0Fp3I+ESNXlVbkqLBg6SeDw/WoEdCaEKJbQQintqCGA1m7F
 jTP2HatypHCKLLgmUHL6YGSm+wQBuqKwkJcjyPj/AnXgLg3MIpuxJPZ8+eFDmq9deCth
 bKWygKJ2VMh1o4iKKeZkcRNqcfH5OSkL4VOd5ZGht04ndUNmQOVXwOd32ZX7IROkmTgh
 vi/95YNrvNMqK31D+vQjb1GQQnNzfbR+aXZNWZT7yDydzTAooHaRPn3HZzRB2rmuNHRm
 6xpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xWMVOOIzOYwC4x+11JFqfG46O894sP25cVlXkrRR5imSc58Z5NokUdzdI54RxK0yvErfHT8qPrh9D@nongnu.org
X-Gm-Message-State: AOJu0Yw0a+8aAqJOWmNmNVsyiLGJev8TgsyGSC/cmwodMfHWMruss9mv
 8dyOkFiR2qq8uQ+EM00rZoSrcYOVD0lTGGgUdavAc9xUchKQcXsgSrQ4hmFsmBVYzSAoc+dTpBQ
 rxCDlR64AfKcm9av6p+AVK2u1XMOe9VLWssis8lkN8Q==
X-Gm-Gg: Acq92OGDvpzIFz6ZWc0qI8XFP1xvAI1JaeT/LYnXbglSxehwHddLMG6q0iUjvszZJdr
 jOA0j4Qw0RM6H/nFdxL02Zchw/G0IN3YGt6L8Ifk9dJsgdS1Ut59bf5DDN4xRkqWaEAo8ba0Azb
 9MWpoEE5E6Vto65Uudhb9F+QiGPeHyBZUm/WuhlMRh+RW8YZlIoiFYYFshvpzXzqcctvDTZjPVW
 OoF8zx2059D4P3D7k4tY+3OWQYUL5KHTbqDpn/dD16dIRtVl5kVunlq0lvhlfPKAiKagkk0cPos
 Aza39DZPZ81XOkcV7j13GzM6VLEmPiopd8dGQMh/tuDhGQSHEP2ptwjBge6LvNRyzp4eET2SIdM
 9TiJMv1MmZnSz+5wtIgY=
X-Received: by 2002:a05:600c:1f86:b0:490:33b3:4be0 with SMTP id
 5b1f17b1804b1-49234127a4dmr23225975e9.20.1781674970362; Tue, 16 Jun 2026
 22:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
 <5c42a81c-e7a0-47e8-acc9-2be70c8a3380@oss.qualcomm.com>
 <CAEqNhNYSKj4oxYSf6Q9y7LkcvNKD7-5ELxOcVypfEPR81mdbHA@mail.gmail.com>
In-Reply-To: <CAEqNhNYSKj4oxYSf6Q9y7LkcvNKD7-5ELxOcVypfEPR81mdbHA@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 17 Jun 2026 08:42:24 +0300
X-Gm-Features: AVVi8CfFs0pc_0qF9PtjvOSIlaFxhMMb5o-dfYtgKvkegMcJd6fZ98MWQXh5gNI
Message-ID: <CAAjaMXZvVm9Z3q_UxAoWSWqsgBPverh6o276-wjuCcQDBBmDYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Hexagon system emulation - Part 2/3
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com, philmd@mailo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, Jun 17, 2026 at 7:40=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> On Thu, Jun 11, 2026 at 7:27=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> <philmd@oss.qualcomm.com> wrote:
> >
> > On 11/6/26 07:32, Brian Cain wrote:
> > > This is Part 2 of the hexagon system emulation (sysemu) patch series,
> > > building on the infrastructure from Part 1 to implement the runtime
> > > helpers and CPU operations needed for full-system emulation.
> >
> > For some reason this series is missing ordering, but is fully
> > reviewed AFAICT, so good to go?
>
> Yeah - sorry about that - I'll fix the ordering next time.
>
> Yes, fully reviewed: just wanted to share the entire series w/rework in c=
ontext.
>
> Only part 1 has unreviewed patches.
>

Hi Brian,

May I suggest using b4: it allows you to define series dependencies,
so you can keep the series parts that you don't want to change as
dependencies and respin only the other ones.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

