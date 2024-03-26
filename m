Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAJj-0006UU-6e; Tue, 26 Mar 2024 13:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJa-0006Se-93
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJX-0006bW-U4
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso3440352f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473018; x=1712077818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Dxp+qC3MBDCoPwn4MSHcBmknQiyHJfiE1PD2um5P9g=;
 b=r8yu3ykLKsUeLgfq/85DfKFIl1u2iENkHwENpeHonz3EBlRXoIBNzRzIAq4olDzjkt
 RSg7cZj8JeBbgbsTr/EFocih03+ycsbo56cxmz+slF8boylnLHrEXOwFukcFHUfwXF6k
 NtKBo+gFv8TXlHxKPERo8Ewd86xX6a5+S/tDgfsOZu+oshpIBaoL982Rru1HAdAfb4Ek
 EqVTAxgYVfJ2qDLmcYr8xQ2dRSRrHTH7FyiVyhErOh1SmQ2iMUQGZC3fTrv+tKFx9EKI
 9kJuN9g1LdXKGDio2iurySSqfzeWqty+5kcWtNR5rdrIuJ9E18Yi0unXx5A+BGtGVUwP
 YlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473018; x=1712077818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Dxp+qC3MBDCoPwn4MSHcBmknQiyHJfiE1PD2um5P9g=;
 b=gjRhq3xWnltoj6Oa6q5SMLicrMuMqG2TXA+M1tceememniqxrQ9NRgqqeiym1REhKT
 DCrJs/VA6khDWoNurL7N6hEfA41icKAFAdg0LX5UEML8q81I+r9gDlQ7yeGX7RV8+6L7
 E6QvZrfEeonUY+KS4t0djkm7zHILzcl6Hnpd0UXY9Wn2iJNtUy+ccCLE3WJykfr6cWU2
 3g0iISMioOdSFfNMUYF5PIx6iqKDYj0thtR8/ZPvwm4bilyKNkrC3kd15LtIsYoJnkms
 3yONSfs7X1z4OcVT7/3r37+hf9ygC60LBnvlNKdNXWgrGKl86e3nc4IebnwMvSGvPIGs
 WPWg==
X-Gm-Message-State: AOJu0YwSxiSA6LrxySp1Fz+12AUBxXjm6JMP8swI7n96Max5MDYnCU2A
 Uu7+gQLAwu3ecyZlmzj/qwmGJqgeY3VU+qy/cGfrC3muY3J20cFWJfjq58izhlhiUZ1b3UBbUuj
 +
X-Google-Smtp-Source: AGHT+IFf/w3junysBDCoHdj2OjDwBCX72iNg/46FAVI95FKGBQE4eTxVBisciOtaN4WSEXMnGPhXOg==
X-Received: by 2002:a5d:5707:0:b0:33e:be35:d449 with SMTP id
 a7-20020a5d5707000000b0033ebe35d449mr1414220wrv.44.1711473017883; 
 Tue, 26 Mar 2024 10:10:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 x17-20020adfffd1000000b00341babb8af0sm11331005wrs.7.2024.03.26.10.10.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 10:10:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org
Subject: [PATCH-for-9.0? v2 1/4] hw/arm/smmu: Avoid using inlined functions
 with external linkage again
Date: Tue, 26 Mar 2024 18:10:06 +0100
Message-ID: <20240326171009.26696-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326171009.26696-1-philmd@linaro.org>
References: <20240326171009.26696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
inlined functions with external linkage"):

  None of our code base require / use inlined functions with external
  linkage. Some places use internal inlining in the hot path. These
  two functions are certainly not in any hot path and don't justify
  any inlining, so these are likely oversights rather than intentional.

Fix:

  C compiler for the host machine: clang (clang 15.0.0 "Apple clang version 15.0.0 (clang-1500.3.9.4)")
  ...
  hw/arm/smmu-common.c:203:43: error: static function 'smmu_hash_remove_by_vmid' is
  used in an inline function with external linkage [-Werror,-Wstatic-in-inline]
      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
                                            ^
  include/hw/arm/smmu-common.h:197:1: note: use 'static' to give inline function 'smmu_iotlb_inv_vmid' internal linkage
  void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
  ^
  static
  hw/arm/smmu-common.c:139:17: note: 'smmu_hash_remove_by_vmid' declared here
  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                ^

Fixes: ccc3ee3871 ("hw/arm/smmuv3: Add CMDs related to stage-2")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313184954.42513-2-philmd@linaro.org>
---
 hw/arm/smmu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4caedb4998..c4b540656c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -197,7 +197,7 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
 }
 
-inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
 {
     trace_smmu_iotlb_inv_vmid(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
-- 
2.41.0


