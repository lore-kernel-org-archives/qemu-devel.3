Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E33AC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwN-00080I-0k; Mon, 07 Sep 2026 06:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwL-0007zd-Da
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwJ-00085p-U3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55d5+Bk/PPCECwITaJI+af3wS9ezo/MiSarVcMf/BVY=;
 b=YV1M8UwYPTQLPY0ePA73M6IxK64qz9zh0IBsvrEDR+nuTTaipLdh2ZcFWD+7y91kx3eYCh
 C2a6FoWMsQ5YawE3mQ1fngnYhg9qhfBpz01UoiNp9tmJrBGFiEle38nO869UTuQNsMWDJ6
 zIObYRtoRUdGsFYLE3zxeGjuhUuSNsc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-imP93Zr1OLCmGq-Y196Hvg-1; Mon,
 07 Sep 2026 06:51:02 -0400
X-MC-Unique: imP93Zr1OLCmGq-Y196Hvg-1
X-Mimecast-MFC-AGG-ID: imP93Zr1OLCmGq-Y196Hvg_1788778261
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4B91954AE4; Mon,  7 Sep 2026 10:51:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33CE21956042; Mon,  7 Sep 2026 10:50:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:13 +0400
Subject: [PATCH 15/17] qga/vss-win32: initialize *num_vols at start of
 requester_freeze
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-15-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YvAZ7FyAYlgMnFp2aEC5hIldna5HU3GCZJ5PQBv+yaw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjspH3rUiMk3NLpunctZRhA43qR1L4f7f5j
 0Jvn/GqcMqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5eIXD/9JTVlPev1fTyk4rpKtrMGUXZ4+rFeiR2PWxKMH0kB+g3yiW1smsfBbZX4hq05T2IfuW9L
 x6GeU+EPhqwn3wlGFit3/wS240OeP8GxEIadIhfP7Uzx/C2k1z0OnAg7rczx9ey0+EFCVvClE+i
 +NNVUP70EoQpYWHCGem5HCYbnd7oj/yu6L9ZvLQgSpxsLtarB4mrpLHo4xE3pf0RJwBAjgDsD+D
 /M9qePhxhoaZWBrWHxQJxeIhQc7N25L9APrEgtCVpWL1CLwp4wlawRHtinRsEGn8pw7NMxFRDf6
 cJUU0ohXVUlIKpuuCKQq22Ogged6njlmjlOqGgIbdk+Z6QKQRTrM3NtcxTqngG6ublt5lAM3MZo
 1SBixf2AavyACjorgwHvpjSkJuUxVZmaruInAaH3T9b0WWJIqLmwgCJMjb92K8irlxamgkcYiXq
 hjCO50sj3JkJweNNuLyCPSyno1P0prWYr0jK7G7MEprW+xp/ZnPPzfQ8sUtdteSZzovZr/kA8JW
 +SGeN3Eop7k3hs2d/Kr8j1U1h9vTo5envcfiauisHzAx49KiAvj7HkkLbY0MRJ871xoXWRxQQ1F
 ksuSJ8v0+uJmX0kY1MH+0+7E0Ip1EnodmbNnXzGryh3h3YXA4jhCsn4634fxpW/bAfB72TPnkC7
 YwDLYthiVdKVXhg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Initialize *num_vols to 0 at the top of requester_freeze() so all error
paths and zero-volume early exits return a defined value to the caller.
Previously, only the already-frozen path and the success path set
*num_vols; every goto-out error path left it indeterminate.

The sole caller is qga_vss_freeze(), which already sets *nr_volume = 0.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index f14c47f9f7a9..d36a90c17d1d 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -306,8 +306,9 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     int num_mount_points = 0;
     VSS_BACKUP_TYPE vss_bt = get_vss_backup_type();
 
+    *num_vols = 0;
+
     if (vss_ctx.pVssbc) { /* already frozen */
-        *num_vols = 0;
         qga_debug("finished, already frozen");
         return;
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


