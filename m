Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2A3C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D5L-0005Dt-Tq; Thu, 03 Sep 2026 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5J-0005D6-TQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5I-0001Y0-9t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4858303de5dso302323f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788463611; x=1789068411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/paBWoTU/+U3EiPt0qTWWxiaUQi+TbCN+6Q+i9Aj4sU=;
 b=TLv6s9ka4NvI4z4kaGBotyTojdqyz1tY80il11MFecY4B2XRc91Tns33fl8NQaNtky
 1P2Nz3xcv491UWCGKI5iAKT4JbscFfI/Dsfl4QRvJzKyvTU4VTmslQKfer5dvay1QgnN
 dUkMK/TAUDsG1o+c47/3pryNvsaUW+derqWZfLQe+fA/1XlcYs4xO0T/qXPUwxN6uFsB
 X8shmOCurNpmCquGG8nMk1DOjegbiGSZMIW/Ipu/xRTakXm12pPx8H94m8EdwBOZ2/6J
 GEba7GZKh4Hr5Ldpsdx4XOP4M6Bjk5/VChjrQ8LEqVk/KO+bcwcjbLp46jM/1zhDnOSy
 vraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463611; x=1789068411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/paBWoTU/+U3EiPt0qTWWxiaUQi+TbCN+6Q+i9Aj4sU=;
 b=RDeC5UBWwHLP+anQFx8nfWZc6waWXiLdcr/3h/XE/YXlfnk5wrZVqmArVtpPoMs890
 91+keIA/wZGh7rAU1bFaNyDH6MngWKLii724oyYSnf0xUtZBjpAkcl400Aa5+yFAzX05
 AvDCWqFZYXGdOJbtPEoCjL2dthl4Gnn+RXj4k27jKn5ZWUJYhWRpuAJ9jKnyYEMUJQ1a
 geE1+HSI8FhsMWHPiT+R9b0pme4bsTFYIPsWsYDq/fXxooKcvGje2cPvqoE8pNHwE6mA
 PjiBpQau/eOpBQXf8vxQeKPbVOBcVIxEYQxSzsnYyP3+9WngID7D8dkHAM+TOlBOJw/a
 sAiQ==
X-Gm-Message-State: AFuF++mc68+6kikRwJplCNqz2y9RRASsnmlQ2d6s21YgePsXBct9i6tg
 b5lbTQWmuPPl4CCRJVJ4pJQR/x5N0QzGJmkkMgRKVk9xjQTlO4bBfOPF6YBHND6CCDeNtEX0iAQ
 H8Ikk
X-Gm-Gg: AYBFou1DjiVdgyOdry+m1M44M+sxTLZb9PjNqf6eNMdlMuSjPSMKHckoH7W32CwbPTk
 zfpSr9rQJ6EzYvemUnMwpX9QM9+s+UHWeU2TnMvxsV7m1LYSYsWjTNnu8i+DFRRvSoY42H5syJy
 45am37yQJeN1cVK0JP590ICKqPPRPHNhslQfCdDRzeZxnwoaBJk98ToIC/akNAiPiGUGD5sM1V+
 vUSopDINRfcutnqwrKOUkH1CtH6jdTCCr869kfwz/Cp7Es38ekuRAONvqjwnb1SpZKkZlrcDdZx
 cJmMXGcxPnsIMEms2HU/WI27Q7jQ+6d5AbdcI1KXh1joYN0TQuK9flUN6Je+Uk6KFqiJTx1k/Yd
 5qx2AMpHhx1lzSAMI5kmpDtOtjHIPhnz7ZMb7KD3S82jfXjruvPvCvdOhKuSWTI212E1gqZ1LhI
 8DjHpg6B6RsNu+Hj1y5/zAx1L/0cS176JHx6fIsq95TtzI+lfclrZboygm
X-Received: by 2002:a05:6000:4694:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-4858703f92dmr2298462f8f.4.1788463610738; 
 Thu, 03 Sep 2026 12:26:50 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm663164f8f.36.2026.09.03.12.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:26:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] hw/display/qxl: hold ssd.lock while replacing ssd.cursor
Date: Thu,  3 Sep 2026 21:26:46 +0200
Message-ID: <20260903192647.2677279-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903192647.2677279-1-den@openvz.org>
References: <20260903192647.2677279-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

qxl_spice_reset_cursor() unrefs qxl->ssd.cursor and installs the hidden
cursor without holding qxl->ssd.lock. Every other writer of that field
takes it: qxl_render_cursor(), display_mouse_define() and
qemu_spice_cursor_refresh_bh().

The unlocked path runs on a vCPU thread, reached from ioport_write() on
QXL_IO_DESTROY_PRIMARY and QXL_IO_DESTROY_PRIMARY_ASYNC, and holds only
the BQL, which the SPICE display worker never takes. Unlike
qxl_hard_reset(), it leaves that worker running.
spice_qxl_reset_cursor() does round trip through the dispatcher, but the
worker is free again as soon as it returns, so it can enter
qxl_render_cursor() and unref the same QEMUCursor a few instructions
later. Both threads then drop one reference for what is a single
reference, freeing a cursor that another user still holds. The store to
ssd.cursor races the same way, and a guest that keeps this up also ends
up waiting forever in qxl_fence_wait().

A guest reaches this by switching QXL mode while it also updates the
pointer shape.

Fixes: 958c2bceba06 ("qxl: fix cursor reset")
Cc: qemu-stable@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/display/qxl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 384b8767b8..c4f547e88b 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -294,10 +294,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qemu_mutex_lock(&qxl->track_lock);
     qxl->guest_cursor = 0;
     qemu_mutex_unlock(&qxl->track_lock);
+    qemu_mutex_lock(&qxl->ssd.lock);
     if (qxl->ssd.cursor) {
         cursor_unref(qxl->ssd.cursor);
     }
     qxl->ssd.cursor = cursor_builtin_hidden();
+    qemu_mutex_unlock(&qxl->ssd.lock);
 }
 
 static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
-- 
2.53.0


