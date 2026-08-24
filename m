Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B265BC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4K-00057r-KO; Mon, 24 Aug 2026 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4H-00056w-4H
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4E-0001k7-U0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnG5i3329819
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5hCU05udzNv
 UXZyM5XD3pkdh+cnubiv19BnjcGI8PnI=; b=khttfH57kqmxEiEpiaIASXSd8mZ
 QGRfcYGIZZn23go2M7flJESTn9P5oKMFsZ2Cr4aFKgivR75ieat7V98P5tIvNu5Y
 c+KPFCLYOyNy+dprjgIo7vyrKLX+UM06QnpnZhhCEZam1lF53mvqkEBfXkjd2J36
 dVUCVav72SXfL1sDT9I4TI3iMtk5vieHrDmN1wI/xqPRAwqsShTcNALEkcdkNT2F
 T5Gf679ibKyxJsxuui9R4rMogJAytL5r1srUQSdV8xpIaxLkmqS/xd7P4nVgTZRz
 6qNZPNfhoW6eZhgN9coB1byKd7jvJ4svw4JDjRzyTTo7Yvvye4R34KE1PoQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xy5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so43866a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587113; x=1788191913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hCU05udzNvUXZyM5XD3pkdh+cnubiv19BnjcGI8PnI=;
 b=kMysPg0XfL+eEnGljWWOyKqrIXWQEej3EHaD7v6eq8ZGhUvModrvogMbQ1LChlAne8
 jTJXwNsuLpuueyvIhZ9SctURtjaUewlHVMgdbDbgKjG/XxdnBNs2am1hoQuyhkR/tu+0
 Bea8T8Dzdoqfoy3Zyp51gW1N9G6h5tfKJ0AyR1B3PGb3EgM/rMwlYkhftexq6JkwD8wP
 7awHe7HxxWKWNzeM6juJbGaftVjp7KfBfOOJml2P//9wfY4hr2tubqG8c8FAPNv0LSzB
 dt9scH4MmoZvYS9btIw97E+FgfGEFMkAZoVkur/sYs5MmRrU6t4pH5mVSdi4uSaHyoMq
 XJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587113; x=1788191913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5hCU05udzNvUXZyM5XD3pkdh+cnubiv19BnjcGI8PnI=;
 b=kUEysKzScqcKDcVlGn2Vjx4isBi2jD7tp4DrlWTLN//u5928WV4Gvc639l/cey8CJs
 jt5XTZuZ/qf45dwNsldeIM60xh7kFUpBmLc94VrLWunLrUOyL6EUzbydGKVLVfw2Tyt8
 bFX28DUNL7N3MuZI2GAnxNtYZovEPVgIXkKbt1Yq7E5YEIBQoE5APD/JGFXcY9RdVyCr
 3ivEqtPIg2N8kLpjHtM4W4Nw3vXxt7FeRgS5ltMgfdjFe65mnNWS4qM7/dkrlKWC8qk/
 HIHLIU3CmFhnLbbmy5fmKG3nB0e8jZncg9f6j2JH4k7c0nMEdOj4IvgYp6DAxEEDI/gb
 /YIQ==
X-Gm-Message-State: AFuF++nywnPpfMTBlERLnRBTmX+Qsp3DGxNPr1JUo+XBZVO61sntLCbJ
 la/367kG+dsvweQhD5xGzianPwy1JxDqmKfvvHTnzZZNatfbDu4xN0jC9rnLrV31L4cAps1GCZy
 vCX6knduGjVxnL8SYFG5k/zW1H5oqqNJCL7y8jC3HOlc2Ry51BtHTcK/HrsgLYr+CkQ==
X-Gm-Gg: AR+sD10HL8gmhji6btAlCWoOLgEgh07hVZSIvQs4n6k+d339LZWWolLYTQPqWfzeZnv
 WpOgjst3EsEiXhYuzGxemF1flAVpTco4+/CezyVhFwhqvmbAebJcZefNyANkgE3LOjG3RNGmEcu
 UAhbPAKJe6GuYwesdfWWkya2/undgofTEVB51t6tSXvaMspCCiAh2FRmNQbz9HF5SIS1xmEW/Ln
 Cxs74qt57mjDULsD7gLI4heXcGD3AKHtpefFC63vpKp/gA+RFIoBPK2+KT9e9+lIDrG7hpGl9qT
 ix3ySIy7KqpNag2V23HERUqaX5oJt2DU8fMeSJipPtW9jZ4wtklQmGLSlJZgDxDshFV/JclgjYP
 h5KSuSHEQX8bX0XeB+J/QaRPEJmWggZSNcVHah7iyS3geU9N3R51CqQxLwI6Tt9c=
X-Received: by 2002:a17:90b:5890:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-39645a56cc1mr237222a91.12.1787587112968; 
 Mon, 24 Aug 2026 08:58:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5890:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-39645a56cc1mr237089a91.12.1787587112195; 
 Mon, 24 Aug 2026 08:58:32 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:31 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 05/14] target/hexagon: add aux functions for guest mem
 load/store
Date: Mon, 24 Aug 2026 08:58:14 -0700
Message-Id: <a1f63c89099161f4e16ad68f25b25a993fd3ac2a.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX+XIDjXLseT1A
 6AH65/Uv+CRwu4nm3XhiwdLnIwZaYQ7u9+HYJ4d4qpYQUZ0PkNo9pUdNNlGg9fqmEIGN1/cVO8d
 hvCFEAwCg42QGkCFXODNJcFkJxTAte6GutqaWxkPQ5cGMheJIJblpTqMxNzsezMN78h0nfA1Z8N
 PbtFeuy89EpckU8VAxasIoIILyLRhP8YXYhWmbM0T5TUA7BC5a9+igQwAHDXhRi8d8H3BHZCHtw
 7+ukjHpHOMhMmLm5Q39qxQymIdZcbtkM5M03lG9PWlQkZJ9xsdNJXWarUzKrOl7mHQDGdpaB14G
 trGsHL5i9qhZUA8wCwERHLuZnpDygxKGNwvE/vrVULoINgw9+6RitBOwrZ2a0L1NEKkh5WCmKpR
 95Ah+Uj+lExxfW16eA/8OngSjMeTMpBk2R64IqqwENGQdFjokss6SZDrbRq0se9ZQdPJC/mZPhQ
 bMNdgstKu94fRIk0miQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXz2XNmu4mcaYN
 3ks3Lqj8olb4u3xfpFyTcz105bvwMK9m3BJGCanL34uS8SyAbmADUMCbUzfHLnv9WBfYuWhye/3
 zMm/9n9T92vq8I448EWnkVWX0vpNDew=
X-Proofpoint-GUID: xh0Mje3IDt21BKjdd0ZWwHnGzjWVLWQr
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a2a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-4NnfYh-EZONJb1VZs8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: xh0Mje3IDt21BKjdd0ZWwHnGzjWVLWQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Will be used for semihosting.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.c | 100 ++++++++++++++++++++++++++++++++++++
 target/hexagon/cpu_helper.h |   6 +++
 2 files changed, 106 insertions(+)

diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 64c5746c6d..fab9a9d7b1 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -25,6 +25,106 @@
 #include "sys_macros.h"
 #include "arch.h"
 
+#ifndef CONFIG_USER_ONLY
+
+static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
+                                      int byte_count, uint64_t *data,
+                                      int mmu_idx, uintptr_t retaddr)
+ {
+    /* handle small sizes */
+    switch (byte_count) {
+    case 1:
+        *data = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, retaddr);
+        return true;
+
+    case 2:
+        *data = cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+        return true;
+
+    case 4:
+        *data = cpu_ldl_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+        return true;
+
+    case 8:
+        *data = cpu_ldq_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+        return true;
+
+    default:
+        /* larger request, handle elsewhere */
+        return false;
+    }
+}
+
+void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
+                         void *retptr, uintptr_t retaddr)
+{
+    BQL_LOCK_GUARD();
+    CPUState *cs = env_cpu(env);
+    unsigned mmu_idx = cpu_mmu_index(cs, false);
+    uint64_t data;
+    if (hexagon_read_memory_small(env, vaddr, size, &data, mmu_idx, retaddr)) {
+        stn_he_p(retptr, size, data);
+    } else {
+        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
+    }
+}
+
+static bool hexagon_write_memory_small(CPUHexagonState *env, target_ulong addr,
+                                       int byte_count, uint64_t data,
+                                       int mmu_idx, uintptr_t retaddr)
+{
+    /* handle small sizes */
+    switch (byte_count) {
+    case 1:
+        cpu_stb_mmuidx_ra(env, addr, (uint8_t)data, mmu_idx, retaddr);
+        return true;
+
+    case 2:
+        cpu_stw_le_mmuidx_ra(env, addr, (uint16_t)data, mmu_idx, retaddr);
+        return true;
+
+    case 4:
+        cpu_stl_le_mmuidx_ra(env, addr, (uint32_t)data, mmu_idx, retaddr);
+        return true;
+
+    case 8:
+        cpu_stq_le_mmuidx_ra(env, addr, (uint64_t)data, mmu_idx, retaddr);
+        return true;
+
+    default:
+        /* larger request, handle elsewhere */
+        return false;
+    }
+}
+
+void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
+                          int size, uint64_t data, uintptr_t retaddr)
+{
+    CPUState *cs = env_cpu(env);
+    unsigned mmu_idx = cpu_mmu_index(cs, false);
+    if (!hexagon_write_memory_small(env, vaddr, size, data, mmu_idx, retaddr)) {
+        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
+    }
+}
+
+static inline uint32_t page_start(uint32_t addr)
+{
+    uint32_t page_align = ~(TARGET_PAGE_SIZE - 1);
+    return addr & page_align;
+}
+
+void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
+                               uint32_t length, uintptr_t retaddr)
+{
+    unsigned int warm;
+    uint32_t first = page_start(start_addr);
+    uint32_t last = page_start(start_addr + length - 1);
+    for (uint32_t page = first; page <= last; page += TARGET_PAGE_SIZE) {
+        hexagon_read_memory(env, page, 1, &warm, retaddr);
+    }
+}
+
+#endif
 
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
 {
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index d176750315..ca2e13ab1d 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,12 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
+                         void *retptr, uintptr_t retaddr);
+void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
+                          int size, uint64_t data, uintptr_t retaddr);
+void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
+                               uint32_t length, uintptr_t retaddr);
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_cpu_mode(CPUHexagonState *env);
-- 
2.37.2


