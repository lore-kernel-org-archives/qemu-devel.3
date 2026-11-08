Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090C606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Agmg+wX7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzci-0005sq-8Q; Sun, 08 Nov 2026 04:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbO-0005Rz-I2
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from st-2004a-snip6-10.eps.apple.com ([2a01:b747:3001:201::a]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005z6-Dq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 64FD21800198; Sun, 08 Nov 2026 09:54:13 +0000 (UTC)
X-ICL-RepId: 01a1ba94-72cb-7d9a-931f-e7d3a75a86d8
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGCl1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131655; x=1825667655;
 bh=M0CJ8m1tE45aGnGPaASxvBBsdpDz2YYKmBv/2eZp7xY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Agmg+wX7/CgImoYoVdj0J9YMieauUcZe256rIAX4bmc+SE/yOZHKAIx2fzAemeGQFwsIzcl0KxFmdl7ROlCwxrNhkKnyR541E7XYz9aEtqAjnCM0B+vTclumiVZLQ02XNY1E+oTQqw+0g6REyxDDFdYJvPTDWEZJHAeVHjA/EzX49pZv68Ikelpmelto0QlbUnHaK/BNl55nPr8uiIphOlvPWppW/900Ml08wR7EF3G3PpHI3aOqr0RWVziEG+NYGouP0eF4tNtpwb4adLRK5JPJsuCNIYMX2S+DHXZcLAdEcnHoz0glQUO+plBMOhWa+ZHCqly2ioqY+M7f9NbQNA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 0C50018000BD; Sun, 08 Nov 2026 09:54:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PULL 07/13] whpx: i386: avoid updating hflags for vmexits
Date: Sun,  8 Nov 2026 02:53:57 -0700
Message-ID: <20261108095403.70813-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P_SIJRJy5OPnvr-If6nY9XbEDn4SzfiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX7l67fJCoKHT2
 0AOMJRzBDS96paKMnMK5td8o9eH8kX93Ma5gJFTfzHm9XPG8LdTR2pNNRY+2b8J4WU/uU6RQL6h
 W8JFPVEHBYwZU9Fkg4+ASNPcv50GEc+ZF3Oq2RfsT/AP9WBKfr5oApfPIz24sIW64B1JQuCYAuj
 tNHdyrtz3KuUgodZJO8/M9bLimS/wOuyvTj2Kv65lGxC+kgvZLlQMmisvjOxmJf4X94QoAPc9UH
 GPf0NMxZHm8M7lGu4XSI+4sR3cFZxiqbt8d4MAM0Jnp8ZJLGRLYL7tefN+fILklPpFzQY68GfBr
 uGLxASwZPCK9ykWJ8dbtHH5CRq/Mj7MxiypP9vC7NHlc1D3869Q6i1JTdjhpKg=
X-Authority-Info-Out: v=2.4 cv=Kd3fcAYD c=1 sm=1 tr=0 ts=6af046c6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JvUqhf-O7Ua7-JxK32kA:9
X-Proofpoint-ORIG-GUID: P_SIJRJy5OPnvr-If6nY9XbEDn4SzfiH
X-JNJ: AAAAAAABDMbhn5pFxH86WZmHoZllfB0umoJJHocNDZPsZyEri8M4GDhWbRuQb/B2Ptw/Ar
 9fecgpgSgSN5787uqvy8KaOd2kQms2Fx/QcF65eYimbzAxYELXy/rWlGxOlQNeX1Lxy8Eo
 R1dC/JJeIZmpxBZqv6WhIuqid6Bgc5U+x1eNu8knIroIp9LJjl25TlvkuhtCdI+wjEyUqH
 X/vUSxhJ+EJrYWKQDRGxpXv2ZJu9xdCVbG+gJt1kaUWVX3WjB22Tq+XFSpvnlI/JvDEBdt
 5SfnrxF23s3LFKzm354HCCNxfSIFpykv04mIQuRU+xamh2gY4mJ45wHs+tV9ARd8ZrZ+Eb
 O8X3Zu3D4D9DYeZHnT5i0Nh4uwphGqgoNVP9ZOu/ChT/lh/2tBtnE9+GFCpBPuyrw/diII
 ELxi6jiIhAhcov5QKxnUvSyIe1osU+Bp8flAeIGIGftqYbuJzRUb7Nfk5gQFdrGnU0qb06
 2v5umHtMic3ViW7pggC3wsaE7hq0Ik0yOqVvzrL+4l26oCd+VPHm1axMHi8Vmsw8Ih+reQ
 M8cr0tCLSulqDehNSH2Y/djqQGLAWetXPwmrj12vHLlzrgIJdZ1kJDL5RU5TdrU4DJXeil
 G92EQ5aQVIAy5OsngbXPnF8cHLTiP4JQ/1mlZXCdIwSXrkJ2USFI05RYeALc5nthPqWS5V
 rrpfjXjQCin1/LzaQk6sw/ncJbi6HGgt2E7PjWTH4o1cP9K41eQHhlPhVT5C7uEL1IdH9Q
 OBTAKga8i0FqkSBpf6XCk5++2ZOVG5Ce6cNWqouDJ7EihjaSLCcq8Q58ejTPtXB2Lkqg==
Received-SPF: pass client-ip=2a01:b747:3001:201::a;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

From: Boden Randin <bodenrandin1@gmail.com>

whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.

x86_update_hflags() depends on state not refreshed here, while the code
using the fast runtime state does not depend on the hflags it recomputes.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d13513985c..65e56d32fa 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -772,8 +772,6 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     rflags_to_lflags(env);
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
-
-    x86_update_hflags(env);
 }
 
 static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


