Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C62E9539E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnd06-0001tf-M5; Wed, 04 Feb 2026 08:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd05-0001sl-D3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd02-0005fR-4w
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR2fBcORYdmt1YPsf7yFFS0kUNSb0702Te0uJ25zGIo=;
 b=Jno1SCmo2e8MtkQZegN/PsE8AxhyxHWLKfAcUgZItS5qTz4WJ7YXsNTqggN0EQu+s/MaNj
 LIeyrMAfyrLPoj6MwpN8F7htpq+EroTSvbzRIGEqPqHhS5OzIle94UnshJ6ez0tQE8GYKf
 3Wmjk2SyzQ2dMdmOAYga4MiryIovP9w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-d7zoEFN8NiGZbBCnsVrEWQ-1; Wed,
 04 Feb 2026 08:32:51 -0500
X-MC-Unique: d7zoEFN8NiGZbBCnsVrEWQ-1
X-Mimecast-MFC-AGG-ID: d7zoEFN8NiGZbBCnsVrEWQ_1770211970
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39178195608A; Wed,  4 Feb 2026 13:32:50 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-192.str.redhat.com
 [10.33.192.192])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31CA41955D87; Wed,  4 Feb 2026 13:32:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 1/3] arm: handle demuxed ID registers
Date: Wed,  4 Feb 2026 14:32:27 +0100
Message-ID: <20260204133229.297061-2-cohuck@redhat.com>
In-Reply-To: <20260204133229.297061-1-cohuck@redhat.com>
References: <20260204133229.297061-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-sysregs.h | 13 +++++++++++++
 target/arm/cpu.h         | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a8e..911f54bc8a4f 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -35,6 +35,19 @@ typedef enum ARMSysRegs {
 
 #undef DEF
 
+/* ID registers that vary based upon another register */
+typedef enum ARMIDRegisterDemuxIdx {
+    NUM_ID_DEMUX_IDX,
+} ARMIDRegisterDemuxIdx;
+
+/*
+ * Number of register variants per demuxed register, trying to accommodate
+ * possible use cases.
+ * CCSIDR_EL1 currently needs 7*2, could be 7 more with FEAT_MTE2, in which
+ * case we would need to bump this number.
+ */
+#define ID_DEMUX_ARRAYLEN 16
+
 extern const uint32_t id_register_sysreg[NUM_ID_IDX];
 
 int get_sysreg_idx(ARMSysRegs sysreg);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 21fee5e840b7..f9d51c0fc187 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -906,6 +906,25 @@ typedef struct {
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
@@ -1084,6 +1103,7 @@ struct ArchCPU {
         uint32_t dbgdevid1;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
+        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][ID_DEMUX_ARRAYLEN];
     } isar;
     uint64_t midr;
     uint32_t revidr;
-- 
2.52.0


