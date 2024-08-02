Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC8C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZlBX-0000f0-B1; Fri, 02 Aug 2024 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k831.kim@samsung.com>)
 id 1sZkhE-0006NI-16
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k831.kim@samsung.com>)
 id 1sZkhA-0006x7-07
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:19 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240802051904epoutp0384a7913f7b42cbe0aff025a78d0da0c1~n0bIAEKN53074930749epoutp03n
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 05:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240802051904epoutp0384a7913f7b42cbe0aff025a78d0da0c1~n0bIAEKN53074930749epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1722575944;
 bh=Gb8B3TXn+xo9h4l6vSboE3RdLHUd/nPBab6r1NkFaV0=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=m3ZDQVrdET3eZ7s5g4hx8bVYLCD6TElEAP5DhZR+2WxT4nqHAGQnXedtutsFqOOz3
 JT+8P6lSyoimg9oAYRpzs+1Dj+C4VGVbQon+YjXUh+hhi/AEZWht6HckgYJqtiVvde
 N81lC3Il44qndvw+NA7ABw7eLapMKqg5eX40QZJ4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240802051904epcas2p4657d6102cf1a37cd71457662ddb530f2~n0bHQ8-ip0256902569epcas2p4F;
 Fri,  2 Aug 2024 05:19:04 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4WZvJR2Dd9z4x9QB; Fri,  2 Aug
 2024 05:19:03 +0000 (GMT)
X-AuditID: b6c32a46-4b7fa70000002752-d3-66ac6c471356
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 B5.31.10066.74C6CA66; Fri,  2 Aug 2024 14:19:03 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] hw/ufs: add basic info of query response upiu
From: Kyoungrul Kim <k831.kim@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kyoungrul Kim
 <k831.kim@samsung.com>, Minwoo Im <minwoo.im@samsung.com>, SSDR Gost Dev
 <gost.dev@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
Date: Fri, 02 Aug 2024 14:19:02 +0900
X-CMS-MailID: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmqa57zpo0gz1v+SxuHtjJZHF/6zVG
 iymbvjJaPDt9gNnieO8OFgdWjyfXNjN59G1ZxRjAFJVtk5GamJJapJCal5yfkpmXbqvkHRzv
 HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0TkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
 q5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndH84B5zwR7hio5j31kaGB/xdzFyckgI
 mEi83fiMpYuRi0NIYAejxKznraxdjBwcvAKCEn93CIPUCAvYScx+/psVxBYSkJO4Pr+bFSKu
 I9Hd/IEZxGYT0JLYeHwjG4gtIqAq8WrxJrCZzALLGCU2zT3LDrGMV2JG+1MWCFtaYvvyrYwQ
 tobEj2W9zBC2qMTN1W/ZYez3x+ZD1YhItN47C1UjKPHg526ouKTEjGNtUPFqiauNu8EWSwh0
 MEq0tD5khUiYS6xcfQmsgVfAV+L2j7dgcRagS+ed2gBV4yKx+dZrMJtZQF5i+9s5zKCAYBbQ
 lFi/Sx/ElBBQljhyiwWigk+i4/BfuLd2zHvCBGErSbRvuwo1UULi2cQLzBCtHhKHX0VAgjBQ
 4v/H2YwTGBVmIQJ6FpK1sxDWLmBkXsUollpQnJueWmxUYASP2+T83E2M4ISn5baDccrbD3qH
 GJk4GA8xSnAwK4nwCp1cmSbEm5JYWZValB9fVJqTWnyI0RTo4YnMUqLJ+cCUm1cSb2hiaWBi
 ZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA9PORPlbC59Uxvc133rozW6s2y+z
 zYvlU5y7iVpYo4XK3l1fG3kX3OB6vpep+5yBSlF6j4joy2tSnznmbVmQn9GRtrPGvez252tH
 /i/J4HxdOTm2iaPLbqKxYtC1pIyP8rfkU9NseqY2663aceVdndGVaxzNa9dPODlXMO/+0pl/
 q5Zez/4XtVvj6e7E64Jcof1HSjuXtVTaHHPjnHuvXVH/+vY3TVfaP29aJ2AfIX2H4cjXJO/V
 0ppaG8OnyLbtz6258GuBUbxg46FYxbMveXg7Ozue+jtKyu24+4N7Q8zZJ1PelUn0bnOyebNS
 PrlhDUexXW+Z9MajMmYXTTwt25yW7bufvyUg49XPnFv9vEosxRmJhlrMRcWJABtE9VoBBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d
References: <CGME20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
Received-SPF: pass client-ip=203.254.224.33; envelope-from=k831.kim@samsung.com;
 helo=mailout3.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Aug 2024 01:50:35 -0400
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
Reply-To: k831.kim@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Modify to fill the opcode, idn, index, selector information of
all Query Response UPIU. because attr and flag operation of query
response upiu need these information too.

Signed-off-by: KyoungrulKim <k831.kim@samsung.com>
---
 hw/ufs/ufs.c | 13 +++++++++----
 hw/ufs/ufs.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 945a0ea127..ce2c96aeea 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -851,6 +851,14 @@ void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
     req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
 }
 
+void ufs_build_query_response(UfsRequest *req)
+{
+    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
+    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
+    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
+    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
+}
+
 static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
 {
     UfsHc *u = req->hc;
@@ -1327,10 +1335,6 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
     if (length > req->rsp_upiu.qr.data[0]) {
         length = req->rsp_upiu.qr.data[0];
     }
-    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
-    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
-    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
-    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
     req->rsp_upiu.qr.length = cpu_to_be16(length);
 
     return status;
@@ -1411,6 +1415,7 @@ static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
     data_segment_length = be16_to_cpu(req->rsp_upiu.qr.length);
     ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_QUERY_RSP, 0, status, 0,
                           data_segment_length);
+    ufs_build_query_response(req);
 
     if (status != UFS_QUERY_RESULT_SUCCESS) {
         return UFS_REQUEST_FAIL;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6c9382cbc4..4bcc41f53a 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -228,6 +228,7 @@ static inline bool is_wlun(uint8_t lun)
 void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint8_t response, uint8_t scsi_status,
                            uint16_t data_segment_length);
+void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 #endif /* HW_UFS_UFS_H */
-- 
2.34.1

