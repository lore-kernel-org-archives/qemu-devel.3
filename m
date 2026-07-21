Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454C8C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDBd-0007c1-E5; Tue, 21 Jul 2026 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmDBa-0007OZ-CH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmDBW-0007Z2-Vd
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784650749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sxk79o48sVZ44ehC1RFZi7bdieBEB5DuNMUzHGcuWW4=;
 b=Byu687DdwvMPLBcpl9GkGnAwjVlucfEncNBtlY78mA+i/tjQ+vPylta6NbUMSyZiAQ4qIx
 Fe0HiaZfdNymiW8VxJ2pfZ/Xe4UbmV/1j+dDVMGoBupyc3f9HctnhAJW0PFAOShH2m1GCl
 HpeMTUr80GfHOyRt17P1JI7YaCsqOp0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-iPrWg_lzNFa8JzU-FughFw-1; Tue, 21 Jul 2026 12:19:07 -0400
X-MC-Unique: iPrWg_lzNFa8JzU-FughFw-1
X-Mimecast-MFC-AGG-ID: iPrWg_lzNFa8JzU-FughFw_1784650746
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955edc851aso12828805e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784650746; x=1785255546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxk79o48sVZ44ehC1RFZi7bdieBEB5DuNMUzHGcuWW4=;
 b=Y9dGD6eysyvApfMcwY5UQw19lxwg1ZMpGBw3lyONDSHmo9mPSmiOhR+kHe0JGjVxDc
 wDC+Q4FX0rwstGI+ADwcuIS/pF6RXxiIr7hEH556C4ejUuh8L+ON+aolGqPjPqqDkqCT
 z+MEv5MbchM4msDEe+dk+r3g6yfYt4JQdrEJuwJnuyDb4aFjksD9f7crULvyhZP7FZjx
 RrlMlzi9GhO6bfZ9BhfZdXFfU+rypbe18iYK6ICIYw3Z6TY4tOcr/x74xSGK/uVTF/is
 LAr7SuxcL8F7msvtT5yjknkkAGjhNrtJxP3GVa3/0A/0fVtiwuZbikNm/KZItsOsJSLt
 8R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784650746; x=1785255546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sxk79o48sVZ44ehC1RFZi7bdieBEB5DuNMUzHGcuWW4=;
 b=M2Hjty5KGIs4mjgjHgZ1X3D6p2eRs16jl8L3Kxg2EAPIBg+cLSregXavwZVhCnIWvV
 JhoggkRSGFWINqCgLlGiFh9KtAo1hSDEVju8mje6SWZFDdSXxUZV/3RJBhyJH/C1ZlG4
 U9Ujro40XrswaGPzxChn9AAqyKGVuSrUpwikIhQQuKhNS1GAF9yMQfyrBJoNgpThQ1JO
 0JqSea//hR4FZ0W8cYOL0uUHXczHVv6r6rIW1WrASj3Pgr7WI1aKLnWEm/7Pc7MDHl+1
 49m6P0klvI+Db6uH684yCkFTWE0WgF4BEhwWCc/PcTG4D+fO4PntjoIzSxfiLkXs8kpv
 y0kQ==
X-Gm-Message-State: AOJu0Yxtbq5btx03SDNlvMv8VU0+HUp1x8H0u+Z7GDsGWWsXOFMBcE1g
 VbFtzN6x9jQ5IlxalsA7qJEN1UG43j2Byj+DEtrmGx3PfwahvSRX6NJDUvNiIZw+KcFH9G2f8bF
 AZRoQsEN3hccE5ywN/lXPaJcAq1Zeblx2Ya3xfPsKUH4hFcD6IQjfXUFjE35CcI96qb0LTecasz
 osdC3kbBT+Sn8lH0goELCPbXEBOmWaTu/H3gr8NAck
X-Gm-Gg: AfdE7cnuL4LfJl/Z7MIvxrz0KRw39jZcncjpruYyKDT050D4fE/skQV69pRwrdLeaHu
 2o4S4vj3gi5R6UuaV3x4TGWK/Foi9+c2VkYfCoFWYnxQ3u81HzKwbKosd/dNFDO8QlyJo94ivaD
 LkTqi4z0ZI0IUOWeRTe/QaTwOf2iqMz5vyNqbdYgKYllUOC78J8yvPCtAy2UMmhiyMx2uo8gXNt
 B+h9sywWOatdX1Il95xvt46EPWsUU/tJckGC7jmzrzRvzknKR9Ze/Fe3SGEaOT6GjxSTX6GKf3Y
 Z5awQvYvQmirvrQZg+9RJwJHXrAcdNceB2fDZHtYZCzl0cWlyiEi/GJO3rMxN9x2lkeoyqIvWji
 8fxkCMyQ+xcAEHvXQz7l720B37DfBhEItZsmpWOTjlyj2Egv0zU9hRSop0q2sd+igdrd6dSxbzX
 royw==
X-Received: by 2002:a05:600c:350f:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4954a3db7e8mr217281025e9.11.1784650746341; 
 Tue, 21 Jul 2026 09:19:06 -0700 (PDT)
X-Received: by 2002:a05:600c:350f:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4954a3db7e8mr217280675e9.11.1784650745753; 
 Tue, 21 Jul 2026 09:19:05 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955df9d2f6sm140339165e9.4.2026.07.21.09.19.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:19:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scsi-disk: protect against guest sending truncated data for
 MODE SELECT commands
Date: Tue, 21 Jul 2026 18:19:04 +0200
Message-ID: <20260721161904.363367-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

scsi-disk has a MODE SELECT path where a truncated mode page can be
allowed by a compatibility quirk, but the parser continues to use the
page's declared length rather than the number of bytes actually remaining
in the request buffer.  This means that scsi_disk_check_mode_select() and
scsi_disk_apply_mode_select() can read beyond the valid part of inbuf[],
potentially up to the emulated age's length.

Clamping page_len (the size of the page) to len (whatever the
guest provided) ensures that scsi_disk_check_mode_select() and
scsi_disk_apply_mode_select() do not access anything beyond bounds;
however, this requires care to accept and handle truncated input in
those two functions.

In particular, until scsi_disk_check_mode_select()'s first call to
mode_sense_page() the number of bytes to be cleared in mode_current[] is
unknown, so zero it completely.  And for everything else, be conservative
and use len when providing inputs to other functions; but at the same time,
ensure all accesses to inbuf[] are bound by expected_len.

Note that pages longer than the emulated one are still rejected.

Fixes: 389e18eb9aa4 ("scsi-disk: add SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED quirk for Macintosh")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4051
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5ba5b46c4f4..85d0bd0b811 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1524,7 +1524,7 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
 static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
                                        uint8_t *inbuf, int inlen)
 {
-    uint8_t mode_current[SCSI_MAX_MODE_LEN];
+    uint8_t mode_current[SCSI_MAX_MODE_LEN] = { 0 };
     uint8_t mode_changeable[SCSI_MAX_MODE_LEN];
     uint8_t *p;
     int len, expected_len, changeable_len, i;
@@ -1543,21 +1543,21 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
     }
 
     p = mode_current;
-    memset(mode_current, 0, inlen + 2);
     len = mode_sense_page(s, page, &p, 0);
-    if (len < 0 || len != expected_len) {
+    /* The guest may send a truncated page, but not a longer one.  */
+    if (len < 0 || expected_len > len) {
         return -1;
     }
 
     p = mode_changeable;
-    memset(mode_changeable, 0, inlen + 2);
+    memset(mode_changeable, 0, len);
     changeable_len = mode_sense_page(s, page, &p, 1);
     assert(changeable_len == len);
 
     /* Check that unchangeable bits are the same as what MODE SENSE
      * would return.
      */
-    for (i = 2; i < len; i++) {
+    for (i = 2; i < expected_len; i++) {
         if (((mode_current[i] ^ inbuf[i - 2]) & ~mode_changeable[i]) != 0) {
             return -1;
         }
@@ -1565,11 +1565,15 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
     return 0;
 }
 
-static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page, uint8_t *p)
+/* Note p may be truncated, so check any bytes you access against len.  */
+static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page,
+                                        uint8_t *p, int len)
 {
     switch (page) {
     case MODE_PAGE_CACHING:
-        blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
+        if (len > 0) {
+            blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
+        }
         break;
 
     default:
@@ -1612,6 +1616,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
                 goto invalid_param_len;
             }
             trace_scsi_disk_mode_select_page_truncated(page, page_len, len);
+            page_len = len;
         }
 
         if (!change) {
@@ -1619,7 +1624,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
                 goto invalid_param;
             }
         } else {
-            scsi_disk_apply_mode_select(s, page, p);
+            scsi_disk_apply_mode_select(s, page, p, page_len);
         }
 
         p += page_len;
-- 
2.55.0


