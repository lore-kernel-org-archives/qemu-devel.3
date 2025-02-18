Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CC2C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJgj-0005yl-OL; Tue, 18 Feb 2025 04:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tkJgi-0005ya-64
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:14:44 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tkJgd-0006hX-E2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:14:43 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250218091430epoutp04c796d3f0215da74558be90f80dc6700d~lQpxVh8lw0650906509epoutp04P
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:14:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250218091430epoutp04c796d3f0215da74558be90f80dc6700d~lQpxVh8lw0650906509epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739870070;
 bh=HcZHltFL7jn1Mql4lVVdvfwYZ6LbevSpFPN2Ve7VETM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JXFdg4GjQH05gQKB4S1QA9/lRWC+g7FS6Xgr/HPWcNUwY/IX5CmmLIQkgYRZvpEK7
 x2EVC2hxpWm5C0qIpQPWJvqk4kRdEoDuHOeCqEqtpdJWt0whqUSiW1SksygySYheTx
 Ln9eBwqMzk+pIxzQ965gHdgePKhf7KTrRZIS75ao=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20250218091429epcas5p24e55180c10ec70523481cda98af26100~lQpw_uew31780717807epcas5p2k;
 Tue, 18 Feb 2025 09:14:29 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Yxv3l1hjnz4x9Q7; Tue, 18 Feb
 2025 09:14:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 60.7E.19710.37F44B76; Tue, 18 Feb 2025 18:14:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250218085812epcas5p3981d9649c89f876d59724a24c0ed8d80~lQbipeBry1166411664epcas5p3n;
 Tue, 18 Feb 2025 08:58:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250218085812epsmtrp18f0c5a59d732f9358b2a8cf5bdc9fcf6~lQbiorSRH0197301973epsmtrp1R;
 Tue, 18 Feb 2025 08:58:12 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-3b-67b44f739f8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DC.0E.18949.4AB44B76; Tue, 18 Feb 2025 17:58:12 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250218085810epsmtip17068f6c2cd445cd3b5c4c724710cda67~lQbhMmSLW1084010840epsmtip1Y;
 Tue, 18 Feb 2025 08:58:10 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils.c: Added support for Clear
 Log (Opcode 0403h)
Date: Tue, 18 Feb 2025 14:27:30 +0530
Message-Id: <20250218085731.550029-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085731.550029-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpm6x/5Z0g96D3BbTDytafDm9h82i
 d/ESVovVN9cwWtw8sJPJYuHGZUwW52edYrH4u20vo8Xx3h0sQO4cdgcuj52z7rJ7PLm2mcmj
 b8sqRo+ps+s9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
 tVVy8QnQdcvMAbpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCd8fDRA5aCV0IVT5cuZ29g7OXtYuTgkBAwkWg4I9vFyMUhJLCbUWJx
 8wEmCOcTo8Tl2TOYIZxvjBI7Tv8EcjjBOq4sWgqV2Mso8eDGD7CEkEADk0TPbCkQm01AR+L8
 7blsILaIgKTE767TYA3MAm+AGq4uAGsQFkiQ+DfpApjNIqAq8e38JVYQm1fATuLB5CYWiG3y
 EvsPngWr4RSwl7j9/js7RI2gxMmZT8BqmIFqmrfOhrruJ7vE18cxELaLxK3Nv1khbGGJV8e3
 sEPYUhIv+9ug7GyJP/Pb2SDsAolFP2dCxe0lWk/1M4PCiFlAU2L9Ln2IsKzE1FPrmCDW8kn0
 /n7CBBHnldgxD8ZWk2jfMR9qjIzEm1+LocZ7SDzZ188ICbhJjBLzX69insCoMAvJO7OQvDML
 YfUCRuZVjJKpBcW56anJpgWGeanl8EhOzs/dxAhOplouOxhvzP+nd4iRiYPxEKMEB7OSCO+h
 rg3pQrwpiZVVqUX58UWlOanFhxhNgeE9kVlKNDkfmM7zSuINTSwNTMzMzEwsjc0MlcR5m3e2
 pAsJpCeWpGanphakFsH0MXFwSjUwBSWyi2bI3+w1ezXJJOV+ns7E961cP24dYPlv9OMV36Q7
 ebKZEtO0TrX/4zZtCA5mSli63io7J6zyhNQ8R8GsopjVXD80/FfK6/y1V8+PsPf559hkOPXi
 iukvPXl+MPtc+atq4SEnp514+3vUg/X71uimvMtPqPr9UNNBeWLw5sRgjZ/3n+0w3/BlpV7B
 Mp3c8N43qkGMHUmqWT5XGp4tCd/gy9304UoWS0z1lZ/6UcdPPC6wlhDc1q598Rv3E4s/6vPm
 cQi9FxbcpvzkRcRGn8Aix9JH4qw+j9w0yta/DpkZ/2/HhirjVbsdGiXWlRS9DuHol+rSEeAN
 +zDN4vU+p+vbJ9Xd7j3QLcjKe0KJpTgj0VCLuag4EQB1PDuwLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnO4S7y3pBot+CFlMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSvj4aMHLAWvhCqeLl3O3sDYy9vFyMkhIWAi
 cWXRUuYuRi4OIYHdjBIHrn1lhUjISFyc+ZgFwhaWWPnvOTuILSTwj1FiyXo2EJtNQEfi/O25
 YLaIgKTE767TYIOYBb4xSsy59QJoEAeHsECcxK0TKiA1LAKqEt/OXwKbzytgJ/FgchPUfHmJ
 /QfPMoPYnAL2Erfff4faZSexoesvI0S9oMTJmU/A6pmB6pu3zmaewCgwC0lqFpLUAkamVYyS
 qQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYweGupbWDcc+qD3qHGJk4GA8xSnAwK4nwHura
 kC7Em5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QD0yaWc+F8
 vdYKbPUBC77WzDzB8PHEw83LQsUSVVxXCv3sNb5682vZpFKp7asiHVTC5wTXSAR+qPNteXpX
 Wirg69vCm7syZE2OLtzzXU7UoFDX/kJYVC2TdP372YY3Bb/dW/SGgfdM6Xq2tCt8p5/fnvaP
 5zPvsc9Lqn9GshsX/DvdMiWnqzyKe4OftOjTNu71l+YsbXOU+HZp587I4IwvPocM7u182xH+
 3rfTjUs21mWTqsh0m4fHG7z5ed+/bOblOqk7O7hay+Ok2sOV7p3GOTab+BsYjq1PVWS1PFR+
 pt9rz86ly2//rq8MfL79fDX3JkHDZWvmchq7flyhm7Q3m3XfN/Ygo6R5isb7j8VfVWIpzkg0
 1GIuKk4EAOGfQoXmAgAA
X-CMS-MailID: 20250218085812epcas5p3981d9649c89f876d59724a24c0ed8d80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218085812epcas5p3981d9649c89f876d59724a24c0ed8d80
References: <20250218085731.550029-1-arpit1.kumar@samsung.com>
 <CGME20250218085812epcas5p3981d9649c89f876d59724a24c0ed8d80@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CXL spec 3.2 section 8.2.10.5.4 describes clear log.
It clears the content of the specified log.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5b0f793ac5..1caee3f058 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -77,6 +77,7 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
         #define GET_LOG_CAPABILITIES   0x2
+        #define CLEAR_LOG     0x3
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1113,6 +1114,30 @@ static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 Section 8.2.10.5.4: Clear Log (Opcode 0403h) */
+static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
+                                     uint8_t *payload_in,
+                                     size_t len_in,
+                                     uint8_t *payload_out,
+                                     size_t *len_out,
+                                     CXLCCI *cci)
+{
+    const CXLLogCapabilities *cap;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * clear_log = (void *)payload_in;
+
+    cap = find_log_index(&clear_log->uuid, cci);
+    if (!cap) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    if (!(cap->param_flags & CXL_LOG_CAP_CLEAR_SUPPORTED)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2880,6 +2905,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
                                      cmd_logs_get_log_capabilities, 0x10, 0 },
+    [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
+                          CXL_MBOX_IMMEDIATE_LOG_CHANGE},
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
-- 
2.34.1


