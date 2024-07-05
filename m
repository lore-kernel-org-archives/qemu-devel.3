Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670AAC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0E-0002zh-7G; Fri, 05 Jul 2024 11:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzs-0002Zp-EX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzq-0001GR-6k
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso215488066b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193832; x=1720798632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNTI1OxNzY3tCEGj206q5bDerGVhXw3fIYt94bTCFu0=;
 b=cKvgivHvE6Uom+pPq7kMH9IWKYZrJ3xGeg6MR06AoUJUHVhG0iXJ/X8+XakUdXVKYK
 /2ztW+bWulUMFwMmpnEEZ467WKQOwCtgA798yLh+QT1hlxeBnLJRCHVMBn7s1cYigt2y
 OcdQxW58/QOcSl9zagtQ3VVZYned0Y/JndpvspTba1jdF6znQueiX6wBmUq+lKEyvayb
 kB60M0ugNMvi0JfrIuPFMdyMdPv75loShLUYxUDyRzKbuONfhf1rbOiBrMjVqFOvtPhv
 RDHuiRnlh232LZt0J34itDOOsD6EqpGiyC+U92Ub8Lcg8V4fB8cNS4yyyISjdWP/s1DN
 3WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193832; x=1720798632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNTI1OxNzY3tCEGj206q5bDerGVhXw3fIYt94bTCFu0=;
 b=RmyLaYkOOS8Yx7i2rDNh4+d399VN34MHdaui5jwf/ks5Yu4C/YrOPSpUomB1zqxFqI
 jGDn0J7WUlIxjDSQexyNHSctqWCBU86dEwwu8jDsFIsMs1wWyh27qS2xT/nXO6kb/ie+
 gL9KRxTwizSMfoRsNLmuXOtzJdl/Ib9ZMy76LMWLhbDWGL/rKFkpKCzdPyPfXhO1o6S9
 EJ9NvS96JcR2pui1QRXXWqlqVPd8n0BIupUdppCVAk6ptUsydiDfCltuHPc/4QBO/mMW
 qNqCD72Rq/krbvHxtBZM+gqTtLX4VMLmqzJoXEar6G3N8S9wKuu8sRvyKSx1DTONYiS3
 7O3Q==
X-Gm-Message-State: AOJu0Yxh3HS7AHl0PxnnsNggtg8d4RjOzVgB1cNIL7ok9tvVhM69Mb4P
 Q7Ij/Ncd1YFlboJx9/1oVsaxkdrzAqqwpqZjj6hnr7+JgS3yS3lIA9aGYpY2H98=
X-Google-Smtp-Source: AGHT+IHmqaXjaetnXVSMDU9zcUAb5yfJuBDEBm+erJ5zJZ7DaxwGQjwvKqRrFH2skkYOJfRaHhMLNQ==
X-Received: by 2002:a17:906:3b8e:b0:a72:4676:4f8 with SMTP id
 a640c23a62f3a-a77ba70d755mr282546366b.62.1720193831692; 
 Fri, 05 Jul 2024 08:37:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77d8ce6a78sm40399366b.179.2024.07.05.08.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A58A6216F;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 33/40] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Fri,  5 Jul 2024 16:30:45 +0100
Message-Id: <20240705153052.1219696-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240628050850.536447-5-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-34-alex.bennee@linaro.org>

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.39.2


