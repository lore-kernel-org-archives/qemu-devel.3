Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E26C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUzv-00038f-Vf; Mon, 29 Jan 2024 12:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUzr-000362-Ez
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:00:36 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUzp-0007NI-3i
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:00:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-339289fead2so2460859f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706547631; x=1707152431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GusI8HUqXqctRCLaiBIZ31PVThLOe2s7yLwU52A1msc=;
 b=e6s7wYZQGc7cZirW8LtJDqlBpUUD4CTHIM0ItxZlnu0u0g1pCiAAtujFxwJuGIC4Xs
 i1034mHwUdvWo9+c+Nd39dVcNqfVP2rtvaIKd2bup2Xp/tADN4dE1rM1Wdl0fu2z1Nye
 XmeqK7tKYPGsz4fUigMQb6cMkwsmUlupvgFP8PIWjPxYHHJL4B2fad7UDVU9UCAZb6qM
 qm3yHtp7iebrMnxbXILgAhGekf/kcKLObX5oOynQXGpsyWvy4VEqV0iutst8hMu7KWMS
 W4CbM9eUALe2Aivq5/VHFj5Wxr5wb/p7CFjqteKfsr74+0zEKs8qAjAnmPyk1DzDaGo3
 rGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706547631; x=1707152431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GusI8HUqXqctRCLaiBIZ31PVThLOe2s7yLwU52A1msc=;
 b=ltePpcoGB8GEbKiX5QMIR3zxw7WvVQT/rAKmxFxf/uECfaSkDG5WxdBDmrn/sda9lJ
 EPAZXrXWc6D2BR6zr60pIRY8LqAl+AjT3+z/M6ZyHWAPaV5U1FKMHtbL7S1LRZnqAMPD
 YBpnE9/pTnusCKQxAbS2G1hYWYPM8PyvVsF4iQElg61ZaLBT3s27tBFqDTafSKSPD9M2
 Xq9pUDXVbVHcTb0HdRK0mU79x3Fg9nDGRuOmJMh5apQtmxjximKwZVLWG+ZJFU67Zc+p
 Adxk/IMw2iPSBC5vuGYtx1y2cDyFt6L+PAvSOBLdEV6mutfRiS6i8erjYK4zV3EdCcsR
 XEMA==
X-Gm-Message-State: AOJu0YyatDyLgQA+6JyGVmL7UYxPo/eywVANH9r6ExYjyHWKazAw/+JQ
 MV4aBwC1Ij5wDovQ5kRkzbFvTAPvDE2riXGX0wO7D8wMJ4Up7moa8TYOsvmxemk=
X-Google-Smtp-Source: AGHT+IGZDYV/Tj0Y2+lCCRwA3W0Fs8qZFJ8r1zT2iJC+ZfWOCRm+DVX98RFXh9NhFRLr9qOsZWQ0GQ==
X-Received: by 2002:a5d:5cd0:0:b0:33a:df0d:98db with SMTP id
 cg16-20020a5d5cd0000000b0033adf0d98dbmr4261302wrb.5.1706547631087; 
 Mon, 29 Jan 2024 09:00:31 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 cx16-20020a056000093000b00337d5cd0d8asm8519505wrb.90.2024.01.29.09.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 09:00:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Roman Kagan <rvkagan@yandex-team.ru>,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/hyperv: Include missing headers
Date: Mon, 29 Jan 2024 18:00:28 +0100
Message-ID: <20240129170028.74012-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Include missing headers in order to avoid when refactoring
unrelated headers:

  hw/hyperv/hyperv.c:33:18: error: field ‘msg_page_mr’ has incomplete type
    33 |     MemoryRegion msg_page_mr;
       |                  ^~~~~~~~~~~
  hw/hyperv/hyperv.c: In function ‘synic_update’:
  hw/hyperv/hyperv.c:64:13: error: implicit declaration of function ‘memory_region_del_subregion’ [-Werror=implicit-function-declaration]
    64 |             memory_region_del_subregion(get_system_memory(),
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_signal_event’:
  hw/hyperv/hyperv.c:683:17: error: implicit declaration of function ‘ldq_phys’; did you mean ‘ldub_phys’? [-Werror=implicit-function-declaration]
   683 |         param = ldq_phys(&address_space_memory, addr);
       |                 ^~~~~~~~
       |                 ldub_phys
  hw/hyperv/hyperv.c:683:17: error: nested extern declaration of ‘ldq_phys’ [-Werror=nested-externs]
  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_retreive_dbg_data’:
  hw/hyperv/hyperv.c:792:24: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
   792 |     msg.u.recv.count = TARGET_PAGE_SIZE - sizeof(*debug_data_out);
       |                        ^~~~~~~~~~~~~~~~
       |                        TARGET_PAGE_BITS
  hw/hyperv/hyperv.c: In function ‘hyperv_syndbg_send’:
  hw/hyperv/hyperv.c:885:16: error: ‘HV_SYNDBG_STATUS_INVALID’ undeclared (first use in this function)
   885 |         return HV_SYNDBG_STATUS_INVALID;
       |                ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
BTW who maintains this code?

$ ./scripts/get_maintainer.pl -f hw/hyperv/hyperv.c
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
---
 hw/hyperv/hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 57b402b956..6c4a18dd0e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "sysemu/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -21,6 +22,9 @@
 #include "qemu/rcu_queue.h"
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
+#include "target/i386/kvm/hyperv-proto.h"
+#include "target/i386/cpu.h"
+#include "exec/cpu-all.h"
 
 struct SynICState {
     DeviceState parent_obj;
-- 
2.41.0


