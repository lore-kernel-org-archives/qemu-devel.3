Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE28CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wUC-00016a-RH; Sat, 04 Oct 2025 03:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUA-0000vx-Sd
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wU7-0005J6-Cc
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so27189235e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562112; x=1760166912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=onibXA/0DXFXSxtx1nm+9XwI5EvOuqLKNFHp+rd5VVI=;
 b=Rsh96tS0JrSuxybtVScIR5436/i8wZctgZgSq4hl1CSpwes9p1p4RP+nbtu40Bd0Cu
 EDZSuxl48v6/BkZZ2F6CZTXpDOFd2lduN1iEEpU2Pc3Onk6AUHEvx7gmkhts0O4fjuKf
 OCSpf1SC2AZaishpVwN710PsCcfVs3Ysz1uporMnZtsblZBhHqWP+5k5alf1fU5cjoFW
 WgVBjTpz8WuL/uTc2u7regcmtL3SoOUZF3zPWMJbKzQVb4vuYGlk5Fst88lQysWMXGKe
 cArvogXBpW0ONSHcDLseZg3kOPVW3nQQfXqyPsqgFafDDdqVbvbxAjV4o2PfCZK4mOAx
 OaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562112; x=1760166912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onibXA/0DXFXSxtx1nm+9XwI5EvOuqLKNFHp+rd5VVI=;
 b=NLEr1z9dfh5vDvY44OK+ThAVjQ/G3HoFFPCTOBAb5cZwR0uksjLVpQm+zb155FpMgx
 R4ybm32yKyfULUQ1SIjdhHJ3MUUOPNwX4nLq1PYqRyHv+XQMSW3YeHV0oo21jzNwQYXw
 KyfJNd9Gt9BcbowsiTUzxyOASTlVVShvzuCrkWN8GsxMBzNeXrxDjHsrlLCPcsf1HllZ
 EKq4OTkxqenVJ3HlOVAmPIxp46MyggIhHkJUu5lNc936RsUg4QJLMm32KpHrTvwHnM2k
 4K8s50zk1SOKdMsGgXL8MjzS+POMbUi2in6qm1AzYx9jQteUYDSJg5tcSxXmqoGSECIG
 yhsw==
X-Gm-Message-State: AOJu0Yyab7I6KTlh6qWZ1IVZjzdu9qIuGcpE9+s3xbNlu1ZdYzSksvA4
 zK89h/CfofKj/4MDjqblQCi+dXAdNYiMylEoe0jHRS2pGKY89wOmvHOH2wNQ9V4JlIRQRIg4mb7
 uzSpoY+580Q==
X-Gm-Gg: ASbGncuzoSfrb0KdjKHtRuVHn8XMyLqWrpxsTw+fQ95Z7gJ0uED687qaHTi+r1GgEYQ
 YW3nmMJ/t1CSutuB4Tu44wMYHUWic8U6L5W9G8Zv+lqVrP5Lk9Lo29939eVWat3NCgtz46NpgxL
 B4yrx8aEXv8wgLha5cF2KRbKTvB537qjQAP9RobJSqgMoEltozJJnhNH+ttaGQPFrUw998nXmrm
 60AJgu1eQ2WaW1C2LGDuOLOaNTCJ+yTB6MPXy5DfPrnSHvciYyNj+aT8wHRiwrwyaVffiRuZzTP
 +SEke0McgeUdou5vozh8mNv2ewZFyTo+IuGEXRZ1V/em1PxYtCuxJgBi7s7an+OefkX7vfJagNW
 ubRsFZohWUktps1ylpDOT21/77HNU2Kw89RHj8Bf9XFTcEQImW+GszHXkKXJj2YEolAoE+eakp8
 KgLY9uPS35/UL4k3nLmejnTSj5
X-Google-Smtp-Source: AGHT+IGfSF0FMor/h4pFj6KtZirU8XTKqgqw1R/oTuvf6T6LrDFjKxqzZkHGgoNDkCAwsPTFDUIrOg==
X-Received: by 2002:a05:600c:3d90:b0:46e:43ee:3809 with SMTP id
 5b1f17b1804b1-46e71111cbdmr34182455e9.7.1759562111874; 
 Sat, 04 Oct 2025 00:15:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8343sm161206365e9.2.2025.10.04.00.15.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] hw/s390x/s390-stattrib: Include missing
 'exec/target_page.h' header
Date: Sat,  4 Oct 2025 09:12:52 +0200
Message-ID: <20251004071307.37521-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  hw/s390x/s390-stattrib-kvm.c: In function ‘kvm_s390_stattrib_set_stattr’:
  hw/s390x/s390-stattrib-kvm.c:89:57: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
     89 |     unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
        |                                                         ^~~~~~~~~~~~~~~~
        |                                                         TARGET_PAGE_BITS

Since "system/ram_addr.h" is actually not needed, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20251001175448.18933-4-philmd@linaro.org>
---
 hw/s390x/s390-stattrib-kvm.c | 2 +-
 hw/s390x/s390-stattrib.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index e1fee361dc3..73df1f600b9 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -10,13 +10,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/target_page.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory_mapping.h"
-#include "system/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 13a678a8037..aa185372914 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,12 +11,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "exec/target_page.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "cpu.h"
-- 
2.51.0


