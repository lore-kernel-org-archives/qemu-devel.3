Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F1DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDQ-0004Gz-B0; Tue, 25 Aug 2026 18:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDC-0003rL-Bg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDA-0001r3-K7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso3395435ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695299; x=1788300099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yoa1yXasHmwThxA/d6QCly7EHag7eD5zfWJ/qbBT6qc=;
 b=HyyT/CqkjCIDudEfTfQvnM5GZsLTu4i8BrBVOoeBlNQutE1Jpo7Wk4m/Mby3nkGMfa
 PtaBgiE2K60+a3emuy4tUS4uEVNggDwauh9VtEVZRl2hmLaqBBnNSiYofAetqt/BheZt
 neUQVqTyDa4B8Ta76Bp9cy5RHyoO5qGcYsiYbX51U6yZ4xbijDc8ye1S4en8kbhKT4Oq
 OZn2ZpcOcruEuHMizPAkCD3o3j5fl82AJHRcTi8d0Y8jbepYY9Yqq/+whr39mVAoLso8
 zM5fPAA3gwSiwW1l9JpFPD4PPKZkxob8zYVmJn9PWdor1nQo22ZktUPWXhkaQ0SQjPew
 lkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695299; x=1788300099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yoa1yXasHmwThxA/d6QCly7EHag7eD5zfWJ/qbBT6qc=;
 b=sFO8FVp/TQ2ARZ04N8Nx9yClAE082VCO590UUweWcvF080RKXUq0Qb36mriv5ObFtZ
 V2AbvAha2I2j8gHPBAGbwykgluKiqVGL3XUsPpju0oLCrvNyV/d1SguM9hvHRZUP4fBB
 l9wF0F7x/vkxzIvrsTOBEmaCgMuc9a96fmIg+zNn1P5LqQlAjRP2awHIww8nBOcOG6M0
 7LGO/s1u00iLhHlUD0mxsJsFXmeuGHci8xy2+BiJLKHG8wqBVge5HS8cXmVNJYXzUg8B
 fcTzk4NzRk1hctywChWO9isxhGpihzVxBfDDBCVixd/dQLM703vldbilN/Km5clBzcEX
 YFZA==
X-Gm-Message-State: AFuF++mkDhpc1zah9/JiEKipSZzxsDmhdeMs10lDN3hbWcIB1yfhr/PZ
 aBPtTbWVfP4/O5BlXsz9fOXhUB+mtr9kPqL1e8OIUUAYwTwP0c2OiE7TrOnmUk9Myn4=
X-Gm-Gg: AR+sD12pzVp1s6P3XfJ8W7KPLfRs9HrTvNoXNufw1ppQXYhwFn3gSNjDUeHA9S6xxim
 OjXp0SUD5Da2r3JCyyNfGkH7vjjNoGP7VUovtkYYJiiQolM6I8ZP36niGGNQ1u/HnlA3q1ZwC0c
 vECC7YEzJmHtxJb8A6L1HnDRNmFuoWpxk6rpdnr6fL/MToQE6QnMuFEJs6LOLu+58wxQIFC3Uac
 /HjK9QByYwB2ri2Q9Vq86BG8fZF0yALgFxSAv5gAoKPFlko7EM7A4fgWDbXcesukvJcn+ETAuI3
 /e66+hmBh9hpJBpxuL1mNEDzVPRGCSBsga+AIQMgIzGvKk3V29jtfuEIzBqy9W0OoBJBz2fdEhP
 HnF9dRjggpHlocf09fMbqpt2aR5Nb1OIK/vzu8zFKFJEiWY3YGQJM4bNZMpmbwOQiy3e1hHF9k4
 tx5oWoO9wcDHEx1nkU0lS2D4PrGvsxUGHJ4sPx02V/ZiT3Ay4rQaH9l3Lnc6xf7B9zfRxM4sQxt
 w0FQ9NbFNgdPEhGc290MVLWrQ==
X-Received: by 2002:a17:90b:3a05:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-3966d44312fmr4568138a91.12.1787695298971; 
 Tue, 25 Aug 2026 15:01:38 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue, 25 Aug 2026 16:00:53 -0600
Message-ID: <20260825220101.3443954-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3418d75eccc4..fe195d145676 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,6 +96,8 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -3971,9 +3973,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -3998,7 +4003,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0


