Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6D5C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHRPS-0006g6-Rg; Wed, 12 Jun 2024 13:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sHRPQ-0006fl-UI; Wed, 12 Jun 2024 13:05:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sHRPP-0005bG-2V; Wed, 12 Jun 2024 13:05:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CGP1go011703;
 Wed, 12 Jun 2024 17:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=h4DiGOn+TewBWqIUqH9t7H
 Vu/MZAlmdByx5eKKIVB0s=; b=IxNvUS+Co3cWnUzg2+uAm4azmpZCrEY1MSVOh0
 of+GEZkD6tKo1pNNgLSKIPw3P8kGfCriGeRMAZntiQS2BcYqEaO1aspZ3AUMFCMT
 vVuuB2oPf3hSX+vgFt4gkRPH23NykNVXiEAqbVmi9VGNfO7u3ZWUT/TJX1qNT+bD
 mbWtlNpxCfIfZYQH1d04Tpdroey/xDADWWMOLutI5DjeVJw0jR2cBnJK6e6Sj7JJ
 Cmiq3smeLVhTD58fFKHMM65wAi6v+o4PEorcjt6c2c2pdX4F3JjBuzCI5j8ktsoY
 I3Ky3DSzoNnYQWcf0tnbpa6LA845cdE4X0vcCaO0YmvjZFOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq83wh05a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2024 17:05:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 45CH4xZn008591
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2024 17:04:59 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 10:04:59 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <alex.bennee@linaro.org>, <pierrick.bouvier@linaro.org>,
 <philmd@linaro.org>, <qemu-trivial@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] cpu: fix memleak of 'halt_cond' and 'thread'
Date: Wed, 12 Jun 2024 14:04:46 -0300
Message-ID: <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: ltFrEk61xI18zjQg6xFx6EBbd0rtHzCj
X-Proofpoint-ORIG-GUID: ltFrEk61xI18zjQg6xFx6EBbd0rtHzCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=614 suspectscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since a4c2735f35 (cpu: move Qemu[Thread|Cond] setup into common code,
2024-05-30) these fields are now allocated at cpu_common_initfn(). So
let's make sure we also free them at cpu_common_finalize().

Furthermore, the code also frees these on round robin, but we missed
'halt_cond'.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 accel/tcg/tcg-accel-ops-rr.c | 1 +
 hw/core/cpu-common.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 84c36c1450..48c38714bd 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -329,6 +329,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
         /* we share the thread, dump spare data */
         g_free(cpu->thread);
         qemu_cond_destroy(cpu->halt_cond);
+        g_free(cpu->halt_cond);
         cpu->thread = single_tcg_cpu_thread;
         cpu->halt_cond = single_tcg_halt_cond;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index bf1a7b8892..f131cde2c0 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -286,6 +286,9 @@ static void cpu_common_finalize(Object *obj)
     g_array_free(cpu->gdb_regs, TRUE);
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
+    qemu_cond_destroy(cpu->halt_cond);
+    g_free(cpu->halt_cond);
+    g_free(cpu->thread);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
-- 
2.37.2


