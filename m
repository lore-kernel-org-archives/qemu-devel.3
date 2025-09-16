Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97BACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaY-0005wD-SV; Tue, 16 Sep 2025 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaL-0005ny-O6
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaB-0008Lh-K3
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:02 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77619f3f41aso3158736b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032576; x=1758637376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCzDp8Y5rVmGyXdmc/HyYS3z4EeUCME39z0RM1On4WM=;
 b=NYI9KRHZFQuUXr3OBPAiCpJuWG6MqoCnauBEOqzewUIsN52KkdVhb9rZvLKSlMyn+G
 afgY6blrAcNAHvAgpUI9DEgqQBWL0jq/PrLcskyWpuDQ3BHW94UiuZ40bUJ4QlfVBUYi
 CaRpOoknxSqiRN+5kBBVCo2M1c4+iBpHAATtssijqfj2kNscFD4cgBlQg+PT3tKo3Riz
 hVJmFa28Xe/n8HVisqsyLc9aDDsn357ROBLYbpRZiWBbAhkAqy2D9r0rFPu/sZ0npryO
 TJbL59x/3lvMXfuXUrtaadFV4pDQEmJVfUqnxukkcvbmycBN9OpZQq4qU4khoPfW9Fis
 K/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032576; x=1758637376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCzDp8Y5rVmGyXdmc/HyYS3z4EeUCME39z0RM1On4WM=;
 b=dh9kXNlVfUOkHSCAVf3AlylFhGqsgMnBYlfXsuNWCoQmFXksfBfJy555d55hJ/3H1R
 W/JQGmNfTo0CCfZ0QG7eEPS9RPWXpNVB5gaYORw7eW8tDzioc2J2FJkCCRso+jb21F3h
 8kYJvs26CO0VeskUY7WjL075vx0sVbgX5aUo7T9ePgO8CgUcEBkFXX7Mqp2zdXNZN+d1
 hdCK8+daGFmOpOiUdiqFkOGrvxDjj+MdbdncxC1TYL+OdKsZOPgvrRNCbyyWK8/CZl+6
 M3xIix7oAdmAx/5ZwukK/H7kOPdJ1GeeSeJYTqrKjlO52L0rsGtuGkXdGKN5JgvO9B4T
 7/pQ==
X-Gm-Message-State: AOJu0YxIlVO6RIWtDrZBukRCdxf680OO+s3HX1oBWLzmZ5F+IzPa7xbF
 kv3O/MRhc1tHEll/VDM7G/ysO1Es2nKsaxPd2c2PH7QPBQzdZENrgj8QF7ErzrsiSh2YPpJFaEu
 6aVsp
X-Gm-Gg: ASbGnct6tTJ1OfHyqq3jjVsYcdaiKq7UKJWz7f68NB8eaH5CHw0Aii0iQCsYr+zqGZ/
 Js1OPDOqbz9jYuPrQiLyQNr1jET1/volbS19T769e+XK0msdmesVucHIDfJsCaqakb/84JHk0Ql
 HDiXWDKeUWggdBKtpGYgGWR1CoUApdg2dtGvmzp1Ei6gICp1cmpu0u/p9pJjBf+LGrxKybK+Woe
 RC4wiHCbqr49+KkiXGckCXe5AN58ofdOpAtNmRyQqPdqc9bZzpRNXCFiIKj4kmVa7vK9MUSDcoE
 7du1eGzAfogXP5wqeCtHHFdsDPPft+LeD3EQjaK2et4swxu0MdqzI9uFGuJPnkYhz9wu5eIfiYd
 qCHUHN7262/rgQ3jnoMXNWBkGEDmqZVSSvdlro5E=
X-Google-Smtp-Source: AGHT+IFbjMJwc4Fa8M+sjcUIRl5egR78zUo7cHwJdYLUZflyetRycjgXMxfHNcSr2lZM/DZrl2XNrA==
X-Received: by 2002:a17:902:ce82:b0:252:fa17:bc87 with SMTP id
 d9443c01a7336-25d273336cemr189797955ad.53.1758032576012; 
 Tue, 16 Sep 2025 07:22:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 21/36] target/arm: Improve asserts in define_one_arm_cp_reg
Date: Tue, 16 Sep 2025 07:22:22 -0700
Message-ID: <20250916142238.664316-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reject ARM_CP_64BIT with ARM_CP_STATE_BOTH, because encoding
constrains prevent it from working.  Remove some extra parens;
distribute ! across && to simplify.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ec78c8f08f..8a805695e7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7706,12 +7706,17 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
 
-    /* 64 bit registers have only CRm and Opc1 fields */
-    assert(!((r->type & ARM_CP_64BIT) && (r->opc2 || r->crn)));
+    /*
+     * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
+     * Moreover, the encoding test just following in general prevents
+     * shared encoding so ARM_CP_STATE_BOTH won't work either.
+     */
+    assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
+    /* AArch32 64-bit registers have only CRm and Opc1 fields. */
+    assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
     /* op0 only exists in the AArch64 encodings */
-    assert((r->state != ARM_CP_STATE_AA32) || (r->opc0 == 0));
-    /* AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless */
-    assert((r->state != ARM_CP_STATE_AA64) || !(r->type & ARM_CP_64BIT));
+    assert(r->state != ARM_CP_STATE_AA32 || r->opc0 == 0);
+
     /*
      * This API is only for Arm's system coprocessors (14 and 15) or
      * (M-profile or v7A-and-earlier only) for implementation defined
-- 
2.43.0


