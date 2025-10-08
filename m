Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8E7CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6STP-0003Xr-9d; Wed, 08 Oct 2025 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6STN-0003WT-KV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6STL-0006ne-SH
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759923403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2kgx1cvqOZ+h4+T57GUF2enlBgkH/035iZ1C6xGs6A=;
 b=FBz1uOdZ6cZTilBBxyGHzvb/loFdxppvA0SwDQgPkz1A88f9fcTSzU/Gyo7NtkmctGtMKu
 zpLtxUJ6x3Cd/RRzMgfEtL4rUXugCB5oxC5o/aSdHDeJec4wR//pgHdfy1m8N6zvbzafM/
 k38TQz9vQfP/qJj3i820H1Lo/4Z8wr4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-D9bNb0C_MAalfwLDYw2Ebg-1; Wed,
 08 Oct 2025 07:36:41 -0400
X-MC-Unique: D9bNb0C_MAalfwLDYw2Ebg-1
X-Mimecast-MFC-AGG-ID: D9bNb0C_MAalfwLDYw2Ebg_1759923400
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 179E61800365; Wed,  8 Oct 2025 11:36:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.74])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F7971956056; Wed,  8 Oct 2025 11:36:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Date: Wed,  8 Oct 2025 12:35:51 +0100
Message-ID: <20251008113552.747002-4-berrange@redhat.com>
In-Reply-To: <20251008113552.747002-1-berrange@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This introduces new suits for running I/O tests on NBD and LUKS
drivers, giving new make targets

 * make check-block-luks
 * make check-block-nbd

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 939a14ffae..5735d67c8c 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -23,7 +23,9 @@ qemu_iotests_formats = {
   'raw': 'slow',
   'qed': 'thorough',
   'vmdk': 'thorough',
-  'vpc': 'thorough'
+  'vpc': 'thorough',
+  'nbd': 'thorough',
+  'luks': 'thorough',
 }
 
 foreach k, v : emulators
-- 
2.50.1


