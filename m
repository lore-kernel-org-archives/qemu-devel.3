Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FEBC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWx-0005RK-U1; Wed, 12 Mar 2025 23:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWR-0004lX-IW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW9-0007qZ-4z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so9041265ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837555; x=1742442355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvUlsYrMynQ2g+Bt+yO0Pn1F4tS1wPQ/SJ1FqTEbcVc=;
 b=pb8CpaJiT+9ovFWBzxM+5BctyWNkz+5DsecF3NzCXc7bZ5xNMrbnLbK6N0S+2RP1N5
 XWVYCoSj4TB0O3YyIdBNM14yFLBnB85LlcQdFMrrcUqJSeQju6Ncykv7k7iCHBdBjqSN
 7GQ4y+sEhcnpzTjg4CjAZn83dPk6Myqs2Bilsu/9KZCvJnaDsn8Dodb2xOES7w623uJc
 mvcoOwgeJS7sYVL0HNmPcuA7hqcBY1nwymU/CmXM+9NsinpNnIn9h826C8Z00EBDPopa
 Kz3v6qAHwo7NCcOcdmoA1opOm6EYM0MtajfoCeuTH4WVtZtw4WfDncjAZ/K00ZORWAZI
 IAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837555; x=1742442355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvUlsYrMynQ2g+Bt+yO0Pn1F4tS1wPQ/SJ1FqTEbcVc=;
 b=eRG4aHDiK8EZa8FOC6BguQ9QMNaxNTnX6orgG0QCT9YSDXPbfuYbfAEQHf/SI7eBqj
 hF7vEQRAcGR82QpMslH6gX4eQcO8VOUos0PAi2ktdQeuvBD20N8SIVTC3pC7b55RV+2/
 YB/gY8oAoyafZ8boTwBNPcQoG2NmLFN16qaw43WycMlfi2dpUvixDDD6PrXv4Q2mUsHU
 lp2GUzDuoA0fOKmu20Q/5M3ns0Ifc5GTjXkbHZ1ShCkPGSkvekgCVEO0X+PWUvNMTs6B
 TcAo/IAlKw033AiHIJObgX/nZ3+4cazDXNRoDz8iSlhYPEUcolarmpc7d8o5iCGt6fXD
 i5UA==
X-Gm-Message-State: AOJu0Yyun2OOM2kCeEp1mbJEL/XLuPp02iCjj9QNQVSw/tdS3Pvsaka9
 RnUnQ9AyR8PkPQcH6mqaXLoBMm6WetVWJeHeRlKnKDrFchLFPHkZrJnMeITcXtQyIO8gFa+X+N9
 f
X-Gm-Gg: ASbGncsHZQW6MPeIpvgMwVzm/Z/puyN7jn1rIReqGXaF0429uTe+KYtBqufPlC1+2cz
 aNYd4e+coWvJAp6OjYa3Ym3AkhgqlbpVvQXfFU+1Tbnk5PmIy5t93lCdTscDbvI4yPJs1J3n5tn
 Ua3q+1OykNAIZG7q+n0bzpCxq23HQ6xqOd0UJMr7cWkk0xycG5qpSQHHLpa7soS5dhPUGQOWLeY
 EBLU4lu/MxdiJdR9RTgxRX06Wh8EBISigJ6q7VKqC9GHKHKjakbRzA6V8Ywo2jO/U4fKgjBSkKQ
 LnIo9a6iASyVcrNtXtoDclUTNS0+Om8Y3P/GcNAbXqWZhreHVBa5f19YyAn1DGGIQCl3Svsss7r
 t
X-Google-Smtp-Source: AGHT+IEUOr7lE/liiSBrqlLH/HFTj+SnLFmDbzwg7rIq6W7N5fjzpc7345QM1rW6z8uMmsszJBiBpw==
X-Received: by 2002:a05:6a00:244e:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-736eb7d87f5mr16179174b3a.8.1741837555218; 
 Wed, 12 Mar 2025 20:45:55 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 36/37] target/riscv: Remove ifndef CONFIG_USER_ONLY from
 cpu_cfg.h
Date: Wed, 12 Mar 2025 20:45:16 -0700
Message-ID: <20250313034524.3069690-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

While RISCVCPUConfig.satp_mode is unused for user-only,
this header is used from disas/riscv.h, whose users are
only built once.  The savings of 4 bytes isn't worth it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_cfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..cfe371b829 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,9 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
-#ifndef CONFIG_USER_ONLY
     RISCVSATPMap satp_mode;
-#endif
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
-- 
2.43.0


