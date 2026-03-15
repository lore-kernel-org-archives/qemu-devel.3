Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60271F3026D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oiW-0002sW-MV; Sun, 15 Mar 2026 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oiT-0002qE-EI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:53:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oiR-0005Bh-QV
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:53:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso34690985e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773593602; x=1774198402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0NEITniyNI/FIGYoSeUNcyMvGs7A/VnLFtbi3zjb/c=;
 b=ATxMf8qrU7KFM3Cw1dixnXjOVjjhWqhWNFUMTJsALUInOW1mkRHf+wYAacSWZEpTyr
 x+5hms8LJ+5/DoosOH39rPra99AOkh1wznmvuznQFAfYUHOeb1w6Qs63wS2vKpUpatW4
 MmnFbfMWCXjXH0EQLfDqkkaTqEU6n5JBQCFLM3EZwPtijz2tCboOAxKxIdDogoKU8aur
 u6onqXY+9Tw3pfMeBSLHqKo1CqyawDxRwj1Alysh8QNCyoxa7/5fR/4dFi6HRgc8Rb1j
 eKs7ulEyLlDrD3qrb4cnM+k8SETlY8FQYBrFE51dk79swO6WE9qDCN4MW/Zi8o3gZbiH
 M4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773593602; x=1774198402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0NEITniyNI/FIGYoSeUNcyMvGs7A/VnLFtbi3zjb/c=;
 b=fzfhaIHZNvH+PSPjB8AveNiJwaRlu6Z304jTac3SGRO2JmGEGwey+Fjok80XNv8lPr
 Yd8KlLYtdh57iXchqEGFoeAY4CBO/uq3BIitYxb03dyIDy7JE315N4mrCMtISAQGITXZ
 cs0838z8NMHeHRfC/atHmpSRjNw/mvqI0eCHu7AGkCKvnICZop50gxeQXJgUQVAY8uTO
 Hh7cFX2EehhN4OUw2bKLbhl0PISRBAWrxg/L0G8f2FdsxuD/lR10qaDXF+0miYZwUJLj
 o5BuIYfSkFGnhfEZYDk0w3YSzdoA6xyW0AkHRisHIZG4sf1dBfO29sR0oKmoSyLIYebl
 8hWA==
X-Gm-Message-State: AOJu0YxfmUqTU88w5HYMIvtWyUv5NuLwZpVFcJVrZioSRUXkcynR/3E0
 DvIu4ktnVa8qhR7PdKskuoy7YW1kJBAQa3aLIpjATaosilBPdSB7HP2gdPFzXbdsPku1s2JVX50
 wf19CJ5Y=
X-Gm-Gg: ATEYQzwS3cr6r+koHmAjI4ESrak5rUDkFa0B855SKXswarT2IshlW0UPqbEnc7v0+a9
 Ydh2pz3DomzTelQX2ufBlgDZmcbqgkWxu/Rfnat9PQFjCZriVV0nTiSYcTCPLYCeFdlNyI0TBnP
 qjP7gVQeYh5Kju7+Nx7Ky7aeyKLB3qdNM4BoEXxEcwAfl6Yk5JC+tYCJwwJVBRHKjO69kdmxv2e
 6bu7QGQB4p0Ii+lFGeHOikX1uvyBtI8m+nMwpNSGz8s2/ISn61q17M9s6ZL2XhZuJl8fAukxArz
 WUR16hDTmcg2w1kNpbYpMyYDexkc1TurX4MiS//3S2ituaELLIpJVnqVXLx3XAqMQot6ZpDnlCV
 pJSgzYJsr/DCbo4B4/1AiGbOSqzihYQvhIRMzEz9uhRof49cASk7ZxEbEHeutxkbIoDABFvaMSL
 P4rHZo7K7xY1emXDk0xNnuFu9FTIzgO1JFnfrkxDu4EebEE+j4Dil1HWgTAcwzI+nkn5WxQvsV
X-Received: by 2002:a05:600c:4e16:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-4855670cd92mr163078615e9.30.1773593601759; 
 Sun, 15 Mar 2026 09:53:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6070acsm315607185e9.8.2026.03.15.09.53.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 09:53:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/i386: Replace target_ulong -> uint64_t for
 TARGET_X86_64
Date: Sun, 15 Mar 2026 17:53:19 +0100
Message-ID: <20260315165319.39727-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

These registers are only available on 64-bit builds, thus
always handled as 64-bit. This isn't even a migration break
because they are migrated as 64-bit since the beginning
(see commit 02536f8b1f9 "x86_64 save/restore").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e5ae29f8af1..b0c730b3390 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2058,10 +2058,10 @@ typedef struct CPUArchState {
     uint64_t vm_hsave;
 
 #ifdef TARGET_X86_64
-    target_ulong lstar;
-    target_ulong cstar;
-    target_ulong fmask;
-    target_ulong kernelgsbase;
+    uint64_t lstar;
+    uint64_t cstar;
+    uint64_t fmask;
+    uint64_t kernelgsbase;
 
     /* FRED MSRs */
     uint64_t fred_rsp0;
-- 
2.53.0


