Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D28D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFZ-00043k-Ls; Fri, 19 Dec 2025 11:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFI-0003iw-PD
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFG-0006On-Lh
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so21549045e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161340; x=1766766140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khiScXO2o7JNwZuNHp3qGbNqQoHSXXrl/2UNC4oNo3Y=;
 b=e9R8N/LJPfCjS1qzOJRNlJZfsmM1IvQ0MZ4fWBL02vl1fhYaPPaBW3pRvKd/855eLv
 nKwHE1N+djpky2pVh7itWJ1E5GQv1DevUbXUbhI5Io0SGDv3w0YPjCTTA3zJ4EmBpjiv
 rJ2JQ85M4FJI8IzkEJLlPto+yeXZZBvMI6saKyGxspx91O5rRE62KUCpQU3bLI8dgRbQ
 BIjButU2NJHl9gnpD+n47MZ1Jx6NJzsQGkA+HsIL8Ln58D3xsHKzClhTCzghK0U0dUlZ
 RJPvKRX8aJcB11Yk5UhqPSFeMPkGFVJjxM+jw/+bCTozhtP+naY4IPypVjE8iOv18YPa
 Qyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161340; x=1766766140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khiScXO2o7JNwZuNHp3qGbNqQoHSXXrl/2UNC4oNo3Y=;
 b=kYNXF5X++4ppXIzyegdp7d24qeh05BupRZl/3HFUDc+DToGNlNfdnP0XNNKYNoJ4xD
 O1PKNbeocbwaiGZ/MXhGAMIEVFM/cf3WDFhMgsbrOwVB3XB71l1bjML87vkf4HRx/N9i
 qM69Pq9h9idgKxg2RorcIXLY6T/l+j+S5OmEQsnYKN7qQ1X7mjyOGVnV22r6MWPMAz3I
 qlRiCko1ENz3FEglcad4ZQ3bn1JSB/tL/iicRd5VixE+EYfoP6HdeaDBne/PUbjbaxeY
 4MYY6m3HWbFDspKO9W+amCMAI5oNaiI7c2HGiEmCAxGua9n+/5cB5wwW0b1cC40uQ82q
 g3ew==
X-Gm-Message-State: AOJu0YzsGavJrzewwjxTJHcErctb6jFTKTla7kXu760Ga8YeCHtEy9sS
 iGtkypy0sTDRbgUikz+u9EnquUxCkpr8rnRrI2VsSrWDY9jsCC94fgUCzDhOAYVUZn+J9iac4Qh
 WDFI0TWM=
X-Gm-Gg: AY/fxX6xZFh4TvWn752Me+eZwIocMfxiBICRHwyU7f/r9i+oWSptOwW1NMZ/owqKyri
 tX6DiU9O3IYIvh1ZUHDtXL8G6eR/zG8oUbsO7pdIjry4pVcbqRZkdzvXQvOFLjrucSi/nzo9bB+
 ZnLE+Q6bxI0U99XRJNmuSOzXdJPlD6VBZ5RvwV6HLr6fKj99twMt8nNUgrVsYT8byir0AWvCz8L
 Pg7j1IdzaFX4jnCebULq6335aSIxDfSFbBilOSatvCqF+/NGnXKn4yTI177iqt3paAxgTdRLpUp
 n9PQsX3JifBoxgyEz8L85ZnhGs7QBU2XCHFf07j0Ub7DsMoLOVSlhcC4ZkIPDGrhGflpQS8s1UQ
 yTM8K/tzjY+DosaekrBYjtqZsO2ulJWFwE8vcj4468L4MZlOSn5C3rp5K/l/+ZgT+D6f4SlGWaj
 5/a+tAWB8ZRyTZ0RsDtsyaQ9+Nx8/Zt4eid15isvqRdPL7Zja9+qnY5oWBKrYW1ZCbGW+Kzb8=
X-Google-Smtp-Source: AGHT+IHP4gP5GWXHINMPK9I9IqaJlx+u6uNcXxRwOYG417teMq+lGtm0kKMo7FlMjBAonvrwccAzJw==
X-Received: by 2002:a05:600c:8b12:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-47d1955ae38mr39840045e9.3.1766161340209; 
 Fri, 19 Dec 2025 08:22:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c637sm97193505e9.11.2025.12.19.08.22.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/24] system/memory: Restrict legacy cpu_ld/st()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:47 +0100
Message-ID: <20251219161953.72724-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..91b618c2f41 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0


