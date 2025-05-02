Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A8C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguY-00043E-Uw; Thu, 01 May 2025 23:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguQ-0003v5-Sw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguP-0003ky-Bi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1842108b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155871; x=1746760671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZHn8bqcj4q9CJJxCqBE9dI5/6R1oiuiTmmuYFd25J4=;
 b=iUpcMBxgQQL6I7dI+TEf+9U3RO9HKYAbXe2X7aqKfCrq01hMdoN53t/TdlUz5B1tzN
 MuQQCFm5VsyUisrRhZF8lVY7Fe9Lr9gu8EVnz9TPLA0Mkw/s6ZaQxkq0Dzo0ypTwI0xR
 0KYhLoTPqbe/4gHciUaUYHqbpDXF1/xEzZbTwb0voj6nfYcNBqzUrNymVoJTGbV1D+CF
 qZfVHj9Z4Ffz0O1J/B4hflK8i4gU+wt2VItQMHJqrGXJT4EAiNn3qhXfpHH3hMi3EG/9
 nCCURw2bUmCzyG2QIcifTPrWWTzDeuG2sCs03Sz05L7Br8z5Fa9rA3uB04e+yn261ZIR
 QZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155871; x=1746760671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZHn8bqcj4q9CJJxCqBE9dI5/6R1oiuiTmmuYFd25J4=;
 b=f/y/MVTrBiZvB4gvUp3RUUejhJNWsiIHFmkNN+FuFoEoEDIuR+YuIHkZilxQCpv4mu
 w7xwujaDONvJls1QgpGkjQOVrzNcKr8WqQFDF7QEiZsysWKFnCSNKhsqjX8UJIQjQeh/
 cclgAJSaIQUShEuJhXXpmYNmoUSqwivaW9Dc6sRl2ZDmYdk3CekYO6RwgAhpCaPpYGy5
 8y5fhZGCvMcudRbljxBiQpeG7058ZArAfjelOU0Z9ELT0ukSPEHEZ06bXeWBG+Pl6IQF
 z/u2bUlecjuAFo6gv0dWPgz65b1aR/q0yjXY4pUumNIDYTw0+irP93/O2SLlwIJZuWod
 FwyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX1n11yAyDTbVB7CFCJGeW2jvTYDue2D317FcgIR4swrYaEU4Wt/DEcybciisgrYlj7XCpuRy7WlPY@nongnu.org
X-Gm-Message-State: AOJu0YzH/l3v559jhDWujEKiZqyKiVeo23EXlc6M0YQ5E0yZSoni7Bf7
 YQ7PfDhh0r5kYhXW2y51sPAdXLZCQIaMZ+3pmSAv46Zeh4sh7GpQ
X-Gm-Gg: ASbGncsdQEmPukg3f2j+ogyP+k9D29sbe4LxP5Os2IftzFhw5lU/X1gGV350yJFK8Uc
 e0+cel4EHWtCgp8xgjBNE7fpo3NDeHAs+WPT4txN17P3og95/VAhZ3aarBPs0SNPUYGp6lyBFC5
 ZaKbMLUITpBK335cRVPEkrizHuKDrcMD+M18aJ++5NoMOayS2cCytoxuNKRFG91WMc3oksZOjk8
 ZR6MQ5F13pznaR1sZ0a8pd21ZXrC6Z+y5jDHQBcT4yO+e8AxzsyTDBPSKRomzBJ7UbKivI0SvwX
 na4VQ1yVqbSjgxGzT4ZVaU+WYnbgQm7nqh86jOriRtyc
X-Google-Smtp-Source: AGHT+IFz3WvjRR3ebp/n+kH3zxPdAK8r5G7wCeua16UPCMAPBiYLFVZnBEEhNOeGGr2ypZ1dZHL8dw==
X-Received: by 2002:a05:6a00:420a:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-74058b4e8eamr1817262b3a.20.1746155871190; 
 Thu, 01 May 2025 20:17:51 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 07/12] igb: Add a note about re-loading timers breaking
 deterministic replay
Date: Fri,  2 May 2025 13:16:59 +1000
Message-ID: <20250502031705.100768-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

Add a note about the problem re-loading timers with default values.
Deterministic replay requires the timers be migrated with the same
value.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index eedc341f298..3ae3e53530b 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4589,7 +4589,9 @@ igb_core_post_load(IGBCore *core)
 
     /*
      * we need to restart intrmgr timers, as an older version of
-     * QEMU can have stopped them before migration
+     * QEMU can have stopped them before migration.
+     * XXX: re-setting timers with fresh values breaks deterministic
+     * replay.
      */
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
-- 
2.47.1


