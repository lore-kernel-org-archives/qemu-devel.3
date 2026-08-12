Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DF7C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K3-0007Vh-Mw; Wed, 12 Aug 2026 04:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K2-0007Uz-8j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:26 -0400
Received: from pv-2003i-snip6-3.eps.apple.com ([2a01:b747:3003:205::5d]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K0-00052E-Id
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:25 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 CF7641800965; Wed, 12 Aug 2026 08:28:20 +0000 (UTC)
X-ICL-RepId: 019ff516-3396-7b66-a3c6-930e15ee08f6
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523302; x=1789115302;
 bh=pEhb8ZE16BlOGPNjQ1XeHM1sRdquNH7mB6HdHyGZ8c0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=vQNY/NMOBxZZIUy6NzE7G6eh7R70T48yv0hJxFFr10ClNCy0txU1odR28bTOdq8uljMWgBPM+dwtrDioB9ueKWXfnSxNFp169+jZg/YPIxdls+qVK2W3UFFiO34FpGboBmHPNntwtBbf4PtJQMFJGpPCXthTxzaIOWO2AcRpxct/2VX5Muh4X42QDwuUhz4gGpcfFe/LvN5clggSbybYbuPpbUTrwzDTd5MsysJlPvcZsx5jrtUC87Oy323w/L+wvNrwK0DlXEcuu5FJI97rQ4RR0lwnDFRbZXkTxrDj4zhSPKLji/D6ymcTG97HVYeBV3hoU/ol88kZ76Lfi60u3g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 1EFD81800957; Wed, 12 Aug 2026 08:28:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] whpx: i386: fix xsaves enablement in legacy probing path
Date: Wed, 12 Aug 2026 10:28:09 +0200
Message-ID: <20260812082814.27217-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX2JZtRwZ6mn03
 LZaftKkteLJjsN8hPDF4aB54jZb7XqW6pj5inZEhpoHUbHLeyrhZcKwOprihOQsxzBTI5epX6UJ
 MQxL0BYpDqdXQ3tas+Aoor9HZ1moikGipW6OCP5sWQ1JusYJqymmYG1v/GSyBT9BLvCBnnCMXOu
 +fe/v3YMDQpyDSaEz3lGIkIEaa7y/dtTMRwWWP6b5NYR1cIBSwlJl4vYAq/6ehbHUsKlE6uqsey
 znbuO+jxj9oPFi3Fs/JuUzI27PPsM9et3XhtWvd+UFg7Sft0Cmh0rZFPWLdizlSZT+SRN+n4hlX
 RNkOafKlzsfQdhMxmhra17zwk3OZDAymunmxfR5HN0mO8yI4w6j9QmT29NKEXg=
X-Proofpoint-GUID: _dCJ3M6-07YxGyY28wPStP8AwI-y7v3j
X-Proofpoint-ORIG-GUID: _dCJ3M6-07YxGyY28wPStP8AwI-y7v3j
X-Authority-Info-Out: v=2.4 cv=LuOfC3dc c=1 sm=1 tr=0 ts=6a7c2ea5
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1u9Qq8vgubJVBI3kFjUA:9
X-JNJ: AAAAAAABIwDISLh1QCXYTGAdhZXLxpzsQBB7vF7rtIJf/r71i/PqhR4XXNiDv7CDPkfgzi9IaMKCnKS0i38yjZ3LTVGkIvTN1kxeQWxW65AAZIUVROjujpjR6pRWuL9/D1Po65I4DpkTbTh9CRWlOLZvLpkrXAlIDV4QGDSkt0Pk3oK3XKAKG0nWoeYmN9tFfm/H8tvk6c4BDeO8qLpKHPeHRcAJH6nJsQLDbarPR+wDjdTrsr/K3bXzd52ZSP6uO0c7WzLQqr70tIKU2aAiT4UybMEpuqD7IjmY7NCmtyELzccCbHgdBASlkVtBteSERuNJOBm32P7cf71NEJZFmhFvqu8zgCTg8i9Dd0Ir38HDfO2L1YWsvjZIrtWe8f0g/Vz3vq/P/TlJ03KiV+ApkQy+gyHZDOf5XqERBG2jZeWdnnGPQycW6/3v8u0OP9v8ZfIWmxMgn77UprciwnBZCdLBQIloPm/B3VvPX7HiubZSPyE4apeHyKVcQ0G4lTHC9TxdpRKpgUt0ja7goDQCZ/1mS0FJ0UehzHX3UlvWqWgUMC7PsU50bst5IuG005sNp5x2Ah/S7XXuVx2RszTxH4FoMHKv5nB373RCXfIhd8E7bEaaSv51IdqETcVeyngv8QO9JKmgWF/YOCMvg3Uuu973cHVCUopC1jSJtR+YCJjz8a324e0u85TpSikHEiPoyfeV+90JlFbf8UHP5a0qdn4sZ7cTPwDtm2Q=
Received-SPF: pass client-ip=2a01:b747:3003:205::5d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Without this, Linux will crash in a configuration where
xsaves is expected.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-cpu-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
index d341e6f4fd..3fb5ed79e3 100644
--- a/target/i386/whpx/whpx-cpu-legacy.c
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -113,7 +113,7 @@ uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
         if (idx == 0) {
             eax = supported_xcr0;
         } else if (idx == 1) {
-            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
+            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES;
             if (!whpx_has_xsaves()) {
                 eax &= ~CPUID_XSAVE_XSAVES;
             }
-- 
2.54.0 (Apple Git-156)


