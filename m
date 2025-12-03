Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764A3D1BDD1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpN-0001iB-4C; Wed, 03 Dec 2025 13:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpJ-0001gW-RC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hA-9U
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37fSXA3673740
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=t/8WC/8W9FdsPsEYza0XQgEda9PqZPLJMpsz9vEOBB8=; b=WVvptEtL54I/
 vLvzHbpp5NiMKV0LShf91PxC9uUA0QlIvT6wo2sRq5Q47aqf8jVLv5Etghrsn35w
 0dVYIA0oFBVG4P1Erp6bxYlY7PMHjxFGjRy2DKUdByz4QhStxMeKjp8NVO4bXs0C
 6oh4ZK2biy0btPjJbfMNHcPSmFQ/AbUYegXy/zGvIjt74i3ThqzrjIxwiUjJiR7b
 e3qsQx8zVZyVyNZv1UpUyI4thnYfPVvzyMurs+ZY/oQArSJOj9dIRbrIbHIMVS3T
 xtrKdqE7zwi6zx5hOpUoE38BO+/yWNmKcKYzxPPER+yt2wwp6ZwHOGwuyjNA28GK
 pRGVlBDYnA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aspcaad57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FSw26013454
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kx8b-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 45AC58D
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:23 -0500
Subject: [PATCH v3 2/8] migration: cpr setup notifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-2-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=1432;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=ybfQKPvFeL2sBlrQktra1uae8irgJMED5+q0/d3iGMY=;
 b=KuATHJ0YFwA02lTa7GWr7HmQr+gItBDTjCuH49zROVE3uVANH5DQWZG2SQlCL9F4vY7KEBeW/
 CJx+PgxkTpDAIfr7eAq73ZHNaAkHMj2b/JPqt+2FRNt9XGV+uidiWy1
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030146
X-Proofpoint-GUID: Zr2Pak1savmau43Wu4QDNH2i3n8SwpiG
X-Authority-Analysis: v=2.4 cv=c5umgB9l c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=9e0HOU0VQPgVKZhTx6MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Zr2Pak1savmau43Wu4QDNH2i3n8SwpiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX3RVyKgFpUhmW
 QD47CDxtjKIifP+QrSfnvp9WKxsJ3waqMSoM2xBNLwMoSfB8E3Wa23j8bhfxoHwhXgA4MjOpjgk
 rm4wk6ZiLgoECCiHH9HyD0eRtbOQMpiCxSTGxWc37VC6/QRwWPZuf8rW39u3Eae9QyIxJN3lTn6
 TtOOl/HXC72lEb2LfS/LK6QeGU+M0jEusjR6lQ+zA0y2Tlo/zMIUdtqHaCQ3IEWsjVlcUpjx2Wh
 S+uWRqzawHsjCPk0zoPPWf0JvTfCGRNs1ZtgdVTzAhm+O8oOvJYYBjxu6vrahZm3QSElkdvBfQ/
 DXN3BT0jDa9tuKl8Z6vXC/OXj1rny0T9NYwy5MWzrMeFIzf2URY9yhOf/cfjBn2t6U8YALru6PB
 1uvuMDP/Kw/Q+efgI1jMt9JIoawfHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Call MIG_EVENT_PRECOPY_SETUP earlier, before CPR starts.  An early notifier
is needed for resetting vhost devices, as explained in the next patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 migration/migration.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6d40697767..60850c232e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2310,7 +2310,14 @@ void qmp_migrate(const char *uri, bool has_channels,
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
 
@@ -4108,11 +4115,6 @@ void migration_connect(MigrationState *s, Error *error_in)
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


