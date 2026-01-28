Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0F7D46BFB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKQ-0007m9-WD; Wed, 28 Jan 2026 15:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKI-0007Xf-Ra
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKG-00084b-Ua
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:46 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SKOMP2615999; Wed, 28 Jan 2026 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=iDI9J/2kQZuf9g4MQ4HQ3luovEdJMVHjXyCsvqkM41I=; b=odoW25ii+AK6
 G5Y0zu+NjXPHNl0cnYkUGWTYtitNwsAfWOjzRnMJzDWgcs7VVI6nco817aN+knya
 KihR0/HU66106CKkMe4zc2YM6SeMplrKZ3ZyPErZAmN00Q3VQ4nqEcHAkJ9M2sqh
 d9l3WwnzOPe52kwov+Jeq8JLdtO+wN8DpYkJJToWhGjFsMXK8ee/Sl/U4pRZAkTq
 WIlUGgX64v4plndjYt/TubndSEtFpfAd5gCIHLcxl9z1y4sSoQeSGdJ+pCKdnCLU
 dksrZmVeezXSe2hAyaLdtp+zGVq9t2xm/iK7BNFr5Z8pLFgzDydhIYfwhp+I9DT0
 15dTjRHI/A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4by2u0y6eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:40 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SHaNpM027792; Wed, 28 Jan 2026 15:39:39 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4bvta3rd2k-1;
 Wed, 28 Jan 2026 15:39:39 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 0D7B3A7;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:32 -0500
Subject: [PATCH v4 4/8] cpr: delete all fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-4-48e334d4216b@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=1519;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=Damz0E1eWx9seXrv9+FOKa0jx9R91HPkz/OMuj3AucM=;
 b=x1cN8t23lCcrsd9ATgVEADXMH2Ex1PmIj57S03giHvMWvtxqK1wwGKQimEUHewMQzVgZhAadT
 vA+xYoy2CnSDzrGPp53+wxvPmojCoGwboWGwtuDrJNE4/G+DbIomZ3Z
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
X-Authority-Analysis: v=2.4 cv=OOkqHCaB c=1 sm=1 tr=0 ts=697a740c cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=n655hgSsutws6UkWyQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7uUafde4TSqvnZWBDiNjzX5zSAXAh5JW
X-Proofpoint-GUID: 7uUafde4TSqvnZWBDiNjzX5zSAXAh5JW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfX4Aq7WLolcLtz
 Aqm5eN2L+7jrTss01Chy/RcqW/mpZoTtgsPkjKm+bqYDQYg1CHhlnhYC+6kH5y9Die+75uepG03
 wPton7X0rXCvzmbmVfNYd6XjdbbGK0EngXGqKmRxZ0+XR2DySPcAtWb0fDsASZu+NOyesd9MvIb
 zPWcMpZdtix0uFCHNZr8AthiVyorYgUkl4MmlYKHFo3OcVIQYa3KLFMATM0Pq6NXvXqfkYW4Kbx
 BrIizCMlaCp0BoMFTLlBbhea6v//SbEcw/D52wtvs1Uiwt68ncjfhsN1jsVhqr4/PdFNS0sr7cY
 HEgjw2BjUspehZPUtqzv09U+snYm+8xPKlk+dsCYtF1E9tvKlXvMjGuBIWhjGJxXtE3OMYy3dAP
 FKUxXQfw4570FraynSEVvbHODZ8C3GLWrHG1mgZ+PbVNIE3t27Sw+cKsYDBelRds/CETlFQvLuH
 Z0OnCcAXqduVy+bOpKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280170
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
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

Add the cpr_delete_fd_all function to delete all fds associated with a
device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 include/migration/cpr.h |  1 +
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 027cb98073..d585fadc5b 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -29,6 +29,7 @@ extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
+void cpr_delete_fd_all(const char *name);
 int cpr_find_fd(const char *name, int id);
 void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
diff --git a/migration/cpr.c b/migration/cpr.c
index adee2a919a..c0bf93a7ba 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -85,6 +85,19 @@ void cpr_delete_fd(const char *name, int id)
     trace_cpr_delete_fd(name, id);
 }
 
+void cpr_delete_fd_all(const char *name)
+{
+    CprFd *elem, *next_elem;
+
+    QLIST_FOREACH_SAFE(elem, &cpr_state.fds, next, next_elem) {
+        if (!strcmp(elem->name, name)) {
+            QLIST_REMOVE(elem, next);
+            g_free(elem->name);
+            g_free(elem);
+        }
+    }
+}
+
 int cpr_find_fd(const char *name, int id)
 {
     CprFd *elem = find_fd(&cpr_state.fds, name, id);

-- 
2.34.1


