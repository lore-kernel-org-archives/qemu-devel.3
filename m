Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B076FE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEZp-0004fH-39; Thu, 05 Dec 2024 11:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJEZg-0004bL-KW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJEZb-0007oT-Pw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xG8LQleyZaEfHMBwq60MdqrgLxtBGgS3uFbJQoWRKmI=;
 b=PlK5xppuM1LRtrcsCHwc214AUrvsA9Lcp8TKEknf05L/hwFg53HtrZO3vKXL6pfBxcimVu
 K9Hv4R3eAb/cNRWHv0suOaVm2CUVzuq4QSnFCRkHO5rrQavR3H9fNx/IS1lSRXRJfUmXoE
 iZeNjvDn8bCGBuFFUzwlg5DfOsuHq44=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-5fCWULkJMCi4GVh-xlRPuA-1; Thu,
 05 Dec 2024 11:19:18 -0500
X-MC-Unique: 5fCWULkJMCi4GVh-xlRPuA-1
X-Mimecast-MFC-AGG-ID: 5fCWULkJMCi4GVh-xlRPuA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D261955F3C; Thu,  5 Dec 2024 16:19:17 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05B9F3000197; Thu,  5 Dec 2024 16:19:15 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	michael.roth@amd.com,
	jtomko@redhat.com
Subject: [PATCH v2 4/4] qga: Make run_agent() and run_agent_once() return no
 value
Date: Thu,  5 Dec 2024 17:18:48 +0100
Message-ID: <8f4469febaaf5c48afdf13a6c88e959956c0f204.1733414906.git.mprivozn@redhat.com>
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

After previous commits, run_agent_once() can't return anything
else but EXIT_SUCCESS. Transitionally, run_agent() can't return
anything else but EXIT_SUCCESS too. There's not much value in
having these function return an integer. Make them return void.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
---
 qga/main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 35f061b5ea..346274f114 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -145,7 +145,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
 DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
 #endif
-static int run_agent(GAState *s);
+static void run_agent(GAState *s);
 static void stop_agent(GAState *s, bool requested);
 
 static void
@@ -1521,7 +1521,7 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent_once(GAState *s)
+static void run_agent_once(GAState *s)
 {
     if (!s->channel &&
         channel_init(s, s->config->method, s->config->channel_path,
@@ -1536,8 +1536,6 @@ static int run_agent_once(GAState *s)
         ga_channel_free(s->channel);
         s->channel = NULL;
     }
-
-    return EXIT_SUCCESS;
 }
 
 static void wait_for_channel_availability(GAState *s)
@@ -1561,21 +1559,17 @@ static void wait_for_channel_availability(GAState *s)
 #endif
 }
 
-static int run_agent(GAState *s)
+static void run_agent(GAState *s)
 {
-    int ret = EXIT_SUCCESS;
-
     s->force_exit = false;
 
     do {
-        ret = run_agent_once(s);
+        run_agent_once(s);
         if (s->config->retry_path && !s->force_exit) {
             g_warning("agent stopped unexpectedly, restarting...");
             wait_for_channel_availability(s);
         }
     } while (s->config->retry_path && !s->force_exit);
-
-    return ret;
 }
 
 static void stop_agent(GAState *s, bool requested)
@@ -1674,14 +1668,15 @@ int main(int argc, char **argv)
         SERVICE_TABLE_ENTRY service_table[] = {
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
-        ret = EXIT_SUCCESS;
     } else {
-        ret = run_agent(s);
+        run_agent(s);
     }
 #else
-    ret = run_agent(s);
+    run_agent(s);
 #endif
 
+    ret = EXIT_SUCCESS;
+
     cleanup_agent(s);
 
 end:
-- 
2.45.2


