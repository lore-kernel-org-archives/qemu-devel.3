Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A2CC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy4cl-0004Ct-9k; Sun, 23 Aug 2026 05:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wy4cj-0004Bw-9L
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:36:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wy4ch-00041P-Ly
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:36:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d58efc7356so27658175ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787477774; x=1788082574; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GrfZIkiLIPkX4zgbKoe+aL7IslYfdCWoR76dhTFDNcE=;
 b=Mc01y1u6qwnSV2VhZzITZK7pCXkogsGU7Mx1Uv7Ubh2M8yDWJQwQGDdyOF5UqQOuUG
 uQww6kGVXsdpl/rn95GAYYUaOgkveh1vrw/SdTpKWeReK4S/msE+QWvHa1SBC+MWl9aI
 aT/oBb0zcoksF+pE9yXYR38ek34nFUuDRFpLryIH656n0Z1Slia6aeuwAxDYL5Vzj3d2
 dyeBQ9W1zTCsMhAmS3SjupKzi5OME/yR82wNIcBxV4Lbku5HJ1PxNLc3EBs4vR2Qs0aO
 r6RSIk2mY0WLaoOAp9kpkoEgl3iDFQvZwGLQwuxHaEWmEw0P08jyjA1SM1au7+1A09nJ
 ebig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787477774; x=1788082574;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrfZIkiLIPkX4zgbKoe+aL7IslYfdCWoR76dhTFDNcE=;
 b=Mi99DjsKvoW9nV28bJ7fjCrJFl8voXK3az/c9wEs15GzVlKn6vJ7HBP4q2r6UpaO6E
 BmSi94ql/TRflE++oDBk/Q+zvnGa3XEq32PY3bvIu44pbUZu0+PPsQbD+7oRRFYGau5M
 /grsANBSYaBGYZ/d4R6/lAx+dMXONsycVycs/y0Mm2Ydb4c69b7VSc9TU6P29Ei0mOJp
 3eE2kyXB/l2UaoYesisb6RSdihwyFn/Wy0INlwbvgBfZKnW4AjaY5yVg32eseqzeWWka
 0tOwMQq1jBeM/YwSaF/mqjJE3kM/A8U5olM/FE6c7SSpg8YRAVFAxOF76vmn32YjSqlr
 uStQ==
X-Gm-Message-State: AFuF++lGJi3mkhnrYdU8bQqkD2dWqSt5uAUCOR4B1Qyb+TTbr0JHLPqT
 /2+mB4lDOhN2ezroD/I6CP5NkdN4EAMx9EyHmfMrABAV0dObEmf4pQRHySzZx9KrvENQYA==
X-Gm-Gg: AR+sD11K+FDuaKw1gmC4uRH2mfoYgMjYnoqI1juvGNPzxrWxFrnda8yAjdPrZIuZgF6
 rPiwsVnPbJcBi5JhvxoNfHVxwt4EytibdApy3tMPbaQLagWe1bQZz4cyKVlTyn4JI96imH4iPEl
 VcLrgyx49KgSz425EwyQ/fdBHU7I5LfDs1u/uyWmCq0uX3JjXjgeLP7rrlSVLGYaBPd/Wy8PvnE
 fxbMLzY2yVUBsDmTKG9VE0wCHeaK4i7AEbcuhOIHauOTTxixnDTwF43quuaxuxKh9KgoRpiMRVt
 Q1aHphS7aRGdD2jkGAC0TyQNrLZEx79PEckIx1gmlfjVucfxMFVD/bBQaNfU0UzY5gbRgBlPwzV
 NblkbIiTxDCD6NbDeUxywyacZbXoquX6FuDgRL/oSR/FrmMpYSv18JeXRXjzChmksEmqISnDZn0
 B+VyBM4voEJ83dzUWhmdkCbLfc1X/uGoDSZAVb3baiFlYJfc2syao17sm80ZOvlDraV+cXt6hjl
 Tl9AzU=
X-Received: by 2002:a17:902:ce0b:b0:2d5:ccb7:12c3 with SMTP id
 d9443c01a7336-2d670b83673mr204518995ad.2.1787477774111; 
 Sun, 23 Aug 2026 02:36:14 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f8e2a730sm15000783eec.0.2026.08.23.02.36.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Aug 2026 02:36:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 0/2] hw/riscv/k230: add the K230 Reset Management Unit
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260719180247.8660-1-163wangjack@gmail.com>
Date: Sun, 23 Aug 2026 17:35:58 +0800
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5866774-254F-4900-80C1-857EAD752C30@gmail.com>
References: <20260719180247.8660-1-163wangjack@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62c.google.com
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


Hi all,

A polite ping for this RFC series.=20
I fix problems raised by chao liu and Daniel.
I apologize for previously missing the qemu-riscv
Mailing list, it has been added to this ping mail.
Any feedback or guidance would be greatly appreciated.

Thanks for your time,
Jack Wang

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
>  device_class_set_legacy_reset()), per Daniel's review.
> - Model real reset propagation: the RMU now cold-resets the two linked
>  watchdogs via "wdt0"/"wdt1" QOM links when their PERI0 reset bits are
>  written (Cao review).
> - CPU1 reset request is now a two-step assert/deassert (not =
self-clearing),
>  matching the hardware (Cao review ).
> - Filled in the documented per-register reset values and reserved-bit
>  (writable) masks from the TRM; the *_rst_done status bits reset to 0, =
so
>  they follow the per-bit "Reset" column rather than the summarised =
total.
> - Added the reset-time-control (*_RST_TIM) registers as plain storage =
with
>  their documented reset values.
> - Fixed the storage mask so the upper half of non-write-enable =
registers is
>  writable (surfaced by the new TIM registers).
> - New qtests: reset values, TIM storage, reserved-bit read-only, CPU1
>  two-step, and real watchdog reset propagation.
> - Moved the qtest from patch 1 to patch 2 for bisectability; added the
>  MAINTAINERS entries.
>=20
> Jack Wang (2):
> hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
> hw/riscv/k230: wire up the RMU device
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
>=20
>=20
>=20

