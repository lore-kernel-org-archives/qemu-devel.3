Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A18C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJln-0008BE-0p; Sun, 26 May 2024 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJll-0008AW-3c
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlj-0007cp-G1
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f480624d10so5999215ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752578; x=1717357378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYP1yN4ZKgW4BIdLMmHOja0Hfuxd6mArjAtvAgL/GVQ=;
 b=uT9/Ac/xBKvWqk5vdLKi0wQ1xvlqfWz5uFdWhAGNcJILaeV3OWnKHZ62HJ79zM1+Os
 UqO2mpHkk5RKxsrBGTKw6NNUChoAqnaY43mUCOpRABebxpG2Y6QTMIAZiZ95f0c2A5bO
 2TgWa4Hl3Lzj0t5DCSxQFSadPYONu841DTWHJa+SplZUyAyGHyGzGsKj5xU09t8nduOk
 YFfol899bSpjo19iBCO9eyzOhpfypCdfr0W57+LXinGwxuAJ83OFTBEOyFeLF+2gt/6I
 dhGmiWpBEjnMo+x8MWxt7hgF/OxP9CREqKEldXRY313JLz/VRYHh7H97Vxo+RfVSTwBO
 Sg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752578; x=1717357378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYP1yN4ZKgW4BIdLMmHOja0Hfuxd6mArjAtvAgL/GVQ=;
 b=s8m6dPvM+qbwmhbmq51JDQQt4+x67GttF3RWcxeaf2urII8tm5TpQH+56Hnp7Uj6g0
 nsWA7Z6g37CtiCM7XeeWyzup6xZZ+J7W30e+TZbaFqDuvZ3RwUC1cDfnh2fkEUyVapFW
 MwwLaQ4LP9gzXQo4et5AaHMc8KU1cXb8R7dj/Hh8tKmuLW3PiWO4fBFv19W47yDXyuWR
 r4FGbaAAAifULn0iDubLD4k2HyS8I+JPl0dwhsXpFWtQS1CvNkrRLRYrjqNcv9xZk4vM
 WIQoXWTnvpTlYzVQLbraQNlej18fP04pNpfvfEDBVMjfEKk+wH4YX0wXwD3cf0TOnnT1
 1bEQ==
X-Gm-Message-State: AOJu0Yzs3ycF7grMloVwYLZPYLeyzaodlcAaEXm4wp+qCl470c/ruyWf
 DZrQiYDRc3qdgqG79QXfKmXkn88BtXpvYxKdgV4je5PzGFXptc2k9xtV/E1ac6aRvTLVY+Zw0So
 O
X-Google-Smtp-Source: AGHT+IHdCAXcIOX+JeXzZaxFfgHNay43edgYv3NeaVGqbcSZufY8qBU8aOaPkRryZ+5M1gCB/Wc/gQ==
X-Received: by 2002:a17:902:cecd:b0:1f3:35e8:d309 with SMTP id
 d9443c01a7336-1f4486d9f35mr86120695ad.20.1716752577827; 
 Sun, 26 May 2024 12:42:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/37] target/sparc: Fix do_dc
Date: Sun, 26 May 2024 12:42:20 -0700
Message-Id: <20240526194254.459395-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Apply DFPREG to compute the register number.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 00c2a11353..1eb1a6decf 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4253,6 +4253,7 @@ static bool do_dc(DisasContext *dc, int rd, int64_t c)
         return true;
     }
 
+    rd = DFPREG(rd);
     tcg_gen_movi_i64(cpu_fpr[rd / 2], c);
     gen_update_fprs_dirty(dc, rd);
     return advance_pc(dc);
-- 
2.34.1


