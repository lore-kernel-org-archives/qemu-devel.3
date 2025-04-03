Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5953C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTP-0007xh-JN; Thu, 03 Apr 2025 19:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTN-0007pP-OT
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTM-0002ed-25
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso10268965e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724786; x=1744329586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DnV5Hp0tmpiDlfH4Mi6kMgDb46uwa+8Kt5FmKdT51M=;
 b=LnNJxmKBz1sIPqvMLUr/IUJ18ZwtsL0/2qDBGJB+K263D/u1UWda6/8xkpO/1mIL1Z
 +Cwc+5q7CAfntt8N0ffhgUbEcysMFTi/fJIODTnoVPq2iwA0MVYxeqVhAoUcIN+Fqur0
 egjh4NhLMW65tHjenlmzod5K7YCPNKlA8r6K5kuFTpqUug3tKin/Cds79xhpVs/N0Cio
 /Pk0e3+gM4GPzDQ473MgtwhO4One9FH5E117npHuD+5jVYHt1y6PlZ/H8VTOZAVMPq0Q
 mmv+yEBdegDwsM3nYvrdENBhVW6J8Ldd1JEJapsxkfkiCiJzdm02kkjoqwQyFP4jOZwH
 esxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724786; x=1744329586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DnV5Hp0tmpiDlfH4Mi6kMgDb46uwa+8Kt5FmKdT51M=;
 b=Cb+dSqEDIJlrPum5lfOkmw1vjKIs6RfcW3mCfJaGAs45Mq/m7TSYfa/AQWKwkoz3rT
 6G4fPds+oK0eBhBD3fsaPUKxVps4CTm/vXG6nSgL79oQOgC3ywS1lrdueb34MtWQtLFY
 rMWlDcxWUAasthSg7lI0ciZyj7TY66yXH7iydbVCuCPx4RngOx/5fwYx9IBvBELJO4Nz
 WkIFVQVkMrOw5DuJdVro9gd8HCtTnXIkbXklOd4AbElkrhNfHkYzKpVcZj3OG4tu3v8w
 aLc7oYm0iLG7ssEJvnMxMBxkfqF7DSjMmY+rowRRL7ii8j+fJgNBb4GcDv62mf/jBtsO
 6Gvw==
X-Gm-Message-State: AOJu0Yyg4Sdcr81fkgAgplcD++gJsp2iZvyrKxej1kkKbcIjlWIwODil
 H0+7wGCe8B4NqJ6lelSH1CtT5lBbZCWtK2bVGsX+Me4zYO8QwNKKxXj8HURy0YkjzoUgdwYcBSl
 5
X-Gm-Gg: ASbGncsfuzetGJWHhz7A6kdz0XxYd7AftUPZrnlAXB9PbtkgJgb8na7Sk0CjKFVsQYL
 PwXsWOkSUmnmV3bJNvuA6puaJKUH+9DJUBSTSYNJXMEv2AsoHip9Bz3R3mUkqzYq7biIzvkiXqp
 DCobsWxtqtZT3QKLy8sYKbSLgVwyeoxufErgg5hIXQ0eFxBY+0iLYB4LI0QzN3dh4wBLtPRsukL
 2Oo4EF/nhTFzZwovyFmh5B3zaXwWIqtweDJaHaxmjD5PUPY79fbibm1XMXaCCUcQ7AuZyH1wYB3
 ZUffMhclsnRB3PcLketz89diHJ+MdkDH8Z6TfTkSjbR2gU+umwdsqV1mc1i54lPUy8YjaI/3x2k
 /Lke/j7g1di84cqu5dhQ=
X-Google-Smtp-Source: AGHT+IEUs8ro3CdmhxSTxIZp6e6T9fSDy4jbLiW0GQXwHTwq3DChGzS3N2MT/ojVNXO/VsaTctEBbw==
X-Received: by 2002:a5d:5f81:0:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-39cb3575d11mr859095f8f.9.1743724786023; 
 Thu, 03 Apr 2025 16:59:46 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec147c9dbsm35465045e9.0.2025.04.03.16.59.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 12/39] target/arm/cpu-features: Include missing
 'cpu.h' header
Date: Fri,  4 Apr 2025 01:57:54 +0200
Message-ID: <20250403235821.9909-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

"target/arm/cpu-features.h" dereferences the ARMISARegisters
structure, which is defined in "cpu.h". Include the latter to
avoid when refactoring unrelated headers:

  In file included from target/arm/internals.h:33:
  target/arm/cpu-features.h:45:54: error: unknown type name 'ARMISARegisters'
     45 | static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
        |                                                      ^
  target/arm/cpu-features.h:47:12: error: use of undeclared identifier 'R_ID_ISAR0_DIVIDE_SHIFT'
     47 |     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu-features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 525e4cee12f..4452e7c21e3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -22,6 +22,7 @@
 
 #include "hw/registerfields.h"
 #include "qemu/host-utils.h"
+#include "cpu.h"
 
 /*
  * Naming convention for isar_feature functions:
-- 
2.47.1


