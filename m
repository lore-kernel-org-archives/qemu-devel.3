Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED81AC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJo-0000eL-3N; Thu, 03 Apr 2025 19:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJm-0000e4-6b
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJk-0000Sf-K5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so14686495e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724190; x=1744328990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PyUW7pUGtdQFg0mGJcdbddKSlIReGI4v2OUa97+DAA=;
 b=Z1bFKRhr5xqV6wahMD8DNZ0ADvgVz5oocGYjYlhoQ/n94ZDS/RBkoPxvfwGMam+d9V
 Xm5NMdALktSlg3sqUCgBvGPtsI0lvRXase8z/phT3mXtmu9ZekAF7sGI0qEF27TVVo+S
 xSlXauzlUKFbd1KUs1CJiX/3FvFXg8IVbGYmFpSZuf0PmTwXPNIH3db6Hd/mAz7Mv6KE
 4J+DLy5G++RKfYzgMaayy8qEgvwjB6vbTcbo/+xuB8xjossxeINI2T3L2+QjKoKeQQjg
 5+gOceXBvs2bR9PvYIbJMbok3ivjjncGCI5zw0dBeQRLKsvNSNoprktBSNDkP4pjeki5
 I7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724190; x=1744328990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PyUW7pUGtdQFg0mGJcdbddKSlIReGI4v2OUa97+DAA=;
 b=hqXRtBqq82phUzeH5xRwW2qw5zdEz88qAWvALg0t78tRLZdHrs1qX5NcVPDVetbSRh
 bDe9pj+BWC8w2xcyfYZnBiQN92/VB0FH520OvIQuiSKEjT0FXbx7h5wez5xelv8gbqwr
 48qscB885ranhfSvkb6Kcy2AvOzPu9uHufzEscMS4xkcnrfP3DriVu0TsD7sVX0niy49
 bZwlnAf4wnNvQrk2jx9kMisxyp/e9aqHWZTijaS7HJJuOXPRqhEVoNSmv1NLXAs0UTJc
 Hg7z2IOK12zPYRmma7Bs5xCZreZGCoxopUPoJijPmP+16GeFsVHZnsyxZIDZJ5dsslSr
 k8FA==
X-Gm-Message-State: AOJu0YwCLUi9jjajUjoBJO9LZqPIevQoutnXnEslxpN+nHGomX2eRTyx
 RK7YzYRU2FazSPqXVIVzQHN7qFD7AD0PtwogYP0Sq1RotH/B2aixUWJTZlF3u00qw8GjT7VAsB2
 s
X-Gm-Gg: ASbGncuPCYR75ayHaKmWdveXBG0Jkf+RHmCIIq1Q3qPgG06uShdVkbWA0FZp//5Rrip
 b5ADLMb97BmxTL0kPlbWNbr69iIEDqMUkMwMaWE2BjoxbLjA8848fLKLNLVKmziA0YaWUDgc7m3
 HH9yzG5jWcy/39j1KL28z32meRSVCK4rjdrTLp0P9Nsn2lQ4AfpTTQThETdD3PbAARVQg/Ni02+
 WERbB+42DygIV5dkzfr1PK7BklmoSSwEa4/gXW1s+doKrDxbVRChG4dAz2/RfDhrOMT8Lay4m55
 yGYKJdZZmzeyUlDn3/Fuiog1LT/0mjuaYHu9OXZaA2yR9MdrAPmgXr9w2RcaC4PGF7xj8YgZ3kV
 pcUodygHokzGiZUn/ffc=
X-Google-Smtp-Source: AGHT+IHM9D9L28psTSkzvUhTw9HfoNOBAz0mGzP1zV24uzdFTZ2kPAAVNnZhqi/vrKI5xGBeI11+DA==
X-Received: by 2002:a05:6000:2211:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-39c2e610f88mr4782528f8f.8.1743724190564; 
 Thu, 03 Apr 2025 16:49:50 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663046sm34887965e9.13.2025.04.03.16.49.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 05/19] qemu: Introduce target_long_bits()
Date: Fri,  4 Apr 2025 01:49:00 +0200
Message-ID: <20250403234914.9154-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
---
 include/qemu/target_info-impl.h | 3 +++
 include/qemu/target_info.h      | 2 ++
 target_info-stub.c              | 1 +
 target_info.c                   | 5 +++++
 4 files changed, 11 insertions(+)

diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index 14566e4a913..8fa585f8138 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -27,6 +27,9 @@ struct BinaryTargetInfo {
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
 
+    /* runtime equivalent of TARGET_LONG_BITS definition */
+    unsigned long_bits;
+
 };
 
 #endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index e84f16d1034..66c43b329cc 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -32,4 +32,6 @@ SysEmuTarget target_system_arch(void);
  */
 bool target_words_bigendian(void);
 
+unsigned target_long_bits(void);
+
 #endif
diff --git a/target_info-stub.c b/target_info-stub.c
index c1a15f5cc12..a5374caed6c 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -16,6 +16,7 @@ static const BinaryTargetInfo target_info_stub = {
     .name = TARGET_NAME,
     .system_arch = -1,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
+    .long_bits = TARGET_LONG_BITS,
 };
 
 const BinaryTargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index 22796dda543..2fd32931e13 100644
--- a/target_info.c
+++ b/target_info.c
@@ -36,3 +36,8 @@ bool target_words_bigendian(void)
 {
     return target_info()->endianness == ENDIAN_MODE_BIG;
 }
+
+unsigned target_long_bits(void)
+{
+    return target_info()->long_bits;
+}
-- 
2.47.1


