Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6376BD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 16:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ6TO-0003FV-Ur; Mon, 01 Dec 2025 11:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TE-00039z-Nx
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TD-00084Z-5o
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779a637712so26561605e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764605385; x=1765210185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OS7tRew+r9kUvp81iPWbbOvAXQRnsR6HNLxQwl57VfU=;
 b=Pumep1CZo/uwv3348lz/7J6D1o6GRXHmYBKDYJ+4knokrnbnIzoIh1H2qDrhRLpo4o
 WjKMWIcNAtZ1eLnr3R4Pf0HgCWa626triDCC6dlxWIvtwfaq/IWtZgYjfte3M5+2URUy
 lwep0hLzd3bZX9VtS37LjVIzETwXV1ynuth6NNAzmliiGoPzllDPxQuXqe6RwLAD1iu6
 J/+Ypy28SruZ37g7eBmtCgJ+C9g8tm+6bPE8gCu3alGBlRYOJrVxG5Ks+xTuCUqk3KBw
 A1PtmWK8PPbLk6GRl1Z04MokkSw8CQOVhxSeLRqHpLwbNNAOb8UPUVmEeJrONRgn4UQl
 +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605385; x=1765210185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OS7tRew+r9kUvp81iPWbbOvAXQRnsR6HNLxQwl57VfU=;
 b=mx4nRr8QQFR4GTpba6Qv84w9/EZVUTvw/0VGV3+XwWxt5h9avwdqQ51ZmiIbdZDJay
 p+3MBz8yiJQxB7GC/zy4JiGNV/g1dJGjMSkKYqTcA2LbcqpVa9XvXCTzPmgaBl+E3L7t
 HelCeipYGqujUEqVs/sR4FDtDew0uebSHfeGwVaJjDIFVGH1WqdXgaWeYALjuHWzn8++
 yPhbNJrmsls0SJ/IpaaUGr6kzmPYK5qZ/BnqzPBFS65jVl1UOd9v6YyoZ/kJ5A19u7WG
 FywRtOPwAxW8o0vUaheF07kHVivqugzr0Zw0yESfolzImwAi8RuZTocVWV9uwKvwo6TT
 sjNg==
X-Gm-Message-State: AOJu0YyquoLvD5ePOSOjO+yoF0andp5nsfYo9ukRNSpbAPkdOpmQHPwf
 YYm+MVUltdP41t5CWw3oQnLB1/zgGDpqOhPIhgcmbYVLtJYX1ZS0BN0KFkTQuqfOZzoRT0tQOJF
 FT9UQ
X-Gm-Gg: ASbGnctPwSJTIJaUKVtdqcl0VbUh4JZ8n5K7Aad4Mguf2vwQLwUjvij+bH/UW+ajuqp
 RKjI2oWXwOesqNOkgpP1FWrRBFKtcpYmxXpk94LvLk7xJYYtmQn1Phumc/kHURmJSzGaxCHOr4U
 6ELavjqI7nU0BDJiSei+xmUf224xFsBmWs6v5K46jl2x3YVF8Yy2beyRkZxBL4NmUbRe8hJ0vX+
 nxnu205mGHDTFUqeo3iUaK1cj/KILhuIGv/lEBDESX6d2h7DAuV6+d01KIE/7Pgm8kXgV8ilgWf
 EVSW3NiOU6UBb2bR6TD0vEKiicYj31xeH0DZLgujpNwq7sU+rQoV8yyZbUfx/H8/RefR6zozazZ
 DByoad/oUXNrFRpujsflyw4+VnPuzEhpfJUo2jPG1KDSB+0QcdZalG5MOyG7838OeLvLRpjs5qZ
 tDrYSj1FjHVMloV6ve
X-Google-Smtp-Source: AGHT+IGU8lBlKSgQ8VxGXH94ZQf+CAoo1lyHeUyUZShV+0ZVMZ5eKULzviGqt4wrboYdrr1hIYufsg==
X-Received: by 2002:a05:600c:314c:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-477c01b4986mr392621225e9.17.1764605385380; 
 Mon, 01 Dec 2025 08:09:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm26682796f8f.14.2025.12.01.08.09.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:09:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] target-arm queue
Date: Mon,  1 Dec 2025 16:09:41 +0000
Message-ID: <20251201160943.1342099-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi; here's an arm pullreq for whichever rc we're up to now :-)
One easy bugfix for an assertion, and one docs-only change to
update a URL.

thanks
-- PMM

The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:

  Merge tag 'hw-misc-20251125' of https://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251201

for you to fetch changes up to ebb625262c7f9837d6c7b9d8a0c1349fe8a8f4ff:

  docs/devel: Update URL for make-pullreq script (2025-12-01 09:39:46 +0000)

----------------------------------------------------------------
target-arm queue:
 * fix assertion in translation of BRA
 * update soon-to-break URL in docs

----------------------------------------------------------------
Harald van Dijk (1):
      target/arm: Fix assert on BRA.

Peter Maydell (1):
      docs/devel: Update URL for make-pullreq script

 docs/devel/submitting-a-pull-request.rst | 2 +-
 target/arm/tcg/translate-a64.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

