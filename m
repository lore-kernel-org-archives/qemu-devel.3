Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E0DCAC5BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28L1-0007wE-Tp; Fri, 26 Sep 2025 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kz-0007vf-4U
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-00041z-SM
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso12825355e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892667; x=1759497467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuPD+L61acvA0x8PKEn4VJj4NNmgzobTUEaPWcs990U=;
 b=CymS9TvZOWq85rmrmqwwMaYT/C4V1TEH/UYLqiRay7L9wU9m6+8WbaI2R2wg9o1NzW
 aB9Te/7cbA0DujBajnfd62V3cVwQQgqn1e2UB9AAFScLGJtNDUVxy9TSp/OMwNKSYLN6
 zyDozXb6CnBWXi0nsue9OxmOK9s4XH7odeLK0Ys4Wc0sB2a4D/+5w7guhsXDWsUV0Ggd
 SeS2I7GOT42HULU/PCytkJGbBmzukYrFJv0R2ogXWB5+DqI49b9Bg5qTmMwHXOKnpdk3
 hCvSKeSTmum/ArCOywrciSagpbNx4V4jjdFrc5A/U4KuzstAXhrMTsx4w5d/aAbAdTA2
 pnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892667; x=1759497467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuPD+L61acvA0x8PKEn4VJj4NNmgzobTUEaPWcs990U=;
 b=Td9jlkdsnxB3c0gPhZuUUGUP3O6w9W85sCyRdwH12quhCHPMLshtqc7yW6FdQk2/1L
 x9U6jEQQMqtPY8yc74tPJTjDJZlMINYoTR5ehnTa1AvsDhNR3hOvcoGyo3uRlgeFjWBC
 RsTwQMN98mODiAOPRcrwtLdC4377pDkWv+K14fKZXXIkF1JW05qilDyGSq71Kx3htZIf
 4X2y+YnhPQ4PZO93hfyg/d60A/R9nwPWhdY9sEAkCxuSikSTZ2Xtwh/xYK8fYiHaRDwJ
 /RlYeSHF/8XNDKc4Y9m2W57o5/b28v4xW3bfOxBcVJ+JTWLn//wSef4shJHoLQ4hOjyX
 i23A==
X-Gm-Message-State: AOJu0YwgIkNTIqks8Zp3lcuL5EMXVMIeVJTO/TceIqhcyUO4envQ2KfO
 pTNbo8vByE0vQS6/dNV4t6242JQciajFWNbeqPL/6iL6GborfsMu6s/63iG4FXZuGSc=
X-Gm-Gg: ASbGncuXj4aadhW89cBh87CzuGEOUdSmwpL5VdEGIx6FoH108u26KuB0lM77nWE34cH
 04ON+ngT54+riaN4tPOgTA+mLFZNC4sOPm5gXJ2RQPsmHnNJ0QJI1YBc/bgcmuMqLPDMvOx3yoI
 9zZLgXKhAWCj1adROp89FeXTjGEV3rO4ns077yobaoR7jual0tD2GKT7gQzSEsRw+uX3GSFn2FV
 7+7Km2KTL+1KMbGele+3kbHuJPe5u8TYUMJClC+xH4vpzFDOPeNyl2ZaS98aklwxwqTnlz8gPw1
 eGOXJi2B9QA8zVkRjFCQDT62lTK8su8JGqd83tvzPLqHqH/6Q0Y4+G3o/UmBsyxCvXzK4mnMSGz
 lVfBen9iJozpDh5xLYGFA6Bo=
X-Google-Smtp-Source: AGHT+IEvwMYJ0STpamQ6LtPXC30S+bE3uFkVgVceMGkjSvZY6sa0z5vbPATgnvqCi83D1cMAp+5OxA==
X-Received: by 2002:a05:600c:a09:b0:45f:29e4:92fc with SMTP id
 5b1f17b1804b1-46e329eb12emr65161935e9.20.1758892667375; 
 Fri, 26 Sep 2025 06:17:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bf6ecbsm80460305e9.22.2025.09.26.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA4365F8AD;
 Fri, 26 Sep 2025 14:17:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/24] checkpatch: Ignore removed lines in license check
Date: Fri, 26 Sep 2025 14:17:21 +0100
Message-ID: <20250926131744.432185-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Nabih Estefan <nabihestefan@google.com>

When running the license check, if we are updating a license it is
possible for the checkpatch script to test against old license lines
instead of newer ones, since the removal lines appear before the
addition lines in a .patch file.

Fix this by skipping over lines that start with "-" in the checkpatch
script.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250916165928.10048-1-nabihestefan@google.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-4-alex.bennee@linaro.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 91616c974f2..40b6955c698 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1816,7 +1816,8 @@ sub process {
 		}
 
 # Check SPDX-License-Identifier references a permitted license
-		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
+		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
+			$rawline !~ /^-/) {
 			$fileinfo->{facts}->{sawspdx} = 1;
 			&checkspdx($realfile, $1);
 		}
-- 
2.47.3


