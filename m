Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE591C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCs7-0001ov-H1; Tue, 23 Jul 2024 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWCs5-0001oQ-Uh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWCs3-0005ss-B5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721730949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pjMaJoFD4MX2Vbtkaaii0UVODEjgEc918R1+UJPA1oI=;
 b=RL/I9QbfVEajyQuKZ1nCEQhuRpQDOVXvxMZXdzl7wr1O1aic8eTyRvjyZSx7D+f9sFVp8g
 y8Tl/xmv9uZn80bnWLbnvs8+XymUyouP3NJPCumSNZ/LaIQCpIZ1TWsX5KA7rjInu26s16
 XXpzG49S1XJ4ujjdBOES5C438C6ICW8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-jqQ1MJ73N9-j_RBGCKy6FA-1; Tue,
 23 Jul 2024 06:35:47 -0400
X-MC-Unique: jqQ1MJ73N9-j_RBGCKy6FA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 368EB1956046; Tue, 23 Jul 2024 10:35:46 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.63])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB63C1955D44; Tue, 23 Jul 2024 10:35:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] meson: build chardev trace files when have_block
Date: Tue, 23 Jul 2024 11:35:42 +0100
Message-ID: <20240723103542.2998235-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QSD depends on chardev code, and is built when have_tools is
true. This means conditionalizing chardev trace on have_system
is wrong, we need have_block which is set have_system || have_tools.

This latent bug was historically harmless because only the spice
chardev included tracing, which wasn't built in a !have_system
scenario.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is an add-on needed for:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05068.html

since I discovered a tools-only build fails

diff --git a/meson.build b/meson.build
index a1e51277b0..d3850a8c0f 100644
--- a/meson.build
+++ b/meson.build
@@ -3327,6 +3327,7 @@ if have_block
   trace_events_subdirs += [
     'authz',
     'block',
+    'chardev',
     'io',
     'nbd',
     'scsi',
@@ -3338,7 +3339,6 @@ if have_system
     'audio',
     'backends',
     'backends/tpm',
-    'chardev',
     'ebpf',
     'hw/9pfs',
     'hw/acpi',
-- 
2.45.2


