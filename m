Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFB5CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNth1-0002rP-Hj; Fri, 15 May 2026 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wNtgv-0002qk-To
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wNtgs-0005QO-4N
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778855941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=slS+xGGBrcxWvZFE84wqwyyN2BCLJeaqhOxhyQmvPRA=;
 b=aEm8ZiHbmoleC4HZD6nFTFzS3JuMH91QgXH+FlS8XYZyLDtD1o+fMbGMdbxNqE2pvhOUlK
 x9eAjY+B8vIoEYIpiNS4EGf+9Qa2V4wGuAeCuV8swmbR5QoDX3ZOtTYdiTBoMdFdXLSWZT
 XpN8giLOhhB4XHDflA0f2/Y6gy1tOmI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-VupEgE11O5Wfws3pu5llNg-1; Fri,
 15 May 2026 10:38:59 -0400
X-MC-Unique: VupEgE11O5Wfws3pu5llNg-1
X-Mimecast-MFC-AGG-ID: VupEgE11O5Wfws3pu5llNg_1778855938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 623B419560BA; Fri, 15 May 2026 14:38:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70EC01956053; Fri, 15 May 2026 14:38:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: f.ebner@proxmox.com,
	qemu-trivial@nongnu.org
Subject: [PATCH] system/vl: Free allocate memory for pid file name in case
 realpath() failed
Date: Fri, 15 May 2026 16:38:54 +0200
Message-ID: <20260515143854.2010741-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

In case realpath() fails, the code returns early in the function
qemu_maybe_daemonize(), without freeing the allocated memory. Add
a g_free() here to fix it.

Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 system/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/vl.c b/system/vl.c
index d2f4044e5d8..7e2ed898240 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2670,6 +2670,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
                 warn_report("not removing PID file on exit: cannot resolve PID "
                             "file path: %s: %s", pid_file, strerror(errno));
             }
+            g_free(pid_file_realpath);
             return;
         }
 
-- 
2.54.0


