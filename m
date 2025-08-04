Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E65AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizwA-0005Dk-G5; Mon, 04 Aug 2025 14:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiy4g-0002Xu-06
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:30:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiy4e-0003ro-7K
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:30:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so30682675e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325006; x=1754929806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fyg4V/BJb4Yh/ywk/gyoQ4LrFvtg7mzAwCBuzyAs9Es=;
 b=kbHLRPNh7lFerpF6WIuM1btsWPctdmd87Uf4k9d3t4FVXtwWrE4FIMYxq0g7B4NlRH
 D2egsBgSnhE/WxMhuwgQlqZZixYDBapLQ1P2/Uo0S8vsTwJtSrjMC57tt+N9NvQ3U9/N
 4tYnfZvGQDmpxHxmoHK9sH8TnUaPTcQKnNbtuMnAXKKmCHCR1kziKsxUtJgkbEIkp2Qw
 KytVCLad4Gf/4SQyPlNswyp7TGO/vfC9S/N0qtODXcDeFqcUrihWAxhH4Ug2y7P+6kSa
 QgTHGdQZU9HTdZrRRQY3kEqDKW3OK/e4IDUlkcu1Ia06Wc3uGQrQ6OY9ze/NEPWVuWI8
 hGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325006; x=1754929806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyg4V/BJb4Yh/ywk/gyoQ4LrFvtg7mzAwCBuzyAs9Es=;
 b=oFB5btvuGAl5M2x1TGx48Q5cUGDSgerx5stajrsR07hNr0dW5hhBL7Y2SQXCj3fqjZ
 Iej54qQbfAf5L5g3xdwvUwVtIcg+TdPwFvl06RZz3GVIT2BaLWzIGdY2LOEtpaySmd8/
 F6+yCgR4D3xqwIghMz0Eh3LJ8Ruf7LT8HpUtHY2MgDfY8SYoV4DJNUICyFbEmcIAPgA+
 qard2GKcBTO/v6TINGvtwIwLilOaVe19+FEHCv/yRP+VPCl0oxJMsR+NbtoEDcwaKiTH
 3oCZ9/6OLT9DR9/Hm0m22+VEqLxtuFI/FFG3bD8ISCFRp6R93B85PMKe0g9gaS/6LuWb
 sOBA==
X-Gm-Message-State: AOJu0Yz1s0EfosXAYFCnYrshnZcQ7GljhNeW+ko6rjdLn6GiKSOK9k5w
 BA7fSYpp+a0rikOPJrnahphZu7bvwpHEsB/yI/dV8bQn5Z2mTNL7XSEjedfiYfcVSP8=
X-Gm-Gg: ASbGnctTH3HBeLclSCVqtt2+FRhprvRVyee8Z+j8QApjcgAn/dEahHiALLGctqtc1qS
 He+zaMMRCPG5sGeMPs40k41BMdPSZENjL2mFqIulZ2YERSkH0K5Xs4D9ey3UAqXbeMNFlwR7vZy
 p1p4XNdRdZ8V2VgezzxEls9iS6uYJsjxmDEIm0DlvOa2Lo030fG/5yelBgny0h5CurzqFIjZsLT
 4bi7344om+2hoPjpczgnRfxNmAazDo+In/zWqFsuqlAz/rNcKzohUBIXjs3QUh7EFPy1Y3d7CJ8
 6sgjTMB4nLXYOFEB2Ixxm2WRmXNPlhVKPhp+jxTlbOuBX6ACFCsy4F68FGJdqYke8uSDVs3nX1H
 Tj12lg69nxz2QgeUsU379XbE=
X-Google-Smtp-Source: AGHT+IFl35QlWoTZEF5QnpmNbQhT3S66Ro/0jHeqz8w+EbKbgiYPd+A+TjsWzNtPjgFLob/EW009rA==
X-Received: by 2002:a05:600c:4445:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-458b6b421efmr67474115e9.24.1754325006192; 
 Mon, 04 Aug 2025 09:30:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453328sm16807907f8f.46.2025.08.04.09.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64E525F76F;
 Mon, 04 Aug 2025 17:30:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] readthedocs: don't build extra formats
Date: Mon,  4 Aug 2025 17:29:59 +0100
Message-ID: <20250804162959.330060-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We don't build the PDFs ourselves for the hosted docs and it looks
like rtd can't manage building PDFs now they have gone over a certain
size. Disable the extra formats so we can at least have the online
stuff again.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .readthedocs.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 0b262469ce6..639f628612c 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -21,5 +21,3 @@ python:
   install:
     - requirements: docs/requirements.txt
 
-# We want all the document formats
-formats: all
-- 
2.47.2


