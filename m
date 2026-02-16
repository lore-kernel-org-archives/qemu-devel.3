Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8390E83839
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6CB-0000Ji-U6; Mon, 16 Feb 2026 16:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bs-0007Pi-SQ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bp-0003xq-BT
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48375f10628so20541325e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277491; x=1771882291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqLUEfFp4yyvVrqD+DcLUkS33yg5lEUMmYhr1LZOcgw=;
 b=Vlfm57pGSoHFKM9CfDmUOHuG+XjNWUQMA5ZYu/2+WFdpK74oBk3uDcz3rpJ9Rg4/11
 vIArY6xpR6ZvCTA0tVWS7UUBeOQ3LS5dVudE0gFWWo1Y+AOUBCSIL91fuXqfhIRzQmR5
 qm4Q4IbHZaA3HMDW13X+oaliGKeMpfVQi34FA449uPMcsoC3FCiRsl1G0IliNSZwPE1w
 ffOY8qutTAl2e0I7mFPpgNZWoxzXIPAkHYfm06Vj8NUa4OCZdKCJiribxygWgPymAeEg
 O84EnOHRZRU3bYVAWJ+JEl99Cecv+hVj/qOONIQlrksHgJg3R1CKukxtREC4hmCcXFA5
 H68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277491; x=1771882291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqLUEfFp4yyvVrqD+DcLUkS33yg5lEUMmYhr1LZOcgw=;
 b=LLfDhYo3qhZWLKvmGrD10MbpkYlfyVTGktXNPr/qVmPy3JRmvu5oxHge1LP8QP4TRI
 b3OoCd8OIxXhqKL7L8DsRWFlhdrll011yTGUvEE9W5LdmwzufomqITBljiCSHdOgPiRd
 eQePLazYVpuwkH/D1Q3S4PTtB/4K8r6SC8ag9gQD5wN6/k+EgKVXCLMWAoVNsUvRJFHq
 SXL+b8nIJ+WBdI6Xbik7S4fVIScRTfl7EfGr6SmzX/2O8Ah0pH23aV1/nRDqj3kpNSst
 mgYho/TPp1mE2eFrUczE8Y7U6Uq2Do7L2NbTJodOfadVGvdTFFFpJhdj4jxBq9szH833
 ttJg==
X-Gm-Message-State: AOJu0YzxLysJTm3PxWqBy0ERkwogDho4JCd0DM2AJqxYhkWiEV0ZyU5I
 y8FpcbOM1wN0+TErOtZ1hMN3QRIZG9iRXgSCKcKlayLe9bfB6NUpWUufzOnBLzeYw/Cz1bYOHjW
 2xfzRYIg=
X-Gm-Gg: AZuq6aLIDkQy1gq0IKppTBZX8Al/mGgZwYwRwd7CUCdovEO0dfpXy3NUUR7i3XPcKy0
 zLD2szEQGs90GKBnX7YwgmfFvagisDk4C0IDY3H+UtjxUo1E0/xgyIDuym6Ghr8CgEziqD+8YSP
 OmhzkXEz4WkL+7SPmSZmTGDjyknW3D/PYBZVcqDc21ESe9WpshGDNNRsU8oI2R/jne1Vv7ZceEb
 bFSa0xZkA2sfUq3A19D2G7AgKXR+btLl8madgq0TUOmeY96NLkuO+hiUe5phjTkEctsRMQNcyKM
 vpd2FB0+y6fm0uB0qXZFOxxBEEhkqdMG0xgqSlqfIZMVwIugCynjXlYmook7eSSMSrfuxxOFIj3
 1j2tmtvXqhcoUGKuo2+5h0nCowUjHnB5wZLx1wXnOULK74wVjm1wMNMeggPmLwr+W/C1QsddeiA
 FPIMR6BV0/DhSGPxwRZF2+Fybgc1N9tFuZblMfwKp5oNBpobjZvIklBTa1pQqcfnXfK3w3TMRY
X-Received: by 2002:a5d:5d06:0:b0:437:6f0c:2ed with SMTP id
 ffacd0b85a97d-4379790f0a9mr20966358f8f.34.1771277491139; 
 Mon, 16 Feb 2026 13:31:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac92sm29582865f8f.1.2026.02.16.13.31.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] hw/display/macfb: Constify macfb_sense_table[] array
Date: Mon, 16 Feb 2026 22:31:14 +0100
Message-ID: <20260216213121.47122-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

macfb_sense_table[] is only read, never updated, so can be const.

Update the single call site, macfb_sense_read().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/macfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 388f8de5070..57ad8ad5587 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -82,7 +82,7 @@ typedef struct MacFbSense {
     uint8_t ext_sense;
 } MacFbSense;
 
-static MacFbSense macfb_sense_table[] = {
+static const MacFbSense macfb_sense_table[] = {
     { MACFB_DISPLAY_APPLE_21_COLOR, 0x0, 0 },
     { MACFB_DISPLAY_APPLE_PORTRAIT, 0x1, 0 },
     { MACFB_DISPLAY_APPLE_12_RGB, 0x2, 0 },
@@ -342,7 +342,7 @@ static void macfb_invalidate_display(void *opaque)
 
 static uint32_t macfb_sense_read(MacfbState *s)
 {
-    MacFbSense *macfb_sense;
+    const MacFbSense *macfb_sense;
     uint8_t sense;
 
     assert(s->type < ARRAY_SIZE(macfb_sense_table));
-- 
2.52.0


