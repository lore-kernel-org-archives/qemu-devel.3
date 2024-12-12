Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E18E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGk-0004Bw-8s; Thu, 12 Dec 2024 04:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGi-00049l-FP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:00 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGd-0008RJ-Nv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:00 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so296547a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994834; x=1734599634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTdRLETnDJrohYBMUvZokfWyJ2vN454iXatV/Zh1U68=;
 b=YbF0RUeTlIjf4ASFKzHTuQgiXhv29/SJdxDRMDbMAORph6WHZ08sZA/JJPBzHaHd3r
 1scnP/fAA5J/23f/n3ua4juEGno3ZEUmZkkSSmLlfMGSyd45BpMp0Pbyty1pq5XNZTrL
 rKmo0aHhiMMD6xUWpBLQOuJ2EPvuKK9VIaLfmbRQY85dgbB0/Z8RLTa61IxdsZuTsPkK
 uZnR7LXLLJq5WlDpWGaoVYUmsgI7x8zH+K6FVbSs0b65klN3h5fU5qX+yy3XPQo6Yqpi
 k0QkZ963x0vG042IAsO+I7xil1bPlSF0g5VY6iFWMFXr32BoPS8uM7DOY6c3F9tjsvAW
 4osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994834; x=1734599634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTdRLETnDJrohYBMUvZokfWyJ2vN454iXatV/Zh1U68=;
 b=wLK/00Np5XQczATfiiTy999t2hc8qyOqmxP2rul3t2rD47z330I77PJdjDOmyzOMU2
 FD4+qSAkRAubtEEWnfP2CzRTieAaBvxAPUbfLBEa7B0yZqBQEa20RWqAf4+j0or3iX91
 efT/e1JZ9UXX6Bh36y/u13paI/Lpa2+U9Ia3VrCAcTo5BJ+f/jvNz4jKwoDVgMg5W8wx
 v7BL5+u1TEwelj0VKVoIhY4C28QsdVM88C9r71hTa+x76u9Yv1voa4XOITP1Tby2h2J+
 XIMWmJBqmAuIjuWhHcoXy+DujA0qVm41Xzrd5BtDQvuk9ZMFgfWkvTJ4EPt0ZQM4gL9p
 9tVQ==
X-Gm-Message-State: AOJu0YyX26a6O41zDijJIYGor8sKwErnlJylEBin4GONgoGGvZcpqWp1
 ruyZApULgY9y7CJat9867eDaE0MbPijar1MTrulCoSXzHHOW0eXZ7snuYQ==
X-Gm-Gg: ASbGncveg+rAuDltcL1VHvtgBZWcjLE6sbC+j2BuMgg0h8lVBCgm1NWhZIM23Ouc0e/
 4L/zUvDn0s7b9Y3kEOIUEobEQbmwdrzCPfWlYqO2MMX8bU9sQth0/VnlqGJhyGwXaakwgtBxnER
 8R9CYsJAcT3MfuNG3tYrM5UAZB7bdUnjAKksNAALktYxjaiUoaxRggGXtikCufPNg/wDBrZBcDu
 fgOs7qaSAL1uBKI+NoxEN4R0h+YnJYsSPJUaSJdLTpghyB0Uh3Rc2a4pIY=
X-Google-Smtp-Source: AGHT+IFVOJuRD7FHgGvirzgcMQ4JSI7ykWjx2o5xjq5fMLTgQ+BFboEdlT6hhn+FL1a5IWDvzZb/tA==
X-Received: by 2002:a17:90b:2ec8:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2f127fea997mr8744289a91.19.1733994833926; 
 Thu, 12 Dec 2024 01:13:53 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 06/11] usb/msd: Allow CBW packet size greater than 31
Date: Thu, 12 Dec 2024 19:13:17 +1000
Message-ID: <20241212091323.1442995-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The CBW structure is 31 bytes, so CBW DATAOUT packets must be at least
31 bytes. QEMU enforces exactly 31 bytes, but this is inconsistent with
how it handles CSW packets (where it allows greater than or equal to 13
bytes) despite wording in the spec[*] being similar for both packet
types: "shall end as a short packet with exactly 31 bytes transferred".

  [*] USB MSD Bulk-Only Transport 1.0

For consistency, and on the principle of being tolerant in accepting
input, relax the CBW size check.

Alternatively, both checks could be tightened to exact. Or a message
could be printed warning of possible guest error if size is not exact,
but still accept the packets.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index af9eb7ea8a5..064bb700cbc 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -400,7 +400,7 @@ static bool try_get_valid_cbw(USBPacket *p, struct usb_msd_cbw *cbw)
 {
     uint32_t sig;
 
-    if (p->iov.size != 31) {
+    if (p->iov.size < 31) {
         qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %ld\n",
                                        p->iov.size);
         return false;
-- 
2.45.2


