Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96148C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7XV-0003iN-11; Fri, 13 Jun 2025 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQ7XS-0003hu-Im; Fri, 13 Jun 2025 12:45:58 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQ7XP-0006tn-TZ; Fri, 13 Jun 2025 12:45:58 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei B909A54F1
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833112;
 cv=none;
 b=mMUux+ysRDalIZtZqbhWl4FJqoWiCD5Z2hhb2hPV8opPYDCphmHrtyDKe0rZgxlvNCUGKul19ZxvPlhCIQ8dk15v1zFuBxxYF2yYkOthe4nTuRqDYAm/R8P4KAmJNVTW4r0fOJDmqXA7+yTq4TDyRmVBPYYt3nBemhQ7oW5kqWPZFwpd+N56jcM1wNKnCOk4S6ULoKY7Whr10lWyx1mLZy1mXs7LYVbD/jg2xiy/J5sffwUClQmYEJ9b2/f8zC8Bm4oeuhLo0tLw/Ss35yxh39GG7YxS/j7lSh1YV0hFc+Msordbd1wqf1IUbTxYftSoJjvU27Jijl9diwZxIejI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833112; c=relaxed/simple;
 bh=mhscFMdSztrvU5b1rwCwTGae67om5VKIFAhn6mjEei0=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=Tr/IpoR9bP359uBFOq0NL7OXAocRuA3K/keyyZOlaTqOs+BoVbh4Qs3KcExdEIH11j7rBxBhln26i6dvogma/L4lA3179sWryyBsdyqC8mAna1EQcU/pKmgfBAXTAh3A+52pX2AInsuRn1yvyBrcy9k+pFALsiesrpoAKIBRoGGPFOfrOECCqVszTK2ZAlKKG25kcY6rK34rF0NLymVmQX66+537amjLshhTBjjm0M7XCvsIVMLA9pKAhNN4p4nGRVn9fyNgV4zT7OWtHyI1bXE1NVcd/7Z3FH0+bM3s2VccZih1TquW4p/wO/zFJglw0ErpJ9WVkvrFA0q4Rz8K2w==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833111;
 bh=mhscFMdSztrvU5b1rwCwTGae67om5VKIFAhn6mjEei0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YNXCYM5lWtpi9nvTQEhn+CSS4Ut23Rp8fjDTwWC9eDHj9+2f8gvIvHpw9oEFdIDBt
 gC7ygFyKpqb0OSXnww7cNtdOQKzS3D4iZXxclxKmLtG1wuP2qwek0XNPr4Ok8pC+iZ
 BdGLyA0JisUyJFbXLYDbnbpqrOGivFg9HTwbdu2skfc4jn3SelTv18LtOipHa3wiRc
 Jw8F+MMIvNv3ac1f1ssHppACbGeaoI2y22lDfGJEaHz0IXjznJ7C8YuZenO7KMXx+x
 UUndYKd6bcBiO5Ob5DzKWGPLgpl/UKobK3rE7+XeXStL0Ylx/xMgbMi5aJ3IugyGuq
 sp8CCe8lkwdxQ==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id B909A54F1;
 Sat, 14 Jun 2025 00:45:07 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH 05/12] include/hw: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:44:10 -0400
Message-ID: <20250613.qemu.patch.05@sean.taipei>
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
 include/hw/i2c/aspeed_i2c.h     | 3 +--
 include/hw/pci/pci_bridge.h     | 4 ++--
 include/hw/timer/aspeed_timer.h | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2c4c81bd20..2daacc10ce 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -14,8 +14,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
 #ifndef ASPEED_I2C_H
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index b0f5204d80..8cdacbc4e1 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -14,8 +14,8 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ * along with this program; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * split out pci bus specific stuff from pci.[hc] to pci_bridge.[hc]
  * Copyright (c) 2009 Isaku Yamahata <yamahata at valinux co jp>
diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 767cae4b05..a850625a05 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -16,8 +16,7 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 #ifndef ASPEED_TIMER_H
 #define ASPEED_TIMER_H
-- 
2.49.0


