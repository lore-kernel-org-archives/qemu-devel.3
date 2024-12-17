Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AFBE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR18-0002x9-Rp; Tue, 17 Dec 2024 01:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR12-0002ut-8b
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:08 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR0y-0004rc-HG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:06 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1687866b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416702; x=1735021502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XBZdhaiMoxKZxHX9jMR/nzgRkr9faWbDFQsJShgEOjc=;
 b=eFjFcaQ5636zxbtRWzPGLfu7H1lEvSQGar4pGLO+LZl7js9Fl82CiGrlvWFjlqYtmc
 PcLabD3qmovBpUujoRKj/8mFPRdgR48WL3c7i/DW33Z1208ZB3BmOTbNeBn5lZPQIFzK
 sX6+rSmVB7ok+0DPUa5bSzUcQ4mDbdNFAjLpafYNrbk63htfX9MbJ0ByOxznUYsxb36n
 26lgJy4Yx8NZeZnIfSVTRuGUeqz4Ik+P4V31EWPuOvKcWcXviGIO6OxVSFhZnQ8OzaCx
 D3Veah/pBt9XSal4cJLOvqD7v7ZZUfLPxjXGyvS3LTe7ElCdHYnMz6DM/5lRnLKzy22y
 0+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416702; x=1735021502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBZdhaiMoxKZxHX9jMR/nzgRkr9faWbDFQsJShgEOjc=;
 b=k6pK6dDv56kh4sVseXCOlB3kdpSAeIII+1xaMuTUPCD/bPhntXXbn2kXLVxG7no+tZ
 pX2KYwg5xJhk3qQSS4Yd7w2+IarACXmSI7Y8O9154dD7djfVurRKJtzzWIn41XHpkTxL
 7ev5UvjK6+HUTaTIwVTmINCZ2Z2wyGuliQe86RlVdhQB2EI4VIfHWkdN0I1HB+OqlZwy
 IlJ9rwD15V2/Wne/kjLdJuQohhTlhxgYXwj/k0bPjpu0errrE2zCw5SxLLL6bnhxsfNx
 3I7Lp8chUmKdoNfpVvBSMAYUdqbrlK4FgNP5VSRIol/CU48XG8LgxM4d2oplcFnMFGHS
 Q5Og==
X-Gm-Message-State: AOJu0YwLl5XCmLSpqD16MJMHEkKlcFFUq1L5f4xBvCYyZ5STYlZw8sHk
 V37+qwJ0QG3Zqap2jYDCCTyUJnAHr+QalD+DqxcYl287fJXcjmvaMfluG0qqMvD4h9Uv2jzUUTU
 KlDrbIIipCxj1sGBZVkm+g7px/77JJhGFHsJJs7iAxWKHOd6ZkQeZwbWvEjfwdJG1YXjXVcpl+J
 wy/hwydLQxeQzdxq+Pj/1KVOOHyHx3Yy7J0QlAQfYqwA==
X-Gm-Gg: ASbGncsRDc575jwXNBKxvk4/gP3LusWjokhqyGVjb5QR6LGrPm6knz/pW5bvFdsTkDr
 We2FnqLzDe9s7KrtQWMcwnbF+0df2j4atLfy40So2TiAhwKXZ/LKZuEpAc/2dNIMHi7jKmYo6m2
 kAYIYroXPemaJZnCWelf5q9VX7ZrN5AMCbTjVwaIYFkV7o5epiTym4RO3wu0C/+Lq1eArv9HU4S
 daJ5sJIov3MW/BmneUxY13oJeNFK3XhtWtajXw9avsR/PqmjTh2H9hfTMXZBEDXBspCaiVP9os+
 BYloe8hbEnE=
X-Google-Smtp-Source: AGHT+IHh6jHsACOOD/BRR0MrAgKRWQSK8bXVPbR9GBGvKhBlfSBudbGtMBmur55+pFe0uprLPu+6Iw==
X-Received: by 2002:a05:6a20:1589:b0:1db:9367:d018 with SMTP id
 adf61e73a8af0-1e1dfd60c79mr24694748637.20.1734416701579; 
 Mon, 16 Dec 2024 22:25:01 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:01 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 0/7] Add Smrnmi support
Date: Tue, 17 Dec 2024 14:24:33 +0800
Message-Id: <20241217062440.884261-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This patchset added support for Smrnmi Extension in RISC-V.

There are four new CSRs and one new instruction added to allow NMI to be
resumable in RISC-V, which are:

=============================================================
  * mnscratch (0x740)
  * mnepc     (0x741)
  * mncause   (0x742)
  * mnstatus  (0x744)
=============================================================
  * mnret: To return from RNMI interrupt/exception handler.
=============================================================

RNMI also has higher priority than any other interrupts or exceptions
and cannot be disabled by software.

RNMI may be used to route to other devices such as Bus Error Unit or
Watchdog Timer in the future.

The interrupt/exception trap handler addresses of RNMI are
implementation defined.

If anyone wants to test the patches, we can use the customized OpenSBI[1],
and the customized QEMU[2].

We implemented a PoC RNMI trap handler in the customized OpenSBI.
In the customized QEMU, we use the Smrnmi patches and the patch from
Damien Hedde[3]. The patch from Damien Hedde can be used to inject
the RNMI signal with the qmp command.

[1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
[2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v10
[3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html

Test commands :
$ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
rnmi-interrupt-vector={Offset of the RNMI handler in the customized
OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
-bios fw_jump.elf -kernel Image -initrd rootfs.cpio
-qmp unix:/tmp/qmp-sock,server,wait=off

Use qmp command to inject the RNMI.

Assert RNMI:
$ ./scripts/qmp/qmp-shell /tmp/qmp-sock
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=true

De-assert RNMI:
(QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=false

Changelog:

v10
  * Disable Smrnmi for the 'max' type CPU.

v9
  * Add Zicfilp support for Smrnmi.
  * Change the existence checks for 'rnmi-interrupt-vector' and
    'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpvec'.
  * Add warn_once messages for cases where the user sets
    'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
    enabling Smrnmi.

v8
  * Set virt to false when trapping to M-mode by RNMI.
  (Thanks to Clément for the suggestions.)

v7
  * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
    checking codes.
  (Thanks to Clément for the suggestions.)
  * Add the missing REQUIRE_SMRNMI() check and remove the redundant
    check in 'helper_mnret'.
  * Rebase to riscv-to-apply.next.
  (Thanks to Alistair for the suggestions.)

v6
  * Delete the redundant code in 'riscv_cpu_do_interrupt'.
  (Thank Alvin for the suggestion.)
  * Split the shared code in 'helper_mret' and 'helper_mnret' into a
    helper function 'check_ret_from_m_mode'.
  (Thank Alistair for the suggestion.)

v5
  * Move the patch that adds the Smrnmi extension to the last patch.
  (Thank Alistair for the suggestion.)
  * Implement an M-mode software PoC for this with implemented handlers.
  (Thank Andrew Jones for the suggestion.)
  * Add a commit message to all patches of the series.
  (Thank Andrew Jones for the suggestion.)

v4
  * Fix some coding style issues.
  (Thank Daniel for the suggestions.)

v3
  * Update to the newest version of Smrnmi extension specification.

v2
  * split up the series into more commits for convenience of review.
  * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.

Frank Chang (2):
  target/riscv: Add Zicfilp support for Smrnmi
  target/riscv: Disable Smrnmi for the 'max' type CPU

Tommy Wu (5):
  target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
  target/riscv: Add Smrnmi CSRs
  target/riscv: Handle Smrnmi interrupt and exception
  target/riscv: Add Smrnmi mnret instruction
  target/riscv: Add Smrnmi cpu extension

 hw/riscv/riscv_hart.c                         | 40 ++++++++
 include/hw/riscv/riscv_hart.h                 |  4 +
 target/riscv/cpu.c                            | 18 ++++
 target/riscv/cpu.h                            | 10 ++
 target/riscv/cpu_bits.h                       | 24 +++++
 target/riscv/cpu_cfg.h                        |  1 +
 target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
 target/riscv/csr.c                            | 82 ++++++++++++++++
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
 target/riscv/op_helper.c                      | 54 ++++++++++-
 target/riscv/tcg/tcg-cpu.c                    |  6 ++
 13 files changed, 348 insertions(+), 11 deletions(-)

--
2.34.1


