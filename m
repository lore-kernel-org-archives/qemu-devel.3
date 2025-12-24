Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC0DE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ3-0006hJ-SE; Wed, 24 Dec 2025 11:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRII-0006TW-Gz
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:08 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIF-00060r-Ax
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:00:58 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so6612950a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592052; x=1767196852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Plt/JvxJf6wWBs1it886xzqgaHX7P6k6nrPi82rdVHc=;
 b=vRqRkarvUkZWt9tRN5uqZe8OQj9kTxixTHMRwwR+2Oi1N0FQIKDZYBJi5jUKBKTN/c
 6IkuRNjk94ChQbArB52mKRukTV1GKYxW1ryKRHlAIBBqqnbULUjp8Aaqa1jbSM8dqJ8/
 pZIXhq+H4OR0tOqzvbfcIXjXvCi9E/hWthFP8YWCzQTfQpO2rfWQbpe+rOLgVXGRAed6
 oQJF7IXD/fDohAJOY8pHgeFrtGZFo7Uuf7zWEUpd1fB5nEmty6G6IVh2Kd/aVGgGTVCg
 XDzwF7TI1hxFD8i5CRinzaIgpT1T71+zdrCr0y9noMA5s4QpyynaB4xDt8OjHKqtLX6t
 Ykyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592052; x=1767196852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Plt/JvxJf6wWBs1it886xzqgaHX7P6k6nrPi82rdVHc=;
 b=JfSUAcplj2baA/mOSsVbQj5dQfq7Di7W+HtDTk+wQ6cfLuG/HekO+ufu7tQ7fyxZkl
 v5XUEbdURV8JigBpCSTTshZz2zoHiDs73SoI/kYd52UZCQ/In66DYgzSkeOTg1FInswB
 VcBA/8QdWD22sXnTnZD3FSSFONumjPRokPxt2vWiqTEAJPWu6cEI4RL/9wrEVYS4bYTH
 26t5HSEncM6h/lYMvh7ZaTu7pkJz7Hurz8KZC5lY2Jv5iWJ1SwSy1irkuT5tf+Ld0Drp
 V87+GxHFQgwB+JzxNcy5d3p04P20v9jRvNoPa33IrHYcmmeqFNgYukdn5ddft4D7LWYY
 MsIQ==
X-Gm-Message-State: AOJu0YwSXGq1dpgYJezwvnoeFvC0medD6IJRizWNNwvEBoQoupm5Zx9U
 7JPFnD+Fadtl5gJ6Gj0X+3oK7Rhstzsjcuc0U5nED+pddQfpCPq/mJQZNlakfC8ON/DuinbX+Iu
 3J0maZhw=
X-Gm-Gg: AY/fxX49GMtCjDyozDVopL/vVkJXZ6dLDbSTBu/s6tcoRS7tAPu8wHre5YSAIHtlR5a
 v7i9BIuBLBzgiE4uGsvx1u3Fd5APrJhIygXxK7bJ6DifXtr4FrowzKJoqeI0Fz08jOY51noPSUz
 Zp4mjCPkGWLitaSrmf2IeV3QGRADlpXe7XGUrQgVJ01tYEoKjfoIk3GR1CVj1xWo7u7p6qbtltD
 GMAzEI8SYZPTbssyj7OrFsSCtx1xOZ0GJZClv627Oww5AOmHFYclG9kQ50H/eF+cSY9Aogf8bIH
 OUZn1a4ppJkrE8TBFvMyuPbGxXVxZfxLXs8bcUtQrmcFvx9efPshA3gi1rQzHc5k6XSJ1BUAhCr
 upU0up8aVVG/rvWmeNP74YDIR7khSArZuWUB2Q5oIBRk7qESGOhyXa07Smwd44+i8sExuvMAVz4
 0R+CqlmKGoUeI5IYJ62toQkDTnPX2IO3vuyUr589yubxIZjxhBRnZ/az0=
X-Google-Smtp-Source: AGHT+IFEJ4+x35x9K2CEd3lsRP5p6HV3dW8pbPoB34osBXc20jRI39JRBQruVydTKjSW4jLMfSLQjg==
X-Received: by 2002:a17:906:4fd0:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8036fade7bmr1960531066b.27.1766592051885; 
 Wed, 24 Dec 2025 08:00:51 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f09149sm1782035066b.47.2025.12.24.08.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:00:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/alpha: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:00:34 +0100
Message-ID: <20251224160040.88612-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

The Alpha architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/alpha/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/dp264.c   | 11 +++++------
 hw/alpha/typhoon.c |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index b6155646ef7..203b9ce92d7 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -194,12 +194,11 @@ static void clipper_init(MachineState *machine)
             load_image_targphys(initrd_filename, initrd_base,
                                 ram_size - initrd_base, NULL);
 
-            address_space_stq(&address_space_memory, param_offset + 0x100,
-                              initrd_base + 0xfffffc0000000000ULL,
-                              MEMTXATTRS_UNSPECIFIED,
-                              NULL);
-            address_space_stq(&address_space_memory, param_offset + 0x108,
-                              initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_le(&address_space_memory, param_offset + 0x100,
+                                 initrd_base + 0xfffffc0000000000ULL,
+                                 MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_le(&address_space_memory, param_offset + 0x108,
+                                 initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
         }
     }
 }
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 4c56f981d71..0a039dc8a31 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -622,8 +622,8 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
    translation, given the address of the PTE.  */
 static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
 {
-    uint64_t pte = address_space_ldq(&address_space_memory, pte_addr,
-                                     MEMTXATTRS_UNSPECIFIED, NULL);
+    uint64_t pte = address_space_ldq_le(&address_space_memory, pte_addr,
+                                        MEMTXATTRS_UNSPECIFIED, NULL);
 
     /* Check valid bit.  */
     if ((pte & 1) == 0) {
-- 
2.52.0


