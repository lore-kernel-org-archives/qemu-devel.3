Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AB1CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 06:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssczo-0005c2-7H; Mon, 23 Sep 2024 02:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssczm-0005bN-D8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 02:56:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssczd-000096-Gs
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 02:56:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N0o1KA026131
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 06:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=WuXYAx4FbZyqJc1WExb81VsrAb
 VpgVGV1MdusHw5kbo=; b=LIFLZtab/kdrs7RkpeFmaBPcb6WriPACWH5NmMjJcr
 dkQkvMvDxziMgOS0+E42FSWKBEcbOo7zXcGEri7TXJcvKtHV2efZGAIsn9Eg5RGg
 al5gItt/XFhm01uz4c9f8htFzrpJSL+9bemLzv3x5d+kuleBy/W00TfFJAaXU3ls
 XW+PiGgipL21II4OlNrXBVkWkydGSU/vEs1vQWX87e5riEdNrVEPMALA6HGzVRfT
 VL97vjJ8mlLdfcjecGUuInsBjbvboSLYgDd2CJNdOmKZkd52mFpsD8lt3jG3bL6E
 mkhKVnRYysRzeDxN0ALC0AXBrC6+2DJpcmKu7wchBFwA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvat0th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 06:56:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N4Jnvl013998
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 06:56:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9ymmwth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 06:56:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48N6uD2435389870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 06:56:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0126F20049;
 Mon, 23 Sep 2024 06:56:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C52220040;
 Mon, 23 Sep 2024 06:56:12 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.38]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 06:56:11 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] typo: Fix description of '--disable-debug-info'
Date: Mon, 23 Sep 2024 12:26:05 +0530
Message-ID: <20240923065605.2170454-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9HLyR7doVfrePJAc4uI6HVTBlMHMOl7C
X-Proofpoint-GUID: 9HLyR7doVfrePJAc4uI6HVTBlMHMOl7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=925 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230047
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The existing description of '--disable-debug-info' seems to have a typo.

Later scripts/meson-buildoptions.sh does the following based on option:

+    --enable-debug-info) printf "%s" -Ddebug=true ;;
+    --disable-debug-info) printf "%s" -Ddebug=false ;;

With above logic, the description should be 'Disable debug symbols...'
instead of 'Enable debug symbols...', Fix the typo by replacing Enable
with Disable.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 scripts/meson-buildoptions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index cfadb5ea86af..81c053a0fffa 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -12,7 +12,7 @@ meson_options_help() {
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
-  printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
+  printf "%s\n" '  --disable-debug-info     Disable debug symbols and other information'
   printf "%s\n" '  --disable-hexagon-idef-parser'
   printf "%s\n" '                           use idef-parser to automatically generate TCG'
   printf "%s\n" '                           code for the Hexagon frontend'
-- 
2.46.0


