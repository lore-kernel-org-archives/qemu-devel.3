Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B1CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCE-00069q-Hh; Sun, 14 Jun 2026 15:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC2-00061Z-1e
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC0-0002Am-Jq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfJdqs5MKd0CqLIkn3rh1rMCUwFP6s1/sPPGLqw8n/M=;
 b=CsIxeMuFzrM4Rq7vDlHXGe9moMU9A72blX5SZfr6OVtjhFp865i5H4biPFKJtLeGUfswsW
 udvGVeIu18y91z+UF5DZcZlrLYhdj1fESG4nvTeq9VABLAKy2Nmw1ko2hIYho+bC9Z+MZp
 2cdkkBJ9bPRx1/3W30tjOEfjEMwKH34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Tu80dsN-M_-6kWGKSbK-Gg-1; Sun, 14 Jun 2026 15:08:19 -0400
X-MC-Unique: Tu80dsN-M_-6kWGKSbK-Gg-1
X-Mimecast-MFC-AGG-ID: Tu80dsN-M_-6kWGKSbK-Gg_1781464098
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ae461f8dso19277665e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464098; x=1782068898; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JfJdqs5MKd0CqLIkn3rh1rMCUwFP6s1/sPPGLqw8n/M=;
 b=hSAnX5nkkFNeS3Q9R61jwbT/ola9P5M4XGq7pKadMsTAKntPdkigvACysbMd4rC9Uk
 tLKYaDJ8uP760IW4lI6dZ0Ejvxcts9F2Fp4rpv01HkFQEm6OSjG+bYnGmqqodKYRHIPu
 Xqc61K/DTJw/OVRheqC4DruuXHC+RTQeTWbOYhtrhn2zCrDMQ7tUptzwZP77umJoIc1y
 t/3ctQp5VBD5wuJc1VnH0AuHsNA4ZkOkXYuyZkz9VUHBhP8qI9U5MneIqfLhC2yIc8pt
 Tuo63LCBHBfugTts2SCiDjc7fzSyxAUa+qn6KS9jeXk/wzVb68J6V1irOYl7FeIM6KyP
 gdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464098; x=1782068898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfJdqs5MKd0CqLIkn3rh1rMCUwFP6s1/sPPGLqw8n/M=;
 b=Zq+tZVCdeLmT2VyLEJ5T3XPreLSrUX9+pAl4P4GD4yxYt2XOxGYWhD59Z4qmbH7RUU
 Edc/2YiBZYrUVBZw32KIRZPlzyNh9vmuB9cTmH4yOM0QhwpqtSs9tRkQeRik2Km1r8du
 0GSQgBciUgOz5pk3iS9RxZ54WytPmVBsx886sNAEGGTFni4Z1fJvV0W03q0gNr+ZcEQ1
 SjtmbhrCuHAO2+7m6qm+Q8io9vMWbicq6GRPGQ4aCD5c8EZEhUj/xZFKmr7XQOo0ZcUR
 oKSvcj6GQ2VA5tVaigtL0iBkZW+2xqIX4f3Itlck8yjoFus/1QJL+Q3ICHdLgWi2AIzr
 3o4g==
X-Gm-Message-State: AOJu0Yzd+Zw73QtqX6PDV8yYhwg0HrYkS3IcCgwS//Q25eje8rpWrwcm
 gREG5hzd6uh3ig5iG72t0k/RdvmeisC0GRXYpRI0U8EUgtXZRTBGBQinV/9UWyZKTUQRwEvR55j
 ur+EbOSOQm8LZhpm2vIjpCZN9Z+S/EqVDfU/Wo72xCWfTV5aQJcpTFIYNGb+yoC1xizVzcKVlrV
 tdxztbxbUV1GaiD/W70DuN/95b4MrWSYdyaA==
X-Gm-Gg: Acq92OGV6kpdAZ07Zl5tTbXlJ03h1AJ9xnGQitSugnVVJW5yd7KYOO/nWrB0g+DVCHt
 J4CtCpuEYtxjCrczaDw1ULSm64k9F7pSt4JqxAQKfbYxJqDK8i7cODYHeohsmgef8Gj2Xp0QxPo
 MJFCppTIoLOh7qr7pSjhe9RjqweRCBOx3+Zw/sRNvneb7kK2AXXdWELAHCnufg+XGv5AdlEAjlS
 Tcl/LfsAvib/5PFy9Nnz0ra1O246sVbZDegaY9vAGvxjljuowu2nAf8Efj15Y0+bOOmPCASmQrF
 P022vr8DFqpWVO/urtiBngS2cWZ2GAZ3gIM+Tk+Vfup30Y69tNu7Td7k+fKqD/wEMKzvJErWzs5
 +ggh4Jg1sPHC1nZzBJ4ti/ANSAGiF3qNHN1ghfqMbmec=
X-Received: by 2002:a05:600c:c04d:b0:492:1eed:3e67 with SMTP id
 5b1f17b1804b1-492201439a1mr58945125e9.26.1781464098296; 
 Sun, 14 Jun 2026 12:08:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c04d:b0:492:1eed:3e67 with SMTP id
 5b1f17b1804b1-492201439a1mr58944875e9.26.1781464097717; 
 Sun, 14 Jun 2026 12:08:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5d6csm196030455e9.3.2026.06.14.12.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:17 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 DARKNAVY <vr@darknavy.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: [PULL 059/106] libvhost-user: fix buffer overflow in
 virtqueue_read_indirect_desc()
Message-ID: <85805ee887be4adddb1f1a34f526968adc95e582.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Stefano Garzarella <sgarzare@redhat.com>

virtqueue_read_indirect_desc() copies an indirect descriptor table
into a buffer in chunks when the table crosses a memory region
boundary. The destination is a struct vring_desc pointer but is
advanced by a byte count, so each increment moves the pointer by
read_len elements instead of read_len bytes, writing beyond the
buffer.

Use a char pointer for the destination so that the arithmetic
advances correctly.

While at it, change the source from a struct vring_desc pointer
to a void pointer: when the table is split across regions,
vu_gpa_to_va() can return a pointer into the middle of a descriptor,
so casting it to a struct vring_desc pointer is wrong. The pointer is
only used as a memcpy() source, so a void pointer is fine.

Fixes: CVE-2026-6425
Fixes: 293084a719 ("libvhost-user: Support across-memory-boundary access")
Cc: qemu-stable@nongnu.org
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260417132645.121192-2-sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..014d210748 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2391,8 +2391,9 @@ static int
 virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
                              uint64_t addr, size_t len)
 {
-    struct vring_desc *ori_desc;
+    char *dst_desc = (char *)desc;
     uint64_t read_len;
+    void *ori_desc;
 
     if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
         return -1;
@@ -2409,10 +2410,10 @@ virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
             return -1;
         }
 
-        memcpy(desc, ori_desc, read_len);
+        memcpy(dst_desc, ori_desc, read_len);
         len -= read_len;
         addr += read_len;
-        desc += read_len;
+        dst_desc += read_len;
     }
 
     return 0;
-- 
MST


