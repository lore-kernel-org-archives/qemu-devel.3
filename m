Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2813CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6k-0001D6-5E; Sun, 03 Mar 2024 20:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6i-0001Cb-SE
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6h-0002EE-7K
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJAI1gAQLc7X13eSRo6rRfshCDrM0B/QS5LuWZzr9kU=;
 b=Puey8nsCIcaiqZx/et/F8Rof5yag6SNGZF2+prSMrKhyD+Bn3hc8EL8qiAS8dArEbM5Vow
 +iQDgkkqJ7oUaf3sopgaULdOENf1Fed1Dd19IFTaMbLbR6i2XqnK0EPYG5Z4UwChQbxi7f
 31NEQtmHrhiIq9TZXt+4NWBvr+rCeMs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411--zhynwtGM_a9NZJT-sLgfA-1; Sun,
 03 Mar 2024 20:27:04 -0500
X-MC-Unique: -zhynwtGM_a9NZJT-sLgfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44EE629ABA02;
 Mon,  4 Mar 2024 01:27:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73CFF40C6EBA;
 Mon,  4 Mar 2024 01:27:00 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 05/27] io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for
 channel file
Date: Mon,  4 Mar 2024 09:26:12 +0800
Message-ID: <20240304012634.95520-6-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nikolay Borisov <nborisov@suse.com>

Add a generic QIOChannel feature SEEKABLE which would be used by the
qemu_file* apis. For the time being this will be only implemented for
file channels.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h | 1 +
 io/channel-file.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5f9dbaab65..fcb19fd672 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -44,6 +44,7 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_LISTEN,
     QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY,
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
+    QIO_CHANNEL_FEATURE_SEEKABLE,
 };
 
 
diff --git a/io/channel-file.c b/io/channel-file.c
index 4a12c61886..f91bf6db1c 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -36,6 +36,10 @@ qio_channel_file_new_fd(int fd)
 
     ioc->fd = fd;
 
+    if (lseek(fd, 0, SEEK_CUR) != (off_t)-1) {
+        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
+    }
+
     trace_qio_channel_file_new_fd(ioc, fd);
 
     return ioc;
@@ -60,6 +64,10 @@ qio_channel_file_new_path(const char *path,
         return NULL;
     }
 
+    if (lseek(ioc->fd, 0, SEEK_CUR) != (off_t)-1) {
+        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
+    }
+
     trace_qio_channel_file_new_path(ioc, path, flags, mode, ioc->fd);
 
     return ioc;
-- 
2.44.0


