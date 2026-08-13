Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D0BC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauj-0008Mk-Fl; Thu, 13 Aug 2026 15:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuauf-0008Kd-3J
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:25 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuauc-0002w1-P4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso113700f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648581; x=1787253381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hXoCQSjkb1YT/aVngRd+8tQQ1QHaF51bKobunk1FA7w=;
 b=hWp57WzyDlrnAZmWYYP4u6BLLsQVR+DXbgQu6fTxykaKhtPMhvGg5pvPhQ+Vg6FmVf
 G2u0Bj2XYjHyx6SAcSrvVyG0XkKrgbIfMR5VZd6kYCxToBIjq5UxJMOxkc3wofPlsFXw
 RZrLtuYVxygQuYPAs8DN0oReIavbYjExmRKlSBgrXGcpkIWDq6oOTP7CbdvZyhJM/61R
 FA/IuBPuakGFoWTOKWEorZ+WZaoMcxAg0M+Vf3Ao+hpGb6uvgFa3JRhFqOtT+eYLyCd7
 y73WuxntxrcDqNgQkQJziCV6DXMl8DOWrMUGJJaG+yxpIruJlEXBFFIdXtV+ePcEu1ZT
 fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648581; x=1787253381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hXoCQSjkb1YT/aVngRd+8tQQ1QHaF51bKobunk1FA7w=;
 b=N6EveqdSb0LFVHgw8huD9SWKbe8aYcw53LcTBvvCIl3zuV3R9VEPmf40XcnsRB5HJr
 zdcVgx5NIN7ZmR+jO1P5ccdXtK6Lgnzi6yKYZdJhRqPHd9LkgYh7spe/MTNDuu5Pxm4Y
 HM1dPrMPnhmPnCRuNd1WR4KflhKTS/x/BC3UTcAcU3gMQ8W/ytR9FFp8+KKl0CH31u46
 8THT6fGifcEp/tH0YJeXohXGByUC6Cqja3Fgw2gQcYqOkh+Vn7AfVzROi3GZgYO143lv
 CXiv5qZ+68ckGFZPzrEu6MqaHhxk3wTezRckO97d7FPO78MG1nGuC9rI7QEWOU9ZXALX
 ogew==
X-Gm-Message-State: AOJu0YzcpCh9lkwiYwBVLw1ExmGY0+aMlQxCcl+QA7M5lxn+VJ2hFMHv
 XSwYEmE5b47vrtWxFQk+Q+ns0e5Bn0IjQuhrjd1gyQLsabT79ZczYUCzXkHa5EpWyhCMlJT/FlP
 +APuY
X-Gm-Gg: AR+sD13pwpJVkrflCUdnyaRr526I8UhpeIQkp/cuQM15JC6mSjUUhyOl0+2uQ028k+2
 OxSVVivbnQwA2/2ffKLY9Q+R+84wozpAu9OJjCOl4MRufUGTtIjBgUUjqjyPVNv0tuWRZdXVrZY
 zRrq6JicDuSd28bK2cGDhSvQTyRe+zem4J4NDYI3VyUjTPNT3XRq+Sk+XgRBTCNO3tc8GuON1dM
 N8Pu7lkoWfhPV99fhTksFmuHuEfR0uQ4ZkIBfU/DXVoQ7MQJuUdHiKUWb+Hd9wu9nJC0mBP3MsU
 Wb9x5lyF+ExW8PXd3eKDTxgSLha2IINiJlkAAcXUt+WTK4Vq3cJg2vvAuubVTB4G6po71HsdOJy
 XFThf7y3Zfi/DqEfa1h8yR6zjtNKut/C3yI1qSApgrWBIugAtFlQNDJee5J0WdgV0HoYoC1ffCk
 d8v7dlsBFXug2uSeYkuDLuaGXt018602KsPXiynQ939NebFgPvyWLnB1lXvHL69kCXMojS
X-Received: by 2002:a05:6000:40de:b0:47f:83ee:e56f with SMTP id
 ffacd0b85a97d-48160748fb9mr609925f8f.18.1786648580954; 
 Thu, 13 Aug 2026 12:16:20 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:19 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 4/7] tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
Date: Thu, 13 Aug 2026 21:16:09 +0200
Message-ID: <20260813191613.2323728-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
References: <20260813191613.2323728-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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

ahci_exec() always builds ATAPI commands with a 2048-byte logical
sector size, so it cannot drive a READ CD that returns full 2352-byte
raw sectors. Add an atapi_raw option that sets the READ CD
field-selector to 0xf8 and the command's sector size to 2352 before
the transfer is sized, so the derived block count stays correct while
the buffer and byte counts cover the raw sectors.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqos/ahci.c | 5 +++++
 tests/qtest/libqos/ahci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 0621a6c477..e3019a1eca 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -707,6 +707,11 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->atapi) {
         uint16_t bcl = opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE;
         cmd = ahci_atapi_command_create(op, bcl, opts->atapi_dma);
+        if (opts->atapi_raw) {
+            /* request full 2352-byte raw sectors; sector_size must match */
+            cmd->atapi_cmd[9] = 0xf8;
+            cmd->sector_size = ATAPI_RAW_SECTOR_SIZE;
+        }
     } else {
         cmd = ahci_command_create(op);
     }
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557..2a48a7523d 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -242,6 +242,7 @@
 
 #define AHCI_SECTOR_SIZE                (512)
 #define ATAPI_SECTOR_SIZE              (2048)
+#define ATAPI_RAW_SECTOR_SIZE          (2352)
 
 #define AHCI_SIGNATURE_CDROM     (0xeb140101)
 #define AHCI_SIGNATURE_DISK      (0x00000101)
@@ -485,6 +486,7 @@ typedef struct AHCIOpts {
     uint64_t buffer;    /* Pointer to source or destination guest buffer */
     bool atapi;         /* ATAPI command? */
     bool atapi_dma;     /* Use DMA for ATAPI? */
+    bool atapi_raw;     /* READ CD returning 2352-byte raw sectors */
     bool error;
     int (*pre_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
     int (*mid_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
-- 
2.53.0


