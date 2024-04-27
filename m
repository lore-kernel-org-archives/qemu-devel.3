Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79699C10F16
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRY-0003OT-E6; Sat, 27 Apr 2024 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRV-0003EW-VQ
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRL-0005YH-Hh
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ebso9133365e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233492; x=1714838292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTp39rZqop/if5H1KxCSQywM5GdZtqtO3vJKkvfEhps=;
 b=WfeUbBF9MuRCJIHlxa5yZdDPiwlW03RlsRYaaA63MHRdxHdZEciCWFLFTuVB+ugFpQ
 p5A2hjcgH6RPSVZTTxO9nVTqpII6LjQnYmton4drMxQvHpL2HrNK+wAvLXYFN/PZTJt9
 Y0PbK59wyAN3tK0lwTGgqZXZh7r+sN+ilF2iXkpW0Byo3B4KV1HRvzpb9b1mcIHO5RkA
 F471+2aIMWi8NhEPzNKi3+KKlhx6FUyL9JAPTAg4iJsJI/CyvICLdB8qAlt3nU7Yape2
 ZLXdkJ3BgYadoXqCFkRl+Rh+Mhe9gCPN5kITa9jngNbIsylwuc53o9iaM51heX/gSiJN
 knvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233492; x=1714838292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTp39rZqop/if5H1KxCSQywM5GdZtqtO3vJKkvfEhps=;
 b=YaDP6+KXRUra9i8sW14+oAmGh0u0G1vLvUJrLQ4CNssEyiQjz4U2JwgJ6c2c66juMk
 QqGlJ7LZE74HWcZzd7rfEoHh1mM6fq+i6uNZiYAFa8v56k7OOoVMCdaLfAsDfpPwntQI
 aHLMwjjUxDxik6qSfzeCkDAcEraSm2o8539Ssi47FtoY+TGekVP4PYLZLd9MAie7t8h4
 awm21ega1Kak9yYMGcycNfXJqcVSOZhllvdn1vfa8YaOT1PBXgDbw0RwV7co0/u96ger
 RjhaFj0D1ocr2OuXW9aRG5NzLyVJgIzYS9RgM+cS12d34HTcu0rVN8NKD51y4GPMfB/m
 MsNA==
X-Gm-Message-State: AOJu0YwfKj8mDJBRMGN+f+tVom0sKUdK36Ihs+P01s7SG8wriVhpL7NM
 6yj1mxZnCJcu6vHTJC/EZlGZhLsbPsUjjU22toP2CkaZvddGUTlCRPW/wmu7C84DINPkpIv0vkk
 L9qg=
X-Google-Smtp-Source: AGHT+IGyKjYyCoNxoWd5FlFSj5er02bvReh9mfdcKuIXNwKBYkaRyUbDcHCo73gKwOk8sHoXqwv97w==
X-Received: by 2002:a05:600c:450f:b0:41b:f2ca:19cc with SMTP id
 t15-20020a05600c450f00b0041bf2ca19ccmr653942wmo.34.1714233492632; 
 Sat, 27 Apr 2024 08:58:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b0041496734318sm38996123wms.24.2024.04.27.08.58.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/14] exec/user: Restrict 'syscall-trace.h' to user emulation
Date: Sat, 27 Apr 2024 17:57:10 +0200
Message-ID: <20240427155714.53669-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

System emulation shouldn't use "user/syscall-trace.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/user/syscall-trace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index b48b2b2d0a..6926434d9a 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -10,6 +10,10 @@
 #ifndef SYSCALL_TRACE_H
 #define SYSCALL_TRACE_H
 
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
 #include "exec/user/abitypes.h"
 #include "gdbstub/user.h"
 #include "qemu/plugin.h"
-- 
2.41.0


