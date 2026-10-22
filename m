Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2B606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=ArLLZVK7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gj-0002ga-NB; Thu, 22 Oct 2026 19:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gh-0002ff-Pv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:11 -0400
Received: from mr-2003d-snip6-8.eps.apple.com ([2a01:b747:3000:202::27]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2ge-00025e-Ok
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:11 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 A81351800267; Thu, 22 Oct 2026 23:59:05 +0000 (UTC)
X-ICL-RepId: 01a1660d-d78a-7d95-8e78-1bb2f4af0715
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713546; x=1824249546;
 bh=5lM3M/27cmxL429SQ6zeAkdGwYl8tz0wXYP78bVYgaU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ArLLZVK7FrV9RfxvWnltP+vwmuS/jOcZzd13wodWa5fIqUcrfhs+rLxVjZuMSlehzjkAlkmHzwNo/coL/Bu2e3aluAjEzDzvKq6KDCokrY3dp/dLuzWXfrSChiHD4R7Hxh8SgNt82xQwKMuDCiXDyxGBR/ChUYPeNLLB+9s/aZffdDijMxqSr09bCPFv7a5ZfE0P0aDzt5mt3FlqjMu1R6W3fB2nAmLcVrKfJbhB0eI4D3D5QMpevbEYpeiqOZKRCKQqiX0e7I4uqShdRGfxuXUTtUUN9ONjcrtUr6BuTGwDu+vMFbBI+8Q8fvUDH8Fo7sdh9/kz+/CaKb4/WY9I8A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 BFA3418001F0; Thu, 22 Oct 2026 23:59:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>, Doug Cook <dcook@microsoft.com>
Subject: [PATCH 01/11] target/i386/whpx: fix VMX capability MSR values
Date: Fri, 23 Oct 2026 01:58:49 +0200
Message-ID: <20261022235859.88753-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX3yVSrlAz14ua
 //EWEm+wrxbR0xl8qc8DCLmRAN1kKe06ZDyPiHa3ecW60tng0/N7Vcf1ducGTpssw7r1Zp8DFX5
 yoI83GK8xQYyBdrdvqNy0zpVuXpwg+vu33U+Lk75LlDf2xHyl+qxZnpUOhf1rGLq0x2gSsqJXuT
 DY5ZtT9y4RCChGBbdLr4Z888PbAXOIBuOqHRzWJmV1BomMuMj//K3IwR3O0IRjtnb3gjGQ0X3kS
 iaYD4VINjACyRDvKTiPxJFPL0OOv2A+D/8UWwQC2LWmvqs7/U1kN24SapWpSL8msjDWyydB+6fZ
 9dCRtV4drclVexR4q3Wbjx2IQFN0rdp+4tPnYxmMWYRftcMsZ6mArP/a5E68QM=
X-Proofpoint-ORIG-GUID: hpVEasEX7C2roEwPkcf-w0jsf46Yj3xN
X-Proofpoint-GUID: hpVEasEX7C2roEwPkcf-w0jsf46Yj3xN
X-Authority-Info-Out: v=2.4 cv=DtFbOW/+ c=1 sm=1 tr=0 ts=6adaa34a
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=34rDk-nlojoYW5TMjDsA:9
X-JNJ: AAAAAAABtHPeT6FE31YMsD94aQTX7RJClXvvCMdEjOYrr9LPD5reDDHa1K2YG24P57+Fp2tJzG8chlJ7RiAdsVh/egitqHoK864caElzQ1RnEUEBdJvx4H+FgyaVar785KXkMJOW60E5wKZtWfx1EH5MhPmuAU/3d+LBOPZJlzsCMRmFXvMImgmxIJzo2gx0h5LiVELct/GokHotgir1h9GlgKe/6BwWs2VLKrV1yGRvIfSpaOzxl2rCQp7JYCyjslksastH1IPCBmFW7gNuM4bJpINv3jUOpNwkKhFpQA+Zkr7PYLHhmPfoGH/IOGzD9zSXv1ADY373pyC23NlGv6BEeqy/MS4yfrSKE9pa36m6jRvuwVHE4/bck8Sfv4a8NRKnN1RpYyggfKLyRuFgMORvxooY66xUnZ1LOwZSXYKcidosm5vvLxuksaNRTndksgVhwU47fqgFhC00iQh0IJkvnxjiPtSv4VymwfOiPYbdZenaX5TNwZJfYVglWgKv4veBZfVlUfHJvP/UD8rs7oTI7auX2FfatTmNxtPFlwC2OV5Cmr86R6Bfb61oQqV7aed/A5zWBVr0drRidQz3ofG4Q0vfJTgIL4cYz0CYFJgWLzPmQ+pfXA2YY9GskzXQ8+VRGFZKtp5bSylwCiSCDyQHoISmSaha5rzU/LBGVtkYYBCaiceS7KY/NgNIktcsn3FGhDB11962rq3E4e1pyEiMMGng2R+dSW/rsUrG6eOaDn1d3KCCZ0Oe6qFKX7hIKo0MpUnA148960bgfqT8KPpo+h6o6LHfwUDUHcS4A7izfgM=
Received-SPF: pass client-ip=2a01:b747:3000:202::27;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Doug Cook <dcook@microsoft.com>

whpx_get_supported_msr_feature() had two bugs in how it reports the
VMX control MSRs:

- MSR_IA32_VMX_TRUE_PINBASED_CTLS and MSR_IA32_VMX_TRUE_PROCBASED_CTLS
  were queried using the non-TRUE capability codes
  (WHvCapabilityCodeVmxPinbasedCtls and WHvCapabilityCodeVmxProcbasedCtls).

- For PROCBASED_CTLS2 and the four TRUE_* control MSRs, the raw
  allowed-0/allowed-1 pair was returned. The feature-word code expects
  only the bits that may be 1 but are not required to be 1. Apply the
  same transformation as kvm_arch_get_supported_msr_feature();
  make_vmx_msr_value() adds the must-be-one bits back afterwards.

As a result, with +vmx QEMU treated many VMX features the host does
support (secondary controls, EPT, VPID, MSR bitmaps, ...) as missing,
warned about each of them, and dropped them from the CPU model. The
guest itself reads the VMX MSRs from the hypervisor, not from QEMU,
so this did not change what the guest saw.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 113f79afb9..1386affa9c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1452,10 +1452,10 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         cap = WHvCapabilityCodeVmxEptVpidCap;
         break;
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
-        cap = WHvCapabilityCodeVmxPinbasedCtls;
+        cap = WHvCapabilityCodeVmxTruePinbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
-        cap = WHvCapabilityCodeVmxProcbasedCtls;
+        cap = WHvCapabilityCodeVmxTrueProcbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
         cap = WHvCapabilityCodeVmxTrueEntryCtls;
@@ -1474,6 +1474,31 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         if (FAILED(hr)) {
             return 0;
         }
+
+        switch (index) {
+        case MSR_IA32_VMX_PROCBASED_CTLS2:
+        case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        case MSR_IA32_VMX_TRUE_EXIT_CTLS: {
+            /*
+             * These MSRs hold the allowed-0 settings in the low half and the
+             * allowed-1 settings in the high half.  QEMU's feature words want
+             * only the bits that can be one but do not have to be one, so
+             * apply the same transformation as
+             * kvm_arch_get_supported_msr_feature(); make_vmx_msr_value()
+             * restores the must-be-one bits later.
+             */
+            uint32_t must_be_one = (uint32_t)val;
+            uint32_t can_be_one = (uint32_t)(val >> 32);
+
+            val = can_be_one & ~must_be_one;
+            break;
+        }
+        default:
+            break;
+        }
+
         return val;
     }
     return 0;
-- 
2.54.0 (Apple Git-157)


