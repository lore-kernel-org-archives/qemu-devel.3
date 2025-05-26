Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B1BC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJVw4-0006Gj-Do; Mon, 26 May 2025 07:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVw2-0006GC-1x
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:24:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVvz-0001ps-Vv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:24:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442d146a1aaso25718265e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748258638; x=1748863438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDNGc9uXORNTBpjrU5AzqhH7cBKsBdI7XLELUbLErSA=;
 b=VUQ6ftxzjWsRRtFnYn6R8uk2isreSdsVr+PrEVvwkfsqnD+jHDftf8xtUiwMVlUasX
 PGePyl05YMalQOc53uYYC3HpcBbDyFcYg1c1KqC0fCzfNT+CktfhIIOIMH5hAmHsLVYt
 +AK1Z5Qg8Gt1L/G+g/mqMloUaeV1KN7ieb/JKSam5uYasJ8AfZ+ivFGO8LxnjhuMbBra
 YaTWbagRu2U9dIeZlku9kCgRtjVn1KZJY5br+X6wmRfqzJXlFdVpUrgcGK0YYYbzjKzU
 B/AD8REEPhf9R90tLK9cZYyYWeo75RLeQTh/Ian7rmxsfDri7mDfW3ZpLLcNEmWwytOz
 VyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748258638; x=1748863438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDNGc9uXORNTBpjrU5AzqhH7cBKsBdI7XLELUbLErSA=;
 b=j0KXLXFmQ1fzdzVEtSAvK6p00Y8YMeq775wEquhROPxmiXcCQoaEnzTdCIOdb8HEjh
 hInWzgL1aLrygSXIRNq7qJ5dcZ/iCRtujFBikCKDhLQPuCiUi71wWwSuosVNZgwqG4IZ
 UnygZBZ0hQbq+pxAEFs1Jc0H1ssii2WbBRvqh3LV5vyZL1o8aj4lQrgIUA181pmkgfwS
 RCsg3CenDm0yvRQxpsR0t5lSLqmkH80L6SDpP6SdeygOLzGwMehmhmRyCmQVhlRPU69v
 2LHQWHmbmK8uoqmR391Le9DhJFJ6FjTSTv0yNAUtVqJWWEfp4n20cnlXX4E/X5uEZhB2
 Wq7A==
X-Gm-Message-State: AOJu0Yz2k0VUImvsPr6k1z9o5X7ZEuL+vMmrpsA2RrqHCQ1q4F2IxVSe
 gI1E850jy+nkKSW7TiWz87lMoeDJ2+l/FjNzUdUOjnoIY20ewqu5NFnSgcEtC7NVelyF8KitoeE
 uuQ9DePwYDA==
X-Gm-Gg: ASbGncszS8sSFZ/efTRw8yNTUZ5JHIhu5Zg5BYcbNENI1yzWBFObvPwTA8AEc/xsImn
 NlYBz29VzmXZL2Ysb02UgVPi6Q1fc5LM4NVc6nVB4f+zda9hdq9InFv4DahE/DU7HCEsZZimI6R
 jabvGc+eMerQUMbzqIWO/DnkiF9y2cDDJzkhtc64qtRCapr22prGmAEhXZtUBzCTSHCG99p1EE/
 U9sA4GtTehs/mYP3C+gpqbkhdR8PFED6EhJ/zHA8yDuSBUzThIQVPCGV6uQG/4lPvhZ8XLkIsZH
 EZqcvh0Tl7K8FUc3+WG0JheczHy7SWDWxJoEK0YviZNcGKFTmeh64dBqkxsWqpv9lD83M6uq89a
 wJxoGQjsM3dp/kheBksGUpU+4OAVzTdE=
X-Google-Smtp-Source: AGHT+IFJI2AYVXInSHCGxcYwdH6ujJIhjEW80Q/nrWHP0UB0Ndxy6hOFxEY3sJf12WvcgaCWQSYVXA==
X-Received: by 2002:a05:600c:314b:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-44c93da7c4dmr77361285e9.4.1748258637735; 
 Mon, 26 May 2025 04:23:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4de9c9853sm550080f8f.27.2025.05.26.04.23.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 04:23:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/ppc: PowerNV machines expose a I2C bus
Date: Mon, 26 May 2025 13:23:45 +0200
Message-ID: <20250526112346.48744-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526112346.48744-1-philmd@linaro.org>
References: <20250526112346.48744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since commit 263b81ee15a, PowerNV machines instanciate
a I2C controller, so expose a I2C bus. Express that in
Kconfig, otherwise we get a configure error when trying
to use '--without-default-devices':

  The following clauses were found for PCA9552
      config PCA9552 depends on I2C
      select PCA9552 if POWERNV

Fixes: 263b81ee15a ("ppc/pnv: Add an I2C controller model")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index ced6bbc7404..0d017df83ee 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -29,6 +29,7 @@ config POWERNV
     depends on PPC64 && FDT
     imply PCI_DEVICES
     imply TEST_DEVICES
+    select I2C
     select ISA_IPMI_BT
     select IPMI_LOCAL
     select ISA_BUS
-- 
2.47.1


