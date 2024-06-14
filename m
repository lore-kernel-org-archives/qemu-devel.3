Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DD1C27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 15:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI9Bg-0001sr-Dm; Fri, 14 Jun 2024 11:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI9Be-0001sJ-98
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 11:49:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI9Bc-0003z1-FL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 11:49:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f223e7691so1491093f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718380194; x=1718984994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AH1T8j+snYwiM53VlnL+FCmC0JkGpA0roAN8nA3hzcQ=;
 b=qHgNFTIL4lkIV/8796txxGCqGasSjD6mwv6k/Lq2i8+urKTownX5nafrSOhwU92Pw9
 b3OWVaL+L03oo24eqRIDxqbO2FrWuXhT9O6kidkQUGHDocoUXQZo/WHWKyxSrKMiKkZZ
 X2Njc6LZfns210kCo86m2ap7bPdXLK5J31V0G3IJPwP6dycNuDtnkdHDFQsxkgnWpwwO
 f62EPnWlu6hGYO3Zsy8+b2p5sc8mTm2UlXmurI4/THhaZAYROVd+pb0X6kni8wa5+6Yf
 1N+2LcuGLt8W304WJRRX4YUKcJpFxtM193wSMANT7MWrDJLtwineWj5UlHg/BJVm4/Uw
 I/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718380194; x=1718984994;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AH1T8j+snYwiM53VlnL+FCmC0JkGpA0roAN8nA3hzcQ=;
 b=DWtK+fbQeBU77iMXoRxoJCjxVF7Oc+zkxo5RtumT1KuUN6ve3Kk1ll34G0XfPp8LJM
 eSzUn3O6+N2GaHREQ66NGOrr2s1aL8pNDrNXnWSWnLyW7SGUh9HIqH2UYpMsabh0vODe
 XuTGtTrLML5pHlHaP48p/ds563Q1VhRjOUgJyv76v96kzQzWn9SmZ+gMV+KQrJYFpbQu
 qx4u9NyQOGHDqFjtByu+qM9fRbxBBxJ9PHTnHR9xyQRr9E6NZzkBHp+0tr+i+qgQKy2C
 R64URa1eYW5HeFnCpfK6EyDVVTb/BArm22SRyfR6KXjyW796eufkTJe4to3XOSUQ+D5U
 1oLw==
X-Gm-Message-State: AOJu0Yw42Z7jGGJqLGmoFeMv6R6QZIuxZQbWfHkuiiaRyv4QN8mQh55k
 vSlim55ysSF74x3gKEnd9jzod1RspzEAp1dVnDMl4tQAsqPiwAU2iKmTGylhdiw=
X-Google-Smtp-Source: AGHT+IEo2W5Bk5x+bcsTCGGm2Q2evLjPCDlXlXk1y8BEqslphp2/NXVLqBmZ4T527DU584vaqRotuQ==
X-Received: by 2002:adf:f906:0:b0:360:715f:faf with SMTP id
 ffacd0b85a97d-3607a4cd26bmr3840822f8f.10.1718380194168; 
 Fri, 14 Jun 2024 08:49:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104c17sm4703898f8f.106.2024.06.14.08.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 08:49:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DC3B5F794;
 Fri, 14 Jun 2024 16:49:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:20:54 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 16:49:53 +0100
Message-ID: <87ed8zttge.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This patchset adds the stubs necessary to support GDB memory tagging
> commands on QEMU aarch64 user mode.
>
> These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
> packets, which allow GDB memory tagging subcommands 'check',
> 'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
> memory tagging commands ('print-logical-tag' and 'with-logical-tag')
> will also work, but they don't rely on any stub because they perform
> local operations.
>
> Since the memory tagging stubs are not common to all architectures, this
> patchset also introduces three functions: gdb_extend_qsupported_features,
> gdb_extend_query_table, and gdb_extend_set_table. These functions can be
> used to extend the target-specific 'qSupported' feature string and the
> handlers for the 'q' (query) and 'Q' (set) packets. These new functions
> are used to add the MTE stubs for the aarch64 gdbstub.
>=20=20
> Note that this patchset requires a GDB that supports the
> qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
> tests introduced by it must be run using GDB's master branch, since the
> GDB in the distros hasn't picked up the change yet.
>
> Once GDB is built and installed locally, the tests can be exercised, for
> example, this way:
>
> make GDB=3D~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32

It looks like there might be some BSD build failures as well:

  https://gitlab.com/stsquad/qemu/-/pipelines/1332635371/failures

>
> v2:
>  - Addressed comments from Richard, Phil, and Alex
>  - Made the series more granular by splitting it into more patches
>  - Moved gdbstub command-specific structs and functions into a new header=
, gdbstub/commands.h
>  - Fixed exception in allocation_tag_mem_probe()
>  - Used MTE helpers ({store,load}_tag1 and allocation_tag_mem_probe) in t=
he MTE stubs
>  - Factored out MTE code to set TCF0, avoiding duplication (both prctl an=
d gdbstub code use it)
>  - Hoisted sscanf() out of loop in handle_Q_memtag stub and use gdb_hexto=
mem instead
>  - Rebased this series on Alex's gdb/next branch
>
>
> Cheers,
> Gustavo
>
> Gustavo Romero (9):
>   gdbstub: Clean up process_string_cmd
>   gdbstub: Move GdbCmdParseEntry into a new header file
>   gdbstub: Add support for target-specific stubs
>   target/arm: Fix exception case in allocation_tag_mem_probe
>   target/arm: Make some MTE helpers widely available
>   target/arm: Factor out code for setting MTE TCF0 field
>   gdbstub: Make get cpu and hex conversion functions non-internal
>   gdbstub: Add support for MTE in user mode
>   tests/tcg/aarch64: Add MTE gdbstub tests
>
>  configs/targets/aarch64-linux-user.mak |   2 +-
>  gdb-xml/aarch64-mte.xml                |  11 ++
>  gdbstub/gdbstub.c                      | 211 +++++++++++----------
>  gdbstub/internals.h                    |  24 ---
>  gdbstub/syscalls.c                     |   7 +-
>  gdbstub/system.c                       |   7 +-
>  gdbstub/user-target.c                  |  25 +--
>  gdbstub/user.c                         |   7 +-
>  include/exec/gdbstub.h                 |   5 +
>  include/gdbstub/commands.h             | 102 ++++++++++
>  linux-user/aarch64/target_prctl.h      |  22 +--
>  target/arm/cpu.c                       |   1 +
>  target/arm/gdbstub.c                   | 253 +++++++++++++++++++++++++
>  target/arm/internals.h                 |   2 +
>  target/arm/mte.h                       |  53 ++++++
>  target/arm/tcg/mte_helper.c            | 181 +-----------------
>  target/arm/tcg/mte_helper.h            | 211 +++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target      |  11 +-
>  tests/tcg/aarch64/gdbstub/test-mte.py  |  86 +++++++++
>  tests/tcg/aarch64/mte-8.c              | 102 ++++++++++
>  20 files changed, 975 insertions(+), 348 deletions(-)
>  create mode 100644 gdb-xml/aarch64-mte.xml
>  create mode 100644 include/gdbstub/commands.h
>  create mode 100644 target/arm/mte.h
>  create mode 100644 target/arm/tcg/mte_helper.h
>  create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
>  create mode 100644 tests/tcg/aarch64/mte-8.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

