Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32765D31A29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxex-0003pS-Nw; Wed, 14 Jan 2026 04:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxep-0003o0-Vx
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:59:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxel-0003bU-PZ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768384753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3U3CCOLsG9i6TKgeqX5IOgn+kvt6XkYtIQsfgQVFE98=;
 b=HW3ZAEmoWTq8P9ulOrVD4b6aUKnMk5uImbi8jH47CEVligYFursXEP4cmynQlTrW9TQxIl
 OXSLudcRua/7KKwWQ1F1ryTQdMyuZlD0tu3oyZqF5TmsoPm/Kcqc2LzRVPfYZhP5PinSjB
 QAuIvzV+K2vrpnrHhEAPL8OME8DvM7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-puS7RUA0NT2A3D_iQ8Go-Q-1; Wed,
 14 Jan 2026 04:59:10 -0500
X-MC-Unique: puS7RUA0NT2A3D_iQ8Go-Q-1
X-Mimecast-MFC-AGG-ID: puS7RUA0NT2A3D_iQ8Go-Q_1768384749
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C9D419560B7; Wed, 14 Jan 2026 09:59:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C8DB180066A; Wed, 14 Jan 2026 09:59:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH] tests/functional/x86_64: Limit the memlock test to Linux hosts
Date: Wed, 14 Jan 2026 10:59:04 +0100
Message-ID: <20260114095904.35442-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The memlock test analyzes /proc/*/status files and expects the layout
from Linux in there. However, these files also exist on NetBSD hosts
with a completely different layout, causing this test to fail. Thus
limit the test to Linux hosts now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6cf..97286d78b8f 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -9,12 +9,13 @@ test_x86_64_timeouts = {
   'virtio_balloon': 120,
 }
 
-tests_x86_64_system_quick = [
+tests_x86_64_system_quick = \
+  (host_os == 'linux' ? ['memlock'] : []) + \
+[
   'bad_vmstate',
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
-  'memlock',
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
-- 
2.52.0


