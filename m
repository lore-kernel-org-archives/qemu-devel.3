Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B3FD1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpS-0001l8-Ko; Wed, 03 Dec 2025 13:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpL-0001hW-5J
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:47 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hB-7y
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:46 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B35SO1q2996017
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=iDI9J/2kQZuf9g4MQ4HQ3luovEdJMVHjXyCsvqkM41I=; b=jX4UrqrxRFhd
 rFhEMXlJvrK3QNkmZigJAtfjIl/EiOSsyVjrqYsa1rNeyuojXBN6pxJt9Q/G9AoS
 HUChkD/yhTMuW7P8cF1Z8aV7eHX4aWmeDuDwDSIyw+r0gDmHSFG30VjFhvnTSduA
 vIYac20ZZIG4D43S2o6pCuL8k2+FL0Etn3SOX8vpFv+tTtMjAysd9m+p35q8zKI/
 EG8NbWeCqNmhe55sPODRTl8YxPMqy5TffKu7fcH+7WjIv34ZbFT5KuP6lSNux/bU
 8xTryUJzfWvJd+FTtcgWlMzUWoga/MN+7OkwxJjzH0w+c5XhGvgGQMZqyMOBNzhA
 LNU2DRG2MA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4at1xd1ymx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FEY1E013412
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kx8d-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 4748C94
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:25 -0500
Subject: [PATCH v3 4/8] cpr: delete all fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-4-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=1519;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=Damz0E1eWx9seXrv9+FOKa0jx9R91HPkz/OMuj3AucM=;
 b=53G568mYcarDf1j4BY9VtJEBAima/E69HeeZbmnBSlsZWOXgWhie3vfCGjNJNxjmNZBg0XdrK
 rpftoRJftQ0DSsCezdCQrNMqIvF44hoWAgCxqeYkNCdAX4XLxbmh37D
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=947
 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030146
X-Authority-Analysis: v=2.4 cv=NKrYOk6g c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=n655hgSsutws6UkWyQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kKHsNpMzkg2LPS1uRNnySHzKh-i-a7vk
X-Proofpoint-ORIG-GUID: kKHsNpMzkg2LPS1uRNnySHzKh-i-a7vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX+fs4heUIt9UT
 0wnGgzj4IBUARHUhCvbBLH+8iCU9msNXWhDaR1qwrRRwP8esleHIosD2ojIGDgkt9BLiQDqFStS
 paaNBs1XcsbgrlY8y62qOpYtZZ7INCMLS6ny/Gme+1xsnOAbHwozMbJf/LFKfnjIvNeKhjCWej9
 HjEoKijapTh77WRSrlUXlUZxA+yd6IJPKtM9urrTJGhbX5QXrsUT577F+TGF9wryMM3uou1mw8V
 k3/3BbV5pRRho1f18f+NpVnjSnClq5qlLgA8OHnL9UcVqy7psDscG7PIbHPiBPXN9uj627heJIf
 TwHGEgkW9QxxJhfPIiwmWtz+uyiUnoPoh4aws3WMtgJw88gPHRuVfdxNUUhrNQhmiONTvnpD8uv
 m65bZlA9H7n6DBBlwDIBr6tSCuI/8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


