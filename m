Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE4CC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDQ-0005Zn-IA; Tue, 23 Jul 2024 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDO-0005Av-LW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDM-0001vZ-Ts
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbreE3gRMg3HkdLWMl2uNhF2Or3FkZXwY0kwp8ati68=;
 b=Yn8e5JB+gwUr0KeGSgGtOmL7c6Ee+mmuq6tEjByEkeNltqV8V1FLb+EAIPVTAtDJDJlKNy
 L6vHoO0Msu+q+J7MFRy4XDrSfHEvvwt/+dnjAZ6EkQMyNaIG36YT8jDy2+4+eRXpmBstwe
 Z2LsxdpSXAFHqaFoyQZsK8sMqhko2sY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MiOI5KRUMjynlv24USLzSg-1; Tue, 23 Jul 2024 06:57:49 -0400
X-MC-Unique: MiOI5KRUMjynlv24USLzSg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a8b0832defso2166585a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732267; x=1722337067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbreE3gRMg3HkdLWMl2uNhF2Or3FkZXwY0kwp8ati68=;
 b=fJfSmAj6deUpNEoqgTDJXYqgb1Qi7lXHVJB+sYWQaGtlCpPAbwl4yrpf17G1O8wWWn
 cFGUCXYSuhigy0YymaFFOZCyRefOU12ENDxtQZWNd4AkO99rUPlBn/fcHVD7+RZsBWFw
 BKI9Wl75NLE3NxUJg7M11xRqqokDD3MwhXTuJu2LW93xBJrpoj37dGJZGdxhqKwPSz+V
 p7nw5vAR1dhqUEoGnKXDFrPdzqXKaAgao30Gy7HnWvGc57lVAojeWv3xRNgYyko/TJLN
 i6sjOHKOLjmfNB7oo4oIy41BEAGtXFeVVIGllTWEFooduDJpTepnQKCCl5qBRvxSqOF9
 A2CQ==
X-Gm-Message-State: AOJu0Yxvyd777twFTisTmwdL1tzIGqmPG5ZBc7ve6dJIHV44QRHtpfQJ
 1BukfDNx6TW/Nu5VHuvIsl0XuxsdbrQxDP687VSPL2/dCnfAVFfUaV+Kah5i+TvNHCtEzuOdbvG
 JGcD+glLh+gTwi1bHvhOkAFj/X+DeOkj15LGSQKiBU6M/hAuIDp5VmzxsH832mlnsxRkUoAgvXP
 VVQ/7d5Vf/NzE1YULYkA48/DzA73u/0g==
X-Received: by 2002:a50:d50c:0:b0:58b:bb69:763e with SMTP id
 4fb4d7f45d1cf-5a99d304448mr1515377a12.7.1721732267424; 
 Tue, 23 Jul 2024 03:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJIVWtaTeKjKde7N0jPWl801Uf70p4/47YecoBtFV9nT8OnXhRCx2uTQnzF/qPUbt7JxLiIg==
X-Received: by 2002:a50:d50c:0:b0:58b:bb69:763e with SMTP id
 4fb4d7f45d1cf-5a99d304448mr1515356a12.7.1721732266873; 
 Tue, 23 Jul 2024 03:57:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30a4d6bf8sm7339533a12.18.2024.07.23.03.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:46 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, changpeng.liu@intel.com,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PULL v2 28/61] contrib/vhost-user-blk: fix overflowing expression
Message-ID: <99d7c1b99a3fdb69213c09da6b7614243f877bee.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

Coverity reported:

  >>>     CID 1549454:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
  >>>     Potentially overflowing expression
          "le32_to_cpu(desc->num_sectors) << 9" with type "uint32_t"
          (32 bits, unsigned) is evaluated using 32-bit arithmetic, and
          then used in a context that expects an expression of type
          "uint64_t" (64 bits, unsigned).
  199                               le32_to_cpu(desc->num_sectors) << 9 };

Coverity noticed this issue after commit ab04420c3 ("contrib/vhost-user-*:
use QEMU bswap helper functions"), but it was pre-existing and introduced
from the beginning by commit caa1ee4313 ("vhost-user-blk: add
discard/write zeroes features support").

Explicitly cast the 32-bit value before the shift to fix this issue.

Fixes: Coverity CID 1549454
Fixes: 5ab04420c3 ("contrib/vhost-user-*: use QEMU bswap helper functions")
Fixes: caa1ee4313 ("vhost-user-blk: add discard/write zeroes features support")
Cc: changpeng.liu@intel.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240712153857.207440-1-sgarzare@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 9492146855..6cc18a1c04 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -196,7 +196,7 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
     VubDev *vdev_blk = req->vdev_blk;
     desc = buf;
     uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
-                          le32_to_cpu(desc->num_sectors) << 9 };
+                          (uint64_t)le32_to_cpu(desc->num_sectors) << 9 };
     if (type == VIRTIO_BLK_T_DISCARD) {
         if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
             g_free(buf);
-- 
MST


