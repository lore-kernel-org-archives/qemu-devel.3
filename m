Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42469CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNa7-0000mG-M8; Sat, 30 Aug 2025 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3St-0005YK-An
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3Sq-0005YL-C6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5WgckRyPOl+OzwTIqRF01uc4XyMNWmTjVaQHTrfBS4=;
 b=dcQhTgfuIMTadQYn8PPuWnpWsRdPVIA9Vzqi44pbBmfXBLhLsiIOnrtP13OU9qzpCpb1yj
 YWQPztt2Sz31BKnCg7wx5oJkKpoE39zUyV8vSwhaiVVwwmjKdK9l5t0g8ROgKzU9k8Xoj/
 jLSDxTbUNI1+MILM/OZ3XvWI0XxTAlY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-SjuWimgVPiu2TamYRYZlAg-1; Fri,
 29 Aug 2025 14:04:35 -0400
X-MC-Unique: SjuWimgVPiu2TamYRYZlAg-1
X-Mimecast-MFC-AGG-ID: SjuWimgVPiu2TamYRYZlAg_1756490674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8324180044F; Fri, 29 Aug 2025 18:04:33 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E87C19560B4; Fri, 29 Aug 2025 18:04:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/14] util: set the name for the 'main' thread
Date: Fri, 29 Aug 2025 19:03:46 +0100
Message-ID: <20250829180354.2922145-7-berrange@redhat.com>
In-Reply-To: <20250829180354.2922145-1-berrange@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The default main thread name is undefined, so use a constructor to
explicitly set it to 'main'. This constructor is marked to run early
as the thread name is intended to be used in error reporting / logs
which may be triggered very early in QEMU execution.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-thread-posix.c | 6 ++++++
 util/qemu-thread-win32.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index ddaa1de4dd..275445ed94 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -22,6 +22,12 @@
 #include <pthread_np.h>
 #endif
 
+static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
+qemu_thread_init(void)
+{
+    qemu_thread_set_name("main");
+}
+
 static void error_exit(int err, const char *msg)
 {
     fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 62eaa11026..7a734a7a09 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -22,6 +22,12 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
 static pSetThreadDescription SetThreadDescriptionFunc;
 static HMODULE kernel32_module;
 
+static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
+qemu_thread_init(void)
+{
+    qemu_thread_set_name("main");
+}
+
 static bool load_set_thread_description(void)
 {
     static gsize _init_once = 0;
-- 
2.50.1


