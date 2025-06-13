Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45CC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7fw-0008NV-A1; Fri, 13 Jun 2025 12:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7ft-0008Mu-TJ
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:54:42 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7fr-0007ur-V2
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:54:41 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 7120B6FE
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833647;
 cv=none;
 b=YK/TnEKD2aYpvJN0r+IXaQXHul2eCptFyaYt+VodZ7DO+5XG8+hyJzxzIoBeHnWYpciKAuuEmbsBfK56fp7So6DE94jdzqaE6s9lvoVRQKkoH+vBMagDKVgGjt1Bds6hdt68PoRdJmCUgswaPiYqSMmfaxrfgcDv9/pwk7NU/NXrTJvZerBsFoZOBpQD7XOz/P43TtHmZD5f3LAUiq2GqJjc3k/eE+yGUTOMNFFKHzcl3Rf5+WqpVsPCcw1B+JHBTpXpX3ZOcBAHST4zZ9tLRmuRoK6t2F4GrRY0Lo0uVICPV+sU6QyJNULBHdoevrGFfPOGifEpCO9S4TReaauz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833647; c=relaxed/simple;
 bh=8OVtJagQcqT4CsJxIRMqOUylJgMaAuuwAOj99PuJ3d4=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=gahPAzQP9cWEqsIyM9+83ogtApKQJYJkRgneB8vYRbOEVMU94XxSUGu+M7Hss0ENTyOtTa6xaEevf5FgPxgXYI3IURBGwq0tu/WNpIoct8NOWGUr9Tpx91rW+fRR9trNpWTZhJwKEVuLUCPc9VUNbhPporopxocVm55R3CaRTGRZ2ThhwxdlL4j24WNA50T25mCEMxwLGFYP/zhmZ4j0uOAT18zw5wG8Ycfp2IJ61b6htyvzIqafEXv5WOtTx5ayfBNJWeSd5qrRW/Uyvk25GhgH+6aT28yZDg+1IvmrLXpuMho1xPARkeQsymxcv8QzB+OKAPagg1Sd58EFzFUeIA==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833647;
 bh=8OVtJagQcqT4CsJxIRMqOUylJgMaAuuwAOj99PuJ3d4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bVtePaUtPjAzOkB5JTBq1tbjw/2Iwyha7cptsKWHW9MtoNrUiAgmnV4SfAXzoiabq
 DArNAn3pCkw2jRVoF3ZCqirwUxWxOy5HSgbfeNh7kQ4GLFq/2QBNsgw9pQiFFchg1z
 VlAU3fdNv4DYqpu+qhd3j8LmWhOLbBf99U80mrAyS6+dH3TpDDySKT4prLvUlbQu9g
 J9MJTYL+X0y4RunJF6zYSSVPqFvqqKZAIFyWQjSvDOIwfbvbeOB/0Hu63J0sX4c5jl
 iGaGIiDDw/q3s7DBqheSpDQz0R8V8HRtEq+692Tu/kUeyNQ/scHNPV7ibdo+qmdHD5
 yPUbeWh+ru2Sg==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 7120B6FE;
 Sat, 14 Jun 2025 00:54:05 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 11/12] target/xtensa: replace FSF postal address with licenses
 URL
Date: Fri, 13 Jun 2025 12:53:32 -0400
Message-ID: <20250613.qemu.patch.11@sean.taipei>
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

Some of the GPLv2 boiler-plate still contained the
obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 target/xtensa/core-dc232b/gdb-config.c.inc     | 5 ++---
 target/xtensa/core-dc232b/xtensa-modules.c.inc | 5 ++---
 target/xtensa/core-fsf/xtensa-modules.c.inc    | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/xtensa/core-dc232b/gdb-config.c.inc b/target/xtensa/core-dc232b/gdb-config.c.inc
index d87168628b..8c88caef59 100644
--- a/target/xtensa/core-dc232b/gdb-config.c.inc
+++ b/target/xtensa/core-dc232b/gdb-config.c.inc
@@ -15,9 +15,8 @@
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street, Fifth Floor,
-   Boston, MA 02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
   XTREG(0,   0, 32, 4, 4, 0x0020, 0x0006, -2, 9, 0x0100, pc,
           0, 0, 0, 0, 0, 0)
diff --git a/target/xtensa/core-dc232b/xtensa-modules.c.inc b/target/xtensa/core-dc232b/xtensa-modules.c.inc
index 164df3b1a4..bb9ebd24b8 100644
--- a/target/xtensa/core-dc232b/xtensa-modules.c.inc
+++ b/target/xtensa/core-dc232b/xtensa-modules.c.inc
@@ -14,9 +14,8 @@
    General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
 #include "qemu/osdep.h"
 #include "xtensa-isa.h"
diff --git a/target/xtensa/core-fsf/xtensa-modules.c.inc b/target/xtensa/core-fsf/xtensa-modules.c.inc
index c32683ff77..531f5e2b7e 100644
--- a/target/xtensa/core-fsf/xtensa-modules.c.inc
+++ b/target/xtensa/core-fsf/xtensa-modules.c.inc
@@ -14,9 +14,8 @@
    General Public License for more details.
 
    You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   along with this program; if not, see
+   <https://www.gnu.org/licenses/>.  */
 
 #include "qemu/osdep.h"
 #include "xtensa-isa.h"
-- 
2.49.0


