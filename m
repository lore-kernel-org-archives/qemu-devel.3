Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2705CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuT-00075y-KG; Thu, 02 Oct 2025 04:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuR-00074W-3W
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eu4-0000wr-As
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so3167485e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394578; x=1759999378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W71XKN8BDb9kJ6RH2tt1PLzXlP9jppatkbhtyR1OYg0=;
 b=IvwaN+j9Er8Aoty65ZBsoKCJSd5UmkjV99A2SjMY9uQnZXKgxbistoneA71oXSu+CR
 g/AYCa6Yzzg5FRE6GSuoNtbOe6kk9GHsHgrrwFagcuYxgc24VPTcvefSFIpojVACJ/rg
 z4YRujHq5qctlZpJeECLuGcMtQViDJurnchWjn9RQntpMM6AM8xrzqZunxg3uOexbkqf
 cMl1VryE/w8X82ix3TE0FY05+WJmTvklJ8fNyAxSeaQdFvDFWgl31T65BKS7TgQ8z1Zo
 4Qwo9RPWXeIrc8QsRNb9PEyr+uXwkXaNNtbyL122pUmvbnr9f5n1S66E0/qOdt0jqk/M
 4hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394578; x=1759999378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W71XKN8BDb9kJ6RH2tt1PLzXlP9jppatkbhtyR1OYg0=;
 b=OVIaJI2MyxnkBjki0xSIY2X7tYNAarcZGcKHWy6urNtbQZchevgd71Zp6X0e+8Twrc
 TTjH85arUpO7BmlOzDgXy5c4PZGdlwhk7X4yDp8wJIXbK+34ZSwytCm8S7ohZiSOYJhi
 KcrNLGgXHWILo2Z6VxX1HItWCNo9o9TrF4MtTfgqTtz4j6HrTbJKJ+7Xo9EKdIynkZGj
 +PDA3J2rXuNAvPD/xArBlbyBciKMPfZ/jVrdyyuAgr0phVnQbyl1o6rNLk4MN1ahmGjl
 3v3vc/qlwpMq+hysqIgJaQnrVK/qa/VQf7IJSbOw45+bOGSW7yX46kGEwJatCZwVM3xB
 62pQ==
X-Gm-Message-State: AOJu0YzN4KKI7h0hAZNVj2EkMUFqC8Xoh21qVN8GnWV1sqS0A1dgYlm+
 wRupUaU2GwsItH3S20sExIxpl4fSh2YGkb9o0O0HmOWIotz9Y9DkqzYEGOfF96T/SeawuJAUrVJ
 R3kIF8fQi4w==
X-Gm-Gg: ASbGncvf2k7l8QMVQTAmSqBiu6EiCdEVM8Qi0SOVpM4gTibIhViPDMBJgSqCbjQkgOd
 1VID3r/wOYi3dPXQmUeAQc+chpGMeAs/ai2EUiOZkPiPh97jlPpkgbb/asEr38xiVf/pB6IcHck
 3XyypA7LifPwfALLOPYqXuncz8NdeMWWbV+c1KgUTLLWYyM725QNx7Dr9JLzO0cMV0tD5479Gcy
 H8K6vszu5wlUHeEmwxo4BjgmlalxhUotceEn7QJkZ531Hrw1PiK5TExOXa8fUXz8JafT4VdZu6Z
 L435exFGD2lIHA1YfuuwR1mMyBSTGIdQUawQP3VwTQCEyFGENgEbOpvdr1DeuYofXosndJhGtf4
 ig+Df2wY21YGpghi3Ktpm4LWvrjqaMTQHApwxsGJz3oJOlpgHtoAHmucUf2QndrT9iq5rA3b+xv
 hRjj4cAD9leRrEvliP5LjnxPVH+pFfxQ==
X-Google-Smtp-Source: AGHT+IF+vQnTZyjnghBewujCyKQZ3vteqHFK+eM/Ja5h6DC+kmKBchs84xyaNt6pAje4wwu2ECUb3w==
X-Received: by 2002:a05:600c:37c4:b0:46e:3d41:5fed with SMTP id
 5b1f17b1804b1-46e6127cf3cmr49323625e9.11.1759394577925; 
 Thu, 02 Oct 2025 01:42:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a029a0sm71252835e9.13.2025.10.02.01.42.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v4 11/17] target/i386/nvmm: Inline cpu_physical_memory_rw() in
 nvmm_mem_callback
Date: Thu,  2 Oct 2025 10:41:56 +0200
Message-ID: <20251002084203.63899-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/i386/nvmm/nvmm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index ed424251673..2e442baf4b7 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -15,6 +15,7 @@
 #include "accel/accel-ops.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
@@ -516,7 +517,9 @@ nvmm_io_callback(struct nvmm_io *io)
 static void
 nvmm_mem_callback(struct nvmm_mem *mem)
 {
-    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+    /* TODO: Get CPUState via mem->vcpu? */
+    address_space_rw(&address_space_memory, mem->gpa, MEMTXATTRS_UNSPECIFIED,
+                     mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
     current_cpu->vcpu_dirty = false;
-- 
2.51.0


