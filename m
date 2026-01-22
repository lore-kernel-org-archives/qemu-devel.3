Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9217C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT8-0007ZF-Fp; Thu, 22 Jan 2026 03:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSr-0005oa-Jv
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:54 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSp-0005yf-N6
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:52 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43596062728so1165600f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072089; x=1769676889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ikk5xjEM37AxJt71VFUeJAiBGJNgWurWbV1DPAjfisQ=;
 b=Aq9DwMU/+7FtwP+YzeUK5gM5paZ4a+19AElfDdj+nw19QKnuGisv6GzRehmKOfisbf
 l175NDHS8h2TL+R/wsRLtW8p6+HO+/o1Fex/hFz17v5g8lpccJGBhgc5q1zrdXNKqFZe
 Kp6hEhnpoe6HC7K/5MZfOKJss9CF1kI5D6WTmFsjpDi/IJxQGMOE3H9bCKrBMJanfzBk
 QZyYGv8qJpdLzvJL8P4QhyUcnK4SSAv02/jg60C7cwVs2GS2I9eu+acRFvtsA80zoTlg
 mo1Mf14EAC2AiSTryr/VFJ7r5UGCgUbHIofGyFgW4QWqWDuZ69XEmr7XoQytVX653QCn
 o2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072089; x=1769676889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ikk5xjEM37AxJt71VFUeJAiBGJNgWurWbV1DPAjfisQ=;
 b=QQX2q+rPUrqa41I2iOCMeyXJI7nR1n3b04mKwgCS/IORQ08oc5A34ikjzQNkF+VBWK
 DOmAEatoUwsVZ1GziyQhPiyWgynTaWlPML05qEeuV7bu7nQOkJdVHZa6cSiQci9jChs0
 PihQ24HCQSJDga7jON4ORGLBTE4t+VqT8PdFmBrZr/Z/2CR9kNHQJ6RZVFSa7PIldQec
 0lXDpjFziBu0r4vhv+S0A2jBW6mril3umM6g63MM/TC38zGLfZJ9nyf3ZMaSkQ8QjLrh
 W33PG7cjN3hhYfljRSsvzM1HAN69+y5QXCjmjdtKH2XRBe+Dsyu3Us+KyvJvCXLzshjr
 w9xQ==
X-Gm-Message-State: AOJu0Yxrn4NFCBGk3cH2bMLk3FLJUUf8Nba7aVIRAggXvglb67RSEUb/
 wReZToZYtwarLZojUDehIrTfHSoEWTfFnhqNm91veZXrS0pVEfQe3eU5WKT33fKwh6XTMDodfnA
 q549A6OE=
X-Gm-Gg: AZuq6aJFG6pjSEmEkR1evg5/XyCGiAUjeLDj7e1DDz4N3zHfXqQsDdnPAPRYm0sVBUS
 5a4lfQxbwoKrb02v8N4TzuH2LV7NeO8YvU8v0kBH1P/b8i3O9S9rfeWUQNXTRUbNtY5HumpGTaA
 aotbvW8eFO6LCNh9/C8moJXSWx52Vl1tEEiwa1gcFHmQ5hVdyPI/MGQi10W6myCkavKqNsWFwIp
 njSiPvBIazVZjxHdKHqJmUMdUsCVACrG2x2IWWtuyURToMr+FOFfV11Ttz6KuwjJ29ABtiQqeSQ
 i3CgCdO/6rlwvzcbEFPqRxXV13OVpDqup6WoYmR7CUu7rFoE0GvYhXZvL+O9EkPnAuC0J9sU/9Q
 wMvSDxbwd0mL69ImNjHU3SMJj1QleezYvtIibFGe4Xzac1FH5gmmaGQ4+4hvEUYRN2c95Mwj226
 sh5jA6ipBWD2sdKt7WHGYcFkThfuQXXOaZYvuIHjTaaf2i1jmPsv6EUc5NbqiG
X-Received: by 2002:a05:6000:2887:b0:431:cf0:2e8b with SMTP id
 ffacd0b85a97d-435a5f93e6cmr4158772f8f.29.1769072089252; 
 Thu, 22 Jan 2026 00:54:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm17247566f8f.12.2026.01.22.00.54.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/31] system: Allow restricting the legacy MO_TE*
 'native-endian' definitions
Date: Thu, 22 Jan 2026 09:52:40 +0100
Message-ID: <20260122085255.95035-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Guard the native endian definitions we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-20-philmd@linaro.org>
---
 include/exec/memop.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 799b5b42218..4aaa6a0ab02 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -36,11 +36,13 @@ typedef enum MemOp {
     MO_BE    = MO_BSWAP,
 #endif
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
     MO_TE    = MO_BE,
 #else
     MO_TE    = MO_LE,
 #endif
+#endif
 #endif
 
     /*
@@ -150,6 +152,7 @@ typedef enum MemOp {
     MO_BESQ  = MO_BE | MO_SQ,
 
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     MO_TEUW  = MO_TE | MO_UW,
     MO_TEUL  = MO_TE | MO_UL,
     MO_TEUQ  = MO_TE | MO_UQ,
@@ -157,6 +160,7 @@ typedef enum MemOp {
     MO_TESW  = MO_TE | MO_SW,
     MO_TESL  = MO_TE | MO_SL,
     MO_TESQ  = MO_TE | MO_SQ,
+#endif
 #endif
 
     MO_SSIZE = MO_SIZE | MO_SIGN,
-- 
2.52.0


