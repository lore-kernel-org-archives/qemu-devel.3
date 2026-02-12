Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC9AEEA851
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeE9-0004JB-LM; Thu, 12 Feb 2026 16:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqeE8-0004Ih-7E
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqeE5-0001oi-3E
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770931671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bQyAIibJZ6FqVDGZoXb8EDWrAYh5f0GNLO3GKi3Ie64=;
 b=hLijrWw9SS2Ay8JkFZafVv9nSQ3IarVk1EgnKHBu+n1V3pDj0+qT/OOPl7LU892PMvA1Q+
 8Ds5CrjLGR0sAJ61bh0bGjU/9RC8p51Q3fQJ+U5ZIJoovyu3ir49Mz1VTxtf4WMzqhPwKT
 q/fFL0c/hw3i1H2yL2pCKoYLpga5Tec=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-9sKssSd-OzyFYLe-z1yLMw-1; Thu,
 12 Feb 2026 16:27:47 -0500
X-MC-Unique: 9sKssSd-OzyFYLe-z1yLMw-1
X-Mimecast-MFC-AGG-ID: 9sKssSd-OzyFYLe-z1yLMw_1770931666
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8B2C19560AA; Thu, 12 Feb 2026 21:27:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.182])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC1CF1800298; Thu, 12 Feb 2026 21:27:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, xeor@yandex-team.ru,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] block: Never drop BLOCK_IO_ERROR with action=stop for rate
 limiting
Date: Thu, 12 Feb 2026 22:27:38 +0100
Message-ID: <20260212212738.141780-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
event only once a second. This makes sense for cases in which the guest
keeps running and can submit more requests that would possibly also fail
because there is a problem with the backend.

However, if the error policy is configured so that the VM is stopped on
errors, this is both unnecessary because stopping the VM means that the
guest can't issue more requests and in fact harmful because stopping the
VM is an important state change that management tools need to keep track
of even if it happens more than once in a given second. If an event is
dropped, the management tool would see a VM randomly going to paused
state without an associated error, so it has a hard time deciding how to
handle the situation.

This patch disables rate limiting for action=stop by essentially
considering all BLOCK_IO_ERRORs with action=stop different errors. If
the error is reported to the guest or ignored, the rate limiting stays
in place.

Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  2 +-
 monitor/monitor.c    | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af742561..4118d884f46 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5789,7 +5789,7 @@
 # .. note:: If action is "stop", a `STOP` event will eventually follow
 #    the `BLOCK_IO_ERROR` event.
 #
-# .. note:: This event is rate-limited.
+# .. note:: This event is rate-limited, except if action is "stop".
 #
 # Since: 0.13
 #
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1273eb72605..93bd2b93e65 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -525,6 +525,18 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
                        qdict_get_str(evb->data, "node-name"));
     }
 
+    /*
+     * If the VM is stopped after an I/O error, this is important information
+     * for the management tool to keep track of the state of QEMU and we can't
+     * merge any events. At the same time, stopping the VM means that the guest
+     * can't send additional requests and the number of events is already
+     * limited, so we can do without rate limiting.
+     */
+    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR &&
+        !strcmp(qdict_get_str(eva->data, "action"), "stop")) {
+        return FALSE;
+    }
+
     if (eva->event == QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE ||
         eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
         return !strcmp(qdict_get_str(eva->data, "qom-path"),
-- 
2.53.0


