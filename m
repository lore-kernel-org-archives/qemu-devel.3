Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9066BCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZts9-0000nm-Ri; Wed, 17 Jun 2026 13:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrv-0000gs-Qm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:16:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrt-0007A3-1D
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:16:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpISL3183584
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frllTOIREw6t9n6KjTsVt5BvKxKXWu4RRQZ/uSPHVqM=; b=hro8dLhPHC7sITHM
 fI1DKQ9jm1JqL86FbiqqvO4VyfYC7P+BbGMVqfNPfXcDhzBXUXx/h6bRyDrkECgt
 AQdEba7s9uiQQ4SQqZpCIZNpJx9Ot7X22yOdfi41QmQELKH69ZBquEANPFDgbgFB
 JUXRAe0SkPiWKI0yjVchnlgUHAiyY1AGcY6m2Mm2xUacejZx2/ycpw9ZtHDnC6Wj
 qufKH2zAGdYHj90uDE6QKSWeWrz1m+Z+tqtKngdXZRzmC4NL1Yjh6pwtaKqW2m7L
 nV2Olp1GA6sCA4jIs4VE7TgMx3duenHSj7xlnWy7Blz0uz9ybuQagtNwv0/z8PzE
 AVLHHw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesmkbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:16:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9181f3cc5ecso230408985a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716559; x=1782321359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frllTOIREw6t9n6KjTsVt5BvKxKXWu4RRQZ/uSPHVqM=;
 b=QP2zXBdhmjqAjsvRW4tjTOWOp1++uCoWHtpb28aE+IswcxNj94Kwm0wzopGY/ww9jN
 QHnyAHvlBg8ccXBgXARnEAur/HDJgZ6NM3ancrB+wAJeBfE8UKJsFjFWG6aniZnvO440
 n5E1aOE+BfU44OYJnIiNYVuEc3VuQDsqaLJG4H5Y46IuNR7xOmcgzXJvoQukRvDON7rs
 ko16a9XNKwv+DBAOR5URveGZD5tXFrF/GD4z1/1QoshbLlwzOaj4pWdKrABUmKcJ+Caa
 382guA+ftZ4XwIcu0XvsID2poP/3KrDDBSdUZP11iI0Fkve5CjBWwhybXIGY4NcMHzKg
 xi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716559; x=1782321359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=frllTOIREw6t9n6KjTsVt5BvKxKXWu4RRQZ/uSPHVqM=;
 b=QfTMw6rtuCqqUiNFUd6MVpmjAntH173cVHCiRXltY2iHggxNtInH+0JArlo20yMiBl
 JEDdXl6tsUX+8znv7sFrbpfsoVcQEvzy8IyOr6gIEUluqE5IlD4q3dH/aCOWMNP4TmZJ
 ZAxcY/riob8c4FIGxlP9uOjETTNsLZ0uhbKYZ3TWe8OrLqLUi49guELLAgFRV+hsnEk5
 PFI/4JM1MMN4YrUUpDzj8s60l6zjObDdFKXA0vr6vdg+N8KYQW/425db62sOFxDG9LH+
 LPv/jjzwpiFG3kD9sX8qjyFQoE0yAQYAbpWr9VzFc2mAEgWYs3rl+rOcmoV5KEu9kj6P
 bsOQ==
X-Gm-Message-State: AOJu0YwFfRqgo2KgPdn7UOiJdO5jjfwKd16nvk/Hc0FSyuHLNtsmGeeu
 YKh3cUmzYeGPzizCjxGABQwF8N+LxU9wKZe9hmnaGZObViwl1AX0ReTpTFHgYMnpk0/6YHI/vah
 RJps/HYdGgXGE1RgGWWhfeNt3f5fC8lEcdcY60uHL8sMn2vbgQEaqoUEvP3KuufOfjQ==
X-Gm-Gg: Acq92OGCCAxiYjkrhQpEVsT1G+k28qphAccMKaeuWa1bNdW1tPSE6fovVPz3kiMLXR7
 R/86DvtOMXQEGImUXDknj1JZAKN/Fm9yWSEZaMnZpCh9brBjD5yomhpc6Gdofj0ADVq4aHzbqlw
 HTydN/L8wj7i/0uwrfPY9voC/BJO4luUPB9mkiBNlE9PubZolQWQ4SNxII9Yz1Q93SD6NT1unOz
 DaGmGz/StR81+yNhSCuQ4oly1oCVtH+r9d5Qnjee9sn5MgAKkURSjyLJyLS8H93FDEJ8xo20jEp
 9uFU823W7OUZfZtsCfKpsiI/FG3Voo533jbHGmoE+AaWJgoRYIL8AVgANruvnUgeCxJU+yFwaPh
 Sm0UoTulfQvdqgIpY9N5jZPHrlCnALC8xcDx9OgEpRZY4RQdIBqygkBbjnNPOaKdMZrdC
X-Received: by 2002:a05:620a:170c:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-91f07a26a76mr67772685a.7.1781716559445; 
 Wed, 17 Jun 2026 10:15:59 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8e2b:e5de with SMTP id
 af79cd13be357-91f07a26a76mr67768685a.7.1781716558841; 
 Wed, 17 Jun 2026 10:15:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm55055481f8f.18.2026.06.17.10.15.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/11] accel/tcg: Restrict headers being TCG specific
Date: Wed, 17 Jun 2026 19:14:38 +0200
Message-ID: <20260617171438.75914-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX3OoYc9oU/h8K
 2NMLkJ4zlFZroCWSDlHLHND40XXN9Kvy0/nU0upzQzkKhGmIukQ9vmL9d+TAqtRHAmW9zkQqtQ9
 v37gaR+TTbuJH8XnDf1N8CT39kaOFw60wbqdLnzkWBhfOVn7RrfLC8FGLLzVkO2fL02V3bwHuxz
 LJW2FUG8MX65vVnLpIvf5D47q4smEOaY6CdS+QP/cWJDcfB222Gn9kryOWe07n18IZmmceLDtBx
 FzKcM4oMMWeBDBFKwOd2qlywd9/QTt29Qlx/rWYj7XcQnyAW00CNt/t46M5nmRKqKz4jtAkFvFp
 x8JsQ5vHFXAk6TS0a26qnhgt4jvRbqMIuCa1T+sVRu08iNy923sNWLjZERvs/6V3xHld92Euwxo
 B4UELR9q1wemhnDXaueJNmLy8hQscKTiM3XlGRtP2WRp11t/du3DKMC5ee9Y1nkFh/idmYLO/Px
 VOjstnxVgux9S7ml88A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX91Jt+btyvkPN
 DBk1yartSAwL7UHZYmRTe30I30RwkkzU9z49XJtFfrbAYTZ67yNBkDVJS//Xw9v4Dmu2Ww6DjCw
 P9gjcKB8E7GoQpvBk4o4mwdRPsBQhFQ=
X-Proofpoint-ORIG-GUID: WHW527Qc3J8FanPaDtxKM3P30oan1Cir
X-Proofpoint-GUID: WHW527Qc3J8FanPaDtxKM3P30oan1Cir
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32d650 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=-SUpAgEnhvh4vktFIKIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Forbid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h  | 4 ++++
 include/accel/tcg/cpu-ops.h        | 4 ++++
 include/accel/tcg/getpc.h          | 4 ++++
 include/accel/tcg/helper-retaddr.h | 4 ++++
 include/accel/tcg/probe.h          | 4 ++++
 include/accel/tcg/tb-cpu-state.h   | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index e681a90844c..e0fb6ef91c8 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -9,6 +9,10 @@
 #ifndef ACCEL_TCG_CPU_MMU_INDEX_H
 #define ACCEL_TCG_CPU_MMU_INDEX_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5950cdcaab1..710da12b828 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -10,6 +10,10 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 0fc08addcf3..8a97ce34e76 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -8,6 +8,10 @@
 #ifndef ACCEL_TCG_GETPC_H
 #define ACCEL_TCG_GETPC_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #ifdef CONFIG_TCG_INTERPRETER
 extern __thread uintptr_t tci_tb_ptr;
diff --git a/include/accel/tcg/helper-retaddr.h b/include/accel/tcg/helper-retaddr.h
index 037fda2b83d..ebdc8b378d4 100644
--- a/include/accel/tcg/helper-retaddr.h
+++ b/include/accel/tcg/helper-retaddr.h
@@ -6,6 +6,10 @@
 #ifndef ACCEL_TCG_HELPER_RETADDR_H
 #define ACCEL_TCG_HELPER_RETADDR_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 /*
  * For user-only, helpers that use guest to host address translation
  * must protect the actual host memory access by recording 'retaddr'
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index dd9ecbbdf11..0b788901ba0 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_PROBE_H
 #define ACCEL_TCG_PROBE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
index 8f912900ca6..1903af4c2a2 100644
--- a/include/accel/tcg/tb-cpu-state.h
+++ b/include/accel/tcg/tb-cpu-state.h
@@ -6,6 +6,10 @@
 #ifndef EXEC_TB_CPU_STATE_H
 #define EXEC_TB_CPU_STATE_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #include "exec/vaddr.h"
 
 typedef struct TCGTBCPUState {
-- 
2.53.0


