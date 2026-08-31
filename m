Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855B2C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17EU-0001Op-19; Mon, 31 Aug 2026 14:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17ES-0001OI-4c
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:48 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17EP-0000Am-ME
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:47 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-90c776f6c13so944486d6.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788202784; x=1788807584; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XGz8niZ6gXi+qB2ANR+FEUbgCy1MUBbubi45Fx5v+3g=;
 b=jJNq6nkAuxWeyanl7cT7qsITTfOoaoSDixdKEv3/60TlsV8t8RzJsr8gM9xOPbNbC2
 Qqfk9PAEOEPMRLlV6paS0avTziupuDxb62feYBtIGL7Gvl2tIrx3THdXb4nA3U0TYaSM
 SzMzstUK17IEQy2zeBNFpg/Mfhmzhh8Hezpy1DiqSB4TQm2VsEynI9+MIIr4z04hpwuv
 3slBukVip8Y6Qza2o5k/gP4fseO3Dd6rZneDZS2sYWHQUHKT4gudmSZ7hq5ciivDo1ar
 lxebIzrKjCDPqs9jGXR7hC/vGSkb6nJ9n8+RwN1O93um1NqUJM5K5Js8F9GZUsc76HUM
 5ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202784; x=1788807584;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XGz8niZ6gXi+qB2ANR+FEUbgCy1MUBbubi45Fx5v+3g=;
 b=dSo1foAxtRYhRIZLpSr6Tj6CoXEqjALhasWGQxapgg3BPgUH0kbH1ijCOwtcYh0FCD
 liFUt3+uUvPrQNOz3JnCoIynN4X1Ygd6Xum3caA1/sMBAqU6CJpepRjl6bGbJHs2i2mq
 Fpl5zCRe7DaJo3UNOlGvJ0ehpqWeEdWjqy6nx/ag/50zIkRICMgehNRiQ7mukFzIieTB
 6berRZ6xr2l2xhNa+SV+X96sxTvyScjdyyCHjWOlEwrN+OxBnEFPBxMsa60YWRMjSOxh
 7rMqJqjOvMEdnbfB9AJEciZ5WpAlSY1iYmgOrJLufwK1jEeXU09AWiKTk709u0KnTivV
 Et1w==
X-Gm-Message-State: AFuF++mngZ0hiTfuFuhgoP7qINWnBLlLfsWHHurmSuQUvU/De/dxKFAa
 9YcXh0pN5HKzzNAZFqAJ8aCpOlZ3CK+dCer2JtUmW+9Lzn9TtRiyeXVDrY2SDoGquUg=
X-Gm-Gg: AR+sD12EYZYd2YuORuOt0cjPgGfZad20dCnndu0M41uIAiAnWI4b+PA2a5iz+XzYBFQ
 GwxaDLRZLyOTTThmULqKhDw4hK2Mt1mPj0kZV3o/37AGg7EhzEtKYYjKNP/lV8aIu3p39mdoaK6
 6QpncHjHp8Fpuelh/oukGo6hchuSLMuAOCU7r4Wl8u7RQ5GuhHGnGiG81Q54xxKDUv8B02leGTT
 xJnX3OgfYuVDwEjb1RnFH2TppNiYHWGJA9bQs12dzTmQTyKq9l9Hcrp5GYLXs+4+qqSxzE//cGU
 Ai2hmKPOantRM6ZthoaAsItBXON9xlkG5bPfNLXjm59TUVebjgEedb2Og7vUI9+Oa0Cde9oSmHw
 Wtv8wgw/H3Fwn0cqNi5b07YE5QNgaUfdIepDeNKblS/9Q5kdt9vIv7iV8tCee8A63TJdO9loz1M
 XmwGC2MBLnlZFnQnNdcBhxrrxHROaANn0fWwL5eHCw8uDtk3sjbqTFKYK+Z0k8dZlFwewAyjyz
X-Received: by 2002:a05:6214:3199:b0:90a:7f54:2e47 with SMTP id
 6a1803df08f44-90ce0f6853bmr385883446d6.29.1788202783517; 
 Mon, 31 Aug 2026 11:59:43 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce44f5695sm90952986d6.26.2026.08.31.11.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:59:41 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/3] target: riscv: support TLB page flush for sfence.vma
Date: Mon, 31 Aug 2026 14:59:38 -0400
Message-Id: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrPlWoC/yXMQQqDMBBG4avIrBtwFFrbq5QSkvhHp4iVjIog3
 r2pXX6L93ZSJIHSo9gpYRWVz5jBl4JC78YORtpsqsrqWjY1myQaVjsP3k6ug43Dor1hdk0dccf
 NM+V0Soiyndvn629d/Bth/r3oOL7dakkseAAAAA==
X-Change-ID: 20260831-riscv_tlb_page_flush-11a83fe9e7b1
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf35.google.com
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

Introduce a new function, sfence_vma_allowed(), to handle
privilege/hypervisor checks currently performed in helper_tlb_flush(),
and make use of it in that function. Then, add helper_tlb_flush_page()
for flushing only a single TLB page, using sfence_vma_allowed() inside
it similarly to with helper_tlb_flush(). Finally, rework the
trans_sfence_vma() function to use helper_tlb_flush_page() when rs1 !=
0.

The third patch also includes the fix for a regression in the
'test_tuxrun.TuxRunRiscV64Test.test_riscv64_maxcpu' test encountered
with the draft version of this series, which hanged indefinitely until
killed when the patches were applied. This was fixed by making sure to
use get_address() to canonicalize the address being passed to
helper_tlb_flush_page().

make-check and make-functional were both run with the patches applied on
master, and no regressions for riscv64 were observed (beyond the one
mentioned as fixed above). 

Daniel Barboza helped me with initial triage, direction, and cleaning up
this series for submission - thanks again!

Some background context: as part of the RISE Project[1] mission to
improve the RISC-V software ecosystem, the Yocto Project[2] is receiving
assistance with triaging bugs and enhancing RISC-V support in the core
layer. The 'qemuriscv32' and 'qemuriscv64' targets were enabled as part
of the Yocto's CI system, known as the Autobuilder[3] in 2025, and since
that time various intermittent failures have been observed on the
'ptest' ('package test', where a package's test suites are bundled into
an image and then booted to do basic runtime compatibility testing)
case, 'qemuriscv64-ptest'. These almost always manifest as timeouts in
the guest, usually around heavier and/or more complex test cases, and
they additionally seem to occur only under heavy host system (x86_64)
load. 

Comparing to other major architectures like x86_64 and arm64, the
riscv64 guests are always emulated in TCG mode, since the Yocto
Autobuilder cluster does not (yet) have native riscv64 hosts to dedicate
for runtime testing with kvm support. While this is likely a major
factor in why qemuriscv64 runs fail at higher rates than other
architectures, it was noted after compiling the triage data[4] that
local comparisons of the same ptest images running on TCG-mode qemuarm64
and qemuriscv64 showed the latter taking significantly longer to
complete (using some of the test suites which have been observed failing
as examples), even with no other meaningful system load on the host. In
particular, the coreutils case showed over 70% longer runtime for
qemuriscv64 compared to qemuarm64 (~1000s vs ~580s).

Fully investigating the source of this discrepancy was a long process.
For Yocto builds, native QEMU binaries are built from source as part of
the overall image build, so the first place to look was in QEMU's
configuration and boot options. Other suggestions included trying to
disable TCG plugins or alter the QEMU and guest package configs (Yocto's
QEMU is RVA23S64 profile by default, while the runtime packages are
built for riscv64gc). However, these changes either produced no
meaningful effect or actually increased runtime. The next step was to
investigate the QEMU source, which is what ultimately led to this patch
series. It turns out that these changes significantly improve the
reference runtime test case for coreutils in Yocto, although it is still
somewhat slower than in qemuarm64. It remains to be seen whether these
changes to the QEMU source eliminate the intermittent issues in Yocto's
testing, but it is a meaningful improvement which opens the door to
further optimizations for RISC-V.

As an example, compare the before and after results on a local run of
core-image-ptest-coreutils for qemuriscv64:

|============================================================================
|Testsuite summary for GNU coreutils 9.11
|============================================================================
|# TOTAL: 733
|# PASS:  561
|# SKIP:  172
|# XFAIL: 0
|# FAIL:  0
|# XPASS: 0
|# ERROR: 0
|============================================================================
|make[1]: Leaving directory '/usr/lib/coreutils/ptest'
|DURATION: 1049
|END: /usr/lib/coreutils/ptest
|2026-08-31T17:23
|STOP: ptest-runner
|TOTAL: 1 FAIL: 0

versus:

|============================================================================
|Testsuite summary for GNU coreutils 9.11
|============================================================================
|# TOTAL: 733
|# PASS:  561
|# SKIP:  172
|# XFAIL: 0
|# FAIL:  0
|# XPASS: 0
|# ERROR: 0
|============================================================================
|make[1]: Leaving directory '/usr/lib/coreutils/ptest'
|DURATION: 646
|END: /usr/lib/coreutils/ptest
|2026-08-31T16:10
|STOP: ptest-runner
|TOTAL: 1 FAIL: 0
|root@qemuriscv64:~#

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

[1]: https://riseproject.dev/
[2]: https://www.yoctoproject.org/
[3]: https://autobuilder.yoctoproject.org/valkyrie/
[4]: https://docs.google.com/document/d/1HUk-RvMDdW2EKV-qE1VNfZBycPscQUsayEZ5AgJ85C8

---
Trevor Gamblin (3):
      target/riscv: extract sfence_vma_allowed() from helper_tlb_flush()
      target/riscv: add helper_tlb_flush_page()
      target/riscv: use a targeted TLB page flush for sfence.vma with a vaddr operand

 target/riscv/helper.h                              |  1 +
 target/riscv/tcg/insn_trans/trans_privileged.c.inc |  6 ++++-
 target/riscv/tcg/op_helper.c                       | 26 +++++++++++++++++-----
 3 files changed, 26 insertions(+), 7 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260831-riscv_tlb_page_flush-11a83fe9e7b1

Best regards,
--  
Trevor Gamblin <tgamblin@baylibre.com>


