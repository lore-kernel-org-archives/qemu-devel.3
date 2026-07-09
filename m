Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7650C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whldj-0004uZ-Mq; Thu, 09 Jul 2026 06:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1whldi-0004uR-Ka
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:05:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1whldh-0003cR-0T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:05:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ca70925c25so23323105ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783591551; x=1784196351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qcQF8Hfnfs01Rjv+g1yGOYHDKQ6qq81wmivkEJ2IsEc=;
 b=no3eBcZ4WoG8tPDXQBUr9BoaIgCSSRlao28QLsF7fVDmJSXK4msgv4zCMTyauay4Sm
 YuSSLLb6pNLc8eIkVdXjZIe4iIl1aMHJ7yXX09tpDDo330x+9gYa1/CWsblep/Ekf2IE
 k18OVZeBumFjEYo+RTLUfQXaZ1OVnPzj3ZhR1z/vEahONkXBY8I5vwSLNYqT07CXZMBh
 6IxLDchxZB4p0jcyrOlQgxjL/sbfFKmFaudKj08WbcU1A28sEpxtfq1JtxXoi+jNyH+7
 DhF/CfJXp3+3KLMDKTr1ihW5+NWoo1A3h9cqA0Nfme/5Pmlq/BoD8DOWThsDEAeGNTSy
 wU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783591551; x=1784196351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qcQF8Hfnfs01Rjv+g1yGOYHDKQ6qq81wmivkEJ2IsEc=;
 b=c+me/fZ9wUc3d1OrJZHoIoR8Nxz1STrNzru1i1STP/7DkR/PHsXUcnelf85sD4j39i
 2jlMTy6GDpDuwte3LAdGJp2jlCal5eRVbS8SinESNthgtulMXD+j+nrY3J8sU5Z7xUUg
 1wPfbtSPRvasTdRw+f28Q7TLohnZCJoRqf2vES2f2UVtKYjZHVPWgqgnIRlhmeYTNH2V
 yl+Jdpz8rMGrsrgO5wA+2K5SxtJgCbu3Z8yKtmPPvVp092Zh9KVfEPZeYUjwvd73IW7w
 Z+JIeM2T9cTcBltlyzVNbB7QSaqMVZxF33jgQg0rLqLk4nt7aUYCmP3Q0IPD09XGDxXz
 j1kA==
X-Gm-Message-State: AOJu0Yy2YU4ehCoj6ssgzxlbnld/hbR/XUHTI86BeUe7TIj0jC7F092B
 cT5Z23V/HMXOfdDtaZQuWaBDOHTEbuysPVPtRBKfatJ6E3s7oL7bLe4Bb7n7KA==
X-Gm-Gg: AfdE7clRd7xqQQEVplJdoO5v3rPQmRwSbpL0h5qyxrJKM5rnyfVJ5f3NCdqq1STE3Y0
 wqDl9iXX6/VyjbZO1uvra2rWJoZTN5Xd7gNjGuuY124zoH4QYocakJca0oyqkAD/lt43YlXbv27
 sSEhBPFIhH7AqrwCy0JHPn4TQT+qUgyEvPXwNXfhAZAApyq1tAl5u+ht5TSMhJpWPSeMtsLpeEh
 3vTcuRQr+EdD0Fr7PGvj93e8zP69wx/v66Ero4WNjxsaAzICac2oyKQBBI7KSFNhIk0g2lbGq6Y
 ROJ2vQsZwjxlHTrDUaApiIT3nBsUujfBzPQRczLQ3leQ8rYY2+YHrUVEmSTMIUsWtOgp4CBAXRy
 7SUlv1HcmjY8pHAxa8B6ogub6f/UhF/KpBPP7mjPPyeckc3rThBDV+nP0FNF/xzycnGzT7gqTH7
 4dlwFpXcvbfkw6mA==
X-Received: by 2002:a17:902:d54a:b0:2ca:329:3d96 with SMTP id
 d9443c01a7336-2ccea2a5e26mr65931385ad.3.1783591551349; 
 Thu, 09 Jul 2026 03:05:51 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d60da9sm40905305ad.84.2026.07.09.03.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:05:51 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] virtio: validate split queue head count before popping
Date: Thu,  9 Jul 2026 18:05:29 +0800
Message-Id: <20260709100529.41267-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

virtqueue_split_pop() reads the next split avail ring entry after
virtio_queue_empty_rcu() reports work. Call virtqueue_num_heads() before
consuming that entry, so an avail index distance larger than the queue
size is rejected.

virtqueue_num_heads() also keeps the read barrier needed before the avail
ring entry is read.

This prevents an invalid split queue state from being expanded into
repeated device command processing.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3930
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Tested with qemu-system-x86_64 11.0.50, built from origin/master
f893c46c3931 plus this patch, configured with:
  --target-list=x86_64-softmmu --enable-kvm --disable-tcg

The original virtio-iommu live-vring qtest reproducer used for the
report completed successfully on the patched build without host OOM,
confirming that this reproducer is fixed by the patch.

 hw/virtio/virtio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..252bff8641 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1751,9 +1751,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
-    /* Needed after virtio_queue_empty(), see comment in
-     * virtqueue_num_heads(). */
-    smp_rmb();
+
+    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
+    if (rc <= 0) {
+        goto done;
+    }
 
     /* When we start there are none of either input nor output. */
     out_num = in_num = elem_entries = 0;
-- 
2.34.1

