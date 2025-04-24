Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35244C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837n-0008GC-L6; Thu, 24 Apr 2025 16:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837c-0008Do-VF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837b-000508-5B
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1414345f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526273; x=1746131073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zoze0HQX2v4PQHrHD9ETMHyzKW/oYRwQhqDIameM5A=;
 b=MpBw5sTGg4HwZ8Fk2T7mJWow1pByqwJGqkfzVyFmPdd1bppfi5meGCNix6kZe9KlUn
 GAwTHZOFbh/4TQuYc5Nnv3Nz7V0GpWEJy7ks1KDjyKxNO9VxD3BrxcWxmmCCw4swxT/c
 uWr8p4Yoyuq08EgLwKaOSSqNGSXs+Bxl1cdXilrM6JX5SnEwStypT+3IHvoQsvqqQBUb
 g0U4cWApI9n6502G3mJfKbjZm74aRmFqNzBRZFlquYv2uj5rMa4twOpuptWSm2lcLoNU
 LGBi7jzvpWSrpZqlVpKcfnsSZP03pcfOuZFVmpQUZdXQkr3uH+gLw8/Htruc3qI8zYCA
 +VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526273; x=1746131073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zoze0HQX2v4PQHrHD9ETMHyzKW/oYRwQhqDIameM5A=;
 b=iD44I6AbLA76m58QPm0zDXC0rIsrfwZILBgsIMe+V3FXOMTifgGXfRzVAshnuRwh9K
 gDfaJ4ZBCghW/rZRyjdkNvDPPaqJxVWbRWOq4w8R6hnB+Pu4hW9hfcIIBNH7SPAF0q1X
 6mEtbFkIl/JRcgCMPNeUuEp6X5q0HWwvPsPPn+D/vV/u021nmtIFtdBFrvuSXIoDJQaU
 S1X0RDtjJ6YaPrJOV28EC57CWBF/7TqmBv4giVIfSktsFSn6OD5BzNXl2TMpp7ExiWQa
 1PA22W1sH02P5EC/9BLEu8PfodGJuZCkghhlJB9PvEPuIu6qnMhqJTHnnInHEkG/9E7b
 F6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMlE8MSAe3EKcM80BKmuWtd2IVdtQvA/9zLmU7cbMSuJe/0qGxNtHzfnZvqTQz8nkgUimoGBxUs9vQ@nongnu.org
X-Gm-Message-State: AOJu0Yx0fAK/cRVWUdIecUIQX0POF3k+JcFbc5g4psTS2zOysm4ay0Lp
 gVTFQz/pEYxMBPVWq4jzDbHlqgv8uEqsvTsokbFeLYQMznx/HRq5ap5T1itXVag=
X-Gm-Gg: ASbGncu3T27tYMLM15Y8lstNE9AOxpLmY4fKcjPqZN+J22bF1ycgSEKm/gUJfWdtWjQ
 6lTDE9+z1YVNUnsMS97FkxqLTzCgdSl71xbtNIszb5QLpdNCpPvhJqniCVQtDfcTQftPb/09/sb
 NzUb+/QV5BvlfGdY7nS9rWufRWQL+wxrQT9F8A111UFTnLAo08kThv7JVoYE9DSLeCEGodK1fi7
 G9Ok55qJwgGfPA4I04Ru1XjjYhJPigpCtunOSM4MA89GPVtTiyzKj/t5rBrj0uL/F6qXm62CQGc
 5lvub+vuvnoHvd+J01Txgs5Vr+AuQFZ6pQBCVm3QuB36xkGqzKzupFN+hjVG5o7V3CNz/xzZe0C
 9h+C6erl+cvgNwJRqngVWp55A7A==
X-Google-Smtp-Source: AGHT+IHtgTMU5++X8wPjSfrSQPuW3DPrd+vuCS2eNuu+dFvHtfOSLmXluXWiwnY3dGzb4JzhwvPBXQ==
X-Received: by 2002:a5d:5f93:0:b0:39c:30cd:352c with SMTP id
 ffacd0b85a97d-3a072a68d45mr604179f8f.8.1745526273129; 
 Thu, 24 Apr 2025 13:24:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbec5csm281461f8f.43.2025.04.24.13.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 04/13] include/exec: Include missing headers in exec-all.h
Date: Thu, 24 Apr 2025 22:24:03 +0200
Message-ID: <20250424202412.91612-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

"exec/exec-all.h" declares prototypes such:

  void *probe_access(CPUArchState *env, vaddr addr, int size,
                                        ^^^^^
                     MMUAccessType access_type, int mmu_idx,
                     uintptr_t retaddr);
  MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                        hwaddr index,
                                        ^^^^^^
                                        MemTxAttrs attrs);
                                        ^^^^^^^^^^

vaddr is defined in "exec/vaddr.h", hwaddr in "exec/hwaddr.h"
and MemTxAttrs in "exec/memattrs.h". All these headers are
indirectly pulled in via "exec/translation-block.h". Since
we will remove "exec/translation-block.h" in the next commit,
include the missing ones, otherwise we'd get errors such:

  include/exec/exec-all.h:51:1: error: unknown type name 'hwaddr'
     51 | hwaddr memory_region_section_get_iotlb(CPUState *cpu,
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/exec/exec-all.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 24383b6abad..c46255e66ef 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,8 +20,11 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
+#include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
 #include "accel/tcg/getpc.h"
-- 
2.47.1


