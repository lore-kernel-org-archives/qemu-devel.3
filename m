Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B450C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMhF-0005xL-6n; Thu, 18 Jul 2024 04:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMhC-0005Xt-Ve
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:41:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMhB-0005Rc-7h
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:41:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-367975543a8so336315f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292059; x=1721896859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfZ0l+YnojhbfUi6GMDiZJfhxTY9uxe9srgMx+ZIAtg=;
 b=ULf/oNrrE8Kaar9YiD3XDHg7duzTdVEtNs8w0TCA/MIBElyxVFglglNan7lR3YHzxl
 7AKjQ18/D/9XWuNWBRsyXJTNb5avFGUQhwp0Oqs+MFZW7tE+BT3sdaSf6qIfPJbHRPMv
 8ce4dOcwihjPtK+b0pT6t+tPTRbvJGyZVCw99BZ9r2JHbZy0e+3RqQlOA9dQILbzJZ4Q
 4MNHmdCpXszMzviYEt3uSQc1+tFruuQPKdhuQi8Tf8Ksb373hnGJJHhwqfP0UUgWqHfB
 HNqscZoWMs+RRt3wGpyTjvDoc52XfTnXQMYOe024/hDVZoX4VEZfbpN153CCtAjir5Vi
 hLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292059; x=1721896859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfZ0l+YnojhbfUi6GMDiZJfhxTY9uxe9srgMx+ZIAtg=;
 b=K4ZqfNiL3JzuqLNIySb2dxGyKj3A+4/OCyRE+LxtO2DZ/is8fumNGWGVDoLBoEeljP
 ps7nbjCHbkuXmbMG+A2a3iE0LWGo8jU/O6kEYKnRHhTr78MvUzKeqLXwgVyv/bD48GLI
 lsjXoGVtYZpALxPJYHwQMiRiescjG5AYxfBR5gfR261v6G25suIwtwZyIsA3m7qgzKnw
 AIU6kkMg8m/R/2T8pte8945Qf1wgK+yq2bMrBi0zTLcjTINxs9I69MFWTvKHCtmBN4Od
 smamnbgPnDyOKrYr2UovYPGVx0dYit3Me5kfejWIIWCTbTf5p4rbbeo5l8qwh2fEA96M
 C0KQ==
X-Gm-Message-State: AOJu0YwQ4YCtcQVQIpBBZ0ql9wMZfRbSFGTnjekoLLI0uXe1D8aC6gsR
 O3ctqC/UVIeHsPCE9Oi3fFSN4/1pyjw5jHIwAQ/QTsyfVxNy2Y3oX1jM/NzS3O+UKSDwt1VVE2Z
 RAz8=
X-Google-Smtp-Source: AGHT+IH3x4GgHfsfMtkeAT+js4l8T8brr2d7uqe9eW7hF6XPulJqVzAUF9ILLGVSqarNFpulxDw+JQ==
X-Received: by 2002:a5d:58f9:0:b0:367:975c:e551 with SMTP id
 ffacd0b85a97d-3683166fa46mr3018569f8f.33.1721292059094; 
 Thu, 18 Jul 2024 01:40:59 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db03bc4sm13589759f8f.93.2024.07.18.01.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 18/18] hw/intc/loongson_ipi: Remove unused headers
Date: Thu, 18 Jul 2024 10:38:42 +0200
Message-ID: <20240718083842.81199-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 051e910586..aa1b0a474c 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -6,18 +6,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "target/mips/cpu.h"
-#include "trace.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-- 
2.41.0


