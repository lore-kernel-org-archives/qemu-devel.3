Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883DFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serIR-0005gV-2M; Fri, 16 Aug 2024 03:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1serIF-0005Ln-07
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1serIA-0003xt-8w
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723792953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ziMcKMgTIE3T4+13ZdPgIhZiIyVR9U9bdaD+wjkZoc=;
 b=Sx/GA54WNflgrzJhwL1pbZ8LrncY+j7G3cnpVLArWwbfEVuItpnIz3AjAXudDnRg7Kdmah
 z9Dd8ZNbXqp5LBxij0rTA3OkMBeeNKkftXjCX+D9Tlo1jp2X2KvD79MyqXJWYgOjA0Yd2p
 goTsEIJmq0ZmXWYMuJ1orc7dZn1+PVI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-z5dri-0aO6aPB32rXyabzg-1; Fri,
 16 Aug 2024 03:22:29 -0400
X-MC-Unique: z5dri-0aO6aPB32rXyabzg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB61A1955D4E; Fri, 16 Aug 2024 07:22:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.75])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EDE51956054; Fri, 16 Aug 2024 07:22:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/5] meson.build: Check for the availability of
 __attribute__((gcc_struct)) on MSYS2
Date: Fri, 16 Aug 2024 09:22:15 +0200
Message-ID: <20240816072218.27125-3-thuth@redhat.com>
In-Reply-To: <20240816072218.27125-1-thuth@redhat.com>
References: <20240816072218.27125-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Message-ID: <20240815122719.727639-1-thuth@redhat.com>
Tested-by: Stefan Weil <sw@weilnetz.de>
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


