Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDEFC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woekI-0006Xm-Oj; Tue, 28 Jul 2026 06:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1woek6-0006EO-8Q; Tue, 28 Jul 2026 06:08:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1woek4-0002yl-5V; Tue, 28 Jul 2026 06:08:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id BA420C09A1;
 Tue, 28 Jul 2026 13:08:53 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:803e:400:f26c:359c:adc2:62a4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id f8aui7IXWGk0-hEMSNmwb; Tue, 28 Jul 2026 13:08:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785233333;
 bh=PfoLHGcOutgg0hQy+Phc11/k5TDb5rZJ1aU6PrMxzJE=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yXfUT8Rej7gAuIcmXlHTUgZ5+ijF0yv/P82PSzNWMj5uesDWNwFvc+6JA3Mv39/J+
 hjRuS9J2GnkOP/CBnHyHJqiz+ERftvnaGX2YFRHBblHGBkRIpsiFsU/QIFOg/pLzmQ
 +LQhsbwvqYDb5ppI24fBUkPtSEuL/EfKS0D8/akQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@lists.linux.dev,
 Kevin Wolf <kwolf@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v5 3/6] vhost-user: use skip_drain with
 GET_VRING_BASE_SKIP_DRAIN message
Date: Tue, 28 Jul 2026 15:08:38 +0500
Message-Id: <20260728100841.3475774-4-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wire up the skip_drain parameter introduced in the previous commit to
the new GET_VRING_BASE_SKIP_DRAIN message. When skip_drain is set,
send GET_VRING_BASE_SKIP_DRAIN instead of GET_VRING_BASE, instructing
the back-end to suspend in-flight I/O immediately.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c7f464d55..bd079f9080 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1518,7 +1518,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     if (!force) {
-        r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        if (!skip_drain) {
+            r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+        } else {
+            r = dev->vhost_ops->vhost_get_vring_base_skip_drain(dev, &state);
+        }
         if (r < 0) {
             VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
         }
-- 
2.34.1


