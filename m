Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8S-0003bN-6k; Sun, 03 Mar 2024 20:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7n-0002IX-3l
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7h-0002Pv-12
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOEXJHhRYNP/4RHTVDV6YHp0PaX9wEiaCsnJ5jySJbs=;
 b=ITKabAVlLuoCqbhl9LVC8HSKEbddfl9lc8TA51hgEFuP8cQ4y36DHOEwP89VVez2QqGKzC
 4QfjJ6V2O+ibnOdEav4dlNtaFDXEtpMr9YIqSMmYZS4ZLL96Jivhkl6nqgAvUqApXQbEu7
 0twvi85OuhT8oz2i5TKCGl/z3kPYPMg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-x8jkTkD6M8OXliMpgjiAnQ-1; Sun,
 03 Mar 2024 20:28:04 -0500
X-MC-Unique: x8jkTkD6M8OXliMpgjiAnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F98B3C0DD02;
 Mon,  4 Mar 2024 01:28:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F275540C6EBA;
 Mon,  4 Mar 2024 01:28:00 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 19/27] migration/multifd: Add a wrapper for channels_created
Date: Mon,  4 Mar 2024 09:26:26 +0800
Message-ID: <20240304012634.95520-20-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We'll need to access multifd_send_state->channels_created from outside
multifd.c, so introduce a helper for that.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-17-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 1 +
 migration/multifd.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 1be985978e..1d8bbaf96b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -17,6 +17,7 @@ typedef struct MultiFDRecvData MultiFDRecvData;
 
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
+void multifd_send_channel_created(void);
 int multifd_recv_setup(Error **errp);
 void multifd_recv_cleanup(void);
 void multifd_recv_shutdown(void);
diff --git a/migration/multifd.c b/migration/multifd.c
index d470af73ba..3574fd3953 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -101,6 +101,11 @@ static bool multifd_use_packets(void)
     return !migrate_mapped_ram();
 }
 
+void multifd_send_channel_created(void)
+{
+    qemu_sem_post(&multifd_send_state->channels_created);
+}
+
 /* Multifd without compression */
 
 /**
@@ -1023,7 +1028,7 @@ out:
      * Here we're not interested whether creation succeeded, only that
      * it happened at all.
      */
-    qemu_sem_post(&multifd_send_state->channels_created);
+    multifd_send_channel_created();
 
     if (ret) {
         return;
-- 
2.44.0


