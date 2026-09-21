Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B770C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Z7m-0005IR-I2; Mon, 21 Sep 2026 04:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6q-0004xI-7K; Mon, 21 Sep 2026 04:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6m-0000Jr-17; Mon, 21 Sep 2026 04:10:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7ZPO73153582; Mon, 21 Sep 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TrYrIgi2OX5NknMpZ
 SoEIqcEASSruLtnF3SGkvJGXVU=; b=EUYpii4ev898M9R0CkepU2Pn46qwy/ELG
 zYXuS+ihQPRR2GVJTgiQldZo6FxVH4pvVBdGsRiJQB7cYxs9vzCGIPIjD1bPblPq
 Ka8LJ1v7GbUU3XqYrWyFhTHOrIjT9fykd9hociSzlgb/OC5bT/QCAucIialMUU04
 CuFFbzrZt8OlEviFSZVFujsQZ2MifjPjseo5AuMStAWvVyE54KlYTJhSaW9DbjNM
 yy3ofR9sW4ThCkpJhBow+mhLWE8D0qEiME/i01PX6vD/42xviCnYjIZuWjNaqfCm
 UDJLgk0aUHLDZ+EenCUuPJ8/KYk3vOuKyPZ3yDMUdUAng58h3kQZg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ffac-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7HaCE1835433; Mon, 21 Sep 2026 08:10:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy45m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L8AVhm33030452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 08:10:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C87720043;
 Mon, 21 Sep 2026 08:10:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1132420040;
 Mon, 21 Sep 2026 08:10:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.112])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 08:10:26 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH v3 2/2] tests/functional/ppc64: extend ppc64 powernv net
 device tests
Date: Mon, 21 Sep 2026 13:40:10 +0530
Message-ID: <20260921081010.31778-3-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260921081010.31778-1-asahu1x@linux.ibm.com>
References: <20260921081010.31778-1-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: c45N48tLPyuDidgTlUAAUo2TV4YuHPmM
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0e67b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=qvQqbTaxai10iMa-vdEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX4GQDypkcLzjr
 9Hk7Kw0+g6Up5NqIm7ypUPHljlYMn5FT0JmJ1Ie/yYVusxZnCbCmnaQGdEtsE1xnGItYhFK1xx+
 ScrcUhYf5ZzAI6pdFxA7Je4OWMakCXE=
X-Proofpoint-GUID: hjU_wqpa6Ozy7oCka2IMMs-SVk15gyI9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX5dXRT0vdetII
 uu42VqOR7xDhHvzQe3CPT4QqbEXoLtAUitNqm9gLcWSqddT0zwkPygX5hTpliYvW23hKnWv8Ptj
 SAn0bHuSJdGFKCHleJwrhjK5EZSi1gk5YwZcUnVzngHoACtMPwLPH9GgGoNshc2KIp6PbngBtkQ
 uGKLf8ZmE3yxMtljnv+KPVSa6Uh6lqTElmiFZweJb0NEA6WdjFNGL6nR5gQsX6iOKFnKqJ2ZlR4
 mW8tIccYJMgmvFgMgGSfa4QKvdnxdx4vE6ICd8C9iyGDQIQEZvL1obBkR6TVn5yDofJQ7yIk2gQ
 Ks4CZxZOLyxlr9RQiULE8qWFKiKFNe+3VWNsOMHTMS0+NwR7wL/ETmqmRKjqZwSZhm8VL+9Jn8K
 Wg9R6vvlhugAd6rlaFT5m/C9BTwjXizk4Va/oZlXqYel7qwwnQft+h5WS7AwjAYL9W21imTrETd
 NJ/UaZJHnCpO3Agob5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Added console checks as the probe log lines will appear before the
S14Silence-console init scripts.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index f3e05e4d38..200fd2c894 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
 
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("INIT: Starting kernel at ")
+        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
+        # during PCI enumeration, after OPAL hands off to Linux.
+        self.wait_for_console_pattern("nvme nvme0")
+        self.wait_for_console_pattern("e1000e")
+        self.wait_for_console_pattern("xhci_hcd")
         self.wait_for_console_pattern("Run /sbin/init as init process")
-        # Device detection output driven by udev probing is sometimes cut off
-        # from console output, suspect S14silence-console init script.
 
     def test_ppc64_powernv_external_dtb(self):
         self.set_machine('powernv11')
-- 
2.52.0


