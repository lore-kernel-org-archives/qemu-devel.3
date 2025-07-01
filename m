Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3E1C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHF-0001Rf-RE; Tue, 01 Jul 2025 10:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGJ-0007wS-AE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGG-0007YJ-37
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so33964365e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381220; x=1751986020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hhl07c07Yt1bcZ4pWFGg1y3bhGgJSn5MEgtp83jeqQ=;
 b=lyRmHytQNi5Bf2rs9cUiwFLb3XSH8YH6OFkGYZ8npmDkjv/e2/Fmywwu0WCEGdxSQa
 m9u3uTs/DLlJuE0uzelfLg/0z0kTjaWLlGsIacd9LP4CJYW/10AhPs6xqUUyMgz1CxRO
 cqpwLzy8MIgaQzuMalQFgSBR1NYMumFoQCpRTbyJ29dY4C1rHOEMjWrLMSicWz+fsdfi
 QKDK2qmPejPENLBTrzhVtGU0IDvd0tEm+weV6MO7QfYhU8/r4t4zZk9okR1kfhb97LA6
 czRvJ9hLdSw9KEHAL3Xobm56ubYE1Uh/N3g2n5li/L/GHt+WgpIsR7jvJoQYCakObu8K
 M1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381220; x=1751986020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hhl07c07Yt1bcZ4pWFGg1y3bhGgJSn5MEgtp83jeqQ=;
 b=uE115uwgkTB2ZBHPzhqHpDfnmuzyuNtFjz39RfeaHicxgGcAQ3C1plpY9j0Arbc5xC
 sMvmw8FWgV4V8oTRca4wgdc/gxUa6G3eKvVzcBEVmZM0p4E05Pvxo/xMznWJZCWbcvWZ
 OCj0wTXIAv6fr9jhnIWxgMp1s3/si6iJ3cMr4FBjMgWsiq5AKoAcZ9oX88vHQLc9QFXU
 sztPnpjBzuGxhwXEOTyDTU5zE2cETflnAHnuFmXkqWHX1vjtiKFltTyg4hFp5Rx0d7VF
 UYjIUY3ib2oYzpHMmT0QVlb9oYwN41Ob48r+UVh0/rmkDowGyfyY+4IQpvNAuDEnEFsI
 gdRg==
X-Gm-Message-State: AOJu0YwjEpYoaI+C0zjdbmjuakBRQo8IMvhFsv3XEWqu85ZfJjevXWta
 qV6dfJ1yMwfKOyGzTo+NIK64s8rljgGE88n2XiPa4HGGWPP75zJdqrBhj/73mp6OuNjXm9/3Hft
 Bj8sC
X-Gm-Gg: ASbGncu+xvXYHzxMcymD77NIrkdoJ1ZymJksRBb+UD0yS6xCz9bGiYlJvszlmdNhvMv
 dgh+yfOS+fBaK2GDBcsZ9tOwB/1MUWOzvKK9BiIxQOes462eBzB2gKl97qj5FMV5OM/TP7EgjuG
 1uedAARXw/HBuwKN16yVftEP4Exj97BfRJZLdccPIJ7jfk7x4K0cD0hHo6+yAVsfdAPrwfKGqD9
 f2Y7/jg09UlEpfOSWK7ZdEFlTNCyho0cEBnFlYj5HZWOm7/56sIOQ+FyMnLbKta0+PZs9bwHRgs
 rnvQF/2uDcP0WzWWHmxINDLOygJUJHzUIjc6KxNi4ZVeTO0X19cbeTsFCv8ThoD1LEsjOC2+Trx
 FtXD/2EINs9aYjNln6AGrL1uUQPTYLqEMw4qzyOhP7jWVh98=
X-Google-Smtp-Source: AGHT+IF/XHm+eQVFhfWlnEuKj+A771wed5Z2AiWXa9QWZz55KdZWok3A3Kpc/lRRnJMjK4pvXRnEhg==
X-Received: by 2002:a05:600c:6085:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4538ee58e29mr156297785e9.11.1751381219845; 
 Tue, 01 Jul 2025 07:46:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fb67dsm13749177f8f.35.2025.07.01.07.46.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 61/68] accel/tcg: Clear exit_request once in tcg_cpu_exec()
Date: Tue,  1 Jul 2025 16:40:09 +0200
Message-ID: <20250701144017.43487-62-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/tcg-accel-ops.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 8a0295e2410..2fb6ced2572 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -130,7 +130,6 @@ void *mttcg_cpu_thread_routine(void *arg)
             }
         }
 
-        qatomic_set_mb(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 83fb2d1362c..9b5caf9c4f5 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -95,6 +95,9 @@ int tcg_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+
+    qatomic_set_mb(&cpu->exit_request, 0);
+
     return ret;
 }
 
-- 
2.49.0


