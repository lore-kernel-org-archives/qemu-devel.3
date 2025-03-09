Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED8AC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 22:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPBu-00079d-SM; Sun, 09 Mar 2025 18:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPBn-0006x5-UB; Sun, 09 Mar 2025 18:32:07 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPBl-00072d-3Z; Sun, 09 Mar 2025 18:32:07 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86d6ac4d5a9so262241.1; 
 Sun, 09 Mar 2025 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741559522; x=1742164322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDes8Fe0NbgLcGeeAJL0eKKPjL87NZq5FcvIzWHjqoE=;
 b=fJ7c8bNgtIl4KHurj8cEmRDtke36kB7qls71QUKM7D9iMPcUS/7n9VDGWkoj8jdc/K
 sm3IjmUk4L3gT4JdcVy2B+JXru+Qkwzx78cOZ4v96Fid0uR4T2QdnONxbLdxVDXS5o4W
 2V5FCdaD5CyWxeLsYbQX8vgUdWgLoHSnBjAK4xdDPVeRW7frARr8DnPyOKpO+RtpBk7G
 aZ47qWY23B0q9tHQ5P2qVOEC6Xte9I5F3Q/UJSDFC4S8uCRVehLv9Up5y0kUKi71WJit
 B/RC4JKpA7LnM69lVJVGg6Hw6oPVvupiuzApMHPDNOPS1pHlKGeXNrwmZPhWROC145Wx
 DPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741559522; x=1742164322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDes8Fe0NbgLcGeeAJL0eKKPjL87NZq5FcvIzWHjqoE=;
 b=VQdh9vGMglugtgd/OajyvrjAWCjkt5CxJ5zTVeF/uWDSka+vkMFSAaTJ2hegHxiaBU
 mE7lmRn3txhOItiJpLiSJW+iPLjelQHAH6y1bJa+F9C4ss4kmX2s9SXeQ/VukIgPp/bN
 crv21BBHFMxv3rQuI0qslTWGxlhgu3aD7x3gHFhaAxGMxeMsT8OrhMZtOWM2JuSafqJU
 5OXPUiPis2Rq0CLPbyZTG6DXIoXuk9NP6JY8x0rPT5cIGXrGIFhGLHqWVjCelkEsLqlt
 4i9sEjt5VG5jOn2BECAxYvu8wc5LebD/CsJw+GsPBh3dcEjJUppp5J5FKPvlvWKry53N
 SR6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVytCqsdPi/mPtbEvotnLEVR7V/1nUxGK4rWG2dtXu2D3J9n7R7Zy1+g7xC4G0KcKe7a37RtDie9UmPCQ==@nongnu.org,
 AJvYcCW0UXoZmXc85ixaR8RgIwNTwYxkJzWn6D6o/f3M80dw1/F0DSmi1N6mokt2ySrP9q1WoGQKoRuBOyY0@nongnu.org
X-Gm-Message-State: AOJu0Yyxo6Sb+6xeGHMU3aNdKgn/5IeH73n+gswi4Y9O/7O9XWXo3U97
 ORCbazZSaOw72dYA6Xg1CWeF13+C4sqV6fo3C3dNxRFraTK7VK8vexsDoEQkqubT72APuv1stdx
 +5GU7t3AjLRl6HdwC6wp6tMM2KOk=
X-Gm-Gg: ASbGnctsQLpoD0rmsFEfuPOtxJqisXKqZiL913MpsASOK4kms+NYFDmHQhAOYhWvzOb
 vvbxP/HqbDvdPcHK2M5xXeKCYAC8GxJumb5wbwDrNOVnBv14Zg2R9OfiKRCRlf8effPU9A1xK16
 DuVD5Vdp6OgvBtI426z4Qwc6RZDz4cZj3rExDD4UC9Odwsg8WI/z30ZwM=
X-Google-Smtp-Source: AGHT+IG66IhyuuMRVMNZAAUwZJLICdlbrPeZscQNGiWX1Kfg9a9Ygtg1sBlZXq7AYBkA5tlxhE4q/HXdIqYQrMVDrtE=
X-Received: by 2002:a05:6102:1613:b0:4af:c519:4e86 with SMTP id
 ada2fe7eead31-4c30a501950mr7601614137.1.1741559522456; Sun, 09 Mar 2025
 15:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1736130472.git.lc00631@tecorigin.com>
In-Reply-To: <cover.1736130472.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Mar 2025 08:31:36 +1000
X-Gm-Features: AQ5f1JrxPhGniueMU36EPKa6uf8C_odEz-NbYzaYSZncwxNy1CuaoVIg4oiOV3M
Message-ID: <CAKmqyKMu04UPhs_D5xg_z3H+o1_9m9yh+GRhDCgLak9j=Jw+=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Enhanced VSTART and VL checks for vector
 instructions
To: Chao Liu <lc00631@tecorigin.com>
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jan 6, 2025 at 12:44=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> wr=
ote:
>
> Hi, all:
>
> In accordance with the review, i improved the commit message of patch and=
 added
> the reason for the modification.
>
> There was no change in the patch content.
>
> PATCH v2 review:
> https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e@v=
entanamicro.com/
>
> PATCH v1 review:
> https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkK=
OAgEMt_b2KvZA@mail.gmail.com/
>
> --
> Regards,
> Chao
>
> Chao Liu (2):
>   target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a
>     parameter
>   target/riscv: fix handling of nop for vstart >=3D vl in some vector
>     instruction

Do you mind rebasing on:
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

>
>  target/riscv/vcrypto_helper.c   | 32 ++++++-------
>  target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
>  target/riscv/vector_internals.c |  4 +-
>  target/riscv/vector_internals.h | 12 ++---
>  4 files changed, 69 insertions(+), 62 deletions(-)
>
> --
> 2.47.1
>
>

