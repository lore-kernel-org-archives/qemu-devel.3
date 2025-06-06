Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B39EC61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaC7-0004zq-Ac; Fri, 06 Jun 2025 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaC4-0004xz-RO
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaC3-0003P0-Bp
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso2118269f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228321; x=1749833121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rGEJzRlC4Fsxdbk2GIFasmygNDXfJQlCwnu7QAb7e0=;
 b=AiaO9F+yxOuBXKFwiw0grjQPPOWRiGZ1N+nMrlQLtoUgjzhZqBNxog4FgYGYXO+gcc
 EidGG1+kOaUDbwQ3Q00LTqWVFAM1SpRKMZrRzdi4Xi6tQRjGRAe+tQ7fJcSYLpKBRk2G
 Un3ZDqQChxmKuNaYagpXMIIcWLO7/WG5pTzCEsoQiJ3jrPk3PdIntKLpUlEc6ll5jF2u
 AZNBR/StrP+9ee1qq3cstWlq1T+YxHCpC2Dr81k1XVC6TzjrlfGvasOyMIv+rH1ojlRi
 uLJdcVYkn+ywjxBqbZdMwY7tgpMojEKKe3HKW5v/BQB0RJh3QQl57LxVc9ZBt54YaqFZ
 MKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228321; x=1749833121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rGEJzRlC4Fsxdbk2GIFasmygNDXfJQlCwnu7QAb7e0=;
 b=ZkhXnwRfGBlZL5TYqtXfgwDYX2IHuS75aIxZMfITTNK5J2hd5CLGMt3omi0QWaHygI
 9n02e9We19va357dhTfnVMTfbzHUQmyBv9yj5xu8mCPDdjy3hvvm3d6tnXCNf/ssv1LD
 ULHJeqfa9nx48xGwZI2Viv89bOzQgUc3OQSYBbsKPc01N/DMhepcCQ1LHQMye03SYxOt
 jA8F+/m11LNkhz19Pepjiodr9/I+KVrsIvf5yQk5jVNUhJa9EDzydQi6+K4cNJPvwt4q
 3S+PQ5pgDgs3GPb4qXtZNTavFgr5flu5ElaxnHG5Cw/eoa3EaQCiPI47M2TPlog5qkT2
 lzpQ==
X-Gm-Message-State: AOJu0YwwpqJUat/9Qiz0Gm/12WMKkOV5TV8eCW+vp/Ga5MvLVrDajlFT
 7fFAnAaqlJEMrdOVlp+K9YcXDaZA9KYbWa+ojGhDjlOXoilsEQMNPx1RkzeOpsXnk2/BZWkQjNc
 paj49BcDtHg==
X-Gm-Gg: ASbGncsoJSc+cY6UcmiQZnzoRakmPVNud2KRIjxczqgdLFRfiAiZ8uEzNoHjjMxNUN2
 zNNWjLv4JIdzspD8pwmAG2Lla4foEy24Qfn76o6m9WBZrOCP+iPNR0+FXdtzJXrcYSdG4sobyPb
 N2YTPUumrE2U2Hg8cflMblFlGcFCj7+7ih1xY8uIpYs7NvxqT6xjZlicXBb3+lXo5RqJ1upSEWp
 kBnBqi5lurqvie91/639LXYcytJxRBtLhmbF7dssLvyBaZzExE7cJAA/nBa2FYw42PTt9MXUuKG
 hoBF/rf2TFkaZ5lMQavJdQXx0datA+jpi4GSm4JdPVU5guLRw0qfmJjj6QkOJ/8FEfGZ6HbYiDV
 wNYi48FOepn/tFSjdwnSSfyfZ0hcxVPu3Vr0+dA==
X-Google-Smtp-Source: AGHT+IHipB4Jravzy/orNFjTY1wqg05TgvuL3WtTJuqQ2mU9camsarUlzg2Im3xUE8SfSw7SV6N81A==
X-Received: by 2002:a05:6000:4305:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3a5318a070emr3112474f8f.32.1749228321601; 
 Fri, 06 Jun 2025 09:45:21 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f82878acsm35550495e9.0.2025.06.06.09.45.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 08/19] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Fri,  6 Jun 2025 18:44:07 +0200
Message-ID: <20250606164418.98655-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6c5979861cf..4b1238ed345 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms, AccelState *as)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


