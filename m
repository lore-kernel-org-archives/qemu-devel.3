Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84449D2F7F3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KE8-0001gM-Im; Thu, 17 Oct 2024 02:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE7-0001fd-14
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:15 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE5-0005Fk-IF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so389787a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147392; x=1729752192;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuqvH2NTqcFSEDwUKN/STKKD5/FUD3STbfz6kJBD0EE=;
 b=Z/yaVSZsSEzNV+K9BBqATAp7yrmMommD/+wshFHC8v8anl83KLMq0P8avKHiKaz52O
 Mh+83sJqXDHX3CV1sl35exVNmy9QoOEpAItEgcgWMAUcrcu9sOWRAt70kX5ltuB0QZnJ
 NgZHQKqnpjY9ddAru+7wIN0tzojniq0Fzpj8P1yp0i+T/wPkNGdmbmoBrfDVvz508z5L
 pqG+JSSuVcNnZNrYgmkt6nu71rFwFoDDhmCs4dT4DSrDidttf3yDGhneQOrahrcQv67j
 0AxH90WY8LmVN7k3pxx7iG760bqqPR7HEtc9OvVq4niZ6hUQm3H6Fs4j2cPu3I90oyW4
 jTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147392; x=1729752192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuqvH2NTqcFSEDwUKN/STKKD5/FUD3STbfz6kJBD0EE=;
 b=SxYmkW2EHjGsoxVwgaphXlqqPmQuMROh+hlrZMJMdyUtI7oec5fue42AnWztBYth4j
 xTxUEccRyLg5fLTig8NhQMjqFLCtPDVU3L8HCvddZfrKWzlcvEYE9VfccQhDXTUXaiGl
 JSzVIap/jw7zZW4tut9sZ5uUygWzmaad6HLGfjHNm9ox9LCyJXhz1Op4UNe3Dz9hKS0L
 AsiVUbWxvQndUVdIbmQya7EdUjghzCIH/y65Rkr1QJtAckL3IMa27o4ZsczceI2UBPLK
 cFAnAVXt9N0S6elY5vuFtOf7vjjWsOHKOLjNogBudkZ3l2Y4SxE/jmiQffvLpDqZlopH
 yWzw==
X-Gm-Message-State: AOJu0YxnyUOqtdPMiuVDTV9/KNCIBf1wwisKYY8caTh2lMnV+2dTikAw
 gq7wqAmsJC7D8323eJxlBNLvPtBYSEfWnkGBbsc4FVWty/6+KhUCIWLDLj2l/dV0Idtve/XOaPD
 U4Ndirw==
X-Google-Smtp-Source: AGHT+IGVJkp+f34DuAMjC6+QzWkaoK+6LCbLo4DlA8737VvkMJsmiR2vLkqLQXqDdKc+kMWC8dW/iQ==
X-Received: by 2002:a05:6a21:3a43:b0:1d9:21cb:ecdb with SMTP id
 adf61e73a8af0-1d921cbed64mr1000367637.41.1729147391434; 
 Wed, 16 Oct 2024 23:43:11 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:11 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 2/6] migration: Stop CPU throttling conditionally
Date: Thu, 17 Oct 2024 14:42:51 +0800
Message-Id: <f0c787080bb9ab0c37952f0ca5bfaa525d5ddd14.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Since CPU throttling only occurs when auto-converge
is on, stop it conditionally.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..37a200a177 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3289,7 +3289,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 static void migration_iteration_finish(MigrationState *s)
 {
     /* If we enabled cpu throttling for auto-converge, turn it off. */
-    cpu_throttle_stop();
+    if (migrate_auto_converge()) {
+        cpu_throttle_stop();
+    }
 
     bql_lock();
     switch (s->state) {
-- 
2.27.0


