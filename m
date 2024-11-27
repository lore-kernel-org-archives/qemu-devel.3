Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD11D6ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYF-0003hR-Ak; Wed, 27 Nov 2024 08:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYC-0003gi-6j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYA-0007jA-Sm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xa+LddK6R1hQSg+kwz9wRZYAduyZ+dc2oJ7aKe9ONYs=;
 b=ahpj6Iwil/+lV644u44qy3T+abI+tsO1KPWeMzhQoMdb+35C0XhBvdw+12xlHLa4YV5NjE
 07Fm7qwHRkDPdvsDmLHce8VGQykSAnEHxZzSZAYMnGeXe9rYYsgIHv5QkhDxjE2QhYgkvo
 R00li03phxV5h+dSalrH3PxgzzlqtG0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-ToDpg7qSMLayc-eq0MK1nA-1; Wed, 27 Nov 2024 08:57:47 -0500
X-MC-Unique: ToDpg7qSMLayc-eq0MK1nA-1
X-Mimecast-MFC-AGG-ID: ToDpg7qSMLayc-eq0MK1nA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-382450d158fso3295855f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715866; x=1733320666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xa+LddK6R1hQSg+kwz9wRZYAduyZ+dc2oJ7aKe9ONYs=;
 b=eu7hMT6tyfsjb7U97WuJTqQRBU9QSlW+MiShlNQsxClWJQTrX0ybLYNw3Zity2RK4K
 wMtM93VybirDL01SIzoyr+2ASzsNsbT4RTfD7Al6/0C5/aN1T+YWq1+a27n0yd57U2dX
 2nbpYL8spAHd+7CUUMR97T18f6pW1onheghDj3F3bvX0/vNzc+QUFoTAvVKlZ50n2sJF
 R9THkGgdrdO+EsVTpSvJ//UgoQq/fHIowCzDujYz2qZuIyr5DN5nP//LV2OXybOhXbsO
 rYKoXhrO0SMHNePQxhRmspO37ejY910XXTrb2ALxHj5fOPYppCQXz1Rzst9834Lj58LF
 n3ag==
X-Gm-Message-State: AOJu0YwuEvkxAqNl5WoBYXMddRdIkBl9exQKaltl12rMLhpEk+LsInsv
 5RR41BzdlPPXskJCy9aL2DIjyFRZu3HbepFGgKGRu8rLIErGNoUjimusg//pSaadZIjXZl87zD1
 3WpRJ2dOP9DM3wIojkoSIDGEV/wR5Nno+9LE6QO+OtejoTZT7e6+raH8doJh/MG9xLqnPOjBKQS
 NuoaiG3ZilJoZ39jZmLaTQn5MNN1zjP1Vh
X-Gm-Gg: ASbGncu7VdWutwAQNHGf8DczTP0459yHJYAL5DyyZ1HhJerle2y8yR1JuYomg0Pv0FD
 xlSejo6Fy0jmcyOb5maMBK3nAnhELH7ih6zf/elHw+jzY+0pctDm479tB6+WQrPgFOIlh5e0yYU
 bxvxTiJKrvccBC3KTUAS1OnD+Q+lkauIqGX2BRMMkQVFtQDUEQbt+/tzDdr9kgdEIcXT+uSksPE
 9FnHSM2eWrJYa/HfA70Imo01+3f7Q+a0+0K3YoAhZ+L
X-Received: by 2002:a05:6000:1866:b0:382:4a98:da57 with SMTP id
 ffacd0b85a97d-385c6ed75afmr2839345f8f.47.1732715866266; 
 Wed, 27 Nov 2024 05:57:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2h/4bv3bZBmCd0Px+rc0BS1nvvkRJchOVpoYq9Dwa5vQQlIpT5VHSx4BSvHgIT7zP0j8z8w==
X-Received: by 2002:a05:6000:1866:b0:382:4a98:da57 with SMTP id
 ffacd0b85a97d-385c6ed75afmr2839325f8f.47.1732715865825; 
 Wed, 27 Nov 2024 05:57:45 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385c91f66c6sm944377f8f.72.2024.11.27.05.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:45 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 06/13] hw/cxl: Check for zero length features in
 cmd_features_set_feature()
Message-ID: <c5e36a5a6adbab7f6dc17d3bcb7b06660995cdc3.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Zero length data for features doesn't make any sense so exclude that case
early. This fixes the undefined behavior reported by coverity for a zero
length memcpy().

Resolves CID 1564900 and 1564901

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2d4d62c454..ce9aa18364 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1288,6 +1288,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     set_feat_info->data_offset = hdr->offset;
     bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
 
+    if (bytes_to_copy == 0) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
         if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
-- 
MST


