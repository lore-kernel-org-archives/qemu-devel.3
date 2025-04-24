Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F92C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksU-0000QI-Sv; Wed, 23 Apr 2025 20:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-000159-KP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq8-0004iQ-Vp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso387139b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455999; x=1746060799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEc/3fiG4iISK/71vr3crINCUz3P6fX9ye3zEIs07n0=;
 b=P/ZyKyj4lM40oaQW1jiMLaKOPr38Z2xLR2tL5RvmBO6W1gbNCoy2JJ0dm+/3LnsM8N
 SKwMCRfHjnwBUwI9czbhCM6fekAv5OVtrpc5YZChxLrUQE+gGacwh1i5IZ+FPQFhdXtB
 JI0ge8cZWqbgaTvVKAT987Pi/m43QyJge6ZYLK1RR/2EFKBlnyNX8XIkz941FcUuuksM
 AXPDDru0GaWo9VTN05QilhkLRzMa08+yu3/3MHd0MLNpvYqWj5DQ1ZzavfR4SUh1XqnZ
 dj0Q7GRQJcPh9SqfBvWKIHLKFDmfseOYCMOI/zVzWnnl+5TkowMn5wUwvZqIbjl/kpVP
 MUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455999; x=1746060799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEc/3fiG4iISK/71vr3crINCUz3P6fX9ye3zEIs07n0=;
 b=BUmz3y1wDpJxk9yeVMm9Qot2zh4oFwwbt8t1KRsRzA7aWZxe8Lp3DvdbGUADc942xS
 UaZgvWespiA8CmpizMlmDn7hnqpUkvBuxAqoF+NFfotm4vUny+ccGyXBpdWt96xsEvPZ
 yLiWrF5JtCfWg5dr2OqG8thnxhbH39KPB0OviLcR/rll2CimGHwb9nejB0fFkIicki5S
 TzPLKbgZlOQFr3ekv2RrR8KdUQOPzqciBsqehQmssmRLI92ai8WryNbgvvQB4py9UJ78
 0HidtGSFOuJKQy765NWY7EIDX1a8Deh2gKAtXdxxqnxpst4SkY587I2bn6ADGm5fccz6
 +Ptg==
X-Gm-Message-State: AOJu0Yz3Uij8GCyNU7YQis5cPQ8z+2+yQaSp4WjMSk63NojOw/qkYJx/
 /eBnXS0z9vWmoGOtdziUflkRUuWaUsTSYafvxBfVwyETcZbwu3ayjgU31hi3mUI8eBNLgYqjgKP
 Q
X-Gm-Gg: ASbGncuAv4Gj93H4kUPZS9mK273QIKvMzZ7jByAiylxFGVWqCwV0TLTDuR8ySDWU276
 /gBAqJSQdvXfzOoQWF18VimFkrffL2knaE2DYZmIZy2LCcvrGdASAmLH5zizuLmhLcTkTxFP1t4
 km9xGJf0uB0nViQ1FQRjY1R/0vQUf/nQQXJOL/D4VBPMxi7mCAgYw30XIwYUdEXIgbgY7wjkWD5
 MOUzEEOKVAh5DwP6tV5aAzMUIxsrnO8QTgKD08AbfPw3HVrRJy9PqcGe8etSdOytUp8o/tdcZ+B
 pV/9jiepaDQqXQPRmDKq8OBfjXNw9wfEQqzk+uYE+eQnkF10yR2APGol0ra22W4wrXiZTWyDhCk
 =
X-Google-Smtp-Source: AGHT+IGkuGdxoc7VS2BLhl1jXF1r3PYobYqoCASrJRNi6lyOOuMP1GVmYtAt7afME1NfFaC8cxLHDA==
X-Received: by 2002:a05:6a20:e18a:b0:201:4061:bd94 with SMTP id
 adf61e73a8af0-20444ebdf33mr839092637.19.1745455999327; 
 Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 057/148] include/exec: Protect icount_enabled from poisoned
 symbols
Date: Wed, 23 Apr 2025 17:48:02 -0700
Message-ID: <20250424004934.598783-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/icount.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/exec/icount.h b/include/exec/icount.h
index 4964987ae4..7a26b40084 100644
--- a/include/exec/icount.h
+++ b/include/exec/icount.h
@@ -22,13 +22,21 @@ typedef enum {
     ICOUNT_ADAPTATIVE,
 } ICountMode;
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_TCG
 extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
 #define icount_enabled() ICOUNT_DISABLED
 #endif
 
+/* Protect the CONFIG_USER_ONLY test vs poisoning. */
+#if defined(COMPILING_PER_TARGET) || defined(COMPILING_SYSTEM_VS_USER)
+# ifdef CONFIG_USER_ONLY
+#  undef  icount_enabled
+#  define icount_enabled() ICOUNT_DISABLED
+# endif
+#endif
+
 /*
  * Update the icount with the executed instructions. Called by
  * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
-- 
2.43.0


