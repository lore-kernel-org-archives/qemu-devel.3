Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE2ECD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjQB-0007yh-Hf; Fri, 05 Apr 2024 09:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsjPv-0007vI-3U
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:15:53 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsjPt-0002vb-8n
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:15:38 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bf63af770so1245902a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712322935; x=1712927735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLZl1S54/NJ9uhO86NDCoHEEi7QSVMnYkwt0v60ii9E=;
 b=cQnRZuYEh40sq4+LcIkZrecqgIn+nP7974ZO7szzHSkEUHKhLM3sxzAB726LIDKRfu
 AIx+rSROL1XYB63NcAfntJy0G1iq3oYUMBZrHwtRUERKDHd0VR4HmGaia29C0F8ih3Tq
 6j8wRUN8EF3BCvyuVZMzCJYvr/quXCfDeoFNR8CuEKWH4NFABaIkVtTAwGqIbfRIkEbH
 CipUDgsLhi72gRp5Pf3iwTvwwGgbEUevEzL79roXYgQukYSKFiGWMh5Lfk3i4yOHWo7L
 OACDDMRxZ+xtSheOvXHYR77Es6Ymam0uKPVbB6rBfnZvE5B9o9EH/kWX0aXZaotgOgmc
 g5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712322935; x=1712927735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLZl1S54/NJ9uhO86NDCoHEEi7QSVMnYkwt0v60ii9E=;
 b=DodonAZaGzAJP4OLBccOLcSHPCUnCLve6z9JG87gm5K9vPU1QwxiE5YuCwl0xU4M+s
 0ksCMzoa1vXCBG6LAF/yj33gHIh+LYtvugb28eqnoEdJIcxzsHAF+xLsEn5q4IDEz1xO
 RtCnekaDn9p2hzFPACNC7esRfmItSEYTOJueF7/ufSdJdmWhZQSGEOUPHEqeGHl2vI3q
 lVUYhSIQzjpgeq9mM9Y5jqqlk/nf+M04o1vwJkwjigi/FOKVW1b4v+A+2wukj4LXxYZz
 ngaxJSV6lOLGARbytwjOjSc7MROlr3b2KO1YJi4T2SeBBDC7TscO3k3zlfTAf0VMyeuO
 ARFQ==
X-Gm-Message-State: AOJu0Yyis2HVEkm4VliPJPKR9674eo5fRijh+oEF4xh+kfjk93Ky1y9D
 FJ/imKp6L1ujLDmByLLlfMuv6NHaVLgo1FbV7z+cHcKb7QfmSE5AVQmqVWhaGJ/35r8xYwXhTIs
 U
X-Google-Smtp-Source: AGHT+IHHyCf1U7Z5LOUR/tTJpEIYfaO3nFn4CXMQaDoyQuxMMXSs0uqHe/S/AtGFNtGJL2C6fOrUBQ==
X-Received: by 2002:a50:d653:0:b0:56e:2d93:3f7f with SMTP id
 c19-20020a50d653000000b0056e2d933f7fmr1513747edj.39.1712322935075; 
 Fri, 05 Apr 2024 06:15:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 b9-20020aa7cd09000000b0056c0d96e099sm762718edw.89.2024.04.05.06.15.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Apr 2024 06:15:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 33/32] accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code
Date: Fri,  5 Apr 2024 15:15:32 +0200
Message-ID: <20240405131532.40913-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Previous commits replaced them by translator_ld* calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb8f3f0595..85ca104dc9 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -438,16 +438,6 @@ uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int8_t)cpu_ldub_code(env, addr);
-}
-
-static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_code(env, addr);
-}
-
 /**
  * tlb_vaddr_to_host:
  * @env: CPUArchState
-- 
2.41.0


