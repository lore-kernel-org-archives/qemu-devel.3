Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C00C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ku9-00019p-PV; Tue, 22 Apr 2025 17:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ku5-00013C-4j
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktx-0000Qd-4P
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so5956035b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356291; x=1745961091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4x0j7WHmS5PoiJFKXF/CXQYHRcuf16x9CbNw0mWO8Y=;
 b=gfBJvrFJ4d3TyZeSofUAzwSD7Mdna1/+Vow4oVuezXtYOxHYAbW74haUsbwjwWv5Kj
 grAJXq5yK+I3Y66aox9jXGAFOU1H1jG8cSJAS4q0zIjxEFLOxaeUlCdxVLR8yPdN54Et
 ECAlYdsHIAi6i4PwkJh7/rXQWkDz3VwszSeIDdnG+21pcXyTkw2r66IdtXGKr9pfn+88
 qked+9+3wFGWKJDF6Fn4o6+H+rXIcNOcznc3usqA6FdnigpatJ4wBSOXXA6PwSAr2Pnf
 nSI/0kpwrSYroWUf7mXmOclbD+g4aEVi/TAJ2BjFtWLUSO+c8gZ3UGESruZD74+N3x0P
 hrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356291; x=1745961091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4x0j7WHmS5PoiJFKXF/CXQYHRcuf16x9CbNw0mWO8Y=;
 b=SML7KotKShkAIWffEv6zWUdwcFD6XqcdkD3febPZICfk5dF/aZWTrAOWN5bbC5ZKLA
 CuLiG9BLIh+27FmBa5ii1XQi4LzRoDr4N6FVtT2KUAgS/JnMXSMRG/e/VhCdkOKzeQsr
 bXCwsRYGA3sp818mG1R1YBKTHitJE5AJolLy33BB6qtTEKwBHE2mRjwbggS8ipDHuEoN
 px2VwxP/Jh+fSuBUE6VCv7IqNmkjDFhvdZTGtA+NwrY0mWxpL7wqmaJCRWZ6BtlJ3eFQ
 6mcjdRBcfGUWoikWXRABNDzlryS52FqXBUvXQf4F7tAetSEICIaQPbqQ1LZn2JaZ7oth
 C34w==
X-Gm-Message-State: AOJu0Yx1RQM7MPcmMXMJIPXpYkm43jsDkPR7hChXD5A/YgO7Z7T4T4n4
 2kw03FhEYoniOc1S5uRKrZL6PaDO0NDcE5pyeodrDQeJ7SUPC4Q+KTrqLYLkmQB831tg+ipHIYp
 p
X-Gm-Gg: ASbGncs+7p5FBBkTyAkHF5i1D+RKJhbPmYCCXt0i+fl2x7gknAddJJ1chLZ/wftZqEB
 11zxvf0s4Qg3pP0weLil8FXe/DX/euq7e5tddduofRaFf+YSTR8OLGD0JgzuCeVwYFLW6eQhS9J
 6NGp16c4MXf1vOE/bBvWu5hQmaBi01RAtSOtqU9CqCz6XhWtrUdX4p6CIxA0MoEfpB1m9t/e9Qx
 Y9+PaF7SH5UuHx5wTVoTokUZ5NWstbxTr4rwgHAX3h9NPgg0Xe9gx/uVRINk0mherq3iWJkD31T
 SfuZuTOhaIXUgguNRHzEsVzNDOmmRDTJWxLXobkoAla/atluto6nDUMV8xCRENpKDKJvqQ3qx2M
 =
X-Google-Smtp-Source: AGHT+IGYnyUFNSdjvJkc0VIW3yuJtg5aiz0NyZ+LALBqUDcckNurq4l2e7uGpiJrXW6vpO/DZ00KKA==
X-Received: by 2002:a05:6a21:3305:b0:1f5:8e94:2e7f with SMTP id
 adf61e73a8af0-203cbd0bba0mr25055381637.33.1745356291350; 
 Tue, 22 Apr 2025 14:11:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 9/9] target/avr: Increase TARGET_PAGE_BITS to 10
Date: Tue, 22 Apr 2025 14:11:24 -0700
Message-ID: <20250422211124.305724-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
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

Now that we can handle the MCU allocating only a portion of the
first page to i/o, increase the page size.  Choose 10 as larger
than the i/o on every MCU, just so that this path is tested.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu-param.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1..f5248ce9e7 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -21,13 +21,7 @@
 #ifndef AVR_CPU_PARAM_H
 #define AVR_CPU_PARAM_H
 
-/*
- * TARGET_PAGE_BITS cannot be more than 8 bits because
- * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
- *     should be implemented as a device and not memory
- * 2.  SRAM starts at the address 0x0100
- */
-#define TARGET_PAGE_BITS 8
+#define TARGET_PAGE_BITS 10
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-- 
2.43.0


