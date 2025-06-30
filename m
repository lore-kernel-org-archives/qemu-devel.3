Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950BCC7EE30
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 02:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW4Ve-000589-Jl; Sun, 29 Jun 2025 22:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uW4VX-00057C-N2; Sun, 29 Jun 2025 22:44:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uW4VV-0006RD-JU; Sun, 29 Jun 2025 22:44:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNeHl9023492;
 Mon, 30 Jun 2025 02:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0az5zO//UdNKmzP2bxYjrdorWSGk7qTOwGAbfNxo7
 5w=; b=gEUcmDWdJG8eSNmcZ8mvsL5D5zyxpm9cRyk1TV+gvNFaiFJw5W1uLriwW
 vMUU/YcMOy27YtYzROqGFY6licQLiGrqyIhN1qQ8WZgk1AOFFC70+hSnFrYKqfTt
 je7VOAaa0BskAz0usKEjcqMQO3o1G2YLpqidhpDAe4xcwlG2XWckAtL84e4+XK7V
 7ruLXd3+3K8Qph+36FRUrbmMqML1cS0FdxcOTEVkD3OCWQq+Q89eP6cPNe7hP1t7
 1bKzPkgo0/XgTle19PmBK3SZldAixtD4mxXc/LlDt0viZo5+/BzWS1y8/1M+5UbV
 pdqkZic/Ow+GGTWPGMosUamRmKVXQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830er4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 02:44:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U1DgR5006835;
 Mon, 30 Jun 2025 02:44:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm3r2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 02:44:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55U2iPIS19923506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 02:44:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FA5858045;
 Mon, 30 Jun 2025 02:44:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BDF558050;
 Mon, 30 Jun 2025 02:44:24 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.116.154]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Jun 2025 02:44:24 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, fiuczy@linux.ibm.com
Subject: [PATCH] target/s390x: set has_deprecated_props flag
Date: Sun, 29 Jun 2025 22:44:04 -0400
Message-ID: <20250630024404.940882-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U68NzL2fO0AOF8AJmU7Q4ZNAuF2ukG7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAxNyBTYWx0ZWRfX+STo2nQTDKCt
 pIKnpz3fsphl3CsjXxHQzoW3ieZKO+HZkbj6BVLm89OAleY0oXq/yFfLVdThIMsUr5RF59rIhQT
 6kt91qY8MuNm2rWGIpqjiTIIwoP4R4n4iu5SaZrJlLPjs9ll6DyKnCFdOchacsNPrS/6HyrJPJ8
 H57DJtx/yh3Ki9nps0xq6DB4US/YyJNtqNYsk18fblaDxOe4VABKy/ucJ+CTh67QqquyENpn1mG
 YaA9bfkjQA3rUudasoIO/K+mmu3lw4No2K+EQQ67E/PLPM3OKffBBa/u3MKrpFZRDu69tEXRMgL
 7JTPn9BkB+S+rAezh7CiVMzMocSjURfUbgopfluDbd7ry02ldhyGXowhZ5I0KwBKLk6MnPUJRxU
 vZ1ZZIlicyCDS79E+KiDVULAcd9Ipzd5wk1+1rMQ788vtnYmf5c9K3C5qDfOp0yvN7AB3vGW
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6861fa0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=aQYFamGOHixhPoCw4cAA:9
X-Proofpoint-GUID: U68NzL2fO0AOF8AJmU7Q4ZNAuF2ukG7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=716 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300017
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the deprecated_props is an optional field, the expansion method
must now set the "has_deprecated_props" flag in order for the data to be
output from the response.

Fixes: 448553bb7c (qapi: Make CpuModelExpansionInfo::deprecated-props optional and generic)
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_models_system.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 9d84faa3c9e..5b846048675 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -252,6 +252,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     s390_feat_bitmap_to_ascii(deprecated_feats,
                               &expansion_info->deprecated_props, list_add_feat);
+
+    expansion_info->has_deprecated_props = !!expansion_info->deprecated_props;
+
     return expansion_info;
 }
 
-- 
2.49.0


