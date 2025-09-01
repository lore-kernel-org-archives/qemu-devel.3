Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E60CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4kE-0006eV-6J; Mon, 01 Sep 2025 09:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4kD-0006c0-4N
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:38:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ut4kB-0002wC-7e
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:38:48 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4df220483fso1635113a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756733924; x=1757338724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZowQdyvRwHsml+bgujSkjckmEz+MBBensDiSah6jtI=;
 b=j9EfbDK/mN46zWvV0Q6TkAoflAmkjkdZVblDsk1LipJAgwGaXZzpR7NAaESg1lkPa7
 Hhhd5dI3rSt9eyLyh/K/qOYGcS+izeCjM0cWj8BIFt1QDfcElUfpkxIg2leufx1DF4lm
 wvcH4aImGcTPbAT23q3xFD0/ZFpPdQMENHKJNmZmuTOWPkWbSSsZa4m3zCKaRU1XmVTS
 qrPwkzrtLC9XWZso+LM07R3FPgIrH+yJukfhs5k9FpMuRDmmMI9m+JqeS6puQiNYYmEX
 AcgCyAKVzhBt/O46plsUFX02RHRJc5uUwLobUdvHIrBQXv2mZKm3RRrWhTqjSz2i/Vlt
 X+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733924; x=1757338724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ZowQdyvRwHsml+bgujSkjckmEz+MBBensDiSah6jtI=;
 b=HKay1uLrb+cA3rFPABYQmJGpA8wdFkSi31Fi6lqWbPA63O1RdlcjeQwFD6YfPcU0Np
 HaN+MtWoj/VxOGzAoKjCdAJLeJY6RgX27BxBcaQSr2OYJWB3VYCpUxEm4SdI5cMyBpmW
 2HRRRNWwxuLJJMnLfNlSYufywm1o1RBwqYmRNoGmi/l0b+9dgy4nliLsMFL1Zs4C1JOc
 3kx/sP9ySoulE1UoODWwZyfFBQixnkS4WRD0MkKkXw83B/fwSi+sNPd6ygkHnXmvIA8t
 3l0trVNMDQ1ydCw1lR9bsZBJ464mXQhSQZZoTv+Ll7Psmzjsbf22rekAGMERty38bQ/e
 yUGg==
X-Gm-Message-State: AOJu0YwAFsLwnT3ipPKiY2H5lBlYQeh1B8TD1r0Jg+FY2jDxy60JjiHf
 VEyN42mY/GhIbwY6thUPxsOCRdKkE9VMitvbjXQzY8Ulg4agUTMftrG7hv+llbsDH7v+YN9R8WE
 dTLo6wmtood6e2bKLEMj4NRxPh+y4+SQ3urNWrNQ7PuTDMOaZ77FeYsURZ/KMQOrDMCUZDzNrhN
 i2ZEccTEAly70N3E7wOg4hwBfC06dcgvB8omNaPa/33g==
X-Gm-Gg: ASbGncsPdTwjHm2tB41CQGNoLbw5T4vCwE6kGuLisU+tLKSNTlLSdhd8f+FG4W8rnwz
 vIbG8mw0eVlZk8ekAcItlce/h78+xxgEgWZvYMYCcOxY2PVdFjs3GuT4rBKE1pImGXmfeVIs2la
 szs55f85X8SuOfhbLPYfn8ua02SOG2IMf/VSluDVXSSIT6+EKurLUEWl4hhc7n2Giw2WLeRNlB0
 iJ0njnZedjEItGAoQvRxNHhPJjsGzDDabRULiam9aZMLHp8JNhwY2fsYyh8JEi061+8yh2nJFtK
 I7B0MAqgqP/nIKrby/K3W6gHt3OAgZnWVU2oyDMYLWVbvr2OIgGUruvzmPPrkZE2oi/AXb2KULO
 f5AhmfoaINCo5pLam/vkziS6hf0NE1zIw9ZQgOTubsQcrKfrIc7PBLFM1IvFrln5wTv0=
X-Google-Smtp-Source: AGHT+IHM014xf+YvdOuscE9kzw/u9kI7adweaxblznyhxRsYxtfEyHAp+OUftFuItwH+Gljk/Khl1Q==
X-Received: by 2002:a17:903:2347:b0:24a:8e36:420a with SMTP id
 d9443c01a7336-24a8e364377mr96213125ad.40.1756733924344; 
 Mon, 01 Sep 2025 06:38:44 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da3bbfsm103106375ad.70.2025.09.01.06.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:38:44 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 0/3] Support RISC-V Zvqdotq vector dot-product extension
Date: Mon,  1 Sep 2025 21:38:12 +0800
Message-ID: <20250901133815.1693077-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series introduces support for Zvqdotq extension.

The Zvqdotq extension's ISA specification is not yet ratified, so this
patch series is based on the latest draft (v0.0.2) and treats the
Zvqdotq extension as an experimental extension.

The draft of the Zvqdotq ISA specification:
https://github.com/riscv/riscv-dot-product

Max Chou (3):
  target/riscv: Add Zvqdotq cfg property
  target/riscv: rvv: Add Zvqdotq support
  target/riscv: Expose Zvqdotq extension as a cpu property

 target/riscv/cpu.c                            |  2 +
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 ++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  5 ++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 63 +++++++++++++++++++
 8 files changed, 152 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

-- 
2.43.0


