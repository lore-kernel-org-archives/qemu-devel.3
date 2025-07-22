Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADD5C83F34
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHa7-0002Dp-36; Tue, 22 Jul 2025 14:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.baeotf06a4prll1=o7924fsz37l5=2sjkmm5myk78tw@em483429.getutm.app>)
 id 1ueHFR-0003sC-9H
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:57:53 -0400
Received: from a3i638.smtp2go.com ([203.31.38.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.baeotf06a4prll1=o7924fsz37l5=2sjkmm5myk78tw@em483429.getutm.app>)
 id 1ueHFL-0006N7-OV
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753206159; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=azel97UDFsTcUGHXJb1kwolHChTExud2jlJm4Acs4/U=;
 b=XNecgXS+o95NGTowRLD5F7ZVL5Lu+po6+Qj1F8MCNtu3dgETgnT4mjxwHwZlnIdleSe8a
 hI/PjWSldQ+y6YySjhxTsMpY4rKxhAgPAslEn6Kj14LR1LSa8Z5LrPPMirEq4U34a2n5iZJ
 CPHeCrCGACBrX4vQPnX40N0+Im9qpp5ietgtmq4kbAWGsg1iXjNtTux8BWra7jQN9z/Kc4C
 6VFyJ9SBSVXEWEsOQfJULBBYvDG26XKHD9L8Mgf3CIU07TJX/OiiCZ6qUSWd/yeEHefDUuj
 VqZCRHrfEljr8W1D/Qpy2SqHJvbVXLn+WeG5R55fUfxWROEvbNiXIKu6lWIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1753206159; h=from : subject :
 to : message-id : date;
 bh=azel97UDFsTcUGHXJb1kwolHChTExud2jlJm4Acs4/U=;
 b=XJg1b8r7y8vGH4JrJTtNhgGgM2POftXfly5DtKBQx8Jab8Pxbc1S6wdE4JxMZa77LtGUc
 22qMXo6A7bxzJcUoRU9i2/0vwjc2ZJONl4pce/akBqz1KgWkNAjQJlAnyJqxrbQiSAMNMJE
 ubZtz678dUCyhOsDLEmR3UvgYC7mRnBub17wngzAoUfxHykOnQ2DXUL7WcpCS4S/irZeXr4
 qvdQW6w29QP0vdJsyLhZUWsJuIo+N/7K+VdEQRGbI45hPMl1SM8OzHB4JJtN5QjQYbuVmuS
 XCzJiOQ7xhlCqYCpaqsQ1lX0pAHL3xUJLrmdRzSSoO+lOmrB4qEyn3I7wmEg==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1ueH0e-FnQW0hPuqJt-eGDr for qemu-devel@nongnu.org;
 Tue, 22 Jul 2025 17:42:36 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/1] TCTI TCG backend for acceleration on non-JIT AArch64
Date: Tue, 22 Jul 2025 10:42:05 -0700
Message-ID: <20250722174228.16205-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429stPPbqo6ic
X-smtpcorp-track: B7krIOBMmoOd.yArIcWNzW8_t.RPG3XwOhMkS
Received-SPF: pass client-ip=203.31.38.126;
 envelope-from=bounce.baeotf06a4prll1=o7924fsz37l5=2sjkmm5myk78tw@em483429.getutm.app;
 helo=a3i638.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

The following patch is from work by Katherine Temkin to add a JITless backend
for aarch64. The aarch64-tcti target for TCG uses pre-compiled "gadgets" which
are snippets of code for every TCG op x all operands and then at runtime will
"thread" together the gadgets with jumps after each gadget. This results in
significant speedup against TCI but is still much slower than JIT.

This backend is mainly useful for iOS, which does not allow JIT in distributed
apps. We ported the feature from v5.2 to v10.0 but will rebase it to master if
there is interest. Would this backend be useful for mainline QEMU?

Joelle van Dyne (1):
  tcg/tcti: add TCTI TCG backend for acceleration on non-JIT AArch64

 docs/devel/tcg-tcti.rst                       | 1140 +++++++++
 meson.build                                   |   10 +
 include/accel/tcg/getpc.h                     |    6 +-
 include/disas/dis-asm.h                       |    1 +
 include/tcg/tcg-opc.h                         |   12 +
 include/tcg/tcg.h                             |    2 +-
 tcg/aarch64-tcti/tcg-target-con-set.h         |   32 +
 tcg/aarch64-tcti/tcg-target-con-str.h         |   20 +
 tcg/aarch64-tcti/tcg-target-has.h             |  132 +
 tcg/aarch64-tcti/tcg-target-mo.h              |   13 +
 tcg/aarch64-tcti/tcg-target-reg-bits.h        |   16 +
 tcg/aarch64-tcti/tcg-target.h                 |  107 +
 host/include/generic/host/atomic128-cas.h.inc |    3 +-
 tcg/aarch64-tcti/tcg-target-opc.h.inc         |   15 +
 accel/tcg/cputlb.c                            |    3 +-
 accel/tcg/tcg-accel-ops.c                     |    8 +
 tcg/optimize.c                                |    2 +
 tcg/region.c                                  |   11 +-
 tcg/tcg-op.c                                  |   27 +
 tcg/tcg.c                                     |   19 +-
 tcg/aarch64-tcti/tcg-target.c.inc             | 2250 +++++++++++++++++
 meson_options.txt                             |    2 +
 scripts/meson-buildoptions.sh                 |    5 +
 tcg/aarch64-tcti/tcti-gadget-gen.py           | 1192 +++++++++
 tcg/meson.build                               |   71 +-
 25 files changed, 5082 insertions(+), 17 deletions(-)
 create mode 100644 docs/devel/tcg-tcti.rst
 create mode 100644 tcg/aarch64-tcti/tcg-target-con-set.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-con-str.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-has.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-mo.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-reg-bits.h
 create mode 100644 tcg/aarch64-tcti/tcg-target.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-opc.h.inc
 create mode 100644 tcg/aarch64-tcti/tcg-target.c.inc
 create mode 100755 tcg/aarch64-tcti/tcti-gadget-gen.py

-- 
2.41.0


