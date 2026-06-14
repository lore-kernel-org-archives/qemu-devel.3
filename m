Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC09CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCC-00065g-4P; Sun, 14 Jun 2026 15:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC1-0005zs-52
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBz-0002Ah-Lq
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDfoHXS7iEWo5M0RdHNJpei5+MJB/QTX3LEyVD1aqFQ=;
 b=KyPuG5cZ+UUPlgwPyKHTktdWL/23hT3l18BxZAUiI65wkaencqfXEzI58mJk26ULL9rSoE
 +AAhnqXru6dTuNHFjlvM5S4pJ3oR+rJU/qthbEpME5Lpvqgl3Zx0GWd3pSIC8f0nVEgOcy
 8rq9uMAw9Yxwoowr9EZBuRYPUXjt66Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-9QED1-ayMQmMjfvWJCVizQ-1; Sun, 14 Jun 2026 15:08:21 -0400
X-MC-Unique: 9QED1-ayMQmMjfvWJCVizQ-1
X-Mimecast-MFC-AGG-ID: 9QED1-ayMQmMjfvWJCVizQ_1781464101
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so1528708f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464100; x=1782068900; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VDfoHXS7iEWo5M0RdHNJpei5+MJB/QTX3LEyVD1aqFQ=;
 b=eekJ/DgvnTu8MtPs86/k9CRAmghMfAlMbEEq+YY02WjHmmyccnQd69Y/ZGH49dAwEQ
 2+toascwf2ylYYcaE/ja70wbdzqBk5hegtlUgg49ryj556e7iLUco1N5JLPt/FrOhjMk
 45cD9Ro9wMMU8RMCtgsIlbyqKPyddblCuMxyIcc+VC+9ZXk4ZgJALEx2P+5pdC8O8zvv
 jxIMugxvZPg3VY6UR+BTm85Bz53pHeJgoLlnJUTqL0M2DH5YXMhCUU6v/coN/miRiU9y
 PahLtNKzJ3azFkaM+WvbdIRpvumz2n5FRa/4UIblUJHDIe9lyBM/hWY4CMdnc3kbhHiw
 HrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464100; x=1782068900;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDfoHXS7iEWo5M0RdHNJpei5+MJB/QTX3LEyVD1aqFQ=;
 b=cFQx/HFYLRutaaRRWDz2N3zDEPmNDR5HlnxksMzv8zqwRW8XjY0miJY9v3JihZikkY
 dnQftVAqUNcAzWA4Mi46RZFIXGlrDSYlOPDAvIV0EQBqmit3BCgSAedlzQ5ozKfIPz6W
 9J4hYRZFyS1r8JttIwrIchDsaTw0ubK8Z9CJCOETTpGNgiHxRuPAJGTq9qNiZwqhmF7K
 SX4McwwvCODKkb1JT+++IqotK6ay0Iqd1aBBW3TqR07uT8YhW2/GfRol8mLhWDh2NGox
 ZrhH3NZ7FLRtzqQwWNP7p+SqbhyeVUInRKIOrDBI+LYuT5C7mSyLxRCOvkvGmVF9cvPx
 LvvQ==
X-Gm-Message-State: AOJu0Yz2o6jIQq9Gfvnwf+byFI3MBD5SCtFuwH3WcyTrGTzvOUALudxF
 XohsFv/+0i1dXT2aHGjk7Fg7Nx+/x+nDB+Ac1KxYI5vuTMjXJ6/4299fgcPC26m+axHMeKFHOWw
 1egcuTEiirr/fkz9zaD9tH5tCqXBWalQaI7hm8XQN/P10yywQiNCOMbWsgkyx+h75pxXBc7N6ZZ
 JUxV1aUcd6l6N60Rj69XSPfpcEMI/1gLz0gg==
X-Gm-Gg: Acq92OEIypgRzFHB5a2mTaRZHvSEmvsZqx3XAdZaifZzwz0mjjqPZd0ROmfw8z2kpSL
 /ZzG2RdWpvu0/zYZH8W9oFtOjPM4gMbNBj9j/vv8wgjgIG1FLZ15reW93iN2KSJdcj/F3SJjqZT
 8p11jrtGey155kln36RiuMJSusi8/5aIPVy/WXzAWl3uxI6dOoMQoSZ378Wd0akq1jjXkkmm+Nv
 LU3plR7LX1Wku0BypxiOhOj5lW16McQsiSpSF/Bec9nTnj7LhhFzsa8rl+og58MDlmVXpdvLABe
 ffg1h11inVcwaVHbnVTSM5XeBwiJTav79Ora7g7NNZ/WkqMS8yxCMhIizDmulmQ+laUdeNMUBwX
 UicWBj/BEFuGNozTpHZwI1C6WpjAfwTHQ6LF8058Q+F8=
X-Received: by 2002:adf:e013:0:20b0:45e:ef4a:8192 with SMTP id
 ffacd0b85a97d-4606dbad311mr10499427f8f.38.1781464100468; 
 Sun, 14 Jun 2026 12:08:20 -0700 (PDT)
X-Received: by 2002:adf:e013:0:20b0:45e:ef4a:8192 with SMTP id
 ffacd0b85a97d-4606dbad311mr10499402f8f.38.1781464099984; 
 Sun, 14 Jun 2026 12:08:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm27246463f8f.37.2026.06.14.12.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:19 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 DARKNAVY <vr@darknavy.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>
Subject: [PULL 060/106] libvduse: fix buffer overflow in
 vduse_queue_read_indirect_desc()
Message-ID: <9f1b6d013d42b112680b435af9a9dff331b3fbaf.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vduse_queue_read_indirect_desc() copies an indirect descriptor table
into a buffer in chunks when the table crosses a memory region
boundary. The destination is a struct vring_desc pointer but is
advanced by a byte count, so each increment moves the pointer by
read_len elements instead of read_len bytes, writing beyond the
buffer.

Use a char pointer for the destination so that the arithmetic
advances correctly.

While at it, change the source from a struct vring_desc pointer
to a void pointer: when the table is split across regions,
iova_to_va() can return a pointer into the middle of a descriptor,
so casting it to a struct vring_desc pointer is wrong. The pointer is
only used as a memcpy() source, so a void pointer is fine.

Fixes: CVE-2026-6425
Fixes: a6caeee811 ("libvduse: Add VDUSE (vDPA Device in Userspace) library")
Cc: qemu-stable@nongnu.org
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260417132645.121192-3-sgarzare@redhat.com>
---
 subprojects/libvduse/libvduse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index 21ffbb5b8d..df9ca5e56f 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -465,8 +465,9 @@ static int
 vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
                                uint64_t addr, size_t len)
 {
-    struct vring_desc *ori_desc;
+    char *dst_desc = (char *)desc;
     uint64_t read_len;
+    void *ori_desc;
 
     if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
         return -1;
@@ -483,10 +484,10 @@ vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
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


