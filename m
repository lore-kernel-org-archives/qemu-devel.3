Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B738C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3o-0003dz-PW; Fri, 25 Apr 2025 11:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3G-0002jF-Rf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3E-0004Hr-Ls
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1928592f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595194; x=1746199994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwOMz65eNIs3eoNbv+VmSzhLE0TAejNO0HCTVm1dLkU=;
 b=l9Bw/0RBAnzd9nYS9nTRz0RNSbETeYWi1UmvhW2fg4NhwGECdKVUFmPGsSt9Hgs7DS
 L73BoRTLDhgaTjXi11gqtvG2N3kH/573HywaDB0EseqxKNXp/nF6HeaV6SsaTskdaQek
 ZFg6wmt6sLizjAlovoY2JlDLDIiEq6jcD+KEzXMYK2YPkpcJ0ZosZx1AGArnAzxhZd/P
 fX/Cv4K2F6/4UjZoAjqDcHz6JLoRzo2gPAclCRyC4F1fj1U2Nmn+7yfelWokCrzzV181
 BO/yQ4jwmGVSxpq/3ICEfG1zehouFQK58GTH73qTF1Y0BsT15CQZZhdAFUj2N3eaY3ec
 NFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595194; x=1746199994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwOMz65eNIs3eoNbv+VmSzhLE0TAejNO0HCTVm1dLkU=;
 b=S3479rzDG0bnwwTL6hZvdKL1Oqi5cq3V8KpwtmMlpSRrwmwO7J1d0nsiQqK2vc8A50
 E/yQde7kkrMfrUvcLO3gvrz4evy18LwAtnlNfyhPRJo99yG4Vz3IhCOg1ZfFZ2VWFiKC
 iuOGO+r/jiqoU/lYjY07dJm+03+z2okNCO+hifLBaNZMK4BYR381zcYIZVUm3UD9CcrB
 TVEnxKVpVyBV2MySt69sGabRVjyKB9iRLOfH6pWMUwAQdNUCL+3s+EL1P276Guv/XjuF
 Eq+woMN7wL6UwnPw8TAelgXpHCmdkwqQT3mx2zKjqhuRdhiiWZ92xlnI2RHiNaOAOm8Q
 bezw==
X-Gm-Message-State: AOJu0YzgrvCmRtYFyUxPZFyUMhiyUd0bgx+lLmNhaFEGxVy2y7SsmB+I
 blx2HGkYSaF1KcjLrE34R0O4kTZBNXiL809hDR+4f7kMdcs56/ZSiUzft7rTKjNwftl51hdpcaL
 A
X-Gm-Gg: ASbGnctdHWpw5XMeiQdxkuQAxL6hyb17hUOoRzpBhsVJoMihDe6AgRBm02A/cjVNx/j
 5FrZEEDDYYmZEmQIL/1dmkP8V+Q6VgTqRl/tdgz90zZvIKauo1JSyqowzm00P3kBMDQg0F7eFxX
 cQDWb9CX7bBh9yPHdUNA86GFUUMzC6C48hqq2YATRYSlituRwIyArFYf6+QLDTaIw/FifPffY5A
 PLinoM+wHIe/hA5TBoDfXKCHIXoFjDgS/fT9/rPyDtrO+FhP4EvEbpkoZLq9nK72zZ0ZVcsw6Ih
 fXf3jk92/8h3vR3g2GkCSw51YYTWBV2577Db763GxpYHjqv32iw8rmNohU10RE39NGb3pfgtUpy
 LhhcJSzRVWP8uS9QO0YCM9JxV/w==
X-Google-Smtp-Source: AGHT+IGjrEyAODWqPb7eQYThn+FjhL8qqwiiHasnyFfayRLqpaZWlxnkA2zhwh2DuiGPqOqu6IPKNg==
X-Received: by 2002:a05:6000:18a2:b0:391:3d12:9afa with SMTP id
 ffacd0b85a97d-3a074e2f0a0mr2276474f8f.21.1745595194490; 
 Fri, 25 Apr 2025 08:33:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5cb16sm2618012f8f.84.2025.04.25.08.33.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 55/58] accel: Include missing 'qemu/accel.h' header in
 accel-internal.h
Date: Fri, 25 Apr 2025 17:28:39 +0200
Message-ID: <20250425152843.69638-56-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The "qemu/accel.h" header is implicitly pulled in. Include
it explicitly in order to avoid when refactoring unrelated
headers:

  accel/accel-internal.h:13:32: error: unknown type name 'AccelClass'
     13 | void accel_init_ops_interfaces(AccelClass *ac);
        |                                ^

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250417165430.58213-6-philmd@linaro.org>
---
 accel/accel-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index 03426aa21ee..d3a4422cbf7 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -10,6 +10,8 @@
 #ifndef ACCEL_INTERNAL_H
 #define ACCEL_INTERNAL_H
 
+#include "qemu/accel.h"
+
 void accel_init_ops_interfaces(AccelClass *ac);
 
 #endif /* ACCEL_SYSTEM_H */
-- 
2.47.1


