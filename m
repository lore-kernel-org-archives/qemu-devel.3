Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDC8D29C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vht2b-00017B-LQ; Mon, 19 Jan 2026 12:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vht2Z-00011o-Qj
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vht2Y-000093-8s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768843665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9oUB9ONJfwCSwp9vRpulE30gQM7Lcw40drktSGZgXY=;
 b=ZBFkQ+LoCLu+INsnLWbvBXG8YGuUh40bMHz/cWzEp57pQ+nBLxV5I0tlKpp76cH16l+Tnv
 rffAufC9wJd8j0MWRmLUuYVRQ/OkUAayv3AB77vS5vqgyrusjuHnfiYp1MLwXoDKRZWNRI
 uuzJIrliSNcKFnPU2m6mNoVr4L9PpYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-aBfBevRMMbiJd-4kk6SmTA-1; Mon,
 19 Jan 2026 12:27:42 -0500
X-MC-Unique: aBfBevRMMbiJd-4kk6SmTA-1
X-Mimecast-MFC-AGG-ID: aBfBevRMMbiJd-4kk6SmTA_1768843661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13C5618003FD; Mon, 19 Jan 2026 17:27:41 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-210.str.redhat.com
 [10.33.192.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A85E819560A2; Mon, 19 Jan 2026 17:27:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 1/3] arm: handle demuxed ID registers
Date: Mon, 19 Jan 2026 18:27:30 +0100
Message-ID: <20260119172732.140613-2-cohuck@redhat.com>
In-Reply-To: <20260119172732.140613-1-cohuck@redhat.com>
References: <20260119172732.140613-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For some registers, we do not have a single ID register, but actually
an array of values (e.g. CCSIDR_EL1, where the actual value is
determined by whatever CSSELR_EL1 points to.) If we want to avoid
using a different way to handle registers like that for every
instance, we should provide some kind of infrastructure. Therefore,
add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
we already use for regular ID registers.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-sysregs.h |  5 +++++
 target/arm/cpu.h         | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a8e..31f82c6a0afc 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -35,6 +35,11 @@ typedef enum ARMSysRegs {
 
 #undef DEF
 
+/* ID registers that vary based upon another register */
+typedef enum ARMIDRegisterDemuxIdx {
+    NUM_ID_DEMUX_IDX,
+} ARMIDRegisterDemuxIdx;
+
 extern const uint32_t id_register_sysreg[NUM_ID_IDX];
 
 int get_sysreg_idx(ARMSysRegs sysreg);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08b7d3fb936a..f7bd19f26fbd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -905,6 +905,25 @@ typedef struct {
         i_->idregs[REG ## _EL1_IDX];                                    \
     })
 
+#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX] = VALUE;         \
+    })
+
+#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX];                 \
+    })
+
+#define COPY_IDREG_DEMUX(ISAR, REG, FROM_INDEX, TO_INDEX)               \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][TO_INDEX] =             \
+            i_->idregs_demux[REG ## _EL1_DEMUX_IDX][FROM_INDEX];        \
+    })
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -1083,6 +1102,7 @@ struct ArchCPU {
         uint32_t dbgdevid1;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
+        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][16];
     } isar;
     uint64_t midr;
     uint32_t revidr;
-- 
2.52.0


