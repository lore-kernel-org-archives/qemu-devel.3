Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C397C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZcJ-0003e8-Eu; Wed, 24 Jul 2024 06:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWZcI-0003dN-3S
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWZcF-0006Ec-Sm
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721818380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pLTePfz4HJvxSdF46fdW11weCMDnwbKFIfKkTTrx1mA=;
 b=AwMEkQeWsTHXYK13O+LB+mQsD/bVceDpvT/G6uWPR6z1A/D5f0k5OhaRDEHmJcPIgqQlJe
 HDqWpRT3ODEoRmMm28c4eWQ//AZapi50tPpn5g+Qcl07sqDixEVgcGqFXckkhKd9wBIEFe
 9VBhVG/GHw4UNwpkPt4wEU1Vimy1AbI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-nHyxueAfM4i2mWqo8vrsYg-1; Wed, 24 Jul 2024 06:51:59 -0400
X-MC-Unique: nHyxueAfM4i2mWqo8vrsYg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-369bf135b49so368147f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721818318; x=1722423118;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLTePfz4HJvxSdF46fdW11weCMDnwbKFIfKkTTrx1mA=;
 b=MJZtp8CKQRdMWwxguw769otwPOptUyAbrF1zwKU5jEerVfdN/6vwsShpvCkVfxPKU5
 S0I3W0EZg3TaPoOrYu2fAhh5NfmNyitimczpMLpDa8MYjRWm1c5PFquiTW3fuhbzg5B2
 n5ZMJs+ZbluUc6wZjKj/aoQ+roTSJiaJ8cm6Fb3D/cBxq52mGZ18tFE3ezfB8vEl7XOm
 BQRu7aKt7+1pjKW2EnQLGKpW6pK6N2ALwyysZc/2zRW1kxCwlHcglfNX4JwQbQFfb6Xh
 dN7X/RZ/G3K/+wYSFQfk1mnNDJLRh0TikL6hgeFtoo/p8h3ge9blVCSoNWhsXig/o5aR
 JryQ==
X-Gm-Message-State: AOJu0Ywe0KjTYmMdx19z1Qcom9vwl5CjodaLwqWOYRIoTjldmkuLtmw9
 JOJBAfAs8CDPRDykkUZKnUAq+29F6C4Yb8wTd5sTXchd+3nE3eD85QUzSpXtPUkbmdmuMqn13ih
 5pPbigcmIvNjtC264dvGC5B5+AomH3NbmMjEckKFFaLLvIcYKsgtwqY/+oU2rlwPa8Aai6lhlru
 IqrdcHBjV59VkyaaGSpZ5YP3sNgLKqHw==
X-Received: by 2002:a5d:61d0:0:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-369f66ef862mr1340187f8f.24.1721818318106; 
 Wed, 24 Jul 2024 03:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD7P/HwfFxzDUtoBZpUQYjUty/ejo2FjjAqIqpn0MTDWLdJKQFWPu6XpwsFfaQAb5NfjZa0Q==
X-Received: by 2002:a5d:61d0:0:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-369f66ef862mr1340155f8f.24.1721818317468; 
 Wed, 24 Jul 2024 03:51:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:6083:a67a:e8a9:2855:2683])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced33sm14117330f8f.86.2024.07.24.03.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:51:56 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:51:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PATCH] virtio-rng: block max-bytes=0
Message-ID: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

with max-bytes set to 0, quota is 0 and so device does not work.
block this to avoid user confusion

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-rng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index f74efffef7..7cf31da071 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -184,8 +184,9 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 
     /* Workaround: Property parsing does not enforce unsigned integers,
      * So this is a hack to reject such numbers. */
-    if (vrng->conf.max_bytes > INT64_MAX) {
-        error_setg(errp, "'max-bytes' parameter must be non-negative, "
+    if (vrng->conf.max_bytes == 0 ||
+        vrng->conf.max_bytes > INT64_MAX) {
+        error_setg(errp, "'max-bytes' parameter must be positive, "
                    "and less than 2^63");
         return;
     }
-- 
MST


