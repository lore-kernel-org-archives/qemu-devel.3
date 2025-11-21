Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65C7CFC52A
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 11:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd1Q-0000uZ-Jr; Fri, 21 Nov 2025 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcW9-0001KM-Ey
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:34:25 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcU7-0001cx-RE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:34:22 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso4574629a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763775118; x=1764379918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3j2FTpR0aj6OQBGpq/AXoTS1vEHZTJrzZrKRCUXjeU=;
 b=TVpWcMmEyRxHrgXHmlWBN2SHXbdBCDwAaOM33r8ft81XtOf0e1Y8EYQEXRQtCDdKVj
 v4tWtGXntxMKUSR08KwjNJVU1PF7inmNKLQOqahY6PDinm4omBIjJHVWLGoPMCJzUhLy
 flgwuk6runvuwLmoTH49Zre50anfhfym2aVjrnUNv/PMfIstNEBzSF5caMEh8lv+i34g
 77duwyuSOFd+nGDrqfZ7MfUYkptRwHkoIZJ2PogONXWKB14/UpixujRfECw59+KOOyis
 bhKwVbfTpJUfwwI0FuxfSdnmownJTdRsO5xSANPgJdJYjG97+hJYo3HPPT6ZPeluqjIh
 7z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763775118; x=1764379918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3j2FTpR0aj6OQBGpq/AXoTS1vEHZTJrzZrKRCUXjeU=;
 b=KzEjByvLiI68hX288JK8REQze/7SXpFcX/JdcMXp/aWlU5fDOqMlAH7W6Admh4NVim
 wssdfIZ72PshgwL9SSU1/S6mcJ4nIJhQn7AeF+kv0J9KvvEETFImVohGEo96ASwVmeus
 1qYQeiNI9gn6ngBmg4r1nyGUQU45qSNb7Y76cjqyV7cIYZtW6ZnnOjOp3RkRKWp9bxlq
 0vppYOr37QK0T/aqbCRN2fc2PLhZGr4DBAB3Gtzo58PsIJngtYg39+6ekIm449zHYy9K
 NwUUImmdigPVDvtOKeFFursQuEKtyTTsN0BtgNE5j3bIbTkvZGez6S6CStaER9yn4mGe
 M9Vw==
X-Gm-Message-State: AOJu0YxUNDVQKvgMzb/cmnE/ulKXsptkgpQsjzvpDyx+PgQ10UvTdEem
 5EP6X8i2cOZ7fU9cpbvKWsoDyinZyb2ugMmWd2UisLs5FSfU/SkwC+ioyrAAotfAdisIxi3Slm5
 8ISga2CFl5g==
X-Gm-Gg: ASbGnctjRl7I/zykP/R1uSRlvwTRd8buVQ4r37QJb7u2zP8tikkJGjPVpzJTsilUu3W
 KYvkBhN5NetMi+dAXLKqHyKe4lCUZOznC1epyedZ2so0MB5YLSWywWV0VbSHWh3NpKWJd5Zfh+a
 XuaT2ib2CQi4u2ViCuJf4l5ipfh1oSNXcc+sg8by9a6TmqluSGBtcOCVp+w5Gj00x+ZaF/05S7v
 WjuW6hih8tLZMv73BfS6GVh3ASUcBVEo2u0EvDSohaTmJYdZ6zsNWG3E/A3Mkj8CSQSKx2P0Jth
 JLPcgGiYrRdiDvbfjgkKqklZbDLpW6JDOGLSPJJuuBwZMjqrgtGI7X9gDGg2RASm5qO3ClIjEY/
 MLiypOD3DtwC8fVmPE3KpaMMHa2VwrMzJwB9d7N0UgEPb2jItUARtKNZmOhbLfv94ZmHkH1vall
 21aiFBHl4uSMMDWp0L+ZE/W1qOD166Ub8vd33atEC98Lc4JAlX2rgdysj7gb0P
X-Google-Smtp-Source: AGHT+IHpvm5n0pXcwmuEu2SPCCvHmpMRTUrtjIsejteUgK9JQ67Eb0yeRu5feXOzOqB6uzvh7RRxOA==
X-Received: by 2002:a05:600c:3b01:b0:477:54cd:200a with SMTP id
 5b1f17b1804b1-477c110325dmr19164615e9.6.1763732718198; 
 Fri, 21 Nov 2025 05:45:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb91f4sm11225263f8f.31.2025.11.21.05.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 02/21] target/alpha: Use little-endian variant
 of cpu_ldl_code()
Date: Fri, 21 Nov 2025 14:44:44 +0100
Message-ID: <20251121134503.30914-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Alpha instructions are always stored in little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..d04d086b59d 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -30,7 +30,7 @@ static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retadd
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_le_code(env, pc);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.51.0


