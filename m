Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3775E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRo9-0006cL-Tt; Wed, 24 Dec 2025 11:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRo7-0006QY-LC
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:51 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRo6-0005Fc-5R
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:51 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1212816966b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766594028; x=1767198828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iY7+zV3iWK1Z4mcNAheWEHw0L7bIxeyVXz+QVK68RTQ=;
 b=czBfQLVFlTcKb/WPYhG7nXSxoCr0bTpLK9TWZpFksxL9wKs6Sqy3rUcXbYOpD90aIg
 zFL6RRxHoipp1RUpXSRSYmlcE5NLvytmYdxVoE9H32F15IjGMkreSdlroIASXItnLesx
 Kh/d36YN4S7t805MPWSIDNg+FD5a8bsK4yujAE81dlW8qoxk5POTHiiKSGlJ+zpxz857
 V0gk8C/BEkHwY/BuP5KwXM9bB76ADaokvUeC1wqucZf6jMw83eRKJbC3cZKqSIjESZyl
 yrfIXxrWk8t+G/IEnKvL3x5bvGvTFXkQEoxVh/53rl8EWRjYto9Z/DCII87LUjFWjjN1
 QeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766594028; x=1767198828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iY7+zV3iWK1Z4mcNAheWEHw0L7bIxeyVXz+QVK68RTQ=;
 b=QEdVPPMKIQILf/J2j8QLXeoUtaCZuCZhtaZvmAaeLYZsQ0+aOAjrT94BPd/zerkqLJ
 CPtVLD/tIQWsRCS/+HI6RsSF9qWalNDiyN8TP5exbthKHbQZih9UvC318CUn34sqjjM6
 AkNUchXKfabNuPgzz8j6PUZMZFSETVLM5EWjHGlJL2L/wjJ/HdLvmWxEVlkx0sNtlRrR
 GPD54DNiSwevsg7n7rnqCO9dt4uPoz/NiM8htKvyi/DdnxM6hBtblJArO/kstYwykT+R
 uHC9+1q7MWlyPUP+RHevTWkxwzlJZ+oRX8O2hf9rjt8wMlgqtAtyGkZJHL9QoF0UZYYb
 MOfQ==
X-Gm-Message-State: AOJu0YxY8N/HulI1+4oqLo73X4qxK1CAzIXeSjFDb4m3L9xfV3tW4cPN
 D9ec7jsf+EUP6oUG7eBc2APHFPP67XRvL6VBo/0WdHOHaEyz+jf968LKajDciv+MPHb5z5bsLqZ
 kiNuzQ4Q=
X-Gm-Gg: AY/fxX5/aLWD5vz+sEC2Wr1G6ovLQd2Cq7QSW63/L/lENqzl34tXFg5s5db6wIyOp38
 r9Rn6OMXZGFanyStBvQytwSndw3RWfNnsUvZZxpZ0EKVxPPxTr2HGS3C5XRbioNo8vkpXKbtXrp
 DPLwTsYNv/pigm5LUr/WTyVbf4gRlqZyUJNXJZ4Ur+VpmZupOELbIX6PynOR2kajarNe1F2hSlV
 ktdXhb1k3Egz3KUEXm7fj9/2dnaM8U0eo+Oxb1DOBi2kAUhtwqpfXik4rlH5+Tx9OIJv8vpwPsE
 BlWSHnJxlFmhCFdpoeSICDQbbdPi8ipFpVirwOWuPNBj3YWtUGOLeRIZ33KxfOHVyQCSlo7pODx
 IpD229kcFfOwPy/GNFJVFSj+1LZ1IMChJnzeIneEgv04eUZCxVhL4XOSJ0lba5kIjFVS3Z78eIT
 AtfQyaZzb8A/cq0Ss7R5qOFldHTyM2LtYzuY7aYo5jOJx5gaadbUp8tgQ=
X-Google-Smtp-Source: AGHT+IE4HcdeWEaNxJoYpeoiC7fMmTqfxA6b0HWDUHG8xxfQ8MxdZHI4nc0aWmsTK9lDq1BX/8fsnw==
X-Received: by 2002:a17:907:8686:b0:b76:8163:f1f8 with SMTP id
 a640c23a62f3a-b80371d6725mr1932052866b.53.1766594027872; 
 Wed, 24 Dec 2025 08:33:47 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ae2dbesm1864832066b.29.2025.12.24.08.33.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:33:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] configs/targets: Forbid Renesas RX to use legacy native
 endianness API
Date: Wed, 24 Dec 2025 17:33:04 +0100
Message-ID: <20251224163304.91384-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163304.91384-1-philmd@linaro.org>
References: <20251224163304.91384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

The qemu-system-rx binary is buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . 0f4af4e2672 target/rx: Use MemOp type in gen_ld[u]() and gen_st()
 . 2062fa663c0 target/rx: Propagate DisasContext to generated helpers
 . 8b71fd6ffec target/rx: Propagate DisasContext to push() / pop()
 . 363fff6d1b1 target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
 . cb8e4556d58 target/rx: Factor mo_endian() helper out
 . f9903a8a23e target/rx: Replace MO_TE -> MO_LE

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/rx-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 3a90f1b9977..281a165873a 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/rx-core.xml
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


