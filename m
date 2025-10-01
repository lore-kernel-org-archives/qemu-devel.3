Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33910CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zyo-0004nd-If; Wed, 01 Oct 2025 12:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxm-0004DE-Cm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:46:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxU-0008Ew-R8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so53595e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337119; x=1759941919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EDum+dhl1CD52KcXkjkndmne+c8mAKnL24q1elV6zA=;
 b=j59rIdTvWsxLQGP18v3lVk/OoexH9PILwXP60OPVZ6Mx/80/E0i/TQd4BEARSCivBs
 65FdkFFaFs3P6hrJbzGS9dCCiaXah4cf2hqybx+F2hor0V4pqu6f1a4JPQ62PGg0nOrM
 kX62h9Hr49JPB7BNKeJSYKon7bvzp6Y4tgueVwouKPom5KNXvULpqFzYdLP1V0Tga0CO
 YwKN+usvBZ9mehtJLNULl8+0Ou4wQQRUtrm9NOMM6HfuE1Q9HX4NfC5OmORMgu9fsTqO
 dRalRe70IKZWC0I4IzWvShlg64cn8lVjGzybBspdcNEn9lR3rjKOb+fQzM5MPxYYp38j
 zXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337119; x=1759941919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EDum+dhl1CD52KcXkjkndmne+c8mAKnL24q1elV6zA=;
 b=UsksA6WxH7nQ8nZjpZDORmMQHIKRaFyKgqAALOurNsoHu2fQmm0laVzd1LI1mKKa+N
 4IN1Id+XoRk2wlNo/NMMfdDRpJDqvFYk96M+lNIJrntvfUbKkM39Hs/HObJvZw2zFc6R
 TaSkYqx3Yck1u40WqjexfkNH6imoLXsxGGeWV4oa53413B/YutCy0EJpUAqSsHFewE7g
 bLBZ7d9PEh9Qr2+km3Zy1pa/dioKHp4O32iRgpZpXt09aEjIrSTXKff7hyFGX09tU6Oh
 09ZZfU0E1GPbZ+qX6MTX/hrnn6cVW94kS75nvgUuSB30VptOekTqHiCzUFTkDrc61V31
 Q14w==
X-Gm-Message-State: AOJu0Yx5hNeiZqJNReqQquhemCiG4DDUImvzwL7smOQUVziVqdUo4cAp
 vnrC2w/oJ9Sb8tgnwiPHBjYwvDeqn9/rL9kB06O0lQscwdIyadmKAgnTV+jewmhFItSU6ssddWL
 iHvv4df+yJA==
X-Gm-Gg: ASbGncuEVzes6iCwbNwma98D+x2x88ZBfl3T+rd4r+3tSk2Wc27LZR5dcxWoN28A2Cn
 FpI4toBRoiJYNaaiVhuC88qHLgXNggSpdi3keiDt1l8x5dKGiYrFzHkyLFcb/D2qfrzrlnOLuMu
 B5zoNKMI7nxKzQKiYUu0O1iCQBuEowkxrtI1Jn951OKST1hvZvnq+AAST2PW2VxjH0de9/48RnD
 UfEfEmlscqakdrrUfzentO99Ms5FlSbXx0Ttt5r76tfLXECuc3167AuS+IzAUOy/G2pFl0Gfj45
 JJP0RcxlxIhDWgUuZ6mqD7IvdP/vuutL6R/lKS+uD8jhsvqBuQO5995ajvhdh8LxzeFFFVa7cG2
 HFWm/isTv7zcbNjLTRLK7exL18GJOAUZyGIlPAzynoMarlCc6L/WtAeR6ieOEcJk3h+0yiatetx
 osFlmffObb7R7dsv6LE4d6
X-Google-Smtp-Source: AGHT+IFuoJIVwwuSQuz/IALkeQo4mbooTvN92OPoQ5bAMU1DhLeX3idgzhWXiJutaq+0+/Xb8si8zQ==
X-Received: by 2002:a05:600c:4f91:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-46e612dd093mr36263585e9.29.1759337118163; 
 Wed, 01 Oct 2025 09:45:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm30183370f8f.43.2025.10.01.09.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_guest_memfd_range
Date: Wed,  1 Oct 2025 18:44:54 +0200
Message-ID: <20251001164456.3230-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Rename @start as @offset, since it express an offset within a RAMBlock.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ramblock.h | 3 ++-
 system/physmem.c          | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 530c5a2e4c2..839d8a070c1 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -104,7 +104,8 @@ struct RamBlockAttributes {
 };
 
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
diff --git a/system/physmem.c b/system/physmem.c
index 3766fae0aba..2bfddb3db52 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3920,7 +3920,7 @@ err:
     return ret;
 }
 
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length)
 {
     int ret = -1;
@@ -3928,17 +3928,17 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                    start, length);
+                    offset, length);
 
     if (ret) {
         ret = -errno;
         error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                     __func__, rb->idstr, start, length, ret);
+                     __func__, rb->idstr, offset, length, ret);
     }
 #else
     ret = -ENOSYS;
     error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
-                 __func__, rb->idstr, start, length, ret);
+                 __func__, rb->idstr, offset, length, ret);
 #endif
 
     return ret;
-- 
2.51.0


