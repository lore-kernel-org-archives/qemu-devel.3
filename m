Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8594FEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAe-0000rq-GG; Wed, 04 Feb 2026 14:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAa-0000RW-KW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAZ-00082F-4Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRIH6dHk97LErqYrRBUU7eUC8F1/GVFoIBs89PuE0lY=;
 b=Hma4e5T6W/k/skIY0s+SAjWz8Ou7Sw/GeuWDaMJ2lgITgZh6/hTTnAZQ47jM8mYXEUI54E
 x4N58hwN5/i+scYUlbomqaoiQnP+8vcafWQ5Ar8Fp9BInuUJWUUXOj1GM3UUtKxmAwOOpB
 hjBmk9gVMvdmFAMFKIvHucurnW0rk7I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-ITXHcoT5MPSqnYSRsxhY7g-1; Wed, 04 Feb 2026 14:04:04 -0500
X-MC-Unique: ITXHcoT5MPSqnYSRsxhY7g-1
X-Mimecast-MFC-AGG-ID: ITXHcoT5MPSqnYSRsxhY7g_1770231843
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so1011565e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231843; x=1770836643; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IRIH6dHk97LErqYrRBUU7eUC8F1/GVFoIBs89PuE0lY=;
 b=g1WBTFgKZIPO91V6eAH910NmwZ9KBOEN/LYnUtNbjEJoOhgqiORpIocpWQz2UKqmZj
 1PpxEEVpJqLjrCVWG5S09z/W7hOcMi5m2DNJd+1op57k09S4ZroV7/NvXn2Qmcj1WOJ/
 5yMoHwlHA1RivklSjgey2qeaThHQQBnrmv2ZVAXeh9r/ZXjyJFFy1VfnJ+hVjuxTS/F7
 N0mj9KkNg3uEMxLGxX1EDO5qe16hN5c0PVi/cJJEz/VjCdFjd5l6PZfskCgsEiJLsyQa
 RYsHWhqDA3jDnW6Td4/jM1pn9Eh4SDJasms1dOa8dYj5SE5y7oJSSs160jdjZBLJ4PjC
 dYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231843; x=1770836643;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRIH6dHk97LErqYrRBUU7eUC8F1/GVFoIBs89PuE0lY=;
 b=szvOxQKvEMmk9PEHVdlENT7AxNeJaPqKZl3cCOfvTOXAQdaF80CNsL6Vvq7Wqq6X/I
 b6M4c+5jjO/Faykr6KYpLE02C1iELyw+tuJ+vlw+ex/nP9qKN0s2VmtQFDLFV3q7T6po
 T13AUxgQNU9FZo5ehwcH7YQqhcsR8Nto7L0X2h7WRlx+KeuDVVIxlwQUszc4qSLyTjPP
 Tp1GqrVY62jGY0DCGkO/Qnv8fghnLU+W4wx7TUsfeU3T3XmwORyClR8x/BTsnkuaW0EG
 hbHo8haYIJ27+uT22Sv4hsTAw8tK1GDN5fwuhIlvZXoGdXwoeetFO68UKmZS5cBkICW3
 k8XQ==
X-Gm-Message-State: AOJu0YwokM39iASdCfZKPzGWbdaPKJUS2G65Lp7IOuWi5dseyIPqVJrL
 2QUWPGWwOvo+mtdJk9KKm6eKkfwf7jRkI8TRrIdZUDRVfJ/arIHtXfZfM7f4HDyZxh4WwvzITym
 VQ603WIvsdtfJokSSoXe8RDsepxdKTGkMYZARdZ2TskrOH8x8tAt1//TAc/pgZFWC/wfO+EGVTK
 o7II9ow8cgLQ3yNL6Tvr8B4p6+yHn0EBGKBA==
X-Gm-Gg: AZuq6aK04sldOEKG+DxaSzgM+pTr2JWpZNLcXDxrvMyEASugA7wPPr8e2+LEEHxU65F
 uTx0G1jxIIo7Pw38mTF1eTRYEvOF6q7+xJft/mCngLVgfs6KULkyTdaRGJshLrNKBdFhlJj5WYz
 3u4cxXsNq2mAgxs0rvTbLnH3ykm2Ef0FOQptyh1zKj10sCzd5f/b3I8XDHH9mZ7nm+eC1cYx61Q
 DbB1hwVZUyqjCqKN9soJwT1GRMdi5rWWCswmT4GgJXwXDhBVZG7jveV0Rd3nHa9O5Tx5tIxyeLb
 VvK0pgatOvBeQBluwfQBc+/RPOqzcAVi+ZaGFaqbDyhT9Ktn21+29nbIjHenAViL6v1f0aWTd/v
 jjrUDbTPYEEa8OxRB/sxzhrq7dDL/zbwJ5A==
X-Received: by 2002:a05:600c:19cd:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4830e9402f8mr57122485e9.10.1770231843192; 
 Wed, 04 Feb 2026 11:04:03 -0800 (PST)
X-Received: by 2002:a05:600c:19cd:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4830e9402f8mr57121855e9.10.1770231842623; 
 Wed, 04 Feb 2026 11:04:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e263b9sm7936301f8f.4.2026.02.04.11.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:02 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 31/51] vhost: accept indirect descriptors in shadow virtqueue
Message-ID: <b569677fe06510a0661da6bf08aee70b1a3e5655.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

The device is not able to generate indirect descriptors by itself, only
the driver can do it.  And SVQ is already able to handle them by reusing
VirtQueue struct.

Shadow VirtQueue just transform the indirect descriptors to chained
buffers.  This way we don't need to map a new buffer for the indirect
table and handle its exhaustion etc.  As they are only used in control
plane and HW devices don't like indirect, we should not see significant
downsides with these.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
--

Tested functionally by forwarding the CVQ descriptors.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201125149.2151026-1-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..6242aeb69c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -34,6 +34,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
         switch (b) {
         case VIRTIO_F_ANY_LAYOUT:
         case VIRTIO_RING_F_EVENT_IDX:
+        case VIRTIO_RING_F_INDIRECT_DESC:
             continue;
 
         case VIRTIO_F_ACCESS_PLATFORM:
-- 
MST


