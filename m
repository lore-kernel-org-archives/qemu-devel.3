Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8358DC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fy-0004Nz-Ac; Wed, 02 Apr 2025 17:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fw-0004Nj-Qi
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fv-0006AE-9A
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso219539f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627853; x=1744232653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6G8nkP/cj37F83zzzMjf/rpSx1orcBnc0ruMc3Uaes4=;
 b=TGdzk71FWa6NbN6DNEDihN0t+vxIICpQB+vAMqiC22s5yiEI3QXeivcHVcLzNRhdjc
 8+REPbwcR1+k+B2YewIyqaH7L7Gtn4vkaw+AbOxw9CNyN5OKyovhNy81QGLoJqvyz1ea
 nQXZ7Uz0P/W7QBTRnPA52gJZ2lBRE3iH0bt5tf475Wsr+v3pXdomKth4c6anZb91ODyv
 uXLQMRakg/oLZVm1ORKB5yxTb+T2mNfCjfBMclcFyi+FEaxsKjj+x4Gw/dGUrJjNt4sh
 1PVRqXhZvrI6oGSl5i0ncXZdaA4F7hYggM8ucH4rejCuL7vXDdfeIh9F765h1ALURpOS
 Sirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627853; x=1744232653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6G8nkP/cj37F83zzzMjf/rpSx1orcBnc0ruMc3Uaes4=;
 b=ca2FvkbSEA6Dih+ctSLjcy5EwAcrvgmxAAo6s2od3XDyMCd4yWiLLU683X6tramSUR
 BtZtqyHUJTIbmAtmHoAyYEtnvR+4GnS4rw7H7k8xygrs8Tmn8hOp87isH4vfOpReJhM+
 I5OjvR2tAiDvHCGh4rDqCUh9xWtve+lpEtlow23h0bpUXv97cNEuuc92dbXOaPTErgsZ
 K2zf/bX1y2IFlBLiICLYu8sWxyRR7Z+oLCzXIZ0gWHTcedRsttnAf+XSdfkGrIWJQI7b
 Ec6heENPSdKZNBov+xrKGIhPdqUaz8cGZb++eOWjgqs9diV6CXqj3VZPvdGGfFTXVm8y
 EdkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnVt0L2jmOCNXnUYbK/uYr2Akhkpz/vDdUgXHMOWIAptGqsEHUfDjPoC0aMMopCBVN7SdKA8Q/j1ax@nongnu.org
X-Gm-Message-State: AOJu0YzDhh8Ormee+ZMWNtXubyT1VyzACK/wbm9q1oG5ItJPqidSfNwC
 Fm+GjYH+5UDMxqT6bTwIkGgmUpQdRRHznfWvI3W8QSQ/Anbw7tfzqofvZQAGcsOsOYy9OurC76D
 Y
X-Gm-Gg: ASbGncsKiZ1xRtYICg2H4qUdbrgEyfm/NwFyx5h+eVMjiZsmgKIoV8F+qWK6jSu9oyA
 NfaXtzXIG4zn/vC95Uejx8N0Xs0vxPlxdwUkNcshnEaXlOyYiFPEOqXE05oQunRNze++StP/YKH
 OWjvG/RxZFkSN7XbRmgT84v/s11TUBGv/9dbGPINqatC/cWNxVCU7aIdzPPf0CAx4xbj608EaAd
 xlrO2sPdurYtEGzB7oKyeu1/h/QBbswZZoh47J+k6H1zIFWJTlsyGxqU9EbCQZQnEqyrCHMXyoD
 qBsQghDOMnWZP6CWS7HQbT6syhpP/hl4Suh2mzBPE9MSQf7FMZ4yPS6ys6s6+3jTaPBBtjUYAZw
 +G5VMqjKfHxN5NNxFVFc=
X-Google-Smtp-Source: AGHT+IFJcA3bODTaJGqf+AMBDGKf7Cty+F2KLGrUAWSqM4Avd/WpX9ZMW6CxIOlfMfA33fiz09HvAg==
X-Received: by 2002:a5d:47a7:0:b0:391:487f:280b with SMTP id
 ffacd0b85a97d-39c120cb53amr16472274f8f.10.1743627852735; 
 Wed, 02 Apr 2025 14:04:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea978378esm38415305e9.1.2025.04.02.14.04.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 09/43] target/i386: Remove unused cpu_(ldub,
 stb)_kernel macros
Date: Wed,  2 Apr 2025 23:02:54 +0200
Message-ID: <20250402210328.52897-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/seg_helper.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index ebf10352778..6b8606cd6d8 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -35,8 +35,6 @@
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
  */
-#define cpu_ldub_kernel_ra(e, p, r) \
-    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_lduw_kernel_ra(e, p, r) \
     cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldl_kernel_ra(e, p, r) \
@@ -44,8 +42,6 @@
 #define cpu_ldq_kernel_ra(e, p, r) \
     cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
-#define cpu_stb_kernel_ra(e, p, v, r) \
-    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stw_kernel_ra(e, p, v, r) \
     cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stl_kernel_ra(e, p, v, r) \
@@ -53,12 +49,10 @@
 #define cpu_stq_kernel_ra(e, p, v, r) \
     cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
-#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
 #define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
 #define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
 #define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
 
-#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
 #define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
 #define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
 #define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
-- 
2.47.1


