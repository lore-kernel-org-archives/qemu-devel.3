Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB3C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaH-0000is-JG; Tue, 27 Feb 2024 08:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaF-0000hK-3d
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0002pn-9h
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:22 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so2419407f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040798; x=1709645598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jgYHzr2hRg8T/6O9OXdsZJKVALA3Fedt0qDTwO0O3lA=;
 b=uy6Q5icnOkbqTLJmvql6tWpz7izYpDU/XYINQG3kneaQvSt7CtpLZekUeetr7Y0DpN
 +t0rlj9rKGug71RAdWJIS+SJtJ8/m9A9s+RfOMzmQCFQcpCe6keyN88nuBdioHU1TpqG
 OvVuOwg8sLHFoWlvktOKN1act9ZfAsArzevdaiye1BVF3Vj9oIjZlUQ7WntGtQBiENOp
 X/mNUPLM65a5xd/10qZDlcJztPSq6qW3PCI3FPlak32aWCi0Sy/nSlUdUWB3LtMXgalj
 AEvP/i9ClS/bh/TcBjqw3vVBdPQym+m5M/0f0vDBUa42aehbCC/OZf+qmffRNmVbFvmN
 y4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040798; x=1709645598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgYHzr2hRg8T/6O9OXdsZJKVALA3Fedt0qDTwO0O3lA=;
 b=TFunh/D4TDDaMkkDJy5bMWUUM1WN8mABgCeIenzHZ7LVdoDnW7IrhBezy3mxJJJYVh
 tEBedbAUTcEnG2102n6tOfjF7tcgDdD3ROz2JGjPizwMNiGG+3LF6mqEWPEZ5zxjAQxr
 SootpYNWb+Lrsy6I8OugjiHtwJznQp+8Oy4kFU2HuzndbmwbGg+M2/No/NU7Oy8dLmFe
 NTtuy47UFdPRWVoUwQkOp0qwbACJ0SAdAFdb1TlDOhLHvK++PyiYavwe9g4v7QCiQ8Gb
 hAk0krRYZmPOZTndBprr6+0+6g25IawOus1sXLfa6DXCMI/BB1Y/4F0L6KU8nbgn+uTE
 iKZw==
X-Gm-Message-State: AOJu0YwhKL+PahUcVGy/KE86GnB8mBfuUW7GV4oOKoGhsLezhqOjHP/a
 XfBafM/ME/59h6SFhlbm6GJb+shiDoIYvv47tofzd3XR7lRZVR51U9ngJnlfJJC7n7iCcbCfXHs
 w
X-Google-Smtp-Source: AGHT+IGjcv5rIm2JELlytJkgefyLP3xsj0zp2V60/v+j/FKcFFNSelMYHtNlbXIp7jJPPf2vnQzVOA==
X-Received: by 2002:a5d:5f51:0:b0:33d:9d51:9942 with SMTP id
 cm17-20020a5d5f51000000b0033d9d519942mr10019763wrb.17.1709040797790; 
 Tue, 27 Feb 2024 05:33:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/45] MAINTAINERS: Cover hw/ide/ahci-allwinner.c with
 AllWinner A10 machine
Date: Tue, 27 Feb 2024 13:32:32 +0000
Message-Id: <20240227133314.1721857-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This code -- which was moved many times around -- was added in
commit 377e214539 ("ahci: Add allwinner AHCI") and belong to the
AllWinner machines. See also commit dca625768a ("arm: allwinner-a10:
Add SATA").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240215160713.80409-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 992799171f4..ca97b627188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -642,6 +642,7 @@ R: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/allwinner*
+F: hw/ide/ahci-allwinner.c
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 F: docs/system/arm/cubieboard.rst
-- 
2.34.1


