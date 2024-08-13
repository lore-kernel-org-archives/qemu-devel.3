Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44178C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpoC-0002St-Mj; Tue, 13 Aug 2024 07:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpo9-0002Rz-VA; Tue, 13 Aug 2024 07:35:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sdpo4-0002RY-Q2; Tue, 13 Aug 2024 07:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1723548906; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=y7XdrJfJqpNiKpkU6+BzxPgwYczxMgBIcHima2k6tZ4=;
 b=GdwDkZN4PwLL5hhdr7utDjM0QiQKqunjTCixrQUNMneak0JGoO7zMUa353ev+OliH/pQXBocdYLWj5ZpXCqzwfAPJb3iqY4FvNQhmPRaf+tQvB7fSuWnsEsUXvKpL+qLn79uePbITMQ9pHR9EWotTNSxN9bDCLVNBzlZUCrbBG8=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WCoyZsd_1723548903) by smtp.aliyun-inc.com;
 Tue, 13 Aug 2024 19:35:05 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v1 00/15] tcg/riscv: Add support for vector
Date: Tue, 13 Aug 2024 19:34:21 +0800
Message-Id: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

This patch set introduces support for the RISC-V vector extension
in TCG backend for RISC-V targets.

Key features of this patch series include:
  1. Improved register allocation constraints for vector registers.
  2. Implementation of vset{i}vli instructions for vector configuration
     and support for variable-length vector registers and LMUL-based
     register grouping.
  3. Expanded cmp_vec to align TCG's cmp_vec behavior.

We tested the correctness and the acceleration efficiency of vector
instructions for this patch set. Conduct testing using the
CanMV K230 V1.1 development board in an Ubuntu 23 environment.

* Correctness:
Using risu, we generated 200,000 vector instructions for aarch64 and
tested them on the board K230, which supports RISC-V vector 1.0.
The K230 board runs Ubuntu 23, operating a statically compiled user-mode
qemu-aarch64. We ran risu's master mode with a vector backend qemu and
apprentice mode with a non-vector backend qemu. 

```
apprentice:
$ time qemu-aarch64-release --novec arm64_risu/risu --host=localhost arm64_risu/aarch64sve_20w

master:
$ script -c "time qemu-aarch64-release arm64_risu/risu --master arm64_risu/aarch64sve_20w" risu_test.log
Script started, output log file is 'risu_test.log'.
loading test image arm64_risu/aarch64sve_20w...
master port 9191
master: waiting for connection on port 9191...
starting master image at 0x3fc6df1000
starting image
match status...
match!
scalar_cnt = 50447787
vec_cnt = 786345
All cnts = 51234132
Percent vector: 1.53%

RISC-V Vector backend stat:
INDEX_op_mov_vec counts: 503
INDEX_op_dup_vec counts: 9989
INDEX_op_ld_vec counts: 27728
INDEX_op_st_vec counts: 272810
INDEX_op_dupm_vec counts: 263
INDEX_op_add_vec counts: 4842
INDEX_op_sub_vec counts: 2993
INDEX_op_mul_vec counts: 677
INDEX_op_neg_vec counts: 968
INDEX_op_ssadd_vec counts: 223
INDEX_op_usadd_vec counts: 229
INDEX_op_sssub_vec counts: 226
INDEX_op_ussub_vec counts: 265
INDEX_op_smin_vec counts: 650
INDEX_op_umin_vec counts: 1134
INDEX_op_smax_vec counts: 908
INDEX_op_umax_vec counts: 625
INDEX_op_and_vec counts: 8053
INDEX_op_or_vec counts: 4520
INDEX_op_xor_vec counts: 2177
INDEX_op_not_vec counts: 2639
INDEX_op_shli_vec counts: 947
INDEX_op_shri_vec counts: 3769
INDEX_op_sari_vec counts: 2130
INDEX_op_rotli_vec counts: 558
INDEX_op_shls_vec counts: 211
INDEX_op_shrs_vec counts: 779
INDEX_op_sars_vec counts: 162
INDEX_op_rotls_vec counts: 0
INDEX_op_shlv_vec counts: 482
INDEX_op_shrv_vec counts: 229
INDEX_op_sarv_vec counts: 253
INDEX_op_rotlv_vec counts: 0
INDEX_op_rotrv_vec counts: 0
INDEX_op_cmp_vec counts: 3211
INDEX_op_rvv_cmpcond_vec counts: 3211
INDEX_op_rvv_merge_vec counts: 3211
INDEX_op_rvv_shli_vec counts: 736
INDEX_op_rvv_shri_vec counts: 2990
INDEX_op_rvv_sari_vec counts: 1968

real    27m55.049s
user    8m0.284s
sys     1m28.278s
Script done.
```
Note:
The test results are as follows: the qemu frontend of aarch64 did not
use rotls_vec, rotlv_vec, or rotrv_vec, so their generation count in
the test results is 0.

* Vector Acceleration Efficiency: 
We used the opencv_perf_core test program, which has been vectorized and
optimized with O3 compilation. The tests were conducted on the k230 board
running opencv_perf_core via qemu-aarch64. 

The result is below:
```
$ time ./qemu-aarch64 ./opencv_test/opencv_perf_core --gtest_filter="*UMatTest*" --perf_force_samples=50 --perf_min_samples=50
Time compensation is 0
TEST: Skip tests with tags: 'mem_6gb', 'verylong'
CTEST_FULL_OUTPUT
OpenCV version: 4.5.4-dev
OpenCV VCS version: 6a00483e71-dirty
Build type: Release
Compiler: /mnt/rtos_nfs_new/xujf/arm-tools/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin/aarch64-linux-gnu-g++  (ver 10.2.1)
CPU features: NEON FP16
Note: Google Test filter = *UMatTest*
[==========] Running 12 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 12 tests from OCL_UMatTest_CustomPtr
...
[----------] Global test environment tear-down
[==========] 12 tests from 1 test case ran. (274624 ms total)
[  PASSED  ] 12 tests.
scalar_cnt = 1599444
vec_cnt = 7544
All cnts = 1606988

RISC-V Vector backend stat:
INDEX_op_ld_vec counts: 95
INDEX_op_st_vec counts: 3679
INDEX_op_dupm_vec counts: 2
INDEX_op_add_vec counts: 10
INDEX_op_ssadd_vec counts: 0
INDEX_op_usadd_vec counts: 4
INDEX_op_and_vec counts: 24
INDEX_op_or_vec counts: 17
INDEX_op_xor_vec counts: 4
INDEX_op_cmp_vec counts: 28
INDEX_op_rvv_cmpcond_vec counts: 28
INDEX_op_rvv_merge_vec counts: 28
real    5m37.402s
user    5m36.656s
sys     0m0.588s

$ time ./qemu-aarch64 -novec ./opencv_test/opencv_perf_core --gtest_filter="*UMatTest*" --perf_force_samples=50 --perf_min_samples=50
Time compensation is 0
TEST: Skip tests with tags: 'mem_6gb', 'verylong'
CTEST_FULL_OUTPUT
OpenCV version: 4.5.4-dev
OpenCV VCS version: 6a00483e71-dirty
Build type: Release
Compiler: /mnt/rtos_nfs_new/xujf/arm-tools/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin/aarch64-linux-gnu-g++  (ver 10.2.1)
CPU features: NEON FP16
Note: Google Test filter = *UMatTest*
[==========] Running 12 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 12 tests from OCL_UMatTest_CustomPtr
...
[----------] Global test environment tear-down
[==========] 12 tests from 1 test case ran. (539970 ms total)
[  PASSED  ] 12 tests.
scalar_cnt = 1598291
vec_cnt = 0
All cnts = 1598291

real    10m4.760s
user    10m3.690s
sys     0m0.824s
```

Using qemu run times, the acceleration ratio is calculated as
(10*60+3)/(5*60+36) = 1.79, indicating a speed improvement of 44%.

And the argument "-novec" is not included in this set, as we only use it for local testing.

Swung0x48 (1):
  tcg/riscv: Add basic support for vector

TANG Tiancheng (14):
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/op-gvec: Fix iteration step in 32-bit operation
  tcg: Fix register allocation constraints
  tcg/riscv: Add riscv vset{i}vli support
  tcg/riscv: Implement vector load/store
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp ops
  tcg/riscv: Implement vector not/neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shs/v ops
  tcg/riscv: Implement vector roti/v/x shi ops
  tcg/riscv: Enable vector TCG host-native

 host/include/riscv/host/cpuinfo.h |   1 +
 tcg/riscv/tcg-target-con-set.h    |   7 +
 tcg/riscv/tcg-target-con-str.h    |   2 +
 tcg/riscv/tcg-target.c.inc        | 839 ++++++++++++++++++++++++++++--
 tcg/riscv/tcg-target.h            |  82 +--
 tcg/riscv/tcg-target.opc.h        |  18 +
 tcg/tcg-op-gvec.c                 |   2 +-
 tcg/tcg.c                         |  20 +-
 util/cpuinfo-riscv.c              |  20 +-
 9 files changed, 914 insertions(+), 77 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


