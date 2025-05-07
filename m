Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A965C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4i-00067y-Dg; Wed, 07 May 2025 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4h-00067e-Hm
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4f-0006BX-OB
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso472311b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652384; x=1747257184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv6bQ+ZJWmSMXwr8xK5cNNZTpCyKVZTObTM1JOhX7j4=;
 b=pJcIArtrLeft+eWhFmCDG1RXoi2U8BGDGui8OmLvTfC7L2Kb86Y9MnZHuHR8ZPDUMv
 gN3LHlJjYPvYh0KeYJZZ2oQDYCWS6SLfM4t8ul+lVuXwWxAjexSPRmIyiwlwgh/fXc0t
 C1BvWvDDBsDrV7rkA5emYinNF8KontLE4HPqOH5n41ZAw584OGehiEQnbMJXd1FLNciK
 0IFcizYjRnFBP2mac091+7hyux+bNbPKyN6bFi0LZtAqu1gLCmudO9LD9T3/z5cIhOaq
 To2/2Ld45I0m83SNyE62HF2OOY0JDIItC/Gjzny+V0EcoSp/bfRPMStkxQXnWWqRi/+1
 nJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652384; x=1747257184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv6bQ+ZJWmSMXwr8xK5cNNZTpCyKVZTObTM1JOhX7j4=;
 b=bCKWcBb7V4erz7sDlWWnnGozINRB+bvto+IWBkj4hK2giWOoAtBpWAHDvSzM7U1LfN
 bMzhmL+1Ogg/KkBVO4+Vp5+aKrSbYw9pWRscgYqv3mUI9GIW50cBFFSi4OPToD2i2UyA
 llah3Ve7loZ8KcQwkYqkw8PMo3xtpZbHhPalfzkhuHyq3VegN60n3gYljYRIWCoXCB20
 MIvndUZIPDrubOA/jI6eRQI/5KVaUD+qBJmO+cy/ZY3DllQ3XiR4xiCREEbbCaeINSzv
 HxbqeMFBZOQHEAayQr0Qy+qwd1U/AZs3ZoZhEwHXCqhuf8mWrh7W++OAsEdwyjz94Gm+
 BRnQ==
X-Gm-Message-State: AOJu0Yxph4wKgxG0yjdBIFb8bIjcbF3R9wNmdvvnHZ48+JVBZTzO5PAX
 7DpMDImKQvryyEH30R77OofJhbK/n/K6+kqt4LBojrRZA9Kme/85MjP/p7wKIn0hTYBuO6ty/nP
 n
X-Gm-Gg: ASbGncuBdkMixSELbfFMbCr3mBp2zr4bKk06iOf2lBOFVkCE/5Gexn4iy4fxu7rM1oo
 ywxukvl2ATg+wHI3cUFJGwe3yAA0BQ5CppJxf3PMBWBTl87ur8brK7le+saNn7aykajbtKu2DRt
 mEj9eQKtho1XYDOwj74mHbC6enGrN+hlS0ima6Dd9Py0aCIr994uh7CsIQM5elaqt5IwQpEOFRN
 7vpnhXWUemj6j7pr6qhzC2GMLl3cSbdoJLFpQoTUcYjfgsxIn93YmqdqzmQlfuPD6NXjyx3kiwP
 zLlNkUPu09dlKwfOeXhjQmPDZVHSnhElj8zW5BUwDZ3rvz6k30auFkQUv9nVj+K1DKWO+JiUtlg
 5itigPILV+w==
X-Google-Smtp-Source: AGHT+IE8Z3dkJhVmIJ2j4whyXnCX8vZ84qVW3ze2AA5EI/77S8JxedH74QXwnSqfyjk/n2Pi+6FFKQ==
X-Received: by 2002:a05:6a21:918c:b0:1f8:d245:616d with SMTP id
 adf61e73a8af0-2148c220ad1mr6782455637.21.1746652383785; 
 Wed, 07 May 2025 14:13:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/24] target/m68k: Restore fp rounding mode on vm load
Date: Wed,  7 May 2025 14:12:37 -0700
Message-ID: <20250507211300.9735-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Call cpu_m68k_set_fpcr to make sure softfloat internals
are up-to-date with the restored FPCR.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c5196a612e..724138b302 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -480,6 +480,7 @@ static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
+    cpu_m68k_set_fpcr(&s->env, s->env.fpcr);
     cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
-- 
2.43.0


