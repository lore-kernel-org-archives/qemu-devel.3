Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B3E6BF2F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlrv0-0000dF-1v; Fri, 30 Jan 2026 12:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlruy-0000cn-4i
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:04:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlruw-0001ee-L3
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:04:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so28937445e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769792660; x=1770397460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B8Hont5tixHg2oWVfo0xPPJVEtyg01oiNDYCCFLI6yE=;
 b=Mmv0osY6YGSd3pdoLRqIL4INm1k4NTeNtZ8vmzOdG/7aoXzXEBVqCx/qeJPJOG9pQd
 /zaeUNFcNENpBBmK7wRhGjktNzhUz8GcaRsZOK1Wtdoeq4vO4rt6NjxJNr0A9MlGEsZN
 8lp66R8hdqL5GATl3z/RgvegY7eFAnILCPwpzFJEX42ToGWVwi+9yqobeLxirmBNaLBR
 OFJ43aHeFSN6tbPYEA4jpmSbQaaHrxWt3hVgE6nDkgREEUjtaR4o1xphg/IpMsV09Dm8
 T99iWxMSATyBXF1BE0JwCTmtYv3TPo08JhmLxNXqkPkj73O76etP5gGsyHZm5OIUXjXH
 WoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769792660; x=1770397460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8Hont5tixHg2oWVfo0xPPJVEtyg01oiNDYCCFLI6yE=;
 b=uDqAivX+h4R9Ju7Y0VGqs8Z4nsGt+cQ7cx1MQ5uvKrmc5M161VmyY53WbqLtz+cvpF
 izhxURXMdCPrXfKfRXfONPQnrRjD0oNlauySvJtjleQdW9Nmdhoo04KUrj++DhRcflvc
 sh0PYaJXsK403uWDFM/APKR9o1OApi7+EVqmrcAtBcYyKIYdDzcpu3wdmulce47Liwqg
 a2mMDvZVoOifdq563+EbAWbZh50k75GxgJPV/bf2wExiugScF4GLtN7Gt5YpmHtRG912
 ePb41wriUSOiNUTvcKa1NFHJl7wYt/QDopzHCSTM8jBdvTaHhaGItSu59K+6dF8R7JZq
 E3BQ==
X-Gm-Message-State: AOJu0YyBiD+28Lqj9uht/DlBmbce2hIKn+AxsmXlYjiie0IxI9sDf22w
 Qhyfj2/hLCEz6401Vaa+CcLJDYmizeDXHm+ZTeBE+mLAXfbZzJJdqsTwZxQZBx9Rp9LTjFiyNnN
 IhdEwvKY=
X-Gm-Gg: AZuq6aIomO3iHoHACRjrM2aJkKUnqsIK9LAC7tBRaOqGhPLbJeQ5sGJAbgehqQVRQX6
 XYp/NphGJHFnc6e73LQDyBEcgcDHsSLP695+gdlYEVmSBOliwCHyfJhqDzmCHTiLaIW4iCpFHeO
 tLn/b3Myv8zZDz1jlBo36Eoi+ftmdg2sLpDSCcbdkY6AZ2KcmMY3JI9kgUmCzzINo96h+hnpxPT
 P2HQAtJ/T3IcbA2f39VQ0Ao0hIzoY6pRlEZ5xAoFb3XqkePqApDOie0uBUcauyEs4r1mFYdLH8L
 DG/SLs/POvxCngXjKzgTSR0VfKEAv9QwNKrs5FqHIg4+ZGC6jsdYY/ZmUNQTDtRUX8jPx9t9yF9
 8Conl5byFjaT2DsB29hrEqjBCuqWtAiD6Bt7ATDT0nALvBJNOkn0zFQMy128oJmA7/OZANncpRO
 e3GcP2j3hLNWJpjI3nvVGVbolcK4miLQOXF9AiqNyY/wMitVhrku4SPQezR6S2
X-Received: by 2002:a05:600c:3b13:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-482db460298mr41949235e9.11.1769792659483; 
 Fri, 30 Jan 2026 09:04:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfccsm22552686f8f.17.2026.01.30.09.04.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jan 2026 09:04:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Will Hollins <whollins@google.com>, jpcottin@google.com, jansene@google.com
Subject: [PATCH 0/2] bulk: Stop forward-declaring enum typedefs
Date: Fri, 30 Jan 2026 18:04:15 +0100
Message-ID: <20260130170417.43356-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The C99 standard chapter §6.7.2.2 point 4 mentions:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type. The choice of type
  is implementation-defined, but shall be capable of representing
  the values of all the members of the enumeration.

Align with that recommendation by defining the typedef
along with the enum.

Philippe Mathieu-Daudé (2):
  bulk: Stop forward-declaring enum typedefs
  docs/devel: Mention enum typedefs forward-declaration is not allowed

 docs/devel/style.rst                 | 11 +++++++++++
 hw/riscv/riscv-iommu-bits.h          |  4 ++--
 hw/riscv/riscv-iommu.h               |  2 --
 include/hw/misc/auxbus.h             | 11 ++++-------
 include/hw/pci/pci_device.h          |  5 ++---
 include/hw/ssi/ssi.h                 |  6 ++----
 include/hw/xen/interface/io/xenbus.h |  5 ++---
 include/io/channel.h                 | 11 ++++-------
 include/system/replay.h              | 10 ++++------
 include/ui/clipboard.h               | 15 ++++++---------
 include/ui/kbd-state.h               |  6 ++----
 pc-bios/s390-ccw/virtio.h            |  5 ++---
 tests/qtest/libqos/qgraph_internal.h | 10 ++++------
 hw/core/loader.c                     |  5 ++---
 hw/display/xlnx_dp.c                 | 11 ++++-------
 hw/dma/xlnx_dpdma.c                  | 10 ++++------
 qapi/opts-visitor.c                  |  7 ++-----
 qapi/string-output-visitor.c         |  6 ++----
 tests/unit/check-qom-proplist.c      |  6 ++----
 19 files changed, 61 insertions(+), 85 deletions(-)

-- 
2.52.0


