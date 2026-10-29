Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47329606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=McxKnpgV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDK-0002Lm-Ke; Thu, 29 Oct 2026 13:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qA-6G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bb-Mf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxbD1619559; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dHXdnUWdn4s
 D5Bqg7NF8jO7PF1p+lUpXl2uZR8riZno=; b=McxKnpgVkyYIsekbzhUSZE6oTHq
 bIhJBFhDLVWGUW/+39nB/HdGfuxLT80C2L7UKqD0VTyMW35a0jBzhfQiZLEPAFCP
 336OpEXvufBPdo1grCGe0ND7UDWGKXIvvWyH8aRIHv8/PN18/ojYICV+f+hYO2Ho
 uEbomQNSRXyErUSulKxePCrzwoM7PMeSXeP89f38+ulAqxYLqMtMayvExhU9OXWC
 1UYujLjk0OP+EGJwk+OAdZruYdXzCH/mr9XrtCPDhIygOF4ZI5Huyo4JRH2ZyQtD
 FafNzqZv+EQUQcrjfcNDl+/9iQG/J0lqlffvj75YAdvpsOdXuVZMBV8snOg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9wuw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEwd2549258; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiEjW2549242
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id A3CCB2583E; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 12/20] target/hexagon: add HLX packet slot and resource checks
Date: Thu, 29 Oct 2026 10:44:05 -0700
Message-ID: <20261029174413.643130-13-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2mub47UZekyq
 HE78MIVQyVhBdw/OR1xP7h92woRd+G4w4t7Dq8JbiLgzeKaTJdybW6fK/XY+mOpeIP6aO+MtFz4
 oUSPUhWjOi0KydW80qiha4L/sXxVsDw=
X-Proofpoint-ORIG-GUID: A6pw2PJaBcwMQtDE0yo3stgIw24L49NH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXwwFTJqoF1iKA
 Hd1IphMDFSf9P7mrFoUSbFUey6GDJofOJQUEh1K39e+XPIxIKsgn8AkumpRRn42N5LYto7qa2Yl
 2zHLDb6YCBj7SAXXqM/1YQ8aBZ6ETmv6cyvh/h4PqNQ7i8X7haSisZP2b/cCR57ErJis4gQXxmb
 VzcRIKWiYygJ+ziYpuhE8SNGrAK7j2oudsoOe4AlFN6RcUX+gBNkF2OIRBTuHHTP/44V0lH0ag2
 6XE900YMGCQ5hhWanYOWZyZfrZxQVuSw3NogyLuSBrNSuDH0Wek9wXBXm5YqFhEMUHtlyidf8hm
 U14PY/3K82YwNWPHRM7bT8kf+jfey8gADVNZfwMlR0IyGvht6Sg0wJMF72szz5nmSlRXAKrpKqq
 y/V1FyMZnXmbnkflcxrZO00AYiawY0WzkTEgCfSR4QOKGOdCAh5IMaukscI9dURiXETIlSoJXIv
 Rnswt8vlqttiqws/glQ==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=h1MXg8X0kOsy87eJFU4A:9
X-Proofpoint-GUID: A6pw2PJaBcwMQtDE0yo3stgIw24L49NH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add HLX slot rules and reject packets that reuse an HLX resource.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hlx/decode_ext_hlx.c | 117 ++++++++++++++++++++++++++++
 target/hexagon/hlx/decode_ext_hlx.h |  14 ++++
 target/hexagon/meson.build          |   1 +
 3 files changed, 132 insertions(+)
 create mode 100644 target/hexagon/hlx/decode_ext_hlx.c
 create mode 100644 target/hexagon/hlx/decode_ext_hlx.h

diff --git a/target/hexagon/hlx/decode_ext_hlx.c b/target/hexagon/hlx/decode_ext_hlx.c
new file mode 100644
index 0000000000..cb7fc58d7d
--- /dev/null
+++ b/target/hexagon/hlx/decode_ext_hlx.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "decode.h"
+#include "opcodes.h"
+#include "insn.h"
+#include "iclass.h"
+#include "hlx/hlx.h"
+#include "hlx/decode_ext_hlx.h"
+
+typedef struct {
+    bool store;
+    bool load;
+    bool shift;
+    bool mpy;
+} hlx_pkt_resources_t;
+
+static bool check_hlx_slot_constraints(Packet *pkt, int slot, int insn_idx,
+                                       hlx_pkt_resources_t *resources)
+{
+    int opcode = pkt->insn[insn_idx].opcode;
+
+    if (slot == 0) {
+        if (!GET_ATTRIB(opcode, A_STORE)) {
+            return false;
+        }
+        if (resources->store) {
+            return false;
+        }
+        resources->store = true;
+    } else if (slot == 1) {
+        if (!GET_ATTRIB(opcode, A_LOAD)) {
+            return false;
+        }
+        if (resources->load) {
+            return false;
+        }
+        resources->load = true;
+    } else if (slot == 2) {
+        if (!GET_ATTRIB(opcode, A_HLX_SHIFT) &&
+            !GET_ATTRIB(opcode, A_HLX_COMMON_ALU)) {
+            return false;
+        }
+        if (resources->shift) {
+            return false;
+        }
+        resources->shift = true;
+    } else if (slot == 3) {
+        if (!GET_ATTRIB(opcode, A_HLX_MPY) &&
+            !GET_ATTRIB(opcode, A_HLX_COMMON_ALU)) {
+            return false;
+        }
+        if (resources->mpy) {
+            return false;
+        }
+        resources->mpy = true;
+    }
+
+    return true;
+}
+
+bool hlx_ext_decode_checks(Packet *pkt, bool disas_only)
+{
+    hlx_pkt_resources_t resources = {
+        .store = false,
+        .load = false,
+        .shift = false,
+        .mpy = false
+    };
+
+    /* Slots are assigned only for execution. */
+    if (disas_only) {
+        return true;
+    }
+
+    for (int i = 0; i < pkt->num_insns; i++) {
+        if (GET_ATTRIB(pkt->insn[i].opcode, A_HLX) &&
+            !check_hlx_slot_constraints(pkt, pkt->insn[i].slot, i,
+                                        &resources)) {
+            return false;
+        }
+    }
+    return true;
+}
+
+SlotMask hlx_ext_decode_find_iclass_slots(int opcode)
+{
+    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT0ONLY) ||
+        GET_ATTRIB(opcode, A_STORE)) {
+        return SLOTS_0;
+    }
+    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT1ONLY) ||
+        GET_ATTRIB(opcode, A_LOAD)) {
+        return SLOTS_1;
+    }
+    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT2ONLY) ||
+        GET_ATTRIB(opcode, A_HLX_SHIFT)) {
+        return SLOTS_2;
+    }
+    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT3ONLY) ||
+        GET_ATTRIB(opcode, A_HLX_MPY)) {
+        return SLOTS_3;
+    }
+    if (GET_ATTRIB(opcode, A_HLX_COMMON_ALU) ||
+        GET_ATTRIB(opcode, A_HLX_SLOT23)) {
+        return SLOTS_23;
+    }
+    if (GET_ATTRIB(opcode, A_HLX_ANY_RESOURCE)) {
+        return SLOTS_0123;
+    }
+
+    g_assert_not_reached();
+    return SLOTS_0123;
+}
diff --git a/target/hexagon/hlx/decode_ext_hlx.h b/target/hexagon/hlx/decode_ext_hlx.h
new file mode 100644
index 0000000000..7feecff6c1
--- /dev/null
+++ b/target/hexagon/hlx/decode_ext_hlx.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_DECODE_EXT_HLX_H
+#define HEXAGON_DECODE_EXT_HLX_H
+
+#include "insn.h"
+
+bool hlx_ext_decode_checks(Packet *pkt, bool disas_only);
+SlotMask hlx_ext_decode_find_iclass_slots(int opcode);
+
+#endif /* HEXAGON_DECODE_EXT_HLX_H */
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index fd4983343d..f9e820286e 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -265,6 +265,7 @@ hexagon_ss.add(files(
     'mmvec/system_ext_mmvec.c',
     'mmvec/hvx_ieee_fp.c',
     'mmvec/hvx_qfloat.c',
+    'hlx/decode_ext_hlx.c',
     'hlx_helper.c',
     'hlx_gvec_tables.c',
 ))
-- 
2.43.0


