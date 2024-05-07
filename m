Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D06CC25B5C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 02:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Avd-00055R-Ag; Mon, 06 May 2024 22:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1s4Avb-000550-Be
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:51:39 -0400
Received: from mail1.sfc.wide.ad.jp ([203.178.142.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1s4AvZ-0006wg-AM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:51:39 -0400
Received: from k8s-worker-01.tail087753.ts.net (unknown
 [IPv6:2400:4051:3e03:2d00:1e98:ecff:fe05:4840])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id C2847C5838;
 Tue,  7 May 2024 11:51:32 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1715050292;
 bh=BBFe5LEv4h/iv3i4//v6b2vpeYZ629qoaGvgPLz4eww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ieZGML8OOPXAerCPyfLWs92zvxAF4hab+tE8HFI7fe5CoEK4893pD/FIqJxtrtKFQ
 +V7ARdUayTJYSsj9Zmxj3rPfOLoznTQpJbmtzpf9tUpZ3s7DNWVK3R+BbRVyXb2Ksz
 MdnDloBhSDDvNWGtGfbm4ZUMgNhX8s38hv86mhAyVjCoSLbuQXG+Zjhjncnyyp7vrD
 1iWQaSW5D8dGPCF1ZJdhhwvySIHKnrYtgDX2rAjpg3NAd/555Jz+0CrK8L7oP4nGG2
 MWA/EeS8WWOuTK1o5oKcYkyyyOeWYwY/MhdXjSDHSwyvOQ6GRGgUiCS1fuCzLHqlQc
 yA20NCv2XDnaQ==
From: Masato Imai <mii@sfc.wide.ad.jp>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [PATCH v3 1/1] accel/kvm: Fix segmentation fault
Date: Tue,  7 May 2024 02:50:11 +0000
Message-Id: <20240507025010.1968881-2-mii@sfc.wide.ad.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507025010.1968881-1-mii@sfc.wide.ad.jp>
References: <20240507025010.1968881-1-mii@sfc.wide.ad.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.178.142.133; envelope-from=mii@sfc.wide.ad.jp;
 helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the KVM acceleration parameter is not set, executing calc_dirty_rate
with the -r or -b option results in a segmentation fault due to accessing
a null kvm_state pointer in the kvm_dirty_ring_enabled function. This
commit adds a null check for kvm_status to prevent segmentation faults.

Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c0be9f5eed..544293be8a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2329,7 +2329,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
 
 bool kvm_dirty_ring_enabled(void)
 {
-    return kvm_state->kvm_dirty_ring_size ? true : false;
+    return kvm_state && kvm_state->kvm_dirty_ring_size;
 }
 
 static void query_stats_cb(StatsResultList **result, StatsTarget target,
-- 
2.34.1


