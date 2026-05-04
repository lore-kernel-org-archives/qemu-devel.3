Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA701CD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 21:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK0w6-0006FA-NZ; Mon, 04 May 2026 17:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wK0w5-0006Es-QA
 for qemu-devel@nongnu.org; Mon, 04 May 2026 17:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wK0w4-0003Xn-AJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777930479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2z7DVl8CCKbYIE4KyajwhLcUk4shKNW2AynvfwhNHY=;
 b=I5l4yB0pAGx2yQ5qG4OiI9RnBZm4xDMdtMGRxy8AsGcyw8AtmHLK/RHNGQPejPPuS8LWDj
 qY2RgXBrmJM9xruTdnalAOPokuhEXqmZKRUj0Htcmp99R9icJowqP+NAe79jdcpbefc4m9
 YU1Fi4rPc+o5ZGZ5BB147Xdyfxv9JtM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-xgeizsITNj66w0IiGniUJg-1; Mon,
 04 May 2026 17:34:36 -0400
X-MC-Unique: xgeizsITNj66w0IiGniUJg-1
X-Mimecast-MFC-AGG-ID: xgeizsITNj66w0IiGniUJg_1777930474
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41FEB1800366; Mon,  4 May 2026 21:34:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.208])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A58B1944CED; Mon,  4 May 2026 21:34:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] aspeed/hace: Prevent total_req_len overflow
Date: Mon,  4 May 2026 23:34:21 +0200
Message-ID: <20260504213421.710035-3-clg@redhat.com>
In-Reply-To: <20260504213421.710035-1-clg@redhat.com>
References: <20260504213421.710035-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In accumulate mode, total_req_len is incremented with plen (hwaddr)
for each hash request. Repeated additions can overflow total_req_len
(uint32_t) and potentially bypass validation checks in has_padding().

Add a helper function to detect overflow before incrementing
total_req_len and reject the request if overflow would occur.

Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Cc: qemu-stable@nongnu.org
Fixes: 5cd7d8564a8b ("aspeed/hace: Support AST2600 HACE")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index ef698b3ecb72..0504d61cbf0a 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -205,6 +205,19 @@ static uint64_t hash_get_source_addr(AspeedHACEState *s)
     return src_addr;
 }
 
+static bool hash_accumulate_len(AspeedHACEState *s, hwaddr plen)
+{
+    if (plen > UINT32_MAX - s->total_req_len) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: total_req_len overflow, current=0x%x, adding=0x%"
+                      HWADDR_PRIx "\n", __func__, s->total_req_len, plen);
+        return false;
+    }
+
+    s->total_req_len += plen;
+    return true;
+}
+
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
                                    bool acc_mode, bool *acc_final_request)
 {
@@ -232,7 +245,9 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
     iov_idx = 1;
 
     if (acc_mode) {
-        s->total_req_len += plen;
+        if (!hash_accumulate_len(s, plen)) {
+            return -1;
+        }
 
         if (has_padding(s, &iov[0], plen, &total_msg_len,
                         &pad_offset)) {
@@ -299,7 +314,9 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
 
         iov[iov_idx].iov_base = haddr;
         if (acc_mode) {
-            s->total_req_len += plen;
+            if (!hash_accumulate_len(s, plen)) {
+                return -1;
+            }
 
             if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
                             &pad_offset)) {
-- 
2.54.0


