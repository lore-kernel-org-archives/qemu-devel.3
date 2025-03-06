Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDU2-0002fs-6W; Thu, 06 Mar 2025 10:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTW-0000PV-3R
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTU-0006Nk-CA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso5247255e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276166; x=1741880966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4sVC2TkF7qXS2mJBLOLW8I7WhvYkgMOlFC0u4MR1LHM=;
 b=K242bB1oIISjIz9+JXTlU0cXLajRNBiCin4OCs03OcpuWRQEt2r2SDt0oGYFqq/sTz
 DlXG1Dw4Fry8BuxSs20aQ0aHq9arM9ETflT9HddZ7/G84BtxAyIxV5gC3mDWBsmwN1oi
 6Ad+PGwcsxzH5YuQnL44rHEbN1Zl2KXccXNEjyW9HEs3uSeAydGhkCkTivhsS7RAHAa/
 13ESwZguvIvSJdUaYUxfKAFfDGTBY4DjZrAEiteROecPbD0fTrcgL4uTjoNk2Uead8bO
 F+CHjmnDCQASI8JZSa1ONOoNKpVDQ4m4UBIM7Js7Q7/pfRHMBvUZoh8rvZtOLWNJCLF2
 ZV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276166; x=1741880966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sVC2TkF7qXS2mJBLOLW8I7WhvYkgMOlFC0u4MR1LHM=;
 b=fMw1CuFnREL3fpEA36VZx153fRlqmd3fbmn/6Cu26eoT/yoL5jO2dBo/94E9zBunef
 rDEU57gIxafwYfRiOlBMe2xARozfPXZ3m2FnvF7SdasafaZ6qL0k60ZnZ/eJkBA0APHN
 X++EJTBEdWWKujWgtQ556dtFnCeexl1GwwmW9rYcT8I5eaIfxLEZutnq3SJUAWRnnEs2
 qgka0KWGBIqbKPsres5T5WXse+EhG3uSKfkSW+EgO+EV1Z2dtVIR+3tGJEBk071Hb8Hj
 sejQ9TTeoMbpEVapB2Kg69t+2IZ68oLOtvpqM4u0VoR7DN48amvTjdPN9NuAHtQ+kf+W
 xUcw==
X-Gm-Message-State: AOJu0YxygTAMF6lFStjfY5qRjoZZSiH4ZuMUL0KxPciIjWI2nshXBbNX
 Moz8UMVMGEyw3vQ8q3mNH9w+HDUSMFbJ8HqtSJlBsag+MWGNyHOd02Ls+TcmEUSGCBVoNs/a3CB
 zwVQ=
X-Gm-Gg: ASbGnctZEzXmQFDUNEp8nhPZ9vvLr4hpkhmQyxxMer8t/1ucCWUm3YSRjIuF+lCqCbl
 CE1pOCzqPlSs9yMZToV4B3u9rISs71X4rMQnKkx97oAoG0TAepfDpWBvyR7qFFtdD3owoLy3oo4
 jfxwro3ARpFg1JRKRbT7VJTTqAGV7sm7IK1TXGtAVlhV9GWvy7B2X00HeMIpRJbMFpvxd2INlKC
 IXRHsDsubQnhJsZzuax7w9acgYWm5sgavIKrUPIhimTSrdtEwFJOC8PC/heUEG1aFKRhtNhjBQO
 hSP2z46Ip+DIeCekxhdWdXUGF7LVmeHRRJUL05oHB8zuVMvm2QF/mN38xWKV4Q/XB3osRAQfyro
 p49/jdz4TDbnyBQhSlqQ=
X-Google-Smtp-Source: AGHT+IFzOckwGf6F3uW5qNouQU2YB+VifASO7BcLY4YafZLNGmm8Gx9HEdiHqsnzTaRloCPrKHsFSQ==
X-Received: by 2002:a5d:6d87:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-3911f7260c5mr7376064f8f.3.1741276166357; 
 Thu, 06 Mar 2025 07:49:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b8bsm2419446f8f.64.2025.03.06.07.49.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/54] cpus: Restrict cpu_get_memory_mapping() to system
 emulation
Date: Thu,  6 Mar 2025 16:47:06 +0100
Message-ID: <20250306154737.70886-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121142341.17001-5-philmd@linaro.org>
---
 include/hw/core/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b6b22c431b..9dd6ac7c763 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -616,6 +616,8 @@ extern bool mttcg_enabled;
  */
 bool cpu_paging_enabled(const CPUState *cpu);
 
+#if !defined(CONFIG_USER_ONLY)
+
 /**
  * cpu_get_memory_mapping:
  * @cpu: The CPU whose memory mappings are to be obtained.
@@ -627,8 +629,6 @@ bool cpu_paging_enabled(const CPUState *cpu);
 bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
-#if !defined(CONFIG_USER_ONLY)
-
 /**
  * cpu_write_elf64_note:
  * @f: pointer to a function that writes memory to a file
-- 
2.47.1


