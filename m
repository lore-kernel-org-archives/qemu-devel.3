Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0ECC48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQKP-0001k6-EQ; Sat, 17 Feb 2024 14:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKN-0001jC-58
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:23 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKL-0004N3-JV
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:22 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso1762748a12.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708197977; x=1708802777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXJ67KfZkR1b8csu18xtWZdHrYCpHs0OoNjUSahRgdo=;
 b=m037wpwleDhrjc2F1p0DfZ2Jkrwusl3lFcgrz4wIcdPOj+9xeyVOpcgNyDFbXJawlo
 cvOsJLQt0YtcSLMF6pKnGSQPwNn7kzb5KqAyRhQecP9yJ0CRkz44OOmQgYSJ6TOU55xx
 aM+/YIugKjhVEB7apyJxGfBA3K7rqheP02aDZrtXhk0SmG4bhWUYWeek466n0i6UR3MQ
 bdKARrBeuiwcaJYHj0n3rfTLWfC0pgTc3VknWCScMHZD3DSjmvoLMIcDCOX3IepT7tTN
 vpYzkzmjBYGHLaHkjWHZ6BjQjodschYJHlH5+2NDRcMGsLHcc450O3idvKY0jgW8+Ws6
 a1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197977; x=1708802777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXJ67KfZkR1b8csu18xtWZdHrYCpHs0OoNjUSahRgdo=;
 b=KEVS0766HMLUOhhHCRFGbgvu4LGRAiCro2pR4WCboenSoQjkrg5RoaRly5KDmuFVvD
 0X3U/ivyu5uyx3RyDh2NhQL5SYKxHfbJ5SaVgB4b4aOpxJSetBO+5naxGwVPn6MRI9lY
 FaWcGX+TMat/1ZjmW4G5i9Momeujyhk0htoV7tLR1jPHIAOqk447UHRzMGBsvT1SesU+
 cQ67B9/JUeC78puYlSbpZ3U8c/1y8wQolPp0WHiAQSQ3YfSYu03V15/W/mfKHlQN7ry8
 Y5AUSekFniVaVxRf0dLnd1He+Hz0KQgJaC+7tvzBvMuB69leqTfmPLhFOKvSS4RLMRj7
 lhMg==
X-Gm-Message-State: AOJu0YywhiBURsRO7TcHSmk2shmvLlNja2o86Cp495mzjB5Z4SZnkG4M
 lcNL1kr+MO5ZNiQdod3Iy7pN7WEz6lX9T4Y+jHkI5QFX2smg8JQLTv2pGkO3uq/3Lfcw07XGfsq
 c
X-Google-Smtp-Source: AGHT+IFOoZ332VHewATcQCjca7jvcRx5IVzsA/6pl5hP16uUtGaxlNWG5Lij6rg7SgbirnJHvJeilA==
X-Received: by 2002:a17:902:7c01:b0:1d9:f495:cfa4 with SMTP id
 x1-20020a1709027c0100b001d9f495cfa4mr7676082pll.62.1708197977443; 
 Sat, 17 Feb 2024 11:26:17 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm1770927plp.22.2024.02.17.11.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 11:26:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
Date: Sat, 17 Feb 2024 16:26:02 -0300
Message-ID: <20240217192607.32565-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217192607.32565-1-dbarboza@ventanamicro.com>
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The loop isn't setting the values for the last element. Every other
element is being initialized with addr = 0, flags = VRING_DESC_F_NEXT
and next = i + 1. The last elem is never touched.

This became a problem when enabling a RISC-V 'virt' libqos machine in
the 'indirect' test of virti-blk-test.c. The 'flags' for the last
element will end up being an odd number (since we didn't touch it).
Being an odd number it will be mistaken by VRING_DESC_F_NEXT, which
happens to be 1.

Deep into hw/virt/virtio.c, in virtqueue_split_pop(), into
virtqueue_split_read_next_desc(), a check for VRING_DESC_F_NEXT will be
made to see if we're supposed to chain. The code will keep up chaining
in the last element because the uninitialized value happens to be odd.
We'll error out right after that because desc->next (which is also
uninitialized) will be >= max. A VIRTQUEUE_READ_DESC_ERROR will be
returned, with an error message like this in the stderr:

qemu-system-riscv64: Desc next is 49391

Since we never returned, we'll end up timing out at qvirtio_wait_used_elem():

ERROR:../tests/qtest/libqos/virtio.c:236:qvirtio_wait_used_elem:
    assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)

The root cause is using uninitialized values from guest_alloc() in
qvring_indirect_desc_setup(). There's no guarantee that the memory pages
retrieved will be zeroed, so we can't make assumptions. In fact, commit
5b4f72f5e8 ("tests/qtest: properly initialise the vring used idx") fixed a
similar problem stating "It is probably not wise to assume guest memory
is zeroed anyway". I concur.

Initialize all elems in qvring_indirect_desc_setup().

Fixes: f294b029aa ("libqos: Added indirect descriptor support to virtio implementation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/virtio.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 410513225f..4f39124eba 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -280,14 +280,27 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
     indirect->elem = elem;
     indirect->desc = guest_alloc(alloc, sizeof(struct vring_desc) * elem);
 
-    for (i = 0; i < elem - 1; ++i) {
+    for (i = 0; i < elem; ++i) {
         /* indirect->desc[i].addr */
         qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
-        /* indirect->desc[i].flags */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
-                       VRING_DESC_F_NEXT);
-        /* indirect->desc[i].next */
-        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+
+        /*
+         * If it's not the last element of the ring, set
+         * the chain (VRING_DESC_F_NEXT) flag and
+         * desc->next. Clear the last element - there's
+         * no guarantee that guest_alloc() will do it.
+         */
+        if (i != elem - 1) {
+            /* indirect->desc[i].flags */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
+                           VRING_DESC_F_NEXT);
+
+            /* indirect->desc[i].next */
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
+        } else {
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
+            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
+        }
     }
 
     return indirect;
-- 
2.43.2


