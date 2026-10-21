Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C696606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yc8ybhep
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPrA-0004rS-7G; Wed, 21 Oct 2026 02:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJPr0-0004r9-Kp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJPqx-0004Q9-BV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792564269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=66jF8UazuBg/7lKHQxDgOXrP/gAMJa3ieQpV/jwxNao=;
 b=Yc8ybhephtKl1F2aYiuMIuntdV6JjsgB38uCc9t06k85iQIJeF/3fx6AZdosOcRumlvj9s
 fIIrUhDAMmaIjjVIm1dOP4ndIp1wINIa/XwS4a18UJXaswFz2HutiVaAPYsAjqEmX2yBhc
 RZ6sOiYDO6ghDxBE7GZhVuj0Xwpj3IM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-hc3sYvjpMGWqNf05lVobRA-1; Wed,
 21 Oct 2026 06:31:08 +0000
X-MC-Unique: hc3sYvjpMGWqNf05lVobRA-1
X-Mimecast-MFC-AGG-ID: hc3sYvjpMGWqNf05lVobRA_1792564267
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A07180075A; Wed, 21 Oct 2026 06:31:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DD6A1800495; Wed, 21 Oct 2026 06:31:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7EB421800782; Wed, 21 Oct 2026 08:31:05 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH] x86: mmap kernel for direct kernel boot
Date: Wed, 21 Oct 2026 08:31:05 +0200
Message-ID: <20261021063105.102520-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce memory footprint by mapping the kernel into memory instead of
reading into allocated memory in the common case (no -dtb $file on the
qemu command line).

Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fa18bf1aeceb..25e141aa8537 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
     }
 
     setup  = g_malloc(setup_size);
-    kernel = g_malloc(kernel_size);
     fseek(f, 0, SEEK_SET);
     if (fread(setup, 1, setup_size, f) != setup_size) {
         fprintf(stderr, "fread() failed\n");
         exit(1);
     }
-    fseek(f, 0, SEEK_SET);
-    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
-        fprintf(stderr, "fread() failed\n");
-        exit(1);
+    if (dtb_filename) {
+        /* read kernel into allocated memory, so we can realloc for the dtb */
+        kernel = g_malloc(kernel_size);
+        fseek(f, 0, SEEK_SET);
+        if (fread(kernel, 1, kernel_size, f) != kernel_size) {
+            fprintf(stderr, "fread() failed\n");
+            exit(1);
+        }
+    } else {
+        /* mmap kernel */
+        GMappedFile *mapped_file;
+        GError *gerr = NULL;
+
+        mapped_file = g_mapped_file_new(kernel_filename, false, &gerr);
+        if (!mapped_file) {
+            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
+                    kernel_filename, gerr->message);
+            exit(1);
+        }
+        kernel = (uint8_t *)g_mapped_file_get_contents(mapped_file);
     }
     fclose(f);
 
-- 
2.56.0


