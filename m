Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E710CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjaJ-0000FW-BB; Mon, 21 Jul 2025 02:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYy-0008Ar-5D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYw-00066p-CQ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JscNhwd78VHvraiWW7XVgG/TrI6DefncU95YkqltVc=;
 b=A+LUO0vbBfvixofotxzTwvjNFVBoOeXfHLRtRmbzo+xjiAOhjYQ3xC/TqOlX+zsS7en9s1
 k6IwVWfA4V2X0nLu5Y0HBKAZuGkzF/QIVSosGMPgaFpuT7HRTUFM5PQ7igcSiYKXlvxFrO
 RazRkoTQCGjoPQJ5ehnCaaONbXTQhxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-2FAKuCOGMC-OjN9ca4i4Yw-1; Mon,
 21 Jul 2025 01:59:41 -0400
X-MC-Unique: 2FAKuCOGMC-OjN9ca4i4Yw-1
X-Mimecast-MFC-AGG-ID: 2FAKuCOGMC-OjN9ca4i4Yw_1753077580
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D7B41800366; Mon, 21 Jul 2025 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80C60195608D; Mon, 21 Jul 2025 05:59:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/12] tap: fix net_init_tap() return code
Date: Mon, 21 Jul 2025 13:59:17 +0800
Message-ID: <20250721055927.75951-3-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

net_init_tap intends to return 0 for success and -1 on error.  However,
when net_init_tap() succeeds for a multi-queue device, it returns 1,
because of this code where ret becomes 1 when g_unix_set_fd_nonblocking
succeeds:

        ret = g_unix_set_fd_nonblocking(fd, true, NULL);
        if (!ret) {
            ... error ...
    free_fail:
        ...
        return ret;

Luckily, the only current call site checks for negative, rather than non-zero:

  net_client_init1()
      if (net_client_init_fun[](...) < 0)

Also, in the unlikely case that g_unix_set_fd_nonblocking fails and returns
false, ret=0 is returned, and net_client_init1 will use a broken interface.

Fix it to be future proof.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2a85936019..f7df702f97 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -895,8 +895,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            ret = g_unix_set_fd_nonblocking(fd, true, NULL);
-            if (!ret) {
+            if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
+                ret = -1;
                 error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
                                  name, fd);
                 goto free_fail;
-- 
2.42.0


