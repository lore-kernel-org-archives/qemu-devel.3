Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A60C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdsn-0005C1-MC; Thu, 30 May 2024 07:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsj-0004yr-Ky
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsg-0002iL-Uy
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a653972487fso50903766b.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717068216; x=1717673016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+o7pvKT5BEyXPcjf08fbyMOFKdf8fhc0Qm3mgZwM9Y=;
 b=VNzi8fn0eg/Ulluhc/ZKD6pbgRlAx+yhFaGcxCYwfh/LzL2KEzUVfghC5o15kzjqu6
 NCzL215qLiklabu6ZnJayUOQFw6a3PMtZlp0MDvO7ffEveqfC0u9Zg8srfaAn/0mpE4L
 zCfbxiLK/SZH8mQJYRrvUkFKdaNoy6GsQWRNPcTcdhYXmlAqDwUe1cWHb881xa1XpoiB
 PvtpjraVlLCBcDmO7gqWpxVxnaxSbTNf1IUDrx24gankv1aqcgE6OoYQGqJgynlVvbzT
 nLJVsltUrRvdsDBCLs2EFKm8MRCNhZ0n1I/Vz5dwqvp1HX9p6K+XFWg8FGC760iVFTB+
 2rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717068216; x=1717673016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+o7pvKT5BEyXPcjf08fbyMOFKdf8fhc0Qm3mgZwM9Y=;
 b=DjKpfkRI4BaUbbvkJj9ERgR/nCtdsuMH5s03Ayh1XYVLZ5aWt5i8lWTVVaPxHGCpXF
 XhMvQNwa5d7RaHsV+J3Itv/mnUiQV7ni2FcmjHzxRyRNYEKAbV4unTzatoxsloWCBguz
 SJRHhUikKoEzTBAFaK8CKz3ueXvzsfXJLBZ2xBZnMMit675mXWYFJTSpH6pcLZjtHDDs
 BrfIr/qqrb4+Rpifmt+pvKy+tBWfW1CcveuvLWEszd7CzQTM+JWK45EHxcqxP8A1LuT4
 bV5KTBGpuqVnrZlhs2BBxU9R0OpLS4kDN/4xu5LLdH08yExmSSXPMo1vOCJwvUsfigFH
 5gcA==
X-Gm-Message-State: AOJu0YyDbjAl62D4vB0q+WOjYEYEOLW9T76MHVSVTuRqYm1QV/IyWcA5
 rZ+ir7Tva7CFiX+5vnfvpoqCq5IuLvh5kvq2Y5vsUHb+yGfkocT/fFyhVdON13s8fRAkE9LuLat
 c
X-Google-Smtp-Source: AGHT+IHBLFTlPDPzhixtUVGc3NrlpIEvwqp1Ai8OrjSSF14eKdAzOCgXNy1VLpz2ZUHYwzKNmL5Xaw==
X-Received: by 2002:a17:906:d7a6:b0:a5a:3c65:ccc7 with SMTP id
 a640c23a62f3a-a65e93820d1mr119107566b.75.1717068216594; 
 Thu, 30 May 2024 04:23:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c8182edsm817403866b.9.2024.05.30.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4F265F8CB;
 Thu, 30 May 2024 12:23:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH v2 0/3] add SYS_GET_CMDLINE test
Date: Thu, 30 May 2024 12:23:29 +0100
Message-Id: <20240530112332.1439238-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

Looking at bug #2322 I wanted to make sure SYS_GET_CMDLINE works as I
expected. While at it I needed to fix a compile error with headers
which I guess we got away with on earlier compilers.

I've added an editorconfig for good measure.

v2
  - addressed review comments

Alex Bennée (3):
  .editorconfig: add code conventions for tooling
  update includes for bare metal compiling
  add SYS_GET_CMDLINE test

 .editorconfig | 29 +++++++++++++++++++++++++++++
 Makefile      | 22 +++++++++++-----------
 semihosting.c |  4 ++--
 semihosting.h |  2 +-
 string.c      |  2 +-
 usertest.c    | 33 ++++++++++++++++++++++++++++++++-
 6 files changed, 76 insertions(+), 16 deletions(-)
 create mode 100644 .editorconfig

-- 
2.39.2


