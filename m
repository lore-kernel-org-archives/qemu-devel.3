Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F4C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26NP-00059V-8M; Tue, 08 Apr 2025 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26N3-000535-Cb
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26My-00085q-OB
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:39:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so4397964b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108791; x=1744713591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KkJpg2ZaCQwylmwZcNazfm9o1z46TaCaXCXoOTWAtWI=;
 b=myZi/aqOFrkZA8s+Q0Yb/QIv2UXgtAMFlnmisNgsaFy4/Jk0SQMLC//kr4hHlp57BZ
 +L/ntpRiTntWJx+USSD9Ih+amf6z0d4PAY5vXTmpIkjG0Bwj2cdVVb7YUM6fyw1V9b7D
 WVVAwZTBxTDDlJ2deSwRXEhreHyatuTzWdynETUHwarIocSFfpsuRGELwRQ2bsGc+pTM
 jtAtu6sZZ9du3PUbQPnFqjgt0UWY/PivY+rkX9Lylha1b9ThonzKYhqWLBIvm+UC5wKX
 XtYXSNfvHzhV59ADSkyWkOvqrlRy0eyxjzoORC+3jdk0B3fdvot71NLl2ZbiKKh1nQJG
 ha0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108791; x=1744713591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KkJpg2ZaCQwylmwZcNazfm9o1z46TaCaXCXoOTWAtWI=;
 b=envjjTzWdBG09IS1UmAUInpsrjJJcJwL2Hd1NSBiN74hc2sDSvlz9NFa+a0CTsqtw2
 IVNHI64mwC/4k8lnNZmmkCDWk5gqFKDE2fpYM4Mk96Vi5yQ1swkfdUjdchKa0CpPvvOb
 9rxzXkgL4bNxmqr/i76yknVBEAhjxIU4dT6BorpxF7INufwDBmq/l4StRmTagKqSoOUr
 oqG4t/pzj4P6NxcorNBp1+jEd2lly4NYT81NzWIH3cgQBOCMduyGcTmr3Gi+nnDS/tY9
 6Rz6L8HQQTZaRw5rjkOtC/K71Jj7+cVemrYtpk5vPxVsrzQOT9g/SPPP+gaQP0PVOaHH
 7npg==
X-Gm-Message-State: AOJu0Yx+biG8isyZ/jJZdSSHwVkIVfA07W3oM8Y7tf1Jehj7jlL7weMA
 5qMpRGiB4gyxvZVGaWPaZ2bnsn7kAyfohWnJDUHbxIyJyAa2uEBpd0tsgoM/lIlJjRUEyYrnDJl
 UokeamDV6Upk/Szt3BlB0b7bwuZQ7OZ/S94DGZzYezdHwGr+2YWsQzgrW0J1BqYYRz+FLsYlljm
 ZqrZV6XjR3htMlpzeIe/m5nS4vhgr/heFuzddJJ0uv
X-Gm-Gg: ASbGncvutaqs0EEV2J8ywWPI0pJRyM7zZixK03rLd/RJ7QVHWPw3vGrEjuH82B8CY+5
 CEtHal5tOqphHzMrVk/ywxaBQDUySghXT6F6oWMxqdODfqs7ojhPUzNACJ/Gz8BL8l+0XA4KIjk
 +4xFesYhkzTmTJs0YflzvmPAgqNONSKqVtgnDUsuLUl/86ySmljtWnAfGOypcLvYdrHC0jaSpVA
 3sH97wNt5Pihn04up7oNY0/rl/CGX+JDYbBR3AdpvDjNLITiBdXMOtZsUF0Eb6ONPaN/5T1R98b
 w0DwiQ8pRC3ZOA/QoB9/D0BimIUtgqRB2Dwu+sR0mT/ZqhD92e69gcj4MVzSJEK487/ZUXJzoJS
 oAnao+j9opqLIIw==
X-Google-Smtp-Source: AGHT+IG5eAmpHJec2s7kapxyVgpzkGEG3qBtC1syrf3cIEk3WOtmMEpw2qNU2xXprjJ62suK/qr9Kw==
X-Received: by 2002:a05:6a00:2d8e:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-739e71439cfmr24221199b3a.24.1744108790449; 
 Tue, 08 Apr 2025 03:39:50 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:39:50 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 00/10] Fix RVV encoding corner cases
Date: Tue,  8 Apr 2025 18:39:28 +0800
Message-ID: <20250408103938.3623486-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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

This patch series fixes several corner cases of RISC-V vector
instruction's encoding constraints.

This v3 series addresses:
- Merge v2 patches (3 & 4, 9 & 10)
- Remove extra blank line in v2 patch 5
- Remove redundant co-authored-by tags

Thank for Daniel Henrique Barboza's suggestions and review.

Anton Blanchard (2):
  target/riscv: rvv: Source vector registers cannot overlap mask
    register
  target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS

Max Chou (8):
  target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions
    to check mismatched input EEWs encoding constraint
  target/riscv: rvv: Apply vext_check_input_eew to
    OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
  target/riscv: rvv: Apply vext_check_input_eew to
    OPIVV/OPFVV(vext_check_sss) instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector slide
    instructions(OPIVI/OPIVX)
  target/riscv: rvv: Apply vext_check_input_eew to vector integer
    extension instructions(OPMVV)
  target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen
    instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector indexed
    load/store instructions
  target/riscv: Fix the rvv reserved encoding of unmasked instructions

 target/riscv/insn32.decode                 |  18 +--
 target/riscv/insn_trans/trans_rvbf16.c.inc |   9 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 166 +++++++++++++++++----
 3 files changed, 153 insertions(+), 40 deletions(-)

-- 
2.43.0


