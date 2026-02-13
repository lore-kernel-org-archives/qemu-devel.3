Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5BEDF147
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqq52-0000MF-K4; Fri, 13 Feb 2026 05:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vqq50-0000Gs-MI
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:07:18 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vqq4y-0002l2-Tm
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:07:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 474EC80866;
 Fri, 13 Feb 2026 13:07:14 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:d48::1:1c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id s6SruK1AHuQ0-67PcUodW; Fri, 13 Feb 2026 13:07:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770977233;
 bh=fCvYt1W4RO4KQUCccROn9TPj2OVobPXymgDkviTn1YY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=cQRMgp1+HiHXQ1ZiMVXH726y6W8s6j2MRTkz3KYc6hq94j1AF2l7a+Y7gY7c+Vl6Y
 PhLdq+0bTpzHTlPDXwqbnY4nrIcMZqRrt0XQTJ6YS7+n8Yk/nRbr52rBcpSU8BHGbo
 OCe3OEjpWiJn0p4euZCZjMe5S7DiKzCUaaPtCbMs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 1/1] vhost: fix vhost_inflight_buffer_pre_load
Date: Fri, 13 Feb 2026 15:06:49 +0500
Message-Id: <20260213100647.432974-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213100647.432974-1-dtalexundeer@yandex-team.ru>
References: <20260213100647.432974-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

While I was rebasing my series about inflight migration, I missed a
small issue in vhost_inflight_buffer_preload in

3a80ff0 ("vhost: add vmstate for inflight region with inner buffer")

* return wrong type in function
* missed ERRP_GUARD

so fixed it in this patch.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52801c1796..56eb1c4a02 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1920,6 +1920,7 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
 
 static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
 {
+    ERRP_GUARD();
     struct vhost_inflight *inflight = opaque;
 
     int fd = -1;
@@ -1927,7 +1928,7 @@ static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
                                   F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
                                   &fd, errp);
     if (*errp) {
-        return -ENOMEM;
+        return false;
     }
 
     inflight->offset = 0;
-- 
2.34.1


