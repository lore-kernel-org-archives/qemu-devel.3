Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA0CD15D85
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2rMq-0003zv-Pr; Mon, 21 Oct 2024 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2rMn-0003rs-TF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:18:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2rMl-0006hC-5x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:18:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KHEd032538;
 Mon, 21 Oct 2024 12:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=e7eriyND1HxCjqBeCl89HbuWrzqkBW5NqKQv/rU8o
 3w=; b=Yz2JQUEtyVPY/BGv/kvymLqFMvZDZ2zK1pcFq/9sdDhS4aMou7Uu1k2Z0
 MeUQgUjf4/1hYMWqw+fxnl/mxmC4F4oNTM+tFZpeF7upSO1ugXUtVett2svNOUb7
 Dzn+07Dz8p+3mZ+0/VihOXxEBdez1IjNfQQb/SPO8WW7ogI1stHbK7KjMnx5pQ4T
 ewUusRj1/Ov0j1STtGkqwCVF7Fr64FkBXg7xBDQuXkrwcoia0iHuI68lDAXrzUui
 DNndThoJwsGdNTWoMK1aXY5jWVhYAZx1eSoZaEPe5MzauIyLtD3jBw89jfK/Fxil
 mO9CVtWgU/w8hb/jLUnW1Ps4L7yMw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hm94tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 12:18:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9PxGw018590;
 Mon, 21 Oct 2024 12:18:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj6111-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 12:18:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49LCIOAT36110726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 12:18:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E31BE2004B;
 Mon, 21 Oct 2024 12:18:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8959720040;
 Mon, 21 Oct 2024 12:18:23 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.27.206])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 12:18:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
Date: Mon, 21 Oct 2024 14:17:51 +0200
Message-ID: <20241021121820.483535-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vytSpo_TQFChc5SWGWEO7lvDq6FTkIHi
X-Proofpoint-GUID: vytSpo_TQFChc5SWGWEO7lvDq6FTkIHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Running qemu-i386 on a system running with SELinux in enforcing mode
fails with:

    qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
      00000000-ffffffff

The reason is that main() determines mmap_min_addr from
/proc/sys/vm/mmap_min_addr, but SELinux additionally defines
CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
in general, can be anything. There is no portable way to query its
value: /boot/config, /proc/config and /proc/config.gz are distro- and
environment-specific.

For maximum compatibility, probing is required. Use pgb_find_fallback()
for this purpose. The downside of this approach is that mmap_min_addr
remains incorrect, but there don't seem to be any practical
consequences from this. If a correct mmap_min_addr will be required in
the future, probing will need to be moved to linux-user main().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cef8db3b53..f6fb937d68a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2968,6 +2968,10 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
 
         ret = pgb_find_itree(&ga, root, align, brk);
         free_self_maps(root);
+
+        if (ret == -1) {
+            ret = pgb_find_fallback(&ga, align, brk);
+        }
     }
 
     if (ret == -1) {
-- 
2.47.0


