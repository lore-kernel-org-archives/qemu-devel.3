Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333F5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 12:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seZZz-0000xy-9w; Thu, 15 Aug 2024 08:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seZZw-0000vj-5k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seZZk-0002Fx-2v
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723724848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wjm2/ES8sPF+hKm6zOB61v37IYwJT2oHf333HI/CY20=;
 b=SArxyzXSeor2BNj0BWjtA5tdeBy2tWLBvoo9qS1vB3ToBZkMONSKk472dZrp+8uTyFVPfW
 0ygyRsIbjMQMmg8X/wCxb9qptR5Py+f5m9mBgD7lQO+YmmoatiBlj/NvXhOJrT7WsqryPp
 kamDhBLG7r4yS58k9G0I8F7r26VJdoc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-53gwK8bzPzuxxbOnuFZN3w-1; Thu,
 15 Aug 2024 08:27:26 -0400
X-MC-Unique: 53gwK8bzPzuxxbOnuFZN3w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DD181955BF8; Thu, 15 Aug 2024 12:27:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 560DE19560AA; Thu, 15 Aug 2024 12:27:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH] meson.build: Check for the availability of
 __attribute__((gcc_struct)) on MSYS2
Date: Thu, 15 Aug 2024 14:27:19 +0200
Message-ID: <20240815122719.727639-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since quite a while MSYS2 now supports Clang as a compiler, too.
Unfortunately, this compiler is lacking the __attribute__((gcc_struct))
that we need for compiling on Windows. But since the compiler is
available now, some people started to use it to compile QEMU on MSYS2,
apparently ignoring the compiler warnings (see for example the ticket at
https://gitlab.com/qemu-project/qemu/-/issues/2476 ). These builds are
likely broken in a couple of spots, so let's make sure that we rather
bail out early in the configuration phase instead of allowing the build
to succeed with warnings.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 81ecd4bae7..fbda17c987 100644
--- a/meson.build
+++ b/meson.build
@@ -315,6 +315,11 @@ elif host_os == 'sunos'
   qemu_common_flags += '-D__EXTENSIONS__'
 elif host_os == 'haiku'
   qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
+elif host_os == 'windows'
+  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
+                           args: '-Werror')
+    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
+  endif
 endif
 
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
-- 
2.46.0


