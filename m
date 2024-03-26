Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A425C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAJq-0006ht-4D; Tue, 26 Mar 2024 13:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJl-0006Yh-Ce
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJj-0006qF-MF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-414881d8956so15784815e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473030; x=1712077830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2oLQ/SaKcXAucHYLsLudqRjXTfLkOPUS+8DcR0nQ8I=;
 b=aKwL39VuK/lKWdtHDanNeiZSwUU+k28ApDaSTX/VxrodcYo4GGFGnCdWt1vJ18wHAo
 nKGuseQV3LrSrqwCEn7imnktPWkWO2lBbM35tokyaoBkSENmgVWBiE5UI4nvf0wIlmnD
 EMuQiGgG4PhFE3MbIjiNxjt+r5TAsGHJYTZ0nKvf7naU+c7UC2Tv/VjeATba7CbKfANb
 dp0g282Q+OB1/TdD1f5Lb0gN7EIe11NCIcTbAEgN2a4wJNVo2fn30XBvAsh/jmHcl2RC
 wmzbeizkEEX7Tp5++WtaRp8E69v8y3DEJyy0zwn2bPJF2v78xUHz5L1b5QeVhfwphJ3L
 tuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473030; x=1712077830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2oLQ/SaKcXAucHYLsLudqRjXTfLkOPUS+8DcR0nQ8I=;
 b=iCubTwbFNfgI6C4yPOJe3fEXTJsMjpKM+1FJLaRVxs5IOS8kYm9b4M6bxdU3ayv80S
 6L1LRak80B/jVOM5KUBAZQoR/45RAl8MJteOPoY8A/pkBFexKX9e4t62wpyD1aCVc83b
 PFp0jW/+x8owPivTadqJC0mbEML1bmndxgLtfCnR6uhfgOPQzDZCasq5lXXWjoYCJaxO
 a1pT1WcsfPW5CJxWF4dc4VB4BlaG2CEp0OTxO5uoJErfwtBsSs6lJcFP94X6owa9Nfp6
 fwSZyOOM9zOFTECnXpVPHf92di2/Ur9m8aeM0Vl9KJXtvzrnofILTDkw4r71iA5E7y+e
 FJOw==
X-Gm-Message-State: AOJu0YxKOqr7ymQbsL+thTMGbXgGdk+BjLZ+NGFH+v0TXEMHMnLB2MvM
 NjDxLtSrRAD6V7QeF3cbm3Fp9c+LZr2NtE/IoYFsgpU48rL+KDVek2UHKYkYbH+Vh5dYZmlavKp
 m
X-Google-Smtp-Source: AGHT+IF3ADdpZuy3CFIHV3+8mxAlRKHCdWD1MAh7X5t/yDtozxNS1yNtNEwfVatjfiXHAnSZrSOhYg==
X-Received: by 2002:a05:600c:4f4d:b0:414:dae:218f with SMTP id
 m13-20020a05600c4f4d00b004140dae218fmr1187214wmq.35.1711473029965; 
 Tue, 26 Mar 2024 10:10:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a05600c4f0900b00414895d014fsm7341794wmq.41.2024.03.26.10.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 10:10:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH-for-9.0? v2 3/4] qtest/libqos: Reduce size_to_prdtl()
 declaration scope
Date: Tue, 26 Mar 2024 18:10:08 +0100
Message-ID: <20240326171009.26696-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326171009.26696-1-philmd@linaro.org>
References: <20240326171009.26696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since size_to_prdtl() is only used within ahci.c,
declare it statically. This removes the last use
of "inlined function with external linkage". See
previous commit and commit 9de9fa5cf2 for rationale.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqos/ahci.h | 1 -
 tests/qtest/libqos/ahci.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 48017864bf..a0487a1557 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -599,7 +599,6 @@ void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
 
 /* Misc */
 bool is_atapi(AHCIQState *ahci, uint8_t port);
-unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd);
 
 /* Command: Macro level execution */
 void ahci_guest_io(AHCIQState *ahci, uint8_t port, uint8_t ide_cmd,
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index a2c94c6e06..6d59c7551a 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -662,7 +662,7 @@ unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
     g_assert_not_reached();
 }
 
-inline unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
+static unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
 {
     /* Each PRD can describe up to 4MiB */
     g_assert_cmphex(bytes_per_prd, <=, 4096 * 1024);
-- 
2.41.0


