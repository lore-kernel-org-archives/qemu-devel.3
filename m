Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA24EC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOlC-0007wp-Tt; Wed, 12 Mar 2025 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1tsOkr-0007tt-UJ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:16:30 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1tsOkq-00015Q-3Z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:16:25 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30c091b54aaso245271fa.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741796180; x=1742400980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U+oyGJNiylgxir0FH5ex9xhcivR+uKpSEthU+nRvd6M=;
 b=iwo2WNph//9QakajIc5orzCOmKGpxVVdscKOuYDzu2zukGViW9yuy7VaTTFplSBhjI
 ibeJHDhBeBDXzjo50v2LrP7pH5Dd85akVBijk0ryS5eDClu+N4XcQpXQiCWOpo+cN7H/
 RPMPHXIL28RmhIESoI2bjCqvD5+QbUeK/oRIe5X4LpEcEAskg8LT4aGEMrv0tTqVrhZ8
 I/Z9gr4s2OXpRqtnTF++xl3ih4OU/Y2gqSd+XoX+zisr2V0VeBwjXRll8zaRhQQA/FBJ
 JTUldNQFP6ouugATsANL78iuWzTT4gz5CpM8Nzbuv0/7U71LC4SnJEjN/Qx9i73DNeKl
 ijag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796180; x=1742400980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+oyGJNiylgxir0FH5ex9xhcivR+uKpSEthU+nRvd6M=;
 b=ZSqTNGDQTwghhuV/djVMqVs6IYQmWSFACdJM0rHzYPlI0zkQa9t1av9mWeQkP3vSm5
 PuCTIx8NChiGHZCvKoBmrLQQv79KnFwgqRQUgk+fiSNbzvXcCTne6bLOyXBcAf3zJdTP
 WQGMSjae+PG/ALOxYdsFQgPCA1UGw8narNuhtkxbJN2Jmf8bBndxJGonWiOthpFQY/VS
 pIBCbrmEDHElzpeY+ZRbumF6mPKUmZupCoDsb3gEcQ8lpgSWo3+wO954ohnga7zqHmEB
 BqJwso17lxeNe95s2tiYiySFGoRaUXDNgQPaZhV+MBOH7KlBKJ8jGxvg4VX3dCQdJpqb
 1cfQ==
X-Gm-Message-State: AOJu0Yzk8wmP0FC7GIjOokD0MfJzyUKLGDk/X37zSxeebC57NQ3dBUC8
 nTeiSwZo8lqvUm/C/v4Y42iTuM/YUJpcoB1vaj/F7GgZ8Z6cMtihxXnPLsJd
X-Gm-Gg: ASbGncswd8spc9xgLRLVo3lzyKKKBTi5UGXILm3SmjyFoTQauL0SCYZQctspa0zsq4W
 mjlTtFOv3HkXZYp8NaTQY0615PxhTLMLj97vxLoIGnXEkhj22qrIQQXCAYZ4tDAE0EkqlAB4rk7
 aH9JtfZ0ueRX2L0At/XKdkdCkwP7Cb/rKfUGSHGOB3JT3uTMYyrRVWrLhdo70zp6GspV8MVXjU6
 jw68gFRAB/9ROXIElXTrGSEK/OzEGWh67ghoY50OORiXmsxtWrdcTaSBIPjmlDBex0bvJbgMn3T
 aU/nyReaMeX1aEqoCCkfsbWNGz6nvNVbhfnj1iBmRcHHrA5Ed+Q+JD6yidOiUnKaybjtNmgbNcM
 =
X-Google-Smtp-Source: AGHT+IGpqXgN12uJSXc70AFRAKcWKqaOeVvYzvAZCVOlhGbqy50QP/OuUCwoC+cUptc6Sx9PeRkOxg==
X-Received: by 2002:a05:6512:1242:b0:549:66d8:a1f1 with SMTP id
 2adb3069b0e04-54990ec56b5mr9147378e87.45.1741796180214; 
 Wed, 12 Mar 2025 09:16:20 -0700 (PDT)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498ae462fcsm2163350e87.42.2025.03.12.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:16:19 -0700 (PDT)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH] system: fix assertion when cannot get/set rlimit
Date: Wed, 12 Mar 2025 16:16:03 +0000
Message-Id: <20250312161603.24820-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If cannot get/set rlinit warn_print called, which uses monitor_lock mutex. monitor_lock mutex initialized in monitor_init_globals, then monitor_init_globals should be called before os_setup_limits.

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 system/runstate.c | 1 -
 system/vl.c       | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 272801d307..de01cb9833 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -874,7 +874,6 @@ void qemu_init_subsystems(void)
     runstate_init();
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
-    monitor_init_globals();
 
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
diff --git a/system/vl.c b/system/vl.c
index 04f78466c4..0742a3b407 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2885,6 +2885,8 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
+    monitor_init_globals();
+
     os_setup_limits();
 
 #ifdef CONFIG_MODULES
-- 
2.34.1


