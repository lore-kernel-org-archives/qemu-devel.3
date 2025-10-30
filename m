Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F5CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESSe-0002pd-9e; Thu, 30 Oct 2025 09:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSa-0002pB-6k
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSQ-000422-JA
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761829967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yHZZrrUUQSRMnvFRda+HRmPuFvqQu6zL0MvP+J40a4=;
 b=EbJO8KhXOATgJTPYgsItldrTX2TRVMlfsIqYLt7yBN9ohHVpnujsL/dIUA50BntBGxaf63
 GKnhm4hHqTyscARRp2KTIF4qwk7tvwn02t9D4AohCXwRiDjvBM8np85T7bTgxU4pr9GZH9
 NHGnoOHKyutZptsQ3FZj8A/BIbEuzaI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-u1QshRhOOUGE4KZv8KXyDA-1; Thu,
 30 Oct 2025 09:12:45 -0400
X-MC-Unique: u1QshRhOOUGE4KZv8KXyDA-1
X-Mimecast-MFC-AGG-ID: u1QshRhOOUGE4KZv8KXyDA_1761829964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EEDD180A238; Thu, 30 Oct 2025 13:12:44 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F37419560A2; Thu, 30 Oct 2025 13:12:42 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/3] scripts/qemu-guest-agent/fsfreeze-hook: improve script
 description
Date: Thu, 30 Oct 2025 15:12:35 +0200
Message-ID: <20251030131237.181588-2-kkostiuk@redhat.com>
In-Reply-To: <20251030131237.181588-1-kkostiuk@redhat.com>
References: <20251030131237.181588-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

With the current wording, users might think that the -F option is not
required as long as the script is placed in the default path. Be clear
that the option is always required. Also includes some minor language
improvements in the rest of the comment.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250916122111.36019-1-f.ebner@proxmox.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index c1feb6f5ce..5b915af017 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -1,11 +1,12 @@
 #!/bin/sh
 
-# This script is executed when a guest agent receives fsfreeze-freeze and
-# fsfreeze-thaw command, if it is specified in --fsfreeze-hook (-F)
-# option of qemu-ga or placed in default path (/etc/qemu/fsfreeze-hook).
-# When the agent receives fsfreeze-freeze request, this script is issued with
-# "freeze" argument before the filesystem is frozen. And for fsfreeze-thaw
-# request, it is issued with "thaw" argument after filesystem is thawed.
+# This script is executed when the guest agent receives fsfreeze-freeze and
+# fsfreeze-thaw commands, provided that the --fsfreeze-hook (-F) option of
+# qemu-ga is specified and the script is placed in /etc/qemu/fsfreeze-hook or in
+# the path specified together with -F. When the agent receives fsfreeze-freeze
+# requests, this script is called with "freeze" as its argument before the
+# filesystem is frozen. And for fsfreeze-thaw requests, it is called with "thaw"
+# as its argument after the filesystem is thawed.
 
 LOGFILE=/var/log/qga-fsfreeze-hook.log
 FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
-- 
2.51.1.dirty


