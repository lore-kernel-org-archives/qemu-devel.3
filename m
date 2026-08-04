Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB62C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKma-0007Ad-PQ; Tue, 04 Aug 2026 15:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmY-00079f-Cu
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmW-000572-Kn
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXadFxbNPeUF1U0eYN9ts7zWvNYvwxNB1dgDghPB4oc=;
 b=OnamBx/tLYMzIFcrFJ2BEdHp70Cqsyo2KpumdS1O/UgqXWcwbIiDTD0C38DltzjYab//le
 PzxQB82w9QBSDY6v3CwQjpmsssDCh52Kr4FuyyZLatDteCo6t0a6yBKLEQj83ipOYO3Zzk
 6JLV1jc4kphIv+PpKPCFhl6tfwkb1RU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-sfh2VBYmON-4ksDE6Y1IzA-1; Tue,
 04 Aug 2026 15:26:29 -0400
X-MC-Unique: sfh2VBYmON-4ksDE6Y1IzA-1
X-Mimecast-MFC-AGG-ID: sfh2VBYmON-4ksDE6Y1IzA_1785871589
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB611195608B
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2026 19:26:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6626424; Tue,  4 Aug 2026 19:26:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:49 +0400
Subject: [GIT PULL v2 2/9] hw/display/vga: fix panning_buf OOB after
 text/graphics switch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-2-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E7/JuJnX61sx5FrqxASrVT+wu20t+91TLiJoppvHx8w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzTrUxvQztNJk8Fv2ytdDcM2VhsrL/qEqM9A
 Yy8DiayNQiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI80wAKCRDa6OEJdZac
 5YJFD/4jRYlJCRp3Clw+CSACTpnZSDdnube3K4/w232+Lz5E2TrqpLw18gv5MK/UFX6Lv0V7fWv
 rlLvPqI1PBZjmwS4hxCufhveVxnZYj2jYXZkBuTTZKSqaFg3JKe3MZgnRy2rTcLAlJn9kRvnBzl
 DAMdWTsf6jCDlDu3Twh4s9ZY1httRojlu/O7bdAg6VfvAKL8KlUSzOsv2oWvhpEYNPApkZoNjFZ
 l7WF1Mk87k6QwQpfrI1ETe6Hv3V0w7DIB8hE63u2vvDMZIeZZQ/botLhbckLCGxxRQTALBTEQG4
 /okYa5D9WqG7Eg172Y20jBjXB2nQfYSTQR6wfRX16ADydjffuYSgV9a9e2l398/welWt8ILd2M5
 WmHesCQjfWYUw4LKXNBsNDjXkFdve8fbkmCOCNvUqMgOuCyXIb0cyucx2ELIyojcZuO93/eVP5o
 aTlFYYhVhgc/ZjOy36j8imhYXgU5adnKkC/FML0Zc3WtrjeoXNHk4RHFVjDLog1kdzeElb2NMh+
 LH3YewZ/5vrNUBFN8mA/lYX3udVyb2Lkz1HOq6Xl96sBiYkV5xE2NAeFeL4iIu1epdp3ZXDso+Y
 NCWSiL1FYjebKV1nkDoRNrVtN89inzSRC9Eq1f9slguPMmUP1Mvm6UI6yySld32K013Nr/mwfwS
 BEm0i278gBW/tYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The fields last_width and last_height serve two purposes: the text
renderer counts in characters, the graphics renderer in pixels.
panning_buf reallocation is guarded by geometry-change check, so the
unit mismatch can trick it into thinking nothing changed when the
resolution actually grew.

A guest can trigger this by switching graphics -> text -> graphics:

  1. Enter graphics mode with a small width (CR01=0x00, 8 pixels).
     The predicate fires and panning_buf is allocated for that width.

  2. Switch to text mode with a large width (CR01=0xFF, 256 chars).
     The text renderer stores 256 into last_width. The text path
     never touches panning_buf.

  3. Switch back to graphics with a width that happens to equal 256
     in pixels (CR01=0x1F, 32*8 = 256). The predicate sees
     256 == 256 and skips the realloc. With horizontal pel panning
     enabled, vga_draw_line4() then writes a full 256-pixel scanline
     into the buffer still sized for 8 pixels -- a 960-byte heap
     overflow on every scanline, every refresh.

Fix it by reallocating unconditionally panning_buf on
vga_draw_graphic().

Fixes: CVE-2026-17516
Fixes: 973a724eb006 ("vga: implement horizontal pel panning in graphics modes")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4085
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Warisjeet Singh <sinxx198@gmail.com>
[ Marc- André - drop realloc() resize condition & commit message ]
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
---
 hw/display/vga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index abe3f8e07758..da0c331486eb 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1647,11 +1647,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->last_line_offset = s->params.line_offset;
         s->last_depth = depth;
         s->last_byteswap = byteswap;
-        /* 16 extra pixels are needed for double-width planar modes.  */
-        s->panning_buf = g_realloc(s->panning_buf,
-                                   (disp_width + 16) * sizeof(uint32_t));
         full_update = 1;
     }
+
+    /* 16 extra pixels are needed for double-width planar modes. */
+    s->panning_buf = g_realloc(s->panning_buf,
+                               (disp_width + 16) * sizeof(uint32_t));
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
         && !surface_is_allocated(surface)) {
         /* base address changed (page flip) -> shared display surfaces

-- 
2.55.0


