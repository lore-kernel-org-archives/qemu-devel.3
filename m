Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C764FD46BFB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKj-0008Do-E6; Wed, 28 Jan 2026 15:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKK-0007aq-5V
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKG-00084Q-UT
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:47 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SHTiRw1207698; Wed, 28 Jan 2026 20:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=M6BH2hIUeZbU+CB1JGWLEoI/4w6A4BvK63bGRzusxys=; b=pF2osIAcHYZb
 JcQ41JoX5fKPgP3h3bezDquM0vY4zKJ0Nw3EkK6Wr0/U6Gd9czZezA3wLMsRIJYI
 MOg1HcZlcPnXtsRmtG2KqaKR588IyRgASgzhnBsJzYnPQItdDANG92G9o11s48TY
 YfiIn+YL8hYIRfC/TdgHbLML8ULDipLK+wY/4r3QgM7EGpYaQ0tiZc/at143TNnw
 VTBRVCQ9C4yuiCo9P3fGHeCiXACvAF3n7eDxlCwR57UoSgF/uuPYUknkZFBx1u8j
 kor5KC1rZeM4oseB8Bs52siolpbY1ZCxz5TIKmYdHIuoO9EpywNOMrUK+e3D0R0M
 OSPAG1u0gg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4bw9v9uppq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:40 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SJ3ZeR026882; Wed, 28 Jan 2026 15:39:39 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4bvta3rd2h-1;
 Wed, 28 Jan 2026 15:39:39 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 050819F;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:30 -0500
Subject: [PATCH v4 2/8] migration: cpr setup notifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-2-48e334d4216b@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
In-Reply-To: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=1432;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=TqfXrM/OLXJJheaXufHTgmdq25foyMIiKHT3li/H83w=;
 b=UXClXqc3GMw3lLo7z41lQNIgUKiYBymnynASjf1dU+wUjEqMecuhMsgIOoA15pgWn2g8YzwPk
 S/ywgTs1T+ABYbpDRJ6Kc/2miF3Ndvt49bCBtKqMUGhoeR+TAX7CtjE
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfXwPao9aUxYFJt
 qKz6qiJn35f+EL00PmqV633ZEWu3RlO29iNdFFpPJQEvhUxViIMdoi6DQAOGrF2z7NsF3mYxlJA
 DItUIc/PoLDA7sOza6wS0+JYgdahqxGD1PZ91hHtKP7CfcQl5mKFeL+V5Snm0uA2k+2JnFtblis
 CUPBdMO3o+IRxDPS24qu4wjY87Ix5u2J6gL31YzyZOivr1SaMmBRiTSSJDrojQgFovLC9dp5c58
 9hOiDTGDpkX7DY5IlyuCCXL8yPYTpQSKG0B9ZKqzPSJTnQVFY8Jo39gf4rd9vu/OzNIiwJ0VN+l
 nlwU8jUhJBM+s0mZ33/rLtqWK1n/m0QapDUcQS7Ixyua6lDwE/OFapJy+QOTxoUUdHQoxkLXjS1
 T9i9X3ffCTmFp0VkdNOumvqVbMIjvnWvrFKEIJcFo7rBQAHuUycXidkBHMG6eEQEMWmcl0W7Yeh
 CqtUc5A5eyAa6ALtMhA==
X-Authority-Analysis: v=2.4 cv=TrbrRTXh c=1 sm=1 tr=0 ts=697a740c cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=9e0HOU0VQPgVKZhTx6MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SL2HvEf-R0cPZ7wVi1iNPtEhol0yVjCP
X-Proofpoint-ORIG-GUID: SL2HvEf-R0cPZ7wVi1iNPtEhol0yVjCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280170
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Call MIG_EVENT_PRECOPY_SETUP earlier, before CPR starts.  An early notifier
is needed for resetting vhost devices, as explained in the next patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 migration/migration.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f36e59d9e8..191a34f667 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2306,7 +2306,14 @@ void qmp_migrate(const char *uri, bool has_channels,
         stopped = true;
     }
 
+    /* Notify before starting migration thread, and before starting cpr */
+    if (!resume_requested &&
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+        goto out;
+    }
+
     if (!cpr_state_save(cpr_channel, &local_err)) {
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
         goto out;
     }
 
@@ -4097,11 +4104,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     } else {
         /* This is a fresh new migration */
         rate_limit = migrate_max_bandwidth();
-
-        /* Notify before starting migration thread */
-        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
-            goto fail;
-        }
     }
 
     migration_rate_set(rate_limit);

-- 
2.34.1


