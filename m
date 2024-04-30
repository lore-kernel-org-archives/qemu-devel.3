Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E7EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgv-0001Jq-Cg; Tue, 30 Apr 2024 03:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgu-0001H2-AT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgs-0008TA-IZ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVZHVKB4XOye1r0UpampAYDzJMQhwGS855vybvZIBcc=;
 b=gx8Gi6TMR+KZbvUrTLvgWsU9HOTJare88NbCIRotNYGF9Yy1uauSpYArHXxOtdAMaYNlEH
 GAcCVg5PYiQrGvrykIZnu0y3rUA3nE9ZJL8HqxMFhbL0wG41cRCzXwPAo+0Bl/m3tGmqeR
 yhaK5fAAgvcbqkqCtIxQFXayRa8ZN5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Lnwhd-fuPquCB8CZmxskKA-1; Tue, 30 Apr 2024 03:14:10 -0400
X-MC-Unique: Lnwhd-fuPquCB8CZmxskKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E454B80021A;
 Tue, 30 Apr 2024 07:14:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32D6140B497D;
 Tue, 30 Apr 2024 07:14:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Lev Kujawski <lkujaw@mailbox.org>
Subject: [PULL 16/19] hw/ide/core.c (cmd_read_native_max): Avoid limited
 device parameters
Date: Tue, 30 Apr 2024 09:13:37 +0200
Message-ID: <20240430071340.413305-17-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Lev Kujawski <lkujaw@mailbox.org>

Always use the native CHS device parameters for the ATA commands READ
NATIVE MAX ADDRESS and READ NATIVE MAX ADDRESS EXT, not those limited
by the ATA command INITIALIZE_DEVICE_PARAMETERS (introduced in patch
176e4961, hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS
command, 2022-07-07.)

As stated by the ATA/ATAPI specification, "[t]he native maximum is the
highest address accepted by the device in the factory default
condition."  Therefore this patch substitutes the native values in
drive_heads and drive_sectors before calling ide_set_sector().

One consequence of the prior behavior was that setting zero sectors
per track could lead to an FPE within ide_set_sector().  Thanks to
Alexander Bulekov for reporting this issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1243
Signed-off-by: Lev Kujawski <lkujaw@mailbox.org>
Message-ID: <20221010085229.2431276-1-lkujaw@mailbox.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index e8cb2dac92..08d9218455 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1623,11 +1623,24 @@ static bool cmd_read_native_max(IDEState *s, uint8_t cmd)
     /* Refuse if no sectors are addressable (e.g. medium not inserted) */
     if (s->nb_sectors == 0) {
         ide_abort_command(s);
-        return true;
-    }
+    } else {
+        /*
+         * Save the active drive parameters, which may have been
+         * limited from their native counterparts by, e.g., INITIALIZE
+         * DEVICE PARAMETERS or SET MAX ADDRESS.
+         */
+        const int aheads = s->heads;
+        const int asectors = s->sectors;
 
-    ide_cmd_lba48_transform(s, lba48);
-    ide_set_sector(s, s->nb_sectors - 1);
+        s->heads = s->drive_heads;
+        s->sectors = s->drive_sectors;
+
+        ide_cmd_lba48_transform(s, lba48);
+        ide_set_sector(s, s->nb_sectors - 1);
+
+        s->heads = aheads;
+        s->sectors = asectors;
+    }
 
     return true;
 }
-- 
2.44.0


