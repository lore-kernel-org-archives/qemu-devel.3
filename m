Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB3C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kw0-00033k-4S; Wed, 23 Apr 2025 20:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktk-00067K-3l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktf-000590-CI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so303339b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456217; x=1746061017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/M+JJq6ZWP2W3rE9cY5JRLQzGEcLqDNY6NmbDaK7f0=;
 b=wsvhTIaqdtMKotslZX9bcWzqi/M+pUfjQbOfXH0ZnBuiewNNIb3lZdUjmc/HTyPFhB
 SC2gcujNNCAT6Kb9c9W4GYoxw4WESXmrNBoM+2X+wjwI/4VvyCd+HvBtzAqFekJnVAcf
 bvqzrpggi79Q9aeACJLutmN+Dv4ZlEZpbAU/Zw2a6pFERfrhgNEyqBh3FMaRQSAuDR3l
 rYp9RuP3s3PdGd+Ajrcvnbu1vHN6gBw91EkTQP5TreWgxUx4gfwqObGzqcWqwnXdmNDX
 WcfHNg9NOE9w4v18BgIaBnBJq4KpDyHCHvRwAGZRPpPeLIRxkMe36UO38RbLqFzE7UvE
 k0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456217; x=1746061017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/M+JJq6ZWP2W3rE9cY5JRLQzGEcLqDNY6NmbDaK7f0=;
 b=szFwwkxNLy7WGDj35TS0zHfVAMse5YOJx5FL5vNkvjYs1Au2dnixlYmTzO57U+DIB+
 nSMMn9FjUk3INXXRGclPfkEu2DdWHI2Us5SNEpDJlxxEslij2wTAuok0kKt+mUMMeiMe
 0aK1qS3iDvOf8tbS9/MWq+9wv0QEweMo/R4S9K92O1emuwzuuncXdNPmYLZynJPN7Vbb
 Sbwpij72nE4igZHicmRXU3NXwi1y3GTPrKm8KK5zZJGqJMEjiLlQGVIP7VEeyrfh5Qgd
 7uctwD4R69ST8/fqkrPXHDlD+KtN12g8WRFN810gcSzElP1AI6/yDP/772BOcs1321Gd
 lIog==
X-Gm-Message-State: AOJu0YwdfGsh4NrdtxMc8ZNSsRNCcdbiMaG6ZKgoM7jo7qc3ZCaE9jr8
 i0kZHcHZNwUsBiZ+jQ44bMuaLDKHAC9KlRHsQQi5Ug63Pchbpcdt4yr7I/2ICbqedGfHW/p9Zbr
 N
X-Gm-Gg: ASbGnctEzLGfEqna5+wV/HYZEIrpY5H5Q5k1ILLkTEr9iY/mo++buf1Z1nLwFx4G6RX
 KPc4i7zlyS1QDk8094/xde1jluBig7BECk24+HQXb8sfytI7eMR+fHtl63Sfk2Cz/05cQDfP3/U
 0td6t5ZN1I39kDVcOpcyN0+ZG+JNV8TAImUOs2eULCYPVb3R3w6eievyLR57qC9c7HvRya4IUOX
 3wavrfQDcqJAb49yp6YY3FTNnFDJEL6ns1MPMNGXssPglaaImspwMAs4sHMWCKDpUZ8yDj1qmdh
 hgOcTVX8ylTHeQpW1HbdpPMv+2xlgy/QyUvY04RNhc9RwyY9gE09ryRlFmych+9mfdXNTDLQq9U
 =
X-Google-Smtp-Source: AGHT+IH4d3F9l4z62XTghSlLbQ54n4UNM1Z7E+SkxxvW0Ae4v1GADVIoQ8ldiwoC2xG5CYx+I/kZPQ==
X-Received: by 2002:a05:6a21:6d8d:b0:1f5:a3e8:64dd with SMTP id
 adf61e73a8af0-20444d2754emr1026778637.0.1745456217456; 
 Wed, 23 Apr 2025 17:56:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 114/148] exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
Date: Wed, 23 Apr 2025 17:48:59 -0700
Message-ID: <20250424004934.598783-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We prevent common code to use this define by mistake.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-19-pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index f267da6083..a09e0c1263 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -73,4 +73,6 @@
 #pragma GCC poison CONFIG_SOFTMMU
 #endif
 
+#pragma GCC poison KVM_HAVE_MCE_INJECTION
+
 #endif
-- 
2.43.0


