Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BC8C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCu-0007ik-0a; Tue, 18 Aug 2026 13:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCt-0007iT-52
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCr-0004s3-NW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so82800b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072552; x=1787677352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oBDCpF9uwTYRnOatzskuzdRhioUauCCyls7pC+VzqP8=;
 b=OIAzJ89YiW/PMg/OXLYTzhHbx/RUYCb904+UIU3VweyCA2vALUK+saplx3PzbSrKb1
 73qEVFp97wPdi7EHFZ9o8mRPLETWoElLrGmoznNv6ST8FYhfCXAbHj0oQ+UEvk31ErEL
 BFUU3Xq6iuaK5urIckoWeQLjOCuQ+LmhNOUgjGpYobvbsfB29Oa0TZ3RT9ovp29YkRZP
 p+daznSIBeGEtfTF/hJyb4Hn853ySePBFsBwNDm43CtKDBd1HOzjUYWJwHzmxIvjQNki
 mVAb2NjNu69IkDeclY+Ccc9slE5AFBfcEf3wGgDxess+cfO2TlPGFSouj1fdal7Xo5aG
 W8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072552; x=1787677352;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oBDCpF9uwTYRnOatzskuzdRhioUauCCyls7pC+VzqP8=;
 b=GMfJgceiZxLb259O8rSIqBz2bdkFC4YwKJnqUoaTgDREwSpqWrxnMlfGr9Hw2RDHEP
 fgWixMF5e3InaPryNywbL8vOGXgIMwbzdTWZtW+Q67Myf/27SdzG0+l5sU87rbWhawlF
 tBWghXlCVFpSk3JanGSzvglx0n5cPUYeu9mKGRkBOTTSEiAkIunsvDkKiE3i5l/LPUK5
 +78eNK7niXwLV6DgMtWWirZWn9pawMKLjh2oDHXNkitnjFE4/oXm5KNSi/KuJDdevrRq
 KKrwlWxVDrKvqDfTmbVkAPP7hqDPZId7u4um07YF0WjnPWSxfakkA15e8q/9G4yzGrhq
 T6uA==
X-Gm-Message-State: AOJu0YymEiNkjAjPqaRQ6y5XU06K0YSaVpkgMJMsugq7wOmWdwTSAleH
 YkqyyclOUMVCHI2jnPE3YFiJmfmjMLefjqQ23YHkRUaORVc066oNbXn+pBKaYbBm4Nqg+Ur6Sek
 vx+W/DbA=
X-Gm-Gg: AR+sD11DLyclEtvpF44yfN1H8hEW2QcwIkKxyi0xYBXLDHZ+06R8Un4oBW0bDklelmM
 2J2f881tRthDJ3QDik0HQDbIg1sQaQdYeEoPF/rX4VhX82SK3eVFyYWxVDJijVJ5obOo/QPa3vg
 joLB6rJlnxQovI4dp2WRiLH8KNXySPjDsqDl3jc6kWZrsM3um8MA26FSMvOWAosRLc5Jhgk5Ws9
 kVZvC7sbUSjW1eiIt3pTJWIFc8T5rdnkLhtUHGM0mAeCdnok+U0QgbisR1z5Cak8LG2ISBRT2sY
 3jhTHYtKV13xOGS8LyD0+d9ncSfQUfHO2zSY/5KplUkgDTmjVAN/pqKaHyFWp8mt8rac0vyaZMu
 b4lmHn2euBZfEyPIrHpS8dXUU4gsJlHoY4XWMWvIDJ77wA28ybhAW1tyCLZDrxXwOZW8/eSJFOJ
 m3WvJFerX40U/A2a85gvHjNMdYeUg3YDFLmajanQijWj9oMcrhqabhNQytzbCxHKQt5aUAuhBLn
 1IorIkZTVuqIVOwEy/ukqkfZJ42KCn4xtHKHZe8lqk5GQ==
X-Received: by 2002:a05:6a00:1489:b0:847:9aa8:d3ce with SMTP id
 d2e1a72fcca58-84fde14ff2emr36152849b3a.2.1787072552356; 
 Tue, 18 Aug 2026 10:02:32 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 30/38] target/riscv: Improve riscv_has_ext
Date: Tue, 18 Aug 2026 10:01:47 -0700
Message-ID: <20260818170155.1907006-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Constify the env pointer and return bool.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9dfa7daff..376cff656f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -615,7 +615,7 @@ struct RISCVCPUClass {
     RISCVCPUDef *def;
 };
 
-static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
+static inline bool riscv_has_ext(const CPURISCVState *env, uint32_t ext)
 {
     return (env->misa_ext & ext) != 0;
 }
-- 
2.43.0


