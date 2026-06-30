Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0BDC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegl1-0003dz-Gi; Tue, 30 Jun 2026 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkz-0003cx-93
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:41 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vJ-Qk
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7173343D45;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 530FFC2BCF4;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=V/2pbfDhF30oOUDB1EfMaYaKa3TFZUDPkXFenfx7B9I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=aD93q6zP0oKTDLen8EasWYajaWIT+WqoJopwV6RaPklardDOV1kUIl/7u2WDxKj/Y
 aIZB800bZU9w/XB14m/oVNTm7BssPpmimYCxw1VFMJZGayj52cH1wfcNrkQsGOyJeG
 T+NGkC6UgKQUdTHbGOhN37lKwAhrnHfdj0T7o8vlul8ynWSDdLmcGsdOzWvE1Vooa9
 xyg/vHpy80gFYf9kBLXhjdYi1fCPGIZP7Y/+tdrWqNFOvr5iDG1QRTC2SxFLxI5Pul
 ynuCVbeIwNTaY/z5Chceb6UQOB+cdcdYwRuY2CTThbPg+Kn5miBYPONHSOqQs4JyIA
 4wgiyH1UakS4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBEC43602;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:15:55 +0800
Subject: [PATCH 1/6] target/loongarch: make VReg aligned to 16 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-1-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=jW/M08ur9xKxaX4nfsRSNoLMXNSMRPuO/YQmGnCRU14=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAlZC/CoiyZbfeQ4JRHGq3Bidgvf3saMzRjL
 BxIy0WCVTGJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJQAKCRCwMePKe/7Z
 bt+JD/9wiuXoP+ozxMbiMhcgjtalEQcnjQYwhFVBoGUTX4r+2L+PIY8VJu5fyIFTF7a4qYsTGXb
 ev2OBVU5nhPN1A2ilSnucnrX8aArTm+Draa2ngN350UbNv9zQUSttr77RxwpVv1kCDBxHyV4v56
 f2q/pzLgoQxuokW9PmMERo2Lp1SBw9i4gP517OszDeAko3mJRDRe+dSe5mTggtx6UjM8w9RXSwu
 ls/h5yUPTT0cXVuhLzkUvt0ugJAK7xnSdZ9dU4yNfjzdPgM9bXs1pLDHa4Cr3M5G6clwqJ+AvCS
 Tt2El3WcRexS0ka7Envz1JalkuqUESoXYJzaSo4VKNck2P1Cg4J9nOLUax09z5ciDGBji7mR3dU
 9CdZxBjIYVxP19GxKJ7fpMjHtYjXclWwO6gWt8S08myolWbmdzFToZYqESXY6wNrltOYOWf/aEP
 FQKQT2jn5Xd1IbRQt3Q/VBA6kQrHo5bBsfxB85ySsXIfzBkLuDF4cL9ytU2HxIJ9wJuwcOBU0Ap
 8ErUYosznO03CmDj4MK2cE1decfm4xZIrPsty7+h9evq0MijNafy0oF8UOStvOL7EaxO4Eh3hor
 KoNPMGvnMpyaWcSRWO3+EcJqhnMZONNJJE5bKiZJtQcPkFJUOMdJML7Uo0Op1ewbP6koW/AYXFk
 BtP6Q4y60r7l6GA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
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

Fixes: 008a3b1662b6 ("target/loongarch: Add LASX data support")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167ecf6d8dc6faa8c6a18c212fe4fce55..d3eb35953abb87dfb34b8f3340f8dfd83264a484 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -275,7 +275,7 @@ typedef union VReg {
     uint16_t UH[LASX_LEN / 16];
     uint32_t UW[LASX_LEN / 32];
     uint64_t UD[LASX_LEN / 64];
-    Int128   Q[LASX_LEN / 128];
+    Int128Aligned   Q[LASX_LEN / 128];
 } VReg;
 
 typedef union fpr_t fpr_t;

-- 
2.49.0



