Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6841C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Z2-00080v-09; Wed, 02 Apr 2025 17:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yv-0007r5-Bn
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yt-00048q-Nv
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so1070755e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629030; x=1744233830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybuOT5iHPjheG8AHEncXZPqzQ8VYLAi18PseEWSYhQk=;
 b=jGouXdMzVvsyvwx7BWsODMlMPU8wO9j+TKIqDIUlPojXY2QLZ50NBw34TS4fKL/tUF
 4pCZzAr7+1iaZoN2UuSbYnd4LnP8iKlmZcTDjZGxhFFlE/fYosVht+N9UWsJuRLckONX
 S7yXHh/QIyNcu+Eh8pLuAzrbkBAN6ulg/RdgTxrka04jvNogMg9F/nTkRt+5wMTp3i6m
 8QTok3u425okiYVGlF5o4AFP8REFE7v1PcUwiKiZHWowEY8ia3QaD87Ni6O+l7WytghX
 J9egZKljUpptlCFLjSFFlhfmthoiulPahBWldVQE286ykZc0HrcnY/NC9fVRZPu/Tl6o
 wJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629030; x=1744233830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybuOT5iHPjheG8AHEncXZPqzQ8VYLAi18PseEWSYhQk=;
 b=ptRfVIqT/5SsBbaPMDjW/esa+faw5ggPkLNeLh8PIsBcmXHujRtPAqH9v31egkewRv
 fED6v6/Ti+HYSqF6Ozroa8iTrv1f2DlUWP98aNs/ajqKdbXtXuKhexXRuVGMGZllSyLD
 bhRV0ZyITyem1UxbgheGAwVksAfjEGZ4uXTezHNdiYe0HvxWGBA0fytnb5wnuNzl2fNc
 aExXu8yAJBnKQ8J/YAwELeYyGuy8MBGeKlOzBN4unvTyHeT+qFEol3MaYah8N3Y5nLFJ
 XvwxCOVyDTdY7WB/KkxhG23AP2M4Dpn44C4k46W0Hf21DXvXIAK5UhWMOhIX7yTs3Peo
 B1IQ==
X-Gm-Message-State: AOJu0Yx1uxARcUAVJdTY4oNNYBprh+1I2kLg1OJtry5/hlZC7SNEHd5w
 jn0j1fnWzcY0rTyL23c3uR6expdx8wA0fbBjbiJ+wKVul/hyAWo5VBXx4dEMAJbxdXuilkUMSGY
 n
X-Gm-Gg: ASbGncs8souGTU+CdkmhJHBYb4ZUhsA8uT2wJ5HeL50D8WWKVG5Ftg7733nJKIuOubt
 lQh51LT7xGi1IbtURg+PyMCJx2tJgJmzNskeGcd7f6VsLaHzpOLOuaTgjn3URWiUM9XODBBXb3m
 uwM9XSKg2eATPtJ09615rLxveUSOADXhla8SPzwHw6boMzc3PpkuFJo/oTitfWsjpj2OMcxjxRb
 +fcFFlQwv+3Bz+KsRLzEHAreTnUlyYjJvf6JM27gN89ATK+7zvxeeLFFowyqjDrYwAs+J1x3qqb
 QJlQzb8tK9RPaywGUD+Rev9/Q3Pk1X7qffNzjTrRxmUl604CFqpZEHaHXFvtiSCcEdZKLoNkvI6
 riU8e8SMDE36JUCfTK9o=
X-Google-Smtp-Source: AGHT+IHVfG/rksNDL3joam7CiKGW4gPRP1XKQBtOo5uLo/SI6f89Vs3R8DfEmOAkK5ryzMAPBNdx6w==
X-Received: by 2002:a05:600c:c86:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43db61d1becmr168787525e9.11.1743629029913; 
 Wed, 02 Apr 2025 14:23:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b1352sm2267875e9.37.2025.04.02.14.23.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 43/43] target/arm: Update comment around
 cpu_untagged_addr()
Date: Wed,  2 Apr 2025 23:23:19 +0200
Message-ID: <20250402212319.58349-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402212319.58349-1-philmd@linaro.org>
References: <20250402212319.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit f9ba56a03c2 ("user: Introduce 'user/guest-host.h' header")
cpu_untagged_addr() is only needed in "user/guest-host.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3705b34285b..88ed06987f3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3233,7 +3233,7 @@ extern const uint64_t pred_esz_masks[5];
  * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
  *
  * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ * include/user/guest-host.h, and not some place linux-user specific.
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-- 
2.47.1


