Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11E7C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqy3-0005vI-N4; Tue, 11 Mar 2025 00:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvb-0003Ow-Gz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvW-0006UW-4e
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22398e09e39so91373195ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666149; x=1742270949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSQnGpOqRDw3w//OvJparnGxlKjvigYzwQgvxmVvIU4=;
 b=wooyaybViqP1byEs+hy1w62H6jLG4fvt8jvtS9DSxYc/ObvZSK3umAEpygexHXlIKV
 gZrp5lhSXBfHfxCW7HOJp9zg9rCdNhDSRFBKAFnePSfsoI92AUf/Vb82OFlupwRqtptG
 rU2U4ogDbMgKByU47wiG9yZMP3pXN2IaZcX33VSzX85d9spQD7IrY0CTYAseRv1zX+WI
 FZqzKQn6Fd83Oxl9mN4rcs7v8Dam+zVMj2K99vjqbTOepujSugVLWl57TgaCmHfQdx0L
 rprQqGm+6JGY78ienR2mwlwEkjK+nwfyn9WSci/SFbLhChq9GuXjXsBnn36Ds411VkPl
 pgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666149; x=1742270949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSQnGpOqRDw3w//OvJparnGxlKjvigYzwQgvxmVvIU4=;
 b=Qi/WVo52AaP7K1MV52wGSG/sPM+tskQgHYxfujH4lcPayy5yZ33Hz/JZxEabPoV8Zd
 dkCeMgcHB0U4Ul5zcxuxkPKF2VcFlNFnJrBz+xdwMTGNki1+o6+gyy+FcNdFDXLAV2fn
 cVQaiAWmAdrbanX2Qgi4LR3/HX3SsGTyFxzYddI/GJQjQiBdeCJsZ0O+oEXTtqOmfJBq
 rYgerwPy5PEACGzl8uQ03WVI8TLXPZp0ZVuM6gw5S9/R9bg034yVcnoyBtFtNXqsg4fC
 R83v1ipDR6qn41VkndeKb3YFzT7sve0tI/4+sVpAJWVxoNdZsHgOBmnX7bm9/JFFkWwN
 AoEw==
X-Gm-Message-State: AOJu0Yzvq+HhZgewG/c4n8tUSY62KiCqNlhtY6MivoktxJKFMAQ47b5z
 oEh4xPns1ocMTGhdoxlcUO36P8LyWmue2q/aDwrR7IcS6OAbKXnIVslNMBcCVj2iY/mPip0Mrv6
 /jQk=
X-Gm-Gg: ASbGncvOIS1cDeKB7bpu+qy8asb24PBwaSpUvM0j/gIxqOXW1PSCBJDVZRRDXANee2F
 S7iT6ZI1Xheo4hyw9Yj1reLPD8bNagB0NevfJR3qAMmhGVwyVjczWRXePEJCb2rUPmfzK2U1lOU
 sTwcXxD25onurL4eiH3hZ2ucSwQqeXyBbTe2iMCWeDMBzdo2hobbQkQ3EPnnZn/quPG4GKjBH1s
 2NUKVGNbPJzsWaW1yonjhBrCRx1/l9GM5kJ7v0r8n+lqgByDicagqOHjB35BiOChra4LT+9xGgn
 Q8bk5uK61XwScDO9gsyYpY+RT8c7G2ctZwcyHrCI8D0vMeE3tS6ylDw=
X-Google-Smtp-Source: AGHT+IGAtyqJ8JwUWzZUpShXBSvpRNbrwAinE/LFxHiM0RsFVnA1TPY911KWPkY4EkoTDg/0IjRi5A==
X-Received: by 2002:a05:6a00:23cb:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-736e1b3e670mr7549220b3a.24.1741666147270; 
 Mon, 10 Mar 2025 21:09:07 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/16] exec/ram_addr: remove dependency on cpu.h
Date: Mon, 10 Mar 2025 21:08:31 -0700
Message-Id: <20250311040838.3937136-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3d8df4edf15..7c011fadd11 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.39.5


