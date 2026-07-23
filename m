Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F28C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRU-00023z-Cp; Thu, 23 Jul 2026 03:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRE-0001xE-Dn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRC-00042G-Vt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso202452f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790105; x=1785394905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82OS8GpNlBq/fjmhNi5hkKVwto7VKi4nd2Pa4nJKAqk=;
 b=DkrUJzl6jZHX6zDRqdXnqxDj8hoTgoK/v1ouwKImXiVC6dAVk+81dlTIf36GivyJrM
 BGGMNPDImsL8TvMJQBOPEEPrwrnO016UDgnLtfFKULNzp0YRm/Y+EjhqoGFRXt5U+32D
 jww1OGU240xApxYR7Her1Dd/+iQOQLcUXAACO08NmcZ2DYpPlBGXMu51gfh+JYlm1Den
 Qs9VywC4yvFQ9V0dve77gwp325w0NyrLfmMe715fBTMWthlTkjbVYTJBmj02bmW+xWGs
 v/fjJgxWBYZ5soY69nH7Yxpx7uOp3LNDVycNg1ehTzh/R1wIJ93J5kPCzFswXYsuxZv9
 KPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790105; x=1785394905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82OS8GpNlBq/fjmhNi5hkKVwto7VKi4nd2Pa4nJKAqk=;
 b=l5N5ffqIpY9EIcQy2QKun3Gc+TL8Kpp9XjPXbpcRR9sGBWeempXDjakiHrn7w2sV1l
 LPJQrBe8mOXTwbskeagSc31zOO5XcV/tATc9vl+5KCBNa7//qRoLQ/3ywmQo8N0+6omZ
 pbm+fzMxruG5hO6eptGAWp4lOrNPtaQQY/TB5vB4SO0HYB44zEwLstaJg8MydmF2kbg2
 p0Hz0hgSl08fSt4iEawpcElzkkj9H1vfL36blVDUr9fgB7L6Du+1jA5wIbNvmHiJz+fO
 nmpIz4uggO1NbEOGgJNeO6XmWoRwHG3MfwtJn1vsbriyh239wn1n6LRDZcIUHLN70DOE
 2log==
X-Gm-Message-State: AOJu0YwJ8mrILTbvgml337sDYfS36jjuBNRsQ45eybJwipltKjPRfCFL
 OLQL/Q4CLdUHuk7IGt/4RgbHODDF9/sk7WUyvEejHV2m/Z4WBfP5oX/mrrISoA==
X-Gm-Gg: AR+sD11cRXPVp3yuZZT999GkwubcSnZ7/oWLC7VLQq2XPzdTswU5olTpg4UMZFiWeOJ
 7P3RgU8z12rRej9OYcYTHfwYmFdLALiICOUGzxR5uu6oii3JOrI2f+FD0LLxoZZch0wOSj1Mfsa
 kNPOD1MZCEP+jMSJHgKM32rLfaZmsQF928t61+STGwqyduyJEUSw8xF/RLqqptzShEbGGAG5sXt
 MmFtIoe4md9LTZmxpI7Owdi8xrHImym4gzhDVQDjd3zbPurCrhUO3BtwVRsY8PiAJW7RqfV/xzV
 VPhkTBBjc0FBIPGNGFt4Udckvl+a5cpCXrlRCbqGyVfytGoVOIttDEHlrVdpiCY/VpMRiCgEydF
 mJaisF02/YhXy0Ukyxx/UN7y7cd725YN42oEXxoH7w6laIllQzzlJRWFpCIws+BI4ALEpTcT4DM
 eIYiVLRWCubDtYEIiCMfpwYTzGQAlTrpsX8YVYWFiiJMYqLVl0YAqNbmGRH48aqTwFMP+lzsYd7
 qGQhjzvVIDVVhYZFr+NW3ZIbwi78nDDTQl+
X-Received: by 2002:a05:6000:25e8:b0:47f:9235:4366 with SMTP id
 ffacd0b85a97d-47f923543bfmr533824f8f.49.1784790104959; 
 Thu, 23 Jul 2026 00:01:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/9] hw/net/flexcan: Drop unused RX FIFO register overlay
Date: Thu, 23 Jul 2026 09:00:52 +0200
Message-ID: <20260723070059.6332-3-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
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

Remove the unused `FlexcanRegsRXFifo` union view now that FIFO accesses
use the underlying `mbs[]` array directly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/flexcan.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 32de7b904a..d8159475e0 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -35,16 +35,6 @@ typedef struct FlexcanRegsMessageBuffer {
     uint32_t data[2];
 } FlexcanRegsMessageBuffer;
 
-/* RX FIFO view of message buffer registers */
-typedef struct FlexcanRegsRXFifo {
-    /* 6 message buffer deep queue, queue back first */
-    FlexcanRegsMessageBuffer mb_back;
-    FlexcanRegsMessageBuffer mbs_queue[FLEXCAN_FIFO_DEPTH - 1];
-
-    /* number of filter elements active depends on ctrl2 | FLEXCAN_CTRL2_RFFN */
-    uint32_t                 filter_table_els[128];
-} FlexcanRegsRXFifo;
-
 /* FlexCAN register in hw layout */
 typedef struct FlexcanRegs {
     uint32_t mcr;                /* 0x00 */
@@ -78,7 +68,6 @@ typedef struct FlexcanRegs {
     union {                      /* 0x80 - not affected by soft reset */
         uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COUNT];
         FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
-        FlexcanRegsRXFifo fifo;
     };
     uint32_t _reserved4[256];    /* 0x480 */
     uint32_t rximr[64];          /* 0x880 - not affected by soft reset */
-- 
2.55.0


