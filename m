Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3908C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnewg-0002cS-Jl; Thu, 27 Feb 2025 09:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <e2cffb1f.AVQAAGONVc8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd4@a3031119.bnc3.mailjet.com>)
 id 1tnewH-0001UQ-4z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:38 -0500
Received: from o171.p8.mailjet.com ([87.253.233.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <e2cffb1f.AVQAAGONVc8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd4@a3031119.bnc3.mailjet.com>)
 id 1tnewC-0006Lt-LP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673944;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe:list-unsubscribe-post:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-transfer-encoding;
 bh=JVrHQXx+NRr6SZZfhzdaO0NCbP8JW68hHWikQBMc8Cw=;
 b=GTmk2Ga2Rvk3x/Iunj0Dy7lStHOPrr+5bUGWrw5u6QZYojyct5Tfek0sm
 9pGNEabE5JZgP58Fo0PZWbsh67O49I7rK69+um86xNWddVD2sGVanPq0dAP6
 YuZwdLzremoD4OtpW8kmjP45NyowoVO6M4Hq0gAdloXUrmE4ui1mpaDH8x/+
 42aZP3xDI8KOy4Md5otdtgxpaySXp/tHYDVnErTdy+XUWFyq6vzn6leyO5BI
 Kp0RFAhKGGLGVIcEWo6Tkpz0imYjja+vaapG6EPGsDj77SerbIRxIdklgYxF
 tHdZpYcoF2SiqgA2R753b1cq3DAPrSRx2zYq71zGSspLQ==
Message-Id: <e2cffb1f.AVQAAGONVc8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd4@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/16] backends/igvm: Process initialization sections in
 IGVM file
Date: Thu, 27 Feb 2025 14:29:31 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AVQAAGONVc8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd4dfoJvjclSSO_aqaccAt4PAAqgls
X-MJ-SMTPGUID: a402c387-4883-46f5-84a4-c02695955b1e
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=87.253.233.171;
 envelope-from=e2cffb1f.AVQAAGONVc8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd4@a3031119.bnc3.mailjet.com;
 helo=o171.p8.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The initialization sections in IGVM files contain configuration that
should be applied to the guest platform before it is started. This
includes guest policy and other information that can affect the security
level and the startup measurement of a guest.

This commit introduces handling of the initialization sections during
processing of the IGVM file.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 4dfc9b0c67..cbe833db9d 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -787,6 +787,27 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
         }
     }
 
+    header_count =
+        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
+    if (header_count < 0) {
+        error_setg(
+            errp,
+            "Invalid initialization header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup_parameters;
+    }
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type =
+            igvm_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION,
+                                 ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup_parameters;
+        }
+    }
+
     /*
      * Contiguous pages of data with compatible flags are grouped together in
      * order to reduce the number of memory regions we create. Make sure the
-- 
2.43.0


