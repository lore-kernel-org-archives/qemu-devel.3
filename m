Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5B4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZe-00031O-OU; Wed, 20 Mar 2024 12:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZb-000317-OF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:52 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZX-00035s-3w
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso1807066b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951225; x=1711556025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Yct75axRVllCYvwRsbgggiBS0DJ4rQPjxub5vw7VsY=;
 b=vxV9R140ojGixNPs1ZAjnFlMpwhVzJrJEQAgLcVLYNKW9biWAMqHQipsNoQ7/GZ/u9
 Ro3KZR+Mw5dyUdX5G5bPBEqYQ4kY9W2w0GwzNSw7m0MW48M0XufSLStGoPFW/uodzBVd
 zBLwZ4JdPMANQX2TgBxtOAOebpZH7MRssbxUa+L0ImN1llcJ/u/BqlRIiulAteuvETsr
 m667nuELMAzMqvPFoh65zS/+swp86Zghaks0rNqZr5k0ndoqI84M1y5zkkVRVQvFbzOq
 yt2GVrXHS+EMxTcXkvQn8XlFejYIEWL63FyGfcnE1050rZGelNwIawqAnEeAgOpiSCOw
 NGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951225; x=1711556025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Yct75axRVllCYvwRsbgggiBS0DJ4rQPjxub5vw7VsY=;
 b=QUXnOMUz7zZPa/dHeKTGQ2neHV1o7+kL9qNSGmzSkib2Of0JTxyvznGEeGAArTeHcZ
 LLjFemGnl1gisiWJDRoxhDl4FFaYBNUSpfIfB64UxLBf7wkF8+YcCUncaqOM1zR8s40s
 d4OG4/R0sdQIUeyYsFrirqQltmOdBMaB3UMYTlwTvC9WnXeJ4Ublpgzoo2GD6PpwnoOP
 g2GGm256HGoN5LlB8omJJOPJ5ANV5Hl+IucYatbWqhCvZvP8KfnSyMRz692Xi2MrDNR2
 ThKAMEK2CY5DkuDfPIy3UMCQaBZ6jXKDLh5BVMpfqED6OlIAmisodKZrzY3fzdtJF1Nt
 oQNQ==
X-Gm-Message-State: AOJu0YyzDBfM8IL36qx7iuRNmiKaOtbIeRM4XKV4Xwd006KpeJXxqZSN
 oNXM/wpcd8IOV9+xD1dKgbhuKXAFbJwHJe85WUXXkY6zNd11b9yeB9uTUIuXQ0s=
X-Google-Smtp-Source: AGHT+IH3R2P5oUEea3iQ+QOueX5BuTWMN9LRK9mD69compRcthq69ELR1BgOebR6+l9vnAfeNIxcYA==
X-Received: by 2002:a17:906:2a0f:b0:a46:c8e6:b825 with SMTP id
 j15-20020a1709062a0f00b00a46c8e6b825mr1558635eje.26.1710951225664; 
 Wed, 20 Mar 2024 09:13:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w28-20020a170907271c00b00a46acfc72a2sm4874276ejk.84.2024.03.20.09.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 631B85FB8C;
 Wed, 20 Mar 2024 16:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 5/5] tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max'
 setup
Date: Wed, 20 Mar 2024 16:13:40 +0000
Message-Id: <20240320161340.391798-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
References: <20240320161340.391798-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

PAuth makes run timeout on CI so add tests using 'max' without
it and with impdef one.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240318-sbsa-ref-firmware-update-v3-4-1c33b995a538@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index cf8954d02e..98c76c1ff7 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -203,18 +203,36 @@ def boot_openbsd73(self, cpu):
     def test_sbsaref_openbsd73_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("cortex-a57")
 
     def test_sbsaref_openbsd73_neoverse_n1(self):
         """
         :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("neoverse-n1")
 
+    def test_sbsaref_openbsd73_max_pauth_off(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd73("max,pauth=off")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_openbsd73_max_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd73("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_openbsd73_max(self):
         """
         :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
         """
         self.boot_openbsd73("max")
-
-- 
2.39.2


