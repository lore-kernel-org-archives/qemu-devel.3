Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C85C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOj-00077Q-7U; Tue, 06 May 2025 10:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOe-00072e-I9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOa-00014Q-JF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so53696905e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542142; x=1747146942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8whTK9mWErr7ANpJPp1P1U5gX0rqPe4cG4hWSQUV/w=;
 b=CvK9hB1dQduNIhg1wSyPW0tO4MQ3wkkXGNedKtyFodY7S8nsB4w6E5oB3Yl6WokxpG
 USIPnQYgMsDhTQ+M8flfQtYneFdi6+7ccBm5npgs9Z7SUEfKUNNQ+4hnJzgTTlo1QE4i
 TFOZIH0panjiFhPrNKKSRT/dbU1kYWGnji8M35HBSLFXNBPvi30WjCsiFofhkex+Rela
 Y8ZxQWtbMbTtANF4o30cYvHuVBmZSVJk5u06SCLP2smOYk11g7UPSmAdG0fsTgchr4W+
 /tvOv1YxdKYQD7Zec/6Tob+OKGqQjbViFXUsV4P+l/h27AISlNNfYgCAkGASlK2ttdyq
 pMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542142; x=1747146942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8whTK9mWErr7ANpJPp1P1U5gX0rqPe4cG4hWSQUV/w=;
 b=gi37k9QWNtAqD6ujYYVpyCqm+3Ni8cCZzO0vFN4RfvQCvhHH/WGLsQoGHlysH3xlcx
 zz1WiIpzKv4nIP65BBrpBQkk4PrUiFEC83BPjREW9M4RoMgk98tgNKzM5Z4fLqSr94du
 hcIpOseHrwkkDEnySg6NHwyYkTcA+d2vDxB++SE+6bVYiT28UO13tcvTu9OIRCMB9FmR
 VJKQgMTkMh9n6oBHbU7AXqUZP36X4ng+/9S7M9pQruf1OeRFf/7yk6GlOtxkXvkqTclu
 Zuv8EStKugiNgqKsxn9wydduPPLPisbjs9/IfYArTH3MCxuVQYTvcTItpxsItWiMOqlZ
 sYaw==
X-Gm-Message-State: AOJu0YwZ98UwtiJu76zlHehjSUvHIWBcGAhBi4AylkyYblrikcL5j/om
 scTVvM1RgrGzlWVBtqe37D/igdMDrDQGvpS1uNwDLXaAb6VrBctbXNLGVrCVo+D7dxzxtjq6Dtj
 M
X-Gm-Gg: ASbGncuPIk5AHj86vJxedEoux7WdqXRTxQCiujk0c41GAP/hxRqh6QGhscPbECKSPmd
 OMsVPFnGdH59fGH69KYsA1yEkU9MlZOBdEFWZispx8aN6CGVX0XNb9vmNHXqYlJd4+dH+vfB04k
 XM1TZ6LRhUgtnM15YXAQYQmGm+QvsSzCPMyALd5PekJhHlkPaOl+cCV5tzInAPiPkjZ6mQhLfVX
 oWevJ+sAgNMjm1Mfu7Q52/4ctTqpdW2NENoHtnLWBNje6SPVkFJnCcl7bKt+SV1rbasc5N116DL
 IHdjY+pHkAWsnTq2JO6v9Uoyb8/KZfNRqFUpdsUGSZpQlttcUFW0NDYecJTg9MXzWN1eOzNt3SX
 sJtxEERw+qsuhMnqkI6mr
X-Google-Smtp-Source: AGHT+IEkSmAPySOolFHmmtxXZmJVawof27KWv0MsKDEug563v3dY6sDa7xFDT/JaP2nAlqTstk7jCg==
X-Received: by 2002:a05:600c:b96:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-441c49483c0mr89953915e9.29.1746542142370; 
 Tue, 06 May 2025 07:35:42 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ffbfsm13646330f8f.80.2025.05.06.07.35.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/22] system/hvf: Avoid including 'cpu.h'
Date: Tue,  6 May 2025 16:34:55 +0200
Message-ID: <20250506143512.4315-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

"system/hvf.h" doesn't need to include a full "cpu.h",
only "exec/vaddr.h" and "qemu/queue.h" are required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250403235821.9909-27-philmd@linaro.org>
---
 include/system/hvf.h     | 3 ++-
 include/system/hvf_int.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..d50049e1a1a 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -14,10 +14,11 @@
 #define HVF_H
 
 #include "qemu/accel.h"
+#include "qemu/queue.h"
+#include "exec/vaddr.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 
 #ifdef CONFIG_HVF
 extern bool hvf_allowed;
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 42ae18433f0..8c8b84012d9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -11,6 +11,8 @@
 #ifndef HVF_INT_H
 #define HVF_INT_H
 
+#include "qemu/queue.h"
+
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
 typedef hv_vcpu_t hvf_vcpuid;
-- 
2.47.1


