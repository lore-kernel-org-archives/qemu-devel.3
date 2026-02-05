Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6B0ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VX-0006p1-0d; Thu, 05 Feb 2026 14:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VR-0006nT-Rs
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VN-00037n-JO
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483100e97d8so8450675e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321548; x=1770926348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JwGWXxuqSsQ++iisL/fCPRsKkpwKEoJ4MeC9qZ22M0=;
 b=Zv+HXhmO+OblBs4KnpgFY4jGJihlkiX2Iy/Gxgw/eSN8rsuuD5H4aAPiuGJMQEJZCR
 pM3hAcmrXs5mZ2Rt4CdU1UgUnUw/KjreB8pdBtkSF7j121sJjgtjlM44LlhOJjmTT/Se
 JelB9lmTiiE7mlc4jg+qyLz+2nlJyR86PKem+q+8JgJJnsuN+8BCjcdcHCOpNwlvq7gH
 Am+YdtHV/enxYw7+mrgBTpPieuaXeuHwfpoOSP31tfzqoHXSQkdm6HNDIHqtTF8zcmyF
 0NCgUSypEPtsraD/ifSludBOG5MkzvQlgjbLkHxVyWQNHQ5HMKtdRGIgnw8oOC6r9wIt
 E0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321548; x=1770926348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JwGWXxuqSsQ++iisL/fCPRsKkpwKEoJ4MeC9qZ22M0=;
 b=msUlsQE3ULj329yY4rewuEPSs0WiPfPjQP7r73cmQEiH28caJJO93NgZqld62OdXIJ
 Sec83+jgrxoq7mQgPoUayfzboTwTlUPBxrpyBqebRbiA5PXt6XRAsJbu6BW89xncMPh7
 1KmPSs0yCHWhbjTQvtHl+eHSZpJFU4oqXbgnkkR3cia4d9zo/KdpZB8F9hX4nXBNvhlo
 dxQx8Nx7lvsqL5izIZ+1vEcVIANXPCXJ4pNOzOD2FV4githT/nW51nhOwseYeloLPxh8
 B9opS++ncWj+ckYbn8J3me+YWWTVSTKgWyKJtFs8LYBB+9TOuBoMyWb4qe7eWPwhgXaT
 bpwg==
X-Gm-Message-State: AOJu0YxMLAwfXa9pukQVciGtEHLxSKirlc67nXBXPXlC0dju7TrozvSO
 sVrI7amhzCmduvmHY2FAkjHzioGlQqiBF5yVBnXzPBaKcmrX/D/oUjv3tNyfDosFod4=
X-Gm-Gg: AZuq6aKh+18EftyghgTgyN+hl8P0Gt5xGGO8heXBQr8dl0fjAnjZkstcGe6zUtfrfII
 r+CK3POJm2bzw2Ajf9CcdhiePK9y18SZ7WOp1V14mVzuDErBKT7O4PsfMvu4JYBXG+wD4pkvKPu
 PI3xicAuz+eg4ilec/BbFxoackKhZ36y8cbMNrih2RY17rTi+ddkpIGGbjCTEJyi/nMFG+R4E2W
 uiupOh+edyIxpfcREMITHRJi86ahFeXs/bEMpxaOlQG2+DiAlrCTBD5msirBXljoMR0el2OJn65
 4lKlBz/JA+m4mtcTMwg1UpzLpuaGREtjgIZIQhnfcYJ9n634jNXnxcRBxgGcUQ3o9AGqE2jPeNO
 jSume9qWzFU1KbVyLh3AMKMHzANJKuDvWFc/pGRfw5N2Hmeq4PRFRckuCfvpzxDTR52C+ORiYmT
 b8BEluNKo/3V3n1XIpe14=
X-Received: by 2002:a05:6000:2087:b0:435:ab90:6f34 with SMTP id
 ffacd0b85a97d-4362933ef81mr701258f8f.16.1770321547762; 
 Thu, 05 Feb 2026 11:59:07 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:07 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 16/29] system/physmem: Add ats_do_translate helper
Date: Thu,  5 Feb 2026 20:58:11 +0100
Message-ID: <20260205195824.2610192-17-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add 'ats_do_translate' method to enable manual IOMMU address
translation.

This allows the Remote Port subsystem to resolve guest virtual
addresses to physical addresses by querying the QEMU IOMMU
translation pipeline. This is required for the Remote Port
subsystem to support translation  requests from external masters
in a co-simulation environment.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/memory.h |  8 +++++++
 system/physmem.c        | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index e1fb82608d..c787c544ce 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2895,6 +2895,14 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
                               addr, xlat, len, is_write, attrs);
 }
 
+MemoryRegion *ats_do_translate(AddressSpace *as,
+    hwaddr addr,
+    hwaddr *xlat,
+    hwaddr *plen_out,
+    AddressSpace **target_as,
+    int *prot,
+    MemTxAttrs attrs);
+
 /* address_space_access_valid: check for validity of accessing an address
  * space range
  *
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93..b4c18f3a01 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -527,6 +527,59 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
     return *section;
 }
 
+/* This function is called from RCU critical section */
+MemoryRegion *ats_do_translate(AddressSpace *as,
+                               hwaddr addr,
+                               hwaddr *xlat,
+                               hwaddr *plen_out,
+                               AddressSpace **target_as,
+                               int *prot,
+                               MemTxAttrs attrs)
+{
+    MemoryRegionSection *section;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr plen = (hwaddr)(-1);
+    FlatView *fv = address_space_to_flatview(as);
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUTLBEntry iotlb;
+    int iommu_idx = 0;
+
+    if (!plen_out) {
+        plen_out = &plen;
+    }
+
+    /* This can be MMIO, so setup MMIO bit. */
+    section = address_space_translate_internal(
+            flatview_to_dispatch(fv), addr, xlat,
+            plen_out, true);
+
+    /* Illegal translation */
+    if (section->mr == &io_mem_unassigned) {
+        return NULL;
+    }
+
+    iommu_mr = memory_region_get_iommu(section->mr);
+    if (!iommu_mr) {
+        return NULL;
+    }
+
+    imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (imrc->attrs_to_index) {
+        iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
+    }
+
+    iotlb = imrc->translate(iommu_mr, addr, IOMMU_RO, iommu_idx);
+
+    *xlat = ((iotlb.translated_addr & ~iotlb.addr_mask)
+            | (addr & iotlb.addr_mask));
+    *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
+    *prot = iotlb.perm;
+    *target_as = iotlb.target_as;
+
+    return section->mr;
+}
+
 /* Called from RCU critical section */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs)
-- 
2.43.0


