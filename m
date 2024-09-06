Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DB6CE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 09:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVai-0006xs-1M; Fri, 06 Sep 2024 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smVag-0006vg-AD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smVae-0007LA-S9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725616155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zZmKeamd+Y/19a0xcCPMTTtszuGk8gYgyDInBKbgSg=;
 b=PrF/3nwh3ybUIAjB+CiT+IJbuDKzQUsKQ9dXal4jUbSv/ZNKaHEkwZ32m5cPO1VNrZ87iU
 9Tv+S58nPZx8tEAaK/qjESvDFOrwUO6TuEtjePAtj65vjyP4OxIHaS0FbEN6SinTRiRpoV
 qlFrBOQ/QeIXhfNY2jYHPAUPZVtmcto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-tpaBjKxQN1OVXkJXyPsC_Q-1; Fri,
 06 Sep 2024 05:49:09 -0400
X-MC-Unique: tpaBjKxQN1OVXkJXyPsC_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF4041955F2E; Fri,  6 Sep 2024 09:49:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 845BD300023D; Fri,  6 Sep 2024 09:49:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
Date: Fri,  6 Sep 2024 11:48:58 +0200
Message-ID: <20240906094858.718105-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If QEMU has been configured with "--without-default-devices", the build
is currently failing with:

 /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o:
  in function `riscv_cpu_do_interrupt':
 .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined
  reference to `do_common_semihosting'

We always want semihosting to be enabled if TCG is available, so change
the "imply" statements in the Kconfig file to "select", and make sure to
avoid calling into do_common_semihosting() if TCG is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use "select" in the Kconfig file, and "CONFIG_TCG" in the #ifdef

 target/riscv/cpu_helper.c | 2 ++
 target/riscv/Kconfig      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..dc147181a3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1674,10 +1674,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
+#ifdef CONFIG_TCG
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
             return;
+#endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index c332616d36..11bc09b414 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
-- 
2.46.0


