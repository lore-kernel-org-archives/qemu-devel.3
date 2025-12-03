Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E799D1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwr-0007Tv-Uc; Wed, 03 Dec 2025 13:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwq-0007SZ-E5
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:32 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwo-0000zq-5B
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:32 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37fSXO3673740; Wed, 3 Dec 2025 18:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=iDI9J/2kQZuf9g4MQ4HQ3luovEdJMVHjXyCsvqkM41I=; b=nvx+pTE8vwzI
 2gD1ms4hLUZYr/nfhI/HAiKANBntZlJZeGAO3pgJXWupg4HtyEhwTRIpuZHFtzmb
 nVZCf7CLBbz4bUGufdM+en6ykC9nd3bBoGFY/FIBEi11Qluo0kwZvvgSfOtf2iiU
 NIqSHc4PMa+ok4zyE7dyxqyc7xupq426fnKU3uoUAqYZYNDjBnBkbcNNU2Xd9EUr
 XPT+PqwhA5iGqUHOT3+096TnBS4aevahRWzQavXva+YA2VrzyLUzOwYy4JD+ptnh
 hFuLw+Wkp5wJscQ8RQ9dwq6IwVzEcZ2hzaJmetoUYsP0SKNU9oH7mj6R8Xef2ENO
 Y74MXHvIfQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aspcaafqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3Fjee0029587; Wed, 3 Dec 2025 10:51:27 -0800
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4aqypdkm40-1;
 Wed, 03 Dec 2025 10:51:26 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id B0FAD9C;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:21 -0500
Subject: [PATCH v3 4/8] cpr: delete all fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-4-3c12e0a61f8e@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=1519;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=Damz0E1eWx9seXrv9+FOKa0jx9R91HPkz/OMuj3AucM=;
 b=jWF0pcBBUYtCUa/z42DoxeJeZNgPPoR2VI14vXymAm4iU02JIen8LSSLM22ipL3ND7Soc+m98
 f0NxkFp6bDnALaj4tL+SD1V73BM5t1tdI2Y3SfZ7k6cmZ0maI5+P6ur
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512030148
X-Proofpoint-GUID: vuWFN3Ek-Ad1NLybjK4zzAUsSBHQ8uGd
X-Authority-Analysis: v=2.4 cv=c5umgB9l c=1 sm=1 tr=0 ts=693086b0 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=n655hgSsutws6UkWyQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vuWFN3Ek-Ad1NLybjK4zzAUsSBHQ8uGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0OCBTYWx0ZWRfX17ttQeV5tjmg
 AICkf9hTAbxcUZx0Lb9mPAVkhlWp2Wn/05UUnPtbdBtlCWo24N3ikX5e4SjEjCRoB7O5bQrpIXZ
 RqOi2MxBUyAm2NXqY8mifa73k4FWTgeoElWX6s8nCcmtCwjonn4/AaOhxQDFrETGf6HSjsop1I1
 rJqXzRgheKBA1N5dnQ+OaCmC7SobRviVbMWflKhY/p0SdCeQMG12aAlYb6A/kGqRNVDT7B2axa0
 Xy3/H2gEITZESG44lGzIMstcH9HxiP7SryVBiOiKmNj4kv8DXb4X984isCYHYW7SCZIhz5BCPnO
 cOeyv8m1o50wK5hXW6oiJZABlIl0QypFKrAcqc87XL4s2oGxC/eRpsnLIXZ5UNfZftht6zZKUE9
 YeYkcxfqi4c08sW1hnl6hmUnbFSLmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030148
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


