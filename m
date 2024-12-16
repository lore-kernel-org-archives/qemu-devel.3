Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2785AE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8gx-0004Gs-Iy; Mon, 16 Dec 2024 05:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gv-0004GJ-32
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gs-0005P4-Vr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIjnYThMGNILIBqfVTQiDX57CjjFSUzCwV568kgeiCU=;
 b=DlfkpiGmGn9TlKhsEEa8bkdEy3v2+UL0PdxQ9u5RJPDAZ+QvGb88BC4MQk9gHJFmunQH3Q
 dXYLbs+u23GSC7u0wInOTf65Iikb+/Rm7G8M1R50QUUKeTXx8PpoeXJsJJjyVe6kP60/1Z
 1e1epEGRYySm6CcCkbWDhBi6qvjNPpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-B0GRdS5ZOUuTN_CIaFR4lQ-1; Mon,
 16 Dec 2024 05:51:04 -0500
X-MC-Unique: B0GRdS5ZOUuTN_CIaFR4lQ-1
X-Mimecast-MFC-AGG-ID: B0GRdS5ZOUuTN_CIaFR4lQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26D2D1955EA2; Mon, 16 Dec 2024 10:51:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71D61195606B; Mon, 16 Dec 2024 10:51:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA8B618003B9; Mon, 16 Dec 2024 11:50:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/7] x86/loader: expose unpatched kernel
Date: Mon, 16 Dec 2024 11:50:49 +0100
Message-ID: <20241216105053.246204-4-kraxel@redhat.com>
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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
index 28341b42d949..1cef3045ad83 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -962,6 +962,9 @@ void x86_load_linux(X86MachineState *x86ms,
     sev_load_ctx.setup_data = (char *)setup;
     sev_load_ctx.setup_size = setup_size;
 
+    /* kernel without setup header patches */
+    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
+
     if (sev_enabled()) {
         sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
     }
-- 
2.47.1


