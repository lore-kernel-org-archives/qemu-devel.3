Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477AEC54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXH-0000bX-JE; Wed, 21 May 2025 12:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXF-0000aD-UD
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX4-0006CV-2R
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:17 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6019b564d0bso9250516a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845784; x=1748450584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLCQ0JmwftO2eWLG55kfspY4mRvxcs+3bUMWqjXAcvc=;
 b=KeQrPv48dMQ3uVHSQpfCc6wUPSzYy03HN9nRTJpt/sToz/IG7LKL49ZmBVVGzXTBhf
 icK+oFwbSoWYkjh9l3VpP1neJXF0yfctzgzMKyy1EX4GIhl0GcdlyIlTlWMvi3e7IzcW
 cYpIBTJiIua0bkBgbcmnlyvC1vIpXsbJyuckpFycl3IUZjbD7oymmIClOF0PwTtiHt2D
 4yeQLTt2BYBw4RTbg4llf/2h4Vm7dgBWSlP1PO1BJYwqokFecVlc/FPri8vvRj8S5Haj
 U196j9bn8sCmWZB5Hk1xHcE3b/EUqw5h14VD7j21Car6nLY+bfieNmhjZk0/Sc2vp7Ji
 7RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845784; x=1748450584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLCQ0JmwftO2eWLG55kfspY4mRvxcs+3bUMWqjXAcvc=;
 b=fzrnnreP3nJuc2oR7k14nPvXoocuC91FzcluN9YrbEgSpN2steNXiMEpnMMAa79OZJ
 UYZ4Nj4g9GUc90Hd/ShcDRgbujIKL5kw3Y9Yg3EY7J7/4hTdEqyK2lKcavqQqxA2tnG5
 mVIRrR2r97B25J5x/FH9cSc7peHfN8ousW8aawtZrxHDXky+0WMCspjAsovqMlDSMhNg
 2GhETr/lTHTPzPo/7RDOOgtLU0FIlOf4kxXE8dE/xKLTDJSOuZ6R2bzvm6X/u2Pi2M7w
 5gv1XABchsTGdPtOuSE54yGYo85T+K9OEgk84rm7AtMM9HkBg63gjIALMHsMOmW/d9RF
 JNYg==
X-Gm-Message-State: AOJu0YwLg64dBrEnps890tWw6A7XZVtxQBxdpEH6TBVy/wYS7CRnEHEd
 P4umd1jflvzfVAGiRnGb/MSmWRFcwgNgJzgnfNSD0JDVLgbRwz3mEBCTAhvJyFT5DGA=
X-Gm-Gg: ASbGncvFHo1BD1r2N9Bs08njgJk69M634NJJN5q87zRQdJo58npAR5pfkVWv8t9xcWX
 EnDe4dnQXTavM1GeXfLBedWJMSCwotqeHvskHo/ofL0k3mgGzOkGVL5fbaGgfsg1/VoDQNQn6Fx
 1wAC1KwCl2jgqNkih68oQ19D/4X6IqDaW865l8H92wDvobY8aeRYVw5KaMyOufMF4loX6P5uCmV
 OD9pRAVz7n2eYY1acZab8nk9or8urG1iQ9bhs2iQnKFPpfKeKFKh41dBrtcazVc8uxsAG17wc8w
 c0ypFmZFq6qq6qV5auNLGNROmY1GKiAHx2TRwIU4VAv3AD4VHjvT
X-Google-Smtp-Source: AGHT+IFJ6zpJKynxJ6j9897lu6OX/KzvaysbKB0WwK4oN7bVBIbb1Xtfigst7iHOstI8PJmrkwwwjA==
X-Received: by 2002:a05:6402:13d1:b0:601:9853:5471 with SMTP id
 4fb4d7f45d1cf-6019862aabemr16241216a12.31.1747845784002; 
 Wed, 21 May 2025 09:43:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae38870sm9236811a12.66.2025.05.21.09.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:43:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7055F5FAFA;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 16/20] include/exec: fix assert in size_memop
Date: Wed, 21 May 2025 17:42:46 +0100
Message-Id: <20250521164250.135776-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We can handle larger sized memops now, expand the range of the assert.

Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - instead of 128 use 1 << MO_SIZE for future proofing
v3
  - fix comment, 1 << MO_SIZE goes to 1024
---
 include/exec/memop.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 407a47d82c..e934bde809 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
 static inline MemOp size_memop(unsigned size)
 {
 #ifdef CONFIG_DEBUG_TCG
-    /* Power of 2 up to 8.  */
-    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+    /* Power of 2 up to 1024 */
+    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << MO_SIZE));
 #endif
     return (MemOp)ctz32(size);
 }
-- 
2.39.5


