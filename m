Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7R-0003Y9-P4; Thu, 09 Oct 2025 16:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7Q-0003Y1-8W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7O-0007Xb-9O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso9728825e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041204; x=1760646004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5taEFfNlZIf1jW2b7rRm+kFHCwi7mn2fstWZzQZPPRI=;
 b=B9G96eAaLa7z0/Q6rQIq5iijwKDXbtk1F/1zZ2S+h0d2xzH+jsoJFkHMvE4JJ3INI2
 KxqxJsfP7fxHThuW+6sTS5WXW1WD4GDa1bzViIVCA7HanAwrqWBVDxInbjdUeVWwoe9P
 q0M1iqvjMK+gNhjF5qwkCVvOAFCYARQVGtVtpyBlJ+8Tx1q3yK65R3p5f4psd4Bnup+F
 8iyTtOsoZxJhZGO9qApGwsiRMZamLl7/HcDmqwVdiIQ6IZQX1Gyj5c4INJ/fuCtrtn8d
 OxWFJm4fkWihlI2me1yQeXhphpFJu3bFL3ffmIro6FjP9hciIwpe/WvTsPzRkCFK/ljr
 WIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041204; x=1760646004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5taEFfNlZIf1jW2b7rRm+kFHCwi7mn2fstWZzQZPPRI=;
 b=IfYAsO6jrcotmSSBCIMF18ApJEZqibJWiD1NFMHSpoI4gRf+BlPnK0uf/FnKkGkXSi
 EygIhTmU8qAUatJfqO18qjmm+37vQCDldVd9Wlr8vqYaSIaL3XuhplZxbJ+mqs40j/29
 5PwuQffrkxUg43XLRl0m/E9L2ZNOL5oBAMvDndVWe9q10VhAxYEC6s/22heWEyfvLjs4
 2AyJuxX0Kb21KGQ5nUcTPocaCxnPX2awuDeKXdH5azkQJi12cODEv4zDVoaTVRCLNNoP
 L9sizf38Og8ihbHxsSe2EO7dCzKcf7lI0esT1nt92/yII0Yd/XPwjVStKRj0CYFd/VCh
 uQYw==
X-Gm-Message-State: AOJu0YzNsOfBpVIm++oab4I9bzlGYGhZadxy6ujZBWdjyV3B2532WThN
 IrxXKXHQ0mDLhyuzWQ0Y7PviOrYDgkrP4QtNQ+BwrWwMa3zpUlC1v28GRwxSUC7wgeO8QvkxINU
 f1/V1KwYBWg==
X-Gm-Gg: ASbGncuiWgSZf2/zHjWb+Qww/mv0Xx9g49yRQaRwMoWL5hC6aQauQoTGGx9lPSljw5F
 ADg3ODfJqwWpI+hHnj53edWY4foI+WqxBg4Dd9ASbsL6M1LbqN7AsODCRO14hYtd2qbzaNV06m5
 eLiHANEiF1CpTylg2qzKxR/Yc+66vA/8k79CK5umEn4UGAu814K0yaYMdaADrvBJBLioGijP96V
 6jwFZKx+Ja4ujJ12xR4eCVp9XX0lA3FNMlc+n4U6Y35pcu++zR5XmfgWoJQqzRVVdER22DOCBIA
 9ec/kO4uQyLSObe4QDquVts2VH44t2YnezLq0FxKBTr/6hhe/DGcIpY28GeDL5w1943IudXxnUM
 fJF7sMBuSMkMGT0M/BDoU4xZP/NNkcVHzozkgKTzMNqpecTGFQMppZYxP8SA/rvCl4+BLpcLLty
 g/aJoqt9hTCvMJ3m/Lf/KbgsFQ
X-Google-Smtp-Source: AGHT+IFsZQI9dlazXhah+K6A7Hv/DnTKE6rzf/TxvmciZG19epA+whX3S7hXKnFtcsNizuWRTwcZ3w==
X-Received: by 2002:a05:600c:3b11:b0:46e:59aa:cd51 with SMTP id
 5b1f17b1804b1-46fa9a86409mr67555985e9.6.1760041203955; 
 Thu, 09 Oct 2025 13:20:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab500706sm44668595e9.3.2025.10.09.13.20.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:20:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/loongarch: Remove target_ulong use in
 gdb_write_register handler
Date: Thu,  9 Oct 2025 22:19:45 +0200
Message-ID: <20251009201947.34643-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009201947.34643-1-philmd@linaro.org>
References: <20251009201947.34643-1-philmd@linaro.org>
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

ldq_le_p() returns a uint64_t type, big enough to also hold
ldl_le_p() return value. If we were building for a 32-bit
LoongArch target, ldq_le_p() would not fit in target_ulong.
Better stick to plain uint64_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 471eda28c73..23a5eecc20b 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -62,7 +62,7 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPULoongArchState *env = cpu_env(cs);
-    target_ulong tmp;
+    uint64_t tmp;
     int length = 0;
 
     if (n < 0 || n > 34) {
-- 
2.51.0


