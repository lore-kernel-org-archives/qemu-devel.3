Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FD4FED3FB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLwQ-00064p-Sg; Fri, 24 Apr 2026 15:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwK-000632-9v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwH-0004Ls-9i
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGuX0e3088035
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a7TY2AU5eCt
 8gTvQU52cjnC4YSV1NPobt0HuPJwFdDg=; b=cWp706SK4FHRShUEvCipLSSGfGm
 1LYp3DwfFjTxqKBm9nToNVY/+N0INR+JNKEqQiWaEu5qm2lE1+K17jHqu2r3emOx
 LpSZ3GtaIrzOqWtFs1E8+hftADD/yriGF81X+L8QcYSMy9AFl08A6WHMpU+Ag2D0
 XXqu9gC2ewAT7Kgb4qw5qQnDAy+vJ9MV0DcfZawayVUvqgXxYWYMM3HxraExk2IR
 8y6uq8ANbBFWWO5/R3PF4RIaMpqH4qdOAPyG5jEeBGZKIVMXanMQTHp29NTlvkj+
 E6sJlqCb1nDtSmHkRbUBglbk+MbtlmKFyM3Ugt2LO70wP71kuCkwjeOjinA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drbqg0rdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb9f8bbbb3so1032361685a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777057899; x=1777662699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7TY2AU5eCt8gTvQU52cjnC4YSV1NPobt0HuPJwFdDg=;
 b=N1dWPl7cLQz/fk7pl9jn+kOFLhZBEe2MTzmBRKz9JVf0Nt/Jq8q30Od7rBtJkyv82S
 qul6ZKehy8cz0OMmOevBkUUbsm36YirEpTltRi10TNh71Ymf3HwXsEPCYprs2BtUSXK4
 oOtv/Ho3MoMHjrIcf43GBjF5pOXioLRmpip1wgPtnQGfGXdjK1yzcuFK2ywGNM1Dh+l7
 p7StCE9G29fAZ26fkSRisi65NUc+PpMi7onTWgCJeslMun2Ubmk0mneuoyk1aGL/auPF
 dXwXVNRzq44PDpxU8DYitkDfBLO7ddQpsXR9Do/BHxk8QT2IlxYTVT0RY8UU5Yktfwy3
 Ux+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777057899; x=1777662699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7TY2AU5eCt8gTvQU52cjnC4YSV1NPobt0HuPJwFdDg=;
 b=FYYy8BAQsd4go2tIENpI+iMyWzqH0mjwC0pERjhRUqXdn13RcrrpSbLWHksqydWtgQ
 o/vyO7aOzq5XHzotQMHJpwjP+W2rrFvXiPpkGH9Lm6d7k37Tw8SdRjkqf4UvbGg2w6b7
 ym7d7D3KSYv0ZvUfmjxOpgcnuEaDHvJH+burY3XWFDs7a7LgLdrJudgue22cxhMUCJeG
 rFJ19oLXaEPe2trSpartPMnNeGyPUv5eIle1thcp4EPs1CQrj6XNBD21ccNRGxUJJrVc
 rm3pRsegcceV0RAMAD9Baf49n2Bb+D1XAL3d2ZAhl7Pmq9xIKly6zEfP/4wx4AwdqjaE
 BaSA==
X-Gm-Message-State: AOJu0YyVU/BIQX4wfExwq2z4kWorUL3VMfBfGvSRRbk+ZW0bbxjxTjJi
 4evDlPN3f1M8DvB9arEf/HgZQyhuYPCBX7k9tIyPBIY52HSnpR/lfcsVPscHg/C1qxqTELniOcx
 Spxl+TDGWZmTvUjnKoY5trrn9Forb87lU7q7ittmpNVBVsgT8eG5H19TBOsdSKj7y3g==
X-Gm-Gg: AeBDiesu2wKSaKVkYYF9cYQrYFDs3NgEIVCMvsbncJx7X//m7YM3APKoe36G7MeSbDy
 bYsYMi/jBIbLex6RTjk8fa15UsHImMq22AKouPB6lRYZC+y36NllsHnfZnDOHjJ13kt7HKxsflR
 hCZLFhbsWlceLc8CM/BO/BdUvGbmtuHdh5/+iAH/dCY6JxcpSJnBw0C6YsCKI1sIyGSgssb4r5o
 ucILGSnye3uou3ZwnQaHqxOWGqBGE/fzaCtHPgHBa4qz7Kt3zINDa5r1AIcxFDNqh+u2c0i8FkE
 r3Doa5ED4f+7HY3UKYU8ZySVKNROrInSqfi/jYlKC/JUz/y453oFGGOJLVbLIfvVnCpJ64gnIUZ
 mnCd73AVPDp7UdwKJj/Vox1DmbkRF7c08ckW9eS3inNJJkY7LN/s44woKlFKoGwgZ1XYgtnc=
X-Received: by 2002:a05:620a:2953:b0:8cf:dd93:aca5 with SMTP id
 af79cd13be357-8e78caabed9mr3755859185a.34.1777057899553; 
 Fri, 24 Apr 2026 12:11:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2953:b0:8cf:dd93:aca5 with SMTP id
 af79cd13be357-8e78caabed9mr3755855785a.34.1777057899123; 
 Fri, 24 Apr 2026 12:11:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90afsm2319567085a.3.2026.04.24.12.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:11:38 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v5 2/4] target/riscv: Add server platform reference cpu
Date: Fri, 24 Apr 2026 16:11:27 -0300
Message-ID: <20260424191129.1494381-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NiBTYWx0ZWRfX/gIyaHqOTw81
 E47CCorLbPQGW9RYySE2DxpPRxW8MwlKaChknsMAYhStsgGfaqfqPH/GhcKwugidjN2a+TFYkaB
 1oD9jm2XUDnkf2GcDH8JQb8BWfBI99HLj4hH4c1WkH7c6awGaXJT+LVvQ95+wXyZfF0oSAsbwSr
 ho4oaQu0pgL30xVTRduv/NVqotC42GfNgNxksLFxqWhbWaAKK6FhhjyZJERFvEDUYWkGBXStZhh
 n23MwL0b0YYy4FRPJ1rzhwxTm/zdlFbgdYzxHleQF7ZR6DEVz0OMMaaTIQU0gh9ULnXGQzTFFPO
 OTT2zaXHjVCH3AgDTQGErCGMAJYQfuNpiDKvFMI7Nwgy/D56DFQaoN3+xYZfPEvLIGuJ/GBH2gW
 cwaYY9hw34HHy2G1ktf2zkuUWxdALzG2fNztKWi/DVyRGPZl8qAfBj4UgKtFdtN0Yzy8hAzm3gm
 E810CMLWh6p1YlnQBSQ==
X-Proofpoint-GUID: GSOPS5M-NWHS_z4wV8HUCSBBvKvsH0UD
X-Authority-Analysis: v=2.4 cv=DKu/JSNb c=1 sm=1 tr=0 ts=69ebc06c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=V1jnuoLLAAAA:20
 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=EVmsHFvQfC4jtDmeNssA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=T-agBWn15iSmxapsA1lH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: GSOPS5M-NWHS_z4wV8HUCSBBvKvsH0UD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Fei Wu <wu.fei9@sanechips.com.cn>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

This patch provides a new "riscv-server-ref" CPU to go along with the
future "riscv-server-ref" board.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..a150acd151 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 586683b28a..4b59dcabff 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .profile = &RVA23S64,
+
+        .cfg.ext_zkr = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_sdext = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.43.0


