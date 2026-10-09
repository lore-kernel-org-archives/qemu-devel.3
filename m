Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E31CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJ2H-0003Dh-R3; Fri, 09 Oct 2026 18:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1m-0003AG-KU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1k-0000Qe-Kp
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhsWS2281237
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g1nNAsgNCJ1
 6qrOZUCMpXjDSimZJN4qb3I5rmhzC1cg=; b=h0TxFyD52lHTqTYJRQq4o+Qvy0x
 bVNx95iQnd2n42VkyEsLkuvd1pMB/Ggm1FtgvOOqjmasFKxyOq1j2JkY0e5F8VVs
 iFJ1lkNHb2+3rivipMbLS8REmMrbs6gJUubf6WvXmmKnpfbeUawH2fI8rF54UCTC
 x8cP89yfk/jEmVHpUoSzYtqzjP8x4D0VyL8GAKdPX5MXe0r8DJ9wEeUyhbzzTtwV
 vdRK972WhKxIePUauvSI2inwpl564i/SfDyYAiDQSI4SbJtQtyjqR2+mPoZMaLNZ
 nJo4en14QjGzQtjc+3HqSwtHNJHg+XiOJo1hKfgBombLLTE59WEQxMvq5jA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8gwx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:25:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so381913eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791584718; x=1792189518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1nNAsgNCJ16qrOZUCMpXjDSimZJN4qb3I5rmhzC1cg=;
 b=K8//hCPiRJGA8+kk1KszHvre4C4MQlwA3al1xMwUWg3H79XZBtWdZw5A0ElBvCYMst
 JGoVOEJPn9S98wSdJmDjc+uB1C8dDXuTTSaAJLS974q71eNyA0kylIa4HJOhKNnKkhl+
 aTz+BmH5lUJycchCq5qN8dBFZenyvnQNn6HDuyxgf/ybXXg6lJtiiOYTCA+1/HL5BQz9
 LQ7yJaWYU1oLEnNz+VNBvrRoU47CmO1wNm76DP//27NRhcPAvomDsqPVj4Q2zjlHBqVE
 vGKVSBffvDnbPe1Tr54EeFOVN+QgaqXyrBkuejUtddTZ9Q0GfPB5swBc+Kr+rDVq1r3d
 w5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584718; x=1792189518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1nNAsgNCJ16qrOZUCMpXjDSimZJN4qb3I5rmhzC1cg=;
 b=BT6pMXdPW7OXadePw1Sfn1+XYu0ulciM3yA1ev9HA6gfVfaRtyuguYkuEq9jIi9iFB
 w0ptpHMUcUHPOpHKbw3sJJylu9HAQXC5hWPMp3IQ9PAtUMwddf0iSn2Yjf9jqyg9hl+M
 qXyE5avDkYw2xTBFGjgIhATvHNN38Y9sgaESzVtNsptuttLVroTSAHsffyOdQYe7443z
 UzXuVQY/gVwxsNyzDO7iwduyFkoUhdmdfBgwwltu33ITazxKef15GfyNTUYilqyI1/yA
 c4e7dn/qFZ2mPd+oES9xLS4J9IwrNIO5Y8FkPwH87V5fFi4Yu01PQuyoijB5xG3Z+ihr
 2GCQ==
X-Gm-Message-State: AFq9FYJedDr4o51X/+CJeUaFVS6e7ikaGBnWNq6LI4mnkbeMUcgWQp9h
 xo9eIsXi7QBv7K2CECySxY92ETGhuY2IKAXXQmmfemz5Ok5LLXmijVgsQmjB80OGVF4jt6bSCye
 x7JP3AYD2kLeYiwu0H/VkqVD6O4MgmYhcjdXxHIO3ziFJ5s2cgAK1eZouT7DJm2Pclg==
X-Gm-Gg: AYBFou0nx1QKbtIM2jjUgr2MqddeTzCtUymRQZjm8RK0mZMSJFBGLltVNiQe9MWpk7j
 t734qP7gLI+CxApRQQaNL0gM5zsS+qMPaJQpHVe3nUwr3w7NCiaQnmhSWnOkwAtfSbfbnker3Er
 /0WFUSg1nvriRlJasPNxuPMAA5a0FCvAV+6Z6iaR9494dGVSzLUDNIyFX2AExJTuYjVXXHiOvr4
 TNOuBsf+DMasuzxi2rmaOYbaNhOkbMusPq78I9CB9GBg+J70XW9nEbc2xxmaAXUUP4g2RVEopww
 TaE52TFuwLcp8OYN0oPiy60otaeVAgYtpfOrvPrR1JTPbR3FUTUCriNy3AdDiXQUj2fwTu4SkgR
 ui/l7jhInVpdWmeX6FAcTYKIv5hDYKopYM8eCGiKGipWSuvIz6GbiHrmD2bxq
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id
 5a478bee46e88-3537e0cf2a1mr4286448eec.38.1791584718410; 
 Fri, 09 Oct 2026 15:25:18 -0700 (PDT)
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id
 5a478bee46e88-3537e0cf2a1mr4286412eec.38.1791584717818; 
 Fri, 09 Oct 2026 15:25:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca0e64csm9094339eec.10.2026.10.09.15.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:25:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] target-info: rename target-info-impl.h to target-info-def.h
Date: Fri,  9 Oct 2026 22:24:59 +0000
Message-ID: <20261009222459.32364-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OlEWbD4xeqFor86ZeHy_6rBYcTat5I6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX3XU3j0+a6Axl
 4QpDU3OL5ud0aw3U65MoxVq08DwviL5x20R79xlFbm399FGvxLoE4SGSXDQfUV7CSteJjFVLSbJ
 AGwYk06RJKs4vjY2P+U4GwAA+5qB86GG5IXLJM7EnJoKDOVr+wHbAODRTT1n7WuKZzTvUieLAzY
 NzW6fKKOyy0Sp7KJlTKBQ4JuUFqxqpug+9Q98pSeaObwNRWJxKQ3aKP+RI6r9oOyYrO42ptLQbw
 8LP9zoEVbvjoh5jZ/u0C8KmfvWzJ6gi/Bup2ZcLbX/iatvGaPRf9nTa7jKjX8l7PV/53QDE6E63
 n1gliTYqZSwjLkGTITcEqj7XI+y/PYDhwzSTYNNtg+Ww1XK21qXQTzLFbnPqJv8oYfWFdVDea3y
 BHKZx8iDC3I2CcLnME72hTxQvBLii6ADiHMyl1iLzQOFmFCjqU90O46H6sG2HoW+8IKSDiRCGD6
 kkyIRCJsRge8pNSYZWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX/o5eBW1pxmko
 1+EjzKpd0iXDALNJKhprelSi8fBeITXSYGyGhMrWY9zsCPGuDMLpihzgJhyIaKqKvIN406VVQP2
 D3isW1k9JNCFKpV0mqxDgHMj+eTmaUQ=
X-Proofpoint-ORIG-GUID: OlEWbD4xeqFor86ZeHy_6rBYcTat5I6V
X-Authority-Analysis: v=2.4 cv=ELeTQFZC c=1 sm=1 tr=0 ts=6ac969cf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uEmvxZJZQuxZSF3ythUA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090089
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

From: Yonggang Luo <luoyonggang@gmail.com>

Rename the TargetInfo structure header and its include guard.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261007115253.328-4-luoyonggang@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/{target-info-impl.h => target-info-def.h} | 4 ++--
 include/qemu/target-info-qom.h                         | 2 +-
 page-vary-common.c                                     | 2 +-
 page-vary-system.c                                     | 2 +-
 target-info-def.c                                      | 2 +-
 target-info-qom.c                                      | 2 +-
 target-info.c                                          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-def.h
similarity index 94%
rename from include/qemu/target-info-impl.h
rename to include/qemu/target-info-def.h
index cf42aabbc8b..8019d2c7196 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-def.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_TARGET_INFO_IMPL_H
-#define QEMU_TARGET_INFO_IMPL_H
+#ifndef QEMU_TARGET_INFO_DEF_H
+#define QEMU_TARGET_INFO_DEF_H
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 8b6e1ece969..ba2e4370afb 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qom/object.h"
 
 #define TYPE_TARGET_INFO "target-info"
diff --git a/page-vary-common.c b/page-vary-common.c
index ddd08633788..5a4654725a8 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,7 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
diff --git a/page-vary-system.c b/page-vary-system.c
index 6c49c10e23b..9773685dc16 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
 #include "exec/tlb-flags.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
diff --git a/target-info-def.c b/target-info-def.c
index b0079d44dcf..bcf9cfe1e43 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index 3ae1627b8fb..aeeedb7e818 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 
diff --git a/target-info.c b/target-info.c
index ab43c9f802c..6b365113955 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.43.0


