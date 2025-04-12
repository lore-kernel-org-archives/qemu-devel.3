Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E86C369AE
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 16:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3dww-0006cH-Ho; Sat, 12 Apr 2025 12:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u3dwu-0006bq-MB
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 12:43:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u3dwt-00075w-5h
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 12:43:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-226185948ffso32869625ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Apr 2025 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744476197; x=1745080997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IM3ruFcSn/3xOMWTqbq6MJahwA1zxl/1qzgndn9+Nfs=;
 b=kFLEJBSZkk6KtOva2jPg69+aKz5pwO7YcNv3eqBOQMHTS9m4bQv+SPizZGRIgihwLY
 AC0P/Q6vooXrmglw4K8E9lfRTH1MKR6v3Te9Jbb/rqLAp2RAQuluj5nNgm/2KrnWuJk3
 4v5DA3FqhJ0CX0sfr/Z9F7/NJyOPDyA3gMXBBwTRVuHejLZLbDLS+TlfxrUSpaciGcrF
 mQoc7+Z2ii3+DXAB/O+QrsSqVCiVlqQ6ZhEvez8hsaJOkv8huGldi7zdO4eYOUJ5tlqR
 8Bg/NgaE51E+W2yPZvqhN395p8uMb8UhVQYLkqkSR9pN5EB6/t31tQtxj5/VXNnzjgV+
 wcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744476197; x=1745080997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IM3ruFcSn/3xOMWTqbq6MJahwA1zxl/1qzgndn9+Nfs=;
 b=it1PSNc825otxRI8NyufyAHyeHdXJkbbqkUBNQmzrfyOIjW7eFhEiSqvdvzG1erq4d
 EUDuBOTiHiobRJfeNVxqZ+40+PyBYvYner4NYd77EXh2Z+B6e6e0xpoAMnOTVkjhVUMO
 KAf0/9a/RZQuttoQGhsMro9FCqiVqC9hbf0ixaw6zhHf8lTUdq0nQE4p+O2nFgnr9q7k
 d/iBGRnkNYjlYe+/ipgnv8D2BdHfdfPSz40JdiEXtjWJHTh9e+za46AuRnHGc1NNxw9Y
 NbkoCCBd4lIbjdL2UO+bLUPxUJMaYNbabswha6kBVUoug1WMyAvYDsfaJelz9veTfyhp
 Rf7A==
X-Gm-Message-State: AOJu0YwRK38Jk79Pmm5y9DlL8f9qqXLUpuBqvCKFq1avvqbSsCK+kRvw
 bcIlg3Jeiz3fDtVnOhy3EBydIZyGzjUbmrbxpSgRaQ6tb5iEYPsIndIQSjwgwExuV12i2zJLmLD
 b
X-Gm-Gg: ASbGncsfzUD0aV42XJVZbfZIqBZ7qTwHtJPLRnZCRE5fSaExTrhvmlGolI3TQ3bRkb/
 kypyHYrMko15K0bOIEfrwU8//mXaVanZ67lrXQsq7uoNcQfZWJRBGFmsJ1LxQqYD08X2/mt20ur
 6yXMKPtg2B049AYS0evp096ncqasl1Uki0h3nn5qtjeshNsOrK+QWy/8n8uimVydeMywXsKvDYY
 KwIjQpGOsgFlJhixpdIAZPchxebxWkyk52HGVTz5d37bI6wvdtw4iIdzw0YlyQvFxqxTPu2bF+m
 YOrsXY1rL/DwlnU3FqqlUdKZnN/LWggyoAI1PlqPsdqbVrArqCmKCMPqUS1U+tVt20zTNymvU/8
 =
X-Google-Smtp-Source: AGHT+IGvp3g9SuDJXf+bjgO+CRhpBREkZbCVJXFDwapP6nUmAfKm5bBNCQbJNcHrrixfTr44BV3u3Q==
X-Received: by 2002:a17:903:144e:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22bea4f26dcmr79945445ad.42.1744476196981; 
 Sat, 12 Apr 2025 09:43:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cbdfe7sm69599435ad.207.2025.04.12.09.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 09:43:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	stefanha@gmail.com,
	philmd@linaro.org
Subject: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit emulation
Date: Sat, 12 Apr 2025 09:43:15 -0700
Message-ID: <20250412164315.36161-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

With acce728cbc6c we disallowed configuring 64-bit guests on
32-bit hosts, but forgot to document that in removed-features.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/removed-features.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 2527a91795..790a5e481c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -858,6 +858,15 @@ QEMU.  Since all recent x86 hardware from the past >10 years is
 capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
 be used instead.
 
+32-bit hosts for 64-bit guests (removed in 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+In general, 32-bit hosts cannot support the memory space or atomicity
+requirements of 64-bit guests.  Prior to 10.0, QEMU attempted to
+work around the atomicity issues in system mode by running all vCPUs
+in a single thread context; in user mode atomicity was simply broken.
+From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.43.0


