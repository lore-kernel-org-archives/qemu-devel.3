Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55816C61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 07:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNoJE-00030m-On; Sat, 07 Jun 2025 03:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uNoJC-00030M-Qj
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 03:49:42 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uNoJB-0000UY-73
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 03:49:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso498964a91.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749282579; x=1749887379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cfDoMuhI7Gldw7nCdfYIkXAF3bm6PbFrhph+ITePBMQ=;
 b=bMNROOKdN3aIKLCr253+8CuYFaM6SQt9ghcQ/CLqg2FAW3pBpV+zLtxqHC8f/k18Ny
 4JOUWJsn8284IAb7JWPjUemPTEUqAXz0580ouGiBQFjHXSGCk0rNQLJj8zaHfgE+CgSk
 aVo7CPI1jGF+o2PTg3mjuBJhxADoHsx4I3Xbg/5aC1tWHosJsqYBmM//ObcgD/iqO4Xi
 crtFmBGeu/wVEbZ6kZoBVCKYjK6Vm4RKTrNZ+8LOeg3EEV1XKnDpFa9GxgnH76VaVtps
 LWvOkVfy1r4bi4LuZRHsPVdo4mjepVivHUm8mi6bMcGXfNOThezGvot7wCwzJ2HV/n0E
 idMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749282579; x=1749887379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfDoMuhI7Gldw7nCdfYIkXAF3bm6PbFrhph+ITePBMQ=;
 b=E26YCBMCya+NnKL/PSVaa++2cn2SbeW8LFVzYBnwO/qpf+sVryuvl/ruKsTGZT3J5Q
 qIZLufShvC0vF5kLAkKbbSxj6kaai/tvq0KCxYntNB7fJmFdak0uWQFCiWbZG5iqa+GP
 2aSxX1v2vbY/dS6IOAMpvJN3tMGZFTpp1JB8Ak6xONcMbExzqT+dcTby5orMhWkKY1MB
 u+/RmP2A1TGOAQyOwvBuru9vwjSJaZgluYwPINPTKtkLiApNCP+rY1bEKoBjdwkkOGH8
 rxUhiQwqmdqPYJBfKTX29Mlj9EWm+zlbvrGpUeOLeisHo4H7wyveK4/yCBN0Y5crJA91
 e1Fw==
X-Gm-Message-State: AOJu0YwEqD9CznNLN90FTwsDffvNNZ46CU6e3bUAoF42FYKzdO34Eqct
 ZiYYYyA3cBORWuo7lKJmCkAzrOsveDmIIx7sYwPNpVzXi4926J8Qb/VtHbFcDh8YP81mGA==
X-Gm-Gg: ASbGncuQgZzwSWh+O5avPEyk+cP8KUCUBNj267v1AUSUWXC1kv8dGchYM3nA/KbLQxW
 QIunNokJYcV+krsf3gP8kCZi0K+lcNrpqgbNtAZRXUwF4G/GtdlDGLOgDJ5uGMPvRnTx0pMGFOf
 nb9073J3aAdwU6Ga/MVHMjn1eRGlSuqtkcNh7dmVvtLOe17jU9KkhAT2e8lyCRHjo9QSlLwbevZ
 OsFZaJfSaIJM5RPYJNxYClS/TDanu2+7b5RBdC5MK0zHVpC6i/sQyMWHfL7n9oJYxwRQ8aHNrpx
 3b72sVBgjap5ZEiavkcTNtJkhCvBnlc/l9EGvUmZY4zNkQ==
X-Google-Smtp-Source: AGHT+IEn9mCv4z3Fgw+8D+zkW+LLVM+HyfGHE1zQwpEpv/7hlL9mbSPklSHK5+c0UFbi971y81ioRA==
X-Received: by 2002:a17:90b:3c89:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31347506b75mr3459989a91.3.1749282579452; 
 Sat, 07 Jun 2025 00:49:39 -0700 (PDT)
Received: from bong-com.. ([210.97.55.153]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603406659sm22639525ad.186.2025.06.07.00.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 00:49:39 -0700 (PDT)
From: Haseung Bong <hasueng@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com,
 "haseung.bong" <hasueng@gmail.com>
Subject: [PATCH] tests/vm/README: fix documentation path in tests/vm/README
Date: Sat,  7 Jun 2025 16:47:47 +0900
Message-ID: <20250607074747.56072-1-hasueng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=hasueng@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "haseung.bong" <hasueng@gmail.com>

The README file in tests/vm/ points to a non-existent file,
docs/devel/testing.rst. Update the README to point to
docs/devel/testing/main.rst, which now contains information
about VM testing.

Signed-off-by: Haseung Bong <hasueng@gmail.com>
---
 tests/vm/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/README b/tests/vm/README
index f9c04cc0e7..14ac323309 100644
--- a/tests/vm/README
+++ b/tests/vm/README
@@ -1 +1 @@
-See docs/devel/testing.rst for help.
+See docs/devel/testing/main.rst for help.
-- 
2.43.0


