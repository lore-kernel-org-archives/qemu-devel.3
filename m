Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C33CC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGQ7-0007HA-Ck; Wed, 26 Feb 2025 07:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPx-0007Ey-Po
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPu-0000gN-1q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740572493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XViA2bJE9+xTgZXMqrWMnd7SRapqeTzdpfTgMV/IAs=;
 b=PKaCKvQVBWiL6YAejsAJzsmfVoisraslTKF7N3CakEW1mHifjiChkBH0kmuVTG4XsibDq9
 Epuggh6FsC8QTnuPxsJN2stA92T1OAExDhjyJH+GyijyH/VL7qo0MuyjpdJxDB2MSHQ3AT
 djgn+6HNo4l9K3rJltBWjDlsqYKaJ2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-Kude8jXcNY-kDv8VZO0e5Q-1; Wed,
 26 Feb 2025 07:21:31 -0500
X-MC-Unique: Kude8jXcNY-kDv8VZO0e5Q-1
X-Mimecast-MFC-AGG-ID: Kude8jXcNY-kDv8VZO0e5Q_1740572491
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8732190F9C8; Wed, 26 Feb 2025 12:21:30 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.227.242])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5517F19560B9; Wed, 26 Feb 2025 12:21:28 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/3] qga: Invert logic on return value in main()
Date: Wed, 26 Feb 2025 14:21:19 +0200
Message-ID: <20250226122120.85790-3-kkostiuk@redhat.com>
In-Reply-To: <20250226122120.85790-1-kkostiuk@redhat.com>
References: <20250226122120.85790-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michal Privoznik <mprivozn@redhat.com>

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
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <8a28265f50177a8dc4c10fcf4146e85a7fd748ee.1736261360.git.mprivozn@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 531853e13d..eccfa33871 100644
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
2.48.1


