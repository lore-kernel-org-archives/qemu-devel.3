Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF7BFEA814
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5IN0-0005DG-5i; Wed, 25 Mar 2026 03:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5IMy-0005D8-C5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:09:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w5IMv-0001Le-2G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:09:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35b97ed057cso2998138a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 00:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774422571; x=1775027371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G3y5QlUG/tMAbZ3SxiPqAb5cTH9vT5XPJmLCpB8xPYo=;
 b=GYY+yv2h3tAaE970t5REGdiZrrvpReqBeyLXO1X+sTM35ukLU7Myctv29Sr/PlzBQu
 k4rUaN6fnD/0wvPzh2KPAT3nVZt4WloH4dwaiIlipPUTgydpXKFyhshcTfyr9xiRSUjh
 ksa/fXeRby6ccwG9b5Qwm20VSipMS1AgcWBGhz+OqRT3pp7WMxvbokgRhUxQUh1g/s7/
 MtWAtakImL/sc/944nBn7dVzpNOqKeXWyXlGUTMI8qUNsfCtHQFCD/Nnd4dBYtRiJxdF
 qaQ+UAvQLS34bsdhHR7YDvE13i8cT3FJLaToKfpU+Dx5TWbxlk9MRn6uve/s+IpRgfzi
 0fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422571; x=1775027371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3y5QlUG/tMAbZ3SxiPqAb5cTH9vT5XPJmLCpB8xPYo=;
 b=L8F4Cn7sAvpt1spnatStQq0X0jQT2+/R52MqfEqDi5DwCnWykmdIiK0l83voJd3tAA
 nY59jny9uC8urvYaozWci4ajpb8GGipWNrdQt98yJWXQKF3xmXEVuxBIi6FfRK17q4+F
 xktZyrXjlpO/U9sytzNvKp2GDyyEdixv0kh5BNykOW3F8tK1WhEBBty9Zuwyr+2SUfjy
 /66+77iHPBgmTYd/eOUq8pjndm5/kCndKClQ1NqQ+zknYRT8WkMIjPXhj0wmvZmaoYqf
 oSrUOgteIt05JfeA8RPfbycfnBXGYscI9QcuRR2+km7Ckk5HJ/ML11q0DRWqKKM7zZ1H
 J5jw==
X-Gm-Message-State: AOJu0YyLX3ehwfgBAa4jHUfiib2ShqI4K95kH6REans+tl/OtVuHnM1K
 1ALoqdHuhUWZiiiycibDDN/Q5tYalwzb9haRE9n0wPQ9qtPjjuCGaUJq
X-Gm-Gg: ATEYQzyt3SlOpHWGU+l0WURnaW0Q+eiE64/0z5DDmZziDRf/sONZlaWRio5OAFIAnkW
 TejWoQuOFyztwtp2j5gZ4RIGGkBHmW1pt7n44TmaEPR1mkqN4p2X1WNSSOU6prJ5sF9g+/RNXEx
 HnHa662fdnxTbdNK1PtxIMJlbTrNOEIRwLpCQXEecHmttuOSBPnxEV2DIhG5/nFv4c6sPAhxUh6
 AajKGENXhDObxun/dckfQbSx36sZWVsgfOjbrlAL6mzbe8eOGoyy5efh+2mZXosdwM/I5o4ZNqS
 h/+yRVia/ACLMm7iF2ZxypoK5bicdmU5C/nKbnY9z27HHZ/5WTOatjB/6ps8yHIVWfllj6Gp6gx
 Cl1nK6rB2MEcQxvHIeBCVF797aPTwX3P+s+Qi1Mn4LM9WesJdo4fgmlmeCOl7udbs7t+R+5oEDC
 fhDzrFAxPdQKhA//igWQTM6ehLcGg=
X-Received: by 2002:a17:90b:4c08:b0:35b:8d89:719a with SMTP id
 98e67ed59e1d1-35c0dcd71d8mr1989628a91.15.1774422571016; 
 Wed, 25 Mar 2026 00:09:31 -0700 (PDT)
Received: from orion-o6.tail020997.ts.net ([2408:8352:441:f661::1002])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031354f3sm5328074a91.6.2026.03.25.00.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:09:30 -0700 (PDT)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH v3 0/2] tests/qtest: Add Intel IOMMU bare-metal test using
 iommu-testdev
Date: Wed, 25 Mar 2026 15:09:04 +0800
Message-Id: <cover.1774421649.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=15fengyuan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

This patch series adds a bare-metal qtest for the Intel IOMMU (VT-d) using
the iommu-testdev framework. The test exercises address translation paths
without requiring a full guest OS boot.

Motivation
----------

The Intel IOMMU implementation in QEMU supports various translation 
modes. Currently, comprehensive testing of these translation paths 
requires booting a full guest OS with appropriate drivers, which is 
time-consuming and makes regression testing difficult.

This new test fills that gap by using iommu-testdev to trigger DMA
transactions and validate the IOMMU's translation logic directly.

Test Coverage
-------------

The new test provides:
- Legacy pass-through mode (identity mapping)
- Legacy translated mode with 4-level second-level page table walks
- Scalable pass-through mode (PGTT=100b)
- Scalable second-level translation mode (PGTT=010b)
- Scalable first-level translation mode (PGTT=001b)
- Root/Context Entry, PASID Directory/Table Entry configuration
- Complete 48-bit address space translation
- End-to-end DMA verification with memory validation

Testing
-------

QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
  ./build/tests/qtest/iommu-intel-test --tap -k

Changes v1 -> v2
----------------
- Rebase onto latest upstream to resolve compilation errors
- Add scalable translation mode tests (SLT, FLT, PassThrough)
- Add spec-aligned register field comments for improved readability

Changes v2 -> v3
----------------
- Fix MAINTAINERS: move qos-intel-iommu* to "QTest IOMMU helpers" 
  section, move iommu-intel-test.c entry to patch 2/2, remove
  duplicate entries from x86 general section
- Remove duplicate Q35_IOMMU_BASE macro, use existing
  Q35_HOST_BRIDGE_IOMMU_ADDR instead
- Drop unused QVTD_TM_SCALABLE_NESTED enum value
- Fix parameter alignment in function declarations
- Clarify qvtd_build_dma_attrs() comment: PASID=0 is reached via
  VT-d's no-PASID fallback, not via DMA attributes

Thanks,
Fengyuan

Fengyuan Yu (2):
  tests/qtest/libqos: Add Intel IOMMU helper library
  tests/qtest: Add Intel IOMMU bare-metal test

 MAINTAINERS |   2 +
 tests/qtest/iommu-intel-test.c   | 216 +++++++++++++
 tests/qtest/libqos/meson.build   |   3 +
 tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h | 185 +++++++++++
 tests/qtest/meson.build  |   2 +
 6 files changed, 862 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.h

-- 
2.39.5


