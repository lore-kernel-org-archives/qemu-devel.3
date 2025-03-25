Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF59DC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wU-0001Pk-L6; Tue, 25 Mar 2025 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vc-0000tv-4m
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vZ-00083S-Ns
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso47982445e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907764; x=1743512564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPwtIJ7PyZH/NUhwd2km9X/kSSpo1y0r8LhrZ/SyOu8=;
 b=YZcBzdFNAn7GSksyuJ2pEZ7k3rPKX/D8FQhQsthfTXloZdSbpLclz/4uGNOaG6M0b0
 oomTRzzToUnKbbBIKD/UAN8DlRCJf4i25nfqmxqgsAiizZASjBBJa2LLhRM6G3QsVO/K
 RHHPDTNiHnV0Xr5AoHRavJDZXnOBND9PIITghSQ5UvYIpKyWp9nWQai+cs3H7CYY34bi
 g3A19OQE34gUPEkJqvKxbbVUcLsJG9y42UxSi0n5b33LOI5q6wORVJuRwQtttoVYeo9k
 ua8NkBcO7n5zZ6hVdniBbgOCM6K3isxSpCcwLP2uPk/nKO2zKyVkSdLah1Ome2tzxtBG
 7bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907764; x=1743512564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPwtIJ7PyZH/NUhwd2km9X/kSSpo1y0r8LhrZ/SyOu8=;
 b=VC1fEqvA4A845eqNyAgA7CFuIdQhKVkOP/F0S9l3OeFe5xm4RQaGiLLjSu/AKB0Xzc
 4mkWI03y8O7Iwwpm9y4cgP2FCJDPTmrnxqSF/T0L7gvu3U3AGOsXchSY8nM8Ze7qt/n/
 OBMq9XwgVaMBK7Ncy8SgvWyZ3V5c+4fRx84WV+t8atAlZAtja2GCkGBTHLtoyI5YaAI0
 LEtggmFQGTdPsmIlpu65kVBGXgpCGT2C0sIcveFkaxfKF4x3DpizUEbIt35vqTo+XSA9
 YM4y0/JEOw9WS2a4EAgzxXTg4KJ7JdENfE3iWUnj8Dl49368qaSGUO4Mg6poElppVrzL
 BmUA==
X-Gm-Message-State: AOJu0YxMaIz+SFq3QIcExalo5sID5ZdGvhaxKh4+K5a11/o9cIqX0EOP
 vWc67suUM34yK/JjmBy8tbYgfnVswBnw/WHJbyd2hT648CC3eTGLG4fccIzm+IKLD6ZpWnI9Sjn
 S
X-Gm-Gg: ASbGncuizWnDeH79tNhHEJmfoo/SDABunbhTGyVpkT5jHonBhFyufi33O360MZMhsAX
 keKagK8JA5xBn+IKSGX9n7d2pIYqXfiEM6faLwqDi3KEWjx4LA224TqSEJiaPNtawAeJRiP3wwl
 7oI+QyVjzO1auodBACrg+o9oL/WtkMpZyukWbLw7bYwyiY8PbDFteJDfANE/Dk1Nknx/mizlNnq
 iOhK4aeWX0uhcZpAXUKhh1OBM/QFFKrqutI2eDYISttSS58fTJ4yBcyAHdAsLyDGtD+s/hE11HV
 l1pDq0+XCcaMrzMQij3cO+Z8JVQwzjcIKGj/FlIjUnvBp4b69wIDuQBOf4B02jGxxwwE5pLI3gx
 H3ob6lC8Ykg+aMJG9wKA=
X-Google-Smtp-Source: AGHT+IEMIP/8iOrSgXM1xj9+77tapHOdqrFUtarrlpEzgOJ6FvO7fKL0tpMBgH/nfRs1lb39dAiytQ==
X-Received: by 2002:a05:600c:83cf:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43d509ec3famr189652755e9.10.1742907763580; 
 Tue, 25 Mar 2025 06:02:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440eda26sm201420575e9.36.2025.03.25.06.02.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 4/5] user/tswap: Replace TARGET_LONG_SIZE ->
 TARGET_LONG_BITS
Date: Tue, 25 Mar 2025 14:02:19 +0100
Message-ID: <20250325130221.76116-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
References: <20250325130221.76116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Having in "exec/target_long.h" this definition:

  #define TARGET_LONG_SIZE (TARGET_LONG_BITS / 8)

It is safe to check TARGET_LONG_BITS == 32 instead
of the equivalent TARGET_LONG_SIZE == 4 expression.

This removes the last use of TARGET_LONG_SIZE outside
of "exec/target_long.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/user/tswap-target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/user/tswap-target.h b/include/user/tswap-target.h
index 4719330dbbc..1c66a5b9344 100644
--- a/include/user/tswap-target.h
+++ b/include/user/tswap-target.h
@@ -11,7 +11,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/tswap.h"
 
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 #define tswapl(s) tswap32(s)
 #define bswaptls(s) bswap32s(s)
 #else
-- 
2.47.1


