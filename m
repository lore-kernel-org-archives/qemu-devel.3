Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B159C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 10:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0G3T-0002WC-FP; Sat, 29 Aug 2026 06:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1x0G3R-0002Vf-TE
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 06:12:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1x0G3Q-0005o3-8K
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 06:12:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2164397a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787998370; x=1788603170; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MBVJG7s6MwOddcd7tH6RtphYGgZZlHn+SpSTGBFIEVs=;
 b=maLBSEonqhOUXhH9b7GoWfMwg57LJZs/iKNsJryS1jHJ/MWfLEz0UFkmuC7VCV8z2I
 21KPQVwyh+zXakKoLjWb209qE33sHtpS+PKzvN4bdXNNiVihjRllRfBpejZk1hgfZAwr
 rJuCTfipmbCCReYHrOaL9zIA9tZEPrQWN4RAw8T3DSWLN+QOQsXlWdgSH8Rq069Rmdmz
 0kUDuKbRQHg2dTdSVBK0OVj8tpb3u4M8HN80SfM2MshvPpUoU45x3IE278JUd94uCdnk
 qIFQi+BCSkBJucRNOUvWevjk/MgLDlwh5gAzIpfWi1cmckE7VQ+/qFdRBEUxPvG0MKxH
 x+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787998370; x=1788603170;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MBVJG7s6MwOddcd7tH6RtphYGgZZlHn+SpSTGBFIEVs=;
 b=MnTUG1XfsHg1iesYnb1gPN4axh8d8jz16gmtyMPYhxT/fhcA/Flvi3ime5biD3QGJ0
 wDR2JacuvtJm+QOJQv17tUt7sFKaTNUHt6vRTI+YiDHH0Vt+B7BXybqRZf+79a6K794/
 rMfDo7nqbetS1DlvtoHcHUqLWxGFl1ry8v0RZjt99/FwyGd4lZEjfIrDoAeaxYthH4jt
 FZcMXPqIt+/iu2+fvGAxLh9Y1ojFqqnlRhfo222N1If9gy8afGYEyVUGOt4DwzEjZ3Xp
 hcHTIkYk139vH6cxxGbxBigTUO5QrkOv57zVzTZ7LDL7a+Yc7ZmNtvdxyVK9Kvu/mBvQ
 swpg==
X-Gm-Message-State: AFuF++nsUAm7YEuR5IAYYtfREnBVey9hWB/bW23vxPyKGtJDczaDazkz
 pevv4wGmzG1GnUw0ePxcoBCpsZzsJH6UjjPXjQ4Azk4NZv0rfjbNRAL4kneRgx2Oiqk=
X-Gm-Gg: AYBFou2nvRrMxz/nV7aeuL0vn3whK72y/QYd29gwmyexfqOKDvI8Ov95sIhzgriR1H0
 Rxb9XqGQ6qDSfs0yuxwLoXCxXGApdZL/SFgZQz3VtN+08smmlSj/oGLcGMQsMD8yi7l50tDRA5A
 bIvnXXY+OHYTaBN8JXcUYKA1jG8aXdLJxuKXw+w5xcj2d7Udu51jCeDdW/1y8dfuxGDKIIQSjr/
 nRjC0oseMIqzb2hVw1QEB7Xq/O2mNFX9Q9PEFkTHYmf2X8NMbf8KkQ7vHnD2gf2iXdhbJ0EPlJP
 eTa/xIKTuwVIlhtEo7BJz3TVWaHUn4Rt0JJulDzymBLbETcu6lbi5j0bfK18Kl9IhjQdxoWd094
 Y3yhi9gfp7ebC7dPQnrj4k+dOxixBtu3dk6YJAC7O6D1VhrebyBUfZDnC43kwyCzanGXZGfLK4I
 MFSW10Kz/o0FB6fR0iZTgJKiUjTQyebo40N4ru4HlzS7AenIXGttfmxSRhvA4GwfdnO7pQ
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id
 98e67ed59e1d1-396d0ff5bb9mr24603922a91.14.1787998370042; 
 Sat, 29 Aug 2026 03:12:50 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0df264csm24354655c88.14.2026.08.29.03.12.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2026 03:12:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 0/2] hw/riscv/k230: add the K230 Reset Management Unit
From: Jack wang <163wangjack@gmail.com>
In-Reply-To: <20260719180247.8660-1-163wangjack@gmail.com>
Date: Sat, 29 Aug 2026 18:12:34 +0800
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0685DFA5-2C5E-47AC-8635-A38C69A1A4E2@gmail.com>
References: <20260719180247.8660-1-163wangjack@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping for this patch

Thanks for your time
JW..

> 2026=E5=B9=B47=E6=9C=8820=E6=97=A5 02:02=EF=BC=8CJack Wang =
<163wangjack@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> References: <20260709031237.21284-1-163wangjack@gmail.com>
>=20
> This v2 patch reply on review of=20
> This series models the Kendryte K230 Reset Management Unit (RMU), a =
bank of
> reset-control registers at 0x91101000, and wires it into the K230 SoC. =
It
> replaces the create_unimplemented_device("rmu") stub so guest reset =
drivers
> (drivers/reset/reset-k230.c) work against a real model.
>=20
> Patch 1 adds the standalone device model; patch 2 wires it into the =
SoC and
> adds the qtest. The qtest is deliberately placed in patch 2 =
accorinding to=20
> suggestion from Daniel: it drives "-machine k230", which only
> exists once the device is wired up.
>=20
> Register semantics, reset values and reserved-bit masks are taken from =
the
> K230 TRM chapter 2.1 "Reset" (V0.3.1) and cross-checked against the =
mainline
> Linux driver.
>=20
> Changes since v1:
> - Switched to the Resettable API (phases.hold instead of the legacy
>   device_class_set_legacy_reset()), per Daniel's review.
> - Model real reset propagation: the RMU now cold-resets the two linked
>   watchdogs via "wdt0"/"wdt1" QOM links when their PERI0 reset bits =
are
>   written (Cao review).
> - CPU1 reset request is now a two-step assert/deassert (not =
self-clearing),
>   matching the hardware (Cao review ).
> - Filled in the documented per-register reset values and reserved-bit
>   (writable) masks from the TRM; the *_rst_done status bits reset to =
0, so
>   they follow the per-bit "Reset" column rather than the summarised =
total.
> - Added the reset-time-control (*_RST_TIM) registers as plain storage =
with
>   their documented reset values.
> - Fixed the storage mask so the upper half of non-write-enable =
registers is
>   writable (surfaced by the new TIM registers).
> - New qtests: reset values, TIM storage, reserved-bit read-only, CPU1
>   two-step, and real watchdog reset propagation.
> - Moved the qtest from patch 1 to patch 2 for bisectability; added the
>   MAINTAINERS entries.
>=20
> Jack Wang (2):
>  hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
>  hw/riscv/k230: wire up the RMU device
>=20
> MAINTAINERS                 |   3 +
> docs/system/riscv/k230.rst  |   1 +
> hw/misc/Kconfig             |   3 +
> hw/misc/k230_rmu.c          | 425 ++++++++++++++++++++++++++++++++++++
> hw/misc/meson.build         |   1 +
> hw/misc/trace-events        |   7 +
> hw/riscv/Kconfig            |   1 +
> hw/riscv/k230.c             |  15 +-
> include/hw/misc/k230_rmu.h  | 126 +++++++++++
> include/hw/riscv/k230.h     |   2 +
> tests/qtest/k230-rmu-test.c | 225 +++++++++++++++++++
> tests/qtest/meson.build     |   3 +-
> 12 files changed, 808 insertions(+), 4 deletions(-)
> create mode 100644 hw/misc/k230_rmu.c
> create mode 100644 include/hw/misc/k230_rmu.h
> create mode 100644 tests/qtest/k230-rmu-test.c
>=20
> --=20
> 2.53.0
>=20


