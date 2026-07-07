Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFB8C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5OR-0006ie-Ep; Tue, 07 Jul 2026 08:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OP-0006e3-Ju
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5ON-00079v-R6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cP38TrfseWfxNY2kprSWcDunP7+jEtM4OABSvDAZxdM=;
 b=fNuc0lSrBEiu100U6lpA3Z8Ggji+Lqy4jSMRWjrnUnDFt1eaQquw3DyR6hcUXX2LQ1hyGi
 Y78pA7j8K9qW9AjlQi21nDoJvEJbJnggtLqLDqvBkelpEqdWbr9PA+V0HlCh1MyYBUp0Qq
 SKBiQkw+wDL0imv54xM27ibdQoQ4wC4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-oVJ7E3IHNJWgLGRlnP-74g-1; Tue,
 07 Jul 2026 08:59:12 -0400
X-MC-Unique: oVJ7E3IHNJWgLGRlnP-74g-1
X-Mimecast-MFC-AGG-ID: oVJ7E3IHNJWgLGRlnP-74g_1783429151
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E350B19540C9; Tue,  7 Jul 2026 12:59:10 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6922A1956040; Tue,  7 Jul 2026 12:59:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 08/15] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Date: Tue,  7 Jul 2026 14:58:40 +0200
Message-ID: <20260707125847.1785168-9-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

Allow propagation of the ASTFLEIE2 feature bit.

If the host does have the ASTFLE Interpretive Execution Facility 2 the
guest can enable the ASTFLE format 2 for its guests.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20260701-astfleie2-v3-2-f692dc7f4f24@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 4 +++-
 target/s390x/cpu_features.c         | 3 +++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 1 +
 target/s390x/kvm/kvm.c              | 1 +
 8 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index b9c3983df195..2d2cde7803ff 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -146,6 +146,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
         s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
                             &read_info->fac134);
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC139,
+                            &read_info->fac139);
     }
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index ddc61f1c2148..e1f9b0f6bc10 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -136,7 +136,9 @@ typedef struct ReadInfo {
     uint32_t hmfai;
     uint8_t  _reserved7[134 - 128];     /* 128-133 */
     uint8_t  fac134;
-    uint8_t  _reserved8[144 - 135];     /* 135-143 */
+    uint8_t  _reserved8[139 - 135];     /* 135-138 */
+    uint8_t  fac139;
+    uint8_t  _reserved9[144 - 140];     /* 140-143 */
     struct CPUEntry entries[];
     /*
      * When the Extended-Length SCCB (ELS) feature is enabled the
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 4b5be6798ef5..896914888aa9 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -148,6 +148,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_SCLP_FAC134:
         clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
         break;
+    case S390_FEAT_TYPE_SCLP_FAC139:
+        clear_be_bit(s390_feat_def(S390_FEAT_SIE_ASTFLEIE2)->bit, data);
+        break;
     default:
         return;
     }
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5635839d0329..52a82da751ec 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -24,6 +24,7 @@ typedef enum {
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
     S390_FEAT_TYPE_SCLP_FAC134,
+    S390_FEAT_TYPE_SCLP_FAC139,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index c017bffcdc4d..a822f0f2fe99 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -139,6 +139,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
 
+/* Features exposed via SCLP SCCB Facilities byte 139 (bit numbers relative to byte-139) */
+DEF_FEAT(SIE_ASTFLEIE2, "astfleie2", SCLP_FAC139, 1, "SIE: ASTFLE interpretation execution facility 2")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 0b88868289bf..2dd9aac8078c 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -263,6 +263,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
+        case S390_FEAT_SIE_ASTFLEIE2:
             return false;
             break;
         default:
@@ -553,6 +554,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8218e6470ec9..a309dc2c09ab 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -720,6 +720,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_PAIE,
     S390_FEAT_UV_FEAT_AP,
     S390_FEAT_UV_FEAT_AP_INTR,
+    S390_FEAT_SIE_ASTFLEIE2,
 };
 
 static uint16_t full_GEN17_GA1[] = {
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index fdef8f9e8acc..9af2a397f5a2 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2288,6 +2288,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_ASTFLEIE2, S390_FEAT_SIE_ASTFLEIE2 },
 };
 
 static int query_cpu_feat(S390FeatBitmap features)
-- 
2.54.0


