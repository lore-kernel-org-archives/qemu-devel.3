Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A27C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ysg-0007ef-5n; Fri, 04 Sep 2026 14:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2Ysa-0007bT-3r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:14 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2YsX-0007F1-0m
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:11 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-90cc372d6b2so16943116d6.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788547387; x=1789152187; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v4bmJUEOgxrrJZU9J3darmlkBkvz3ZkB2+0//zGgDso=;
 b=c8tHnqfLaOsB15eJrw1buY4EpIW4rTixNqqCuZeJwkKHW8pCPD25uqzTMOX5WB2DyF
 MlCILkwhz/gsrqfvs0naI8nYV/8qJZJK6gKdY+vI5ho8ysmLp1oOWa9PAZBdkWvF028x
 La++gANsgl+kh+kJkXRzhsFvnln23vRv4AnJ40DET1Jc5WQei8Ht4HD6cjUDm2X/7IQR
 tCpYWudXY+bLgs/vKQG2qV33YbOY/6tRkPGCpwfV899mAf7CW0HRKgqfzqWyHVAhw7jv
 2TjxEWN6ljaLrZnoT7ELW+nwFg1lt+b9oxteUUle+hO54Ik8Fs1YmIJsNFpyKcCUOgye
 BWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788547387; x=1789152187;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v4bmJUEOgxrrJZU9J3darmlkBkvz3ZkB2+0//zGgDso=;
 b=Dzc3GDv+ONclrfpnxARB76i79DoYiaomE7kfJ6+gQyyncnBzYH1v75/aVP/uEedg9N
 6LAwXgG6db2lrIEGlYmQDcorYcNismpmNU/gqcriTRFkf0tg28YbLgizybT6rvhdCO8e
 TnBiN7ZArYqopCPt1suRRiLP4R0F+T6k6jut0Q5FsyMGEIUdMm6gbwnwoaADqKZN4bfo
 a7HEeSt5RUZG99UGN2KvZYsraTEusK4nFJ2l5djRmMHTtY1yDvuSapClgdrn1E3pkg7h
 ysM9CjbQfbfhpblgEk8eygV6aODhIjhhisp3ss2xCFK3Th/4krFQ2FqPV1JFE4aQy01l
 AFDg==
X-Gm-Message-State: AFuF++mVqjHtWD9f5N4XcKaHz5kQmZV9q2ZxVsVuzWkqTpjhsfLvp/hd
 AXrQc0xG1/ZOLrZgWioXaodhwCwxWIgM9TMr0ptqMxXkuE9cSyheTbBi2GWEpmXmb7c=
X-Gm-Gg: AYBFou0Dn6motYst6rtMopuqMPlRZl74Cy8nWOzK2f4cPWRsr39AqjjiG0s0hmhy0A6
 6wIwbog+dBhSXXsbSE5WYsGDI+ShO9c+avQqeSiyezYX7s8+yn5winXVsvDGERY65jw91ixi40W
 pzcqCS7mLGMHcM37Hd9wwOm/wifzLsjCFHBpGacG5T+/P3hIZI8HKBmr3igCWL60FESIgUqFyai
 6OloO888ub70IFPoKvrbzW+rEhuN1WMXBuCMLKpklnoEn/MWNufgjLqO1+tQH4UvPuIH7UotSWd
 6PtBlHDsluYHJt1vWnrdRRaHkRp0TE36qGqoA4gUL5IZWeH1CBn+FlSDYT9rxGQ+WV3EA9MTSoZ
 +F2qKThGP0ZeQvSYC7HMtO6NonS23VdwNSs3eX6XJe2aIuddjNSJ/223iXBYvHtjLIeDJFTXgW8
 dqV0LvkqKgZcatvk2NXEQMofaCtb7DmWQ+fTTJEZ/CzRUoAC/e1zK4z1ULI6reAF3ptRuTMakY
X-Received: by 2002:a05:620a:995:b0:939:7ea5:de2b with SMTP id
 af79cd13be357-939803118f6mr603690585a.2.1788547386530; 
 Fri, 04 Sep 2026 11:43:06 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb36129sm277111985a.19.2026.09.04.11.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:43:05 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
Date: Fri, 04 Sep 2026 14:43:03 -0400
Message-Id: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcRm2oC/4WNWw6CMBBFt0Lm2xoKysMv92EIaesUxiAlHWgkh
 L0LuAA/T3LuuQswekKGW7SAx0BMrt8gOUVgWtU3KOi5MSRxksVFKoUnNqEeO10PqsHadhO3Qkp
 VpBZLzLWEbTp4tPQ5so/qxzzpF5pxb+1GSzw6Px+/Qe7en4sgRSwu1mTKltcsT9Vdq7kj7fFs3
 BuqdV2/4aSN1s0AAAA=
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf31.google.com
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

Introduce a new function, check_sfence_vma(), to handle
privilege/hypervisor checks currently performed in helper_tlb_flush(),
and make use of it in that function. Then, add helper_tlb_flush_page()
for flushing only a single TLB page, using check_sfence_vma() inside it
similarly to helper_tlb_flush(). Finally, rework the trans_sfence_vma()
function to use helper_tlb_flush_page() when rs1 != 0.

The second patch also includes the fix for a regression in the
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
Changes in v2:
- Renamed sfence_vma_allowed() to check_sfence_vma()
- Squashed patches 2 and 3 together
- Reworked check_sfence_vma() and helpers using it to be consistent with
  rest of codebase (e.g. no unnecessary returns)
- Adjusted cover letter to match check_sfence_vma() naming
- Link to v1: https://lore.kernel.org/qemu-devel/20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com

To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org

---
Trevor Gamblin (2):
      target/riscv: extract check_sfence_vma() from helper_tlb_flush()
      target/riscv: add helper_tlb_flush_page(), use for sfence.vma with vaddr operand

 target/riscv/helper.h                              |  1 +
 target/riscv/tcg/insn_trans/trans_privileged.c.inc |  6 +++++-
 target/riscv/tcg/op_helper.c                       | 22 ++++++++++++++++------
 3 files changed, 22 insertions(+), 7 deletions(-)
---
base-commit: c513597761d6fc06690b5b7cf10dfb7ab05815d0
change-id: 20260831-riscv_tlb_page_flush-11a83fe9e7b1

Best regards,
--  
Trevor Gamblin <tgamblin@baylibre.com>


