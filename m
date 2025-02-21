Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB6C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5C-0000vW-Rp; Fri, 21 Feb 2025 07:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS55-0000YG-KO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS53-0007Dr-SI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAxtLkE7W+XUghJ5VIYoz6FDtNlGyyTqDgvbSHIaIzI=;
 b=iJaV0ctVFdMOGKrqRVZJqZZ9T6YKyktx25/cuRBN2fM7ZQBe9eSJyYMSCNbbeq1c1ZEgNA
 kE8im+tpvMcmGfGWa7FtTruL/He57IoedRd3ok1jMlktmcI4afLSZm6lRJ6UfvKglY9EyA
 PgNUDiGWx4c67yr8XEPQnEIUdiGYS30=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-7Jdp2p50OAKdEnAO2KLyww-1; Fri, 21 Feb 2025 07:24:32 -0500
X-MC-Unique: 7Jdp2p50OAKdEnAO2KLyww-1
X-Mimecast-MFC-AGG-ID: 7Jdp2p50OAKdEnAO2KLyww_1740140671
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f628ff78eso1073988f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140670; x=1740745470;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EAxtLkE7W+XUghJ5VIYoz6FDtNlGyyTqDgvbSHIaIzI=;
 b=P441zPucIYbRWZb97lq9HZnYdW1AtFsRFvu/2Na3Ggz+VHWHLKbi98TRhtgPbOazWY
 3eqizv5kjl0XS1QVqLDyPcll1QIcrfJ7ITiEnFIB80YOf+UHFkOJPUTINZE/LyZphuf2
 wPsRdzOWktuAZD4NidX28ctAduFXoYzVBC2g3zNjN0BYxA9GEPaCKY4r816/SkmoNWG/
 O+343F582MZaXLdAJ62v9HGsfcSInu7IM0DFNU9TKR99TrazlmhOO4d/+PtY+uxb2zZv
 4ekcWfwvKq2k4A9y5quOB0AnfS7gU4BTMKPrjlbeedZa8PHNlymO5xklLD4xsXTvjLEP
 Kjww==
X-Gm-Message-State: AOJu0YxDafJKURf/3xGWpTFHkYEtJ/gcGYmKzqNdpu1fUQqPYBenYTww
 3+JCk+ythjviWveyFbSYQ7h3jDRVsK69w8441gtPvWXnjAg50pBplxqY4DFJd26nv9XHOvh1aJj
 f5hK15sgEa4sJ8QkUIG6WsUdWMhFdrVJ2nquUiHDJDPvg96KCzm0p4DaENtrXIc0/aOPcV/A6ct
 lQcZ/YpNnAArGvPfHy5j5QjWUQOM8Qdg==
X-Gm-Gg: ASbGncv9WE6PAwPDR+RQhETIpj41gQfWRLN5H7QWjkELPxUIZYOiJKrepIAuI5yy2+M
 KdaRXqCzsjhdTZzlzFxIRl8g0Ya2QU0twrTU+Fr+kseXGROE9hjlPiaMvNA4VqkIME2zFlSyQeM
 ySqBBoPsvbitlrdEZHPIRb2O/QIJm2WuDYaq+2oGBj+yOPtVrqqXTF253yXnInC2qY5ymALEiWB
 R0676A0ieYmTaxYSXv130d1LOXNJINI9tsMPX/uUP5XRG7an5LFiT7Qswmj8EywUYVG6Gf0x4Ax
 Eq7xAg==
X-Received: by 2002:a05:6000:1f84:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38f6f3c50bbmr2137651f8f.3.1740140670404; 
 Fri, 21 Feb 2025 04:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHozMNEJXCK2el7msXK/RalCAw14qKq6Aw2YgNN1y/9vaE7HcjvC0xf0w6Rf4dvcuifEp+uUQ==
X-Received: by 2002:a05:6000:1f84:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38f6f3c50bbmr2137625f8f.3.1740140669998; 
 Fri, 21 Feb 2025 04:24:29 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccdesm23255646f8f.26.2025.02.21.04.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:29 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <graf@amazon.com>,
 Vikrant Garg <vikrant1garg@gmail.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/41] hw/virtio/virtio-nsm: Respond with correct length
Message-ID: <131fe64e63c88ec52c45a5946a478c0edeb31b78.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Alexander Graf <graf@amazon.com>

When we return a response packet from NSM, we need to indicate its
length according to the content of the response. Prior to this patch, we
returned the length of the source buffer, which may confuse guest code
that relies on the response size.

Fix it by returning the response payload size instead.

Fixes: bb154e3e0cc715 ("device/virtio-nsm: Support for Nitro Secure Module device")
Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Message-Id: <20250213114541.67515-1-graf@amazon.com>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Fixes: bb154e3e0cc715 (&quot;device/virtio-nsm: Support for Nitro Secure Module device&quot;)<br>
Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Vikrant Garg <vikrant1garg@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-nsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index 098e1aeac6..b22aa74e34 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     g_free(req.iov_base);
     g_free(res.iov_base);
     virtqueue_push(vq, out_elem, 0);
-    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
+    virtqueue_push(vq, in_elem, sz);
     virtio_notify(vdev, vq);
     return;
 
-- 
MST


