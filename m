Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE5CC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6OV-000053-Pk; Sat, 04 Jul 2026 15:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wg6OP-0008T8-SM
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:51:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wg6OO-0001SK-Dd
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:51:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D424860052;
 Sat,  4 Jul 2026 19:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DEA3C19425;
 Sat,  4 Jul 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783194662;
 bh=MSWyeKV18llKahaHXG8bCvHMnKwOvm0niKB+BaZhvPU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=WSJIgPondCybI7au3vOCZ60/FQWx1e0yzmVLDKE6ejz95yT5STDakME8FLJouBnQl
 jWJbpnb6q2Orlp6IV5ifzpzVQCvdaFKWGV9bcNoJxL9FYgO32UZzJyHyzW1nd6tR8Y
 LIjqsgqNB+ofLRHLEFGxtpryUAGAYEGiYMdEQdFGqmLau17JUbrcd7Woaga7iYfCzU
 qxX1r6hAyWYEciJAQRqQsHEOwi//8bw+JmCEK3P68vj+5H+7O8pAlPO1rlIIs8mryh
 n8BtMxbLuX+YV4LT7OPQAsLCbN29JUFRPBG1PgFpT8Y6yTi2J3ki04RO9ztzc+ZI7R
 pXBU2rgtn0sJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9DC44500;
 Sat,  4 Jul 2026 19:51:02 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Sun, 05 Jul 2026 03:50:49 +0800
Subject: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
X-B4-Tracking: v=1; b=H4sIABhkSWoC/x3MQQqAIBBA0avErBswKYOuEi2qGW2oNBQkiO6et
 HyL/x9IHIUTDNUDkbMkCb6gqStYt9k7RqFi0Eob1asOZyI8QvDOtLjnE0n3Da+GFC8WSnVFtnL
 /x3F63w+8SodGYQAAAA==
X-Change-ID: 20260705-add-loong64-kvm-d271ec6d0ebf
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, b4-sent@kernel.org,
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=PNPCtIMkRVK0W0qxTiHLb/6sHgdzlIg+LHyIGQMkZOg=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqSWQdZbln0nBPF/MUEWhAJnBVvj68yui68kwBK
 GJvZ7XYAlaJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCaklkHQAKCRCwMePKe/7Z
 bqDuEACEUUv91y0X4mn0YdQZQHfur01hnPvgiEzLB0f1/7J80m/76pFXdFe3hH3dUZSL/Wwcu/A
 45ktFdGifpq4YIXYhuuQzLI7ZAQ9htk8X3LyMIlx/8VCppdCsbAPr0yGqvmdaStJtxNDPjxApQ4
 ATNAGFmmIiwI4a8BCmyvQX6ZIyqynVtVXOiPSnk7sH8Db/5SqmUlEnxdftVvUJ/icaDj+FUJH7c
 a2wV+qxrCNBbFRxzgGhJBQIREYJvU7H5STL+YziUiSf0k4Deqku7srUoV53C+lbEBfb0t5BJlkr
 xLsxMKjcunwB270wtrC/tDQonP94oSgdj9oltQmUnVydfYw0NNQY36Rpj3VJviTpCY7CrKPRT4g
 ak6LsIERABRsaucVSeWT0ExaEuN+ewwmQccitbMgKccXl7k87yIlp3nORFAAh3i85Fr/PzSspj3
 nmxeW4OVaVTX3r/c0COQk34h+AkRUXVaEHN3uALb0z2Ca/LZPY6OqXrxPcrLIubQOIVs+yvbhgb
 1KhDRutCkkTo0LbJzK+QzNqyjO+XIsO+FOt4QxdQwsfcJXvjtKwjIjuFXO/UoJHWzdZyGh0vcXB
 JFjWwbgmwZCpDIstUM1paIRYXKOxlpQOhlc5vkf9t9lJM8eTNzQ/F9yWvuCCQmH3UN5DmAEyt0g
 xyHQI1CMfJCzN3w==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d18795dde9a7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5164,7 +5164,7 @@ ERST
 DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
     "-enable-kvm     enable KVM full virtualization support\n",
     QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
-    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
+    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
 SRST
 ``-enable-kvm``
     Enable KVM full virtualization support. This option is only

---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260705-add-loong64-kvm-d271ec6d0ebf

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



