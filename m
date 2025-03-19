Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8529C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4N-0000Gv-2Y; Wed, 19 Mar 2025 14:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4F-0008V3-0r
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4B-0006MT-GM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1331747f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408577; x=1743013377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDUb7w8GKKpDywt4UPFksGcZt0JQXrqn/MAMj7YlIms=;
 b=yQ8JpidZIIZxZf8nSYJI3GvCoz3wJsyF6ww/heRXiMCHBlKOP2WA6uZq6sO5PIGmGG
 En7zsMOR+kMJoXQTHTqOlp9H1Jrmf2UuOg712L+2OuKzMdL4P2vBOZSmB469b2wIGigK
 etZpYH+R5ozM7OT4hyLlMvG+2Lkt4gnKir9YMXomyYy1UZQDgB6BTX6sAU/vco9ydGSu
 T+CyMjs/D7oJsEXjEd6RpCHLc7Ngno6eoB6oJV8jOEd3LXimlOfJGcRHd0PJqQOaJvv0
 JDf6CQd6N6hqdShdeOcPwvjpJH9XBzqLdIEVwNyDuLrMsk8jTadfBDqDYyNXMZS3ePTr
 UhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408577; x=1743013377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDUb7w8GKKpDywt4UPFksGcZt0JQXrqn/MAMj7YlIms=;
 b=tr2eEcBLkH+aUMTdrrkO4WdQ/MN1L7UYNWS8DZflPZ3H8xjD2HvHhAd5AobPPnrFIw
 IjxMQecl5pgVHtadiFcdJc3D9AucgUNBwUUWqJj8AUfCfL8Xd3K1S5heQGyc5et7hNob
 xurWhnoq+JI4dwZAj4urXzVxCI29h7GXvp3PGm+S8l7kxnwkEoh7LWDuvw+7ainUEWaI
 ulyVfShOvGLbl02Fx/QkU5zh63AkS7xz235s+mEPy9f2/BPXOEX7tLXT58CxIjD1rKYW
 hP4pyF4dUumq5vydocRCuRAp4J7o7x7d/nwBBQN5xoLbnlSJMuPN0oVKZHjV1TtorH2P
 KQsw==
X-Gm-Message-State: AOJu0Yxo4PqDvjyMhUYBDfBSevOo6NFEZssy2FdM8K4d+EmZ9vPbbTAP
 T/FKikQziqhxZ9nQWNYaA42W235aA4LGftKR/q/MfU6QUivyZPK/01XyI+aDY6Y=
X-Gm-Gg: ASbGncsAChtTa+7qeOsIlN3CdF6NnC/CTt+xkMmcMbfCmEAeMGp4TXagxRziYgXcuxM
 pKst44Z0LOccPeqY8lwsKFgSfvtb1cAAx2qKZ7LS9rVmDdYyJDU3KtwvjBg5IA4zfSyViz0Hyr9
 2+c5a+oydIDrd8p6qlPiUhQ7q2XowyrCPl5E9rQ2MTtD1B4WoxC2fX+sO86szyKz+qTWBqHViTI
 yr9QXP6uSm0uRDLT8GUseL1h2TsBOMiYAQmmM8LJ2CT8ATlXxF9iPxnJJITofdXq9yXU8JTGN8b
 oGU2bUzXNCP0gvmNq2CKokgOtpQWMLvjWNWXU67IVkFE6zE=
X-Google-Smtp-Source: AGHT+IF8ov831vSEErLM+GNa70tGIkWTOO4IfBYBqQH3lC1weVVD9w6iBzholBos1ABfwh1o3q9Cow==
X-Received: by 2002:a05:6000:1787:b0:390:de33:b0ef with SMTP id
 ffacd0b85a97d-399739d3dbcmr2798743f8f.30.1742408576770; 
 Wed, 19 Mar 2025 11:22:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a27sm21877226f8f.31.2025.03.19.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D41E5F954;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 01/10] include/gdbstub: fix include guard in commands.h
Date: Wed, 19 Mar 2025 18:22:46 +0000
Message-Id: <20250319182255.3096731-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 40f0514fe9..bff3674872 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -1,5 +1,5 @@
 #ifndef GDBSTUB_COMMANDS_H
-#define GDBSTUB
+#define GDBSTUB_COMMANDS_H
 
 typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
 
-- 
2.39.5


