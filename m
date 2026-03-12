Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D1105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dqr-0003gc-1V; Thu, 12 Mar 2026 07:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqi-0003ft-D1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqf-0000DK-MK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruerrzlVnh/jDopFTG4KtbcM0C43F9HKskRHhkTWEf8=;
 b=PSdVdsXeArI5dUTtpF/HTTyyB0HTh8j5OEyp1ycAABOZ/6Uh/rvsBcu7ufnVa3s/xEQlex
 Idoxt3VbI8L7zn21rOUKpMIzptUi+09xfPIiMHcKEgUXA9/13g3kpxQr9nNcDRikWUUhCT
 KNx8+2yOIwEvCRbgiMeWGl15hpD5EpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-XBleqGboMxKOqNuPKShTUg-1; Thu, 12 Mar 2026 07:04:59 -0400
X-MC-Unique: XBleqGboMxKOqNuPKShTUg-1
X-Mimecast-MFC-AGG-ID: XBleqGboMxKOqNuPKShTUg_1773313498
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48544725bdeso9959975e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313497; x=1773918297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruerrzlVnh/jDopFTG4KtbcM0C43F9HKskRHhkTWEf8=;
 b=abKsxi705cyPzvOL7WEjUKvcPuJa1mKmpCPlywgv2LnybNCzGjV0SzKWHeiK/lIrFB
 raiLh+eW81pu1Q552SFdJxAcT4Fd1t0tG+jzC7Z5aAu7y8jgCsD5sFueLnrckDddoU9E
 zvHicaJ3zucsmsRlylv5h9qkyZdXQmTcrqrPIg5vgIHiFvKvTuatZFQeFjpfLYuIhY/+
 qTnv2OxcrbeG0dyMjEx+qgWjvAiK5kBihvAo/2HbeWhIqucK/GrNaEJrfL9QTt+wz+uh
 8GdAVcs77VTkBjCjEB8n0pQ4wd+HMbPRG1HyViBhVq5VRxw/xXntkBD7QzHk+X1xZzb1
 CeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313497; x=1773918297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruerrzlVnh/jDopFTG4KtbcM0C43F9HKskRHhkTWEf8=;
 b=vkyF+zB8Q5er6Crzt7LfO9jVnGwe2tJV8EJ0MDoysOadA/JLe51lTsPeNzqcFmwzSl
 mtE+uqT3cypTXNaEPYGADYHqCyZughQuvP6Qvx+d0A8cFA83upyqRqaYvLX7A8HX53or
 TajiMclMC6MsJNH2W5REJtsUKK+SDXPswTqMuKQ7gX8oLoTI3jLheTNGBUhcXFc4dlDw
 eVX8D5rQfckjiQ+y4BVV/0rO9K3tjK/BA/k3O8Poyv13vm/iYfP6GeWI+LATk9eF4Fw3
 DpCf++CxOqxWjcI+hOCcAyICITOcY/8OCpdIKcOEGKIyKMWsutCWcsaU3VkrcppBgPOf
 xVvg==
X-Gm-Message-State: AOJu0YyDdY4hnqFlKHibTADoTgQCyHSLfxvKSsh8R/ySq3w0rceEWDnn
 16Q5wQHgbrQpS7zvXZpLpekPNe3SWXc7hvZHJcw8VB8UQaNNG6GvSJkuoZH3L4OcybUIvrWFdtn
 Ej1H+kvPs22bJfaIU6cUnXk0DrPzNgCtpMcGUaPyUN547G+xssY9UPGe/mJdlPf68BPtifp5ouK
 8/fYwoJYbahuIsOqyTQ7MK8kA7CDAWcedBsLXunXMr
X-Gm-Gg: ATEYQzy0V8QvDwjnrvWE9mE5Ze87RyPekz0wyooZv/sFU9TPx0EWu96PX/4fGmxRzL0
 cWVdoiyYurbk+Lxet1h8dI8IggSX0It0v520pZjLzmzaJ6Xsd+uxdnH6MU1zNYZNvl34J1MZAHa
 +LRBzTBcKFLrtbGIzzDd7qSENmrHl3f7JnXPlN+cCguiLIRlzEP9x87g+viMq92xT/ctWse51bC
 rlX/fHHl8Pi/7FSADBfBgcXR9tfwCu19+LhDAbgAfbTGx+IgOYX8ufOf2zR4/DEAybSPSy7yFP1
 x6xD2GkmNNBtMabwzhVN8Xre4rQR9zIrqh/0ch1KU7ACAVFUKul+MfQzHYsGTLJ3irNURH+Y9nT
 rgCoo3uUoGmLLdov1E4ljdNg4P0aXOHdps4no5TPu3IjpwpXcsj7zmgtyE7SIOTm5f6fwKGJu4f
 tgv/vqZ5BJ9a/wxxk2TUvY7Tjkbag=
X-Received: by 2002:a05:600c:4752:b0:485:3a03:cee1 with SMTP id
 5b1f17b1804b1-4854b15a6f4mr93490295e9.33.1773313497284; 
 Thu, 12 Mar 2026 04:04:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:485:3a03:cee1 with SMTP id
 5b1f17b1804b1-4854b15a6f4mr93489615e9.33.1773313496696; 
 Thu, 12 Mar 2026 04:04:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66dedfsm124256475e9.12.2026.03.12.04.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:04:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/14] hyperv/syndbg: check length returned by
 cpu_physical_memory_map()
Date: Thu, 12 Mar 2026 12:04:33 +0100
Message-ID: <20260312110451.685161-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
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
Fixes: CVE-2026-3842
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


