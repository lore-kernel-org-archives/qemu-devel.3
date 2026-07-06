Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C21C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWd-0007gc-Sd; Mon, 06 Jul 2026 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWZ-0007eD-7i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hm-Ku
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ED6761389;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20DB1C2BCC9;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=ydZZxJiKbQLk2JYyXs0SOyRQ0pJtUQJCOkpeOV70XQU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bmrtltlNOs9zFQcuAAjQD+D3tOfYDsTnPZ/DWDB6qoohSwgxrintHSv6HMnUDBqej
 FyXdS5hLyvUMyzsYpbnMcH/Fv2V3WN65jUmXtfAJ06kyiWMy1nBBcp4o/yftzgMxBV
 wAsLyvCiN9pIAyHaxTEYAn0ahDcqFmT9f/GK9X5cb5MRAqF9Zqppi6Gs97GfQPXkRU
 W+IVWHzv7/APb73CMS0V1bioxPz3+AspPOLFP20/aR61+DylTcVZ8bQ7nK4Wq7eGml
 sHzTBsdkFRup6CKSyPs7C3sS31DaCkcudKpnNrAGHocPdTdYINngTn+S6VuLxhbykI
 +KNGrg0IloNnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF3C43602;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:01 +0800
Subject: [PATCH v2 1/6] target/loongarch: make VReg aligned to 16 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-loong64-be-v2-1-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=AFdjbsegFHP4zmAfzZSPK1zArtZDW6YGlRIIeT2QlgY=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnY6E5saa448LT9jtA+RJc6CB4bOwmFMfB25
 Ime763L0FCJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 bsIED/0QTJidMnd1Q9kvhQF4E9k4rzyLL8gogp4fW/ULp4awxGpbOdpEdiaPBSJw+czbg3GTOhO
 K4yxhqmV3ADm5CFEtDNOkqsKTrlNWX9Bo9W2JSpsSyCKXoDD71X6Gg04qljSlAODvZMEqA0C2Dt
 5BJguxb82RiJ7O31P5vyBydTi6Mbm87bquB8pnvyBNK2wEYMFix8kFn+7TqNy5hy7ssOV9ISRNI
 k/FLtbL4+up000tMXcNv29fvIn6WpXVUNxuGRicDRTkEH+eIJc02j65kWjtmUmbCGx0dlaW7LG6
 Hmbg3wdbssJh6XtHYHE5ZYsS8/nWHeFXevmoYD82fHKkC7wShd2v32t7SIG6wUCm2oNyUDGBTA5
 HufnLwO6NLGwXd+nWZo6YyyAY0ahn0n4v16KjMpTj/joO58T7bIcTM/w2PJW75ZUIjkMErV+AnI
 z9tuVVJvYvbHxYl+CTQKAhaQAzHgaET4yL7YyW8MYuTtg3n8BlStYy1k9hkqvmQfyFjaDzZgQuj
 YIBumRlLGqqx+nvqMDaSjS/PNA5Sbf1MqjTDzh3j0emHX9r2slOIuCmiscjcx81ZixEcZxaHf+N
 UkpCfY3agZxc+WVBOZ46FwDFs+IhjQZs4bW/uQIwy0d7S8b7c5RwoOYX/09AFcDBX4Jjs1Zzarw
 QibMjpIyAoB1bxA==
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

When tcg_gen_gvec_* functions are used to operate on 128-bit
vector registers, the registers are required to be aligned
to 16 bytes. On some platforms, such as s390x, __int128 is
not aligned to 16 bytes, which will break the requirement
and make tcg_gen_gvec_* functions operate on only 64 bits.
Explicitly use aligned 128-bit integer to fix this.

Fixes: 2d5f950c054b ("target/loongarch: Implement vaddw/vsubw")
Fixes: 16f5396cec23 ("target/loongarch: Add LSX data type VReg")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167ecf6d8dc6faa8c6a18c212fe4fce55..166d831f29c5d239e1c8129fa3448d6242fc562b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -276,7 +276,7 @@ typedef union VReg {
     uint32_t UW[LASX_LEN / 32];
     uint64_t UD[LASX_LEN / 64];
     Int128   Q[LASX_LEN / 128];
-} VReg;
+} QEMU_ALIGNED(16) VReg;
 
 typedef union fpr_t fpr_t;
 union fpr_t {

-- 
2.49.0



