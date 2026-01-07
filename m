Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE49BCFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHx-0001oj-UX; Wed, 07 Jan 2026 08:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHq-0001We-C5
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHo-0008Sx-2f
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so17450725e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791353; x=1768396153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPkxcYHG+SlsC2jdk1bjarvCnbLuCT55aC0CvSPC8p8=;
 b=Akxrt+GP9NKajKkrfPEgZBTLbJvW0Dnw3ER/2f+Cd1ocKM/t1RMWyRDtjZYzC9w5mx
 ufBc9dD02pga0cunsuYtzvhWZR58l4DbykefGIOqwUAu1jxhDqz+fqMF5+XlanMZ4HO+
 R2UCM2LAJMI2lkffdm9BsApQgwc8MkN1xEzVrMuJRiCeFBT8T+xaOtl49SIdiZCPXMSa
 Iwr9jFuBf565rZyM1OddIoFEzrNMcQMrPzhsl4dysC/VkBIeND6pV1099rr1pXisJafl
 XAgTH6PR5SdYAJ1qVF36WIlFARYGq48n4Ei1fhqoz1fTgzr08n6XvTYfBCTKj1RsaADr
 KSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791353; x=1768396153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UPkxcYHG+SlsC2jdk1bjarvCnbLuCT55aC0CvSPC8p8=;
 b=YVHQ2MU/z1y6/fC1SICmzatg03OfGcaXyBbXwZ1vtp1NyDbHquWEFVmVw9JUHL6/V7
 tsSAJphA4MOmPdLQMJVaV6BYnKptgkdfoEm6oqzVUZjiMxZdzqcoKoTssTTfpaoxiDOH
 3llVaIypEGo512djuZWJDLHnrKCaxTOgONwvgElv7A+1QpuitASJW6FHXR7t781kmkDp
 ST9TYLEZ8ENAe2FhFEjEJsbRC67NvxoPw+35PAUKXTHOLvJmmXg3hhG+2WTi06+1p7jQ
 qdnHcqgCVtGla6u1vSL7Y1LLKN+22lKPslAlApRHHvy3glopKsGtiuyUmd+6lckPyTpT
 thyA==
X-Gm-Message-State: AOJu0Yx9xmH0r/QBu9iEKlmmGxDErDajSEr5VYCAMXdQSlactyOKRPB0
 Sjiwr9yjf9SvdjnrZBroV6NqUKifIXL4XO5URgnN6K3otyCyjUmVf283KyUEQu8srfRy3jcMjVz
 bkDsse9zGbQ==
X-Gm-Gg: AY/fxX48bu6s4FxdXMZIA2U6Ls8L0yMnvgKcXGsrxksula7C7LFVk9hJEGz2CUGIm/1
 QlxTXyxMoMpblBkHuno3ZOGnStj/jvQOS86OpJgf5akx2uN6651x53lD579Qgn7aZbnBmo79dQU
 hY8BB+gP7tZjYNBjo76PH2ciD+nvfZKu8u/p1lyd7WO1HiGTghsSkBKUE6IXsOAfAO9x5GnodlE
 f1H7ej3wOJmR9ibOwJzwD6GGxMcvGQUy3XUSsepyCX2EEqG6ikx4sB4vNKWJjMVcD4k3nySjA46
 j0vhktZ123t4cSIqFT/cg6WXVq5fTM7o59k1nBLk28Up24U4CSEQXr2+ysR1tNLiFPY9/KwuYNz
 ore4qwQzP0hqChuR7nSTODwOBGODLjU118MQAox8FBeapLK5X52u+5ir1zJmAwFRJeQtoJpcM/j
 R2QcS92D6gu58eXP3vTtjXrcJcnp14qvonQM9MzA4o2+MqS4K+QPp3mespftHX
X-Google-Smtp-Source: AGHT+IGFNV9A9ubBI+h0ii18zKZyrY1NtsEcAA51HLWKqSq/fxGaQ9gqyI4+WVCKJNrtWPLzY4N4XQ==
X-Received: by 2002:a05:600c:500d:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-47d84b3bc37mr19851835e9.29.1767791352769; 
 Wed, 07 Jan 2026 05:09:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d870dd5b1sm12800305e9.4.2026.01.07.05.09.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 09/18] target/s390x: Pass hwaddr to mmu_handle_skey()
Date: Wed,  7 Jan 2026 14:07:57 +0100
Message-ID: <20260107130807.69870-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

mmu_handle_skey() takes a physical address, then aligns
it to the page size to pass a guest physical page number
to the methods defined in "hw/s390x/storage-keys.h" API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b73d902b05a..5a613b33150 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -296,7 +296,7 @@ static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
     return 0;
 }
 
-static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
+static void mmu_handle_skey(hwaddr addr, int rw, int *flags)
 {
     static S390SKeysClass *skeyclass;
     static S390SKeysState *ss;
-- 
2.52.0


