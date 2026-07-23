Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D9C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsn7-0006wr-Nf; Thu, 23 Jul 2026 08:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmsn6-0006wI-7P
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmsn3-0000gM-Rz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784810680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PVEgGZD0a4bNOPMUtuuMmfqj8NAr+4M4g6idRABiZhY=;
 b=GDATL1jCecFttaOJGc/j+ckxcQIQi6l9GmB4GeMo3+aeX/VAvZV8QsLSHdJyP35lsXLeJj
 wbLEiBP8bp9+fyA+qfLsvaln3CrTMkNDm/jdBFOr5brmAiQlgHOQRiH3DcvmXoIdXbrR1f
 lOMXwF5/2p3rbaQRLnkVqWECWDQ+yIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-dY4QxEl-MiumwqRmR_3NQA-1; Thu,
 23 Jul 2026 08:44:38 -0400
X-MC-Unique: dY4QxEl-MiumwqRmR_3NQA-1
X-Mimecast-MFC-AGG-ID: dY4QxEl-MiumwqRmR_3NQA_1784810677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AEEF1945CB6; Thu, 23 Jul 2026 12:44:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1AB721956053; Thu, 23 Jul 2026 12:44:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-trivial@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger long
 running loop in host
Date: Thu, 23 Jul 2026 14:44:32 +0200
Message-ID: <20260723124432.353969-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
basically does:

            x = vmsvga_fifo_read(s);
            y = vmsvga_fifo_read(s);
            args = x * y;
            goto badcmd;
            ...
badcmd:
            len -= args;
            if (len < 0) {
                goto rewind;
            }
            while (args--) {
                vmsvga_fifo_read(s);
            }

Thus by supplying huge values for x and y that overflow the result of
the multiplication, the guest can trigger a long-running loop here
that burns the host's CPU cycles.

Add some sanity checks so that this cannot happen anymore.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
Reported-by: Sunday Jiang
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value

 hw/display/vmware_vga.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f6f9edfd1d9..567806f0e47 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             vmsvga_fifo_read(s);
             x = vmsvga_fifo_read(s);
             y = vmsvga_fifo_read(s);
+            if (x < 0 || x >= SVGA_MAX_WIDTH ||
+                y < 0 || y >= SVGA_MAX_HEIGHT) {
+                goto rewind;
+            }
             args = x * y;
             goto badcmd;
         case SVGA_CMD_RECT_ROP_FILL:
@@ -776,7 +780,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             if (len < 0) {
                 goto rewind;
             }
-            while (args--) {
+            while (args-- > 0) {
                 vmsvga_fifo_read(s);
             }
             printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
-- 
2.55.0


