Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2186C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7cj-0005wW-Qr; Fri, 13 Jun 2025 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7ci-0005wO-W0
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:51:25 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7ch-0007dk-4c
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:51:24 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 169686FE
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749833450;
 cv=none;
 b=hocpg3WmNjcCFifYGGFbdmxLUU5LMxcDZZfigAdmPc85CVZM0fQkioREGyoG/wzezvWTVG2UFca/KnRMc1Tc7IQt/0yrk0a9thEGE7hGCpxFQW06vtWdVNmhc/8QqXFQ2osFnya5aa9U+vdy3DQFdoYzBoFDp3+s7XQvD03NTcbyYH9Ixbtc0c3w5cEjhszRGJPB7D6NC1mOk5+uKhLc6xtrgDuIbLx1n+2gJe2JPn6ExPmVCR1jd4WTczg0j1Xn/zIE9z2q0AEUoEOMQyvfenNjrlm9Xi2LVmXgeS+VNoc8w/XwZso/KA7O8+wQYMkRLjchUlOPuN6KyUJuX531Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749833450; c=relaxed/simple;
 bh=KN+QfjXO87LWOdYnoHgbV8syv98RuniMJDgDwfJ84J0=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=WCWXjqrTw+Itgup0t1AjlbgjM9RvD0uBTNWAh49VyvEEEusKNT1Air9owCkxsqp3r2wauU+4m+UMgPO9BC/jUTgFm5b4UsjoLpxfO0TnpKSCDj5q6N7kTNFvhMl9uPcEj85xVLvMGlZW9c4rAm8kg+R1lWWRjoTUBLZT77sr8tHIgAo1xdr+zkQA3VydwkScICYFwbpmIBAtyTEyC0Gl6HeQ1evLoYvbUBCiEmH6x5Tgk9EhYpJNr0EYcY2ujcISRoy8skU2+v7ROE9GDMf87fvMo0Va7AX0dB4n9/Yqj49PcJ+cyLQsxIpJIy60IayjS/I0McDSZ2AnLPM6X/7FVw==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749833446;
 bh=KN+QfjXO87LWOdYnoHgbV8syv98RuniMJDgDwfJ84J0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=3agaPJdaIuyzJrFm+r1/8SwL8F2Z22uuk9GonM/XWap0NOkQebWUgoMA5J4qlBUmW
 OS2ojGq1aJjJac9SD6kuie4yJNkVPMRxxo21sQINjZRGM2FsriqyOwkWt2k0zdwSAM
 L5h3Fwu1jZ+jwJ9J5r7WG/5g2DZjFo8Oy9f0ZN1kUHioCQYLzyEFUgFoBZSNVQpeJg
 RpZBlkbHSuSgtGxkS+my0HOaeBE/I+7R3tF0Ssw+eu8aEQxetBbk+U5XSSg4kqEk7E
 LueOOo/dAW1VQA4DErfjeerLhdzT5zPh7y6aS2y6IA1HHuaom6S1LDmbEyG2yn0Kpv
 LhGz+e+r9yjuA==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 169686FE;
 Sat, 14 Jun 2025 00:50:43 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 08/12] hw: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:50:20 -0400
Message-ID: <20250613.qemu.patch.08@sean.taipei>
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

The GPLv2 boiler-plate in vmxnet3.h and vmw_pvscsi.h still
contained the obsolete "51 Franklin Street" postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 hw/net/vmxnet3.h     | 4 ++--
 hw/scsi/vmw_pvscsi.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/vmxnet3.h b/hw/net/vmxnet3.h
index f9283f9e7b..dbc69d5fb6 100644
--- a/hw/net/vmxnet3.h
+++ b/hw/net/vmxnet3.h
@@ -63,8 +63,8 @@
  * details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ * along with this program; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * The full GNU General Public License is included in this distribution in
  * the file called "COPYING".
diff --git a/hw/scsi/vmw_pvscsi.h b/hw/scsi/vmw_pvscsi.h
index 17fcf66273..a3ae517e19 100644
--- a/hw/scsi/vmw_pvscsi.h
+++ b/hw/scsi/vmw_pvscsi.h
@@ -14,8 +14,8 @@
  * details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ * along with this program; if not, see
+ * <https://www.gnu.org/licenses/>.
  *
  * Maintained by: Arvind Kumar <arvindkumar@vmware.com>
  *
-- 
2.49.0


