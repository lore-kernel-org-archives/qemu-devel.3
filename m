Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E659EFCA177
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfrk-0008Gt-MD; Mon, 09 Mar 2026 15:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfrh-0008GO-Do
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfrf-0008Og-NN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y/qlqmIofDlptpbL5/aMCvyiW+xkWmjzCFv3R3DqpoY=;
 b=UDAJbL7UiOIpzoCN0aTlQ+0kAYcG0gFloh5VtCMgD68/AfIjLVdd9NZY/J5FbQXM/+Y8rj
 k7IR1Tb4JnucRox+BFgQy5z2yMaAC4EZt2jsj0fbwnxGWR+27TQttEmdcAFfJ9pLiX3Nga
 gRRFQyOiTLEEE1dAFN3amwB323mjy5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-NnJFGW2iP4a2ksev2yJr8A-1; Mon, 09 Mar 2026 15:02:00 -0400
X-MC-Unique: NnJFGW2iP4a2ksev2yJr8A-1
X-Mimecast-MFC-AGG-ID: NnJFGW2iP4a2ksev2yJr8A_1773082919
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378df3469so83224045e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082918; x=1773687718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y/qlqmIofDlptpbL5/aMCvyiW+xkWmjzCFv3R3DqpoY=;
 b=e19jk5l0oXKKEEjszrJqPj16N0n8DsNoOJj+qglnLUbMYaEAEHpY8DDemCXJxgribh
 IEUBap3BO4q5QQglLLpc52zWOesCckMOSpcBYtwAEsKMo0rKBKpLFwb9teic1hbjdX6j
 vPipwnsuJ3KesxHdsYU+qXoxwMHdnS01CbEsMCn3mFmziX2LV9/o/vIUIfAiLjecoLf5
 sjO0YXfbOx9DM7qDlrdNS/zGpk0sG19cl/emvuwfzUdCVT24RRzhw2KyV99ETA6bunNd
 ppZBahaw5l5ANMoKPM5BjtoyQpn6r1bFpFS+/s7GBKKpF7bySLBhEuFdeZnyd+DSnjAd
 kZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082918; x=1773687718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/qlqmIofDlptpbL5/aMCvyiW+xkWmjzCFv3R3DqpoY=;
 b=wSLDR5NpYm5lCChUA4Ls2sLwPubIYtVFR8KJV8ORv/lcnGKOxuBWW8+IMKabySWdIt
 F2ZCotEs/dQEV7dVNx4Q5peTi8Trvr66m/KBuBKHFswylWMABzCLZvU14ESW1r7TdOW9
 nWae+B8c2Dw7roOswUIaAwkTcm/Bz7FK4JbocFP3k3MvhRkgAZcCuoUITcFFC5vDzNuS
 m1pfhLykwW6+mS9h8IIi96lGuXEf2cCK43AdJ6MSpS3g27uKksTQvHBduv4L5awaG9Tl
 vzridyg+SbOt8lay/SLhCXrzu5V/73FHns/ZYte93u6h+7G7dkIdrnebOL7/1AhS2URU
 EgPA==
X-Gm-Message-State: AOJu0Yz/U1/VFq+DJshbgTNIjRF/YMSiKGuJn8EFWXFZnqrzBavWu2pC
 dPrQK170rtPgFfXhfEenNLy+fdXs5wKPlvllcHUttDRGydak4kPD0zUHxRsXh9Pdtb9ARQhmSLY
 f36JTtdWUgcP887mF3r+eur0Ctz3losa/pDz88atF1iO2g0gQL488h++Ofi1sfATKkrWokgEMFE
 805bmOLOF5v4vdyMIAvVVwf5T+JmwhrytP7+MnQhqJ
X-Gm-Gg: ATEYQzwrC9Md8kHb3+STYyy739lp8oLapWGnuUP3a+HOUdHtspQzUXpkMqVbphDZQRH
 a1csJmlJMIDxXtvomfazQrrUF4U1J0I9+OdoMNzoou/j2PEYZie515YdlKiuinUnseXrfntB/0w
 yqNGAp/vzfd/1K39yoR7zrhnueBGBH+NhVEFS6cFiUb+DPLPZh3JmgxhRQnVzhZ5uZt1QD73EXk
 Dns0jOq14DhTqLyJu5XldQLEK5SzH13wq/roD1qocBmVMUmCR9rUT/MTmhKjL2+CTWxdGdzMXtB
 IeoF8MRb3PLk3SX3A5gPR9tehVkW5j0/+8RAYWLwlAQooYA75hjsO6Ue23gpZ0ni5lpJIhE45Cr
 rHwLWveD80Xh8ZOG4OFdcNF5jLpXpFzMoLH+azOrOqHWFmnP9erMB8sIvw2NOziTZKQvFhfTvne
 BsUmWyA8fHRLjPDEMTsjkhEFzkpbU=
X-Received: by 2002:a05:600c:8488:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-485419b61a2mr10821245e9.6.1773082917959; 
 Mon, 09 Mar 2026 12:01:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8488:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-485419b61a2mr10820735e9.6.1773082917435; 
 Mon, 09 Mar 2026 12:01:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8d4desm10575555e9.8.2026.03.09.12.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 12:01:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, security@1seal.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hyperv/syndbg: check length returned by
 cpu_physical_memory_map() [Fixes: CVE-2026-3842]
Date: Mon,  9 Mar 2026 20:01:44 +0100
Message-ID: <20260309190155.80619-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If cpu_physical_memory_map() returns a length shorter than the one
that was passed into the function, writing the full out_len bytes
causes an access beyond the memory allocated to the guest; or in
the case of the MMIO bounce buffer, an out-of-bounds access in a
heap-allocated object.

Add a check similar to the one already in handle_send_msg(),
and take the occasion to remove repeated computations of
recv_byte_count + UDP_PKT_HEADER_SIZE and clarify that the
code does not write past out_len bytes.

Reported-by: Oleh Konko <https://github.com/1seal>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/syndbg.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 1e177f9dd82..10171b19e8f 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -194,7 +194,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
     uint16_t ret;
     g_assert(MSG_BUFSZ >= qemu_target_page_size());
     QEMU_UNINITIALIZED uint8_t data_buf[MSG_BUFSZ];
-    hwaddr out_len;
+    hwaddr out_len, out_requested_len;
     void *out_data;
     ssize_t recv_byte_count;
 
@@ -223,29 +223,28 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
     if (is_raw) {
         out_len += UDP_PKT_HEADER_SIZE;
     }
+    out_requested_len = out_len;
     out_data = cpu_physical_memory_map(outgpa, &out_len, 1);
-    if (!out_data) {
-        return HV_STATUS_INSUFFICIENT_MEMORY;
+    ret = HV_STATUS_INSUFFICIENT_MEMORY;
+    if (!out_data || out_len < out_requested_len) {
+        goto cleanup_out_data;
     }
 
     if (is_raw &&
-        !create_udp_pkt(syndbg, out_data,
-                        recv_byte_count + UDP_PKT_HEADER_SIZE,
+        !create_udp_pkt(syndbg, out_data, out_len,
                         data_buf, recv_byte_count)) {
-        ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup_out_data;
     } else if (!is_raw) {
-        memcpy(out_data, data_buf, recv_byte_count);
+        memcpy(out_data, data_buf, out_len);
     }
 
-    *retrieved_count = recv_byte_count;
-    if (is_raw) {
-        *retrieved_count += UDP_PKT_HEADER_SIZE;
-    }
+    *retrieved_count = out_len;
     ret = HV_STATUS_SUCCESS;
 
 cleanup_out_data:
-    cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+    if (out_data) {
+        cpu_physical_memory_unmap(out_data, out_len, 1, out_len);
+    }
     return ret;
 }
 
-- 
2.53.0


