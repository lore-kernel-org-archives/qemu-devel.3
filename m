Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B5C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9i-0003Wc-GY; Fri, 11 Sep 2026 05:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9a-0003Fw-93
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9Y-0008Bn-M5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=DhZrPSz6Ivy5gdpPtGgHnC18+FdDPMAQ0MAiUzwX66xnfoEaSxmaBWHRH/srGTkg1xCyHi
 JBIiql/UFtkE9Wlno4yXBBoZAfu1IxF+Auf0AJsRnGLq49GMAHZ9Grl/ROFEr1EOwepVaH
 nuf4TZ7q8eZLMoWGnMEuvC+FIwNsax0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-fhzmbPuoPR-khXnIeHgMlg-1; Fri, 11 Sep 2026 05:02:32 -0400
X-MC-Unique: fhzmbPuoPR-khXnIeHgMlg-1
X-Mimecast-MFC-AGG-ID: fhzmbPuoPR-khXnIeHgMlg_1789117352
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so6426345e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117351; x=1789722151; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=DcPVKCkEiQw57Z/L/oflYPrcrk7ZqwSb/OElZqB2Usu4p0ie0f0zS4yeUtf/FEmXlV
 vSh4CAh9Q3ffXzNqGGYc0QHsTupW6DpEsdTYdXtM8Ae4gsrePRP64EksSHQC/YaNVQTe
 kHFZsP5eekgNvTG9tPLpOKOChsyVtgfox+00TwMvTILC9fmZafA7xWCtoA8XmkZGvjqb
 wS1ZsaB54CY1iEAcZdM7YbkXi0Bf1J5WJAqyjmQDgNe8Vz9ZEQgngfSXMd+9oyDGc8g6
 rOV/A6ZMVOoGRuL7f6QPdJqLdTnvHJgK8mmLe0Zr9zL3t02p33MxvrP3VMkhjhMSc414
 Smpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117351; x=1789722151;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QEbTpBGXkapN3DVQGc/Z0YGHeJnV/+deXbNBxtlR344=;
 b=jctRhng6tVMTbnecyfw/MazSmeyCIT2oZbmBtd1QFqju0JmYDmmSbA9r4QaQXLYvVn
 np+Wot/i6xK9NsW+3fDHIwUQIELBVPsRj2U/qdzI4y/E9imYofZdstrkrlA/eZbea2Cc
 Uu9ZfE8MZlXdwJ2BB44Gd5jlAL61ssT+1Tkqn9xBX8inlR42UZBgafxet2AuIceKdl2P
 +eAbVYS52TLrbBh3Ox4BUtIksD0yZqRhfNHXpVYSFilmfa2lxZobxiHleQrKJ/O9yajN
 037ZQUw/fQiyRqBUm6zCprYuL6CNcvUQ5+90968Dg0w8FCMGnVaOsNz2chQvMYTa02pm
 Z4wA==
X-Gm-Message-State: AFuF++m3NkBkTYidSYgD7pPUjRLW/ctPrZY7y+z06f87knRwagdWqAkB
 0tN55gLhNK9XfMlNI4PS2jnEIbBIofO6H16efysMNsh6iIW+dkujh91/VFtsW9mg5AL/5aNM7ut
 oy9HB6XpsExYtRzftpX7tErY+WheSwzgNvFCDSegH6njjxCyE6xg/X6mrAhH0V7H/VpukKgo8ob
 NqN6g3JIXm5dCJlVOnaB+A6It0qloH9ZpgwA==
X-Gm-Gg: AYBFou00g1YWc6tmtwL+mhVu5Ng5UyweWsvAJITIhYxLudbIoLNoYBFaS4yC3LYCaU5
 glVt1mXIw3f8CIRLXf47o/BBMFuCGRMPki6Iiz75Kbk0V8s8IUD/lLet7n2QmSIJMgonHnAdoZ0
 cOj2q4MdU7hQtd89W2BNcCzW/78860+QIabUpFfi1kYUoHH3FRBSYp1eUy4S9kefe0/jC3Yn6LZ
 PinK1vIpUzrkBkWmH+mhxwXwsGzB5wVw9b/X0DWtK3ClVEtwLxLK4W5VhpNl1zq7Tddt70fO1Iz
 1Vriye0GCDeh0WKrHCfgUpmXWP7jb8o19vpgs0lf8Tkk7VZApNOXOTsE9moUPlMSZbKe/4BOQhA
 rNWKPMhk5qeVyOs7NbBspvd4=
X-Received: by 2002:a05:600c:8411:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49e619f5049mr74971815e9.11.1789117351575; 
 Fri, 11 Sep 2026 02:02:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:49d:1e09:694a with SMTP id
 5b1f17b1804b1-49e619f5049mr74970365e9.11.1789117350824; 
 Fri, 11 Sep 2026 02:02:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a686sm40699275e9.1.2026.09.11.02.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:30 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 30/75] hw/net/virtio-net: check packet size before VLAN tag
 access in receive_filter()
Message-ID: <1d2dc18b298da9d1b615e7399b87a0619ac1a323.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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


