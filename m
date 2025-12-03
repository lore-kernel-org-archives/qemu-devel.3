Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8604AD1BDD1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwr-0007TM-Cg; Wed, 03 Dec 2025 13:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwp-0007R3-Ja
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwn-0000zQ-Bg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
 by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B3HaD9k365124; Wed, 3 Dec 2025 18:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=t/8WC/8W9FdsPsEYza0XQgEda9PqZPLJMpsz9vEOBB8=; b=ZjbO1FblYWdt
 9uwR0d9nrRpvLrlGXPdoWDn+uxKFoIINk+UhC49yBqxySNPf39DtUvpe/DknWhHx
 F88/f+hAMm/hV4viuWCJFnMmfNiqE+9w9mTfzcjcBnEJgut++qNfv38FbxOi8KCJ
 ZXp1sQi19V6GFmCF56G3yDDh8pzYxp5/RD+xbZihiu0ofezHqWzCvJRlceQ9Cu3E
 hjX74b8sjxfIoNeRgRGv2SHv+K3h3UztkSa+pz5+yMz367GR8l/zxasnS+vVKQ8j
 CdO2Y4WHGmwEsBHjAxI40RkmovVPU8Vd5pDrjypBE8uwqzwKF9R5V2gg/uFBvv15
 KZyobEHV5Q==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4at31m8y0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FFwRH029135; Wed, 3 Dec 2025 13:51:26 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4aqw21kuh7-1;
 Wed, 03 Dec 2025 13:51:26 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id A1B5094;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:19 -0500
Subject: [PATCH v3 2/8] migration: cpr setup notifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-2-3c12e0a61f8e@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=1432;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=ybfQKPvFeL2sBlrQktra1uae8irgJMED5+q0/d3iGMY=;
 b=rg7zTjfT3ixnbbFdX2jzPZ/ISY6BkmHvB+4CRKRmZwTQh2JA3SldPyqy8PGjcJKH6L+B+IzbQ
 YomMPLzKLJmBFvJQykbYnCYLXt1TBxPPdC8j6bdqa05gRbj20+MWiCD
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-GUID: rHBQMF77W4e5ezlpkbQaGCRR5cRxmGsc
X-Authority-Analysis: v=2.4 cv=I6Nohdgg c=1 sm=1 tr=0 ts=693086af cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=9e0HOU0VQPgVKZhTx6MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rHBQMF77W4e5ezlpkbQaGCRR5cRxmGsc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX6stM5Kuyw+v+
 sEfy4AwwAmNyi1icEJqliZZNLz4se99mlCrEr+KY9Oyz02++3wyFjAxLbBgQuZDUt3KWOgSaWMo
 6FbAU8bRPaK74dmv6ticmg2jVhHjlzgiNebvzE4WtanxdDI/LD15MttMrZr7kCkoryCKCh9Hhyv
 /VSzVKPp/zz3bAt80fzUgY8Ba77ggUtUyd4cxiogYzA+RzvxKK9HFiu82PaOe5ZDwO7D95X3EQ+
 /q2HJGTSy9vIRIAw3uGVaDzmTDJGk9rPXg1PtfEzwC0jYIGvfhj0gZmSVVAYd4qCWXEwiygGcg/
 DQnDpukTwnPjpCPxhjldYPOhWsUUtcFDNHnU6DgS4iE1/NQLXsHCBILrl/lG8AxxUZdeVIjLCi6
 SrAykQQJiJcUvUA7y68O8wllPaXbmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


