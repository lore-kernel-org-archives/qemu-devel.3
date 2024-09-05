Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940ACC54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRhE-0008BU-At; Fri, 06 Sep 2024 01:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1smRhB-00082y-HD
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 01:39:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1smRh6-0002ij-JM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 01:39:45 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240906053927epoutp024fc1fee41db02a447b1b780654fde1bf~ykR6OvPD61563015630epoutp02Y
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2024 05:39:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240906053927epoutp024fc1fee41db02a447b1b780654fde1bf~ykR6OvPD61563015630epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1725601167;
 bh=u5CsbTpYUJUGDeI2fwtbVmg+NjGQwjc5WBi0JcTaYl4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=vbgTongPx3nuW/+Cp7S3T03aZzBp2lXuG6fltUQzk19p9oQU37QMC4hTTUlIvzygo
 EKZOFRgudF1zNYUS56tn0ETWoU+xgN8fdrilqAl3qWzfya6H32SfPL80fN5jRZw5fN
 WBuFl6emFhUzPKwoocbzWCFnTHxMwE5VWiGQFtgA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20240906053927epcas5p4118786a2ee7226cf346fd6043612c5d3~ykR569pPG2525125251epcas5p4A;
 Fri,  6 Sep 2024 05:39:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4X0Q5p0wqcz4x9Q4; Fri,  6 Sep
 2024 05:39:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2D.FE.19863.E859AD66; Fri,  6 Sep 2024 14:39:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb~ykIn5eA6S1311713117epcas5p2i;
 Fri,  6 Sep 2024 05:28:49 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240906052849epsmtrp1bf4a5819ebbd65f4a5613c3291436055~ykIn423JP0284702847epsmtrp1b;
 Fri,  6 Sep 2024 05:28:49 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-e0-66da958e5285
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 63.A2.07567.1139AD66; Fri,  6 Sep 2024 14:28:49 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240906052848epsmtip202fa27137ddb9af26025c4a17612b6d7~ykImqS7-h2879728797epsmtip2V;
 Fri,  6 Sep 2024 05:28:48 +0000 (GMT)
From: Arun Kumar <arun.kka@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Arun Kumar
 <arun.kka@samsung.com>
Subject: [PATCH] hw/nvme: clear masked events from the aer queue
Date: Fri,  6 Sep 2024 05:28:59 +0530
Message-ID: <20240905235859.3416741-1-arun.kka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmlm7f1FtpBm/WsFjMuW9hcWJKmMX+
 g99YLSYdusZocbx3B4sDq8eUadfYPc7tOM/usWlVJ5vHk2ubmTz6tqxiDGCNyrbJSE1MSS1S
 SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
 0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+DdnMnNBM0fF
 lTfnWBsY/7J2MXJySAiYSMz+/4ixi5GLQ0hgD6PEja2TWSCcT4wSL6bcZ4VwvjFKXHmyjhGm
 ZfWjg+wQib2MEosP/QabJSTQxSTxaGsxiM0moC6xduYOJhBbREBS4nfXaWYQm1kgXuLboqUs
 ILawgIPEg/WvwGwWAVWJK78/gNXzClhLvFj+gx1imbzE4h3LmSHighInZz5hgZgjL9G8dTYz
 yBESAvvYJU4f2w91nYvEn09zWSBsYYlXx7dADZKSeNnfBmXXS5yZuYcJwu5glHj6HSpuL3Fx
 z1+gOAfQAk2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2ksS9rT+hxkhIzLnyHeocD4l3
 vUdZIOETK/G08RfrBEb5WUjemYXknVkImxcwMq9ilEotKM5NT002LTDUzUsth8dscn7uJkZw
 GtQK2MG4esNfvUOMTByMhxglOJiVRHifet5KE+JNSaysSi3Kjy8qzUktPsRoCgzkicxSosn5
 wEScVxJvaGJpYGJmZmZiaWxmqCTO+7p1boqQQHpiSWp2ampBahFMHxMHp1QDk6bxKcEXjuvP
 X5xsbX9raYfRxG2Hcz0CWq6/UQ7/3jaFe8qNABvNT09V1F4Ui27sYbihs+b3Ls6DdplaYtqb
 D+/6UyN0PPCF118xX1vzgxEThac98Dv0bMPxcxsfmixvtuK3UPu5+fo1i4nSB97cqntvcbGP
 IV3lyJX39+Z07I6pbV6amMvy71xhlX5FhtPyBRPZ5/371vP0ZFEbx8xetZXdp2TWJq4+uvTw
 j09z7cW/2i3Jf2RlOyFBK/KBsReDgHPQ0Tk78nQfM9UpnljKGifK12flJbFv0c98myf+F8SY
 1n96cCHk595ZrXrzGZzfbzVZts8qPog1L/WKgehJ19oHpXPVTrfnMB++ca1hvqwSS3FGoqEW
 c1FxIgCW46BYDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvK7g5FtpBpv6JC3m3LewODElzGL/
 wW+sFpMOXWO0ON67g8WB1WPKtGvsHud2nGf32LSqk83jybXNTB59W1YxBrBGcdmkpOZklqUW
 6dslcGX8mzOZuaCZo+LKm3OsDYx/WbsYOTkkBEwkVj86yN7FyMUhJLCbUeLflHeMEAkJiR9f
 vkHZwhIr/z2HKupgkmju2cUMkmATUJdYO3MHE4gtIiAp8bvrNFCcg4NZIFni9Q9fkLCwgIPE
 g/WvWEBsFgFViSu/P4CV8wpYS7xY/oMdYr68xOIdy5kh4oISJ2c+AatnBoo3b53NPIGRbxaS
 1CwkqQWMTKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYLDUUtjB+O9+f/0DjEycTAe
 YpTgYFYS4X3qeStNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkm
 Dk6pBqaji8vrJe59vz/XWk2A64hsWuhj1fdBYmovGQ7l1p8VD1+6V+fJd8n5+9skFiVuC72e
 1BTPyC4jnZG1vvjpKsNOtcXP7ObeuFuhHzxvwXK9vvSYmVK6Rh9vR+QH37/Z9OvFLWGef45u
 elODTu9ytbq24WZDS9PGd1fLi9f/+/mLZUdchdStNVYLxB4Yvzw0Kzlzx+yIKxJr7xhcv8Hy
 N5dppXmm9bSMFXuvtE5T/nhJIDywe/9Gz6JfZ2K1vctF2k1DfthXuJnXz43hqTN5tfmRjMMZ
 W7YZvbtjd94ON1jE7nls9ZEQ2TqmkL0ftC+dXixTGWd+LfLjzpgZM+v4/0y9+Ciq4uOKNp1s
 W9MNyiVKLMUZiYZazEXFiQDLtmfltgIAAA==
X-CMS-MailID: 20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb
References: <CGME20240906052849epcas5p2602787ff0700a8feca81ad173f957ffb@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25; envelope-from=arun.kka@samsung.com;
 helo=mailout2.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.142, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

clear masked events from the aer queue when get log page is issued with
rae=0 without checking for the presence of outstanding aer requests

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
---
 hw/nvme/ctrl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..85039779da 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1649,9 +1649,16 @@ static void nvme_smart_event(NvmeCtrl *n, uint8_t event)
 
 static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
 {
+    NvmeAsyncEvent *event, *next;
     n->aer_mask &= ~(1 << event_type);
     if (!QTAILQ_EMPTY(&n->aer_queue)) {
-        nvme_process_aers(n);
+        QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+            if (event->result.event_type == event_type) {
+                QTAILQ_REMOVE(&n->aer_queue, event, entry);
+                n->aer_queued--;
+                g_free(event);
+            }
+        }
     }
 }
 
-- 
2.43.0


