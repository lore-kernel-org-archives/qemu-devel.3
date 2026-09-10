Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47831C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nRZ-0000xc-55; Thu, 10 Sep 2026 18:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lS8-0005It-6S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRl-0002Z2-7Y
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QfzBMW08YXqJdiZb7Qe3vTI1hQNhNiXNaPJ5pmcJCyY=;
 b=BZ6Xol4EpO05k48wA+7ZnICwjnFJiONLx6LDgn6xXg9jG4VTA+9nAF99D2FoIGiQ/AjtkO
 auVWDkwf3Ag/hXBXoHpQJYynptiLExZVp8wrQiuoG/FVQnfBJz+TWYna969vsDweVVn3M9
 NYEklIAJpPOHb99R1F4iSQthXDtZsNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ILrrqYEsMiWZXPA8OJzhLw-1; Thu, 10 Sep 2026 16:15:47 -0400
X-MC-Unique: ILrrqYEsMiWZXPA8OJzhLw-1
X-Mimecast-MFC-AGG-ID: ILrrqYEsMiWZXPA8OJzhLw_1789071347
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2245745e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071346; x=1789676146; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QfzBMW08YXqJdiZb7Qe3vTI1hQNhNiXNaPJ5pmcJCyY=;
 b=XGTkpMy0hW3P5tfm2uz5INLVc6C8MCk/6/IByNVeHYvrvvF6R0tMyCk6APZuZucwoM
 QrolNmxd+xfsgfSYZB2hyZsV09Cr71JQA40hGhMcL7RWt2PPX6OSFtbQbMtn/DMhZapk
 n4ejgOkr0GKQnhvpwoZ/TSs97Z1LnIBC6dXXQP9ifHXIOmRUkNeeLzr+DBjIFhQ7ZObK
 L9wCqWLtO81F4mxeX1Zht4m44Xt+WGr/t9t78NJp6BzpDqizei35NhSfAV+AeRc4CLn3
 8epKl+menRKAbX/Tq60HXuazhSPM3SBmC/IpjYmAdXVUL4w4UzJtZ/2tvCWyKIdr0CpR
 Ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071346; x=1789676146;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QfzBMW08YXqJdiZb7Qe3vTI1hQNhNiXNaPJ5pmcJCyY=;
 b=omfEVgCgodj1tQx3fMs4fbjMyUXdcPKeLjrzp/EyZe58LNoUbZtdB08oWnEzbXfBQ/
 3/WGEHousQ8EZ26PgsKhNe2IAlJ1CE1zL6M6q55NHMntcL8FqiXUPuf1+qru9uqJ/7YC
 c9oSnD/zMTfBIxoDqc1ZBaHK43svHO36bk0FLwyUJjGIp9jYbKbmVcaw2ccLapbzjM9G
 zJkCRxIBlWQkl0MRq6KF4wm3742t+5HEUqzWwkB0B4NaNPAhFV56/wnVdloJbypwqs6q
 PK2tmRVky0tdPecaSvbGlleb8+AufimqAYt5q+836BHnh/XJsnkJcnxffoiof0xGV1qq
 nS7A==
X-Gm-Message-State: AFuF++l3tvL+iB6ai62S5e7VCGWN8MqEpF18BaUjJeT3G36pzGi+aYId
 bJ6dgAoR45Mx+wLw0TE5WtuXxGkxqzwdo0Bn9+uam4OFkdWe6YTC1Qj/IxUr6/c2C2aso5bw0p9
 QTBPHR2RU/MXSQ8eGaXY+N58wrsjsTa6rndmfAJ8mD1uv3iEbwDAuOJa9tzc6ES/IGoi6Riz+KN
 y1lOBHYXarAQg/wk64eHGTE24w+X9xPp5WjQ==
X-Gm-Gg: AYBFou3QIQ3e3oztuwhGp1KWjo5cl1rtfAkc/ItMqo83YAzHh+HgnPWFq7V1T5EVdh8
 vQF+YiJ1D6siCThNsrpLToWeLvRDiE57cepmCLqdu6P/q4A2JZNAez/V0rATZwTGdL7fAM+JcYe
 fL4pWJsSlYz/zi4EmYIyQzggtrGYWn6qj6VckYii9J5Lq8a+8xSojXysc799YOQ0Q0e/a0C2ElH
 soELTNNPzk9d+BNy1st/zHtnIyS4xaZEBM+jvP+/+Yn5tWO4W4XN+HxSSL/GSFV6AUfoTlMoINq
 fbPYDVRiXt4wYqG96viOimUItRGm6FRv3HAcdBlfn7p37qhT9aJiuV5JgVrMOJ5A4QgKV/UJMZE
 eO2pH35RjoM6wUNRP/eMhQts=
X-Received: by 2002:a05:600c:3b90:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49e619b397emr13912845e9.4.1789071346499; 
 Thu, 10 Sep 2026 13:15:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49e619b397emr13911915e9.4.1789071345908; 
 Thu, 10 Sep 2026 13:15:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62230e72sm871435e9.4.2026.09.10.13.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:44 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 86/90] vhost-user: use skip_drain with
 GET_VRING_BASE_SKIP_DRAIN message
Message-ID: <7dd0f53d0b10c19ec83adf369801cc1104b1b56f.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Wire up the skip_drain parameter introduced in the previous commit to
the new GET_VRING_BASE_SKIP_DRAIN message. When skip_drain is set,
send GET_VRING_BASE_SKIP_DRAIN instead of GET_VRING_BASE, instructing
the back-end to suspend in-flight I/O immediately.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-4-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 27c78ffabf..68827dc731 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1531,7 +1531,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
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
MST


