Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546EFD132A2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tn1-0002WA-OJ; Mon, 04 Nov 2024 04:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tmz-0002VA-0F
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tmx-0002jx-DK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHtrzReOa/j1KY02SZCyfWRb9w55Kdov5F5zFubNRVY=;
 b=M82NGvVk7UYXtmxRYkmeTiKiNpGBYapfoB13ZaC/DLt4VFqGYRtDQmSFnh/JU4QljkebAi
 LcJfP1aR7lAL9j0ur/5qQ8aCHEwOElYeA+hu/SSHp3hEFBnt26D0LdlL1qkJz6r9VnI/yW
 IIqOe9hi99JHXF2sjOm057FkS+M+YVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ae7mR26WNZ-mueoVNGoICw-1; Mon,
 04 Nov 2024 04:54:19 -0500
X-MC-Unique: ae7mR26WNZ-mueoVNGoICw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83D3C1955F28; Mon,  4 Nov 2024 09:54:18 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 675A8300018D; Mon,  4 Nov 2024 09:54:17 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 2/4] qga: Invert logic on return value in main()
Date: Mon,  4 Nov 2024 10:54:08 +0100
Message-ID: <5182ceb139a43aacaab2c8b833bf52b13279dcf0.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
References: <cover.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Current logic on return value ('ret' variable) in main() is error
prone. The variable is initialized to EXIT_SUCCESS and then set
to EXIT_FAILURE on error paths. This makes it very easy to forget
to set the variable to indicate error when adding new error path,
as is demonstrated by handling of initialize_agent() failure.
It's simply lacking setting of the variable.

There's just one case where success should be indicated: when
dumping the config ('-D' cmd line argument).

To resolve this, initialize the variable to failure value and set
it explicitly to success value in that one specific case.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 4a695235f0..c003aacbe0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested)
 
 int main(int argc, char **argv)
 {
-    int ret = EXIT_SUCCESS;
+    int ret = EXIT_FAILURE;
     GAState *s;
     GAConfig *config = g_new0(GAConfig, 1);
     int socket_activation;
@@ -1607,7 +1607,6 @@ int main(int argc, char **argv)
     socket_activation = check_socket_activation();
     if (socket_activation > 1) {
         g_critical("qemu-ga only supports listening on one socket");
-        ret = EXIT_FAILURE;
         goto end;
     }
     if (socket_activation) {
@@ -1631,7 +1630,6 @@ int main(int argc, char **argv)
 
         if (!config->method) {
             g_critical("unsupported listen fd type");
-            ret = EXIT_FAILURE;
             goto end;
         }
     } else if (config->channel_path == NULL) {
@@ -1643,13 +1641,13 @@ int main(int argc, char **argv)
             config->channel_path = g_strdup(QGA_SERIAL_PATH_DEFAULT);
         } else {
             g_critical("must specify a path for this channel");
-            ret = EXIT_FAILURE;
             goto end;
         }
     }
 
     if (config->dumpconf) {
         config_dump(config);
+        ret = EXIT_SUCCESS;
         goto end;
     }
 
-- 
2.45.2


