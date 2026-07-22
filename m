Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24533C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRZ7-0005jN-6H; Wed, 22 Jul 2026 03:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYn-0005QS-U1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYm-0000g9-0v
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784706007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUjOgvWag5AckSEQEnJFl8yvK03F4OrpZff1DyUEVGY=;
 b=OOnaEUU/UePZcdmupGT69uIqrdJ7MEodA7WLKe9PwKOT1rvLPGnJIbxyfv+jkI4UCbiMKj
 YMAJKIXZ/ValcVYXXfhwK3sc2HUCqhufkVtZZ/VEGhAFJkHGbstClU+To0umUCDderzrly
 A1Qk3iCwiP2VF7bMA8jDv8d6ZZP01d8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-jEb4IYgSPBGMWNiMB0exmw-1; Wed, 22 Jul 2026 03:40:05 -0400
X-MC-Unique: jEb4IYgSPBGMWNiMB0exmw-1
X-Mimecast-MFC-AGG-ID: jEb4IYgSPBGMWNiMB0exmw_1784706005
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso96688115e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784706005; x=1785310805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SUjOgvWag5AckSEQEnJFl8yvK03F4OrpZff1DyUEVGY=;
 b=Gws0voPSK0iH5nJSRrbB0saQOkdC8NZLY0wfMVaAsvflL9Btez4gVl4vV76fwlXDNa
 Cxb5BOOh73mbgIq0GhEhmdAe3TqaJjuxrIooYuVjccVpj8AQaDS1Jran2TDwglr6ZT7X
 USne3BTawBN+ykAvUpvOWM2tn3bax93oAyRPKoDukmONlh1wFMqowoR89Za3ZnVB4fa/
 rfXYM1PzTMPA6cXpnQb1N27SQWcVa20wJz1iY+fHRbBfBEh2nd4waCTMMLumFzxId32a
 tTwekKMD1qd0vudk29+zaeLGS0XQhJsmIa6O8D+seHqXECMnWQVRewW0CwMAJ3qGIuvj
 x7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706005; x=1785310805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SUjOgvWag5AckSEQEnJFl8yvK03F4OrpZff1DyUEVGY=;
 b=E8M7ILoQC1fg5zZ9oT34spLZNcF4Sk+KXXK+CK4RS+M0VpKIXrdOrnTYLbI+awzqVe
 rZnpc6UwjibujgNwbCYXMQ6EWhBMDnbzHdP2utwUrurr8nTcsIT+28Hr3aWg/y746/+D
 pDep7DZ3/qO2lp+LYnZOJW8UBDjkoAWJCc5Xd2+0sjfpHL4RizQ5jwnhwDvLwuH2l55+
 t/Y0RMJ3AqFUv8/kOqIylTh7GkA6I1d8I8tRawkKnKo0V/DQi0ToNu+pNlLbZSJXqdAD
 C2dO6Ry0Mfob5YTjCJxuhc7kZCb/nIdtqLRCaleLtr140dVh7lyNnodLMOiqj/EZtcSa
 H04Q==
X-Gm-Message-State: AOJu0YwMRvMaCAqtJmNg8xmugHVi8dU/vj3MTObzM2T9bs4LwdLK5WMb
 8gQswXsM2IbN0toMEingDTMfD8AZg5D1rjyACS4HAk4lmvzGmzREvWGaeIZ1K2SZ72peiykgmi1
 0Jq3u8aS7exYpYFiPH5iE3lwxIoQnWugFkI1/8ryf+GwWRSZ4tcgoU83ivjhCPBdktzgqnL+4qC
 bvllCKqBWv9Z3avVgBNPY5BnGC9fat9p0pks78X2QB
X-Gm-Gg: AR+sD11HWdroWwS1CSw9AgwcjDRoe36cBCygNlArfMClvsATxkyia8ZDgKvASUX5jN2
 X09ztgmqcBL+xuUSjlPlEzz2xvPiH1j2tQFPp44zkMeykmp08PG1AX/YpTZ7/vMhkA6OND/18/U
 uzIhVM1Tw0tZVPK8GYLk4nuRuWlzbCAm1iaIcIt1mQySJQ36WPCmkaCdc7g3HyxXD0a6U0vXR4W
 +r05NrhNuHAU0lZLzDHyg39n2xvwT4owFjJKDn0w6GOiYcvPVK5dtBXSowhzyyjU/XvEKa7hIYm
 viMdKsLO8wbBo5b6Lo0xLQMbibPxz9YQ0eaNFy9szub4KVxXrMX9/10kRepOBA0BboHGsUfOATg
 xFMbE9TIUPr4d+VMMciNGoUneiLPZ3W1FN75i3GQjRPXAFBsY64CBS/03hXGxShABKyFrQNM4Ez
 KM0TzZ
X-Received: by 2002:a05:600c:c178:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4954a40481dmr201488235e9.19.1784706004673; 
 Wed, 22 Jul 2026 00:40:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c178:b0:493:e46e:157d with SMTP id
 5b1f17b1804b1-4954a40481dmr201487875e9.19.1784706004188; 
 Wed, 22 Jul 2026 00:40:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b030a64sm32609385e9.3.2026.07.22.00.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:40:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 4/5] scsi-disk: protect against guest sending truncated data
 for MODE SELECT commands
Date: Wed, 22 Jul 2026 09:39:42 +0200
Message-ID: <20260722073943.396872-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073943.396872-1-pbonzini@redhat.com>
References: <20260722073943.396872-1-pbonzini@redhat.com>
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
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


