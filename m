Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA4C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K4-0007WF-Vn; Wed, 12 Aug 2026 04:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K3-0007VR-8y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:27 -0400
Received: from pv-2003d-snip6-11.eps.apple.com ([2a01:b747:3003:205::29]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K1-00052L-Hd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:27 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 903831800947; Wed, 12 Aug 2026 08:28:23 +0000 (UTC)
X-ICL-RepId: 019ff516-3e85-7720-a7ae-e673de3dc962
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523304; x=1789115304;
 bh=Ke2xrkwmgPCgpejUY5i9tffDmcMSLiMUb65iOIu/Chw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Io9AfNSAPUoZt+13hx2QErfdE0THv07FSD2PJWWYSO6uzoZjQaDmwm5H9WvPjZ346GdKbmdEalrsiytQw5xxqzI8mjt7bWR6bhECOIIqFYJ299Eyj8mz6Zukhr4r6ma2XKTwu7Ic/Wv9ixIUqUYDaxCS9R7QIDuCl7JSFQj+IQH46mo5jOW8HxCfl3d2mzwC+XrRagO+5wcaC/kM1XROsf7R9xG/vGWnkQuBYUjNimHM9oUdVDrbk7xfHH8OvolcgPNw4tHJkYRP2BnFPv3mc3BRXR0fTJJIWRD3y46rmnoFlPcIYtGOnEJUttW1mOO+RESHi2yErZ39vyNYLVzBJw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 0C1B21800967; Wed, 12 Aug 2026 08:28:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/6] whpx: i386: enable fast hypercall output
Date: Wed, 12 Aug 2026 10:28:11 +0200
Message-ID: <20260812082814.27217-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXzmXgBdy6K9z2
 H69I6O6R8Br0b1YuvAROQ1kZIv+7sgOEM8dhdXtwZ0IlBFdFzSbTHRox9Jm30q2dSW2gGvkd001
 dGUcx+qSWFjmzr/iByQEGSx/VsZdAmSXiA52D4yEiMly27m7PhCUALWTMR0uE1bHe/e+tAasCxT
 RDUmDDIpjE0C1Rx4G8X0oHtqUrk9d/b04WnmRZRoSOmG8ZolfOHxRTNJHKtDrnIYEGY8F//KaZ9
 cTrFu+XKYCz9qeyNgNVX+Hq91JNSDu2kl9FJj0hgqslV4V5YSMp8m3Q4y4F34LM4e1ZaWbeDeY7
 IEaXEfDni9NuPDOR5OPTwxG6eMwC+ixuZHfCXaN+eztwwAr8dOeLkMXwgQaFaM=
X-Proofpoint-GUID: gCvJFNmCPvKV5fSYUjnIRE9VPbXPwG_A
X-Authority-Info-Out: v=2.4 cv=Uvdu9uwB c=1 sm=1 tr=0 ts=6a7c2ea7
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=__wDYlw7T4YerZGgBbMA:9
X-Proofpoint-ORIG-GUID: gCvJFNmCPvKV5fSYUjnIRE9VPbXPwG_A
X-JNJ: AAAAAAABtpNDyKogb/IorJ4LTiVxxzAcpBWym9GmaJO4LkzHbN65+tQoZrza2+92LcBT3DGWUxAaGe80T6pj613ckqlX10y1Y0e/Lvdk39jXAjAoLezDg835f+9GnpFH5wYpMqaQRPkBX3cwPNeZXY4rRX+sQox4ZwgJpobWA1iivLEm+kR8LYfKv+7d+O49W/NGMSkEp4HeSiPLK0OiuGW5Fs3QuhaS8p9N+iWaVzRwVp/rYMOSPt0kKFNei23fKa4z8VDyAyZVWMzqHhcZ4hKLXnU7v4DXljedPsWS7hUt7pRMS6j4YNUZ1+/UtdRErUZ66PXJVRI3VYKBONh4Sr8KiZAjjRfnkHE7z52Q1miKnQ0BKdGRQC794FEFX8v9uo10Gb+UfNilT4jqjjCMI78vPrG4v6umfN9mB6SwAfQfaIP3RVZJUmZYmlt5TI1MxlKzfuQwwsA6aBwDs6A/aLBkCDLNRv5Oo2Cj5IuFFgQCQnBDr9qoyGxDkD/7wMkD3dfygay8Fcl8HVOCzIaa9t3JW6fP7EkFhA2RRi2Kwmq53N1TkrHYxtGrkOvL8iBVd13CWY/JGHrdIdxzMZhY3KtYWxT5NmS9yogZ8UJYpSTybBgXZKOXpOYANZAzh3ImqsZOTUgFcFmr8p9gjlDW2StzCfbQ3kVDkOMoNAsdo3ZnSB3dnd09fymH4YBusjn0LPxJODmCCeYhpiY2QA==
Received-SPF: pass client-ip=2a01:b747:3003:205::29;
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

Already enabled on Arm so extending it to x86.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d542821..1800ba8eb1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3247,6 +3247,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
     synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
-- 
2.54.0 (Apple Git-156)


