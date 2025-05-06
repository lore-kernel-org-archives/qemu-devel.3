Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21B7C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOZ-0006vu-2j; Tue, 06 May 2025 10:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOW-0006sY-UH
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOV-00013p-5D
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so19207775e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542137; x=1747146937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufygZT8s60A1VbqI5u3oirvtlHFo9Kd6lcHx0GOiJXE=;
 b=hpUrhw+2cC1h//DLPAnSQQUJL89Nmy4qJ1eqnv1AV8lbpvigSc+gO1yxW17a8U7Cuj
 bGkqhuu2wzQU6cJW8p4QeV1wplmARwy2DqH1hgq3Ru6nV6o5DD2BlgjgdBFB7fm8w8YD
 Q2WJvp0b3i4UK6IJEwyt7KcunEwGiCiUFz0euVeDfgPdlr/JAcTwoQQWR37zPRi9dOjY
 vgJZPZPsphNcyDVRcsmaY6Y8OqLRZqJzyx8FB6TrOxKk51b4uVTcilRcUzIL0ASjz9F7
 1VtehEAYGlc5yV/cuhe/lh4hJK88U9qunn4Yv7MdOuiuYMHCmx+1IacqdSzK7uq3LTch
 jNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542137; x=1747146937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufygZT8s60A1VbqI5u3oirvtlHFo9Kd6lcHx0GOiJXE=;
 b=tWKQklcsv/OpEz1lxRnEgt1QwcB5s9hRv+jrihv2ZXJxzHJHJTJS68F7LjJvXR/lty
 fcm5DqIxyi9mY28WgJ8mqcu50xkI1mWCnVLwQ3hGYrW+/MiVnDN1iKEPHULG4uNK7R+U
 aR9v3jwA09AoF5wzYcdvVln8gXTDS2i40Oiw+GvLagO9izE7X0kL5t/YKmJ9IvUr+sSb
 3+Yy2TZkd4ehTZa6MwwA/cCNo7XmRVFx2qOLVy8RM+3I5A0p1iOJz+xgfg16nTH5CACi
 OvEppKwI52ivTeEqPQILyIc9XAgRDZ+DFUxxgNIgMOcITVe5XomiKe1JQt9sI+HuUh1v
 L5bQ==
X-Gm-Message-State: AOJu0YzmwD1+6uSyo9gnVlEaYgoOsaQwAikeJzF1hbdL7XX9/qWjhtYq
 nvTwXM7otlIfK0xD/aOfChEMHTmA81dhZDP6qkyjOZxFf8cvN55giDJXgM0W0HGbPq1VSeQvsod
 d
X-Gm-Gg: ASbGncuh45t01FIFRwl7mYPo46DOySfo5DBnFX6ysnzDisJBomj4EkWZtIgS6DrhoN7
 bq1hV7ARXTtm+5ipCCNYNhjwYrmbKAHNfhSFdWH3CUZBddc8k6FxWVKjdHHSwp90+6QKzHlcvdO
 CCoCeTsuHzDbXJftg18175I7AlFAVLSJ7nYlKMQtZOToVU+THN6uTLKEAA63/+B1ESW6sMlRyw1
 Rpm+8sU4r3bS5cWWbhZBm4Yx9nlku9EQHO4xksX2v/+HHcYlVSNGKYyS24vhWa+G9ZoVaTYiDfW
 Ni2QvCvyLVT41p7btAsvCrVPj1YpAaV20FoQhpDpQRdJ/tdlZZ0XZatzyjpmXbLtudpBEp7FKo3
 9zQRoVa1UuJEC+PRPg0OP
X-Google-Smtp-Source: AGHT+IGczfu/u4a3BdbAs+TMB6mBoMfLzu9PBRHyTMioPhXuuLwid8NLQR7UGiXaNqgYkyV9Hl71FQ==
X-Received: by 2002:a05:600c:4fc9:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-441bbed9ec1mr185259305e9.15.1746542137077; 
 Tue, 06 May 2025 07:35:37 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28082sm215745915e9.34.2025.05.06.07.35.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PULL 05/22] target/i386/hvf: Include missing 'exec/target_page.h'
 header
Date: Tue,  6 May 2025 16:34:54 +0200
Message-ID: <20250506143512.4315-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Include "exec/target_page.h" to be able to compile HVF on x86_64:

  ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
              uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
                                                ^
  ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
              hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,

Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reported-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250425174310.70890-1-philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 99e37a33e50..b16fb066758 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -50,6 +50,7 @@
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "migration/blocker.h"
 
 #include "system/hvf.h"
-- 
2.47.1


