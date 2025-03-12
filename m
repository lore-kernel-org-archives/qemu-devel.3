Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC227C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLAC-0001eA-U2; Wed, 12 Mar 2025 08:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLAA-0001dd-J3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLA8-0001dF-1j
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso13585655ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741782371; x=1742387171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIY17leVJs2z4tAUMiT8cAqFys40kyohmzEKVjGlpNM=;
 b=mVegO8oO4JVjpY1xwcltqBCLz2SC6roN48CYvMq8d7oPZVLAiz47T21tmGa0a2tF+I
 bUzB8ME3u/sztx5mR4Foi5imM37xqhrLhemlNvvdbt8hbbdmi9tzXuskPKlLcwzN0p21
 qj3dJZ+/XbLgZbx9WwRSCBG5Ql4Jq98rI0I2s5FhXO/UUoj25iaIOBYRGhDHhtAhmxQX
 cD/dhzx1zQXSMIFh+I3siG0VdBmFyUMzXPC1XQyA/Kn+oLFsl04czfPbwhzoT0q/lU1F
 0nDcroq37eWCMP66pRVA5JpOhCDK4pcwtnQGVS+4q+ZQBSywbmbhgEUqnhQe7IBWhf39
 h1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741782371; x=1742387171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIY17leVJs2z4tAUMiT8cAqFys40kyohmzEKVjGlpNM=;
 b=gZXmjVtSiG/byKYLmhVdgh61rIWotwOmzM932IAdNsVosRcc7cF7JGqQJejmRfJ9ts
 OUg0eOw5OUGm7IFGMZ2+x/xPAVIAOp5pnBHwAqfzodzqe03xNe7UymQ5nhDvJq+DAVo9
 m/01F4vxR6OAzNMfRYR7VC6f9THD1j3XRzCfJTz7kJEnLjSMhYkAUQyvDujJs5D7bndv
 ILxnPlMRQmAU6PlMlTpjLRpQQBWY2AfqZQeYztWxhmwe8j/wUjeDx8HW33cjTtZEnTeC
 PDr9l0EUEwxAxInnCrAlpuY+75GOh/YekXPCzWKvoF9vwEW7R1Mo1UGUKWOwoANvJ6cc
 h+8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULHEDTnpfDSIpK3VacWsMOnRfeSubzN2Feq81vzb+ZfraEJ6/FhazMvMXzqS0uRqAbMWRBarPa4mRx@nongnu.org
X-Gm-Message-State: AOJu0Yy51LaIkXy7D4u2p/RyyIGpl8SG6Zv2fuDBKaNWtbUmyiLnvYPG
 hdMxyeqJq39mQRIi4Lbl8oHzJvWBymLU+xMiIYebnspdLUGiUB0S
X-Gm-Gg: ASbGncvPciqUI0r9SJY2+Snd9Fm9KbIm4uzEwb8G6FJicMZ7i4L34L64bg/rV/u/31B
 8v1lB2G3vNLE2yulyxPxopDnsopqmIHDtOTQtQPktSLo4E6qYHhSxgbqdouDH1PZWKNvM3U3oPI
 fjIt81f41ly8k+Xd3BwGa0ZnORyFtiu5HgyTRQVEn/xXJqoDfCTA/w+CZRJcWdxv/s9ZNzjTVMv
 yjrCcMLimQJTr6lPRjYih+K7mbWMgKh0JltjDQ85FP1kwd/J1v6EyzYjWO8kFKQn3+LfELvZGYR
 pu9NAkHhkKHLSLPFKuVxnWgBxIWJxatAF0afUzM1pQKQHzYKPvg=
X-Google-Smtp-Source: AGHT+IF+TjI7wJD4rF9NQUlubzjMOWpKVKBr5lDqtHsv+SZJkKC+qq11frN8D58CXiH8N9bWZI5W+g==
X-Received: by 2002:a17:902:f611:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-22593d78ca5mr99211985ad.12.1741782371247; 
 Wed, 12 Mar 2025 05:26:11 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ab33e1d3sm10842408b3a.132.2025.03.12.05.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:26:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] tests/functional/asset: Fail assert fetch when retries
 are exceeded
Date: Wed, 12 Mar 2025 22:25:56 +1000
Message-ID: <20250312122559.944533-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312122559.944533-1-npiggin@gmail.com>
References: <20250312122559.944533-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Currently the fetch code does not fail gracefully when retry limit is
exceeded, it just falls through the loop with no file, which ends up
hitting other errors.

Add a check for non-existing file, which indicates the retry limit was
exceeded.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f0730695f09..27dd839e705 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -138,6 +138,9 @@ def fetch(self):
                 tmp_cache_file.unlink()
                 raise
 
+        if not os.path.exists(tmp_cache_file):
+            raise Exception("Retries exceeded downloading %s", self.url)
+
         try:
             # Set these just for informational purposes
             os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-- 
2.47.1


