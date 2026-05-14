Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F7CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWry-00051Z-EV; Thu, 14 May 2026 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNWri-0004x0-65
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:16:44 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNWrg-0002WA-86
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:16:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso2007839a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 07:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778768198; cv=none;
 d=google.com; s=arc-20240605;
 b=hNK4EWkrsna/fgOdLGWUaeIPhP2R22fLX6O4leDSrk4gQt73Ex6gPzP3WpvCPfL7sK
 X3Nmlv6iQk1PDaVi9z6pA94J/4HZIr3qwEMkSzGN1CipVAkUTmEaGu0Khdf0eTQ9zdvD
 +QbG9PSHXmsCvf0obbjQ6AHSnCKZYechW564BtD5+vayGhvklhM/9ilvzY4ZkVAnxEvB
 cpxQHJctqb1WysX8RFyJAXUX2HgN48L/MzszhrngzCvRNetBxtuNhkigZbvQMxWWl/Ok
 k0w6rMnBxnUejGP4XjioX/9RB2XgMJOEF5dvli6UvrWk5GTMSA8F6KO5xneI6uxNxm8w
 q05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PjXORPx5Peg6zIxSFMU+GqvyYI9kAzUSokiTLfFVI5g=;
 fh=ynMZpoLdc8EcguBEfEqlF67vL8jpBgF8ghejmEGS7cY=;
 b=cHkpzwBOJHBlOFH6HKDUDQtDETSFttUdYGZFarHHp5xVatjGr9sikveWXwH/y4Tp11
 j6j9CKEB0qCCCsoXFKZ4przz18kepQbBwVquCOj6RFwrLd8d5PntYI31xVwTHaJ6E+Bv
 UDfiikUkz0hZV0wQNAeRdpGqzuHMyYF+7qhC3qbyv0Og8fNfBif05FYXPUeP/WBdiPgY
 ez7EsyplIg5dzLgew5E6Ms3unfp9XOiQDwih6Cp0PKB+wlcxL7U5oo4AOhBdkqCldL6+
 SDdxVrQBs+NfFiz40jle9NzJ5yl9AlQIuDjufxh2jpNuDDwkNbVIL1WQHzOLKv1pdnUK
 k6UA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778768198; x=1779372998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjXORPx5Peg6zIxSFMU+GqvyYI9kAzUSokiTLfFVI5g=;
 b=JnMn7YUedHtQmTpwA4PAnPuRqtN7hyz64EMpwp06PRMfhBOKNcctt7jkhsq/Vv5mTf
 PsOqr0pUVQ6rRV3fE9wG2VGIGKbllLbpBJbClA1dCzgbnMFw927Xbte5UyIgTaHCNIBa
 h2WJ20ftKdPUOgWaM+DJTygPJho4q8GMBSqAUeNBqkRaQUEoFm7SEngAx0XmjlaBSU5w
 X9gTT1rc2Psx4sASD1BgcxPYHq4hScy1R1QplnSZacZrEJMXVi7Vj0zg6RU4Nrj05pmy
 LjyE6qvbVzxyMRnGSA7LqNXHz22TRv3pbPpRpi2ykfmf6gkr6UHLAisB/0/4YLtF60lE
 OaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778768198; x=1779372998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PjXORPx5Peg6zIxSFMU+GqvyYI9kAzUSokiTLfFVI5g=;
 b=EVc0Cof//YEHj4k2/qRSaDx4JIcl06t7joYXYZlWESjtLDC7ZL7rE40L+n8uNttrjd
 m0F5NLoSrEKVAU4Auc7eVKKXc+nu5FYKOBkLiq/+zrsTweX1JPirLWVHfAetNUInmYFB
 Zf0jujYq9DiXeCK73aAbVedYXBZ+dSiptNoOv1sM4SPbcX/WLkNmBUafAPZAG1MRGhhd
 NLSvRpvR6uPvLLQ2usYf0PQHlkbHqx2qBqeT9h1/WxJ8Jbl9p6hHJWIjaNUPhOpqgVbu
 YTLe/OC/0M7y/BVEFofXZCb0YB5ngNB4StgVg7EU0ZOwmudXiowD2guOtpowfsQ2aV1o
 fkAw==
X-Gm-Message-State: AOJu0Yy4d67zN9CJ0lkNtScDGRaSAClxBUE2P2nEUsINjfa2Q+QHxA9C
 DD7v1GTMIbaNTA6m3Lc0J4TXOqDq051LK5McIhRPxhRXDglkK0xMHYo8vTkanz0Xo4ugchuT9TK
 EUZAOeDurqECgbIJcvmaHGQaWmLD3oxw=
X-Gm-Gg: Acq92OEPrbAuZktjD+CBN1iNwkiVHtdpjCCyVgGw93bwKly+mCVL1dbcTE0yFr43zX8
 SjPqrYDrCRxgBQPaq1l2jQ/hb4btx0RNexmardqAyGMSLWyEUYIIVQZ2ALV279w+KPrKQgH6pMv
 atkXonVgQtrncFjxjFZJAGgkzMUvm6Vr7BbKqf50m+F2nNWLur0RgZduRKb2KcnQozBFQUhghqh
 P/T0Xkf+vJ6NnomYmLwDbOBHhQdBsGwi/tdSM9GejKNCn/yj2ildMEJuTlfW5buOQ/4pDPT37Vg
 dVGY38SbD/mZpPiSXP/WgbunDzhPl//6Dsn9Ug==
X-Received: by 2002:a05:6402:c42:b0:66d:d0c1:f87b with SMTP id
 4fb4d7f45d1cf-682a700add2mr4110096a12.10.1778768197541; Thu, 14 May 2026
 07:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 14 May 2026 10:16:25 -0400
X-Gm-Features: AVHnY4KQWSQKvW2YI-xPhDpdSHTnYSgQMe0X-izV9vwTZppyg5JTFBvVF-y4htM
Message-ID: <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
Subject: Re: [PULL 0/5] Target-info update for 2026-05-12
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, May 12, 2026 at 2:32=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e95=
3b:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu=
 into staging (2026-05-11 10:49:53 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260512
>
> for you to fetch changes up to 0fc2022c6331c5d5bdd9060c73d067abba3f5515:
>
>   target-info: replace target_info() in system-mode (2026-05-12 11:29:18 =
-0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH v6 0/5] single-binary: deduplicate target_info() (Pierrick Bouvi=
er <pierrick.bouvier@oss.qualcomm.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-1-pierr=
ick.bouvier@oss.qualcomm.com
>
> ----------------------------------------------------------------
> Pierrick Bouvier (5):
>       qom/object: register OBJECT and INTERFACE QOM types before main
>       qom/object: initialize type_table in static ctor with fundamental Q=
OM types
>       target-info: introduce TargetInfo in QOM
>       target-info-qom: detect target from QOM
>       target-info: replace target_info() in system-mode

Please take a look at this CI failure:

Testing ./build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus=
-vga
...
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D5334=3D=3DERROR: AddressSanitizer: SEGV on unknown address
0x000000000020 (pc 0x5bd0beb39ef4 bp 0x7ffe0ad764d0 sp 0x7ffe0ad764c0
T0)
=3D=3D5334=3D=3DThe signal is caused by a READ memory access.
=3D=3D5334=3D=3DHint: address points to the zero page.
#0 0x5bd0beb39ef4 in target_endian_mode
/builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:42:27
#1 0x5bd0beb39ef4 in target_big_endian
/builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:47:12
#2 0x5bd0bf4f1da1 in qtest_process_command
/builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:705:13
#3 0x5bd0bf4f1da1 in qtest_process_inbuf
/builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:778:9
#4 0x5bd0bf4eef54 in qtest_server_inproc_recv
/builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:910:9
#5 0x5bd0bfe18f85 in qtest_sendf
/builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:715:5
#6 0x5bd0bfe15294 in qtest_query_target_endianness
/builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:804:5
#7 0x5bd0bfe1f2f3 in qtest_inproc_init
/builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:2043:23
#8 0x5bd0bfe71778 in qtest_setup
/builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:64:12
#9 0x5bd0bfe71778 in LLVMFuzzerInitialize
/builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:206:16
#10 0x5bd0be9b3b56 in fuzzer::FuzzerDriver(int*, char***, int
(*)(unsigned char const*, unsigned long)) fuzzer.o
#11 0x5bd0be9e2166 in main
(/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-ge=
neric-fuzz-cirrus-vga+0x46166)
(BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
#12 0x7f7fef9a65b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
(BuildId: abd2a4d896fed122b3f7da571746f193feeb86a1)
#13 0x7f7fef9a6667 in __libc_start_main@GLIBC_2.2.5
(/lib64/libc.so.6+0x3667) (BuildId:
abd2a4d896fed122b3f7da571746f193feeb86a1)
#14 0x5bd0be9a8f34 in _start
(/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-ge=
neric-fuzz-cirrus-vga+0xcf34)
(BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)

https://gitlab.com/qemu-project/qemu/-/jobs/14371480130

If this issue is caused by this pull request, please send a new
revision that solves the issue.

If this issue is not caused by this pull request, please let me know. Thank=
s!

Stefan

>
>  configs/targets/aarch64-softmmu.c |  6 ++---
>  configs/targets/arm-softmmu.c     |  6 ++---
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++++=
++++++
>  include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
>  qom/object.c                      | 22 +++++-----------
>  system/vl.c                       |  4 +++
>  target-info-qom.c                 | 45 +++++++++++++++++++++++++++++++++
>  target-info-stub.c                |  6 ++---
>  9 files changed, 145 insertions(+), 28 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
>

