Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA96CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSqk-00063Y-4E; Wed, 27 Mar 2024 08:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rpSqh-00060k-Ql; Wed, 27 Mar 2024 08:57:47 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rpSqf-0007Vg-Dj; Wed, 27 Mar 2024 08:57:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 09E2EC000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711544261;
 bh=igXJmAQBRIraB7SXsgsS6/LWmhtuqbDlP7Kfi3hiOhg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=a/TpLrqhTwvq5S7a+fC/8MxDQU0UMC3MLsOr6j7DmukAOf6QGyjDQOeiznduPX/eb
 9GSS98vUxf068MOvndslhBZtLfFmwrTStvY48BAsP4ElrqCx9d6b7JXwhmKW9f5m6k
 mK9PeIKFwq6ETNwYUFnYmBAg/0GYuFD0Ib30qBfOSuYOrKN/JwPDy3116bkXpu0Le8
 dMV51tzbVnI8QEXI/XzFzWEL2LyiPmYSqYTSQe4XTlyEDVJ4+6qB2uuupj8GlB8Vl1
 8J0eDX8pT3ShIpEPe+Kcr9ueZPBi/3Jn1hSTVgAV3ibU79FruAk3f2KwX+XXgPiNGg
 4Xq63ztsEtAKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711544261;
 bh=igXJmAQBRIraB7SXsgsS6/LWmhtuqbDlP7Kfi3hiOhg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=UxIg30cK/PhdGXdGnev2pOE4YJMGMUE//4F2sE0LdeR/FjEgbRN82/DdisTDiCNDV
 /Uq9K0vxO/rog7/9ex1o/gjxr0X9eLOcAmWYFOLR81xyzbkYumAypQjWr81Y2XwuzP
 lVuu/RW7qpT+VqLCo4YIvkKpZvM/tV4ke4la1avrc3WRCqU4s2RbAa0SGAz9VBkCA1
 9pt7LFksQlh5nx4tnjTbskE1Hk2JpuCg98DVWmQRvFmm1NIx18aFPX85Bfxu/vj1l/
 EqopWoYCwbVOGV1OzW5tKchqXXPWxxax5LwXOYE8vY5pSqodjjp+b4sWiadZAjUUvD
 T/U1ihMJ8jARQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <alistair23@gmail.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Wed, 27 Mar 2024 15:57:32 +0300
Message-ID: <20240327125732.11739-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKmqyKNkyxx9YV5ahb-VTO=4+mtu-1D2nMvyP6=-MpZ6KGXomw@mail.gmail.com>
References: <CAKmqyKNkyxx9YV5ahb-VTO=4+mtu-1D2nMvyP6=-MpZ6KGXomw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

kvm_riscv_handle_sbi() may return not supported return code to not trigger
qemu abort with vendor-specific sbi.

Added SBI related return code's defines.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes since v2:
        -Clear kvm_riscv_handle_sbi()
        -Add SBI_ERR_NO_SHMEM return code's define
 target/riscv/kvm/kvm-cpu.c         | 13 +++++--------
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..844942d9ba 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1392,7 +1392,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
 {
-    int ret = 0;
     unsigned char ch;
     switch (run->riscv_sbi.extension_id) {
     case SBI_EXT_0_1_CONSOLE_PUTCHAR:
@@ -1400,22 +1399,20 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
         break;
     case SBI_EXT_0_1_CONSOLE_GETCHAR:
-        ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
-        if (ret == sizeof(ch)) {
+        if (qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch)) == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         }
-        ret = 0;
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
+                      "%s: Unhandled SBI exit with extension-id %lu\n",
                       __func__, run->riscv_sbi.extension_id);
-        ret = -1;
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
         break;
     }
-    return ret;
+    return 0;
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 43899d08f6..a2e21d9b8c 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -69,4 +69,16 @@
 #define SBI_EXT_VENDOR_END              0x09FFFFFF
 /* clang-format on */
 
+/* SBI return error codes */
+#define SBI_SUCCESS                  0
+#define SBI_ERR_FAILURE             -1
+#define SBI_ERR_NOT_SUPPORTED       -2
+#define SBI_ERR_INVALID_PARAM       -3
+#define SBI_ERR_DENIED              -4
+#define SBI_ERR_INVALID_ADDRESS     -5
+#define SBI_ERR_ALREADY_AVAILABLE   -6
+#define SBI_ERR_ALREADY_STARTED     -7
+#define SBI_ERR_ALREADY_STOPPED     -8
+#define SBI_ERR_NO_SHMEM            -9
+
 #endif
-- 
2.34.1


