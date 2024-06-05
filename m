Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0844C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMI-0006G6-P9; Wed, 05 Jun 2024 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMH-0006En-CY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMF-0003yZ-Po
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:33 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6819d785528so17113a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608210; x=1718213010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xkTnIJzxFSsgLxwFEGJgc9RCPD2wi0PV4sGMffGtxM=;
 b=L0xsFkxbJJZs+fFwUlDR402TL1B297KvUEBnAxnnr5K+y8wNGbuO/2TZ2cfQES0Cjz
 zDblSz6g6XDeTWEjRvWLdyLrYlsQR5ABCZqvmb0OPmRlivFb9xVOeuXXgV5kuDtQsxNV
 fl2lQkmTGZXeHGkpJeROpJWMMmfNYMFQRzicMDTvjGrTmsqZMvd26W9b66lRnkuzQ2Wd
 SgOw2B1B8OcoqJrAEu8aR8i5xNDoJdZA93QkfH4Qy8Mvthf42hT8hoPH9rLXhhLcAwez
 f5lRuXXr4NA0TN90hPX9FXubAFLx/+HSGeZt5IrThHTmAyiRFpKJNLTSbB5vsJ/5qrRX
 tBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608210; x=1718213010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xkTnIJzxFSsgLxwFEGJgc9RCPD2wi0PV4sGMffGtxM=;
 b=vyMZ6yxBmMdgR2iSbfI+3HS8D1VYc4nZCGbL1bvLUTW3xoJlcfbNTnOR/2CUuG8C5e
 0CalOh7BQWg0ryPXKhfNG8g45gRQS8fvQUBs2Ezpv+/5mozQjhLCPu/qaYmn3Rv+AeL9
 BZhUvkAsIPXoo61RPIc09KrO46hLfLQKaqk+ofjlyWDv0NE7qyGIfulq4XI01kEpJcr5
 okQbVlw8JWC5SDAzJr4lxQ47MwUSGjgrTJ4FETQdnQ//JrwqLAYw7ALP5oKIefreyMwI
 XJoyeM3nvZcpoIBYIVzZGcOB4ESfEAjAKpu9yTYTs6iIn57xyu/BESsL2lepX3g3uQF3
 upPw==
X-Gm-Message-State: AOJu0YyJTwgXRZjktnzofh/yPJpqcqBzYZyt9FgyirGT+MS6wYs2F82G
 HxL+QAbQA3yxxgs3I+P1yTgyCt9qS1bGtGphjgFdrL1SAbi0aF0BCKSPAgu+RMYl2+MSLVgkkiy
 P
X-Google-Smtp-Source: AGHT+IE9j9rvh/384GHhj6ivBnlQas7UjJeSXJqfLx5ItK0Sq3eKxX2Kj71r1CCzg2gIHWvT+Bp55g==
X-Received: by 2002:a17:90a:df0c:b0:2bd:e965:8193 with SMTP id
 98e67ed59e1d1-2c27db02bbbmr3693112a91.9.1717608210453; 
 Wed, 05 Jun 2024 10:23:30 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/38] target/sparc: Enable VIS4 feature bit
Date: Wed,  5 Jun 2024 10:22:53 -0700
Message-Id: <20240605172253.356302-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 88da5254e8..9bacfb68cb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -552,6 +552,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
     [CPU_FEATURE_BIT_VIS3] = "vis3",
     [CPU_FEATURE_BIT_IMA] = "ima",
+    [CPU_FEATURE_BIT_VIS4] = "vis4",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -886,6 +887,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS3, false),
     DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_IMA, false),
+    DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS4, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1


