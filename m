Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76492D132A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tn7-0002XQ-2q; Mon, 04 Nov 2024 04:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tn6-0002XI-Es
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tn4-0002lo-UK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBgza4hhP23Pb2M0lj59Qny3KhuoCZYtJwoGS3tsh8o=;
 b=ITCM/QgU7tMg0oenm8w7HM7OEGFNZ5YB9Ftb7k6ENpBMG4mmwyvzNwWVIsFus8GyWkUdyQ
 HF8xJ2IYo5X0Xip3p9zIoz6dt5cU3AxmrJJE14QoANxDsZnd7IBYn+i6PHKT7F1aTV76aO
 pk/QOEI2VW1zF0wue7CS27jd3+yBJHw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-iGXw1G8yPmm-SKUFGxPePg-1; Mon,
 04 Nov 2024 04:54:23 -0500
X-MC-Unique: iGXw1G8yPmm-SKUFGxPePg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 009C219560A2; Mon,  4 Nov 2024 09:54:22 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9E51300018D; Mon,  4 Nov 2024 09:54:20 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 4/4] qga: Make run_agent() and run_agent_once() return no value
Date: Mon,  4 Nov 2024 10:54:10 +0100
Message-ID: <36b6cfd879215f67ad92753a57565c14a64d8704.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
References: <cover.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

After previous commits, run_agent_once() can't return anything
else but EXIT_SUCCESS. Transitionally, run_agent() can't return
anything else but EXIT_SUCCESS too. There's not much value in
having these function return an integer. Make them return void.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/main.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 6240845f39..bcc182d64d 100644
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
@@ -1521,15 +1521,13 @@ static void cleanup_agent(GAState *s)
     ga_state = NULL;
 }
 
-static int run_agent_once(GAState *s)
+static void run_agent_once(GAState *s)
 {
     g_main_loop_run(s->main_loop);
 
     if (s->channel) {
         ga_channel_free(s->channel);
     }
-
-    return EXIT_SUCCESS;
 }
 
 static void wait_for_channel_availability(GAState *s)
@@ -1553,21 +1551,17 @@ static void wait_for_channel_availability(GAState *s)
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
@@ -1667,12 +1661,14 @@ int main(int argc, char **argv)
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
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


