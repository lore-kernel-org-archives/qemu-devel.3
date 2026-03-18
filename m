Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2767A1077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2w3H-0002zK-3Q; Wed, 18 Mar 2026 14:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3E-0002yT-Fr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:28 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3C-00070T-Rf
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:28 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 49ED080241C;
 Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (trex-green-1.trex.outbound.svc.cluster.local [100.117.57.254])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id EDF84801090;
 Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773860124;
 b=w3RT5iz6nqau5+vo6cx0W77qvxFSDI0svTT03q/fLgMhobZst1aTrWIBVK62+MLE9KU+7+
 gUYtnRnE/A4UTOPyVpUesMGa/NXIMUPSdsi7QQKlE+7FftHP5S70d3V/z3zGuzaN+opDzs
 DXCxxcabGo7roYJEpuXo8yHEsVTmXg40R/Evs2rt4LA6iArRcZ82JbRFPLrAnkOPPYAfMm
 wdcYbFXvTOZHEZm26mrT1DA5bMm72nhFX6zdo12cyZwSyuJ1H8HItGob5MRGYe7o0TzqRW
 B4roWahgivxmO4Fvg4SHh1crl15x1quvLSPtlVlk41XAXhRXTni57fP63ifGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773860124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
 b=2XGEtXkK6vx44/spkMQeOgDz6P1jdVGTSmnyrLBYHbQIx+muZ7lk2IUs654fIAnAWEUaJ7
 PuCmo+rnkIXr0r7QcAGocTTHiEohB8S8rLlau5VLxa+QqUQueCmGVfdvNEt6ArQ8IBOwUt
 Bciu63Vj0gdlbg29TboJDO5zXv3C5WKKX1LUQay5HYA5oiyfU5bP/1VuWsLx00IRTGU7nv
 +R/Puzqk7ecf61QMfeHAS2ezFaHLJY/fMQaSPz8T2oG0oGZTxvd2O1H33Agu+22RQa/vyI
 VnkpRP+3Gj9/j+HTUvrPCOXylYj/rN+gi4arM1pAPkwTycGEz0F6hGRb8GR+1Q==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-tplqm;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Army: 32f9276553bdffee_1773860124203_2027179416
X-MC-Loop-Signature: 1773860124203:338686361
X-MC-Ingress-Time: 1773860124202
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.57.254 (trex/7.1.5); Wed, 18 Mar 2026 18:55:24 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg3dWJz103R;
 Wed, 18 Mar 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773860123;
 bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=a6PZ3WaaQNcrXfGLdzcipZDB25eg5nHDwMtbxwHOp1xG/DDxuhjhQOOH/xBCgFZCD
 wIjw7/Gsp/GeaIRfpsDa5a26Ck5WyrRuYTJdEAocZWRiRiYUxaE1Gv+0eGeN5eeKVa
 4koxDKcO9QE/1x37mKFIM9vITs4/UyX42Rv0mJbdt/oq/tR64HcY75ajh76853ssS/
 YMur9QJa9gnWDUQ25yN1zliG6bV2c23ZRrcgyZKNfH909Oz6hitJ4zFPlgt4K0qNrR
 QDkaQkD9UkvJIco+98BGx1/5i0Elk0hc5as2QeZC0U6zeVu+C9cFmVx1/y8IqHA6QB
 DacNAWz5ybQjQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery
 semantics
Date: Wed, 18 Mar 2026 11:55:07 -0700
Message-Id: <20260318185508.3683044-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318185508.3683044-1-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.209.27; envelope-from=dave@stgolabs.net;
 helo=butterfly.birch.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

The Discovery handler rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a3143f3faa23..71a012121c87 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,6 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
+    int total = ARRAY_SIZE(media_op_matrix);
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2609,24 +2610,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        start_index >= total) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
     media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
-    media_out_pl->total_supported_operations =
-                                     ARRAY_SIZE(media_op_matrix);
-    if (num_ops > 0) {
-        for (i = start_index; i < start_index + num_ops; i++) {
-            media_out_pl->entry[count].media_op_class =
-                    media_op_matrix[i].media_op_class;
-            media_out_pl->entry[count].media_op_subclass =
-                        media_op_matrix[i].media_op_subclass;
-            count++;
-            if (count == num_ops) {
-                break;
-            }
-        }
+    media_out_pl->total_supported_operations = total;
+
+    num_ops = MIN(num_ops, total - start_index);
+    for (i = 0; i < num_ops; i++) {
+        media_out_pl->entry[count].media_op_class =
+                media_op_matrix[start_index + i].media_op_class;
+        media_out_pl->entry[count].media_op_subclass =
+                    media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.39.5


