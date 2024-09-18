Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB2CDD55F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4HS-0006c9-JT; Wed, 18 Sep 2024 19:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4HO-0006bS-I7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:40:14 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4HL-0000oG-AJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=dTIntThqI0I9hA9G3JbOPz76/20uZGcN17w4JplCOQw=; b=FU49795pLeqYZ1I2
 N2kdAN+O3ZLiSrMdm91q4E+n+5/UtR8lAPWnoJqKGd7JWy3+9+CzPkKXN2Oi/92AvQi06ANlfHs/8
 48imLMZePbLKOOkEKDuB30UlrUUIiqWOx7PzI8xhC/A/EVz5NHRI4tJ65cQvBt2w9BfTouEe6hyQ8
 f5z0/yCQWP0wrCcyL5K41FCUifujzoz0DE/AufnAZR5fL/xCfvTexEBzZGfWlLqNm/p/qo2fnuv78
 oGrN8DM5YRrsH0eyNlhlhgSh0OId2ggUpCty128twN1yRJSZoveIkfKp2HGXROOX2aHI6UeA9K5ti
 XB5Nmn+hELl1ojEt4w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr4HG-006M0l-1R;
 Wed, 18 Sep 2024 23:40:06 +0000
From: dave@treblig.org
To: pavel.dovgaluk@ispras.ru,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] replay: Remove unused replay_disable_events
Date: Thu, 19 Sep 2024 00:40:05 +0100
Message-ID: <20240918234005.466999-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

replay_disable_events has been unused since 2019's
  c8aa7895eb ("replay: don't drain/flush bdrv queue while RR is working")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/sysemu/replay.h | 2 --
 replay/replay-events.c  | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8102fa54f0..cba74fa9bc 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -117,8 +117,6 @@ void replay_async_events(void);
 
 /* Asynchronous events queue */
 
-/*! Disables storing events in the queue */
-void replay_disable_events(void);
 /*! Enables storing events in the queue */
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
diff --git a/replay/replay-events.c b/replay/replay-events.c
index af0721cc1a..2e46eda6bf 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -92,15 +92,6 @@ void replay_flush_events(void)
     }
 }
 
-void replay_disable_events(void)
-{
-    if (replay_mode != REPLAY_MODE_NONE) {
-        events_enabled = false;
-        /* Flush events queue before waiting of completion */
-        replay_flush_events();
-    }
-}
-
 /*! Adds specified async event to the queue */
 void replay_add_event(ReplayAsyncEventKind event_kind,
                       void *opaque,
-- 
2.46.0


