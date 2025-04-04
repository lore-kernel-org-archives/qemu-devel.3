Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D79C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Xbr-0004Uj-Ek; Thu, 03 Apr 2025 23:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbp-0004UC-G7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:45 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbm-0002Ji-ND
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:45 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af51596da56so1448180a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743736840; x=1744341640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yzLkzx/c5x8giPX3f5sJFHV+lc5v+GH1cpH1SFX12t0=;
 b=YlfYVXqs+8ro+CJyb3oKJdoNnuxflFLBVe4yEQN/CCaHasCWXmCOp+FGRAa9izRoqA
 fRHHFthA/78ipRjK5dIU3UfggjomrZ7+v46ysbgGtQlHnLNv1VBitJK8FbYJhX+Gv6bm
 y38+dKLbl47WbxR4UiGR6AogMEfrdpmVQ82BdAeeBO62Yn6cfY5FnHzuPPWH1LWyR1br
 9vm1+Qf5/XIIwdPB8ieoc0eNL40bbkO/rdYd7HzcPn6ijBmD6Yad5WUyiU+TDucAe+Va
 I+BeWv8alPD1mayKiZ4lPFXEe+Wat2Mdtk/pmCjzVBUcwv99HHknH3vf7lJN8AKXnL31
 0XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736840; x=1744341640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzLkzx/c5x8giPX3f5sJFHV+lc5v+GH1cpH1SFX12t0=;
 b=jODt2HX6/VI//WSUAno2CodRwjPbSmsMNhLWHs9EkKFtqXmtl14egSLAXsnhK/XRoo
 5GW5wHdRBl/+rL6BjU14FoGMnhtLm5QFrdaU8xsw1dEOsZX1rORtuHT4O63fCAl5E+Cq
 YgZ4vuUGPkNPeQrC0s9AViVP+5Qdr0h1++TIMuGXG3L0/3dqHCTDYw1/+9ZXDKb/T70Z
 0UGBScYXPGmpGV2uxHw2qbiGzTGOFpR2hMZPdK4DRSpTwkReKCaVULtZ46NAdelVs5Jh
 QZ75NA4wHdjKih/rJvu7NpgFT6tB8zk7kCi2cbuAiXkgWGdaNw8sy4KVnWn5CnA6vCfn
 9xbQ==
X-Gm-Message-State: AOJu0YwxZkXyMXEZoaV4F3Tt/2rfQ3zY7TFnHjK73NL/0A2j3kBPlTda
 CaBpD81dZ3xpqDkAhXARHWHQUkKqfdcO/43/75+efVVyF3ahVEwLHuajC5JAE0S7zCPV6tK2C29
 G
X-Gm-Gg: ASbGnctkiGNutBMzrQOUpeli7wB9uoEyA0aZNSGAPtHSLKLa8xzRL3IQn5JB/IPLMM+
 lEJZe2dPJHxATPcemp2uP7KE8uzlTxogFT7pdo74HqpPZoNwMmlICeXM8QiJaTCHBdamGFWkDqq
 bveVLB+QllYCxoovusTHgOKJo/qdf1u8KKZw43YIWXWBhzg4v9jd8NVTtdE0imkQ/HdTiEcKcH/
 bzMkx0Vn/kE+XWObY9SyrMuDFaxxodhor4WQlltwVacmtoTDIFbRA8AmtHrIrHoXznJaUdMRJsa
 Glj5PKER3KLyOfln4nNKvP8hVqLuHCK/D8R6rMcCkqYn
X-Google-Smtp-Source: AGHT+IH6gYNCDwC8lSyY6xV33ATe5GZbNc6CBv4xR/CLee6Yb658IGb9p9O61HzUIkhYZt8p/oMVqw==
X-Received: by 2002:a17:902:ec92:b0:220:f140:f7be with SMTP id
 d9443c01a7336-22a8a8ceda8mr20401535ad.41.1743736839992; 
 Thu, 03 Apr 2025 20:20:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad943sm22325945ad.23.2025.04.03.20.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 20:20:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 0/2] fix deadlock with plugins reset/uninstall
Date: Thu,  3 Apr 2025 20:20:25 -0700
Message-Id: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

We first fix the issue reported in [1].
We then add a test plugin making sure we don't regress in the future.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2901

Pierrick Bouvier (2):
  plugins/loader: fix deadlock when resetting/uninstalling a plugin
  tests/tcg/plugins: add plugin to test reset and uninstall

 plugins/loader.c              |  2 +-
 tests/tcg/plugins/reset.c     | 73 +++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |  2 +-
 3 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/plugins/reset.c

-- 
2.39.5


