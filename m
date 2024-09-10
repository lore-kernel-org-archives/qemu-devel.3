Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D66EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1Wy-0007Xa-48; Tue, 10 Sep 2024 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wv-0007OM-Qg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Ws-0006U0-BB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so6924033a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977257; x=1726582057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQdWQJOdy0yNPGoyktr5h9MWk5hDnvlzDOKzVVqQGjs=;
 b=jYoILo0jz+FoSf/vxYo/eKp9ucicuqrMM513i3F1nUcHwV7H9sdcg6I4DpHiiJUkhh
 mzMx/CqhTYwnwfrTMIKkN0K34+nzKoJWIk7BRuQwXL1xzhoiyeVJzJ5rCP2gJ/6Okrml
 8j7BwMJE8v+UhsmZsjQjyb/eDqsVGJFdrf9OY7vyQHhaS6rDZu47AdWNUD+rGwW2ndZR
 at/jpD543N4eP/pQl5pPpFCvlA2mQ6DaTjaAbp5yTqu80JzAgHllYxF9dRmKxm678O7W
 mxvQdHkiiice/0C/cG4zZgroBsxfoSDGwoA0BRXQwxQgzpyKjUT7gGZH+P73w7My30dL
 cjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977257; x=1726582057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQdWQJOdy0yNPGoyktr5h9MWk5hDnvlzDOKzVVqQGjs=;
 b=NDwkO7ocPmZzRpsg9Dn5YXSR14OXuDa89U2slvLCjvDoS3cAm6QymQb4Azuz9+888E
 kOKCWSzcQ2d+B1BGwgL+4RrKj6KGinDnUfrs5S450MuQWHok/v3Z7nYcHRviQJpJA12e
 66kLv5+OJ3Gq2Wte+XaBAx/lF07nfHiXoXhBbtE3xjaXo1M3nriJ+7fjbNYxfmRnu6kg
 wEyUbtBuztbHG9Fy/DYfw+iz6SE+hWD3lNjBtBu6MAjrUNAZoDMhHPkAs+T91NgAspK/
 WCmh0+gMZZjrhcr861lIVdielTw6plDHD8JreAxhD5tr0DctbQe/A95OJImJWw9qf56C
 BcUg==
X-Gm-Message-State: AOJu0YwblyK004IryDXnlPL5xFk6UfL7EWP7jJ6Yc/eoS9/6XyDSI7oT
 LvbX12SQ4cQ/619m59a0spjBhdVXvWqUJP8dWJ9T6sFaa7HWFxmtYIyjH0utU6I=
X-Google-Smtp-Source: AGHT+IE2U0uHU06/Vp8X2hd+avzIe7NO4Zox0gqTRxzpZB6uesrM+rBCmQyq9iS6tiXXMU7g4SBUOw==
X-Received: by 2002:a05:6402:1d4d:b0:5c4:95d:da34 with SMTP id
 4fb4d7f45d1cf-5c4095ddb7cmr1039308a12.26.1725977256520; 
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41bb2sm4296386a12.14.2024.09.10.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9E8F5F86D;
 Tue, 10 Sep 2024 15:07:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 03/26] docs/devel: fix duplicate line
Date: Tue, 10 Sep 2024 15:07:10 +0100
Message-Id: <20240910140733.4007719-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

I guess the same change came in via two patch series. Remove the
repetition.

Fixes: 2a851fca9f (docs/devel: remind developers to run CI container pipeline when updating images)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/main.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index e9921a4b10..09725e8ea9 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -500,12 +500,6 @@ first to contribute the mapping to the ``libvirt-ci`` project:
    `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
    page on how to trigger gitlab CI pipelines on your change.
 
- * Please also trigger gitlab container generation pipelines on your change
-   for as many OS distros as practical to make sure that there are no
-   obvious breakages when adding the new pre-requisite. Please see
-   `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
-   page on how to trigger gitlab CI pipelines on your change.
-
 For enterprise distros that default to old, end-of-life versions of the
 Python runtime, QEMU uses a separate set of mappings that work with more
 recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
-- 
2.39.2


