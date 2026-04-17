Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F30F4369F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjDr-0003wm-Ds; Fri, 17 Apr 2026 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDp-0003wN-RJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wDjDn-0008Sr-QL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776432419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwIkfqmt1zQnJULEPImGXDUThga13ymI6/6eeiQZxQo=;
 b=QY+xrr8F9fAxLrB9EX2myabmquBhjutIlZ/1A6xY9tbavRMZdinUvGwMcLHlNMCdKsTiJf
 70X+t+XV93ffkxyYJTWUAFRIaerWeoxUTq7HwnPWta7an7RH6ceWrAQeK2uypRco5TrGMM
 0GMvq98bIES6lwoVk+GliqiAs5q+uA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-vr4ECjyONaWC8tLwJ6ZxsQ-1; Fri, 17 Apr 2026 09:26:54 -0400
X-MC-Unique: vr4ECjyONaWC8tLwJ6ZxsQ-1
X-Mimecast-MFC-AGG-ID: vr4ECjyONaWC8tLwJ6ZxsQ_1776432413
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d4ac6ff9so5463385e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776432413; x=1777037213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwIkfqmt1zQnJULEPImGXDUThga13ymI6/6eeiQZxQo=;
 b=Iqt04R3+3Cyvz0GkVZzDBhUG5J6k+Iiyvu16lRTE//wjLwtaQR4cZ+4p4IRxrRH/lR
 B+rgJtywFOVIQDv0Vu4LtZmKxFFDKxAIG5U1dnoqoHinfmUIaSbNdo91QqYA56dFi8cO
 /L78yBgQKN8Zm992QtfGungvpUekQmwP1dFJzbEGMYcY9FPN+hx37s8oPnceN6g+J7as
 Ppgi7Z5Rf/oDp3Gp0iO67A8yMkZ1CeCj2uycKJMREdAb65qeavZxuneJHRt6reuNANn9
 mpVTiSGJMaLQ8ydi0raok5CBHHSzWpk1pK5anLR3DsXiu/1aHqy/wbdvd47C7EouV6FC
 ZpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432413; x=1777037213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QwIkfqmt1zQnJULEPImGXDUThga13ymI6/6eeiQZxQo=;
 b=nWmQxC0Ya1KveVk5C64F0RKn4anMOZnSIANuv0CkYjtktPrAfDg4QgoSmZEUlHzzRR
 SHdxfkVsYA5yReGYDomi9l1pTOETI6dXoSdfhM76AlBKDrQ7thIEyHbP6lcnpCnf2tvR
 E2/IQsgsTsDxrLuN0IGb8uO5GGwTF4CbnjjcDytywkAVwtbbHTWmKb4vzDbXvYxOVqS7
 qfkHJePVo5lkAX2+YTQnGUI3Su1sSy4g5ETn3TGWos1q8sBZJtqIKxicvlRlT6YB8jqi
 23LSEPogemR+AoJ55y7yq+sKo6j8OQMmIArNAlYDzW/FyWBrkXhAWFGJ38begebyPo+r
 q4oQ==
X-Gm-Message-State: AOJu0YwPGjsoDMQS+T0JW4+IcVtmR87bbUIup1eixAVv6ilZrg0Vplmw
 kXj5oYN1gRQ0N7fNFkWG/Xnb+kFBB95iX6qsM143L+Ya+uaxpu5a1fROOnMG/OrhR3+MjbNQyzs
 Uy3kXhgPaLZpa4FFf8bbQMZJEvDdq47bU8+b2TfJKQ20jElEqKgCBQ0k6+hunljQcnDT8PAbYfb
 3htf1dSBThG/mTTXq7dAFrS/LU7R8QJHSdhnBsTznU
X-Gm-Gg: AeBDiet6QnBrHmNeHfH3/tIMgr4oiMM77FEZYZQEkgIhbQ1nOtVuXqBdhg8ah0eYLKF
 RG5XpvyRYhJHmRq0LTiDuvmTaqhWkTcyS9qrLIlatxcgsHf3WRZQHdbf9quCW/0bQR1ogratmf+
 /P9EwELTamiH34iLB7jiOazhtwt8urj8s9vHB3XvsD4LkdW1x27MgG7+/jBpmOVNMUaPWaBpWw6
 NnglDDIr2zTeJMqy6rhAAEMIPFsJSCbNmL7fzKnoi6h6s5kSsjR0z06ypncYNyub3h76KFfcJ36
 7WSEj0AMiRMR4J+hd8mjZXgdurRUWDaNhgxn4oIc476mw8RrfY12cm3wdzHsVDj/S2/fRumQsp/
 stdKrITofE7vunpkyPuCK9oAB8me1EUHOE0DzYvdmcRcVnCv5AQw9JJdbskQXcM8yxtrgIh7SM/
 M70vYAjfQX
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-488fb792dd0mr44217695e9.23.1776432412844; 
 Fri, 17 Apr 2026 06:26:52 -0700 (PDT)
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id
 5b1f17b1804b1-488fb792dd0mr44217165e9.23.1776432412282; 
 Fri, 17 Apr 2026 06:26:52 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it.
 [87.16.204.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc16f8c3sm42236235e9.2.2026.04.17.06.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:26:51 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xie Yongji <xieyongji@bytedance.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, DARKNAVY <vr@darknavy.com>
Subject: [PATCH 1/2] libvhost-user: fix buffer overflow in
 virtqueue_read_indirect_desc()
Date: Fri, 17 Apr 2026 15:26:44 +0200
Message-ID: <20260417132645.121192-2-sgarzare@redhat.com>
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
2.53.0


