Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E5C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvHc-00010e-37; Wed, 19 Jun 2024 09:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sJnLn-0004I3-Fy; Wed, 19 Jun 2024 00:55:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sJnLk-00017t-WD; Wed, 19 Jun 2024 00:55:15 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c508ea0cc5so2603097a91.1; 
 Tue, 18 Jun 2024 21:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718772906; x=1719377706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nuygwi5nDptBAvHytYIXBemQzADxFZ/rpm2zueIZ1BA=;
 b=HqzUzC/CZRfOqnoCzlJ7tuuAtBnYHD4Y2T73ZaFXos93B6JXfSTtqZL7GLrJDip5jM
 HqiFMWCUaLrD3KDMF3WzvYLNCRvjznmwMCkkHr+G6y9SqclTALFg+B/6jhPEhm39fI+G
 kkFLHrXR0+DhvDa7AjoT3mcOPlYAc/wnwcWIcxjstPBd6WhztefWCJHpxHMIQXa26fbr
 B+FNYAUX9ck7+3sJGi5aSqEwDeoicKDwGDj3q6r07+kmxGn8IXW4Np3Dc5lQtXH/7JJi
 BaPB0M63yOHPFZeXDi4JbTo31ZcexTLbYiSIkiqMOCEnjYlK6gcEVY2hRQPtYleSFD68
 x9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718772906; x=1719377706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nuygwi5nDptBAvHytYIXBemQzADxFZ/rpm2zueIZ1BA=;
 b=plMyiqDuy9qJrmEd8xDCtUaey+Dq5BdP9hE2Ws2Ygd5yVqhiohI0TsWmVerov3iR2Q
 CHkdLGkBj33kiYWyPt/mhMpFfYTo8TX09lYVlE3M9wSNXG5IBonF7eM6nqz41M9Gz963
 tDIL8MoLUbNCFlx7iCV4FV15c32M679JV7EYYGpUaQRCCcaT7Rz1jQJpzM1p648QGngR
 Q3JmGqz3pdln0CwM+w5apX6oK+sN2oboIZrQYHTysJDVKAiERWGK4tjz8tf+smAUO89q
 iRA6J+afgfrSqt0wTu249n+kT+Two2abRfQawodZzV0SO58pQtKmjzNORVxr/MY425TU
 kWag==
X-Gm-Message-State: AOJu0Yz9V687QxDN5XboCR9gZvYWGkINM/H8d2+I7IK/uXg/DoYKXyJr
 L3c5ourunczN9Taks9atZ/CJ8pqHLOabBWlwOH0D0tn0fBzgfdonbagc8Ps3
X-Google-Smtp-Source: AGHT+IHNpI6Rt7/Qr9WIsIg/Y6Jua08sDhXkKvdwhhz+jejSTYCPL+VGCLuxADr35vfqh0Yn7QETnw==
X-Received: by 2002:a17:90a:fc83:b0:2bf:c6fb:ec34 with SMTP id
 98e67ed59e1d1-2c7b5af2f11mr1605552a91.8.1718772906015; 
 Tue, 18 Jun 2024 21:55:06 -0700 (PDT)
Received: from hyeongtakPC.. ([147.46.174.104])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2c738c1b741sm1927021a91.1.2024.06.18.21.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 21:55:05 -0700 (PDT)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Hyeongtak Ji <hyeongtak.ji@gmail.com>
Subject: [PATCH] docs/cxl: fix some typos
Date: Wed, 19 Jun 2024 13:54:59 +0900
Message-Id: <20240619045459.305997-1-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=hyeongtak.ji@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Jun 2024 09:23:26 -0400
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

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
---
 docs/system/devices/cxl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 10a0e9bc9ff4..e2497e6a098b 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -218,17 +218,17 @@ Notes:
     A complex configuration here, might be to use the following HDM
     decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
     part of CXL Type3 0. HDM1 routes CFMW0 requests from a
-    different region of the CFMW0 PA range to RP2 and hence part
+    different region of the CFMW0 PA range to RP1 and hence part
     of CXL Type 3 1.  HDM2 routes yet another PA range from within
     CFMW0 to be interleaved across RP0 and RP1, providing 2 way
     interleave of part of the memory provided by CXL Type3 0 and
     CXL Type 3 1. HDM3 routes those interleaved accesses from
     CFMW1 that target HB0 to RP 0 and another part of the memory of
     CXL Type 3 0 (as part of a 2 way interleave at the system level
-    across for example CXL Type3 0 and CXL Type3 2.
+    across for example CXL Type3 0 and CXL Type3 1).
     HDM4 is used to enable system wide 4 way interleave across all
     the present CXL type3 devices, by interleaving those (interleaved)
-    requests that HB0 receives from from CFMW1 across RP 0 and
+    requests that HB0 receives from CFMW1 across RP 0 and
     RP 1 and hence to yet more regions of the memory of the
     attached Type3 devices.  Note this is a representative subset
     of the full range of possible HDM decoder configurations in this
-- 
2.34.1


