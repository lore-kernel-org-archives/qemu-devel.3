Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF4CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOEl-0000ii-UJ; Sat, 30 Aug 2025 12:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERW-0007X9-Na
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:03 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERV-000526-5o
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:02 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b482fd89b0eso2396446a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532878; x=1757137678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52VfTzYDSgjyTkCxi2KMOJnfbsQ5A6/k4xx3za3L80c=;
 b=tjNQZVlCyQGg8QTCkYcy0sFfMPV9VQx6uW2F2cdtzrHudhAzYJ0KxHUxkhd0zJY+vd
 gXmsvdEHh9aiOJy6nBI+jVWgdq8GNtogPWl8YeQBmD53s2n7iRSFfZVz65ifh9F/qvG3
 tWXAz1PeA0+V2+WVXzc/bx/M0c8CkTTDYHcuVmnV7hM71Ph2Sc8sse823Wkr9HLwm7o+
 d7wjtD3k8O+sv/jY9dvlPqBl50PMevkEi2uOesWeY8olJ4HxZw0QUZ5paHoETwvjSrM0
 yaD9/6upDVDnOdbuSUUH6EPk9AuyNG2B9vpoGTRLXm5xb8hJvrHbYMutaKQUARNNnBZF
 QIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532878; x=1757137678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52VfTzYDSgjyTkCxi2KMOJnfbsQ5A6/k4xx3za3L80c=;
 b=Tp1oSOiJcMnIEQ1b3SpOJ6Qk1hJb3jjkBtGMVVyovOFbc5cV5QTozCgwXcEBehvmqi
 WWbnTERsLSQ+KsOjXco0pvFmTKnQfPV9dW/oGhYHqIlRT00SGAlcFzpr2Rx7kq55XN46
 zjEfx8q0j3p7K7k+kaeBp1x7mPgZp5V08jE5GVdUjW4jkZoDAKvt94n15lO4BTV6hGJd
 hDpfDqJ4qdcIGp7gmtqQrV22LP/THwXMfWgioQ/YlanYKWct/gj18P2Eogod5vuKZ1EG
 BeHUw3cKSsQfgtKoU9IljyPrpi5mrE2UmoRvL3sK1RdUDepKFQhkr1u1rwhVV9jEbWkR
 IDgg==
X-Gm-Message-State: AOJu0YwknlWwr4grY8RHj8vuagPtBUzRsA8JpwEx8ehuJG4za2YjXFn1
 lmtCGNudap4mA6XXjOikpmw/u0Kmn28zNHDuXAE/g1raLrBP4BpshuntlO9qEGMefs6mvijKWT1
 rBRWqKko=
X-Gm-Gg: ASbGncuqD42CdDYD1wAjiYV9JTKmoS40k4DMNCjXYg40GS8t/TvstWKgskzGDVb0zsY
 zJovMxzEFrvvJa2rIMhruppSQ4yTJ9wSJ2KETaLtBuVTuF4FncRG4fD1bcbBwB1m/NpI6eZ3I7E
 aMHoLlvz1+2GUIqgB7tpfkSdSL55hJqUdjEQjpU8ToyBdy0fGInPJtP5cxdekdqFNXO/gJiafD8
 dCHKy4yUL9riybkKFgJHRTWsaYMyGWBt90IXYPEBs4RBK/G1prnPTLUBkuKDMIdJDSHUU9c/is9
 8kSzUEe77Z2rGFS+fE8DherT5GN+Vhqj5AR0jHI8JVMvUC/pyqfwNJkgFSme50uEYUD6628kmIo
 lTtc16rLwFYzNNkbCxdL2iDngWzK9H7epPDR83IWDoPMFxbF9aLzxsq4K/Luotn3ctyu4GLJomw
 ==
X-Google-Smtp-Source: AGHT+IEqJCtImH2Oz22eyTM4pkOhpINTH+uBWpwKAXITS6N4dUZazzhGQABM2eNAavdWhfck3ZKzUQ==
X-Received: by 2002:a17:902:cf4a:b0:246:644f:5b81 with SMTP id
 d9443c01a7336-24944a9bab4mr12851355ad.32.1756532878248; 
 Fri, 29 Aug 2025 22:47:58 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 72/84] target/arm: Implement EXLOCK check during exception
 return
Date: Sat, 30 Aug 2025 15:41:16 +1000
Message-ID: <20250830054128.448363-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index f61adf1f80..7ab7ddf7c4 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -694,6 +694,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * If GetCurrentEXLOCKEN, the exception return path must use GCSPOPCX,
+     * which will set PSTATE.EXLOCK.  We need not explicitly check FEAT_GCS,
+     * because GCSCR_ELx cannot be set without it.
+     */
+    if (new_el == cur_el &&
+        (env->cp15.gcscr_el[cur_el] & GCSCR_EXLOCKEN) &&
+        !(env->pstate & PSTATE_EXLOCK)) {
+        goto illegal_return;
+    }
+
     bql_lock();
     arm_call_pre_el_change_hook(cpu);
     bql_unlock();
-- 
2.43.0


