Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD606CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKXN-00034J-KM; Tue, 19 May 2026 09:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPKXK-0002lI-PA
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPKXI-00008E-VS
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779197464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16khiiboxEtagPZ7yiPX8BOR+daPNKuEG2RYsB0whyg=;
 b=WFwH0FiH7mwrsZ+kQUJWwDa94ffmbImX8enRuKEXiESHWZAIEMYYoxBFyt/Ppo2YzzrVAh
 ysO3wUfMwHPK6lAzMetTaR6MLmfnR15I5tq3Zg7ND7s8qVWur08n4BY1Axi02x03L+vvM+
 9p0xCeH0Go2uDUqV2KXlw0T898DGMow=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-pV_ITPC0P8CtW3NVtGMRNA-1; Tue,
 19 May 2026 09:31:00 -0400
X-MC-Unique: pV_ITPC0P8CtW3NVtGMRNA-1
X-Mimecast-MFC-AGG-ID: pV_ITPC0P8CtW3NVtGMRNA_1779197454
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F5411956065; Tue, 19 May 2026 13:30:54 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.49.207])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FE1E180034E; Tue, 19 May 2026 13:30:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Date: Tue, 19 May 2026 15:27:29 +0200
Message-ID: <20260519132905.145643-16-eric.auger@redhat.com>
In-Reply-To: <20260519132905.145643-1-eric.auger@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

KVM currently reports some bits as writable whereas they are
RES0 or RAZ. This is detected because the code attempts to
match those bits against a named field and this later does not
exist in target/arm/cpu-idregs.h.inc.

Let's silence warnings until those bits get fixed in the kernel.

This was observed with v7.1-rc4 kernel.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6373a66bbd..1688cc2106 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -405,6 +405,19 @@ static void get_sysreg_prop(Object *obj, Visitor *v,
     trace_get_sysreg_prop(name, value);
 }
 
+static bool ignore_unnamed_writable_field(ARM64SysReg *reg, int i)
+{
+    if ((!strcmp(reg->name, "ID_ISAR0_EL1") && i >= 28 && i <= 31) || /* RES0 */
+        (!strcmp(reg->name, "ID_ISAR5_EL1") && i >= 20 && i <= 23) || /* RES0 */
+        (!strcmp(reg->name, "MVFR2_EL1") && i >= 8 && i <= 31) || /* RES0 */
+        (!strcmp(reg->name, "ID_PFR2_EL1") && i >= 12 && i <= 31) || /* RES0 */
+        (!strcmp(reg->name, "ID_MMFR5_EL1") && i >= 8 && i <= 31) || /* RES0 */
+        (!strcmp(reg->name, "ID_AA64FPFR0_EL1") && i >= 2 && i <= 7)) { /* RAZ */
+        return true;
+    }
+    return false;
+}
+
 /*
  * decode_idreg_writemap: Generate props for writable fields
  *
@@ -426,10 +439,12 @@ decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
         uint64_t mask;
 
         if (!field) {
-            warn_report("%s bit %d of %s is writable but no named field "
-                        "in target/arm/cpu-idregs.h.inc",
-                        __func__, i, reg->name);
-            warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
+            if (!ignore_unnamed_writable_field(reg, i)) {
+                warn_report("%s bit %d of %s is writable but no named field "
+                            "in target/arm/cpu-idregs.h.inc",
+                            __func__, i, reg->name);
+                warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
+            }
             map =  map & ~BIT_ULL(i);
             i = ctz64(map);
             continue;
-- 
2.53.0


