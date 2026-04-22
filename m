Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40BAFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmi-0005sG-MV; Wed, 22 Apr 2026 16:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmO-0004jd-UU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmK-0003SH-DM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488d2079582so69044835e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888146; x=1777492946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pGnenDifjZmzk41jK6DgouChFTKo2hRmu0GnXG1NcYs=;
 b=WD27lh2HevIww0OEyLa5om0jGcXZ64Va9czvRSW3veUzB4CpxRm9mr7kT/eoqxYpjA
 SA6P97xxh8Arcy8p0c5/mytjRFi96zGICAvzYKGPuVH33yv8LyKXNv/Jb+gt85L08izA
 yn5WHds3ZqDOlQYy2IiT+4Q+yMuwmEiaxFtRhnVnAu7ubly89esVRudwW8NQhHIIhGds
 TmCvcZ2fLHDIEQuwqN4nNVYw07TUf9ueH9YRYFPxckIDcIYdAfzxdqrsc7wsgTf1orMY
 tP/SMrRJXdOA1AvbnUo5ePM4NOvpeXRsRGX/gq4RjUYUZV++lqc8wgRDv2KVrVYqhWFk
 pvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888146; x=1777492946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pGnenDifjZmzk41jK6DgouChFTKo2hRmu0GnXG1NcYs=;
 b=rSiCqe8s6saV02/bkVVBxeFgJUguKA4s8GCjTsVI/E6KHhon21/EdC4E0HOEap2rt7
 ynO395T5GaHCxiJJ6S2yyCmsJ9oOlSJsGgKqJ6J3FOyCIC5ZBpVBXG5VzSpYw2SAPj3z
 3hFABC7oeZahjp9lploU1LRPfxYjA238WzSOIC68qKcRk8rp44lkXpIPjIxLpdTVxCbu
 2a/haELl1IPUfZGgeugqEYr5NCztsRKVgC3EeniYagIAwfB09x7opVW1MX/ZxnbakDfI
 wgq4WZ9Qb43aB/B3mZ+zZS7ntwwjOWaS/+OSN1KVYt3LRRCQUoPxxm4cNKvgpIEZa/5O
 yogw==
X-Gm-Message-State: AOJu0YwtvHt+cSpI/GuBY8ej3fv6l9Djm76UFszIE70lJ6i7Z8wSRwGw
 mbdueT7zS8QNrDJh/xAArcSgYoGbnehBnEFk7ywx52XKIwZdZgyNO5eTcpSoBPakEMmTYQ27XFU
 4d04+dq4=
X-Gm-Gg: AeBDiet3TaTJv0Uyf6QiS0E827ZogUKNQdKTkgIpAJXLD2MpJSAjSyEjIXKPUkHlNML
 Hw3a9DJ+GkTtNSnBntOeGbep7RkOUQzlOVUvoRbQHz4cYqIq9Q0DiPJ4yI0Oo5r+sTcCMGF48I7
 WMPcHS/NEgsafzS2lse1AIBq2DU+9zz4DHwog0Y/smkjqXQP0On5haX/w8yRMCe3oWxsnfOH8jW
 rChOxhjsyv5VKodbIDxcLk7X19/I+XORx6R/xx0MOt5QXcVK4gP+OnrnlgIzMcjL/B71l4YZt/p
 /uJgrLsIL9gl5pVF1FdAHPOKc7VcGvQs/Hk33tU6NgBOBt9vXrALSbz65xEkeyk3iikYKqeYLcz
 aXXVSF+NAJM+2jMOOb9EKgUHwZS3sF6II/00DhUp3l2KAiUWFLuVgLQ/eI+5Q9NIX6VkEB/9L+6
 la/dtPF0ZZiSRQUAhtsh3I+bMIDi0FsD7YQVQv5mSAOFprB6rFF2d3b9R4Ils6xWJ31ayUzCcSR
 jh1r2pEybM=
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-489e69686a7mr183865625e9.10.1776888146326; 
 Wed, 22 Apr 2026 13:02:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c318636sm267252785e9.7.2026.04.22.13.02.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/48] ati-vga: mask out lock bit from CUR_OFFSET in cursor
 offset calculation
Date: Wed, 22 Apr 2026 21:57:37 +0200
Message-ID: <20260422195746.88865-40-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Junjie Cao <junjie.cao@intel.com>

Bit 31 of CUR_OFFSET is the cursor lock bit, not part of the actual
cursor address (bits 26:4).  Although the callers already check for the
lock bit and return early, mask it out with 0x07fffff0 when computing
the cursor source offset so the calculation only uses the address bits.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260414213523.1125859-2-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0489995d00b..3a7d45a8820 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -147,7 +147,7 @@ static void ati_cursor_define(ATIVGAState *s)
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+    srcoff = (s->regs.cur_offset & 0x07fffff0) - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
     if (srcoff > s->vga.vram_size - 64 * 16) {
         return;
@@ -176,13 +176,15 @@ static void ati_cursor_invalidate(VGACommonState *vga)
     if (s->cursor_size != size ||
         vga->hw_cursor_x != s->regs.cur_hv_pos >> 16 ||
         vga->hw_cursor_y != (s->regs.cur_hv_pos & 0xffff) ||
-        s->cursor_offset != s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+        s->cursor_offset != (s->regs.cur_offset & 0x07fffff0) -
+        (s->regs.cur_hv_offs >> 16) -
         (s->regs.cur_hv_offs & 0xffff) * 16) {
         /* Remove old cursor then update and show new one if needed */
         vga_invalidate_scanlines(vga, vga->hw_cursor_y, vga->hw_cursor_y + 63);
         vga->hw_cursor_x = s->regs.cur_hv_pos >> 16;
         vga->hw_cursor_y = s->regs.cur_hv_pos & 0xffff;
-        s->cursor_offset = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+        s->cursor_offset = (s->regs.cur_offset & 0x07fffff0) -
+                           (s->regs.cur_hv_offs >> 16) -
                            (s->regs.cur_hv_offs & 0xffff) * 16;
         s->cursor_size = size;
         if (size) {
-- 
2.53.0


