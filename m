Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B31F436A1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjDu-0003xJ-4T; Fri, 17 Apr 2026 09:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDr-0003wl-1l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDp-0008T7-Kl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776432420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkKEtBNLy2N5J1c6O82yD0C+DpO7PoG1KTI1MijcaHc=;
 b=NqXf6oe+CDLvOnbYwI4vN3c3EWcykSDOiYWuRTsbW9bVsrgAUquWC41gYlmhO8iQJJ9FPd
 kVhAuLx/EgwNnei1tvws0jPSq+mbBj3YLMzuOyQcZWBYHVTIWQzyUxIbISSc9nM8v4dUmm
 mWWSfiiH8hZrBrD4KRESjQso4/5AeFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Bp_rsrDeM8qFEL25jYRISA-1; Fri, 17 Apr 2026 09:26:59 -0400
X-MC-Unique: Bp_rsrDeM8qFEL25jYRISA-1
X-Mimecast-MFC-AGG-ID: Bp_rsrDeM8qFEL25jYRISA_1776432418
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d2cd2674so5688045e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776432417; x=1777037217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkKEtBNLy2N5J1c6O82yD0C+DpO7PoG1KTI1MijcaHc=;
 b=lgzCXc2mDYbOeIBt4Bo0+ZgNRd3/kNNmHPqb+giWC6LFwpzAzkbA+cdjrsvNBo3Tn4
 ssIvk4L1iTQffunjBygrwZrqqSQMH1BGfTA2mPKsPqKRQd4KRm75cZ2OcXHUI3r4dmM/
 6cHLy5NP1QcHjulwyADw249i9zYcxxqjjXoBpjqn2r21EJ/HKG7+s5KRJLqDOKvoC0Ax
 N9aB3tKAlZ6dMWBH9dTpWuLiF4TL8zpAn+O4CeSnIoxJvEuFAe9Lr6YL86NS3vYfs50M
 3C0TH3ZPKMv8yXbeEkNcg0NTGk7MvsoXNJC/I0YHoCCNlGWpyoS6fv5jrrJOEA2gsTCQ
 /FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432417; x=1777037217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TkKEtBNLy2N5J1c6O82yD0C+DpO7PoG1KTI1MijcaHc=;
 b=SJT0UZw4yordYXCwQhdn2MDk9c8RCvuiANIsOiyM18XLoIg0K5vj6dtX9drGUeiWm6
 fCFlA2gpbiYT/JvZdmF6IJgQhlYrJs/Wpjh34f/Y0hQ/SWGI9eEqI6Fe8NOmTSOX9VY2
 lUtnRAs+oo7eDw3sQIDkP5V0HYgBzUXU+gIXRUm3mAq13S2SKnZNWLXrYEjnZ3e39T4W
 MwlPEdvAW85L/7uk1nOhqNFbDzqZxPVuwK0Vh4hTOD7Gf1ZEO1wqLkIwx5EuIyVFicVg
 +TG0g08MIaADhLJTztYAPn/hkKJESApyyOCgtZFreX6he5F2avbKDJ09H4n70bAmUFBy
 5Qkg==
X-Gm-Message-State: AOJu0Yyr24coylA2dlguyYpoVuth433ulDCPytIPbCiXQE+774inHSK5
 yTtHzHX6rDkRJjat0VSW7TPrTfZyAdUQVpzNIqVvTsZgy7cnreKFt0BNeFDOhpDmGzgZcGLqjIJ
 u+ER1+c/6D3DFWQzNSq2ZBmoZeFEh8Ffg20B25zqPfcbJUGxTLNGKFN4AmuWCTaVKAslg23XQCo
 AxLdRQcoRLBtEPNVLfBf8R4wv0dL3lrUzNYUtUzTA7
X-Gm-Gg: AeBDiesv9mUosCLLg/V88B5ykUl0jw97v+TeYe7Fc5Af3NuOg+TDrV6V7W7sgmGOjL+
 AiDhlyMo4iIPWdLxz4LXleXd9FYEEhZ4JHwPbkVKSzYiRWcfzqBAdZt1xcpXNHzDOAjyPq59DeY
 smZs89ZtH992z0rd0wCdijoAIYAe1oCkbDMMS9/abU/Vv1icLimhZonwiWGOCqQTlZANeNsGt0F
 KC0MD2lhhK0qtDiBDhv9JL8R5jedZONHF/ZhSkaH4aVqN327GO4AnbdgBSy4Dua1O6jk+LhjwJ7
 Fw3C1jkxUi8xXJpMxTGpfKupNYg1PYifeRRxfAUqcPIAPCTKdtAjDquwUIYw5unk0EQ28qsoWCo
 qKt23b5uRCsWP/ujbZhdyQFCraJflEQgnJmsBuGOCviuzDjrpaoJFUs7EzWUwJNgLQpkZGFxTOT
 /40J8O3r1+
X-Received: by 2002:a05:600c:8588:b0:488:9619:9bf4 with SMTP id
 5b1f17b1804b1-488fb771b04mr32560365e9.20.1776432417193; 
 Fri, 17 Apr 2026 06:26:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8588:b0:488:9619:9bf4 with SMTP id
 5b1f17b1804b1-488fb771b04mr32559645e9.20.1776432416610; 
 Fri, 17 Apr 2026 06:26:56 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it.
 [87.16.204.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm4819635f8f.37.2026.04.17.06.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:26:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xie Yongji <xieyongji@bytedance.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, DARKNAVY <vr@darknavy.com>
Subject: [PATCH 2/2] libvduse: fix buffer overflow in
 vduse_queue_read_indirect_desc()
Date: Fri, 17 Apr 2026 15:26:45 +0200
Message-ID: <20260417132645.121192-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417132645.121192-1-sgarzare@redhat.com>
References: <20260417132645.121192-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.53.0


