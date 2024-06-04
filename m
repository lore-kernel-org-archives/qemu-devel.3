Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C5C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQuD-0005OQ-Sp; Tue, 04 Jun 2024 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuC-0005Nm-OU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuB-00023E-8j
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35e0eb3efd0so772108f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494993; x=1718099793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ft5fiyMmdVHsVWcIS5vXcjPxaNkK/GEvLAcOaQ7yGI=;
 b=Mqe/tJPyL8EKxoRQIqyCbZFppiMfOFrLC1gNneeJ5tABTk/5YGKCr2TkezHVllAM9u
 ZWPdZBo+dpk+1YRMchwEd3PXyYmD/zMG8P8jOnraLzS5Hv7lpsZN9MtHPjXyAWgsXL7I
 ePprktmhE+pkEHI2sUn5GY44Sv291g4epRMNOkYSHTQapaoPbq1/be5pqlL61uwQBMS0
 H89DZCbdMj63KJUaW0CQiunhanEx4DtOR/5Z6zlGzDcRfWyf13oHesSKefXJXJR+atcH
 bmYdMPgSgRhmuTGXDBSQQlJOUJf8DUZ7pXIy/HAPTx4EM1Ln0q8H9WceOoF2zaVztVny
 M52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494993; x=1718099793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ft5fiyMmdVHsVWcIS5vXcjPxaNkK/GEvLAcOaQ7yGI=;
 b=w/BThb8dqv9J5w32p0lq/hWTgirwsbd3X0g6fIZdM07fw4zwusEH6D6ko/teDdH8zX
 WzMDSrf29pR/j5iIz2lITmqkRhpFZB4wHHE4fNJMYygOu0+eAYV+cBRCLk9nPeonc74O
 CRZBzO7yLfnXdYgYbiyHwS14rTcfifJGLNNFU6ce9IdbAsXzEpdA7al6yLY6Bi66rjwa
 9+KaOihBtKqfzDYtzey5TT6c1Ezf4dPs/jKtEdD85CTfewgVbRkfi/lOYKyMsRw5cF4o
 lgc+c7pAHx8vcQDbboa2dGb52Zj2TDcZNDpw+aSPmAqTt2r4duHAfUJGp/HgzH4+w7YK
 7bNA==
X-Gm-Message-State: AOJu0YzYWiTmupciicBGLwrnT7tzKrA24MjXLtlVqNWrBFCHCsNXmhSE
 8SUv9zF83WiletMmtRbEWrJPLkgbSko0NyHdlF6tKacLcrWvR8Ae84GqpTiWgWdKKmnzTfEp4Nr
 d
X-Google-Smtp-Source: AGHT+IFOUfeIDokwxi3zlwKF8+obQ6Jnb9GzXIStMD9239fgD4ZM/mEnb7wHl1g+Zrr7HhyvARaWpA==
X-Received: by 2002:adf:b319:0:b0:354:f9f0:a7ed with SMTP id
 ffacd0b85a97d-35e0f30bd3amr7374057f8f.47.1717494993264; 
 Tue, 04 Jun 2024 02:56:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064afd8sm10968444f8f.95.2024.06.04.02.56.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 04/32] target/mips: Remove unused 'hw/misc/mips_itu.h' header
Date: Tue,  4 Jun 2024 11:55:40 +0200
Message-ID: <20240604095609.12285-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since commit e1152f8166 ("target/mips: Remove helpers accessing
SAAR registers") this header is not needed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240529155216.5574-1-philmd@linaro.org>
---
 target/mips/tcg/sysemu/cp0_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index ded6c78e9a..79a5c833ce 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -28,7 +28,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "hw/misc/mips_itu.h"
 
 
 /* SMP helpers.  */
-- 
2.41.0


