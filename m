Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2629CE8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0c-000204-SH; Tue, 03 Feb 2026 10:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0a-0001w9-E9
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:08:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0Y-0002eF-OC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:08:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-482f2599980so30126225e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131280; x=1770736080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5FbGuI09UeGlV1NJ2eeqCeHlDojkDVpM3vN/lPwtocI=;
 b=X7gaXUx/PF5VbdHE6JgcdYcSusjhXPEb0aoL6z+lpfm851PAsfNugmUqzPQ0KLo8p9
 YHIcnmoIXdXc5rUl5+GCwnUx34wEk03k904gfnhcXUvqu4peOPLgUmLez4nllEh1Pz/N
 30gr9drqDp+YnOqE5596nKxXeKJqPoA3qHXNHmkBFr83b7m/a30qiekPOEYvU1Jc1yJk
 0BHAtsovvQS4xDY8tBT6NFFDiyPdWUSaUFyVoQx71jFdZz0MVVLnrT5GlZGLIW8eNTcO
 7jfNRyyP7h9Rdkl/S6xdd6dJI9QbbJsjawI4KlQ3/PECqe48GYF3FY1fd2quc0Sy9esf
 +9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131280; x=1770736080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5FbGuI09UeGlV1NJ2eeqCeHlDojkDVpM3vN/lPwtocI=;
 b=Ju94MY6CW+sgio+WK5hgmN2DG9KR40Z7AOybK4rli5KUZWnbp9hp7Edx/JBn1N3Ul7
 aibiebqZo5tx6ISsLzZXALbIBEn5qrFGjJWqHhIyTwmI3r+FED/EozTNdGO8V7S6lcTd
 0TPE1KN0P+BBIZilcLt+tTCfNTJuicIS9EXNBcZG/kO3wpiYJpL1Vv3MrQMRz6AxxCCy
 hRnZq8yV2d56niJifJOKwkqVt6NV/YLprcvsTh65S6UNNT3QXGRJU6LB1RnH1SkYozl4
 zSNhP1mkzrUIEbPMxcPnMUGdbnX78D0ew5Fxn/3VMexuXnqmtOYhTTU24O9jyMWCA2cs
 bsXA==
X-Gm-Message-State: AOJu0YzKPnr0V1Xjx17r0M8DsRRX4lPNxc5i2/jXveA6frAMnxT67ivH
 QSDD8+rQiXfnoKn7Js0VErk2JYaygDikg0f8Aan43MnNhPc2rBsOHCp9juWH+6fHSbreL3VRID9
 F9O6rrEYeRg==
X-Gm-Gg: AZuq6aInG/bwZym3jWc8LP8L/ADKRDWuSKlL3tmd2+RDdvkYmpQEdPEBf9yWBuwFnoz
 TODzksKDfadctW6h2bBVpQJjLum5Jln/uMmFE5YsekKx5Vg7WTQcAyBdjo4tGSNFCMD7xV7uyts
 ZkstZQX3uFBXH4hd8LjqlIQjPBsW72ybpU/oWe8N4W/y2NmjVkqmWS0aKS/BeVsmNP2cJ7ZCwJ6
 qnA0i7aYaEWaOTL5ok58VLacS260zaYSOKpyE6QzkzD2jrXM7DrPFKOknV+as3Ms3DL8EiDlw2o
 vzAlJTohM6G+wBbJPDbJ/yNiAkLu2e/afqvoAatFSfQTCB4xuk7z9+sW3EhLw8MqxMxI2g8dtFe
 rebuyqEAEK4ahSHsSsJRioCY2gwtRGxxb/tZZH5B4Zhekb2UvMZsZ7/z8WL+82923oOqwDqc0yY
 6sQg80574hc8+lfuuFiSaGrKyC+IQlI6iHQskga7yQ5mIWXIqNVu1oHMFX20E9
X-Received: by 2002:a05:600c:8716:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-482db48d4c0mr220074465e9.24.1770131280549; 
 Tue, 03 Feb 2026 07:08:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm50886185f8f.8.2026.02.03.07.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/30] disas: Make disassemble_info::target_info field const
Date: Tue,  3 Feb 2026 16:04:34 +0100
Message-ID: <20260203150436.71907-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Disassemblers shouldn't need writeable context, so make the
disassemble_info::target_info field const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-7-philmd@linaro.org>
---
 include/disas/dis-asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 3b50ecfb540..911352703ea 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -397,7 +397,7 @@ typedef struct disassemble_info {
   bool show_opcodes;
 
   /* Field intended to be used by targets in any way they deem suitable.  */
-  void *target_info;
+  const void *target_info;
 
   /* Options for Capstone disassembly.  */
   int cap_arch;
-- 
2.52.0


