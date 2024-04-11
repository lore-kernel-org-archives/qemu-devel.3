Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A932CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutEL-0003yA-AS; Thu, 11 Apr 2024 08:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rutEI-0003y2-Lr
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rutEF-0004wf-Gi
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712837310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=opJ+WC0UhA7DXDKHCUJnEdNPmjLDNHndFdpnO7C6VtY=;
 b=Y3zVP76z+ZI6JlVxCGXHZBZDG7jl4b60LF9VI/eFGAE1fJrfhduCepfuXl13+/n5MtjFTt
 0bU5CA2PTtS4MvCaadhY9QXmaRmFVaPj94UyyU9ZiXzqF+o9FVy+VbYSi7up4UM+WiFkpR
 qwaNMUMmFIIM6fSYEy6Ym3Ue7dtBSqY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-6aiQuQLSM1emyMk8ECKGUw-1; Thu,
 11 Apr 2024 08:08:27 -0400
X-MC-Unique: 6aiQuQLSM1emyMk8ECKGUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE2D1380621F;
 Thu, 11 Apr 2024 12:08:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E85D2166B36;
 Thu, 11 Apr 2024 12:08:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-9.0] meson.build: Disable -fzero-call-used-regs on OpenBSD
Date: Thu, 11 Apr 2024 14:08:19 +0200
Message-ID: <20240411120819.56417-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

QEMU currently does not work on OpenBSD since the -fzero-call-used-regs
option that we added to meson.build recently does not work with the
"retguard" extension from OpenBSD's Clang. Thus let's disable the
-fzero-call-used-regs here until there's a better solution available.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2278
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Given that we're close to the release, I think the host_os check
 is the best we can do ... the problem does not seem to trigger in all
 functions, only if certain registers are used by the compiler, so a
 more sophisticated check here seems to be too fragile to me right now.

 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4..91a0aa64c6 100644
--- a/meson.build
+++ b/meson.build
@@ -562,7 +562,11 @@ hardening_flags = [
 #
 # NB: Clang 17 is broken and SEGVs
 # https://github.com/llvm/llvm-project/issues/75168
-if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
+#
+# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
+# https://gitlab.com/qemu-project/qemu/-/issues/2278
+if host_os != 'openbsd' and \
+   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
                name: '-fzero-call-used-regs=used-gpr',
                args: ['-O2', '-fzero-call-used-regs=used-gpr'])
     hardening_flags += '-fzero-call-used-regs=used-gpr'
-- 
2.44.0


