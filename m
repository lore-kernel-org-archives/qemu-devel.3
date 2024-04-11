Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15423C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 15:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruw3t-0005i4-C5; Thu, 11 Apr 2024 11:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1ruw3s-0005hs-1T
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:10:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1ruw3q-0008LP-3P
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:09:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43B8FxwD017146; Thu, 11 Apr 2024 15:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=4g5zHVd
 UW6QD6Wxtj+cBMFx4VjDviOK+vGqqBGtKeO8=; b=LHX0bBlkLNaBnu8jJWm6KyI
 6XE4Sxjvx6CoLuSLzwk4ZNndlymZBHQUT+0zUeRDNyLVIBx9vkQ91jMbfu4YcEZO
 OYxFqDlz6cuM1PvBxJGlrKgHB5GXF6swVrHwdJMlUb2mCj3aGLIEhICPlF5RN1E2
 m+HRXRs+H7+PJ8Fowt7YUkd3EyArVN1PxGuGAfG0jzfU6NiihizA+mY9tGaaFfeB
 tpMluZT+9pJ4124jymDcmcZjcLe3AwejX59pasw8Ds8dX8niVIPD2nv2J76XOhoK
 6Ci+bci3cF228dasRPFdZ+wwDx+fYt4VQRD4JKN45OCZN2wL0u+EQ2lEzrLBDGg=
 =
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6vsea6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 15:09:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BF9gVp023268
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 15:09:42 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 08:09:42 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <martin@geanix.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] Makefile: fix use of -j without an argument
Date: Thu, 11 Apr 2024 12:09:32 -0300
Message-ID: <99185cfa61404dfa019a5e2c292b928791e85af5.1712848167.git.quic_mathbern@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SkYi-eusWzVcrJhwVVqAig4iBme8HIsZ
X-Proofpoint-GUID: SkYi-eusWzVcrJhwVVqAig4iBme8HIsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110110
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Our Makefile massages the given make arguments to invoke ninja
accordingly. One key difference is that ninja will parallelize by
default, whereas make only does so with -j<n> or -j. The make man page
says that "if the -j option is given without an argument, make will not
limit the number of jobs that can run simultaneously". We use to support
that by replacing -j with "" (empty string) when calling ninja, so that
it would do its auto-parallelization based on the number of CPU cores.

This was accidentally broken at d1ce2cc95b (Makefile: preserve
--jobserver-auth argument when calling ninja, 2024-04-02),
causing `make -j` to fail:

$ make -j V=1
  /usr/bin/ninja -v   -j -d keepdepfile all | cat
  make  -C contrib/plugins/ V="1" TARGET_DIR="contrib/plugins/" all
  ninja: fatal: invalid -j parameter
  make: *** [Makefile:161: run-ninja] Error

Let's fix that and indent the touched code for better readability.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 183756018f..d299c14dab 100644
--- a/Makefile
+++ b/Makefile
@@ -142,8 +142,12 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
 MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
 NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
-        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
-        -d keepdepfile
+        $(if $(filter -j, $(MAKEFLAGS)) \
+	     ,, \
+	     $(or \
+	          $(filter -l% -j%, $(MAKEFLAGS)), \
+	          $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
+        ) -d keepdepfile
 ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
 
-- 
2.37.2


