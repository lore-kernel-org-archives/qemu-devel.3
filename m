Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB4FC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Nd-0001qt-Qm; Fri, 11 Apr 2025 04:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nb-0001qI-SP
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Na-0004hG-0R
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227914acd20so23172645ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358686; x=1744963486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psVuI87MgixikN4jJgvMHXBIVk6lAWoIadR2oAOKt7g=;
 b=CNVDP8mhdqtVZ0lva0BZ0mAZIz5BK/i/3QCnyW7Ext/Y7iXRb2hvYuSpbsxHi7Aiqq
 GTmd87I9/4e5rU5EMH/u75ZO1FJVOPNj/QqwZEwaCGXzyTQRdOX5MJwzfMRaDE9+v6pC
 ZFcjMR/GEBDdywFIljOnicgJ3ApUWWUvos+qjbwKHpmcpieXuJdfSwpx5NGOOQu9rMkc
 80qBeFA+g8na45QjEc+7HJXfLBKDngkjz7XsNK9ymbu9Esb2NOkeVy3+X2nCruSHyo45
 mePLEiXPQEfnRlTiKR+PO9UurDmJf3bx9NdWGERPK4/88bKRioMvdFFhjfJvcGzVhsEd
 5itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358686; x=1744963486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psVuI87MgixikN4jJgvMHXBIVk6lAWoIadR2oAOKt7g=;
 b=Ga7k7EM5Cx02wxodFa0Go0ZU6eUQTh1SJbg5UYe2Q3WvxaJl6vj1prJH6f0bR8uC4e
 jkl/h2MEQDwVR7RcT1rdfYMB1pM91JMjpqdrCK3PUJunkDsr76OXaqhA5Lk/lvidJEqu
 ilZyEmel4eshM0GCIDyDNDO/simtuuBe7wJ3XBmcbY7pdMeDF5m9mMQSg33B4tV61/PN
 gDhpcremwEKUBZQ/bHid8TRqM/rynGpDzCNuqamaTeBueRqhVFv1qHEt3JkLlqHS3eTy
 zZpRI2f+pb0/NPCsnDFUAkXTVpIwZ4QzrOyJ0GolkfgSr1y4TELYnnVb9KujwHjb/msK
 KzLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/xXMaFCuUYdPNjiA54QBhxrpdofn5ooSaE7PKzfSaHZFT7cfw8wYeNdlhokpmavZBa/JyS6FCSsRB@nongnu.org
X-Gm-Message-State: AOJu0YyYX16xqHnoU9C0VJjwbUz6Gp4Em1p8vuFd0GrPLN0xe3hoYic5
 ovyKE/g/2q8+7FhqHX0O+EAkOm+J1l1sqYQqXUc3uTs+usq+VTWP9Arfsg==
X-Gm-Gg: ASbGnctZ5glGpRnGwNnMVkTEouHdJNi7sMVa8wc/GZMmtOby3hmXqiYWNKAzf+NaZS8
 DA3yG0x4K7Qu11CgG2brVOcd61GmtpwvjSH6aF+GCK3bPGfIJAxdTrMxaxjKesdx+D4ASYObj7G
 1W9x4rQhc+BiwChoHHILYFI/5ByO5HWvh1goE1FBmBdF69sTRU6WMWYM6SPqkkGuUwdbCdQ68fL
 5XC/3LaFzjFAt8uw6imxllx3eFZYnp113gd2V3bERKD2JeqYya9p49AlLoPUTyXVyBzBGPVFAFu
 tEDiBOAveIl+HV4ut2XEWhfJGxzt7FDC8CHdffqYgTvFl8MRYT/uSVI=
X-Google-Smtp-Source: AGHT+IGTXYGBAk18Sb+hSZW48HB59IcquXvNkHfuGHeatNl6zmKx/fucqK29GOa/9e0lsdLRWhX+DQ==
X-Received: by 2002:a17:902:d481:b0:221:8568:c00f with SMTP id
 d9443c01a7336-22b578460ffmr84413765ad.0.1744358686177; 
 Fri, 11 Apr 2025 01:04:46 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 03/10] usb/msd: Improved handling of mass storage reset
Date: Fri, 11 Apr 2025 18:04:24 +1000
Message-ID: <20250411080431.207579-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

The mass storage reset request handling does not reset in-flight
SCSI requests or USB MSD packets. Implement this by calling the
device reset handler which should take care of everything.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 87c22476f6b..c7c36ac80fa 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -359,7 +359,7 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
         /* Class specific requests.  */
     case ClassInterfaceOutRequest | MassStorageReset:
         /* Reset state ready for the next CBW.  */
-        s->mode = USB_MSDM_CBW;
+        usb_msd_handle_reset(dev);
         break;
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
-- 
2.47.1


