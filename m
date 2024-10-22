Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6692D2CDFF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4d-0000PF-Fw; Tue, 22 Oct 2024 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4a-0000Hv-1H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-00064a-8j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrwhFD+yJwwRK0vf/7Ph/1BLKTn0dL60XtkUPqjTahc=;
 b=E0rn3F7hq+7ZFw4p38azUOIKsyUuKYDyU0WXotKPGSuvdgrjcT0xMVqjTzqlVXNM6on4cv
 eM2x9bDYZB4Na8R6Yh0h7dtVvPXainfDqPWVxCpqCTJmpoeHXDk0dsW5dwzUm0UAZMS/Wd
 bx5CL4RipIADEryaIRWZnJormXftyhg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-WRJkCBd6NyuXEFf1vxyxyQ-1; Tue,
 22 Oct 2024 12:49:16 -0400
X-MC-Unique: WRJkCBd6NyuXEFf1vxyxyQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA2B1956046; Tue, 22 Oct 2024 16:49:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0C3A1956056; Tue, 22 Oct 2024 16:49:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/9] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
Date: Tue, 22 Oct 2024 18:48:55 +0200
Message-ID: <20241022164903.282174-2-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In the loop in qemu_gluster_parse_json() we do:

    char *str = NULL;
    for(...) {
        str = g_strdup_printf(...);
        ...
        if (various errors) {
            goto out;
        }
        ...
        g_free(str);
        str = NULL;
    }
    return 0;
out:
    various cleanups;
    g_free(str);
    ...
    return -errno;

Coverity correctly complains that the assignment "str = NULL" at the
end of the loop is unnecessary, because we will either go back to the
top of the loop and overwrite it, or else we will exit the loop and
then exit the function without ever reading str again. The assignment
is there as defensive coding to ensure that str is only non-NULL if
it's a live allocation, so this is intentional.

We can make Coverity happier and simplify the code here by using
g_autofree, since we never need 'str' outside the loop.

Resolves: Coverity CID 1527385
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241008164708.2966400-2-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index f03d05251e..e9c038042b 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -514,7 +514,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     SocketAddressList **tail;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
-    char *str = NULL;
     const char *ptr;
     int i, type, num_servers;
 
@@ -547,7 +546,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     tail = &gconf->server;
 
     for (i = 0; i < num_servers; i++) {
-        str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
+        g_autofree char *str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.",
+                                               i);
         qdict_extract_subqdict(options, &backing_options, str);
 
         /* create opts info from runtime_type_opts list */
@@ -658,8 +658,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         qobject_unref(backing_options);
         backing_options = NULL;
-        g_free(str);
-        str = NULL;
     }
 
     return 0;
@@ -668,7 +666,6 @@ out:
     error_propagate(errp, local_err);
     qapi_free_SocketAddress(gsconf);
     qemu_opts_del(opts);
-    g_free(str);
     qobject_unref(backing_options);
     errno = EINVAL;
     return -errno;
-- 
2.47.0


