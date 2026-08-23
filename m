Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27AEC5DF9A
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kH-0002Rx-1S; Sun, 23 Aug 2026 03:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kF-0002RV-74
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:35:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kD-0005nt-HW
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:35:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N72Eio1371689; Sun, 23 Aug 2026 07:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ylbTAX
 GVHsCZW9MhHr/aX5zU08P390Rfgs1OZjcrb7s=; b=hZYGk4+Y1Z1GSGma9F7rwz
 0w/orzQuyXIW24LY3LpwjlkzzkEdDWFLQDzrGB/jVFFqcWO/SiH6iH/lUXGkwM5b
 H6nYuflYieijCHuZH8nnZn/wnfdaXPCH9Ii4p9ky5VSVyJw44Dylyu+beeNZbhjS
 suiQGFgEK5RuTVsl5fe/hS3fHGYDKqx1HPrJvFlOBieF18EIKHQgmRxbeZ8QnNPE
 NAK7AzVkjKkrfEBwDEbuQx+yGWSrRBc9sw27L7+VUuSgCML9mHyXpapBhaF515hx
 RiyrtTfqbO9zGNtOXkktjdCPGhofEPruPfgp79fPrin+xdxjAFN//TSuyEovNlXA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e455f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:35:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QGPD012306;
 Sun, 23 Aug 2026 07:35:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag0kue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:35:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7Zn4u32768274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 07:35:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB75F20043;
 Sun, 23 Aug 2026 07:35:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D96820040;
 Sun, 23 Aug 2026 07:35:47 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 07:35:46 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 1/7] target/ppc/cpu_init: make cpu listing deterministic
Date: Sun, 23 Aug 2026 13:05:27 +0530
Message-ID: <20260823073536.40282-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8aa2d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX7P0ir22b+U9I
 MYFidmhoIxbhlK6YioVD39igPFVdOR2p07MXmyrPI3eYRcIDu3N4491oWu2T3rRYwgcbm8OsaaB
 6DA8JI3cyeC6XO/Y94T+tMngDIHksqw=
X-Proofpoint-GUID: SkUWew2-GjeZpZt3xaafVXIs_lyohfbz
X-Proofpoint-ORIG-GUID: SkUWew2-GjeZpZt3xaafVXIs_lyohfbz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfXxDhXFdf6Bgbv
 ePLpwiYNwgYu8LOeynt/xtaT23KoxSJ6eJ8KYnkyLSlb3BcAxPzOIwv6gx/EJJDX3d6lzhyIpa8
 SQxX0HDQOHO2TZmuOiuMGE+GZVFAgOjXlYok7kuRUl6a5z1MlDKfG967wkK52gqFZ1fw1pfmn+A
 9LqysMecpaG0mTiGHdRkozUJHQhMKSaRark4EIuWlOV66m9+htZLQ8ICCL8+5H8pSzTNWYx6P4j
 67zh5uKbMrNp0HHcut2Nh1H1vSll/UkKDm8gtA1R/laBH7Pte421BdLT5ia9Ftvxrn8GmbidcDA
 WM8mqouw7t9d4jn8+EAsCM2yrDXJrI4Jpw/4WhcMMt5unBSlLtE82q9fgdEUkH3XkCN+up9BARF
 zTQiw6SlOrRtf+qFdt+d4f808YpmWGnsEJ78Gq1XL/tl+y+ZAY9y9NasWWv932T5wO5wlrCPlMN
 VwuS5WXlLYuzeJe2UlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

The existing compare function only make sure that we list cpus with PVR
order. However, we never compare cpu names.
As a result, while cpus are grouped per PVR, the order within a group is
non deterministic. Depending on QOM type initialization order, we get
different results for -cpu help.

For instance, previous output could be:
Available CPUs:
  755_v1.0         PVR 00083100
  745_v1.0         PVR 00083100
  755_v1.1         PVR 00083101
  745_v1.1         PVR 00083101

While a sorted output should be:
Available CPUs:
  745_v1.0         PVR 00083100
  755_v1.0         PVR 00083100
  745_v1.1         PVR 00083101
  755_v1.1         PVR 00083101

Fix it by comparing cpu names to have a stable result.
This allows us to record and compare various command line results across
versions to make sure we didn't break anything while working on
single-binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e3a1075aad..e2533481d8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
         } else if (pcc_a->pvr > pcc_b->pvr) {
             return 1;
         } else {
-            return 0;
+            return strcmp(name_a, name_b);
         }
     }
 }
-- 
2.52.0


