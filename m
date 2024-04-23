Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8733C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnf-0007P9-Bd; Tue, 23 Apr 2024 11:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmk-0004Nc-Ep
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-00006M-QB
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSQguZveC9CWehs3CSqV4ojj8hfIHOficnxvbkiw+LQ=;
 b=IvtaF3F5rbhfs7gbgzQ6YYqBHLOjSSh1YX5PoI21QDrWOL9sQ46I+OIR/xXATyWl9diwmH
 MzeLziYtd78U8Cag1QvI/TPAF8EOAuTmWuaoXym7X0HTFraYLntZ5l6r1CfhkwJ6mUCXEC
 nNMsVkh172D5Pk0lTYCJgb0jIIR+K9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4z5rs5hMMj-SouGlBUFTUw-1; Tue, 23 Apr 2024 11:10:10 -0400
X-MC-Unique: 4z5rs5hMMj-SouGlBUFTUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C78D1827102
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:10 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A5C200E290
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/63] stubs: split record/replay stubs further
Date: Tue, 23 Apr 2024 17:09:04 +0200
Message-ID: <20240423150951.41600-17-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

replay.c symbols are only needed by user mode emulation, with the
exception of replay_mode that is needed by both user mode emulation
(by way of qemu_guest_getrandom) and block layer tools (by way of
util/qemu-timer.c).

Since it is needed by libqemuutil rather than specific files that
are part of the tools and emulators, split the replay_mode stub
into its own file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240408155330.522792-17-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/replay-mode.c | 4 ++++
 stubs/replay.c      | 2 --
 stubs/meson.build   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 stubs/replay-mode.c

diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
new file mode 100644
index 00000000000..264be9d96c9
--- /dev/null
+++ b/stubs/replay-mode.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "sysemu/replay.h"
+
+ReplayMode replay_mode;
diff --git a/stubs/replay.c b/stubs/replay.c
index 42c92e4acb8..b4dd6a566e8 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -1,8 +1,6 @@
 #include "qemu/osdep.h"
 #include "exec/replay-core.h"
 
-ReplayMode replay_mode;
-
 void replay_finish(void)
 {
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index a252bffad00..4a524f5816b 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -36,6 +36,7 @@ stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
 stub_ss.add(files('replay.c'))
+stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('sysbus.c'))
 stub_ss.add(files('target-get-monitor-def.c'))
-- 
2.44.0



