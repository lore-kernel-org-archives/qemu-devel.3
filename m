Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7280FE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEZZ-0004WK-TW; Thu, 05 Dec 2024 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJEZR-0004Vw-30
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJEZP-0007nj-Hx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7fSVaL4A+NJUb5Qfu7/DO8n7m7CrRilZSxiNE2PvZg=;
 b=SqxEJReJ0qFRBeWmAHTaZEvX7ULt3ajZEN+DcSm2n3o/R0H879cwZHp5hpy7aCDOv+7Lqw
 1x7Ka+5YwPSmtNonsb5OsqxR6aZvS6xcFAOR3DhuT4SxsmykKtx91RJl9tDomDmeqDUVhD
 fmhBU0TRFfBVKDXsdpJ6n6QRljvpOFA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-AX5DPnzXP12EAsDLnDXHtg-1; Thu,
 05 Dec 2024 11:19:13 -0500
X-MC-Unique: AX5DPnzXP12EAsDLnDXHtg-1
X-Mimecast-MFC-AGG-ID: AX5DPnzXP12EAsDLnDXHtg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA80219560A3; Thu,  5 Dec 2024 16:19:12 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 528DC3000197; Thu,  5 Dec 2024 16:19:10 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	michael.roth@amd.com,
	jtomko@redhat.com
Subject: [PATCH v2 2/4] qga: Invert logic on return value in main()
Date: Thu,  5 Dec 2024 17:18:46 +0100
Message-ID: <9316535a7cd0e73983b57c2c775d6bfc566d4b08.1733414906.git.mprivozn@redhat.com>
In-Reply-To: <cover.1733414906.git.mprivozn@redhat.com>
References: <cover.1733414906.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Ján Tomko <jtomko@redhat.com>
---
 qga/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 4a695235f0..68ea7f275a 100644
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
 
@@ -1664,6 +1662,7 @@ int main(int argc, char **argv)
         SERVICE_TABLE_ENTRY service_table[] = {
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
+        ret = EXIT_SUCCESS;
     } else {
         ret = run_agent(s);
     }
-- 
2.45.2


