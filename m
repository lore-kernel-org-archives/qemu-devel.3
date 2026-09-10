Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE489C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nEv-0005yx-4F; Thu, 10 Sep 2026 18:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lL5-0002sL-Tk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKl-0000Hz-7t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=KX+WKR4RHZRPMN0aGiXmK5YHfdj3HNBvPxnT7gydNB+0F3b09vfwACDU282pXCvcEco9EQ
 KYrDT94GM+M1ltwhUMAM/DS8L6dWtaKCaeCSrDVV1qnOTkU0ldEgAnN50HM/nuQLO+Mzyl
 Svkqik7XWZn9NM424CJHHXGu0/fbreQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Gq03KTE9PLCd0p480LB_IQ-1; Thu, 10 Sep 2026 16:13:19 -0400
X-MC-Unique: Gq03KTE9PLCd0p480LB_IQ-1
X-Mimecast-MFC-AGG-ID: Gq03KTE9PLCd0p480LB_IQ_1789071198
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b7c1dc61eso981045e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071198; x=1789675998; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=F2Y6wmDBh70pxYT8g3A8+hwo5OrPOFQoOg1p4v8tbo6Nb37ZnNissi2M9GtB3OO7Dp
 1G274lqSX9ve6sE4RzE7Q5hrAdPWSxsUGkf3femOHlUafrukiFqlCvI6ShQTGSESkFtW
 BD7m0eGTanMCGhLpTjazfCgCemJ0UgmCAvDPpmcZ2P0pFjGjE9x8Lr+ARpU5GdFcnHxS
 oCqg/N38oaQvboxkGBmdTJpCZtVjHGL5s+tukmGPzA+CpVbMmrJlv6DxGZNoI75eJQhT
 8Agi5g7JR2MKa/vRAB7x5Bh/vJsxgHmLUd0tNS5S8eSvbQvSSIz4fjuskt8obbOjpYdt
 xW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071198; x=1789675998;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=BWhoGE8DPWnexQ4UkygkPDmA22aNthYrx21AOdCgXXmgp+/XzYf/WyMkjPEP7rBsbP
 AeZAntnGD15618BPh6dktiIxcKLTJU5HhBrETdfZtSW6Cm2V0J6wjCfVRAKD7jJ3Hh6B
 hiTYAhgNEMQatIYpfHbuJaot2qir3pjpXrcgUaj0sPpHLFlpjvUYHveQViVKBBqvoDCz
 CiqQYbVzmL3BlqbCUdRJMiEt3ziJQjQ+6DxPBd0/orVNqrPW7BNLfjIurR2FMj2srOze
 m225Q6Ks26cdODlB2tI0nkck9tJOgU2loACyw9MCCaRwJ9G4ul3NbRbNW+kEda2rXXdq
 4i3g==
X-Gm-Message-State: AFuF++m8AFYS5HvgCvbo1DRSgSTcEae7JmUSp7anbSm2MNwk+SUO54+X
 mKlNZ5zGBKDRldwadaIu8w6IQO5Tbhq8vAZd/hwKIbbRgGhc84dFs7AzZdUW5ANlJNeMaoVHANK
 ODA8n8YCOWO2Fgs7KXyIlgRQ/DZXSi7+KFNOiA/fxLNUahkamyr3ttvKqkGY3WWJyCsK+cY79KX
 xBw9PF/89xbKFHOJSbflyT1q+NDVxqPwpllQ==
X-Gm-Gg: AYBFou0dO4ErjcNAPbvoAVge22E/NHGxd2A+/M9J3V7iwartyAJ/zsUmxRnNAebHzlR
 EE/aiaBdH6r7YVacESNmCWXxcZJw3uhOF6RgXzSCkWnWTk62FE9L13iQzeSQam4XfBErHQqbzQ5
 u7FJSmlmgOHlzdDa3bvWdwd66ncI0GpKktT1FVUyuip6BWlgJXsCc+wdYLBtk4g7avWgtYx/7vA
 BI2//svMj7VakKyPVPdwDENyLsATYHLLGcoNTkpM/UT9sHDsQMA2ZS8TY3F50UMrfRWcG4xewYM
 Jr4Y7bjgqKWK2qU+GldPXeuKomckyAblwgSNSzksgnAjwkmCnJQYnViDuksckyJ4NHawf0Y2np7
 b+O1ivdXAG7SRiLhgYlptjWA=
X-Received: by 2002:a05:600d:4446:20b0:498:952:e276 with SMTP id
 5b1f17b1804b1-49e6198bd8dmr5980035e9.8.1789071198458; 
 Thu, 10 Sep 2026 13:13:18 -0700 (PDT)
X-Received: by 2002:a05:600d:4446:20b0:498:952:e276 with SMTP id
 5b1f17b1804b1-49e6198bd8dmr5979805e9.8.1789071198005; 
 Thu, 10 Sep 2026 13:13:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac4397sm19145115e9.7.2026.09.10.13.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:17 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 44/90] hw/net/virtio-net: check packet size before VLAN tag
 access in receive_filter()
Message-ID: <c60ea9e80eab1073d0bd7d573d8b4d7477740ff9.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

receive_filter() reads ptr[14..15] to extract the VLAN ID without
checking the packet is large enough. A short frame with VLAN TPID
at bytes 12-13 but no VLAN TCI causes a 2-byte out-of-bounds read.

Add size checks before accessing the Ethernet header and the VLAN
tag fields.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3788
Fixes: f21c0ed97c97 ("qemu:virtio-net: Add VLAN filtering (Alex Williamson)")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260722115008.1570510-1-lvivier@redhat.com>
---
 hw/net/virtio-net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 274fbcb0d6..f3f375e1b2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1751,12 +1751,16 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     }
 
     ptr += n->host_hdr_len;
+    size -= n->host_hdr_len;
+
+    if (size < sizeof(struct eth_header)) {
+        return 0;
+    }
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
         int vid;
 
-        /* Truncated vlan packet */
-        if (size < n->host_hdr_len + 16) {
+        if (size < 16) {
             return 0;
         }
         vid = lduw_be_p(ptr + 14) & 0xfff;
-- 
MST


