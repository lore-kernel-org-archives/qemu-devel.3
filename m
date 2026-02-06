Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07787EA795E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIXA-0001st-DG; Fri, 06 Feb 2026 04:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWe-0001lW-DO; Fri, 06 Feb 2026 04:53:20 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWd-0000GO-0j; Fri, 06 Feb 2026 04:53:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 97D6AC01C3;
 Fri, 06 Feb 2026 12:53:16 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-XC03yE6m; Fri, 06 Feb 2026 12:53:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371596;
 bh=6nZ/Ugp0qM1nB8yAWkoxwVcWCChUPUTOGmoIYrlH+Qw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mGYadpcWTPRi5Z05ewMwDyiGNNBxJCFm1YtZ8mw31qNK9s5U8YIq35ejb25AgWEJ1
 OcTzZ32skEJvizh4CFiy1J3gTPsdKAYlgSpuol0BCsUtkUeg/9R1ucraySEOcSYjug
 PlPKm5k8JGVxpWKa99h0FiTnQy7BLn3MtQSae8kY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:virtio-ccw)
Subject: [PATCH v5 07/23] virtio-ccw: virtio_ccw_set_guest_notifier(): fix
 failure path
Date: Fri,  6 Feb 2026 12:52:41 +0300
Message-ID: <20260206095258.894504-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

We leak notifier initialization on that failure path. Let's
cleanup it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 6855e20d09..ba55bf4fe9 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1038,6 +1038,7 @@ static int virtio_ccw_set_guest_notifier(VirtioCcwDevice *dev, int n,
             if (r) {
                 virtio_queue_set_guest_notifier_fd_handler(vq, false,
                                                            with_irqfd);
+                event_notifier_cleanup(notifier);
                 return r;
             }
         }
-- 
2.52.0


