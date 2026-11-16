Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31A606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=km55dobW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3HL-0004I5-Ng; Mon, 16 Nov 2026 15:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HF-0003o8-NI; Mon, 16 Nov 2026 15:26:09 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HB-0006CO-IA; Mon, 16 Nov 2026 15:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=tQF2A7Yk+qw1bQYJ4Udl3FSsUJq1hKjNP6u4l6NwYjQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=km55dobW5ppQN2j1GYtWMmKIrieiWeu6iOv3YSUwWB8paLEusaafR5T+QRlFbm5x2
 2ubH+3cPdSfK9v1SeDMPLVhnA88QrxPOMastrACG+X0aSPCrt/kysKw0nv4d3Udmg8
 s6wklZAJDhDuCLxldPyHebYubJKka/blAQDIi1NkBFpYRR1Ku2WU2QDE5bvj1sbMSt
 puMJgmsawWdB6qHKejl1WMPAh/e3Co8LCGd6xDvPKjFz5XXyqG09Tq/7GL09qICcxc
 AJRQQXrUnCJiqmS6ZgMQaVrUHFrmjRRoK2bGYvDDIoA4A8vLVQA7XTEUWvtaOCwpXi
 E4gRiIz3ehUAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7820F1E7196;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 738B145FBC2;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6B0DCB8E48; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Collin L. Walling <walling@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 01/63] target/s390x: externalize feat dependency array
Date: Mon, 16 Nov 2026 23:24:40 +0300
Message-ID: <20261116202554.535325-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Collin Walling <walling@linux.ibm.com>

Move the feature dependency array (dep[][2]) from cpu_models.c to
cpu_features.c, rename the array to s390_feat_deps, and externalize
its length.

This will allow the array to be used between both files.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261009185559.144750-2-walling@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 349a5fa831b7e5c75281e3fb4e36923dc25c5954)
(Mjt: use actual contents of the dependency array in 11.1.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 896914888aa..f221dc6784e 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -216,6 +216,128 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
     };
 }
 
+const int s390_feat_deps[][2] = {
+    { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
+    { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
+    { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
+    { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
+    { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
+    { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
+    { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
+    { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
+    { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
+    { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
+    { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
+    { S390_FEAT_CMM_NT, S390_FEAT_CMM },
+    { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
+    { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
+    { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
+    { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+    { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+    { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_NNPA, S390_FEAT_VECTOR },
+    { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
+    { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
+    { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
+    { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
+    { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
+};
+
+const size_t s390_feat_deps_len = ARRAY_SIZE(s390_feat_deps);
+
 void s390_get_deprecated_features(S390FeatBitmap features)
 {
     static const int feats[] = {
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 52a82da751e..aba7ab80578 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -56,6 +56,10 @@ typedef struct {
     int bit;                /* bit within the feature type area (fixed) */
 } S390FeatDef;
 
+/* Tuple of features[][0] that depend on other features[][1] */
+extern const int s390_feat_deps[][2];
+extern const size_t s390_feat_deps_len;
+
 /* use ordinary bitmap operations to work with features */
 typedef unsigned long S390FeatBitmap[BITS_TO_LONGS(S390_FEAT_MAX)];
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2dd9aac8078..16c654967d0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -437,133 +437,14 @@ void s390_cpu_list(void)
 
 static void check_consistency(const S390CPUModel *model)
 {
-    static int dep[][2] = {
-        { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
-        { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
-        { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
-        { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
-        { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
-        { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
-        { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
-        { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
-        { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
-        { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
-        { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
-        { S390_FEAT_CMM_NT, S390_FEAT_CMM },
-        { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
-        { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
-        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
-        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
-        { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
-        { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_NNPA, S390_FEAT_VECTOR },
-        { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
-        { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
-        { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
-        { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
-        { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
-    };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(dep); i++) {
-        if (test_bit(dep[i][0], model->features) &&
-            !test_bit(dep[i][1], model->features)) {
+    for (i = 0; i < s390_feat_deps_len; i++) {
+        if (test_bit(s390_feat_deps[i][0], model->features) &&
+            !test_bit(s390_feat_deps[i][1], model->features)) {
             warn_report("\'%s\' requires \'%s\'.",
-                        s390_feat_def(dep[i][0])->name,
-                        s390_feat_def(dep[i][1])->name);
+                        s390_feat_def(s390_feat_deps[i][0])->name,
+                        s390_feat_def(s390_feat_deps[i][1])->name);
         }
     }
 }
-- 
2.47.3


