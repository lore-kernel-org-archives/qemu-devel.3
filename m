Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0F3E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRTi-0001xH-Sr; Mon, 23 Feb 2026 03:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSi-0000zL-LL
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:41 -0500
Received: from p-east2-cluster3-host7-snip4-7.eps.apple.com ([57.103.77.238]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSh-0002KW-6z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:40 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 CA72A1800223; Mon, 23 Feb 2026 08:38:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835918; x=1774427918;
 bh=JmJeyCNGmOwI1RRJYOEbtrFmR9IX358A6jq63HYV7u4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NwYl4m+KBSHF9H3/aAbwWp0CA7yQf2KhHrI4T9GzoSvPhRm4Dv8msINPsIIozduWsiO6mDYeLW3rCGs3VNTkKkVa9FGsmtDug9ci2YRxxIhb7uH2HVMBfvsOL1GscByILGfEgRCo+YY+lC+rGStyLBIpvUeBjXRPSz6aIL3LTzfeZkratjx6A4SFSBbucXeOf1bD8mLVM0k3lqxWhQUA4GU+IdpJKSOS7vmfqmw/0YRDB2GVX0M1IXmR4DuQ6Vf5FD+xs3601u9DaBSNzAQU57vzFWy6xszhiFkX3Z990XWqf1dC70CJLYOgBz8Uv+5MWWEPDbsDX8z9ZEEMelRURg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 1D33A18000B5; Mon, 23 Feb 2026 08:38:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 23/27] target/i386: emulate: remove fetch_instruction
 helper too
Date: Mon, 23 Feb 2026 09:37:29 +0100
Message-ID: <20260223083734.48533-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=a9E9NESF c=1 sm=1 tr=0 ts=699c120c
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Mh07pQtNwjrl1AJ-msEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXzTVsOcVOyT5C
 nQtLmd6DPmwQRx7IpOcmEEmyhvawcowpeuIle8PeNT7W4MFvuI67zU8GpDV8BL/5kx1KMw2UREM
 1atYaGzvMqDA242faW1R1AyHlweZHnO96hNvfnSGGD1L4tkfUY7XFrbLSx4YCB1wlc+avFmk+Ks
 r1twbIM6MjUvrb/wPhgqcdlPxOVjIPsC0pZPmrn++qlJjHLw2Fe9QzYlBfs1yFkMq4ns3I+cY6r
 xQlW5HISW+wngkp+1YupojWW9fB3DO1GkwHeT7+u+6mEdJhKxcLQZ1OvAHNk/k7FFM36pR8G9Zo
 0P6hqRgMsRn7bVxg3/R2xkiWh8vw20LWwckxiUBfjpjHAP43kNTejUdimT+LaE=
X-Proofpoint-GUID: xgZNz9hoG3ZdY-QUPZ62EFWhQrMzHpTi
X-Proofpoint-ORIG-GUID: xgZNz9hoG3ZdY-QUPZ62EFWhQrMzHpTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=869
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABoCE3VP3L4BGzVoN9RyMhQXXhBL3V5jkI09wqF8gZqNBe6K0SCMY3UZfCsudJAhqK7vf2THievFNWxfXBdzGZ3/PiuUqYdbcGpHPtKR/J75d7/q6ROQAsP1OVOXzRd5ysb/mRALSgl2w+gCZiFdbuqbNuAd4bD+O+i4NA4rnDJKrDYBcnEBLy9v/tuJrOtj/sSmBOUnQW3Is7ytE9MtNluLAY7piSGfEO5thWb7XY5zd6xzEbL9vgCg64BR0jNGQ5dkpa5n4JJtj/eiCtVZ8ZGVLKpja6Ar7ylHEQRP7wopPdfAOuAPisGuQg7rE2nGO2myFa5huro9vdM7nVXh2ieoRAC0A+QZ9kdVcmu8ZwXQr4EyfIhC61nkh8U/oVOj+e9CEtf/edD0IX9529bQyLWQXtXhI/2HEuCaHmJgBQuar6lGSYnkQp4bMkypWri3dSF+KYUy29DwWpyp/Xf0Hu83GFeNYMLRGBApf3nayTxL465YSxUF2hcopsOVSDec9XtlIuFqV04AXHwOrF8zLAOlK7boQDJG/7b5ZmrITSBdjh/haHQWwCom+KA0LXmktAIxMDR3E98pNFPkYqAtf48SKWrD6PNPbBO4q25KK8YpHtdeq00OAP4Pn6fFMXh73fleIF6etzRdeW6WNWGFTGkoSEbO5Vn2s2cMn/ek9sxdrLjRnc5cGi3Kq2ivrlAQ70YMcBaSRf8Of2PegdkMay1OaLcRuct10Xbp4k/VrDI6YgjH3sXz/aRJcP5+2Zx0G8kFdSZz7QHvZNCbNg+T33TODmouiC609u4fdTHkP9
Received-SPF: pass client-ip=57.103.77.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Not used anymore.
---
 target/i386/emulate/x86_decode.c | 6 +-----
 target/i386/emulate/x86_emu.h    | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 9faa65a579..bae1dd4d6f 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -77,11 +77,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         memcpy(&val, decode->stream->bytes + decode->len, size);
     } else {
         target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
-        if (emul_ops->fetch_instruction) {
-            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
-        } else {
-            x86_read_mem(env_cpu(env), &val, va, size);
-        }
+        x86_read_mem(env_cpu(env), &val, va, size);
     }
     decode->len += size;
 
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 3e485b8ca3..6b69111822 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -25,8 +25,6 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
-    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
-                              int bytes);
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
-- 
2.50.1 (Apple Git-155)


