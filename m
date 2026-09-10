Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD38C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4npP-0007Ly-FI; Thu, 10 Sep 2026 19:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRn-000534-3n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRQ-0002Yu-RM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=VMGVn6OfVBPoBH2pLwzFBu8MDFWlN4swwmA1spStIBse5j0Xr15W92j09jOsLIIVGJQslL
 lxuHX3JQltqUjtr6/NENZHEe2PHNq0FBuCGHa1+9XLiRSuTZExyR1WeLzdeyUaNUsdzPjN
 +IxAeHo/2JWoZCgwsaEmP5TEva7kRxU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-WaxveBleNaOGDKve5pPHEQ-1; Thu, 10 Sep 2026 16:12:00 -0400
X-MC-Unique: WaxveBleNaOGDKve5pPHEQ-1
X-Mimecast-MFC-AGG-ID: WaxveBleNaOGDKve5pPHEQ_1789071119
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso67936f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071119; x=1789675919; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=BGNoGcX+JJusVyUBOkS7qOFwgaPOXm1VIWUGJJcOBlNFwC6wlPXNxQl+2y+HxZ2yd+
 NabjnwQqUnW8wQPp1Lv23577WQkZbAEwKR7KfdgMB4u4EzDldng0XtVJcUkSJrAQtg9W
 bMKCOcQ84jtQMxlyeOCcPglOlGztUaxd7bOQBaLN+SWpBl/f8VH7Z3K2RyLygPxlo96O
 D/ibOrAVG9E9scjIT+FuxL9oIbwRwj8XOdWeY+pnQTTTJzBre8cWO8ct4PX5KFTq4I15
 euOFB3OBspH2a3n6zirqchr7ClPsqROVIk7X9S/ueDltsSUyISI1dUnzQxskmv23e+65
 n37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071119; x=1789675919;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=c06KOeY1P+qlv2p6vH2KUleO7vOiLiFj+KI12IBNUzZ0iou8zICkcPe5PpdIjpNGYy
 9kUqbgejCSUtBW2ayT6JyyrTGgE9UW+7YqPA2mlksp2oIs0B5LJn27gicXE28TlcnbuC
 YQvMozEutKfn2ZuLHflLVz95zM/cZRgpXtlgo5OG2PqgoNZC6wqaIzF2UFFcKRTdKi1C
 enHuy99ePiKM2ZfWk4l7rMtwpAtVPGkfFCth/t9XPoFDTOK5U6119lH3HsT/8rJBsMme
 0SK9NVaxC6QbdER1AKBmpAGu1XrbrkLIfNwRWrZU2uA8ac3CjhICdeKaTi/HtpEio6aT
 UEvQ==
X-Gm-Message-State: AFuF++nhh0hF9W35cTHahh/VxJHmlx13SCwD8lT3mbTCdwPJu//qeyrv
 gLIbjFQEZf+QjbBKLVQvERM5Bh7m8SKj7ZO7CEenC/1uPJMGNpedZv6XDgiqf0oKK1JvzUi7LTB
 WNjIpJshFPh/QgcqOHX7zF5nDGpLILRBSKxWbYsUTr2ifSjIxcAzZ0sh1d4D44RKz8g+lOBd/BW
 ft2XCP/zj9ddUafopI6p3Sc+bCni/bd3WtvQ==
X-Gm-Gg: AYBFou0uBIg9dJWFHRxL1BOoK73JXxltVKXVx0fKa4aGXeHnDv0UccArwybQrLOmZec
 XPusC+1YXDjc+Fj7fQnjL/P/MvhacfLAJikkFyeAycjZyWZTpRjsBzQAMU4KrA0YoUUIUTiGNR2
 s1MhGClLuI6OOPZhxjpILrLnNpUFLiKzpqMN3WcNV6ADA+j+gchxiEBIYQu5Do6HXSeKVIcPTmG
 KTfTK1knNYv43z1Qnj4SvIsh9CwfwhpA++JzNTxgJvhlrmGqUaTKe/7kQlHv1cTRpOFOVirGUg/
 hwVk1geWCl8dAQKxcF2RWjrXHxuKXPIju9YCMGV3gxVAIzuuHdP1y3TMx/wHhn2etq2gf/tABmr
 9jGZRAZTCVqfdoqxH61nCUlU=
X-Received: by 2002:a05:6000:454f:b0:485:acfd:4fa2 with SMTP id
 ffacd0b85a97d-486eb35833cmr716690f8f.28.1789071118647; 
 Thu, 10 Sep 2026 13:11:58 -0700 (PDT)
X-Received: by 2002:a05:6000:454f:b0:485:acfd:4fa2 with SMTP id
 ffacd0b85a97d-486eb35833cmr716646f8f.28.1789071118138; 
 Thu, 10 Sep 2026 13:11:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm731796f8f.16.2026.09.10.13.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/90] linux-headers: add VIRTIO_ID_MEDIA
Message-ID: <f36fae9f20444fd09da5d7aa4127157a9a92ee1e.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Albert Esteve <aesteve@redhat.com>

The ID was added in Linux commit 2187be212179 ("virtio: Add ID for
virtio media") and is included in v7.3-rc1.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Dorinda Bassey <dbassey@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260901-virtio-media-v2-1-bd3cc9347ab9@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6c12db16fa..f9056af0c6 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs
-- 
MST


