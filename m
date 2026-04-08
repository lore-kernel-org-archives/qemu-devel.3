Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92D110F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKC-0002dO-SG; Wed, 08 Apr 2026 15:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAYIv-00077G-Cg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:10 -0400
Received: from va-2-114.ptr.blmpb.com ([209.127.231.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAOlm-0002oj-7m
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1775638799; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g+AMW+AIqcrmYYHnTNq7KzVlFfTEGsoPYwILFkuet58=;
 b=gMGKB+v01Vw6KhsFVjgeDhRZ5F+hfB4Uh48SapBq6Ba0VuSWY5NE733Zs0+Sc8jHulkjnC
 4JUQ6CEcWKvzTpIp6HA20290Ng2Rt/5w/Uy95x8l3CTMskdnUFRJGb23zAzL2BR/8WU8Tg
 rN4Lp45Su6ikx2s0OJhR0cBBQKiqOLIWyqB2fPJPOQq7IX0IeGUZN6VCaVZaU5QhMQxd3U
 OPQ3VWkoaY1Efk+chfdhISn7ikBUGudohT8GwotCmYQj1zultH+BeM8A2K00u0yMC/1NQV
 RCJ3CPrskerg3mTo0tevJi8/IKZeEOGB3qq188yT0+h5p8huWi8ZKGYPa/re4g==
Date: Wed,  8 Apr 2026 16:59:39 +0800
Content-Type: text/plain; charset=UTF-8
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "Steven Lee" <steven_lee@aspeedtech.com>, "Troy Lee" <leetroy@gmail.com>, 
 "Jamin Lin" <jamin_lin@aspeedtech.com>, 
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, 
 "Joel Stanley" <joel@jms.id.au>, "Paolo Bonzini" <pbonzini@redhat.com>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, 
 "Jeremy Kerr" <jk@codeconstruct.com.au>, 
 "Matt Johnston" <matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+269d6190d+50a160+nongnu.org+zhangjian.3032@bytedance.com>
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Subject: [PATCH v1 0/2] hw: introduce a lightweight MCTP-over-I2C responder
Message-Id: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
Mime-Version: 1.0
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.231.114;
 envelope-from=zhangjian.3032@bytedance.com; helo=va-2-114.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MCTP (Management Component Transport Protocol) is a DMTF-defined
management transport protocol commonly used between BMCs and managed
components.

This series adds a lightweight MCTP implementation to QEMU. To keep the
scope small and make the first step easier to review, the current series
focuses only on the SMBus/I2C transport layer.

Patch 1 introduces a minimal MCTP-over-I2C responder core together with
a simple NCSI-related extension built on top of it. Patch 2 wires the
device into the ASPEED AST2600 EVB machine for initial testing.

The goal of this series is not to implement a full MCTP stack, but to
provide a small and practical foundation for simple emulation use cases.

This is my first submission to the QEMU upstream community, so any
comments, suggestions, or corrections would be valuable.

mctp spec[0]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0236_1.3.1.pdf
mctp i2c binding[1]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
ncsi spec[2]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf

Jian Zhang (2):
  hw/misc: introduce mctp I2C responder and NCSI support
  hw/arm/aspeed: add mctp responder device for test

 MAINTAINERS                          |   2 +
 hw/arm/aspeed_ast2600_evb.c          |  14 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/mctp-i2c-responder-ncsi.c    | 777 +++++++++++++++++++++++++++
 hw/misc/mctp-i2c-responder.c         | 694 ++++++++++++++++++++++++
 hw/misc/meson.build                  |   5 +
 include/hw/misc/mctp-i2c-responder.h | 116 ++++
 7 files changed, 1613 insertions(+)
 create mode 100644 hw/misc/mctp-i2c-responder-ncsi.c
 create mode 100644 hw/misc/mctp-i2c-responder.c
 create mode 100644 include/hw/misc/mctp-i2c-responder.h

-- 
2.20.1

