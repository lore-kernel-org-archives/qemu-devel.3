Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF92C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4P-0006Is-8P; Fri, 21 Feb 2025 07:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4J-0005ud-R2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4G-00076a-2J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmV9gn8eSSrkunnR1tfz+dt6M43eXodM12I1RMZXJ08=;
 b=VeCcMGUdiZJfh4pWADDbE+huoe15BxkQs3CGzhd8mE6f+AOVl8DoNKmASHwlbAS2LVtsnk
 VNft9rCCXEkFQ5szPAH19mZP9HAwmfAnUb/wk/cCb7Bnva28cTNCPdIDPHg/rL1am28WJ0
 9JknAgFDPq5jLJiH3PUhmWNYFul30Bk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-NkHcyx8dPXep6i9G9M482A-1; Fri, 21 Feb 2025 07:23:42 -0500
X-MC-Unique: NkHcyx8dPXep6i9G9M482A-1
X-Mimecast-MFC-AGG-ID: NkHcyx8dPXep6i9G9M482A_1740140621
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43995bff469so22357015e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140621; x=1740745421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmV9gn8eSSrkunnR1tfz+dt6M43eXodM12I1RMZXJ08=;
 b=ZU3UTSEydbN36/oLZJ/GiweaEjTEX5W+ADw08BpNm3meLwMicgwY2gcLWebE9cBf8D
 XVgGL0d1hjW9zW6DNYj3drvHHRzcm8WV0sJetu3o4SFHBNHqg8YiUq0nFirCozCNnqxz
 WZzSVZlMRvVRViz4tGoyKJ2QsAV1jPkqd6tjJQ6Jt6SPHtywSy6vbS95yOxST/H9F0vu
 lNJFgtjAMHI9d78cZXzhXJye8DLzhri4MbmUqNoNjEHTqA6c5/KU05/kkrEG/jYzCenP
 Mi8AKSGqSdgBm66uxLG1wfS4+mILkwWN2qbJzI/jfbaNBlTXCiiV0kAHIJqwTvye54ef
 yfUg==
X-Gm-Message-State: AOJu0YxJwbmVT7I5VTOBc1ySnrX/UEXaLWm5xUZC1XQMCrHA6WZpQdnQ
 Zj0HEmenYO3f+0nBR3Es6PTXnDxXXnccxOuXUYcGIEiTkDAsVLfDnw1NJzjsGHCT333rWAYC+zI
 b4ZkveBHMSvOGoIjxi3lFQzn1Dg1Uwxnlm1towcDGxgGemt2hsFjUXemKpRhSWs1oT2ZpzV0ID7
 srVRMuEj/HsFJ6sj6+S9OSLsftRiXcPw==
X-Gm-Gg: ASbGncuFddbd0lhspw5QSvafZ2cGBVfQXRUQc7zV5b/lXuYrGtNFuQhip6q/+o/KvLm
 6BjYutxsYkq+X7/Qzej/p3hopxZq2JVPI51ETrQCYGzkqLpEDejDTtJFpMASFZd5CiHiI+0nIgk
 HNAtsAm1FZLpJYEecJim08o8fpvDZGzhKWlK05Cf1nsGgiMtsI6PP/j/Crt1Fj0Fb3/1PvVLyTB
 WUtbUUz+neS1u7N0jo3PnHfMjSfMxN+JKCzeYYhq84rFRgfjwcdCJW1oUsVxRo8jBAqayB8ektG
 6zZwqw==
X-Received: by 2002:a05:600c:3149:b0:439:969e:d80f with SMTP id
 5b1f17b1804b1-439aebe6b9bmr22320015e9.31.1740140620794; 
 Fri, 21 Feb 2025 04:23:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECyBszWZ+AKTWGIva+rALczMJpq1e0vnMnV+nYXnKg6amFBca/x+CsyF1OZcMfkdhkG1aLKg==
X-Received: by 2002:a05:600c:3149:b0:439:969e:d80f with SMTP id
 5b1f17b1804b1-439aebe6b9bmr22319755e9.31.1740140620405; 
 Fri, 21 Feb 2025 04:23:40 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d624bsm15703225e9.15.2025.02.21.04.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:39 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/41] tests/qtest/vhost-user-test: Use modern virtio for
 vhost-user tests
Message-ID: <14998e50c3638b07946ebe5972a327cc26e9f03c.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

All other vhost-user tests here use modern virtio, too, so let's
adjust the vhost-user-net test accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250203124346.169607-1-thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 76d142a158..bd977ef28d 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -1043,7 +1043,8 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
 
 static uint64_t vu_net_get_features(TestServer *s)
 {
-    uint64_t features = 0x1ULL << VHOST_F_LOG_ALL |
+    uint64_t features = 0x1ULL << VIRTIO_F_VERSION_1 |
+        0x1ULL << VHOST_F_LOG_ALL |
         0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
 
     if (s->queues > 1) {
-- 
MST


