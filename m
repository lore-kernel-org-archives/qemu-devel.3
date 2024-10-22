Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B4D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t33jd-0001BQ-Pl; Mon, 21 Oct 2024 21:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t33jY-0001Az-QR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:30:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t33jX-0005zu-51
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:30:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so1312121a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729560648; x=1730165448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fTpbQNQsiNuoNwZcxTtelnwqavecyaXodDgMGiTIYRI=;
 b=hP6+6nzNYlIO3lPLhoAok9FHGN8yn72SOpCiE+diDzwP3Jy4fyVK/MDHjFVZUTTKt+
 juHXbj+ltGJyhh3aQvwha0bk4RjSll42oMYzwqLynhBFY6GkJNjG3jOY/9H9PRORFd0I
 Vv+c4WBtiPVotH9b/n0TdSz0v8okEulg5RPPcImRswOE1Raw3VObpz+XEBlrC8Fliezl
 iKX4Qy/qch0dBGqSDwJ19auLjeXyweozedi/0FxjwJSC9/EG0HFUzATQYZoDe8Ivampm
 XakLW4J38bv8IHnqFqtHQOj2AvYVNsLnILS3dzi6zOAjTY3U7nlSJUY/MH85d3VyJ/Fj
 XODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729560648; x=1730165448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTpbQNQsiNuoNwZcxTtelnwqavecyaXodDgMGiTIYRI=;
 b=SFZeiMD0MwSZfLoGYgqt6omom2ioeV0G671JP19W57qwbOvH9ohIPDbgbsH45VFfcO
 24G/cZSydLVuKMfFI4hD/slOG6nep7h56uqyT7JMsKahqWli+Z6VE7hEckZGzsxdJ88V
 kK5rq5WCpbaqJ2IPZKAMNJPej/mqRiXXQwhDGRWl5HJD3sAT1mpd/auzA92Lo1Eu953/
 cyCf0tc/GDwQYBbhzRKXp/ObcLm5RW01oHiCcP18xCvYy11fhTe4mphIgrVXd9S0F/xZ
 Sy1H+b7tM6k9y1+FdPGhxCHKUd8vOyv20iQWsYO3zGQhAVt2BwY7j5Nqgpbpme73izgh
 +krg==
X-Gm-Message-State: AOJu0YywW43fzwoNqjMfXB4xwdNbV9gMTLQaWVqkXieyzbKQMOTGFt0Y
 Z9cQuEjLVZ/to1xZcvgC0SR1M/Q3nYK/9V3MgWzfbzCLHrnPl11+Zlg8yL0HGOUbmDKcvNt8zk7
 Q
X-Google-Smtp-Source: AGHT+IES+cLkGhSMzXTFpxCJujo7evWzadr6uJdH9OOhdKMwJ+TvVthNPRWlNzggCQkp0y7tqI0w1w==
X-Received: by 2002:a05:6a21:a4c1:b0:1d8:f1f4:f4ee with SMTP id
 adf61e73a8af0-1d92c4baaaemr19261549637.8.1729560648521; 
 Mon, 21 Oct 2024 18:30:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad365d1fsm4728338a91.16.2024.10.21.18.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 18:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] disas: Fix build against Capstone v6 (again)
Date: Mon, 21 Oct 2024 18:30:47 -0700
Message-ID: <20241022013047.830273-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Like 9971cbac2f3, which set CAPSTONE_AARCH64_COMPAT_HEADER,
also set CAPSTONE_SYSTEMZ_COMPAT_HEADER.  Fixes the build
against capstone v6-alpha.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index a11985151d..c43033f7f6 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_CAPSTONE
 
 #define CAPSTONE_AARCH64_COMPAT_HEADER
+#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
 #include <capstone.h>
 
 #else
-- 
2.43.0


