Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bc-0001rn-BU; Fri, 28 Aug 2026 19:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bJ-0000wj-AR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bE-0006Bi-Bq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTU6G1173226
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TeetWftlAGX
 BkOJee/oDQgs6FaMP4zcR7C6EslaV/gc=; b=XYknu2u/lvgVH14sSPX+TECBnQe
 gFbc7YK8jyyQqairnHR9WOtcjzl7vI6gIR9fKv+m21H4Bdc2bjsqI7SYg0mgi8cr
 mBv9iVJALmSFl/gg17vpZ6yEDDsguMhmkIradCVTcFh72OUibB/+eOahpDC12ILG
 eikyxsRJ54w5veomJFlssSSyI1tPLKPa9RwDu3lJLLxIWpUR2ImIR1VAes6V3kuR
 jQzkSr7wyypgugHs3s9TOkL8QfQj+Y3+v3N9WET1djgT/smkEgyjFSQwqDN/gI1Z
 dgvPpu2lf1Z6WRONcPuse98lQhHRtHexXj2F5uff3E7pg5M+TkNo7IE81Xg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjkgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so1804734a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958182; x=1788562982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TeetWftlAGXBkOJee/oDQgs6FaMP4zcR7C6EslaV/gc=;
 b=Z/IeBYEo7k4QtAte13xOFg0XICvOhZ+Q4tpa8bPz/j4Etb1lQ3YBPvXwFTxg5FcB87
 CHExEpYLlB7ByFHYwWhjUCClQdJvYtI1xi47uLEhKPWXDX4sw4UhjSMoI5gs/4dtCrFf
 UcIrdV79e4X1Tq9Rg8Lf+Lhi/7rVT4naDa+Meb8tIVw/fDXBRNnNGsJ0IFiCMH9F+94j
 FkP3RFk0ew3avAZqKl0WoNfwrnwZAiZyXNwXdaIMIDCdeUJFDwGHJjv+UPGW4R+9eZKF
 GwXGbdhsiB4MMk6St9qU0Vcr91z6ahhhoFpfv44xuSXbZHO1L2ANXx2m65G5KXgqjuxx
 Oltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958182; x=1788562982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TeetWftlAGXBkOJee/oDQgs6FaMP4zcR7C6EslaV/gc=;
 b=ERZ5uzga5+RaUyssskBCoODB6OBPX800s8Tpjtje1YBw3vn+p1OaX6wC2RcxZ0OqnT
 H+1YjktA1HIjOMSDF+SmpsAMG/IugnsE2FwIGD7RPLA6UfT7tHQv7Q7Hv7R/RzYvCDf9
 I9hwozD0NLbNfWV/r/1jGY8xaM2D5rqqvpYS7DjfpsEylDLOd5XJfTwC/uKI6+Eq3niR
 x82tSSTnezi84Qxrplyhcyhw/IfFEjV9cnH3QdJRQBsDZ2hCOeb3ARZDwr/xRTiR1JfM
 aN5vWzfIH04mAV7kQjbzIqsxs2GvCQ0PnOeBKuYcgL9Z1VVpUfN2GFhg1OMENEZPAG7i
 eVwQ==
X-Gm-Message-State: AFuF++khkdpMujMgOnVj4Mf9GfxowGpG0qrpkoBFgyYjoJD9qh5qkz7y
 rUthZm/zpkKD3TghkL/W98dNnyeRVyGG5YAQYomU6Wcjc22GKDeyTS7Z96f2YearBeQL4NF4P/C
 iRhVQMu5wGzMC2NTaqQAw7W1nZVX9UvtR238C3R3Qp0Z6hrGx7eyD+et0q+qTytPSNg==
X-Gm-Gg: AR+sD10YR/XkqzpMFXbmfrvfreVK7E2aFd2b8Q92oekBXnYAdKKbMsCGIHtgw2pMkeo
 gCeZPDDGucqRdpcdVGwjZF+gAI+SK9hoyOWzgXQQQJgI4ziRrGSh0nx5oLlkG1kTtZoMV49Twqo
 y6cciqgQcYJ2wJPUB3sD5cwaKRC3ri3SPxdOIhhJVkiOpiuVMmc67AbbbE4Wf1hv6kVcJ8uleEg
 C1GiLhVd40j387E0CZL+L9iwo73QhEJII3V21Aoi/H/lMRTdMVBT5eNcMzgkfxzAQMZZnJxdK5Q
 3+zJ8CArP25cbzZKi4t5jUguE5jO0l+Gk/XuCU6xW2AiONrT7CyStvFPrF63TT7jJEzL0+mO3VM
 YpJt2AQ26qmUQ+CHQ+LLPkby5oddqZxx7+cd7vuGEiCySO3PpMSCWKYZoCyY=
X-Received: by 2002:a05:6a20:9f90:b0:3cc:9620:5816 with SMTP id
 adf61e73a8af0-3d266571fbemr21302787637.8.1787958182216; 
 Fri, 28 Aug 2026 16:03:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f90:b0:3cc:9620:5816 with SMTP id
 adf61e73a8af0-3d266571fbemr21302718637.8.1787958181708; 
 Fri, 28 Aug 2026 16:03:01 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 42/47] hw/microblaze: filter microblaze machines
Date: Fri, 28 Aug 2026 22:58:56 +0000
Message-ID: <20260828225901.367438-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 41TuonxQ1tkXD_fgkfd4YHfI4FMJR8K0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX3Y2mfniagemX
 N2Rx+vTp8XNKe2k+XW7mPzW/rrH6vmKiBMH6PqgUr4Wtck/O/C1PDeAkWZvQBA6jl2piPn9klwl
 y5AfXPcdwNCghEMveskSmmz+h2nV+hk=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9213a6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Qq-BRxnSyYkDEyn2zA4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX2h4LfDe0WX9x
 J/mtgGrQY1LfWPWYOfAuGLLze3c/Q6VHMXkAmbHsUZk+7WdZXORD940C7nWWSIDboJ6rYfYxy9l
 mJBvUW/DEdu/0TpidLLsD3hr42Klxaopbe31iFyb1SOfQxf7qwOItBmrlTAIxuY7UfKXzsKEbhK
 mxrSQu2UhvhL7HThFzxmbX3GG6yokswn09CpVq6s7ZaGodU2LJ+hP+W5mLIiHvWlebgj/f429au
 13VtmwdmaxHitjjd45tt9ScoumsO7JrwYuBc+nbWzxjNKw916p5zgH65q4Yy7WseCfkO1tKxSYI
 jtw4SS8fNF7MCiKlTq+SgWBBMbQnu/fbGvvDp8SMO8a9ZVHa3yfYqe8Ro5yJWW/R4h84/dms3P9
 XgXh2lYTPq/NYoMNzuhNtlhkK2gHSlMzhhE4L1xUw+QnOMhiqboqVfmMRrH5BdYzf6ySWKlCvrA
 X3LYwkixvFyJ5ClHfeA==
X-Proofpoint-ORIG-GUID: 41TuonxQ1tkXD_fgkfd4YHfI4FMJR8K0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This ensures other base architecture than microblaze don't see these
machines.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/microblaze/petalogix_ml605_mmu.c      | 3 ++-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 hw/microblaze/xlnx-zynqmp-pmu.c          | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 240f5a31aa5..28180804afe 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,4 +220,5 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init, NULL)
+DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init,
+               target_microblaze)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..9e584104db9 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -190,6 +190,7 @@ static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = petalogix_s3adsp1800_machine_class_init,
         .instance_size  = sizeof(S3Adsp1800MachineState),
+        .is_available   = target_microblaze,
     },
 };
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 59d34f5846e..fe82acb965b 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -185,4 +185,5 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init, NULL)
+DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init,
+               target_microblaze)
-- 
2.43.0


