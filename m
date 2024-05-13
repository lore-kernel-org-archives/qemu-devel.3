Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C42EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ty3-0005SO-9v; Mon, 13 May 2024 07:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txh-0005AL-82
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txf-0001QZ-N5
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420104e5390so16567505e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600116; x=1716204916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X9jZxcJ5ik0WjtOOJEXtKwHbeCe/bdGG2ZPreWMpmg4=;
 b=L3jvxBepr2retLRMDTPxXIsAg4s9Cfu6GJs4XF7rHiIVAGPsM+AezIGW4ASOwRvKmX
 9wuWpi5m4Sy/XdupCGRp98z6+qMAtC0FLsVMFLtN78yMLxdmWO3L845WtPYOZ7n6vdWd
 /YaQxbA9/i+UW7vwF8uhPwZlLsB2UCOHrW+/GDdpAktFIcfp0xkbRUbpafpVoluWK/hY
 Ms4UfupsNs7TwJ3Cit9QRrtYZLUuHRUv8HquS7lwNdlTcus+FBXx5kphEWKVfWgskxkX
 tNHOlrk3oVGF4yyoinV132iz/0dHaGxTDEQmVfXHnBvSynOqwfQ9/p8DS1sD6S2TcidP
 PX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600116; x=1716204916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9jZxcJ5ik0WjtOOJEXtKwHbeCe/bdGG2ZPreWMpmg4=;
 b=Rhq0pJ6DeYy7raLs+nEogmtFnHCw7okWf0XwtFx9NoKz9ImgFlSZmm8SQmgL6jByAZ
 7KLAkV3fRw4hmy13zg22033bJ1WAk9TA37bmWNHwWkzB6mR1bzeTiOAAEAXwDSeWv8x4
 jBlPvzR4s5kO0WPCU+IxJbnDNRhmkzSJZ5Tb3uGzVXk+HDyD7sbVw5is/VZOu756feqv
 Bc6PQNqY7WEqB05HH8NpREEZtl9rWgZjWzF1UuCREcWZKylBnKw20eNwq8KnXrEGIYvy
 mVQ88W5w3++OCY3AbhSc1ZUDZSEAMM/SkqFzdWr+Ht48Dg48FQ2+d6PvyNW4ae67V+LR
 6lbA==
X-Gm-Message-State: AOJu0YzlMIctK88u0GtDuL9MbL2ew1INhdwmeqVcVgDkzhVoCAm8hfkc
 urIp2QplZfD9ysQupX808OaqJuZLlcuKRQRTO6r/xZ1f3de5t6Zy/1xZlXQLk2Y=
X-Google-Smtp-Source: AGHT+IHfoPd1wkEKzEiMszs6hcP8/nsMcoYZjpV3KEkUXA4ALIjpu0e7qhV63swvCoWgcmIjf/q7Ag==
X-Received: by 2002:a05:600c:3548:b0:41a:6edd:6c1d with SMTP id
 5b1f17b1804b1-41feac55e10mr83254315e9.32.1715600116338; 
 Mon, 13 May 2024 04:35:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41ff5e3dcfbsm116015205e9.22.2024.05.13.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:35:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5038E5F8B5;
 Mon, 13 May 2024 12:35:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH 0/3] add SYS_GET_CMDLINE test
Date: Mon, 13 May 2024 12:35:10 +0100
Message-Id: <20240513113513.640007-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Peter,

Looking at bug #2322 I wanted to make sure SYS_GET_CMDLINE works as I
expected. While at it I needed to fix a compile error with headers
which I guess we got away with on earlier compilers.

I've added an editorconfig for good measure.

Alex Bennée (3):
  .editorconfig: add code conventions for tooling
  update includes for bare metal compiling
  add SYS_GET_CMDLINE test

 .editorconfig | 28 ++++++++++++++++++++++++++++
 Makefile      | 22 +++++++++++-----------
 semihosting.c |  4 ++--
 semihosting.h |  2 +-
 string.c      |  2 +-
 usertest.c    | 26 +++++++++++++++++++++++++-
 6 files changed, 68 insertions(+), 16 deletions(-)
 create mode 100644 .editorconfig

-- 
2.39.2


