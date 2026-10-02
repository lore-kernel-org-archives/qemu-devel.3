Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74249CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCasJ-0006z8-Fs; Fri, 02 Oct 2026 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xCasF-0006yp-J6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:52:19 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xCasD-0007Dd-RR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:52:19 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 7EEE7239C2;
 Fri, 02 Oct 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1790938334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I+U74psbi8tCVpzeQ6OUMDODRtaL1+AvB1PgukSJWCc=;
 b=fuL6Oalw3AW5+P4FR1PjfCBVtyRkImvTa4/FoCkNGlyGrbiOjgtUXV6pRQQ54BW8UnZt+K
 UKdHOXGeHqW+RmFssfKVeD0Kp58w+iC8sJvzVoD7lQdcdH5MQq5MvvU3QH33GhCTm5x6XP
 8Qf+3SwEoqiZNJTaKCtLTCNINLRo8hoR5eN73JUITE2NZdVW1EgYiTYWI0RugQska+o6zC
 zOTgVAxWzPrf5qtdT0ScG+EffzKwf1to9BNhTBwT78hW8Tmq39ctkLfO2Gsm4ewr0QappM
 HcblWXQpniCeTethi/CSOLNB909Lt8mUD7WommtibzwL3FZAvBtiCDiQj4x6Rg==
Received: from [192.168.1.131] (OPNsense.thinking.duckdns.org [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id CF515CF5;
 Fri, 02 Oct 2026 03:52:13 -0700 (PDT)
Message-ID: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
Date: Fri, 2 Oct 2026 03:52:12 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
From: Rick Richard <rick@sloservers.com>
Subject: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: qemu-devel@nongnu.org
Content-Language: en-US
Cc: richard.henderson@linaro.org, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, imp@bsdimp.com, kevans@freebsd.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A non-PIE qemu is loaded below 4 GiB. That includes every static
build on FreeBSD and Linux builds configured with --disable-pie.
With the identity map (guest_base 0), a non-PIE guest program can
be mapped over qemu.

Only use the identity map when qemu is loaded at 4 GiB or higher.
Non-PIE programs are normally linked below 4 GiB, and PIE programs
are loaded at or above it (ppc64 Linux loads them at exactly 4 GiB).

Signed-off-by: Rick Richard <rick@sloservers.com>
---
On FreeBSD a static qemu can't be PIE, so bsd-user is always loaded
at 0x200000. pgb_dynamic() picks guest_base 0 because the initial
image doesn't overlap qemu, but rtld later maps a non-PIE executable
at its link address on top of qemu's own text.

This isn't BSD specific, I was able to reproduce on Linux as well by
disabling PIE.

I tested the fix on Linux with static-pie and --disable-pie builds,
and on FreeBSD with aarch64, riscv64 and x86_64 guests. When qemu is
loaded high it still uses the identity map. When it's loaded low it
picks a non-zero guest_base and the guest runs normally.

I couldn't find an existing way in qemu to get its own load address,
so I used __executable_start, which both GNU ld and lld provide. If
there's a better way I'm happy to change it.

common-user/probe-guest-base.c | 9 +++++++--
include/user/probe-guest-base.h | 3 +++
2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.c
index 6f1247cf..226fe7d4 100644
--- a/common-user/probe-guest-base.c
+++ b/common-user/probe-guest-base.c
@@ -269,8 +269,13 @@ static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
uintptr_t brk, ret;
PGBAddrs ga;
- /* Try the identity map first. */
- if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
+ /*
+ * Try the identity map first, but only if qemu is loaded high.
+ * A non-PIE qemu loads low, where a guest's non-PIE executable
+ * could be mapped over it.
+ */
+ if ((uintptr_t)__executable_start >= 4 * GiB &&
+ pgb_addr_set(&ga, image_range, commpage_range, true)) {
brk = (uintptr_t)sbrk(0);
if (pgb_try_mmap_set(&ga, 0, brk)) {
guest_base = 0;
diff --git a/include/user/probe-guest-base.h b/include/user/probe-guest-base.h
index d7492ef4..fe7f971f 100644
--- a/include/user/probe-guest-base.h
+++ b/include/user/probe-guest-base.h
@@ -9,6 +9,9 @@
#include "exec/vaddr.h"
+/* Defined by the linker: the start address of qemu's own executable image. */
+extern char __executable_start[];
+
typedef struct PGBRange {
vaddr lo;
vaddr hi;

