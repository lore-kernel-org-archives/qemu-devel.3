Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A5FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQKQ-0001kk-FU; Sat, 17 Feb 2024 14:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKO-0001jX-LK
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:24 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKN-0004NC-1B
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:24 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2906773c7e9so2225286a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708197981; x=1708802781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nxmi3CACwAhgZN22Vw1roSsuHBm2cEUexEge57O3rwo=;
 b=L7O2YeJgf8nvAXziFiKLYaxNUbNC7E7LpVw6ST3iS4/m/lGw0GHlr+xrAEawPHuo/e
 uHYimjU/0NyoypE6han5bvwRrP20dHccw91G7O/H/LMfbuzPZI7GItqmKuNji/8tI08L
 aMB3NPbBJfRoJ+vuR+CHt+8omE6bRWUd74p9vjVS06xsfRN3Ocs+yA5wgnazb81mLchj
 6DB2TGhj4gWOCG7XwYOSWgTyPB170Op2jgQyeNMF/hGPccip95Kb67mlgnBHLD1sPY86
 qOdXWBYTty15XHTfUQlVzp/4WiMHpqmrF4mK//2O/7zjPbHd5+A4F6Rj0mBTNPvEoWkI
 3UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197981; x=1708802781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nxmi3CACwAhgZN22Vw1roSsuHBm2cEUexEge57O3rwo=;
 b=RniNtHy1z5wpw5z0MLmzAyWCoXJyvX3GjsdLdrlanGp3TnynaaVhK8f8b94LEnMs0U
 w+gxCLNJRE09iKzVV/7o+ZtboxddkyW2ZmbsB2TAIpMZfTtRmUHWXhBZxgz3KTCZpS7A
 JH4hJ3gXyQ5sM7QEMsaIj7rqzsf98M+x8ZROtAIUkbxdksfF6aE5dPcPmjdnqSJQ8J9p
 fkajQr3eSVZza+2X4eLg6YejEmwPIqoObzQOu8dxOzAZILZoT5/PwSn1x7jc7vRpJorO
 74LqrYpmolrjDs1jFTvwNFkZ/YMK6vt05Wx8TdeGLLA8lQCbW0AJUQB1TX4fFeKVlTWK
 mIvA==
X-Gm-Message-State: AOJu0YzwbANu6EZQMQnEuBnBGvopjvVmUq9fbmNGhREJwY12VFhKJfLk
 CbW5DxJQX0tZ01Td4sLBpPqV5QRzGyImJwJPcmw+Y6NWgR5h7OSZNPsan6KCHVYJwoPCgLL8GV/
 Z
X-Google-Smtp-Source: AGHT+IHrJZYoaz0r3IYN+hclZWHXSa+XP69uRELiguwO1d0CpxhSg/IzicHmfZte5itti+M9azK9qg==
X-Received: by 2002:a17:902:6b8b:b0:1db:670d:27d9 with SMTP id
 p11-20020a1709026b8b00b001db670d27d9mr6269357plk.27.1708197980895; 
 Sat, 17 Feb 2024 11:26:20 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm1770927plp.22.2024.02.17.11.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 11:26:20 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/6] libqos/virtio.c: fix 'avail_event' offset in
 qvring_init()
Date: Sat, 17 Feb 2024 16:26:03 -0300
Message-ID: <20240217192607.32565-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217192607.32565-1-dbarboza@ventanamicro.com>
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In qvring_init() we're writing vq->used->avail_event at "vq->used + 2 +
array_size".  The struct pointed by vq->used is, from virtio_ring.h
Linux header):

 *	// A ring of used descriptor heads with free-running index.
 *	__virtio16 used_flags;
 *	__virtio16 used_idx;
 *	struct vring_used_elem used[num];
 *	__virtio16 avail_event_idx;

So 'flags' is the word right at vq->used. 'idx' is vq->used + 2. We need
to skip 'used_idx' by adding + 2 bytes, and then sum the vector size, to
reach avail_event_idx. An example on how to properly access this field
can be found in qvirtqueue_kick():

avail_event = qvirtio_readw(d, qts, vq->used + 4 +
                            sizeof(struct vring_used_elem) * vq->size);

This error was detected when enabling the RISC-V 'virt' libqos machine.
The 'idx' test from vhost-user-blk-test.c errors out with a timeout in
qvirtio_wait_used_elem(). The timeout happens because when processing
the first element, 'avail_event' is read in qvirtqueue_kick() as non-zero
because we didn't initialize it properly (and the memory at that point
happened to be non-zero). 'idx' is 0.

All of this makes this condition fail because "idx - avail_event" will
overflow and be non-zero:

/* < 1 because we add elements to avail queue one by one */
if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
                        (!vq->event || (uint16_t)(idx-avail_event) < 1)) {
    d->bus->virtqueue_kick(d, vq);
}

As a result the virtqueue is never kicked and we'll timeout waiting for it.

Fixes: 1053587c3f ("libqos: Added EVENT_IDX support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 4f39124eba..82a6e122bf 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -265,7 +265,7 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
     /* vq->used->idx */
     qvirtio_writew(vq->vdev, qts, vq->used + 2, 0);
     /* vq->used->avail_event */
-    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
+    qvirtio_writew(vq->vdev, qts, vq->used + 4 +
                    sizeof(struct vring_used_elem) * vq->size, 0);
 }
 
-- 
2.43.2


