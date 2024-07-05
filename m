Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A395BC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku3-0005j6-88; Fri, 05 Jul 2024 11:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkty-0005gN-Uc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktt-0000QG-89
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso2092152a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193464; x=1720798264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi8EZxXfCvRnQubk3+hKID52gSjI2xNtzTbxu1dIU6s=;
 b=SsgN2AMEOtLniac5HMZXImt2fjBdShOzc8XyfWAaIMBGq5G74o+5Axg/ZeUnfiz4K9
 74nrRTNvS4mwciG8cPHie4S2jhFgqHHc0/2cprfFwCMWoEyTKO2FMf/NpNUmG4t39wsX
 V1ImyBSOyu/5NaQ2YcZP8x/E9Kh7S1MBcIp5nr2U2q4tDsFCr7Y190Z5f/gaZy4Px2sj
 ct+yxggUpVumpjhmZRl81JbJlfG5N14RYguGpdqQlnRXmwT+sFdQCE50RUyC6Ew/NXu5
 gQ8H80Xag7BF5osgq/QMUCElAIQf4nhw1KG/nW7Xrnuox5kTSxtQ1mvsyfgnjLWfXu+W
 v6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193464; x=1720798264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qi8EZxXfCvRnQubk3+hKID52gSjI2xNtzTbxu1dIU6s=;
 b=SuWdTr5wMYX/azhycE4ASFxYIpaQQICCuKnuYqpAPugPHe9WDeW9rjW6rFWhM++tOS
 5AFdTd/qmDk9uWgyXHsnJlbzCkxFRcvP+E0Bcvj699Bo655Pub39dkeyPA0iK6KfkkkS
 DevT54G0157izQRyrDkCY1zv0pNqWCrFq2GZcyK7hBzX2IlNaDeHHCMsfNMS5Bxp7k/Y
 toe2k5C78F43K6teKIDibXUFzEIA276vQNwCaqFj6JEPrEhnzU2laKD6tkOUzkJ/NLQe
 Eiye1z10awdCuxvKUA30f9Rae1KAhoh8hbrJzXFZjHcu76k+/N/G/H0R6V80ApK1hq/b
 4Kew==
X-Gm-Message-State: AOJu0Ywc4NQ1kBuRNkfPAQODywt2mMeiHHnOV5oTVfQ6sJ8YRaLRt4d4
 sdgJUML+pcV+qGcRimfeYgaCznVndGVP/wK7cL9GX1Pt8mVplbrx0OriGuHtoqS94WjckedMnUZ
 U
X-Google-Smtp-Source: AGHT+IHiI68D0FraDJBDYUx6TOTBSDNW9KHhIvfBS05UPPDin+D54I0XSWig71Y9RFcokuGHl+yvzg==
X-Received: by 2002:aa7:d693:0:b0:58b:9077:2bd4 with SMTP id
 4fb4d7f45d1cf-58e5cd151dfmr2659043a12.41.1720193463385; 
 Fri, 05 Jul 2024 08:31:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324dca6sm9809697a12.31.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC3E0620F2;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 10/40] tests/tcg/aarch64: Fix irg operand type
Date: Fri,  5 Jul 2024 16:30:22 +0100
Message-Id: <20240705153052.1219696-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-tcg-v2-4-1690a813348e@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-6-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-11-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617ad..146cad4a04 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);
-- 
2.39.2


