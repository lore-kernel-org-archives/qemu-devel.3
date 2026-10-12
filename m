Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC00ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGiA-0006En-Lb; Mon, 12 Oct 2026 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xGGhu-0006Ce-9f
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xGGhq-0006Xv-BL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791814124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4h7fXse9RVQRZxyK0yLlaCI7WbRxLw/1BbkPgxyQFvs=;
 b=LpuijEW7hp/HOzOEFmk9KgF6wz6maSv4sGfvw8n7as+UyOoFbW6VYuLeJLXG27JnGgsmIF
 peGI5jkHZuj2k+9xCoa0s4NPBPfru4eECnqkHin/YHMmNCDkj+qZHx991UffFoF0sskU5n
 g7cVIkMQXyQ4s4ldtykuktNHn6NtVT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-jycZrxLhOOOPNpbbwV_4bA-1; Mon, 12 Oct 2026 14:08:42 +0000
X-MC-Unique: jycZrxLhOOOPNpbbwV_4bA-1
X-Mimecast-MFC-AGG-ID: jycZrxLhOOOPNpbbwV_4bA_1791814121
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a19df2328cso13920485e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791814121; x=1792418921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4h7fXse9RVQRZxyK0yLlaCI7WbRxLw/1BbkPgxyQFvs=;
 b=LGvHZPuq00xmM715ndJfoSQJRk3DMYaoXGZ8UhawQ1ptEJZksJNJeFpSxGulGVU0Ad
 Pldh1Sv2oBMQkzDtykFRIg3sxwC5UMlIDNiXofbKfZKL8pLCbIk6Ju/Hw9mL9rdFF+QT
 PVqMfh1U2WeJQg7eykYOuEmnlhpLRgKq5SNhYnsQnxjhFTL8dbqlHYTtp2SH98hWvPVG
 YH6LzdKtrMp+ir85IvSV8+BZnomneVC+Vxr3VtFwOcUOGSYXnpDbW5eyUFcdiy2wrSmf
 9cLIfASNCdZ8lRBOdiPU/0+NSubirPUZATz4xJtQhxmFkjxUYmNff0mk+yT+OwLiyJrK
 uKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814121; x=1792418921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4h7fXse9RVQRZxyK0yLlaCI7WbRxLw/1BbkPgxyQFvs=;
 b=qXGseqtUJSE93TncW0urq8jiQ1EKoWHV1MmZ5d+TOkPwGxgqlJ7nDAn86UckarJlOP
 b01jcbLsoC09XKq7HwdD93bpCOkjy3dhj7pWS6oj+F3EE8u4uHa2OGwXKtwoi10xao6s
 Nzg5NbgWGNAbt24uEBHPmvUarxFiS4z5RnmhZGsQyk03mXQyagsAf0TonGAqyftaWQUn
 GzW+eTZoNa9fnWtwxEJ/LjZNg3s4rd0p+UTqEemjjiPq91I5d3LgKUZM33a96xRU3fC8
 WCOzTCDbqq3KVLzU/yFCo115azIFZifIcQ9WamHEmH2hZcO4iaQbMO7gF8zSfNsX6aDf
 0n0A==
X-Gm-Message-State: AFq9FYKS6bBxyS8QHsLoc9hXbQdf9g6ccDKbLq4lLmSCllG8v3KCYVPB
 mqfp6I2eM7sZ+NccDmAS9BvPEfzoc9elmHzldGSHXfCNS3XuvkYGCnnd+VAiEM8nlEaOKNtAIas
 vQ/wv/O07ajqU7m2kk9DGtZx2BIPVib6DEyRn1EN96f1CfZqUO/cYY1kK4RZsof4j2U1CTyBrUg
 WrOxch+csXO2mIn0qyA8nWh4jBtrh6QUPwH7ydDmlisg==
X-Gm-Gg: AYBFou0N4lzVdrnHqVwJrjWD+kZ50N3nOn3yX6Tw8HJ19uu7pFXI6DlpnSszQetD8bz
 V/DFogEhC8SWtxVjFuEbhyM72FWHTR0CxPkmdlHHuS43uU25K90LFr6fPQ0uPi+mFylGKYdyYb8
 QjWXC+lk3IGcAHTlHs6G9WKmMqC1cXtX46996436hXWsvW7nuOd+xZQUCcYeOXkZUTUgWAEJYIV
 vRuN8XwwUJJ4HRVHKXWXr8z+4nozdUWa++/9zVvrIsNXMRNfEs4lh+mgga52jBzTKQC73Bkr60G
 u7Pqt3QQ3AK60FA0y5kE9W0KgskpWVQsQGRZ1tWKrKerd2lpBNVLRO/AYhrnzjXauHMxIPzW
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id
 5b1f17b1804b1-4a18e4aca94mr175142265e9.12.1791814121053; 
 Mon, 12 Oct 2026 07:08:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id
 5b1f17b1804b1-4a18e4aca94mr175141615e9.12.1791814120520; 
 Mon, 12 Oct 2026 07:08:40 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm420181095e9.9.2026.10.12.07.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:08:40 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Tommaso Califano <tcalifano@redhat.com>
Subject: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
Date: Mon, 12 Oct 2026 16:08:38 +0200
Message-ID: <20261012140839.93559-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The EP_DATA_IN result path serializes the queued response as a 12
byte MTP container header followed by one 4 byte word per result
argument (12 + 4 * argc bytes).  The entry check at the top of the
function only verifies that the guest-provided transfer buffer holds
at least the 12 byte header.

If the queued result carries arguments, e.g. RES_SESSION_ALREADY_OPEN
which returns the existing session ID, the second usb_packet_copy()
writes past the end of the guest-declared buffer and trips the
p->actual_length + bytes <= iov->size assertion, aborting QEMU.  A
guest can control the transfer size freely, e.g. TBYTES in the qTD
of an EHCI BULK IN.

A device must not send more data than the initiator signaled it would
accept. Stall the transfer instead, and keep the result queued so that
a subsequent BULK IN with a sufficient buffer size delivers the full
response.

Fixes: 840a178c94db ("usb: mtp filesharing")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3386
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index c2d36a73cf..cbc2be3317 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1905,6 +1905,13 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
         } else if (s->result != NULL) {
             MTPControl *r = s->result;
             int length = sizeof(container) + r->argc * sizeof(uint32_t);
+
+            if (p->iov.size < length) {
+                trace_usb_mtp_stall(s->dev.addr,
+                                    "packet too small to send response");
+                p->status = USB_RET_STALL;
+                return;
+            }
             if (r->code == RES_OK) {
                 trace_usb_mtp_success(s->dev.addr, r->trans,
                                       (r->argc > 0) ? r->argv[0] : 0,
-- 
2.56.0


