Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF52C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8HS-0006sI-AO; Fri, 10 Jul 2026 06:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wi8HQ-0006s3-G2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:16:24 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wi8HP-0006Oz-6X
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:16:24 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c0c70.dip0.t-ipconnect.de
 [62.156.12.112])
 by linux.microsoft.com (Postfix) with ESMTPSA id 935A120B716E;
 Fri, 10 Jul 2026 03:16:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 935A120B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783678576;
 bh=VWQQm8vY6vkKwijEQUIN0sG/z6alwTBab0Y7LEX90Ek=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DXrghXxGGn8OX7QKTG6AYHX5EqgGyS4zlYGH8iCco6+cK75UdCfjdsSuRgj2PItQw
 Zq08mRKuwy5nM5enjm9hpCldW/jzpxZ+Ya40sqYHkg/HOow8+Sa7Eelkp2QtX/jiwI
 ESEYwQF+Bf/4AbVSUc67+BSk6ozC/UCWnEMa1vHQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH 12/12] hw/i386/mshv: drop initial msi vector 0
Date: Fri, 10 Jul 2026 12:15:34 +0200
Message-Id: <20260710101534.664604-13-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

This has been a warning before that was always raised if the machine has
a hpet. hpet_reset() will eventually result in mshv_send_msi called w/
vector 0, which we can safely drop.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hw/i386/mshv/apic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/mshv/apic.c b/hw/i386/mshv/apic.c
index 9188a93b2f..ad326030bf 100644
--- a/hw/i386/mshv/apic.c
+++ b/hw/i386/mshv/apic.c
@@ -293,6 +293,16 @@ static void mshv_send_msi(MSIMessage *msi)
     delivery     = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) &
                    MSI_DATA_DELIVERY_MODE_MASK;
 
+    /*
+     * Vector 0 is not a valid interrupt vector (0-15 are reserved for CPU
+     * exceptions). This can trigger during machine reset, if hpet_reset()
+     * forces the PIT to pulse GSI 2 before IOAPIC's own reset has masked its
+     * redirection entries.
+     */
+    if (vector == 0) {
+        return;
+    }
+
     mshv_request_interrupt(mshv_state, delivery, vector, dest, dest_mode,
                            trigger_mode);
 }
-- 
2.34.1


