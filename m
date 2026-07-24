Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C5C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V7-0005DC-SO; Thu, 23 Jul 2026 20:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Ux-0004z6-QU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uv-0006Au-9G
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeIM21201913
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fhBk8IytR3C
 EIIJ4CAfFbWjAvmdS4YSZYbwibsbfG8A=; b=Zuzzkj+aSzQzLN41Z3eJt4KblW2
 4AnZ8uDf6zpcsmKbBTNEvzCHEspppmPmPCaJp8e9t82ZQVGRRqTJTpTCSD2fHXvw
 1sos1kaUaicgrsF3+tDpkSA9y7tKREFDg7SAP4qdKwo3TiStilyey6/l3aUMdE0g
 ss1UVmk2z8wlXsz8TV20qHz3h2/NqS7qYBZcY4s+h6qurv5hJcHBi255rBNRGujm
 ISS2VJ7JMtuNu+DJ+xXowJSGqnJz/Dd8VjIevnpC3B949VsPDDmXkJk/zFe6+2Zd
 pMSaoCoatuJZ5du/Dse5nOQQJ6Lk4uPozFvxAjY9GaAWFUOgIVt6jheF2Ug==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqams9wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso1698374a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851829; x=1785456629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fhBk8IytR3CEIIJ4CAfFbWjAvmdS4YSZYbwibsbfG8A=;
 b=K2x2cIU0Yq7mlQJK++DYoFe6Ha8ywzesT1nTgzv9ar0TrGVS6/kcOqTRA6z13GIdmw
 OYku9jlrxBQNeSM71spO8zXyd5Tx60s6YCir66T4UdHvAXOZLKunjH1gl19CZeS/NZKZ
 PEUvGQwwG1KGYMw2rPqogRUv1OLxNIaCUAvB6UKk82LTMUj4Pa5vNApd472MlYL+8215
 yhJYHsXbz1ehwJ7CEKmJ4ycaPJ6I7E+uFN1pY2MGyJZUYO1ZGkIJFAuS4osA0pN310sB
 FBHKj3unX8FxWQxukxakqxSslRV11FMeJMSVKqiyPUm1n9SLkC+x1jNgicfYAzhJqZGD
 n93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851829; x=1785456629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fhBk8IytR3CEIIJ4CAfFbWjAvmdS4YSZYbwibsbfG8A=;
 b=eG2Dfe+ITGn6ds9j0qdsa5iQHIQhcyHMS+b77ZzCSwRDmh+uvxQuTS01wXAV71+l8s
 3TBYdDouyf4SvpiQp1gyfgIjjNvnw1U4cc0fEFbBWf3kwDAKJEITpOt6gvzpHTGtSt+Y
 6I/e7cEKb3vWjBlzExG9DY60RN3WCsT8N5/zUClnvRQ+tHFlBG1zREm1JCXAg7lu138u
 9IyR/Y8/1HMxVbwcl+/vU+uM0KeavLS4mB0cmSoKMPx9fOU7m0IX4EX06SOPUJS2sGo+
 EDoTt+bE0QOek18rIIGeisXcDjmaxT+OCawLYn1S1uqPV/XdeeaoDt4P7bl3A3Uv0TTI
 s8SQ==
X-Gm-Message-State: AOJu0YwH97A5i2sWWf6sGK2mRw5eJjcYOzpj/Tc+DCV4Inhn1pSUmjQM
 j83M1hEE2pIFkC8xNKnif283GkrSvf6HDuc2WWWJvz6LOi3TzIN5TxGknjL4tyP+y7ubd9fwoYE
 1pCq6Le8Nuz2+/efKTi2Bfd/U+DVOQ8LFnCcY1FNUPCzs3PssPLXE5pyJS1mHleYjSQ==
X-Gm-Gg: AR+sD10bJU6XfUPBQ/RBCfIPM6bkzpYobio3fEImlj4xvWa3ogxrenuA6GAb1AOfeJr
 Qh3aET/z9Zwlb/vL660sdIIXivu+uBoZTKYbrHZqu5f7Bx7kogIdUa3fnY6pTz38YBfbnsA4Je7
 PspC3SF66d0Cli+U7Q865FYUS6mu9NMoYivQ2XlUn5rCB0hnL6WoUlPIxnDvNSXQECOmCLVoYm2
 sUzc9J/aZYTzN4DDQ26aU/4xz0GtVEkju9l9eVFOXYkmR/W7HnFgLBpJrHU+JBRbnUtiWtjUqsN
 cafIZGQ35KhQ6PfuMbTbeTaDd72ZL/9hZqKYZZDLHWQcSwQFN5s7w2IPGyXrcgtHhxo+nrN3Zs7
 /mQ9nidZXoLfTjhNx1JwiRJoG8M661dKx88+eUtnxAia94TKouqclDuy32BaXIOUWPIOxeK0=
X-Received: by 2002:a05:6a20:d10f:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3c44afde4c0mr5793913637.18.1784851829189; 
 Thu, 23 Jul 2026 17:10:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:d10f:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3c44afde4c0mr5793873637.18.1784851828750; 
 Thu, 23 Jul 2026 17:10:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:27 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 23/27] hw/riscv: remove {riscv32, riscv32_64,
 riscv64}_machine_interfaces
Date: Fri, 24 Jul 2026 00:09:43 +0000
Message-ID: <20260724000948.234657-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX492psaHUhGdv
 HQ/slzB4GOWXc7PsYDL3rJmhnDzENarIH/yr8FSbdq6XHtcLda9azXtSThF6eKKAirQG0T2dGn/
 +nxH9+aBBEGbVGA6vDbYGnPif6n/NQzCLLLrA7buKLfQCpdHjktD81ln1DQHOP/bW0rIvn+JXaK
 l8vz6bzamdWa4XRZzmCzLOOekQ1wrycb3gNwS7eJrNjtGq5O1su6FtCmthU/4/jHeeoZQLMBBcl
 YFqS7+fb8FBoBToo6HivalAFc0cPLDmYB04Nl2kk372jXCGfSrXeSHUEYq9r8E9pNjuMyuVwzW2
 OMWeHgnX6K2D/0E41w14EH4A1xam6FZ76gOgM5e5oLy2X7hbEBCw20m8TSA9dItbOn3TBRLOuHp
 kQ0xqj/+rm4c4P+RcbdCOHCP31hLwsYk/NLexGg7k5Skbx9+Nc0BFsDMaBMznyI7qF+DOVsm/Wv
 iK/nfE6qjiGcVNKVMFQ==
X-Proofpoint-GUID: ou84H6ssxZPBeC8cDN1t8ALNOFDL4QN8
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a62ad76 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mr8hG0Pkp8B8-MtDLVEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX1ZKofuuvcOEB
 rL8n5qK/u3rrvmsAwJizzA+0Wc26kMnYS6oNl/ATg9W24/KFnkUKwgkrsl33SijQRbBdhvetGxb
 LR3m1AiDPCvwCnhjZjehnidcwjaw0OY=
X-Proofpoint-ORIG-GUID: ou84H6ssxZPBeC8cDN1t8ALNOFDL4QN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From:  Pierrick Bouvier via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can now remove those arrays, and use type_target_specific instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/k230.c                 |  2 +-
 hw/riscv/microchip_pfsoc.c      |  2 +-
 hw/riscv/opentitan.c            |  2 +-
 hw/riscv/shakti_c.c             |  2 +-
 hw/riscv/sifive_e.c             |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/riscv/spike.c                |  2 +-
 hw/riscv/tt_atlantis.c          |  2 +-
 hw/riscv/xiangshan_kmh.c        |  2 +-
 include/hw/riscv/machines-qom.h | 15 +++------------
 target/riscv/machine.c          | 14 --------------
 11 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 0eb1bede222..631ea71c441 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -520,7 +520,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
-    .interfaces = riscv64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void k230_machine_init_register_types(void)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 520d1fd4d11..cd0c8ca5f36 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -757,7 +757,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
-    .interfaces = riscv64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 5c50b1c423d..0b3e02415ad 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -339,7 +339,7 @@ static const TypeInfo open_titan_types[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
-        .interfaces     = riscv32_machine_interfaces,
+        .interfaces     = type_target_specific,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 7556fd8c854..b59c4035929 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -99,7 +99,7 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
-    .interfaces = riscv64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void shakti_c_machine_type_info_register(void)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 657f6ecad25..5b5dc812b27 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -169,7 +169,7 @@ static const TypeInfo sifive_e_machine_typeinfo = {
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
-    .interfaces = riscv32_64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void sifive_e_machine_init_register_types(void)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 33f1af2cdf1..1fd752dfa2a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -680,7 +680,7 @@ static const TypeInfo sifive_u_machine_typeinfo = {
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
-    .interfaces = riscv32_64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void sifive_u_machine_init_register_types(void)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 1f706f4dcc1..450f5679110 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -292,7 +292,7 @@ static const TypeInfo spike_machine_typeinfo = {
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
-    .interfaces = riscv32_64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void spike_machine_init_register_types(void)
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index ceaa88d5238..896dfb1afde 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -610,7 +610,7 @@ static const TypeInfo tt_atlantis_types[] = {
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
-        .interfaces = riscv64_machine_interfaces,
+        .interfaces = type_target_specific,
     },
 };
 
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index d8ee1dfa15e..101b441a441 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -217,7 +217,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
-    .interfaces = riscv64_machine_interfaces,
+    .interfaces = type_target_specific,
 };
 
 static void xiangshan_kmh_machine_register_types(void)
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index 0f9f3b94eac..57da218d959 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -13,15 +13,6 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qom.h"
 
-/*
- * Interfaces specifying whether a given QOM object is available in
- * qemu-system-riscv32, qemu-system-riscv64, or both.
- */
-
-extern const InterfaceInfo riscv32_machine_interfaces[];
-extern const InterfaceInfo riscv64_machine_interfaces[];
-extern const InterfaceInfo riscv32_64_machine_interfaces[];
-
 /*
  * Helper macros for defining machines available in qemu-system-riscv32,
  * qemu-system-riscv64, or both.
@@ -29,14 +20,14 @@ extern const InterfaceInfo riscv32_64_machine_interfaces[];
 
 #define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv32_machine_interfaces)
+                                            type_target_specific)
 
 #define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv64_machine_interfaces)
+                                            type_target_specific)
 
 #define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            riscv32_64_machine_interfaces)
+                                            type_target_specific)
 
 #endif
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 484a3730ef4..555a1f3c881 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -536,17 +536,3 @@ const VMStateDescription vmstate_riscv_cpu = {
         NULL
     }
 };
-
-const InterfaceInfo riscv32_machine_interfaces[] = {
-    { TYPE_TARGET_SPECIFIC },
-    { }
-};
-
-const InterfaceInfo riscv64_machine_interfaces[] = {
-    { TYPE_TARGET_SPECIFIC },
-    { }
-};
-
-const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { }
-};
-- 
2.43.0


