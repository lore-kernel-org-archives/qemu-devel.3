Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF0D65C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXbD-0001th-Hk; Thu, 14 Nov 2024 06:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXbC-0001tF-KX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXbB-0006vB-06
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+0IkxOsPiVhoTY8vn3E5+jloutqv/KmfsE+Oh71/nA=;
 b=FcFvkJYXz9jXY7gW+fRMZqaAJaIB6tMy00tIn1CurtEhdo8sBbs2zpkFlmoEGC04GCaAby
 p7lSeK1uLxhwPdwIztKJDpXbxZyYOjvJivXuDRWUeFrBW1lY/9X8/C2EAQMSl0RhHjmbqu
 nx1+7UxxZ+2UZ/M6J+x2x3e4A2fNDqs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-HdDEwdYlPRCtW46lWcXqcQ-1; Thu,
 14 Nov 2024 06:01:12 -0500
X-MC-Unique: HdDEwdYlPRCtW46lWcXqcQ-1
X-Mimecast-MFC-AGG-ID: HdDEwdYlPRCtW46lWcXqcQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC32619560BE; Thu, 14 Nov 2024 11:01:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E8F019560A3; Thu, 14 Nov 2024 11:01:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D140D18009BB; Thu, 14 Nov 2024 12:01:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 4/5] x86/loader: expose unpatched kernel
Date: Thu, 14 Nov 2024 12:01:00 +0100
Message-ID: <20241114110101.44322-5-kraxel@redhat.com>
In-Reply-To: <20241114110101.44322-1-kraxel@redhat.com>
References: <20241114110101.44322-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
the setup header patches.  Intended use is booting in UEFI with secure
boot enabled, where the setup header patching breaks secure boot
verification.

Needs OVMF changes too to be actually useful.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240905141211.1253307-5-kraxel@redhat.com>
---
 hw/i386/x86-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index d99bef983e37..ac91a3464603 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -960,6 +960,9 @@ void x86_load_linux(X86MachineState *x86ms,
     sev_load_ctx.setup_data = (char *)setup;
     sev_load_ctx.setup_size = setup_size;
 
+    /* kernel without setup header patches */
+    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
+
     if (sev_enabled()) {
         sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
     }
-- 
2.47.0


