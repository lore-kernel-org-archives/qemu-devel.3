Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E5FC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLed-00067W-1e; Wed, 12 Jun 2024 06:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLea-00065D-Ja
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:32 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeZ-0001Br-3q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:32 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 291524078516;
 Wed, 12 Jun 2024 10:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 291524078516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718189771;
 bh=D4GV7tzFR1N+WJtVNNDEu0h0yTZsgSlfvQDOUapPdC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ahnGi+9DapLMYODKduBj6MUO33YKhD+5MWZgPihD6UmVxaTj38VWnvNvOA+7bUQYi
 gXlSoBUcHpCxln/MIN3AotLVI/bbi3wxN3o2/T359t5CtvBgtoeYhPXF8XOhKChV6A
 kpe0YnzKclKa0HYLkCSzh+K6tz8YNFnpcj4QOkv0=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 5/5] Revert "meson: assume x86-64-v2 baseline ISA"
Date: Wed, 12 Jun 2024 13:55:25 +0300
Message-Id: <20240612105525.8795-6-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240612105525.8795-1-amonakov@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commit 294ac64e459aca023f43441651d860980c9784f1.

Reinstate the ability to use Qemu on x86 hosts that do not meet
x86_64-v2 ISA baseline.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 meson.build | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index ec59effc..49962cce 100644
--- a/meson.build
+++ b/meson.build
@@ -336,13 +336,9 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
-if host_arch == 'i386'
-  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
-endif
-if host_arch in ['i386', 'x86_64']
-  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
-endif
+# ??? Only extremely old AMD cpus do not have cmpxchg16b.
+# If we truly care, we should simply detect this case at
+# runtime and generate the fallback to serial emulation.
 if host_arch == 'x86_64'
   qemu_common_flags = ['-mcx16'] + qemu_common_flags
 endif
-- 
2.32.0


