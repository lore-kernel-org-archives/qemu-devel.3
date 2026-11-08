Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF9606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=C42BktnB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbO-0005Rf-9O; Sun, 08 Nov 2026 04:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbL-0005QJ-OL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:15 -0500
Received: from st-2004d-snip6-1.eps.apple.com ([2a01:b747:3001:201::22]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbJ-0005y5-3k
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:15 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 05B2518001B0; Sun, 08 Nov 2026 09:54:10 +0000 (UTC)
X-ICL-RepId: 01a1ba94-6968-7a61-8ffe-543f078cc272
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGB11UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131652; x=1825667652;
 bh=4MtoiGWVHD1ql7ktrdOMb3tf+OVOyyTmcQKxYtuN+0U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=C42BktnBF1H4yOGKcBlLQ1rjqNDg3cFVriUPF5W2fXoYkZBEGN2liSFZLrHM1USsXqDAco8/1Z5bcQ//8oEePhKOVc32QBrjLpi69YRTLwrST4yuMLe97P5drvDFoNDXORc3mB7RYQ3gtV3Wny80KCYhrovhkM54WiBD91oOW2+bw7g0cvsSUczfdIfvt/Lg/M5jszNqdJW56O7ABVXzHBaH+GASa5iXglz6r1Kjjyqdg+a+1fma6CqXGtUniJeaY9BmCIuqgBMBRDh3mBKicSUH3IDYaabhVp0o6FJn/n8Nda0blzBcNxG12daLOf9Yj6Abb7MsnOxLldWDmbF7Cw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 AF98718001AB; Sun, 08 Nov 2026 09:54:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/13] whpx: i386: fix TPR encodings for local APIC
Date: Sun,  8 Nov 2026 02:53:54 -0700
Message-ID: <20261108095403.70813-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x0eHnRvj53dfMqTLR-U6etD5SUVSEiuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfXykFQs0SKfIYN
 0BaYwAuDM2KXxilGTFjfsLooJ5Tp7y5L+L93q2uQzCVZEBlB5wCtGMvA6aIS+W9RxflqS37JkqD
 lASVlfbtJMBVf6QMPkvSD28BOCNDSJJN0hK93DpxTHY18hKDJX4hxf82lH7Rl/ZudT8wN9HblMN
 JDVx2F/XtGQFcfoROHiVKu2oOdlzkjM7sRaFdfHJglnlPc88lXaryfCpL5DeSvej/GW6/ttm26m
 3sj+mta0TVBZbctTdhhBNjRU5te0+CYOHI5qUoZZZ+OBIWczzXm1U/ce7H6NMiWOqtsblno82+r
 j/eYOnYjOf4S5sQgMBskOXMDeUDkkXqOk0l1Ry2Tj75Seyye3ZTBKtpqIL7d2Q=
X-Authority-Info-Out: v=2.4 cv=Kd3fcAYD c=1 sm=1 tr=0 ts=6af046c3
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YYz-tg3MKeN3tcD12NcA:9
X-Proofpoint-ORIG-GUID: x0eHnRvj53dfMqTLR-U6etD5SUVSEiuM
X-JNJ: AAAAAAAB+KctSMk3TkWdEY382X/1hfoBBLn5F8X05tuNB9UeSRYjsTpdMISiwyjrdDaWyO
 3NO+RuaCUKQfYZlfdo2JJXeeUDDQ5+VTGhIE413Xwr+D9+OpOM0HRe/iP67VeWtYHu3LEk
 fIpnErpnmrU8mOOYsvGvkUzgL0ibOxT3jh9/VBxZuHOVfcCau5g5kh5AuyTbYhzZ58IG8H
 p7v4V22CnQUcgdpgMcbITULntI9e+/1YRroqILKY2x5h7o8xEA20lZxMxkGEM02mH0xftO
 4yda1GlgNc3rZiCjCwpCA6F9ytVEewRNdpqku2yXj5YuVX/z3yfAoOb6TXyADTkF2tgX3K
 YGtd7rMNcGzU0ZzKeovQW0cdvVssefGCnEvBowyIew4sFZKyYf96ExTOo+pbJYKKjiDY2J
 1w20oJpgpJmU9ZwXWyy3nzOygj2NVpQpVJ9FjftLYoQXddqkqp1KolgHfbFtU2HRd4zQZe
 x+YeFSxGuYl4BmkUOXaguaEF9W8dX1aWlEcANOSDz5+VJTi24HFe2LGxRC5lKKTQEiYbXQ
 FjRiBYjsHTs0QfcWAwBfozUTFVGb9PoltBZsiVtSkgLodXEWbECapwBNct9uB9gqe25n9r
 IzRSZA5jD+5hT0vIWKjrMjqgJED9e65uE5SfTfISlv84HYzXMibee0LH3Mf2EUc11U3gOM
 BynIxfV4s6liDA0wYelDeM/DXZHhbLYvAZnLHa47RPARMhPXgx6e6RuHCVPDMVCn+TDie3
 Aqe41C9za9+K2McxSBblyYsp6tH1JL9YXbLpDJqNp6usbzs2ueSWgJnkDIpeF7v4s=
Received-SPF: pass client-ip=2a01:b747:3001:201::22;
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

Convert between the TPR and the APIC priority encodings.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index efdedbcd77..2d83291fae 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -184,12 +184,12 @@ static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
 
 static void whpx_apic_set_tpr(APICCommonState *s, uint8_t val)
 {
-    s->tpr = val;
+    s->tpr = (val & APIC_PR_SUB_CLASS) << APIC_PR_CLASS_SHIFT;
 }
 
 static uint8_t whpx_apic_get_tpr(APICCommonState *s)
 {
-    return s->tpr;
+    return s->tpr >> APIC_PR_CLASS_SHIFT;
 }
 
 static void whpx_apic_vapic_base_update(APICCommonState *s)
-- 
2.54.0 (Apple Git-157)


