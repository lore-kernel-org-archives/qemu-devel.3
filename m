Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7FC05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSe-0000sa-1s; Thu, 18 Apr 2024 15:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQD-0001VZ-Vd
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQC-0007e5-Dz
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso1908727a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468465; x=1714073265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuWZ6VCaeCTfKgGM+fcYzWiSC9LIi21t46RdwEg8Jqc=;
 b=x5wRfVcOKCY5n9oADH2ZhfSsE7uQ3MTtfu3jpEtNiUvAAHPMo1BquWtLKtkybqxbEm
 gPDRlQ3Mj0VkWEoUQ9OyDIB8CtJb1QdYZJxN7lVi6jvFB4gs9CpPSrVUb0EwBLeYUlT6
 JuZE0gTxGt1pcM9rGcvud/K99h+Y/rAOVPSR61hWV2uQ/p97UzO4AuuCVW/updWH9ug7
 G35x6dDVLgYjsCpXsfCp5Ya0G0eWuiL9vdjWvcwtOyBSmulb13vPTnn5HZRdExejIreg
 GGzzhWN5k/fBlDPyn0JHcTgrXac4s9qJlCoNDdGrV9rxpC6t654/oM839wBzGYwKhj69
 bxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468465; x=1714073265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zuWZ6VCaeCTfKgGM+fcYzWiSC9LIi21t46RdwEg8Jqc=;
 b=HaVUXlvRzA9s5NQ+SOk90oKDNcGlMBJFm3E9F+dinbwUSIQlJZaTBuDK1hv2jnFUVV
 kPc3Hzka8jczuK3Ktx1+EWYkYEgtaW/699f12+7hXA0wUkUTSciaeBgDoc086HN455xd
 5xO0JhPhDHS/NSUKj5+edCO5eLmTKHuzVb0LThvWn1pBc0z2O8HHgys3oyKEGjFwBVrD
 /xmKs/SD30fzxxVxUJV0cVZVpte+hvr9ZEcHXA/NI02CtdHAue+c0QceIybKYAC0om8P
 BUBQ3tsMpOm81ugzAyF3Y0AmNiknkDhKiNhOAqLQLhpOIAawlkNfI5NlK1IPbdrgYlwJ
 jCeQ==
X-Gm-Message-State: AOJu0Yx+1LjZ4XAuAXQy8ud0fJoAIy3TIHF8Qu0l/KF1na/cQdjWaDvM
 f/J+8Vo3VwHm2crOuyZyhq4VDltV/nWL4J/8E4QvuyksGLGVcJsOrbvCo5U3wnrk+QzwQLaV9GD
 1
X-Google-Smtp-Source: AGHT+IHNrvZlZ7Uei/H294UHaKVP1n4MPQEnwPA0Hao+SxNQsQzhpCkD7PK2coUvXZVR5L3VPti1CA==
X-Received: by 2002:a50:aad4:0:b0:56d:fca8:d209 with SMTP id
 r20-20020a50aad4000000b0056dfca8d209mr113241edc.10.1713468464845; 
 Thu, 18 Apr 2024 12:27:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 fi5-20020a056402550500b0056e598155fasm1213489edb.64.2024.04.18.12.27.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:27:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/24] exec: Include missing 'qemu/log-for-trace.h' header in
 'exec/log.h'
Date: Thu, 18 Apr 2024 21:25:16 +0200
Message-ID: <20240418192525.97451-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"exec/log.h" accesses the qemu_loglevel variable,
which is declared in "qemu/log-for-trace.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/log.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/log.h b/include/exec/log.h
index 4a7375a45f..e0ff778a10 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -2,6 +2,7 @@
 #define QEMU_EXEC_LOG_H
 
 #include "qemu/log.h"
+#include "qemu/log-for-trace.h"
 #include "hw/core/cpu.h"
 #include "disas/disas.h"
 
-- 
2.41.0


