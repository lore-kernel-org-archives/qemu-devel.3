Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F98AC83F21
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvNa-0005CN-Pi; Thu, 10 Jul 2025 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujq-0008Ni-DT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZujn-0008OM-E3
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:07:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so11331545e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752167229; x=1752772029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wvUeOOY6cyFpb0TnaJDdUvgeGCVLx+UP5LGwmkhxXmQ=;
 b=SEL5q/BM20nb8GfHpYAn4PbhazFHfG/Z6FhCnosgtOWVFkhij/3b7o8OAoux+aHIpO
 DRk6XpO6okk0OH2l8zL0ch8rHrfiYPE5TSY0DvW4XyhHFwqeRoc9IhVr+vEmr8pI5I6N
 2OeSdeRkiorkKEwzK6DnAy5KtDEzCTq0upGmWQ5lpuh9jBgC/5E4v/19OueokE93pXi2
 pKWwkRsHeGIFmPvA6r1MivZ6v2nkOmqAsopr0qX3a20jrNLEkGzf+pf7iObhiGSPPP1M
 0gW/X5QRkomDnjD/EOfsmjg4P/6Q4xSCMY0Y658D2Wvu5wllReBND1fKWepXApIWPcWO
 Xiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752167229; x=1752772029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvUeOOY6cyFpb0TnaJDdUvgeGCVLx+UP5LGwmkhxXmQ=;
 b=mAWmi8bJ0jbnnbEKYHJMh62KVL5iWayNecQ6IIUcjVp8M5U5dDeYmafzha8f5ERi2B
 5e9dD9rEW7ROWgQH8OCc/tpbeiidBxNKhsybcxsB19MuIVfriYLy5+KD8NxaubanP0IC
 LzC9sInv51QPGtOaWkYIws18SN1wIFP3Zv8ULFPc8S774T0Ie8J6MeVhRfKnyepywFG+
 RlomgjUGsH0AVwRNgnluvyS6azwy05zAAuav/NZJ7ZuI3zmrdZJuVfSfVkQnTJkW3/rl
 4Zs4vzMUVcyqfBQF1LzNTm6H6X3Ag3zf44LyOiT1odCCTQw1HCPse0I/Zyw/jNWGXfjV
 innA==
X-Gm-Message-State: AOJu0YwWX4CrstHLYQIvY4p5OITiEOJGr3s/aI2JLtS3HaYc4gXuppfp
 yDZVCofeg+Nsg7WF8ecv062Za7A7vbAk9g3zloj0hKCcn+q5UbiDdcY/aku8mQzUPccXF/Cxe70
 fM7YC
X-Gm-Gg: ASbGncvZSD3gInrGOx9TEfygYTj/mijCWG7LFglTy5+lUInE425hGGwBdRamWeUCDP9
 B2UfPYWpDvd/40leM1OvxfcA2roNxbAX9M2JC3ccrzoKKugl3ZKIzIwuzdqhMST7haACfL/9Bht
 5mkZKeea72/jYdeBkbTpSuCobu9BBUGFho/bkRalq89qLy3EbjXIlZPxavIjG/oRXOuwa5tajY9
 WZHRz2p+sLEUMRVCOfHExB9Ps6gYR4SiiuPplLIbq0kB7Az4UZeMls5KIgpdt4QLdPDXPqlnwCb
 s6y92rBfwUBupamzFyKiBGcihKHsNm+2+qyICR6tbxYroY+ktQB9S8qQxyEcFCggJQ3z
X-Google-Smtp-Source: AGHT+IF/cW/azJlXubPWo0lbRo8bphSages4kaodDvSu/U1Iy2QdslMKHU+mu3h7alwSLtdHmxwLZQ==
X-Received: by 2002:a05:600c:3e16:b0:451:df07:d8e0 with SMTP id
 5b1f17b1804b1-454e2b32652mr696285e9.11.1752167229414; 
 Thu, 10 Jul 2025 10:07:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm2392681f8f.16.2025.07.10.10.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:07:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] linux-user/gen-vdso: minor error handling improvements
Date: Thu, 10 Jul 2025 18:07:05 +0100
Message-ID: <20250710170707.1299926-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

These two small patches improve the error handling in the gen-vdso
program. Error handling isn't particularly critical here because
the tool only gets run during the QEMU build process on input
that we trust (because we generated it by calling a compiler
for the guest architecture), but these were easy to do.

The main motivation here is that Coverity complained about not
checking fseek()'s return value.

thanks
-- PMM

Peter Maydell (2):
  linux-user/gen-vdso: Handle fseek() failure
  linux-user/gen-vdso: Don't write off the end of buf[]

 linux-user/gen-vdso.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0


