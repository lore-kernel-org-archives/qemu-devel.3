Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC3CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Zi-00060j-F6; Thu, 21 May 2026 07:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZZ-0005Uk-3P
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZX-0003ag-3r
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEfrYhZZe8I3q5wClqrHbfgmmo2Kh4lJvuHDrgVhAYI=;
 b=eulP1+Dt5Rq+yWwkkZzcMb+CzNGo3zfTb/x+uZtBcewRechFja2yPP+LBFf4IWuM8xIUFf
 iuY2W+hj83pVj/EzlwPdVkDqzKDqwHcU6Sj4EtIeunb/8OhBLKPA5kx1eKY8ObbzImkg25
 LonJip34v/t1izImhDA65i390jrehmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-oXyLti_zOQGTdNylx6AVBw-1; Thu,
 21 May 2026 07:28:10 -0400
X-MC-Unique: oXyLti_zOQGTdNylx6AVBw-1
X-Mimecast-MFC-AGG-ID: oXyLti_zOQGTdNylx6AVBw_1779362889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8988D18002C7; Thu, 21 May 2026 11:28:09 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.32.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2142E19560A3; Thu, 21 May 2026 11:28:09 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 3355D7DC646; Thu, 21 May 2026 13:28:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/3] hw/i386: switch shim loading to load_image_to_fw_cfg_file
Date: Thu, 21 May 2026 13:28:05 +0200
Message-ID: <20260521112806.504961-3-kraxel@redhat.com>
In-Reply-To: <20260521112806.504961-1-kraxel@redhat.com>
References: <20260521112806.504961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Use the new helper function instead of open-coding
the shim image load.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/x86-common.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fde05fa7d7..8f9419e7d3 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -980,19 +980,8 @@ void x86_load_linux(X86MachineState *x86ms,
     fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
 
     if (machine->shim_filename) {
-        GMappedFile *mapped_file;
-        GError *gerr = NULL;
-
-        mapped_file = g_mapped_file_new(machine->shim_filename, false, &gerr);
-        if (!mapped_file) {
-            fprintf(stderr, "qemu: error reading shim %s: %s\n",
-                    machine->shim_filename, gerr->message);
-            exit(1);
-        }
-
-        fw_cfg_add_file(fw_cfg, "etc/boot/shim",
-                        g_mapped_file_get_contents(mapped_file),
-                        g_mapped_file_get_length(mapped_file));
+        load_image_to_fw_cfg_file(fw_cfg, "etc/boot/shim",
+                                  machine->shim_filename);
     }
 
     if (sev_enabled()) {
-- 
2.54.0


