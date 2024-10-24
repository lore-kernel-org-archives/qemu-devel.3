Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83161D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 06:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3rRs-0002Mg-LG; Thu, 24 Oct 2024 02:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRr-0002Lu-1t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRp-0003TM-Lc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729751753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbhhRUF62kOLvxWM5hzY8wOq5z3/LLYtRuVsdsVtn0A=;
 b=Xb4bak0AkSS8RZOkRuSLs+ci5F2p19yCVsJZrsq8VJuNpbh79bfpyqmE37H5VIZVYt4bFp
 5qpcT7m5WbVGryk/4s9xun2Zt2LXNeSjgHruiRONwvHjJqwAPNcLAlmH+rZYg7QpPjNjF4
 1pPzQKgPpAMmPeddxGB8Nlx23KghSOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26--n86GMDZNvCg4ThqfmOtww-1; Thu,
 24 Oct 2024 02:35:47 -0400
X-MC-Unique: -n86GMDZNvCg4ThqfmOtww-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7F51955D42; Thu, 24 Oct 2024 06:35:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05BE91956056; Thu, 24 Oct 2024 06:35:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/17] hw/block:m25p80: Support write status register 2 command
 (0x31) for w25q01jvq
Date: Thu, 24 Oct 2024 08:35:03 +0200
Message-ID: <20241024063507.1585765-14-clg@redhat.com>
In-Reply-To: <20241024063507.1585765-1-clg@redhat.com>
References: <20241024063507.1585765-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

According to the w25q01jv datasheet at page 16, it is required to set QE bit
in "Status Register 2" to enable quad mode.

Currently, m25p80 support users utilize "Write Status Register 1(0x01)" command
to set QE bit in "Status Register 2" and utilize "Read Status Register 2(0x35)"
command to get the QE bit status.

However, some firmware directly utilize "Status Register 2(0x31)" command to
set QE bit. To fully support quad mode for w25q01jvq, adds WRSR2 command.

Update collecting data needed 1 byte for WRSR2 command in decode_new_cmd
function and verify QE bit at the first byte of collecting data bit 2 in
complete_collecting_data.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/block/m25p80.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 3f55b8f38561..411d810d3b1b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -430,6 +430,11 @@ typedef enum {
     RDCR_EQIO = 0x35,
     RSTQIO = 0xf5,
 
+    /*
+     * Winbond: 0x31 - write status register 2
+     */
+    WRSR2 = 0x31,
+
     RNVCR = 0xB5,
     WNVCR = 0xB1,
 
@@ -821,6 +826,15 @@ static void complete_collecting_data(Flash *s)
             s->write_enable = false;
         }
         break;
+    case WRSR2:
+        switch (get_man(s)) {
+        case MAN_WINBOND:
+            s->quad_enable = !!(s->data[0] & 0x02);
+            break;
+        default:
+            break;
+        }
+        break;
     case BRWR:
     case EXTEND_ADDR_WRITE:
         s->ear = s->data[0];
@@ -1280,7 +1294,31 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         s->pos = 0;
         break;
+    case WRSR2:
+        /*
+         * If WP# is low and status_register_write_disabled is high,
+         * status register writes are disabled.
+         * This is also called "hardware protected mode" (HPM). All other
+         * combinations of the two states are called "software protected mode"
+         * (SPM), and status register writes are permitted.
+         */
+        if ((s->wp_level == 0 && s->status_register_write_disabled)
+            || !s->write_enable) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Status register 2 write is disabled!\n");
+            break;
+        }
 
+        switch (get_man(s)) {
+        case MAN_WINBOND:
+            s->needed_bytes = 1;
+            s->state = STATE_COLLECTING_DATA;
+            s->pos = 0;
+            break;
+        default:
+            break;
+        }
+        break;
     case WRDI:
         s->write_enable = false;
         if (get_man(s) == MAN_SST) {
-- 
2.47.0


