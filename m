Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD22E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYL2-0000PW-SU; Tue, 17 Dec 2024 09:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKz-0000K7-PQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:14:14 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKn-00028r-Ci
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:14:08 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso4155237a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444840; x=1735049640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Qal1rB+yavNCgQtrTAwSRmPYHSJg4XL/LhxXnv9Ls=;
 b=lDkEwf9kqg7LxNcde0GuyCMGIdGYi6L7wpH4L3BVQa73/PHBKzzrhoQTPwXIL5tSZ2
 zfgDJnnQmlz2ngVBB5QeIR+A8739DN/Qw8mzOmbsyvaCOKSaJutrT4g+A9OIvmmefhTO
 lOiqx+EanPuD8LXCFRWTvMPvEuq9RZUuKuZSMfsgZmjj7F9icCOtehjFPn2L/jXt+XKh
 z5USDG3CJMjAooWkwNt52d3h3T/wsH0vP56Uw5j8NOTWtsd9rK1qFHgcavxLz6us0qPF
 FG9B0BSJ/Edvtjn9zx7DowITJBbX1gbsk78bsQnI8Tz8xxbDabuGAYC+ORXd6tQlVc6k
 lDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444840; x=1735049640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34Qal1rB+yavNCgQtrTAwSRmPYHSJg4XL/LhxXnv9Ls=;
 b=pLgP6j3SMDkLDsGDNPIpkCjnu7ZRfdtng7dN/rst1TdSDHf+hOvfqAXL2QGgcor+0E
 SB0EEnB8PhIMy5pbbEYWFh3Snq2vi3MhuYag+D5oXgKyKmfl/yWzHY7ER82LjJOppjPl
 72AIsTrGyX3RkORSd4QHkAn5ntucsO4PsEgpnmX4VvdCz6Am4XLVMZbOmcCPIR3PvZp6
 F16MhLfnYhoiKFckLs9VfB6sw4D0G92cx1QM5YJTkLUL5F4CfUHThtNd2WtpzPWyJAHL
 Ukl3QBANPont/LNCduMDlmtfQbFAaVspO87QoNaPkKLtPgWZXtTcY0q7Y8UJmU8cYdga
 k6SQ==
X-Gm-Message-State: AOJu0YxHXd1YNpSRYBDsW1qgz+YAdi/U7SOJ7a3xRpbPQUMjy95Js6yX
 sWQBMjHzXMJWHR41pWWR54SAGDnzK+9oX9tIuL5FbZ7Wt2UKhXRxP0W+ffV4ob81RTFE1qVz6fR
 f
X-Gm-Gg: ASbGncv+0Y4QdLZJ1EhKS3EwJXS9qwBvV7Kcztao2Mc8Z3Z9U8/pncEzCPw4pGSvfF9
 c1G+zKNAZHxBoeV473IeNt2TrSdRI7v/QHcNyXDuMsEg/Bh0KzSA3p3iExGEGNZGifNqNpX8JlW
 BgQg1XWNnK4QJ1bTaipN450I3lzyGfGoRyoshs8iAXX2y41+E7vrDMujm9iw5fYrtbq8syu5p6y
 vk+65ABRngPEJ/S3bO0RX4ixEBvBSWH3NnBfxpxv2hr+Kqp4oIyobsgim9RCaY4jHsHaEFkgYPs
 TXOR
X-Google-Smtp-Source: AGHT+IGKqta6txv2dk0VFHP9m5LXryR2jnEqaFXjWwGbvls4nPBdq1w6k9hotJcM7A+9ISMfmZOiUg==
X-Received: by 2002:a17:90b:1b07:b0:2ef:cbcc:768b with SMTP id
 98e67ed59e1d1-2f2d87bd428mr4913146a91.6.1734444839818; 
 Tue, 17 Dec 2024 06:13:59 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a24349c0sm6640003a91.39.2024.12.17.06.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 06:13:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] qemu/coroutine: Include missing 'qemu/atomic.h' header
Date: Tue, 17 Dec 2024 15:13:26 +0100
Message-ID: <20241217141326.98947-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217141326.98947-1-philmd@linaro.org>
References: <20241217141326.98947-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Commit 944f3d5dd21 ("coroutine: Add qemu_co_mutex_assert_locked")
added an inline method which uses qatomic_read(), itself declared
in "qemu/atomic.h". Explicitly include it now to avoid issue when
refactoring unrelated headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/coroutine.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index ff3084538b8..e545bbf620f 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -16,6 +16,7 @@
 #define QEMU_COROUTINE_H
 
 #include "qemu/coroutine-core.h"
+#include "qemu/atomic.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 
-- 
2.45.2


