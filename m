Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA33EC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgTm-0008F4-OP; Mon, 10 Jun 2024 10:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTa-0008B7-Dl
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTY-0004UM-Pg
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so5846987a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031503; x=1718636303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQhy8hrl81u7GNgqWNgI0Q8CnNR/8+x5QLQF6iXo760=;
 b=x1K4BnWgKHE3cVl8wTx1amBbVh1AzpDiZK9yI31LBTBehMobbuzMldsvDkJnoLIcTF
 4D7RtgqIqpMMty1WrY2h08VAPr+hnq/MxGFmZ73FqylJdk/cczOWS45+zs5YVEdRigHx
 NB+qCA/Y0kcEhanY5KQBrCs2cs3wpnLR3NL32oxeeX/xpINk6blPASnJ2CgA9BQtoIW3
 UxoeLPQIsfu9LC2386R3y36yd52Ns1TPr2gbXgAUX5hvyKzySb2RvFcEmwsXy2zJ7Bzt
 +qDlOHjC7guWRGffOMsCnpqs6YV1h0SuyDc3mtgtFei59y+SipMZdQeXL84B6zo7bTU7
 lG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031503; x=1718636303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQhy8hrl81u7GNgqWNgI0Q8CnNR/8+x5QLQF6iXo760=;
 b=fBrcmqLSC+PHPP5w2HygUZq6BMcQVepISdYSCY3i6yxcIB1GhwnIiWOBnVExbUUzbO
 dfqDS4ANk1+GYVSWPgHNu8eQKG3IM7cCC/5CnhpQtc4d2t8Zkbj5D6x+j1UMatx7kpsz
 svUJ7Rt620pLIm+Y0UzjsLzjMZdoYr600JdyTfezWN6W2OhB2YhSQe1NHip2zg90WYx8
 0pdR4TvcDTgyrdqK7V5xVrmm9DEiwPgbbQR7TbVkbJowUtpZrpR7IHF7h3Aql98SR2ad
 pO+TnqxQnM6NoJ0A4r3ur0uUIKw9uMPLGOaq/h7IfORN22gwoGVAd67JoUMWdh5oRG0b
 MscQ==
X-Gm-Message-State: AOJu0Yygs96ihMzq1vQAFHGQz2QpCS2f03oLWoXSfp/AKLCmskT8Ix4r
 zX+TYZa4v4vK3R7FIHXJhz005gA+gjrKKYVFAfwvzOs46WbUFNi2RPMCm3v8Af4ciMhBe7/lHX2
 Q
X-Google-Smtp-Source: AGHT+IHa524Sq7L4vIHWyuf4lxmRA8Vp2tOvxeV8p3KmsGMF5YYckjxmdIVpodtMXW/pomhtNr0yeA==
X-Received: by 2002:a50:9e62:0:b0:57c:7f3a:6c8e with SMTP id
 4fb4d7f45d1cf-57c7f3ac291mr2541906a12.11.1718031503027; 
 Mon, 10 Jun 2024 07:58:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c7bc88c8csm2872069a12.36.2024.06.10.07.58.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 07:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/5] target/xtensa: Restrict semihosting to TCG
Date: Mon, 10 Jun 2024 16:58:04 +0200
Message-ID: <20240610145808.2267-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610145808.2267-1-philmd@linaro.org>
References: <20240610145808.2267-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the xtensa target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index 5e46049262..e8c2598c4d 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,3 +1,3 @@
 config XTENSA
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.41.0


