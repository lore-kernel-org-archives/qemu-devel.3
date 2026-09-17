Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E034CC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kI-0003HX-2U; Thu, 17 Sep 2026 00:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ji-0003AD-Ey
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:39 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jg-0006mS-PN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:38 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso270408b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619315; x=1790224115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KX6XGJ4AOkJ24EhPP+/XN2jDu4BLnork27FHB+bK6+E=;
 b=HA6m72q29ioUwKIKrf36s5n8DSoP0RR38V5dRTCHsSZki6GN4MKv3u62KetZAqSS7d
 EINhwVY0joDLZbOVon6hgNzHBLyI6YM1XHwJz7T2iammgobap4jxm8zRfrdtrqo6ZMT/
 FBE+b8nknk+5ZYH4sC9JW9r02BWz3BUXJihHG0EwrMsAYkkRR7Tjn8tjsedrid2jQBg2
 ieS/FvS7J6EXFkcmTYPwJi/HgmxemKjNVzIhZnDOMpWc0U4cK9YRbiV1z28spTShoPTF
 /UEjC7XgE0EUkv9d8W6NdkOf1yg30SQ52OMYP2t9AChWhyuazwN/UYYcS39RYyIU41Ey
 VHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619315; x=1790224115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KX6XGJ4AOkJ24EhPP+/XN2jDu4BLnork27FHB+bK6+E=;
 b=Cb6JY5znlp4bjy05OXa9NO/BxDUT7IIu8Ih2I/BXm3XcKY6dfpndS+r+3mCzqK16cS
 zVYxwBoFU/D3cDR9jT0Jy0slUpe6DSqYq/FiVPy/px4mmI8EDJM0kEjrwvQe2lTiAdWn
 2MeTEUCcg70kPQ1fib31PE85OEPjcazOCZgzTRqWZm0t7J/0yp8QRmgW7LOlvc/qSuMC
 gQ1G7enQaWDzqPeWUEx5DaBAD9+VEA8wyl8uLDKaeHncR3HmpCWXDXLABOM562wv/ff8
 k7cTAp4p4/tMhWQV5rJ5rReAP2USoimcJ2uLV2qIZ1BRP4xinHPKdlC28uAm8YvMDNyU
 bvgg==
X-Gm-Message-State: AFuF++llLCDjU42bhtyzUxAGMPjfHKDml2RZMgsc86j2d+v+5xdU2+Uz
 0ZiP1JiQHHvsqSJ0yPX/aau1n02XgBzkQYhVPXIqScnZ++65fY+oPkfo6ke0Pi9qMk0XMJ8APZH
 ZAPVcbzM=
X-Gm-Gg: AYBFou2VHeUmwxpWw+R3y2+K9CCZb6FUTEXRhvxZaSCRtOdk/HbNWJ1uC8N+ewDPVn+
 eOFWCxsm55IjNG1iPYRxSX3wp8zXrAp3RcrdJU4PJzAM9InC3+A4dH/FixWOakwf6QQFvYb/xzM
 vadveXNh5S2I85DhAvAO4BkTww1CbxM/AsmRGCSBBTOfS9vlo1Z7TZIsmTdHIQSkkKC8ILdqGRJ
 sws5sMwAhcIp9C7qlH2VAkoAEd/Dm1ECnOEMNfPLrzx5E1RjWZcykA2P086WC+Oh3yIdB2QIeHD
 vLs5zP0u/ElPiAdMvJhQvSdFpFc3igPsV7501UWrjHiZMVSklIUJyIApvgpB8MLWYGZksdLapQs
 /EB8u1BMyMCyhTfoL0LSnRAWrXHcjt5DWW0+yqCk0QvgpDELyaAo1b4mRJdLCYAzhvAY3wNp0gQ
 KI8t8hb3qmEgZv94RHOwIaZyAL4eJHUKkREzp5c4OJLKSb0vXtfyP4Ql4oGsZOmN2NnEqFO8Z+t
 YwkoUc=
X-Received: by 2002:a05:6300:8086:b0:3dd:659e:5db2 with SMTP id
 adf61e73a8af0-3dd659e5f49mr9880429637.16.1789619315204; 
 Wed, 16 Sep 2026 21:28:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 008/101] tcg: Prepare for easy temp lifetimes
Date: Wed, 16 Sep 2026 18:26:50 -1000
Message-ID: <20260917042823.542588-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-temp-internal.h | 2 ++
 tcg/tcg-internal.h              | 5 +++++
 tcg/tcg.c                       | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 98f91e68b70..932ad1aeebe 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,6 +31,8 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(TCGTemp, tcg_temp_free_internal)
+
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 void tcg_temp_free_i128(TCGv_i128 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2620c23b448..d480d10878c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -74,6 +74,11 @@ bool tcg_target_has_memory_bswap(MemOp memop);
 
 QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
+static inline TCGTemp *tcg_temp_new_ebb(TCGType type)
+{
+    return tcg_temp_new_internal(type, TEMP_EBB);
+}
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 489df0e7386..38e5928ccf9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2202,6 +2202,10 @@ void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
 
+    if (ts == NULL) {
+        return;
+    }
+
     switch (ts->kind) {
     case TEMP_CONST:
     case TEMP_TB:
-- 
2.53.0


