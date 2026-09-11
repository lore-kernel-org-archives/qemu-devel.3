Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEFDC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBB-0007FI-Rg; Fri, 11 Sep 2026 05:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAa-0004Rv-OW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAY-0008KM-0R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=CFmUpsyaVPbxJ0X61Adj7Dhi1hmZKoK4q7AhqT9geuCZdZlQVYRV8cYR5/+fqkQdpMs4eq
 9oCa0+yYpWze8jPFYs4RMwwgeLM+cgZPcN8nXrliHI/1KDQyQxXri5o1J0/hfmk80dYHGK
 UPOq0Og9ZaJKoru2LLBMk+ZoX9M9gFM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-BR0E4Gc2McikE-FvPTbd-A-1; Fri, 11 Sep 2026 05:03:34 -0400
X-MC-Unique: BR0E4Gc2McikE-FvPTbd-A-1
X-Mimecast-MFC-AGG-ID: BR0E4Gc2McikE-FvPTbd-A_1789117413
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4957287363bso4194705e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117413; x=1789722213; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=Gd90zTjZeraaRfo142wnKLtDe9XWh9txkV1iAiQNNKXeRlaqcPjw7gVgX02cT7CUzr
 9ahaX1t19ooAJpWT0KAx648bDEKXt0RL2A2S2ZFpq7BcxV3rQ8dUNyeeecEMaYFIrzZa
 8IAX2NvKHLaYWvMU8V/vD3L3R/6BQ0fA02RMIaKTh1yasjx9764f/+CsLpGtb51Gplwq
 5VFVEfOPRgjsf8ora1KrDkVSWtgzltrRA87nNr9+Enf9ipliN2pyr8Sy23vDu8alawol
 oMOwjWmM+WDObMHMqfdx6WO4SwA/vnnBp0wGgUuQgLy3BmT83S+SKxRgv57MEb23mrpB
 WYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117413; x=1789722213;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=13Q36j0M5BaF1k6VkvQm4baQtJfJHEebKt7N8YZcxpU=;
 b=V3NofjEa9DccQ6wF/kKqbqFGTlv5+u0f7smawIOYH0zINZWXmkJGZE15FEhZWqdDTu
 WYuDrXfGofQ9GbaOdeJeoT5NvbLdxHD2QGL71Ic+rLNopP6HcWz2f9kFdp/okzcKFFS9
 UGgx8Jw8R7oWjihsdy+Tm28bXTajnNqvC7CY36TS1zSGgCwiDPNTZwsWosubbL4Y+4gc
 pWWxCSPELDhIYWEW9AKBOrA4UolSbLix/1BDxAXGPfQQ0qiNC/5s1ec5faHXjAbzThpC
 RMYp/xPB4SExXS0XNxY3aT795KoTIpAyMQQ7PTjRmJcE8zXJGtwVd42NW8WG3HH2nnO7
 1Y0w==
X-Gm-Message-State: AFuF++nr+bZ/ZAvI6OsgW4lUJ5JaqiSlCyFt7JCx01Ozy6fy6+sXsnwd
 lFkptMgLodR5EP7V9uq1AUv9/2Mn0DkW5LaPkThm5p4OrQodZir4ErdAmct5wpbpy8w0KgM5hMX
 rfDhO9SwF/gf8sECjP8gECmnD13+iTQFbs36SN5dM5w9op5aBtiUjUuEfb3MODjJHPFRtRi03Ju
 1HTjhonjsLXIsImtUZRqsGYTTOQlhQ6tOO2A==
X-Gm-Gg: AYBFou0RlWmJccLcmzJvR/A7+DNt2tzH1Ui68i2qjeqlJlS/wGgDCHOPtsEsIS+hBFE
 TrGehlmsjYNlEV211s2Z24t7hzsNILAmM/3jjJAxe6JbKRAEMY0Y32HMvNr7KfN4mIN+NE+gQm+
 ORsaR/Rn2i7C9s1bTlF3rrYoy83MoIFv+/MTUn6PO4YRAeK0QWcFdc4yunDrMiYGmBMwBJVtzPo
 oqdWr5dRbGwM+K8glfF+pkLCElD0dw2gV4qs7qHHrEyGzauUZibNXbX1qsRxctmLI+9XPhIYZ4h
 jVa3DJc/smUBBujbjODllkWPqyR4fo2HZ2DBR2hSHWsZvInK2xT8H63fuwG/YoFKf4oYDdQKNjv
 QPWwKZHUtTtZrUoDe83vJJLc=
X-Received: by 2002:a05:600c:4e46:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-49e6683d4f6mr7158185e9.0.1789117413085; 
 Fri, 11 Sep 2026 02:03:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-49e6683d4f6mr7157155e9.0.1789117412431; 
 Fri, 11 Sep 2026 02:03:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm4249179f8f.34.2026.09.11.02.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:31 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PULL v2 56/75] virtio-rtc: Report smeared UTC clock type
Message-ID: <da02438b4f448bd99fa87b126259168fb4d74aa5.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The Linux virtio_rtc driver only registers an RTC class device when the
clock type is VIRTIO_RTC_CLOCK_UTC_SMEARED to avoid leap second steps on
pure UTC clocks.

Report VIRTIO_RTC_CLOCK_UTC_SMEARED in clock capabilities so the guest
can expose the device as an RTC device.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831190612.369235-1-visitorckw@gmail.com>
---
 hw/virtio/virtio-rtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
index 32de9c1650..0dcbe94758 100644
--- a/hw/virtio/virtio-rtc.c
+++ b/hw/virtio/virtio-rtc.c
@@ -62,7 +62,8 @@ static void virtio_rtc_handle_request(VirtIODevice *vdev, VirtQueue *vq)
                 resp.head.status = VIRTIO_RTC_S_ENODEV;
             } else {
                 resp.head.status = VIRTIO_RTC_S_OK;
-                resp.type = VIRTIO_RTC_CLOCK_UTC;
+                resp.type = VIRTIO_RTC_CLOCK_UTC_SMEARED;
+                resp.leap_second_smearing = VIRTIO_RTC_SMEAR_UNSPECIFIED;
             }
             written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
                                    sizeof(resp));
-- 
MST


