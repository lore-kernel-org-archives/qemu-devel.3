Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0B0C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpkX3-0004gC-CI; Fri, 31 Jul 2026 06:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangziliang@kylinos.cn>)
 id 1wpkX0-0004fx-3V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:31:58 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangziliang@kylinos.cn>)
 id 1wpkWu-0003Ux-Tv
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:31:57 -0400
X-UUID: fff52cb68cca11f1aa26b74ffac11d73-20260731
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_7B, HR_CTT_TXT
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME,
 HR_SJ_DIGIT_LEN
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
 SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED
 SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
 CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI
 GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_GENE_RDNS
X-CID-CACHE: Type:Local,Time:202607311826+08,HitQuantity:1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:be70ccd9-e0c1-44d2-ad59-00a692c67920, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-50,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-40
X-CID-INFO: VERSION:1.3.12, REQID:be70ccd9-e0c1-44d2-ad59-00a692c67920, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-50,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-40
X-CID-META: VersionHash:e7bac3a, CLOUDID:2c8ceb97c63d13f17e22cfb92eda89b5,
 BulkI
 D:260727172240XGTNJ6XB,BulkQuantity:2,Recheck:0,SF:13|19|66|72|78|102|127|
 307|315|316|324|342|347|350|351|841|850|865|898|10053|15053|20039|25002|26
 021,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:n
 il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_RUA,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fff52cb68cca11f1aa26b74ffac11d73-20260731
X-User: wangziliang@kylinos.cn
Received: from [127.0.0.1] [(171.8.192.163)] by mailgw.kylinos.cn
 (envelope-from <wangziliang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 793463269; Fri, 31 Jul 2026 18:31:33 +0800
From: Wang Ziliang <wangziliang@kylinos.cn>
Date: Fri, 31 Jul 2026 18:30:55 +0800
Subject: [PATCH] target/i386: helper_wrmsr()/helper_rdmsr(): Raise #GP(0)
 when accessing unimplemented MSRs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-unimplemented-msrs-v1-1-926b562aa704@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAF55bGoC/x3MOwqAMBBF0a3I1AZMghHcilj4eeqAiZJREcS9G
 yxPce9DgsgQqrOHIi4W3kKCzjMali7MUDwmkymMKyqr1RnY7ys8woFReYmitK2cKd0A04NSuEd
 MfP/Tpn3fD5gySL9kAAAA
X-Change-ID: 20260731-unimplemented-msrs-1376256ce2be
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Andrey Polivoda <apolivodaa433@gmail.com>, 
 Wang Ziliang <wangziliang@kylinos.cn>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=wangziliang@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

According to intel SDM and AMD manual, RDMSR and WRMSR instructions should
raise #GP(0) exception if a reserved or unimplemented MSR is specified in ECX.

Currently, both helper_rdmsr and helper_wrmsr functions simply ignore
unimplemented MSRs, so the behavior of these functions
needs to be modified in such cases.

Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Andrey Polivoda <apolivodaa433@gmail.com>
Fixes: 3c1cf9fa8659 ("dummy rdmsr and wrmsr support - xor reg, reg optimization")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3218
Signed-off-by: Wang Ziliang <wangziliang@kylinos.cn>
---
 target/i386/tcg/system/misc_helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 2998b1aae752c31a487b84dc6c303aac98b9be47..9ac5e167cc3c1a8b2cada34a1388221cde29aeaf 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -309,6 +309,7 @@ void helper_wrmsr(CPUX86State *env)
         break;
     }
     default:
+        /* Machine Check MSRs */
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
             (4 * env->mcg_cap & 0xff)) {
@@ -319,8 +320,8 @@ void helper_wrmsr(CPUX86State *env)
             }
             break;
         }
-        /* XXX: exception? */
-        break;
+        /* Unimplemented MSRs */
+        goto error;
     }
     return;
 error:
@@ -487,6 +488,7 @@ void helper_rdmsr(CPUX86State *env)
         break;
     }
     default:
+        /* Machine Check MSRs */
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
             (4 * env->mcg_cap & 0xff)) {
@@ -494,9 +496,8 @@ void helper_rdmsr(CPUX86State *env)
             val = env->mce_banks[offset];
             break;
         }
-        /* XXX: exception? */
-        val = 0;
-        break;
+        /* Unimplemented MSRs */
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
     }
     env->regs[R_EAX] = (uint32_t)(val);
     env->regs[R_EDX] = (uint32_t)(val >> 32);

---
base-commit: 0345ef676befc1a180d2f63bceaf3fca1d07ee88
change-id: 20260731-unimplemented-msrs-1376256ce2be

Best regards,
-- 
Wang Ziliang <wangziliang@kylinos.cn>


