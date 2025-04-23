Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5A5C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hvN-0006FV-BW; Wed, 23 Apr 2025 17:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7huE-0005DA-5g; Wed, 23 Apr 2025 17:45:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u7huC-0002na-KF; Wed, 23 Apr 2025 17:45:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJ4Zk2024505;
 Wed, 23 Apr 2025 21:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=U97QkbHYOt84HBOKA
 QrTalAjgkyQnTV+YNWXfdb4R5w=; b=N6NvDz3jnwZTvJhWG1CSSAN+HTVnsUSpt
 RWNe8qRff0AYpGP7+HxC4Ke/XP3BJPPXz8p1QEAla1iZM7sOtS4I4IFeQC53yuJr
 vrKLgHfv38qowDiY3Jh74f3fmD2omf0LroYp7qO2CqwkvV37lisGlEl1dnpElRti
 rRm13G0c5QxIK7mM8IG59tAJP9MAOzI2v3IWd4DlMjYlP8KXLi7r8Sct+9Zdc340
 wElszucj5ePYS/vNNczKQ5CQe0iep+/BsEDD9zP1eGFHm+f1kCAX8JCMxWcBCCW5
 w8++7wL2+auj5a72k37Y+55qfyggLGos8rJk3pF9IM9awn2YLJ1jw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466x4ju7ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NIguog004097;
 Wed, 23 Apr 2025 21:45:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfyw4sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 21:45:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53NLjGEs28836606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 21:45:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B98958061;
 Wed, 23 Apr 2025 21:45:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43D8958043;
 Wed, 23 Apr 2025 21:45:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.34])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 21:45:15 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v6 6/7] linux-header: update-linux-header script changes
Date: Wed, 23 Apr 2025 17:45:05 -0400
Message-ID: <20250423214506.72728-7-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423214506.72728-1-rreyes@linux.ibm.com>
References: <20250423214506.72728-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=68095f6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=W0EDWCW3zNCZun0cewcA:9
X-Proofpoint-GUID: oK9hRB0mvfr2_RZL7Wdw_KuA0FYW3zSu
X-Proofpoint-ORIG-GUID: oK9hRB0mvfr2_RZL7Wdw_KuA0FYW3zSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NSBTYWx0ZWRfX4C4zxxPNSDKa
 XfUNTQzx8pqyNiSICW3O4qs0nY7+WDGNKFmOdG4ew4nlk8Gg7N/JH635kY6diPKBXsHOIE4J5ZA
 /u0On/DFtXlY3Hs0fkY65whEEIDu9ZQJSb3UEm6ULF644bO4GrfH/M5dkyYlWktN+/wL9BbAh5S
 po0NgKLA9pxZn4NqcpCRBB9REDl4Npvmj4OxhUu+LeRU34GOyIhn6WjcveGOTAeO2hiw1Gb7ftS
 g/hnrHSS+ggtC0OXok+vhswdL0nDZi3tdv2XDZs8fDZK+Mdik/NxrNUQcOO7B2NibgaPjS8HjYc
 LUQjEQs3HHnAshTdHec8XpnVR5eiHLry7+ONrJsMpmGETXtTGZC3HJVxl6glPYzf4+sV/x7NwX2
 7bgsO3ZLlYyOGI3I3wrUAJBd4ri9AGqyieX090vN74jQy6364BSifLpz8UqBA5A9POwQOaDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=897 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Kernel commit 8a14 changed from using ASSEMBLY to ASSEMBLER
Updated the update-linux-header script to match

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99..b43b8ef75a 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -177,7 +177,7 @@ EOF
 
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
-        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
                "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-- 
2.48.1


