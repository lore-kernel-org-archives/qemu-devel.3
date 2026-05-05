Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18276FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9J-00080r-4h; Tue, 05 May 2026 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ98-0007xj-Fq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ92-0003TZ-GI
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so65181105e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000472; x=1778605272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVM2EdEhrC2RVcrum39dP3flDEFXuwzgEYDRb1J4Vrk=;
 b=KG1Mnw8R04umsm9TsAtLCh/XBesXVJz3X7rwbcHJ37OhKaNDy+xZzbqdKg7nmuVAOG
 Rzv1nIxI+WY+dFrjEqGnS8eULxBOnIjOAYY7bmZCUe2hT0l5mERdBPMAVK3+e6cUbaHs
 FwbhCq3zPvi1S8wTewx2lTLwsFzuXuwPxTsV+mMh8sGBj0TXYnaquaLoVeT4lIzsQDy+
 A1BTZinkukYPakW5xe6JGtoz3mVnCidWlETXdu6ynrwUB+9Gj+TEMTnp8ZCavehdcenk
 R+aUyavPXgzH47cwWx2uHG/wTWTuizHFxwD0dmEZRnxTrggd4q6M3O/2aEOkuPNO0P/e
 X4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000472; x=1778605272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kVM2EdEhrC2RVcrum39dP3flDEFXuwzgEYDRb1J4Vrk=;
 b=UuYqwbkvFIbhktLK1fSuBT416pMthegy67VhC9tx6lQwX9CBo6QGwAfuqhQG5P9wnp
 MAt/JS52pCG1tk8S9KJbMnz1c86tnDHf9JjLAw01p+dHBtIhX98VDKStwjs3goGhPgcj
 PoqODPBWWLV718WkDj9NIOJEETgvQzlnJ0jPkUY4VbkXzIpMi4CSQiTv5IBQkPuDZOss
 rEL2+BzWFMH75xoKqK1U+P07J15vwXklnCTn5ULwYO7VbKgBkDkewwSYSoz6dArm+fQz
 jzvjyVZIznl6ipY5V+EQPaSqOczQJEFaxoa+Lz/TITlmXAdFlb4zl6G1zNQNU0hEmNs3
 GFDw==
X-Gm-Message-State: AOJu0Yw5Ub8YzybTXliokkeRNnM6lZ4llnupM36exG4IaX0qDmJ3Me8a
 jPBt/fE30eBX6IXEiHxLd3YnE3cgHR79wDCdwv5mW+aKpS5hVSNtQu47EZFJ0pbB/l4XYvDzMKj
 lI1hURDU=
X-Gm-Gg: AeBDies1czP7jZHFHNDzjAkZcYVF4FR+lRgRwIuE9Jq4Ei5z3A9L/E8chEpINUetQ96
 EUHhFtZ8iUyHGcPnAGrKvlJGktp4k7jtiUGCLxAwrXbvWWGw83WMv6dGRt3eD6EDftRPhYOVWCh
 Fjh5/4LyZUWvPcNi5VDeXw0IPpFKQIAOTZ0gVrApJ3u4jUR2Mqv3GOAT/EG5tElm8D5b5zt0f4s
 aPf9W12GKjcySAMTeZOiuXZsR4QgdUyWt2mM1g5jXRJ8QijGT1WN+DHBu2Tq1s+uZrDgTfQNl1h
 yQfbhmTzaGdp754KWbvXxynpAT6nkqD9+eT5d8nlXSpRZKL7yqzhF/INR5NWLy6bSWklib/sn7J
 1iH/7pB/nJnCKx6QIfnbAvQ1I2Kbx/ZS0X3ti4DZof7iKa+pfr4mnHq+nwb1tsywu1gCe8mbwAc
 RqA66nQTU3JBgc+9PAq4d0E0w284kfgWcx2A==
X-Received: by 2002:a05:600c:c494:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48e51f41be6mr723715e9.25.1778000471933; 
 Tue, 05 May 2026 10:01:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm598501845e9.0.2026.05.05.10.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB6FF60E4D;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 10/10] MAINTAINERS: add a section for AI agents
Date: Tue,  5 May 2026 18:01:05 +0100
Message-ID: <20260505170105.228162-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For completeness add a section to MAINTAINERS to catch changes should
we decide to merge this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cce..426f3df8552 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4548,6 +4548,12 @@ M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
+AI Agent Skills
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: .agents/skills/
+F: AGENTS.md
+
 Build System
 ------------
 Meson
-- 
2.47.3


