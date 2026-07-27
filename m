Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E355C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQry-0000AR-Um; Mon, 27 Jul 2026 15:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQru-0000AF-9W
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrs-0000OQ-Hn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQNDpvgz0cKq2YM7qNFjDFk+WeGlgzmqudnvc9cyDME=;
 b=CehgnfGT5YnwOqkd7P3sVRdO5uRakF1cLTRVxGIcR7xBWXPNhxs3IK/Z5vaLoIdMVpbmW5
 qwNWn+abPYiJ7TOm+Dh1f0Xtqxq01US6H0+ECWrj+J6fEwPD3MGG/3OS1QjYlsNd7mWFPB
 b61MTvx8Yu85kqxSOYi9HY96AZcczP8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ySRMCvDKP-afaofyvw8kfQ-1; Mon, 27 Jul 2026 15:20:02 -0400
X-MC-Unique: ySRMCvDKP-afaofyvw8kfQ-1
X-Mimecast-MFC-AGG-ID: ySRMCvDKP-afaofyvw8kfQ_1785180001
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955ce558d8so28960805e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180001; x=1785784801; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aQNDpvgz0cKq2YM7qNFjDFk+WeGlgzmqudnvc9cyDME=;
 b=gmqxoxOiCWz19lcufIVVUVVXHT+NEXsuIn/2+MyqpLqtubFkZfwG8bGYX0YJYvlrpZ
 RnH+v+qncejE2Iww/hlHKRBD4B7UQtDq8dQJ3/t/oMsL2VCzgbo2ugATsuEkvsL1q97s
 3VzOPg6CgcAHBg8PZt3iH5tRFK+C5o7bYaghZlq8lOmcsfycvx8btENQHeihdfnkW8S3
 VLZ8KjwwZBfItBwVbKwNxvgft+R9BVIT87dPYOgEQJYCHkSOme6k4iftDuTSdy5GfWup
 qLUd7vxJ4ia79Hdpd5Jkf7ONYZW9MUTuzSYnc5flczokrY+y8Y1ojHKptp/n9ZxAGRFh
 WVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180001; x=1785784801;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aQNDpvgz0cKq2YM7qNFjDFk+WeGlgzmqudnvc9cyDME=;
 b=FdGsK4NS6dLgzISCAixQO2n7hCq7lcAThCXZzYGiWInwpRlqawOv/Dw4w6wwMcKO6y
 85dnxzlFeNKy7dCmF7R0NWQSauWAGL3g7r0ZNj2mNbHbPmqD9CQ13eIM/CRObGFLCHxZ
 PYGUJDzw55sdEntHYSIWg8TgBBwO7YLIjwJCwk4luuq4bXHPHnHyNqx2RYN4XGFJhpcH
 XEwaOCFN+Lk+24yAGUq/Xpp68WDT8Add6LaRWBXqAvoFxR+pj80iGTAK7BUWlnXORCeg
 De5UTKdZGoKPlZaUBQZlH3vqNx9aTXOwxAg9AHKac3XvAQzoE4RsBev7ju5Sx1jbzGS6
 PVEw==
X-Gm-Message-State: AOJu0YzerTzEcsR2OxNqnERMJdIH2fRO99ySQLwujRwlQLQpy6gh0UPS
 OnqhaQGfCM6xlMpksBg0MyqjSIHZdfw87MuLhQUqifnUqcdGs6dfXM7b6JU+RRRc9yb1woy5aZA
 eLtq9DuLYw8cmYGDdHEsVKdW3n56nW0KOjZC35uFIJNu1n5MpLItsnDpvH9U98vFEwGXs+RqWXa
 d9yT34XLjEFihpsZjQVtjhwbF6VOtpQumHZg==
X-Gm-Gg: AR+sD12VTQBTmXLcCaIvwzJFmB8rymzpcHU0t/ljLQHgygxN0l8+Ze0wKVB0Svc5MfQ
 nlUduqfrSP7S7dPSY2sV3MmEiNb7I9+VgWtayl4WlPHHt2iSc3Jruda6CFlKW3s8qUAIBbej6pg
 /c8do25UKK17mb8WqVXoB29s6OJkSiXmJg26UEuw+MjEhyl+M8k+5b++vJCCWAblPSjJ8RwB/fg
 up33AEamfMxzcp90TJPsi5/cKzHTVxDVNt5NVD7r79Y3y59bnRCf08R+p9LzBrcx/iNwxWZNTAh
 QZ3Ys8unS14sY8W50pjWKk6BscinCPnBiFBecACW3Qstoi9MJm32CWaIpHiskmzcvNVBqIaJVnw
 Gr+X1WX9nxlqumQ1OdWRalw==
X-Received: by 2002:a05:600c:1549:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-496b6a31b65mr123243475e9.14.1785180000878; 
 Mon, 27 Jul 2026 12:20:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-496b6a31b65mr123243085e9.14.1785180000302; 
 Mon, 27 Jul 2026 12:20:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45e0424sm14774085e9.13.2026.07.27.12.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:59 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 huntr bubble <bubblehuntr@gmail.com>,
 Jia Jia <physicalmtea@gmail.com>, Miku Hatsune <anznu1l@gmail.com>
Subject: [PULL v2 10/30] virtio: fix queue size validation against allocated
 maximum
Message-ID: <d530f2dfbd2d973b17a6d0ffbfe2afb692bdd69c.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_add_queue() allocates used_elems for num_default entries, but
virtio_queue_set_num() accepts larger guest-supplied queue sizes up to
VIRTQUEUE_MAX_SIZE. With VIRTIO_F_IN_ORDER, this lets the guest drive
used_elems accesses past the allocation and cause out-of-bounds reads
and writes.

Reject queue sizes larger than num_default in virtio_queue_set_num()
and mark the device broken.

Fixes: e63c0ba1bc ("virtio: Add support for guest setting of queue size")
Fixes: CVE-2026-50626
Cc: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3921
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3923
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3613
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Reported-by: Jia Jia <physicalmtea@gmail.com>
Reported-by: Miku Hatsune <anznu1l@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <eb7cc3672a20db392f577edbece2300aa6754dd3.1784898967.git.mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cdc8ba76f1..4a6430c31c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2418,6 +2418,11 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
         num < 0) {
         return;
     }
+    if (num > vdev->vq[n].vring.num_default) {
+        virtio_error(vdev, "virtio: queue %d size %d exceeds max size %u",
+                     n, num, vdev->vq[n].vring.num_default);
+        return;
+    }
     vdev->vq[n].vring.num = num;
 }
 
-- 
MST


