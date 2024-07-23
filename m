Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BEBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Yz-0008Dm-PF; Tue, 23 Jul 2024 03:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yp-0007p4-Oi
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yo-0000uq-6Y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+4OEcfCBx1yNmRfg8InUQI1xPEQU0KY9UnlgF5lAIQ=;
 b=O0McTWQ5WZo59skny/BkFM6rS7zumxaA2qB4lpDJ4qlbz8wGZoV/9ZNdeIBw/yH1q0XRAE
 9xApPAwr5Y7g9zYzxLSeFCXI91dT28+YSc849Id/4Bb7F5ZPsY2IuaXFnr8iPD0DCaqtig
 H2ivD/8e775WXFaAmFzAT1pSZxVe9Sc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-E1-x1rsGN2COOPjS1pOCwQ-1; Tue,
 23 Jul 2024 03:03:41 -0400
X-MC-Unique: E1-x1rsGN2COOPjS1pOCwQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17C031955BF4; Tue, 23 Jul 2024 07:03:41 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988E43000197; Tue, 23 Jul 2024 07:03:39 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 23/25] qga/commands-posix: Make ga_wait_child() return
 boolean
Date: Tue, 23 Jul 2024 10:02:49 +0300
Message-ID: <20240723070251.25575-24-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Make ga_wait_child() return boolean and check the returned boolean
in ga_run_command() instead of dereferencing @errp.

Cc: Michael Roth <michael.roth@amd.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20240716162351.270095-1-zhao1.liu@intel.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 578d29f228..c2bd0b4316 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -48,7 +48,7 @@
 #endif
 #endif
 
-static void ga_wait_child(pid_t pid, int *status, Error **errp)
+static bool ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
 
@@ -59,10 +59,11 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
     if (rpid == -1) {
         error_setg_errno(errp, errno, "failed to wait for child (pid: %d)",
                          pid);
-        return;
+        return false;
     }
 
     g_assert(rpid == pid);
+    return true;
 }
 
 static ssize_t ga_pipe_read_str(int fd[2], char **str)
@@ -167,8 +168,7 @@ static int ga_run_command(const char *argv[], const char *in_str,
         goto out;
     }
 
-    ga_wait_child(pid, &status, errp);
-    if (*errp) {
+    if (!ga_wait_child(pid, &status, errp)) {
         goto out;
     }
 
-- 
2.45.2


