Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F035C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWOW-0003OM-KX; Mon, 26 Feb 2024 03:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNm-0002pG-QY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:50 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNl-0005mO-Bx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc09556599so24260895ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936239; x=1709541039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX+3Krub3diCCCNJrHu+195GG4MbJLHurBfYcEWAXIE=;
 b=DHZzNmeyhVbrH004LOM04B2jSbXOOjfbd1/WJTxuEN9SuzENNWoEa31mTuKa2MhLJ+
 yuVp4EqzEJJD8Zo7gQWI9v+xrOKpP0MY4M2kalfVbRJKfTON7PuWg4IpDDA676xka0As
 6jSuAck484WfGAtWh/MAg+8YKA+YzRVkOeiyQLfsRRc09UTDmufr3phKX0PLhgLO1bui
 hUdlEqa8L6EA4A4syPyQ05Gs5kcXQ4PXJX/06vBh8dMomnp3L6nOJdpJA4Ad9+pDwpj9
 qbHeRfyHtot1FBeeM3uCsp3fEhkfenNpYs+hEEb0GDlex87aWIiTmk4NX4WX1U/z3MWr
 JlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936239; x=1709541039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sX+3Krub3diCCCNJrHu+195GG4MbJLHurBfYcEWAXIE=;
 b=sfl4gFkVRPIQYzuXIz8u0Wvkw/CFmDUIos/e631QI51HhZThuVW+4orErszc28sA8w
 r2B/bALQ/XDTvKRdLZskgS+odVp39r9QPKRxpP/YhCumQ2eVqD3TJPOUUkbo/Hekg24e
 e2h1D8VZo1BUVubBj7xB0UXmGu1Qp7tnnTWkpd18n2CrVUzCWVIRbb/F4ar12lgvp5v8
 iNuKrKpwSOpozWw7V7rLhG7BW5764Yk1XlJPWINIWEkmRAEDya7/rElFvdJLaQZXiEJS
 h02ojtn6oIIeKqhh8K0btw34vbkY4z6FufZVGFZvUgolVCCfl3PYyrwEVoAIHr5F0aEl
 eOug==
X-Gm-Message-State: AOJu0YwKRIirugOMzsxLDu6PLPK+9TfvyIG54HJkqPYdmvBzhYaeA/bv
 oxvfMR13Ub6isMh4TziHJ7u3aLe4NpItny6M0XMpjMzg7B1kEa89TX2ny9ji
X-Google-Smtp-Source: AGHT+IHmTn9JIgmWhSBi+6XQYvJUtdfRfGZUdkQ+N54vLeHeOlM7NxlgyKLrjRRIpYqe4D0MrUA4fg==
X-Received: by 2002:a17:902:f544:b0:1db:e672:3704 with SMTP id
 h4-20020a170902f54400b001dbe6723704mr9670516plf.33.1708936239680; 
 Mon, 26 Feb 2024 00:30:39 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 7/9] replay: Fix migration use of clock
Date: Mon, 26 Feb 2024 18:29:43 +1000
Message-ID: <20240226082945.1452499-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Migration reads host clocks when not holding the replay_mutex, which
asserts when recording a trace. It seems that the times should be host
times like other statistics in MigrationState, so this can easily be
converted.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..2e794db75c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3316,7 +3316,7 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     MigrationThread *thread = NULL;
-    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     MigThrError thr_error;
     bool urgent = false;
 
@@ -3368,7 +3368,7 @@ static void *migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
@@ -3447,7 +3447,7 @@ static void *bg_migration_thread(void *opaque)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
-    setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     /*
      * We want to save vmstate for the moment when migration has been
      * initiated but also we want to save RAM content while VM is running.
@@ -3480,7 +3480,7 @@ static void *bg_migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
     migration_downtime_start(s);
-- 
2.42.0


