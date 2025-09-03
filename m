Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB78CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk2Y-00068l-UL; Wed, 03 Sep 2025 05:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2R-00063v-5y; Wed, 03 Sep 2025 05:44:23 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk2N-0007uR-S3; Wed, 03 Sep 2025 05:44:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 15CD08067A;
 Wed, 03 Sep 2025 12:44:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EicMoq3GhCg0-u946eTFc; Wed, 03 Sep 2025 12:44:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892655;
 bh=LdOEsfMv9+PXz13uCV6qZQY+vLOFE3HhoDVvWVSOAWc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=unZJsqTOEcaT/Mj/DvUYDNcx4ceuEqoxa3/t8/9xjMXVQIBW5R2D+Y9f4umew1CMr
 20/BHKBocmmNhct5E37yYT87thyxaisNp76f+F2MJzGm2aIk/cE3VdxsgUQ8zbwiVn
 6nb55Wkmzi+Boz6tcCJQPJJEfWMo2hX5ET5RjLXs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH 01/10] io/channel: document how qio_channel_readv_full()
 handles fds
Date: Wed,  3 Sep 2025 12:44:01 +0300
Message-ID: <20250903094411.1029449-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The only realization, which may have incoming fds is
qio_channel_socket_readv() (in io/channel-socket.c).
qio_channel_socket_readv() do call (through
qio_channel_socket_copy_fds()) qemu_socket_set_block() and
qemu_set_cloexec() for each fd.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/io/channel.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 234e5db70d..b848d50b99 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -117,6 +117,12 @@ struct QIOChannelClass {
                          size_t nfds,
                          int flags,
                          Error **errp);
+
+    /*
+     * The io_readv handler must guarantee that all
+     * incoming fds are set BLOCKING and CLOEXEC (if
+     * available).
+     */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
                         size_t niov,
@@ -124,6 +130,7 @@ struct QIOChannelClass {
                         size_t *nfds,
                         int flags,
                         Error **errp);
+
     int (*io_close)(QIOChannel *ioc,
                     Error **errp);
     GSource * (*io_create_watch)(QIOChannel *ioc,
@@ -234,6 +241,9 @@ void qio_channel_set_name(QIOChannel *ioc,
  * was allocated. It is the callers responsibility
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
+ * qio_channel_readv_full() guarantees that all
+ * incoming fds are set BLOCKING and CLOEXEC (if
+ * available).
  *
  * It is an error to pass a non-NULL @fds parameter
  * unless qio_channel_has_feature() returns a true
-- 
2.48.1


