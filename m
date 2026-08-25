Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE0C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR1-0000ih-01; Tue, 25 Aug 2026 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2r-0002rw-L2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:33 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2p-0002A6-OA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:33 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-39c7ef2b1e2so43386631fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667749; x=1788272549; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QlOL6w11SZqN4zPs4FHlz73H2V+m5Boo07QxnEbVRXo=;
 b=Btlgx5+JR8STvt9s0JGNHcJ8mc7Q9kop3riwOnwZoqzicWrp9MeG8ZvCj6DA2YrEv/
 KNfeACssGSFeHCod0TH2ycBIUPJ0e5Y4Gv0Ck4R5pH2yYaYEmPPwbhlIHDF1L0hRII4n
 m7kr1LTmo+7TmI8pJRsQKUnMGkW7+qMHHyxBfamL1gOMnzDZwNzL4sIHMMMlx09t/Gzl
 RnDcLycOwSONpqXY096CPo13q4hcPmKV7ZHjes1S/s2SQX3HJNjE8KSk8ySkrXcKBEfU
 aCTOLTOC//h2mT5U/VqI2wcHk0xBdheMMkQC0ub/Kl17TUk7eG2IDpuOIgzD0eeyduQ2
 V4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667749; x=1788272549;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QlOL6w11SZqN4zPs4FHlz73H2V+m5Boo07QxnEbVRXo=;
 b=gD6Cy7WfpH6AbBU6ZyZq00RKiGcQpn9Oj4XQvVnc0131guKzd6f9w6n1LF/ICoL1oH
 sbk2curSvZWmGYkuvF+sJGqlgWY5QtSaOCmAaWyBf9jmFhwXpKw/thIqxNtOBAZGQmsw
 LWnATrUVXskwoeEktF49c3DNX/cVpPZfy+OwvxLLYWLIqI4CWDCm3fgCjerlYSouyOm+
 SB2v4AxBoY5fg7wGpWF8lPi88/m2NWVWsifdp6a1jwLm09sBxaNas4dL6c3m0Xgtm004
 Z5F0+SOZakSDela2x46N6vyJNFycfB8PGoqkaYPXd3ggnMoG8xOCucW67CZ2gps/lfPT
 57Sg==
X-Gm-Message-State: AFuF++m47oTccNc8Uj2Qx04PgY1kLu7fltjmtuEZuqrW1RT/NGQpWnYb
 8zobi2mXhPQEQTiklLZYNhNi1PpTEZJEHVp3m39PLxw0qJXhP6JYQOpf
X-Gm-Gg: AR+sD10G0SI9m9qpnLZWbuVBmY/3+aqXUFlvNUz/nOpNvx6SUUsgAsHaITsCdpB2ZWu
 Lq6+dmFg9+J6FCN2osEzHqXT7ynATHiNuU4IR2JomFiAs15qZahb8H02K480/23fcDeBGA+TtR5
 V3GH9DYz+g4DeFfrqpKv/c6pR9PPCzuoLe/apKXTWi/FmJlarZK3niauijdYtdN7I7XYIDNm1iO
 GGAt0IEfbQetUkMT9KTGeZE3gU931bBPQtM9Mrm7ruCUKrmEvmE8HDX1pDaYhp8zo21rWqZLPBO
 V54goMmlu34dNU/7NyLlzmAwlllgAf1JO3uqlYadDyJhLItZC/XChRvN8YhiH8mWBlgvhKYp6G7
 CS99h817u5Z+7hUM0XbN/rAjwe/gOdli/bj7aO/qw7upiAqC1HuKcf8cL9Tuk0pgbeL2Img2+uE
 v+52+EFM6dLPlvPY+QKEI4CV/sOhRm/YHHCOmwdzzuf76kR0sxb/4OKtdxCWW/NaCTB+ewfUnoN
 XmQFSozVxD7BVUu7HFqXZ25w7lZ/A==
X-Received: by 2002:a05:651c:19a8:b0:39b:2ff8:64ae with SMTP id
 38308e7fff4ca-3a1aec1ab67mr82044231fa.9.1787667749123; 
 Tue, 25 Aug 2026 07:22:29 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:28 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Subject: [PATCH 00/13] hw/riscv, target/riscv: initial n-trace support
Date: Tue, 25 Aug 2026 17:22:24 +0300
Message-Id: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCljWoC/yXMQQ6CMBBG4auQWdukViTiVQwxpfzVMbGQmUJIC
 He36vJbvLeRQhhK12ojwcLKYyo4HioKT58eMDwUk7OusRd3NvOkWeDfJmXxAfcwCkzd9jG29ck
 2bqCSToLI62976/7WuX8h5O+L9v0DgISuUHgAAAA=
X-Change-ID: 20260825-upstream-ntrace_core-49bff943062d
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=AcsZmDfc3j2UIKqFGJFppydqsh1KdxDGDa+3aNV2TF4=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUiSo5cC3UIZp1To/bn2hGmWWDql6ME63Eoe
 0LbbsEPgFaJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIgAKCRBIiqVupVDe
 dsq5D/4yzPsSOISALQZckF2LPvUcuo5qU0TKTyMwifP3KA4F9T6/r526amufgC0bdpJpKYZiIfn
 S2fhAdjtffurHJScnPVwvHq27z5rR0hmw6aUcrIfCU9bFq4eV4RmynlPOgiBViCMDnP616bnx2b
 2A5MUd6VjHfxW1Q3xXUqcVujTfXlFbdhLoMBm4VoIsLIHVn8/cewX2itX27Y4zAecHbJ/H4eRPu
 WaUdR37WP7NqGhDRlTSMRIfs4UaU6lJzy2AuTa2BUH7+noAx+MADD+sSVuj/bQQ+oLfi9R8bYTg
 l+mHbZUJ7bfVENXlC2GDFA4PsrS72A3tiPwXHCfyL+kafoY8oZVN45rjoMuZTvzlnqhaXOpaPcL
 7cjFJMUlf/id4uNibx1i3xP+q4XzXfCErRjCrSYMG9I6MwnlDyxPjV5oCsHXir1wES/6OaSaURs
 OgqIrzcNbRdxTp+Goh6QUivJhUY/BYSMgQdfaxTlW0GJba+GqAXFMNDk9hXUIsY7vh6QKTPdJkr
 avg84WQcfHHapS3zo1jOoiStx2IltXfMvXV/CYIm8fYiNlNym+9Far6UqvCpgME+roKYic+ycIX
 PUcrklV0S09v5Xq1vbosBcTOJdE19QDa/JzZwdx9JqVIn1EnyX+J1Upc2DCmO7xcXAujvzLZxiE
 YANzzAYFuSjlPmA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Hi,

This series continues to implement RISC-V tracing subsystem.
This work implements RISC-V N-Trace (Nexus-based Trace) [1].

N-Trace is a different format for tracing (compared to E-Trace [2]),
and it is based on same underlying interface: RISC-V Trace Control
Interface Specification [3].

This is the first patchset of several upcoming patchset series,
that will ultimately provide full support for N-Trace HTM tracing.

A design decision was chosen to make the most of the existing
infrastructure of the trace subsystem.

Linux kernel driver support is available here:

https://lore.kernel.org/linux-riscv/20251002060732.100213-1-apatel@ventanamicro.com/

Patches based on Daniel's Efficient Trace patchset [4],
which provides support for Trace Control Interface and E-Trace messages
implementation.

[1] https://docs.riscv.org/reference/nexus-trace/_attachments/RISC-V-N-Trace.pdf
[2] https://docs.riscv.org/reference/e-trace/_attachments/riscv-trace-spec.pdf
[3] https://docs.riscv.org/reference/trace-control-interface/_attachments/RISC-V-Trace-Control-Interface.pdf
[4] https://lore.kernel.org/qemu-riscv/20251111114656.2285048-1-dbarboza@ventanamicro.com

Based-on: <20251111114656.2285048-1-dbarboza@ventanamicro.com>

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
Konstantin Semichastnov (13):
      hw/riscv/trace-encoder: add ntrace enable flag
      hw/riscv/trace-encoder.c: add trace ntrace/etrace selection logic
      hw/riscv: add n-trace encoder with ProgTraceSync message
      hw/riscv/trace-encoder.c: align ntrace messages with ones
      hw/riscv/trace_encoder, target/riscv: add trace pc history logic
      hw/riscv: add n-trace IndirectBranchHist rv-trace-message
      hw/riscv/trace-encoder: add interrupt support to N-Trace encoder
      hw/riscv: add n-trace ResourceFull rv-trace-message
      hw/riscv: add n-trace ProgTraceCorrelation rv-trace-message
      test/qtest/riscv-trace-test: add test-ntrace-simple qtest
      hw/riscv/trace-encoder.c: add remaining fields to trace-encoder
      hw/riscv/trace-encoder.c: remaining fields to ram-sink as RO values
      hw/riscv/trace-encoder: refactor register accesses

 disas/riscv.c                                  |   2 +-
 disas/riscv.h                                  |   2 +
 hw/riscv/rv-trace-messages.c                   | 265 ++++++++++++++++++++
 hw/riscv/rv-trace-messages.h                   |  10 +
 hw/riscv/trace-encoder.c                       | 332 +++++++++++++++++++++----
 hw/riscv/trace-encoder.h                       |  49 +++-
 hw/riscv/trace-ram-sink.c                      |  22 +-
 hw/riscv/trace-ram-sink.h                      |   1 +
 target/riscv/cpu_helper.c                      |  21 +-
 target/riscv/helper.h                          |   4 +-
 target/riscv/insn_trans/trans_privileged.c.inc |  10 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |  15 +-
 target/riscv/trace_helper.c                    |  23 +-
 target/riscv/translate.c                       |  19 +-
 tests/qtest/riscv-trace-test.c                 |  59 ++++-
 15 files changed, 734 insertions(+), 100 deletions(-)
---
base-commit: 6cedd046f606f155e054375c369bd606313e5f6c
change-id: 20260825-upstream-ntrace_core-49bff943062d

Best regards,
--  
Konstantin Semichastnov <antikostya2@gmail.com>


