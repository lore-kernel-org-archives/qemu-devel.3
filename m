Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DEC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVr8-0003II-4v; Fri, 21 Mar 2025 02:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoU-0008D5-Ui; Fri, 21 Mar 2025 02:25:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoN-000325-OE; Fri, 21 Mar 2025 02:24:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso30596635ad.2; 
 Thu, 20 Mar 2025 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538292; x=1743143092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEL/F7R455u00adVFhFI6UsyhKk0acwI0gMRQ2k9pMY=;
 b=KTiNX0xVbRU7YxzOjb+UP5C4Q4g+c2F/QFzW9sUmIlmO5f7R3BHlbjIBX1ywLOKkk/
 bHhuqNbc9WbqKFzFFFrv41gvVpL94eeKX7glJhc/wdEyOoPIm1r5RFR00yKmcJNlXlnQ
 J1Bv5W36xm/48SVspjDfly03hwWoaLZ6iNbchyyrGq1X8duCAWQ6D6GX7Qt3GeoYVDFk
 2USai7ls4/XfMyqHORcneSHOkS6v/HdKqpM6fmGjnzVcGdqsf3i2CWXwt/QQaHSoEKUV
 K2WApeh/lPj4fyimLj1Msk7UTWgqhcl1VpY8g4uGIsTqX3sU8vpsUCJ5ZKp3IrFRbv89
 peXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538292; x=1743143092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEL/F7R455u00adVFhFI6UsyhKk0acwI0gMRQ2k9pMY=;
 b=d+rgI2qBtNwMbwSekGPDcw7V+7FFJA7wiQcG7eDse1zfRqSzKFUvj3v1RMxJcJvxRm
 enyEjo7XkvAMnQPEyLbA9oNZb9MYkC546+abCYHpT7B9H/V0QEYi4HCG24d4MrVvlxzd
 xH8aJcCRcW72RCam0nfWfnajhEtqhmXOdf+OHPjVZApmCgWlMPHLPfL5DKE0hyCu40PC
 YLDuUQUiL4yTXhLz76v6gi97KhamKzOYhrYIF2uLej8b7SlzSIgQ1qqmwylRwTLt94ef
 rXAM7cFwxA2esC1qntA1MwHOKLaBUs5QADWX8tBrZsxyJYqDta9NIBidDNAcRYVzd3Xl
 YmLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhXUDDEJLCtxwUM83VZcwFmVOAAx0Z2NxpNVjiIhSpCY7um7pVNKzB7RSO3Uv1ALnbdKcO1APdlw==@nongnu.org
X-Gm-Message-State: AOJu0YwmBJrmTvPodkMB3WHVpYes9LTo3h8xvgbLHt1xkFKGr4FfsEl5
 0V06I7Unofk/O77MMWIm82a6KlLxWl3cHOoITWh/BOJ1H27KrAVqikIHpw==
X-Gm-Gg: ASbGnctaBPxOZxEzX8A/P3JzRR66TjdwWUMi6BjF5UJjzfDUFQiPFvfE6Z7WFsRR8+N
 3a1YUVud02mHjPgYnhvSyznLMB+6uJ6pKMceD93cjXXX4hMaZe25lylEoAwZsZ2HCDknbj20uwh
 T2McOY7mzi7/jcGqkDuLReTi/bGlb6CpZRHQeFi5TJbGYoIg15pL9w5HyzCO+ojSyfAq6Z4CKbK
 stIHRNp6rMyGlppSUBThaWQccrIgBcT9d6OfsRvWnPY8/zNtGkoPCDftas+q5EWhCmXzrFsgDAc
 zS3ji4zKKvCGqX/WMJ/Itm5evKGe4I0DU0rbMN+ecxb+i08K/g==
X-Google-Smtp-Source: AGHT+IHHS5uWJZUEiUIitUEsV9d7FN+nW+c8WQ9i0lPXIKIA1w77HQqHU30Qw209Y0xUCZtwKVL/rQ==
X-Received: by 2002:a05:6a20:431c:b0:1f5:81bc:c72e with SMTP id
 adf61e73a8af0-1fe4300ff4fmr3546559637.33.1742538291680; 
 Thu, 20 Mar 2025 23:24:51 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 08/12] ppc/amigaone: Check blk_pwrite return value
Date: Fri, 21 Mar 2025 16:24:12 +1000
Message-ID: <20250321062421.116129-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Coverity reported that return value of blk_pwrite() maybe should not
be ignored. We can't do much if this happens other than report an
error but let's do that to silence this report.

Resolves: Coverity CID 1593725
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 483512125f..5d787c3059 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t *p = memory_region_get_ram_ptr(&s->mr);
 
     p[addr] = val;
-    if (s->blk) {
-        blk_pwrite(s->blk, addr, 1, &val, 0);
+    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
+        error_report("%s: could not write %s", __func__, blk_name(s->blk));
     }
 }
 
@@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Error **errp)
         *c = cpu_to_be32(CRC32_DEFAULT_ENV);
         /* Also copies terminating \0 as env is terminated by \0\0 */
         memcpy(p + 4, default_env, sizeof(default_env));
-        if (s->blk) {
-            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
+        if (s->blk &&
+            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0) < 0
+           ) {
+            error_report("%s: could not write %s", __func__, blk_name(s->blk));
         }
         return;
     }
     if (*c == 0) {
         *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
-        if (s->blk) {
-            blk_pwrite(s->blk, 0, 4, p, 0);
+        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
+            error_report("%s: could not write %s", __func__, blk_name(s->blk));
         }
     }
     if (be32_to_cpu(*c) != crc) {
-- 
2.47.1


