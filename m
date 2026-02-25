Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA42AFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9U-0005yo-Rn; Wed, 25 Feb 2026 18:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9T-0005ky-8T
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9R-0003Cu-Ll
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so2518895e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061520; x=1772666320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L72HHxccWxsDctKu9kcpcvWnB87hWFYOeaRRdfdcF/0=;
 b=J9s630NttkwDeYEble+OlfCspoSMXW1TzSGbl+jDY+nWjkD1YbZl3kcUlyUKAvuhbM
 aEuuiaieHU5w+x4O7M/2RbQa6e7d2dkGyMKcE79WnW4cDU+lzsy55NY4sVCLsprlJgQN
 m+hvmg6OIVJ6OOvl4VFgimNETYM1p0r4FOYmFyJ37XLqCWOx31Uyp9WXZLaSnOnDmtQA
 3Gvlhk+5g4VquQB9I6ZdgHtlgmTdY4M7axBX0YaLcz57GuP4w/4xsjWytgOnWvXk4pxI
 I5V3e11WrefUuNxgNyVq8nGwHFy6fb9N7nmXq1mFJhISsek8x6gQPWd0bUm5yLNRbacp
 KM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061520; x=1772666320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L72HHxccWxsDctKu9kcpcvWnB87hWFYOeaRRdfdcF/0=;
 b=h0L5WDAz0kfY+OgG2x6q9TGVJzW9gW3kp5BanglP5e+ooiM7we0r3kRcXT4/1O/o5e
 7ciF2wJZ35de+9MRBq68IBMLjyHF+w9DtCw7eyV4EQMFN6QGaLmsZn1Nr9hNmldwqtOo
 N+RYfmj5taQM6M/RdB9EdRJrNIBlXIGw8EbMf424OrSHRmglSi73vabl+C6Eu0/B44mn
 irjzxBaKJJFqspOhvxDxw4P5NFD5duLC7vokfFMKT8sS8tnAZN1nLUDZTUTaKthbpZRL
 5/ySprSrg8uqmO5NF7k+IzNpsdDaIwV0/1ii3/6n9U74n4Wvwow15qgEi68W9iJ/r39z
 7IJA==
X-Gm-Message-State: AOJu0Yy9DMtuUpcP1hcUVepb/Z/BkCZiYT1qMc+aHz6vSGMjvmATBBDp
 uLavwagXSd0VFLR/OViDXJkLbb/asQroF7zNTT3goF86Gje5VqdRn889cqH4aaaP40ipvop6b2v
 oCsWNblo=
X-Gm-Gg: ATEYQzx+WunyUvfgBURjA9L86JGFQsajzMogj8D5aQoU59sIkDWrHJj9+AYuX53RLTJ
 WT2wjiQdOyVlyISrj8q25ImvQEC3VNdqQ8oAugdkGXPHTPHsxB8r8yIzd497k31vBn/AzypVtrY
 RmrnHg8Xa6VqknZIm6sjbyxYNFnbDtpwGOS2ghGIMHxzM6GLGT0/Wg5MEbpxbzHjJhhmlCa7mQH
 IDrYz8PimEKzJvYk36euAQz3rRCpmWec27gNXbnPsOz6GCwMo/fEcJ25MKVZBoOLyCxOkvJkGJC
 AI6Hn3igREvvvftuxZId839hiilFqJT6/UvSU07yKLKnnG4jrqRRucSzOcnX3imPRyJNmzsK1KA
 qNTV94aPmrasxffpEAmwfLOkrtj2FSkyOME7TDT6YCB1rr5K3gGWqdUIDQ6wVbCEbn4yOqWe1m/
 aw8mQRDkZHVVmInR8shD97OSta+kVXe55iwKR8i68UcOnKmMW2xn33cBDoVd45bbzLYl0mMLX+
X-Received: by 2002:a05:600c:314a:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-483a9637a24mr263294395e9.26.1772061519738; 
 Wed, 25 Feb 2026 15:18:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm34951120f8f.29.2026.02.25.15.18.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/70] gdbstub: Remove ldtul*() macros
Date: Thu, 26 Feb 2026 00:13:39 +0100
Message-ID: <20260225231411.96482-40-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

These macros aren't used anymore, remove them to avoid
further uses creeping back in.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-32-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 197592036bf..402514716d7 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -104,14 +104,8 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #ifdef COMPILING_PER_TARGET
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
-#define ldtul_p(addr) ldq_p(addr)
-#define ldtul_le_p(addr) ldq_le_p(addr)
-#define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
-#define ldtul_p(addr) ldl_p(addr)
-#define ldtul_le_p(addr) ldl_le_p(addr)
-#define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
 #endif /* COMPILING_PER_TARGET */
 
-- 
2.52.0


