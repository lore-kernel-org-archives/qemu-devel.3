Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5C606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=XkxTWbQU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbo-0005YK-1P; Sun, 08 Nov 2026 04:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbL-0005QM-VC
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:16 -0500
Received: from st-2004c-snip6-2.eps.apple.com ([2a01:b747:3001:201::20]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbJ-0005xj-3b
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:15 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 92A9B18001BD; Sun, 08 Nov 2026 09:54:08 +0000 (UTC)
X-ICL-RepId: 01a1ba94-5ff6-746d-bdbc-703e91b3cea2
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGAF1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131650; x=1825667650;
 bh=5lM3M/27cmxL429SQ6zeAkdGwYl8tz0wXYP78bVYgaU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XkxTWbQUNQ2lWNgQUBnK2hpwVIVNdRk49Sb9b8UrfEj2QXuZi5WnMlQQSzIkUqy2BSDHg+uRuYbl77ZonwddK4NPZVsM4dxNXdpVh+3bkV7JHk0g3xJUDLbmqjVD/IfeWkwvVTzue++QTDgBWr1+aSrUacVw4PRHIFKBlLa4DfSOHRxCO5V6LxJnt7+wXi129EwRHNubfg7znBW5pN6n4Vl8ARI7AWjD7zSYxeBdBWAKjGbfeY0/obsFeph9CKfAyIZ4EB/N8Cz8wA0AeDcGN6fI16Imx507S0pYBGb9OLjgseRoWxJl45LOal3f0SGiLjMiDFetn8kpHo3fBtDI+w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 3A5B318001BB; Sun, 08 Nov 2026 09:54:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Doug Cook <dcook@microsoft.com>
Subject: [PULL 01/13] target/i386/whpx: fix VMX capability MSR values
Date: Sun,  8 Nov 2026 02:53:51 -0700
Message-ID: <20261108095403.70813-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PJ8a84S6LyPd3qynDWISoHfSonQ27acU
X-Authority-Info-Out: v=2.4 cv=IaKKmGqa c=1 sm=1 tr=0 ts=6af046c1
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=34rDk-nlojoYW5TMjDsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX9kDNodiYJPyy
 fQ7nnPX5g5e75pT8Uo2G39dfLJOQDb1VIaeIBdCwt+0ThyHKR8Z36WyxVPnp6/6JnDCdAl64HvM
 uSJp1TtrMlaZyiz/bgqJQ7XkFUr2skr5g795/isRmA5G7Rx0T4GecAYcT8LuOdPjVtMpTaMNqiZ
 9OR8RwTAxP+49NWIcvWYIueBM/IbmmTv8EJn8bz9R9lK6OYnGjpSeZSjE0VbHKGCU4qnxAmQSDn
 M3ttzRp/Ee8X1Gst3413ilnGuC1uwrapPmR8Cjz0W1yrq5GXx4FMjnJxGTk1uGJR2iAMlglkeCs
 ziqQRracE7FGIhAHAFMoM5nAchdAdJPCG9JZUx+G4SEf/KwP8YiBwJcu1IW0SY=
X-Proofpoint-GUID: PJ8a84S6LyPd3qynDWISoHfSonQ27acU
X-JNJ: AAAAAAABwe+TGvjZQaA4O3stG1JxA/ZojbFvU9DgbcpQeEiwQYkc4qF7TBVxWOw1hbRYfE
 H5Tvc3ICQdTyyfDFp1DPvJnealZr5A9nKKGsOLeVG0wdz42kty79Ku3GRdI4XYjO3YF/XQ
 3IK/qNmTzki6H9dDjPp6iLsozjPgoUEC1qLhsU8gBNcMggUvigWhxvpZmi2hCM82hv0oiY
 iHSPi2tyWsTTYaMt8sCRm3oZBG4Y+Qu6foWtR+WUuKor9HJJQKW8vtea1JCxEClp5Kvr9Q
 AKKbrflXYeSLFJThpNP9vW14GrzI66qQ8VemguVlP8LmumdkXuSMsBMPHZ7ktVyVlvWNnK
 KxW9h6Q485kRKxfSRAVXcYGyY65XjfpeZ5ZVI3b588yNVojntPs4oT4/o29ci0gbbXvCwV
 J/aiwSRXMbQqyE1nb/UfZeokc+4EQbnTah2ywx5IeptgAmNQNau+d2zBfB+z7wVys3p/M/
 HLoRrPCveLATMajVBkbiptj4i7uE0nJYYu9N/8r1QA7wzZ8HAz5OX15dOAR7sojGCHG9iZ
 vSEXgqPBO7yZTfF6hWSnv23lgFlfHbOUPvQ+QOfOwBEaXtmlEX9kD9GTVcY1bfE13++dMR
 /h3Y/v/CJbNr6HkjmD1nj9qIE8/GHa4ulwMF8f1L8IkX00l9JvAsMCRp5hmufDuTspMET+
 5egpiOO04yiogvK2iA66jPVHoKruoCLcdfEzrRorllOYJL6w+eXZyQ4ZxZF8v7aV2+jf44
 WUZU3yDm1sk95BGr41wEsF9ruWzYDga6lbTUHoyiLOXMSX2Ksqs0s=
Received-SPF: pass client-ip=2a01:b747:3001:201::20;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


