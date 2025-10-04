Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E618BCCD183
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTP-0006EQ-Ij; Sat, 04 Oct 2025 03:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTO-0006Av-4t
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTM-000528-Ci
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so2605361f8f.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562066; x=1760166866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uJHR6FBx9YijVZEPs0iL2Jy7f82hi0rShI6pcobdBHE=;
 b=e3NE57jofXV1aXWxVj5qoExiNWYlvv9z2zeTXTZsixW+SbJ9/BIf7vY8T1vK7hKY4+
 vDhDLsjb2JKO+QxwQxoqFRvwY2ouELhNDoxeja8UnDBAqjIWx6mdf7K6rgoqG6Xl0paJ
 3T38vZSgxB6I9P4PYE75oj9YWHcRCFV3K/rnC1LpoGSr0YynTWz4NiIlGET/JLT6IdFa
 aAGN6pLg3dL22kDSuKem+v/AtmeA1nrDs3whTysHeC/dwi+O/JU1XHBKbrkWnPmIcFX6
 UDdx2D8yqmzQg2PY6CHGGqACa6tuFnG9a1ZqvG8biqSulRQ7vax6MABx0GlmOH1pzVXu
 jeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562066; x=1760166866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJHR6FBx9YijVZEPs0iL2Jy7f82hi0rShI6pcobdBHE=;
 b=ZhmIyaHGsC/2FyH1ivvXODW1B5/x9wL4E5J9irZOlGEbiHpzWD66GSdUrffKMbH/hD
 QKbsnwBZr8Vllmt0n7h4PEXXmbyn4zQ7M1Rki6fAGOTFp4ny/wAW2SmjAlRCL/hCC4Ho
 aeMQnl1ujD088AK65zCuYksadUzsuVRZ+jXmkc4nHxEPRmH/hD1hBPkkyDdbIdRVdIL1
 xfIwRt3PZF2cRl6BY5CuO4BtceqLtoybSxP1E9aBmeVkPsO3YPdya57ueoPB/mEHwNK2
 13JGazO8q/YtNk5ADdNHbvVeXVPu4PWb7GPfMm9MY2FAIIh7W0IInMGmE/6fcYn3mvRk
 v1VA==
X-Gm-Message-State: AOJu0Yz7bovhOf6UXoPJx/GU380N1bHnVWyORvFpaXgOyw6GUuQBda6g
 HMeSsUGPaFre93ysU4kkqE0q9j33AVhV1exekm9NmSqPcVp6RLvlxuqXrUp2AO4DAZBENrYlYBQ
 moM6LL7eocQ==
X-Gm-Gg: ASbGncvsbi0f9EyyuL6FuocG5Eynb/lAbBBPMQErx+93+ATcPVVlvXFo5f3QxERfQaJ
 eiR7IIZiZrH62wEpg/xQJTw7rUO5SWxzn+2uupgJTFTDBQQfCwrvTDn0b9af30G5xAD+qlV5xXX
 /JEjzpo3mcylUzDVwegI5ItSKtNbVidFx7+YFhqQqUFkZizTzBYDfwzN65tPjVWqdGAWOV/aLAT
 LzZf6OErnrPABiBcu6oYsjGaAam170dXoLvtCZ07RMbf1g0Iow2fXk1eJmI2ipP6e4DH/Fr3P8b
 kicMt5+dXtRFo+KUfieHr1ZELnsjs3AqTlXsBAC/5B0n+J9kk4G4X3P9QFUEo4AXHdFYE3E/pOF
 9EAyMbbsfc/XLVbhJCzyKTh6gRyL4QPrHCD8q0g0scPohaGPBT9oJDYABCy10BrAc9u5LDruPXR
 N6tDDFZOeuUgp3+RY7K+LDNClqRpHK21z4rHPM1HmG7TtBxw==
X-Google-Smtp-Source: AGHT+IHAmutzNT/3dCTnOLgWKTGg83+wR3sR/6suPdIfQslFRQEoDPUFpGsOL7K8TZXle4LXwCxH/A==
X-Received: by 2002:a05:6000:2285:b0:3e7:5f26:f1ea with SMTP id
 ffacd0b85a97d-4256714031bmr3864081f8f.20.1759562066426; 
 Sat, 04 Oct 2025 00:14:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b8bsm11031148f8f.4.2025.10.04.00.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] target/i386/kvm: Replace legacy cpu_physical_memory_rw()
 call
Date: Sat,  4 Oct 2025 09:12:42 +0200
Message-ID: <20251004071307.37521-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-11-philmd@linaro.org>
---
 target/i386/kvm/xen-emu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 284c5ef6f68..52de0198343 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -21,6 +21,7 @@
 #include "system/address-spaces.h"
 #include "xen-emu.h"
 #include "trace.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 
 #include "hw/pci/msi.h"
@@ -75,6 +76,7 @@ static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
 static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
                       bool is_write)
 {
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
     uint8_t *buf = (uint8_t *)_buf;
     uint64_t gpa;
     size_t len;
@@ -87,7 +89,7 @@ static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
             len = sz;
         }
 
-        cpu_physical_memory_rw(gpa, buf, len, is_write);
+        address_space_rw(as, gpa, MEMTXATTRS_UNSPECIFIED, buf, len, is_write);
 
         buf += len;
         sz -= len;
-- 
2.51.0


