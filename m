Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B2C35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFLO-0006rO-MB; Mon, 17 Mar 2025 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJO-0004wA-J1
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIb-0006E7-1M
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22438c356c8so83697135ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236485; x=1742841285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdsNHldr91xnqdGHk1DTLXuYnmkD/cCe/HKmA2EoKL4=;
 b=bv2EfyrDbwpspLWOAJosLQNUVAJiyDbDctswELIXN3fPdiN+2ZrM4Whx6Qh70uvltq
 Bt8+ff8uZaF/6z/yWSmVux8m8eIGgMjb4I9Dy8XFvceK2awta9NpekLW6uFhRo/tvxMr
 8Rek45fNzRgTG72ehlePFgxFQIJ+3CkSgxQomDyouQ2X8w9O8VbjOBWsYmqPCoFB7HUF
 5lUV+YpUhU8GZAVhE2UblhKaesohNXKUiwYvDTErr7FuAJgU9vT3mXw5ZBOGjNH8aKzp
 THIlgIoXojLP9xgomr5BvLK+QX5VNDQwDBt3LaLA5MkjvOPw4mHYTSSR8ZxLzCOe/DfL
 EXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236485; x=1742841285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdsNHldr91xnqdGHk1DTLXuYnmkD/cCe/HKmA2EoKL4=;
 b=XlTieaKdlvQryJVp4HsitgF7L1ZANQq4RwYgiIL0tIuD/woGFjxWL1BBwv0uG7xZg1
 V1gbc6CBLLWA6eBbJmOh2Fg+unTPBtjt5KvGuZFnKwSBpnxzv9c0Udq27zYSfJdGXFk0
 GyKCp2Sv0qtGeWe2VC60wJ8IaHQ4PScgW0yXyvvlES4mEM5euJ/SO4a99nkn3G22t1jc
 vHO84hdtS/ZVN5H0pu30oKd1/bp0OAGvJubmdX84km8zq4s+N40Q2Y6sRqRB/f8y+uH6
 uzqXHhEyfWiB9D/zyLkCevHZkdn7GQkWArLsZfZ41OWCtkZjc8mg1pUgnvGChLA9FYnW
 LgpQ==
X-Gm-Message-State: AOJu0YyNfFvhUroB45DA30NQxcAkAoKfC8EbB0XXDbTFlLPnmVni1IhJ
 9re3t5YrV6Vb7Xwq9HhfLnr6ARddJFRvR8F1Po8SseJCyR08+Jbc0G6Y8n9kozq58EAxwAizZHk
 q
X-Gm-Gg: ASbGncuX3QW7ersgcGur9O3hgiIPoWNRaIURSaf3eFW5sYFbB4CYac6hU/XSkuAKVVj
 SIKv0WFi+QZOIeAwcJh2eQ9/gSqOthn9OfkdY+K1I+JTClhIzfzh4mPzaVoa5OUEpWlqLRmoln0
 m+DbG1ILu84h3b2EhF86lniuhLD1iRStswbivd7GT7xKeccMnhl4IBDqbypqwj+85prRo/q7ck2
 tI3+xPexPkhjNmaleocEdxYUWtMicYUa+FaYKxxOaqxNdS7DP14axE3mPhFBjZI6OAaCV5I0o70
 I3Uu9YNf7hfNBs5SGl4HROq0pHfAf9VHjzGwtbAeQOf1
X-Google-Smtp-Source: AGHT+IHzNNUW3sLQt1T364FsCohrjLgSsBCXmjd/XRyR5B72Si2GIa2LUJ+5Zkf6gr6cDVKPRd/CWg==
X-Received: by 2002:a05:6a00:b95:b0:736:3d7c:2368 with SMTP id
 d2e1a72fcca58-73722353269mr15820164b3a.7.1742236485130; 
 Mon, 17 Mar 2025 11:34:45 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 18/18] system/ioport: make compilation unit common
Date: Mon, 17 Mar 2025 11:34:17 -0700
Message-Id: <20250317183417.285700-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
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
 system/ioport.c    | 1 -
 system/meson.build | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 55c2a752396..89daae9d602 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -26,7 +26,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/system/meson.build b/system/meson.build
index 4f44b78df31..063301c3ad0 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'ioport.c',
   'globals-target.c',
 )])
 
@@ -13,6 +12,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'ioport.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.39.5


