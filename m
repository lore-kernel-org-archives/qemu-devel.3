Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373F9C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcd-0003m8-Ap; Fri, 25 Jul 2025 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbz-00035w-9I
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbw-0002SO-I3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so442300066b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458326; x=1754063126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY/auZzeGDfY2FoWi/fBd8zngCsKbjYbcPImiiCVnS4=;
 b=R2BktGZwjrtXv175L04n8Ti3sGLymv1azhU1zAXl17pKmq0Zq4scAlSf9rtvUwIqRv
 bCO8zhPM5qYSJPCefQA6sKRVAk4uRDICNkdbjw1/bbUYVAdWwaUFSGVjPsWkJQc6/4h/
 DioZvKtdhiKb+dKkzGO5F/MpIKQYws+AUNaizI6AdEc2KL6HNd6LWG0U5JmfOUnQMbZM
 OajTsUz29I2gkfesVj28T9wTEjHhz5aj+TvQDlAlokqA3kCJhcq8w90qQ0YgwisEmD9w
 MaNYJrVnU3bMauptE55Wqu59/sV+P9Ulazo5UPNc0V9eES7ih4dtPuYGDQJIELcFaEbF
 bd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458326; x=1754063126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DY/auZzeGDfY2FoWi/fBd8zngCsKbjYbcPImiiCVnS4=;
 b=UTJ4hoDpssw7h+ui+fjHMxpXZtAYt6tSnqqWITe5SCNfcGYMKKCOY/P4hYTizEduGN
 O88CG3gBzQD2qVfWqOPUAeSBpmZLsdebYwXoEiLTfJQEIILl69rrLpPZJiEU5Zl0gJx2
 ViEDRkjTJ9tCnW7km6lA36xyx/lGJ6jqI6okDLXUVlh52GrBrx0RtOe3nJvowmnKjMyT
 XbuILiOCAAeS5r+1km7i1zkQWH1PpYVN6v1wRdxKhHOjBMtpSv7AjzHgfIvNGtERFDxE
 i8tKZdYqPvQvrCefn7WnxpP+Y1EvTQmnZw712unYByK265IctQHgvVA/wiOsp3WrMohg
 PUJQ==
X-Gm-Message-State: AOJu0Yy+dwCKkKcAmBhEOYrlvGQ6zIjJoSCXrSc0d+XZrefo8hHEFL71
 +H2TCiZuvLVLtCqVHQx16KRNHvlTXhffBoQ7lB0fHmMeNO8fr8v1bcLpjv4yZWWOmoQ=
X-Gm-Gg: ASbGncsQQHlbAbmDxK1i/sY+NgFvQ20BlPXqMnPROLNQZNvWfuMjCXahCiz/u/v5umC
 7OTw/SZUWjvGxa5jUBpOL7Bfx/+52e9Q3mG/L9p3BZxu1dvWB1KmafyreU0EdE6idRwG0Y2Q5iY
 A2Vra8D9b7bzzSO44LKc93SB12OffDK/NXXPFhn+ii7PC+IRmvMCfgqR8JBVC2VzQaOtbeUdb1T
 SuXuT9Z2mXd/8IcA2yZjYabXoOUviLW3ftD5169amKTsIkEbkMfjVsD7SfwwJgdjDSzmn5JVqWg
 GraLJJujroWZHI6iL8UAG/WH/QmIHqX7NVwlmg9ltCqfJklU8BYDCrNbhmXzQfUPNSGTv5eOnqh
 G0Hkknbb0csES7SorDA4f4qY=
X-Google-Smtp-Source: AGHT+IGhc+DzzG5zkKzznMyj991NDTVBbFEorG7dAAYJ+rsir0JUM9PSs+wbQ2lt8kx0dGHofqv1+g==
X-Received: by 2002:a17:907:3e9f:b0:ae6:ddc2:f9f4 with SMTP id
 a640c23a62f3a-af61c2b4194mr296809766b.6.1753458326075; 
 Fri, 25 Jul 2025 08:45:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b08846sm8320166b.140.2025.07.25.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46D415F8BD;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for 10.1 v2 05/14] docs/user: expand section on threading
Date: Fri, 25 Jul 2025 16:45:08 +0100
Message-ID: <20250725154517.3523095-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Potentially too many weasel words when describing atomic and memory
order issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - /we are limit/we limit/
  - use QEMU -user-mode process instead of guest
---
 docs/user/main.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 05de904225c..347bdfabf8c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -46,9 +46,15 @@ Threading
 
 On Linux, QEMU can emulate the ``clone`` syscall and create a real
 host thread (with a separate virtual CPU) for each emulated thread.
-Note that not all targets currently emulate atomic operations
-correctly. x86 and Arm use a global lock in order to preserve their
-semantics.
+However as QEMU relies on the system libc to call ``clone`` on its
+behalf we limit the flags accepted to those it uses. Specifically this
+means flags affecting namespaces (e.g. container runtimes) are not
+supported. QEMU user-mode processes can still be run inside containers
+though.
+
+While QEMU does its best to emulate atomic operations properly
+differences between the host and guest memory models can cause issues
+for software that makes assumptions about the memory model.
 
 QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
-- 
2.47.2


