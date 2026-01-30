Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051F5D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhMi-0003F3-3J; Fri, 30 Jan 2026 00:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhMf-00039q-RT
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhMe-0005W0-F6
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769752095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Si/Kii2ggAVTdYuNl9bX4xHdx4QI2ldGNdtiEINfNJw=;
 b=feIlyZJ5Hx9HIM1EF1E2qPDtfx1AKyh98noDfT75FU/JeALR5gm8kAqfj6JHw2lKrQqlwu
 MAKVG5yL+5NWkuzT5oWokviAkwcpqz5N6ruF5luYoSOykzCvsYpW9Xwai8wZIHhESXJ98O
 /k6+Wk0QMGjzTW8+jW8To6tFZX97wPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-Y7buGfhxNJSIuN5A_xWpfA-1; Fri,
 30 Jan 2026 00:48:11 -0500
X-MC-Unique: Y7buGfhxNJSIuN5A_xWpfA-1
X-Mimecast-MFC-AGG-ID: Y7buGfhxNJSIuN5A_xWpfA_1769752090
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78BC0195608E; Fri, 30 Jan 2026 05:48:10 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.45.226.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 672B719560A2; Fri, 30 Jan 2026 05:48:04 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v6 8/9] igvm: Only build stubs if igvm is enabled
Date: Fri, 30 Jan 2026 06:47:13 +0100
Message-ID: <20260130054714.715928-9-osteffen@redhat.com>
In-Reply-To: <20260130054714.715928-1-osteffen@redhat.com>
References: <20260130054714.715928-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Change meson script to only include the IGVM stubs file if the IGVM
feature is enabled. It is used to handle architecture specific
differences within the IGVM backend, not to provide stubs of the backend
itself.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 stubs/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 2b5fd8a88a..8a07059500 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -71,7 +71,9 @@ if have_system
   stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
-  stub_ss.add(files('igvm.c'))
+  if igvm.found()
+    stub_ss.add(files('igvm.c'))
+  endif
   stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
-- 
2.52.0


