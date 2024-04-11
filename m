Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCACBCD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rur38-0006l5-SK; Thu, 11 Apr 2024 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur36-0006kr-U5
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur35-00037n-EV
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712828930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJAfTPrFy3A5v4w7d+iJcbwWlf5aVee+o94cln2/F1U=;
 b=X1Q6TqsrkFEoT4fsA2mMq9ucq1vijHtKYFVX7BDTxPKpUpv+9bvDkde4QlNaKJ7uDtZe1W
 FFGf5pTEdJnu8fd8tp87aLMcOBnrVrig8NpkC5Oau1JV4vp52WwGGnUvpbEJ7cHjB72hf+
 m+PUoS6EKwQT2D+D5tiiYydjy9HnW5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-im2J5kbMP8yjgvtgGmVzTw-1; Thu, 11 Apr 2024 05:48:48 -0400
X-MC-Unique: im2J5kbMP8yjgvtgGmVzTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4473A806604;
 Thu, 11 Apr 2024 09:48:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A72BE1121306;
 Thu, 11 Apr 2024 09:48:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6D80418009BB; Thu, 11 Apr 2024 11:48:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] x86/loader: read complete kernel
Date: Thu, 11 Apr 2024 11:48:27 +0200
Message-ID: <20240411094830.1337658-4-kraxel@redhat.com>
In-Reply-To: <20240411094830.1337658-1-kraxel@redhat.com>
References: <20240411094830.1337658-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Load the complete kernel (including setup) into memory.  Excluding the
setup is handled later when adding the FW_CFG_KERNEL_SIZE and
FW_CFG_KERNEL_DATA entries.

This is a preparation for the next patch which adds a new fw_cfg file
containing the complete, unpatched kernel.  No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/x86.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 765899eebe43..6f75948b3021 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1058,7 +1058,6 @@ void x86_load_linux(X86MachineState *x86ms,
         fprintf(stderr, "qemu: invalid kernel header\n");
         exit(1);
     }
-    kernel_size -= setup_size;
 
     setup  = g_malloc(setup_size);
     kernel = g_malloc(kernel_size);
@@ -1067,6 +1066,7 @@ void x86_load_linux(X86MachineState *x86ms,
         fprintf(stderr, "fread() failed\n");
         exit(1);
     }
+    fseek(f, 0, SEEK_SET);
     if (fread(kernel, 1, kernel_size, f) != kernel_size) {
         fprintf(stderr, "fread() failed\n");
         exit(1);
@@ -1113,10 +1113,11 @@ void x86_load_linux(X86MachineState *x86ms,
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
-    sev_load_ctx.kernel_data = (char *)kernel;
-    sev_load_ctx.kernel_size = kernel_size;
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size - setup_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA,
+                     kernel + setup_size, kernel_size - setup_size);
+    sev_load_ctx.kernel_data = (char *)kernel + setup_size;
+    sev_load_ctx.kernel_size = kernel_size - setup_size;
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
     fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
-- 
2.44.0


