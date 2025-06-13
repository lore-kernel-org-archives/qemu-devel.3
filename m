Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BE1C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7g3-0008Pb-VW; Fri, 13 Jun 2025 12:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7g3-0008P9-07
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:54:51 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7g0-0007vN-WC
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:54:50 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 776836FE
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833685;
 cv=none;
 b=iepQVNOyWipkCDWtR1IjnBPpggRw6O539H/pHdd1E+6bxXQ8dt/u2BiWz1AikHwhqRGqnHJZG5w7sHHKaR+arRC6+AIO5PWFPMZsRqbP8FzikcH3c6FJEE1jtIFVghEf9RbM40P5kQt83+L8TaB0nESK7Gn3LXTZBOVtT6WVtp4GSNCEfXQEEvqvmYnK/5dF5TaoZGa0uVG45yfxS52E+r80VZcyW+xkYYyM36eoIOG+f+zJGc+b/HT1zZRIL2LoGOEHGlKQzllX8w8FfvB+JbY6UcwxHOOJwkQiQaB9fPVR7WifRUDUZ/x1Kwhp91snDstv1Xp3xnLOhSCDO0Ocww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833685; c=relaxed/simple;
 bh=9TcCIX2Pon++gUsJL8ggeDvxUxqOwCM3RU+hMoqn/uE=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=AENgZJt2flCdsFoBSebBZo3fjx1Becfref+W7dqIMYi2ftFjM8GW7ZwFWmGfGqnj4xVLWfWyEqses2Spe5rQEBdRhQEGnZtWTQMzZWZARS55n2O98Iyd0dMWAVB3eYjXV/ooj1lZlpcc5g1Qh1Kq2BlZxUeyXUdKjUlLrSNb3HB2yzUCRJs7lDsIqM++wW2KpOy16PfLtgRdm2KiYeITq18Xw2FjOZJZN2Sl3orkqVXE99renMsfuYG7Oaq6gL5jho5DRGGkAwyy2gm6flAnEfnYQu/6c0aQCmFE1oJLMnNAtGIE7jJExV8GG6RJGHMCepJ9JH/nhenutZUW4Jsv9Q==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833685;
 bh=9TcCIX2Pon++gUsJL8ggeDvxUxqOwCM3RU+hMoqn/uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QRl7U1Nkd5niy959F66c4ZPkEqGpicbzqixVPQS1I2WVJqD3/VTH7D5pYHc/KGI8m
 eTyCGZKc+a0UEObWSxfD+9IYKc6bT92WygfQfnJHyPjFUHX5tAw6m2E3S7ple/uyCM
 uZPUiogeM7OAGWVWmigzAUkKuyXityG+gsr+6bG5jkEb3LB53xiYHbVfOG/0LLhGSN
 nn0rI1K98MZEZ7wKBQvBf9hSVeCChLrpBlBj1Fg1DkVRGbCM5ZsEE04kxbmukDKjyl
 rsoQKn+CfnRE9jOzu6KC7LnjE+K0/VZGIttW0G2iib6o2cVQTw5T/ENf7JFUbZUlAv
 dF3bfv/O7VKwQ==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 776836FE;
 Sat, 14 Jun 2025 00:54:42 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 12/12] target/i386/emulate: replace FSF postal address with
 licenses URL
Date: Fri, 13 Jun 2025 12:54:20 -0400
Message-ID: <20250613.qemu.patch.12@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.patch@sean.taipei>
References: <20250613.qemu.patch@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some of the LGPLv2.1 boiler-plate still contained the
obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 target/i386/emulate/x86_emu.c   | 4 ++--
 target/i386/emulate/x86_flags.c | 4 ++--
 target/i386/emulate/x86_flags.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 4890e0a4e5..db7a7f7437 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -31,8 +31,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 
 #include "qemu/osdep.h"
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index cc138c7749..6592193b5e 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -14,8 +14,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 /*
  * flags functions
diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index 28b008e577..a395c837a0 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -14,8 +14,8 @@
 //  Lesser General Public License for more details.
 //
 //  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+//  License along with this library; if not, see
+//  <https://www.gnu.org/licenses/>.
 /////////////////////////////////////////////////////////////////////////
 /*
  * x86 eflags functions
-- 
2.49.0


