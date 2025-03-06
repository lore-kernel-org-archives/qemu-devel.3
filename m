Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551DFC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0rU-0003dz-Dq; Wed, 05 Mar 2025 21:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tq0rT-0003dp-6Q
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tq0rR-0003hS-LP
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741227678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXwUaM8NN4kKieEtmoCvD7sRtFBCEuOKuWxpcxPxfBE=;
 b=i7BdDaSzfkUAai+xBMKZNKPoWx6E7EjLayDYAVK5yzpGucFl9n9jlQbkZYoBeTrzvKw3OQ
 DPvclJUdHLMg21iJGR012LaXjkkOIEHBeUbSHcUv/oNRHI3kathH+i/SPy5MgJ3Enn3yvW
 fddy6gcqQDo6aNgY6wVXvHN13iQQoeA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-NejHA3KiOPS3KAO4EueePA-1; Wed,
 05 Mar 2025 21:21:15 -0500
X-MC-Unique: NejHA3KiOPS3KAO4EueePA-1
X-Mimecast-MFC-AGG-ID: NejHA3KiOPS3KAO4EueePA_1741227674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 329E9195608D; Thu,  6 Mar 2025 02:21:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CFEB180035E; Thu,  6 Mar 2025 02:21:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Denis Rastyogin <gerben@altlinux.org>
Subject: [PULL 1/1] block/qed: fix use-after-free by nullifying timer pointer
 after free
Date: Thu,  6 Mar 2025 10:21:06 +0800
Message-ID: <20250306022106.304510-2-stefanha@redhat.com>
In-Reply-To: <20250306022106.304510-1-stefanha@redhat.com>
References: <20250306022106.304510-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

In the QED block driver, the need_check_timer timer is freed in
bdrv_qed_detach_aio_context, but the pointer to the timer is not
set to NULL. This can lead to a use-after-free scenario
in bdrv_qed_drain_begin().

The need_check_timer pointer is set to NULL after freeing the timer.
Which helps catch this condition when checking in bdrv_qed_drain_begin().

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2852
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Message-ID: <20250304083927.37681-1-gerben@altlinux.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qed.c b/block/qed.c
index 382c9e5335..ac24449ffb 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -353,6 +353,7 @@ static void bdrv_qed_detach_aio_context(BlockDriverState *bs)
 
     qed_cancel_need_check_timer(s);
     timer_free(s->need_check_timer);
+    s->need_check_timer = NULL;
 }
 
 static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
-- 
2.48.1


