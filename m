Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F59CD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJfKK-0006O3-UY; Thu, 13 Nov 2025 16:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vJeyt-0003X2-QC
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:35:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vJeys-0000fk-5V
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:35:51 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADIO1Ed030970;
 Thu, 13 Nov 2025 21:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=UN6ss7zYicPPSSH2IyxXG+dzIjA4VKc45n529cdi0
 SQ=; b=DG/Ou7NSbL6WSZ3UR1AFRhvIHF/AT4Hjs+swYvfEzMbt3/CX630UJf4a4
 8E8gOggCqd1ZN94qIxWe3O1nmq5jV/iZAGta6dB91e9EhIxcwZHgs2/7wyJzi6Od
 trxsCnoTLLVDePmk7hoPmmuzRsDvIEITT6tLxtk9NHxqkpymrMNkP39hMgb+gIBB
 O9FeIFt6WpjPgZLlgRGfwU29KmXyy+dQby7n0wr33xQ39mxatotVIOxF3o9Ol62f
 5UKPWuyx1/1hBMZxpKrUa21haa9pEqJPipPc91LX51oMX8MkQ81G+W40LhsK9N68
 Vi1WkGNzUEW/KsC18LJD3pSRlIqxw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8fufh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 21:35:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADJJH1j028978;
 Thu, 13 Nov 2025 21:35:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6srb6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 21:35:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ADLZkfw34341510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Nov 2025 21:35:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D194858069;
 Thu, 13 Nov 2025 21:35:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4710D58065;
 Thu, 13 Nov 2025 21:35:46 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.187.144]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Nov 2025 21:35:46 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: peterx@redhat.com
Cc: farosas@suse.de, steven.sistare@oracle.com, alex@shazbot.org,
 clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] migration: set correct list pointer when removing notifier
Date: Thu, 13 Nov 2025 16:35:45 -0500
Message-ID: <20251113213545.513453-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69164f34 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DQOzkKFBm_5Ee_nsKn0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: bMAoDaniCtvHlEpMECoCLqr6-LRcRSy5
X-Proofpoint-ORIG-GUID: bMAoDaniCtvHlEpMECoCLqr6-LRcRSy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXyY/+zLS1FGhX
 5AO0RwSNPn0C+RfD9A0we1Tl0AHqJrK33p/A8b8Jx61Aw0bHFp+lNKl0ED5F0wEqGz0wKjq8lqi
 HwfxiVQQjD7SOavVvu0Lj00TJN2a9CpBDp+e04HW32bS7uXr0tr/FJnWNaHjQ8ULWFe8mdzMcBN
 LmoWEku0njCl4ja8dIv1HTFoBNraPZR9xAK/d2AiItTXkaVANVAPEgKzRQC69Njqt1ECdj7JOIl
 y3mcXPi5rwTUgd67VctQWkvF3HT+NlggjE4YdHpJcOjOV316VIvTyCwShnIxbJScz9PYVao3QlP
 MDOppiksHqpzVuH9x2XkF9Q99MMaK72/uRGwNRb7vz56bFGLTvmzgW7SFIiWv+t9y2/0iLv6CbR
 ZgU64b4tADtgj76AUTSJEi6ET2K4BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

In migration_remove_notifier(), g_slist_remove() will search for and
potentially remove an entry from the specified list.  The return value
should be used to update the potentially-changed head pointer of the
list that was just searched (migration_state_notifiers[mode]) instead
of the migration blockers list.

Fixes: dc79c7d5e1 ("migration: multi-mode notifier")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c2daab6bdd..9e787749b2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
         for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
-            migration_blockers[mode] =
+            migration_state_notifiers[mode] =
                 g_slist_remove(migration_state_notifiers[mode], notify);
         }
         notify->notify = NULL;
-- 
2.51.1


