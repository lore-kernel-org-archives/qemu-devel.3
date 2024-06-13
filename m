Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB096C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlxZ-0000sf-0r; Thu, 13 Jun 2024 11:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHlxV-0000s3-NH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHlxS-0003aS-3Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718290904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srd5N3RnAbDznVMUAKGsSutiPz2tl88zdKYEH+HkTxA=;
 b=ghWd767o+bQ+zrs5LAKr62S7xKM1EaMncnuBrOimtrjQTsy0d36wRcGmvKzhTOFrYwNJGq
 gi+nfYIL4uUeoU292etAcy3hRFlax/TxbAo5kk+SIK63ejVh4orY/flCvVwaiolwoVw3tY
 UZ8JTtHgW9aTl2RRdMeEjKEsd4TMvOw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-g_N85tS3PQWkL6u81TRUnw-1; Thu,
 13 Jun 2024 11:01:38 -0400
X-MC-Unique: g_N85tS3PQWkL6u81TRUnw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16D991954208; Thu, 13 Jun 2024 15:01:35 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B87F19560AD; Thu, 13 Jun 2024 15:01:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 01/22] qga: drop blocking of guest-get-memory-block-size
 command
Date: Thu, 13 Jun 2024 16:01:06 +0100
Message-ID: <20240613150127.1361931-2-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This command has never existed in tree, since it was renamed to
guest-get-memory-block-info before being merged.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 2 +-
 qga/commands-win32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7f05996495..76af98ba32 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -3099,7 +3099,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
             "guest-suspend-disk", "guest-suspend-ram",
             "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus",
             "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-size", "guest-get-memory-block-info",
+            "guest-get-memory-block-info",
             NULL};
         char **p = (char **)list;
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0d1b836e87..9fe670d5b4 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1995,7 +1995,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
         "guest-suspend-hybrid",
         "guest-set-vcpus",
         "guest-get-memory-blocks", "guest-set-memory-blocks",
-        "guest-get-memory-block-size", "guest-get-memory-block-info",
+        "guest-get-memory-block-info",
         NULL};
     char **p = (char **)list_unsupported;
 
-- 
2.45.1


