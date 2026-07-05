Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D60C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwX-0005am-C7; Sun, 05 Jul 2026 10:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwV-0005aH-LW
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwU-0001Px-7A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYG7Cd5XYlUgzARXK0+epA8MtHOy9/+okNge9QNu4BQ=;
 b=OE39CKJgxboboXxbRlR8DFFDcmb2JPFBmcvJXEywpzVp2DDUvKrwgLl1Tpm+nSHqDr/vXe
 pEIZsSe0uu5ICpWpIZSt4YxWr8dJdcmxzOl8l8QTSqps2qu7CLVXB8i0Q/93xUu983Eza6
 0hXDg7OX0CAlsqud4kdupm9etN1VYP8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-TsRf1ZpHPQOkYp3xYSPYLw-1; Sun, 05 Jul 2026 10:35:30 -0400
X-MC-Unique: TsRf1ZpHPQOkYp3xYSPYLw-1
X-Mimecast-MFC-AGG-ID: TsRf1ZpHPQOkYp3xYSPYLw_1783262129
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so1699112f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262129; x=1783866929; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bYG7Cd5XYlUgzARXK0+epA8MtHOy9/+okNge9QNu4BQ=;
 b=ZJGWBhA5P3Lo/lXOSSEnn8jbqLEUBLPbZTSWrkwlff6r78vwDefN8Z85G3qC+Js8yn
 3phJGqnwaUvuywnk/rJUflz96TNc5KcZgmWWXAJ43fiuVUs91cq8/yQuEvpBhke2eW7c
 ekYufczuR5lCf7TRWRQXks7gHcEXTofiD+wM4lhCnMmHQbl45qZBulcIq0Lq9vNk/NF0
 jwiD4DfHG75iCBcejpEZvX0C67pI+He3D2onybHD9Xvj69tWdfW6mEIaqEaPbM82JEBa
 Zyc/luCxCYcxMFaRC1hVgFNycQTmSv+8iK7PMUIOpQx0LhF8qklvxwILuRpjkHo8Hv6d
 vi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262129; x=1783866929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYG7Cd5XYlUgzARXK0+epA8MtHOy9/+okNge9QNu4BQ=;
 b=sZQjU6SSrYlzayul/NP97hd+STiuPAv8ikqyxAl9eyJjyJX4M9O0+gEQ3HudHQ1zpT
 I0yUN7GVjCa98WSIC4MAuIATZ2A/cSsFtowI+it19+UWHlkC1wZ+oBgR6QXRNvdKCbU9
 0SC7P+vrC/RMzwOooCQJHc43+E06Wcf8EUz/4hsjSG/Ynh2pU/tNX5GOqFgAmPC8EOaD
 SzCmTfBm+PKNb7FdFzOoeBpjP/TEXNNtQ8ZRdTNOeXRJIwZ9VM0maTdbXkWIzyLKeC4m
 7sd8qfiD8kIf5ITJJMI8q1C/Zdb38woY2wtWHnMS0DTOkL1CySXCQW1I99XrhCM7Oi71
 UwFw==
X-Gm-Message-State: AOJu0YxCXL/u4w6s2jE9vyWPnnw274Isuw+lzFpwj3UBkr9y8z4+EURO
 AaCu6Lq+O8slApGrXq48VMQwyeCnpAmCCYU59xu4Tg8zgoPPPvT3exGAhs1W1sK6GKyNIB5byZH
 OLjExANJONwpprcVGShQLVEI/jWJLEqWWKS8e8uQ9NxSQcOhzNHMn2215XJBvsvc7YmfNRF2DtS
 YmFzP4CeSAlQAiSnlzpvs7ZfIvDSd7nz+Z3A==
X-Gm-Gg: AfdE7ck5mqirhyP0u4d0xUJ9ztukjHN+UESY37qdsmp67YbZlYJYjKnHBsmKFnFIDY7
 Ge9PyURszTBRcrEQx2aV4ViGk+0LhlfWrm96Hl16kP3if/p1StTpCJ1MasmsR4z2WvJyW0uk39+
 mUz3oCiARrzTz5POGzuJq104EM33SByDwJHodUHIW4YwY5WoU5b3auu361hzXoY3Ulssq+WGVFG
 /V9OTsg7vNdNJ1soYASaioGCXhKB0sE8GWSfMEmP7gtOreLoRKWdG0cSeIr/g+BLS5+Jog3mZI5
 /w/uejih/zXdzRS0umWVOKrTAVTEZi7xCMEGarQc7/zRJda61c/WWxzboW3D+Z8EiA5zb+LWwM8
 vBR/24yO7Lw9O1vdiMHOAnDV8X954jd4V
X-Received: by 2002:a05:6000:2086:b0:43d:dd:8ca4 with SMTP id
 ffacd0b85a97d-47aaa60d40bmr7638431f8f.14.1783262128786; 
 Sun, 05 Jul 2026 07:35:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2086:b0:43d:dd:8ca4 with SMTP id
 ffacd0b85a97d-47aaa60d40bmr7638408f8f.14.1783262128212; 
 Sun, 05 Jul 2026 07:35:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm16949135f8f.9.2026.07.05.07.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:27 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 19/44] vhost-user: inject kick after SET_VRING_KICK
Message-ID: <ef02c6becfb1383bb50f7cf724f77a9bccf17bdd.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The vhost-user specification was updated to say that front-ends should
inject a kick after SET_VRING_KICK in case the back-end implements the
old spec wording which said vrings start when a kick is received. Do
this in QEMU's front-end.

An example scenario where this behavior helps: the back-end fails to
check if the vring has available buffers when SET_VRING_KICK is received
and the front-end stopped and then restarted the vring. In the case the
back-end may not notice the available buffers unless the front-end
injects a kick.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260604201029.250450-4-stefanha@redhat.com>
---
 hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d627351f45..517cc4ca71 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1487,7 +1487,29 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
 static int vhost_user_set_vring_kick(struct vhost_dev *dev,
                                      struct vhost_vring_file *file)
 {
-    return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
+    int ret = vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, file);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Inject a kick in case the back-end only starts vring processing upon
+     * receiving a kick. The spec suggests this to improve compatibility.
+     */
+    if (file->fd != -1) {
+        uint64_t val = 1;
+        ssize_t nwritten;
+
+        do {
+            nwritten = write(file->fd, &val, sizeof(val));
+        } while (nwritten < 0 && errno == EINTR);
+
+        if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
+            return -errno;
+        }
+    }
+
+    return 0;
 }
 
 static int vhost_user_set_vring_call(struct vhost_dev *dev,
-- 
MST


