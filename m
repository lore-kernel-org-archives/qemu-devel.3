Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212A8C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7fD-0007oj-5n; Fri, 13 Jun 2025 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7fB-0007oD-8m
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:53:57 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7f9-0007rZ-FG
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:53:56 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei CB1E56FE
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833603;
 cv=none;
 b=ZkAhLXayBLBTc+IddglABwGumavN4ilQEdSkIVR6dv0sHAKeMdGyP1pGzFT5MZFMA8QVuLPInMT4n8cysZDasnC9VVFPlvQQQuZ8GTUpCKWA8clXHqVSstNd4mPdQO9kqVHdLci1ZLWD1fK1gmisfG5ciEb7aZbEb5HSU/my/e/614RiReN4ogcIS5iw89hGL0oOoNE55vlcsnWIpFq/nPEKz2jGvmyLTpsnqOsxjbNdKoRx7Z9BJOhvdLZFF8vygKoFVmyKVp8iso2EHwcz6zGwR+RknI+XOgYHkYJpuukOrqSXToXlE2odGKM3fbg+pFJ1OqDxqr0qcKfisnZY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833603; c=relaxed/simple;
 bh=Dx11tmxRejgWx0btzyhQfAFU0TmrfgS8YNM5kEnZ5N4=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=oaQDBr3hfnZLrd+35gNDdcf5FUESg+wG50ZE7wpBTQ6tNRbaWAqavjcGZ/LlXH8ZyoJW8xcp8q+5yPufLe8JN25g89YU+LWwjZINHjfU3vpg6mUU7Q2TzPCw/kmPEK64bJ4U4HybDARUWlOjmNkQSSm0XnsQc24pzgxsD1t/hVfY7cUZyCTnHcl4RFrsnHJ2FbNTEY1+D1PrWH38XhC2FDiSHz+1yjZ+TY6zhSfWoUSUYl6K9Afh6sogYuz2rLcL8zZJ4GtZYQr7wsOdzZ700XqpZxwIi3WyPI0y7GwdzG5vMNk3h97pXCrL0XNuI4hMksakA/fxR6fGIaVbI2Wy1Q==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833602;
 bh=Dx11tmxRejgWx0btzyhQfAFU0TmrfgS8YNM5kEnZ5N4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=omLQaiR3EIUi8M2HT7DB0n5iuh1aVcnv38XXQi+0vNuBppnOzbFcXtoXljafrkJE8
 vZj/uKylrtxJnr3BenFkJdrFd/T6D0IcdUMOCFa2ZKrca8/YLny5oYqHhFoOUZK0Xi
 ZyGBSHe6KB1PmGwsqtAiIuaFRqlQd17JFPdkG6oHrcsD6tTvEX9l0KW3MLt91Q8SNq
 B0P8ZQt9y6Xw0/15EYSbQ4/Ig0tfAjuVON1ZYTz3PpTcDl+TkCWSXeoV7xjFRJi8Gl
 3rEoZjKk9783jjnsRgiXgkJ+GHfd2mmq67jKS2VndRoPNLIAcZr0iV/3YjQ9+n8UUx
 +mGEm7OJYFg4g==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id CB1E56FE;
 Sat, 14 Jun 2025 00:53:20 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 10/12] contrib: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:53:00 -0400
Message-ID: <20250613.qemu.patch.10@sean.taipei>
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

The LGPLv2.1 boiler-plate in pdb.c file still contained
the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 contrib/elf2dmp/pdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 492aca4434..47c5126fb8 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -14,8 +14,8 @@
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
+ * License along with this library; if not, see
+ * <https://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
-- 
2.49.0


