Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F8CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 05:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYIgq-0001QW-12; Mon, 29 Jul 2024 01:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYIgn-0001Pm-Gz
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 01:12:54 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYIgm-0008Pb-0W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 01:12:53 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db1270da60so2244484b6e.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722229970; x=1722834770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tLrGX9Afltcgokadlb0YQI/9367xWPIB4Lrlteq6PUs=;
 b=QKiKLV33WALWKFHH2mTYUSJBBEwWJhif270fnzTKLJlc3XnuLNkanMBq7bacWXckCZ
 mWlNYTJvG3q1vftnEJFPiU54tF0/sqVE4lnJsqQYFvKVI3i3wCKTd+G51loPKQotKLew
 eET+JMheO7p4peqktMFbgSQ5w8+1Su6YdV+AQ8jsTFVJafKicTh+fhTZXa9TjDU7BFeq
 DDEAYj9zfY4xTyBsgGtTJD5aS0n+OZ6jmKGIQpMnd2OlLVIlTsLfrj06yo5xcRHOaQyr
 /gEjT19umNJEYNLeq8czl8dUdfxIlJCwInTEqEGFBNVI9Lkxxinj8/UJh9sZNmskWWwQ
 /vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722229970; x=1722834770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLrGX9Afltcgokadlb0YQI/9367xWPIB4Lrlteq6PUs=;
 b=fc3H6Qdan/fjup47V8+NaTEaJ7xEuE8igWQYrVdmDGmhs9t0/YBgPK5xS6V8djkFaZ
 Ozkul/TUUSP3v61rZMoS92AyA0Xqq3V+LxP1xTXv2weLGnNN2h91rCbDkuejk19VZE/I
 ZfqS9snIgQguuhQAEqxh1EKrIvpgIdBK5lCRwPtfj8DK4Oi/TRVx3bALTU9GVfUq8s/2
 lpR2w1mE5wB1TwZSc7zY9lqU6wy/GkKDNlfrfcmI3UOFQ2yngmTvPxP0ffaaSpkBPsfR
 sjM3WhFIagokeAAphqwzKgIWSPjURebiWHSdIkp/z4njtvPlX3Qjd+LxrEKi8bTBt8v9
 CGOQ==
X-Gm-Message-State: AOJu0YwR9Gf6/TboDotsRU/Wq3Z4OC0BXSzY+mG+U/Sk4CcwYeb74SPO
 oC9l9Hmmev0W+pgTHx8BlRb+7tQA8KDV9D/sw1ByB3hkKJckNR6BNUFu+LYwgjRsUxhK1Bx/LqI
 sEH9IDA==
X-Google-Smtp-Source: AGHT+IHtAtlhtTXBfGgex2Og0Ukj/1P3Y3gWHmi/iPGB+sHTXmV2KdB4ZI3gOpkKQbcxSzg3qlI3Ww==
X-Received: by 2002:a05:6808:1416:b0:3d9:222e:40ac with SMTP id
 5614622812f47-3db23d37ebdmr9053954b6e.44.1722229969887; 
 Sun, 28 Jul 2024 22:12:49 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead89fac7sm6006691b3a.186.2024.07.28.22.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 22:12:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH for-9.1] tests/vm/openbsd: Install tomli
Date: Mon, 29 Jul 2024 15:12:44 +1000
Message-ID: <20240729051244.436851-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Tomli is now required by configure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/vm/openbsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e646f7c51..49cab08782 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -32,6 +32,7 @@ class OpenBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2", "xz",
         "ninja",
+        "py3-tomli",
 
         # gnu tools
         "bash",
-- 
2.43.0


