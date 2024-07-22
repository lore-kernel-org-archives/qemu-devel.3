Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0904C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn3R-0008OM-2Y; Mon, 22 Jul 2024 03:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3J-0007xi-IF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3H-0006Py-65
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/GzOZxFCbN6eJ01B+nSFP77J4zP5nfCvO0hf3Fvfsw=;
 b=Qpv7rgg/8xVliZO1PcuJtQmKdlFXPoyqOERsrZoL7D/8aqZbHS68fCa2AkEGiMyFWegeMx
 NnlozrzVikGe6Usj6yGLvmJG7qeWHnc+Q2qob4WhBRa2CKTlO56n1p2Snl8DpWBEXPHjze
 1gNo+EMBSlVXbNK9rECM+3bm/DO2d3o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-zZRPiDMhMDO2_2iI7wVIdQ-1; Mon,
 22 Jul 2024 03:01:30 -0400
X-MC-Unique: zZRPiDMhMDO2_2iI7wVIdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ACDB1955D4A; Mon, 22 Jul 2024 07:01:29 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE2BB195605F; Mon, 22 Jul 2024 07:01:27 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 01/25] qga: drop blocking of guest-get-memory-block-size command
Date: Mon, 22 Jul 2024 10:00:58 +0300
Message-ID: <20240722070122.27615-2-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This command has never existed in tree, since it was renamed to
guest-get-memory-block-info before being merged.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240712132459.3974109-2-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.45.2


