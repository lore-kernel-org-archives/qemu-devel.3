Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B1CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5WW-0004vE-4a; Fri, 30 Aug 2024 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WU-0004tB-KL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WS-0003O4-3c
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so18080295e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725039294; x=1725644094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H5TolmHItSaUT9hOvsjRNnuWQE0yYjs/BM9Yo7vZ56M=;
 b=qy1d6AgJcu71SwTMZoPNFYO2A4ZGEChpoa3WDdR/wVM8yyaMcM4mngRKwKS8ECYV5d
 S77ZWvFH1WI8/yRBjaqzakEsUpOWJ3gx3dNQZwdGSdIcgpQZCEj2Y2JYW73CFGF6x61O
 1EKBNgRdPzlrypfJ0YZ5SleIFK+4j6to2sKhax7ufBxCHr0p/GOBXMZAhTwtRs7bMQmJ
 rL5aXmqxwMRkMNhLhgkR0IfAJce1tOCq5TJfUx9rMAZVnuOkaBx+T7yQK3hzeNvyfpee
 mlYrdK2eD2Ybdsl2ax6X0p6lymgBRa1BPxbxJkJCnUPSDXZIvwWVgn419bGC5FwyE33G
 ZrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725039294; x=1725644094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5TolmHItSaUT9hOvsjRNnuWQE0yYjs/BM9Yo7vZ56M=;
 b=u++BtRrPZNjSWyliK4ZvpQ+3AsGW1X1Mhxa6YheuM/0jqLyLAvAzW9i5nKdnHykIn9
 VgFT3/iPgBOjgmttYLbZI1/QoKMj10U/8mDUjmaRkYD7AvlrqWLJrsA34n9FJoKRDa/Y
 RKpKzB+bUWvhKw7BGDAHnMoinVKLay+zpEhLLtkFqwfYoCtKNMTQja/aza6IYlmtElJ+
 AvQdkCxq5sNHpC6KxfgQrc0cRLYjM12wZwGCsmZq7p/CNHqk+yr1iCQ37XeA0B/vTncW
 A5K4/eAZqAU3zIhMx6ldGxHyh4mskSGRh19eBLR2KEcinnO6glhGNeKAXeDy6wD06jEj
 25Dg==
X-Gm-Message-State: AOJu0Yy+UQ6kSQJBzVby5KqLmxAI9sxYKaL1+exaoGmmEM0OtkJ5OIkf
 q0y2fcy2IcrBun8sYFYQ93EcAApp453cO3h0M3US1fQN0BxbhPbG3iVdnug5ULupsaByUazrhCb
 4
X-Google-Smtp-Source: AGHT+IG/UkIusFEk/aL9dXQ/kOvHMmwbHMZ9qsbkbdFNDppdNo9YKqC+LoHO8M+zI8Udtbtu9o+0ag==
X-Received: by 2002:a05:600c:1c89:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-42bd052b0f6mr3284395e9.0.1725039294139; 
 Fri, 30 Aug 2024 10:34:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb37f7849sm58471775e9.7.2024.08.30.10.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 10:34:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/3] m68k: Fix a couple of Coverity nits
Date: Fri, 30 Aug 2024 18:34:49 +0100
Message-Id: <20240830173452.2086140-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This patchset fixes a couple of very minor Coverity issues: one
"shift off top of integer", and one "overflow in multiplication". 
Neither will happen in normal use. I would not bother backporting
either fix to stable.

I threw in also a patch adding a comment to mcf5208.c giving the URLs
of the datasheets, since I had to go find them to check the fix in
patch 1.

thanks
-- PMM

Peter Maydell (3):
  hw/m68k/mcf5208: Avoid shifting off end of integer
  hw/m68k/mcf5208: Add URLs for datasheets
  hw/nubus/nubus-device: Range check 'slot' property

 hw/m68k/mcf5208.c       | 10 +++++++++-
 hw/nubus/nubus-device.c |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.34.1


