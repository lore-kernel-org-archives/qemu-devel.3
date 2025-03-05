Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749A6C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqw-0008QY-MK; Wed, 05 Mar 2025 10:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqu-0008Oc-T9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqt-0002LA-0i
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so62238015e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189205; x=1741794005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6dIwE7gVAC3kvr4prQgvoWqphwYC2S/k+p1kJTqC1M=;
 b=c48DXGjxEH3K+6+lw+hB76dsjSZdOgCcSN5h7nwg82XugAfvjPON6BzNRCt96HtPtl
 ozBgF8lMemjy401D3REG238dJPC46+4zuGr0+TIaNeuiyT0OXM+Vq/gbljNdSROsy7aU
 Bf3SlFETTuWROUrRGXQHiJ+2K+AHeBd2/roowjwTSlYOKSgaRGqHf3Je723CYi6ygTRJ
 uruEAO0eD6c7lWzK4J0YWe5UI9jYiW18XT8wzep2rNsCDvZqoe7Z4YdrEtsD+K5b4KOx
 aXDgwNvFZacWKpUefF334Cn9MYakm3MxyIuha43oYFLnQm2KDi94JFjggJ3epmZ1MWQd
 GLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189205; x=1741794005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6dIwE7gVAC3kvr4prQgvoWqphwYC2S/k+p1kJTqC1M=;
 b=lQ2ZeqbkdyPY4rUh7XjR9n7XtlDc38fzdXIRg8z6kLa6AZYMa+skSpANaVkZKTu8u5
 Io437DQhdt10gP0OGyMJu/X5408g3ikB3C45gl3hw/ugLJnVy+ZbR8VcZFCpZDKDaetr
 /9fjFSRegVgXGLxZ0sw/zl7xTeyw5vCiSIljsZzDtAmxrgAX2nqBMBpQlrkyMISitQ11
 VSge9LH8k1Q7PAkBJv78Tj8vE/3PA31ILhiQBEgi0/skt7D254dDORd2PpkbnImWtfMR
 OxUvdFDfkMihOgjf2P+LI0oT58VRh6KKlb0Kdbb0l01z6ftUSHGz+8xlBmwd39phETwm
 yjqQ==
X-Gm-Message-State: AOJu0YyxIzC3ZoN2J7rPkyfmbgAB33O18TnuRn01+N1zqwTmLXsq/ZUo
 Em6NtAsvd1ybqFSJrmPsSAYQuObc0vYKVGDjBKzYAQLBK3XDGcx37nxrhfc2gqkRNk+IG/5c5OP
 F+uI=
X-Gm-Gg: ASbGncvh3PSX0tEpYYifWh3YOTL87pTnUP6qk1B5V3eit6JfbZ3B+AVfZsLgIEXLfw9
 IrqNktW6lQHbYv1aRJcD2RJplezO4KRe2XnqwgLnC/aqSslrdVSiOQl/t4/4PKfMC38+O7utGmv
 D/p18tLpi6sv0VmRjnfxTFxkM0eT+HE/ZEr2lvyOr/3UZ2Jq8TqwQbLhZuRI41mUCT85NLWxlp6
 Cui8SmATJsMW8o6zJ3QEphDiIJZz6yd6YHdWqQkR5LMsSHlMTSs/vVGq98t6n1h3XVXMUhUtSYs
 UBYfJ0w2Rs4tChyoGUS6yr1QSxfmQ8d72/rkRCj4FcIzUlS7axtP0VCLsOc82cG7sLBE87CNsgy
 IGH8bSr9MdOM5iWtOb9E=
X-Google-Smtp-Source: AGHT+IEEw1M4NTgNFD4c1Pk88DDohyB7w17rsrnSVgJ/UueZW5oDEyan6zat3wzUzU3k9bDq32o2Fw==
X-Received: by 2002:a05:600c:4f15:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43bd294bc2dmr28503345e9.4.1741189205082; 
 Wed, 05 Mar 2025 07:40:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c6f4sm20308835e9.34.2025.03.05.07.40.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 07/18] hw/mips/malta: Replace TARGET_MIPS64 by
 legacy_binary_is_64bit()
Date: Wed,  5 Mar 2025 16:39:17 +0100
Message-ID: <20250305153929.43687-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

For legacy MIPS binaries, legacy_binary_is_64bit() is
equivalent of the compile time TARGET_MIPS64 definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 8e9cea70b13..3517e437f26 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qemu/datadir.h"
+#include "qemu/legacy_binary_info.h"
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
 #include "exec/tswap.h"
@@ -1300,11 +1301,8 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 16;
     mc->is_default = true;
-#ifdef TARGET_MIPS64
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
-#else
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
-#endif
+    mc->default_cpu_type = legacy_binary_is_64bit() ? MIPS_CPU_TYPE_NAME("20Kc")
+                                                    : MIPS_CPU_TYPE_NAME("24Kf");
     mc->default_ram_id = "mips_malta.ram";
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
-- 
2.47.1


