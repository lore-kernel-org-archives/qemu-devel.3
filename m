Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4898D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFp-0005f2-O7; Fri, 19 Dec 2025 11:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFj-0005Ug-Sm
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFi-0006UP-GK
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so21555475e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161369; x=1766766169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP3KYcHy9nGJ+Swo6FkNiFvQDfCIc+8Wts9KydhYuNA=;
 b=BTcrXE7IKZMoi4RNIEHQqOllP9sZJoVtaXK1R2A3hRxdKLOIRo77DzstnYplTg52I8
 ZDhOarQHX7PNhfDP/s0oBFAXL/YBneIYQKahEWq3r2lZTWTag8Bo7muLOerGoLhmclO+
 5ejzZjUWb5tliYn8Wuxw0nTKjdTNaMLlI7shBrkVizB9rTuXPOrAeXllCTt9cZiU7aFN
 LnRHUI8lbBkUWJmPfQKy2nD1ylZsgJPAz6QuuqZSig+Op2XIG4v3MdwCCu3fNhGpY9NV
 wko8HKtERsZw9/6KjGbJKqsBvSIoaEI+SDyo71Y+tKcDV6Hd8woWk4lBMp0sVPLIeZal
 F1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161369; x=1766766169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hP3KYcHy9nGJ+Swo6FkNiFvQDfCIc+8Wts9KydhYuNA=;
 b=M6PRXDU+xHroC5mzs3mYkWwx0M3uRkUDf9S6aGCRvY9x3+LTMeV75k8KTtLmLgNjhd
 7KQfxoYLQ4eC1NeSjy3I82r9gcJL0IrwVwQP5Va1abJnslHNel07hPKq7yiVuQlASOzH
 VAxCKgZaso0QWQxpuHKcC3XTB6Qu2DwaDo5c4f633cX5uTpV+gvRZ4vExkrFjJV+gpLj
 DlmXp0lnD+bl/3Ytf4sMqLKJQDCWDh7qiO7tGPp7dUHhVUhtQuwtfcbqcQSLXGHwtW38
 iqpHQ3XpW+V4Rqnk0cvyzpwMdjA6X8+R5s9Sv7vVCaqGcaDto2DTHVyJBDeGA2wsHMey
 Ou2A==
X-Gm-Message-State: AOJu0YzhlVqTHK4iiLdsHMRtC6d+OXmd/OAAAqCGzTyyWXVRjQWo6nCZ
 OU7lGc4Cw9ZaS3Fu2spIVEjqKY9Gj6mDLis9waY8F6T0p3IWNlXI/cPcvEwOalhCnNs92rvW4Dr
 CZaII0JQ=
X-Gm-Gg: AY/fxX7T1yC7yedPNViPTKuK+U0JAdBwcg0sN+zPPpAnek2IeDk2VPAEMtA+UXwDpJX
 u/9jVsKcKzDJ1GxKYkFJlkfN2NN4zNpO2rehqFwB2FyQKXFZxi2yBQt9lhrOdtNKLzRnvyO0NrJ
 B9Eks/H9OzenpgkO0cYbl9dQEQcLjkazu92lHou0Sa8EVXgNBoD7IxkcUFxKrcZYdZw0seMA3Yu
 Z7iOY54lrU2tu1UqEYVKoKtM+bMhqcJ3vsHy0QKSefmusVdBrwwoj1DGNzNGtHomnDLuvMXgU7V
 Le1cGR1MuMjXO0TmNFy4/Sk12G1u0L3610MyCMSP1k4TLoHGJM5JcESi6OJC6JyE/6qHVMA+yS5
 E5MsT1PEYX8TbRyCiJMrgD2WMwlgN8Gqm4aUxM8nQ7EX0ZZzgYloSJuBLcJSLgiKqdBHLBf7ukk
 PLCpbfCCBLvvqZZi/aEtazf2XDglg4Bj+ceLxcjMtzRZw/nz/afIXa3yOABHNv
X-Google-Smtp-Source: AGHT+IEsDY5GSpN/zj5C28b7mr/pRFn+cB0p9rKKhMBQVv5bpQ0dM5nmKG5V0lU1c+384zO9Id/H7g==
X-Received: by 2002:a05:600c:4fd4:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-47d1955b744mr31676515e9.6.1766161368699; 
 Fri, 19 Dec 2025 08:22:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa9971sm37161985e9.13.2025.12.19.08.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/24] system/memory: Restrict legacy DEVICE_NATIVE_ENDIAN
 definition
Date: Fri, 19 Dec 2025 17:19:51 +0100
Message-ID: <20251219161953.72724-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the target
config, then the target won't be able to use the legacy API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 ++
 system/memory-internal.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e0be4ee2b8f..104d2619473 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -39,7 +39,9 @@ void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
 enum device_endian {
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
     DEVICE_NATIVE_ENDIAN,
+#endif
     DEVICE_BIG_ENDIAN,
     DEVICE_LITTLE_ENDIAN,
 };
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..d781d437642 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
+#endif
     return end == DEVICE_BIG_ENDIAN;
 }
 
-- 
2.52.0


