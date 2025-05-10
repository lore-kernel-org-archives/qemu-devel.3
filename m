Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D49C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8J-0001jT-KY; Sat, 10 May 2025 02:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhj-0006CR-VP
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:51 -0400
Received: from smtpa-outbound1.duck.com ([20.13.235.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhh-0004n8-GF
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:51 -0400
Subject: [PATCH 0/6] MAX78000FTHR Implementation
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5)
 R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
X-Rspamd-Action: no action
To: qemu-devel@nongnu.org
Cc: alistair@alistair.me
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:47 -0400
Message-ID: <16B81215-B460-4A49-910E-E5FB479837C8.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:47 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: Subject; q=dns/txt; s=postal-KpyQVw; t=1746850847;
 bh=7sN68x5gJ3nPnkJoTuC/BsNx+8LRq68gVqGHi9HCnS4=;
 b=Oe7X9gJA3gz2CXYsnw8lljOHLpcf/8SCXC6bgBvLu7QF5lG55yUHjsyAVtETrmq2XoceBfkcw
 QUhzepQ0bBzABjULNTSei1eOSgc57qgswa4gOvzIf52vjfjBmbSy8VshCWu5f557CN2H7d5MgtL
 82COhhgvX70WFinehiQiKBM=
Received-SPF: pass client-ip=20.13.235.194; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound1.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:25 -0400
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

This patch series implements basic support for the MAX78000FTHR machine

https://github.com/JacksonDonaldson/max78000Test
Contains instructions for building a test program against the MAX78000FTHR
as well as results of the test suite run on QEMU and hardware.

Jackson Donaldson (6):
  MAX78000: Add MAX78000FTHR Machine
  MAX78000: ICC Implementation
  MAX78000 UART implementation
  MAX78000 GCR implementation
  MAX78000 TRNG Implementation
  MAX78000 AES implementation

 hw/arm/Kconfig                  |  15 ++
 hw/arm/max78000_soc.c           | 233 +++++++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 ++++++
 hw/arm/meson.build              |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 263 ++++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |  12 ++
 hw/misc/max78000_aes.c          | 215 +++++++++++++++++++++++
 hw/misc/max78000_gcr.c          | 295 ++++++++++++++++++++++++++++++++
 hw/misc/max78000_icc.c          |  89 ++++++++++
 hw/misc/max78000_trng.c         | 115 +++++++++++++
 hw/misc/meson.build             |   4 +
 include/hw/arm/max78000_soc.h   |  51 ++++++
 include/hw/char/max78000_uart.h |  77 +++++++++
 include/hw/misc/max78000_aes.h  |  68 ++++++++
 include/hw/misc/max78000_gcr.h  | 141 +++++++++++++++
 include/hw/misc/max78000_icc.h  |  34 ++++
 include/hw/misc/max78000_trng.h |  35 ++++
 19 files changed, 1703 insertions(+)
 create mode 100644 hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/arm/max78000_soc.h
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 include/hw/misc/max78000_aes.h
 create mode 100644 include/hw/misc/max78000_gcr.h
 create mode 100644 include/hw/misc/max78000_icc.h
 create mode 100644 include/hw/misc/max78000_trng.h

-- 
2.34.1


