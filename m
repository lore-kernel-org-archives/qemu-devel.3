Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8B7C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 21:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTQN-0003Oo-BH; Mon, 15 Jul 2024 17:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sTTQJ-0003Nd-Ms
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:39:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sTTQI-0000KP-8L
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:39:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ca8dfa2cceso3114792a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721079590; x=1721684390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LKnr340UTev84mGh5T6HxSF9s3tgt/IdANDbkIjASfM=;
 b=PAAzRaVN5RzsurTEu1QN4XOST4dptXUKyH/H1aI3/Ycna5KyJdghiFgDmrdESjA8NZ
 77qi8fV/1hRzIPgee/V8eJGLQuNQgT7+n1yhF10Gk0d89rJC4ifqeHNAGoyUyr9txlBT
 hD9Zj6dhcUduawyTcenlDSflcE5YcAPm3t9t/ujCz5NsRz8K7dFafJh5Brg/9vL/0p9D
 h5TaTXxnNGvXzPqvwMMNrPHP99pLpukSh7D8YFqW35DRV2qtdG/EEXPdStz/uv8S88r1
 7Kr66dUJNC1gkSjlMadqQJ53FHdcyjj/EaHaB3Mi6VgPi06MN6UqhQyqrr0LbWp7ijjE
 bTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721079590; x=1721684390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKnr340UTev84mGh5T6HxSF9s3tgt/IdANDbkIjASfM=;
 b=Lx1SHAcCQZWSti2gkbxKFjoSyZvXZykdE7F8tlb8CVIW/Pqj4l2ospDvZhivk5+GRA
 d1ZCugKkNsmdYu6AiDadcLmJpilMf3LDidXHNVxMjw3NcrHcbWfQgKRR+i+xPIfAOLWq
 PQ75p6HCdeUPCJyqYIBgMd6o6GmWKUPEQ46kDhWzjRTVJbcO+PevAQwn+iD7K1C6zdrH
 /Lb+RCYsD7huqidkQGbtqxwUO6aAWiAnbjO06w5cAZ9mh5Qdc32PPSYEseOHcjdC5dAd
 lgYV5N/4Oz7A/sW4SEe9wvzpiKmUYQJDgyeo0YJPT1AXbZi7V8SSC0mFEP66I8HXUTDc
 5iYA==
X-Gm-Message-State: AOJu0YwSHUKdRZQMdBK2HjS1uMLKZgBT2y9reICop4KPKGy2/mfoHx7g
 Jtu1LbPIsgY/DI7OiR67Jf0cx1U5RQ+vBTNAC60QPMLPitmBj377jeHBLXSu4CmScNFxBUo6P/1
 s
X-Google-Smtp-Source: AGHT+IFFobDnD7m4rUzeC2qcnn3UrLT1qJhMIbNpKMCtJRrKeRsdcWgwpQ0G9Suu3JJimfQ83441Lw==
X-Received: by 2002:a17:90a:d48a:b0:2c9:98bb:b9fb with SMTP id
 98e67ed59e1d1-2cb373e87ecmr129957a91.10.1721079590428; 
 Mon, 15 Jul 2024 14:39:50 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:41f1:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedc92c0dsm4861138a91.41.2024.07.15.14.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 14:39:49 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH] disas: Fix build against Capstone v6
Date: Mon, 15 Jul 2024 21:39:43 +0000
Message-Id: <20240715213943.1210355-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1035.google.com
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

Capstone v6 made major changes, such as renaming for AArch64, which
broke programs using the old headers, like QEMU. However, Capstone v6
provides the CAPSTONE_AARCH64_COMPAT_HEADER compatibility definition
allowing to build against v6 with the old definitions, so fix the QEMU
build using it.

We can lift that definition and switch to the new naming once our
supported distros have Capstone v6 in place.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/disas/capstone.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index e29068dd97..a11985151d 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_CAPSTONE
 
+#define CAPSTONE_AARCH64_COMPAT_HEADER
 #include <capstone.h>
 
 #else
-- 
2.34.1


