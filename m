Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9019CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCGL-00064w-2r; Wed, 28 Feb 2024 00:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCGG-00064F-Hi
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCGD-0006XO-9K
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKBXyoo6H3FnuIUhAhVzSn4lKRTtLIfs/jNVHpKxL/g=;
 b=SNlENMxhe0Ue9PqKWhxpafDv6wLKSgR+t2puliZJkuX9V4lFilcOUVaMNd4wTjLMNpbHxL
 wxcS/ebv/ycbARtnlMA8bQvstNo1bw4RMmSsFy6F2NrPbHWy1IEuHLhZCPQaIfl5znO9E7
 B6jW/gqwv1XaTsvUWsOO2R4Iin5NC2c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-57A-BRE0P7qF5I2Bg3_h0g-1; Wed,
 28 Feb 2024 00:13:35 -0500
X-MC-Unique: 57A-BRE0P7qF5I2Bg3_h0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D17B3816D8A;
 Wed, 28 Feb 2024 05:13:35 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A57FB1C117A0;
 Wed, 28 Feb 2024 05:13:26 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 01/25] docs/devel/migration.rst: Document the file transport
Date: Wed, 28 Feb 2024 13:12:51 +0800
Message-ID: <20240228051315.400759-2-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

When adding the support for file migration with the file: transport,
we missed adding documentation for it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240220224138.24759-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 331252a92c..8024275d6d 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -41,6 +41,10 @@ over any transport.
 - exec migration: do the migration using the stdin/stdout through a process.
 - fd migration: do the migration using a file descriptor that is
   passed to QEMU.  QEMU doesn't care how this file descriptor is opened.
+- file migration: do the migration using a file that is passed to QEMU
+  by path. A file offset option is supported to allow a management
+  application to add its own metadata to the start of the file without
+  QEMU interference.
 
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
-- 
2.43.0


