Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2251E776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQkJ-0007Dn-5v; Wed, 24 Dec 2025 10:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkH-00070o-4r
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkF-0005CG-EA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:48 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b8e5d1611so7292388a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589943; x=1767194743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQGh0l206MdToCjytCGMmdsOnEQoIAlyoUIlLQmPYxQ=;
 b=E9EoGnj7N2ly7x+UjZlDmOVccd5xSVpnGboCFBSWiVFkvzFeUI8PyJltBSaMoMWl32
 e/wh3OqYlf3EUUxSou11zJ2h5WJb7POyTkobTDeDRTRV4rr8gPreCCbji5wScHLcJe5R
 JbnOJkz8WMw1UKE7TzPfWr4HbboWd4K9n6W9Q0Lx5OV5VJpY40XbEEofw7N/CjsFXv1r
 qVZGpJsIDnpI9aVBVGM07GostGf3fLJ3DyQCjHkRsqO67i+2dtOD+CAguu8hZMdCrg1O
 fGutfI603UtT97F5cnxmqei0NdFf2s3gHfq1uhO2zUOm+V8UWVhImOR0wsEreK4GBOxX
 SlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589943; x=1767194743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQGh0l206MdToCjytCGMmdsOnEQoIAlyoUIlLQmPYxQ=;
 b=ARRKRI8S7KJiOKl4bdJEAjgCditDBB4GMRs0MgdLRhPBnpS5B9DZEHIrrlx7AQ202a
 BuVxXc+EOtuk9HgL8RsRC8w2fRC4TgvTqDQ05GrpT58k+uajfb2hOk0Js07icNZ7dShq
 6uW69x5p+Cnm86B5hufI6/UWP6TaclBOw2u9N2CXqfbO7pWvZAwofBHaxQ6aVcJzbLy0
 3LOkri2Ye2v+7ttX/8uodYWkrvpgMjOndWoHv1ATvJBu4eTspgjZSokUqWaonLpqu404
 bMkZX2DzlsPgZO84AeUQIOHR79Hdi7aN2AuNHagzIsJs3QVSCUHmwf6Vpe+Bp2ZWPt0m
 onBw==
X-Gm-Message-State: AOJu0YydgSs1J2WteJyy7K1Q8LFeNUJyui2rVRN4UQQyLc96WuP9y9s8
 DFtdWSjy//YmaAawMfURxliNH/6jKtO5AVLrBIrIWlX38JL+194OvglfJJvM9DtTkTePBfnFgkz
 7aP2I4Rg=
X-Gm-Gg: AY/fxX42MmB1WRw8qPeSe+QyaEwPS2ZEowBY0O40M6X7Bi4kzF997zYyEzPcX0hzXSJ
 jpPgLH+wjJ7xMSE7gzQF7+Zyojds+KV13/mPabIIJVs8QYnh+X7T3tPdFotVZC0/FAs1RjL/VHU
 HkAodSberUP8ooRKlK88EFybDHs3yR8KQvGfD4sfY26YtZyZmn5YBWrtW0qxiVRibwDZucuHSC1
 88B5MD8Apkx2Jly1eKZVUHwXtKROpxMoSHKiz2WyluEimWLzuKPfODWCPPFnQnzXvX7Fu9+pB5c
 glYbYmCdq7jUO9a4pr/HMux4PPZpHYPsl1962+jNbo+T4QaMsEQc494gEVmCFWpD/2hKAUjeiby
 cR19O16jV1JmVzKUoJwmv5RRqrEzg9mCwp4TYoN88WUU8eL5z+hE0DyTuYX9vCpH2VoPDleXFG8
 5oSQhb15Da2kD8D8WZv1VtbPHuxqTUl2yvqfUaNZarq7LywiDL5wrMmoU=
X-Google-Smtp-Source: AGHT+IHmC4PIhEocvAh29+V51V8ZadpUapvjzKheUN9zYAad4COpDKYPq8P0Q2HxSt24xF4yadrmUA==
X-Received: by 2002:a17:907:c1b:b0:b6d:67b0:ca0b with SMTP id
 a640c23a62f3a-b803725c920mr1896452666b.61.1766589943409; 
 Wed, 24 Dec 2025 07:25:43 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de1421sm1821135066b.41.2025.12.24.07.25.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:25:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 22/25] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
Date: Wed, 24 Dec 2025 16:22:05 +0100
Message-ID: <20251224152210.87880-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Guard the native endian definition we want to remove by surrounding
it with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the target
config, then the target won't be able to use the legacy API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 ++
 system/memory-internal.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e0be4ee2b8f..f4961a20911 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -39,7 +39,9 @@ void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
 enum device_endian {
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     DEVICE_NATIVE_ENDIAN,
+#endif
     DEVICE_BIG_ENDIAN,
     DEVICE_LITTLE_ENDIAN,
 };
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..5f0524756eb 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
+#endif
     return end == DEVICE_BIG_ENDIAN;
 }
 
-- 
2.52.0


