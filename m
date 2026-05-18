Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6D5CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvaL-0003qH-71; Mon, 18 May 2026 06:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvaF-0003pY-34
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvaA-0000uL-BU
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779101533; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=+hgx9+P/bk9g/hlGdeeb4w+pdmwgio+VTmgH9idLe9M=;
 b=EVJmpOfEDTqUls+cXKnHxFWhC1FKj1TafAE26vAHJ5ZKkYIwqq8u/1KrnnTkiVYj5Iev0vdDTpduNpmA9aU2ijcvubSQMoaPTsfpuIilNx6x7O+1cbaJ3tP3nGQJpgaXZhkUV9Dc7E6/50pUCUs/o9q6NSopm9H23nZIYhcLOX4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X37tZ1i_1779101528; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X37tZ1i_1779101528 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 18:52:12 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 2/8] migration/global_state: replace strcpy("") with explicit
 NUL termination
Date: Mon, 18 May 2026 18:51:49 +0800
Message-ID: <20260518105156.17626-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518105156.17626-1-guobin@linux.alibaba.com>
References: <20260518105156.17626-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Drop the unnecessary strcpy of an empty literal (and its spurious
(char *)& cast) in favor of a direct NUL store, which avoids the
libc call and hides no bugs behind a cast.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/global_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index c1f90fce0f..91fefdf525 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -148,7 +148,7 @@ static const VMStateDescription vmstate_globalstate = {
 void register_global_state(void)
 {
     /* We would use it independently that we receive it */
-    strcpy((char *)&global_state.runstate, "");
+    global_state.runstate[0] = '\0';
     global_state.received = false;
     vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
 }
-- 
2.50.1 (Apple Git-155)


