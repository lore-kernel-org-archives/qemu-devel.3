Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F1BCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKUB-0003hw-J6; Wed, 27 May 2026 16:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSKU3-0003gk-Vl
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:04:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSKU0-0000l2-C5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:04:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RHX7FG1574202
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 20:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JS/LEa6gfD4
 DUFFTnfcGueUYqBiQXNELuv5Iu0pn34M=; b=AKBs9uHSthVxOqVYgRtFeCBzq2Y
 Ew2lfp/kT26UpNJIbu9AEsoZODP83yZ4n2pAjsATTQmDbwl/snLGR4tt+24ormIg
 GVz9LfW3A547qmkKAS2dDqPsfGc4o7GCt4sQpUQw2yyRp8CLkzqfsRCr3ii900Jx
 38BKUGc6v9HQbHx3/6ljQ/O7VnvJUYGfoQzbHt9jeZ70L0QLvz0/Q4GdJGCMvG/V
 KCOCestQgOV9JH1KSRNPG+r+958HT/SzYInELbfyj63wEDuAmz+WCUmx3kiXXq9J
 PBifGn7m7FBpptu3H/t7VDeWLpyWELcOnB1ml66fm9kVe2qlZvFMQ6qAj7g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxvpj5ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 20:04:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50fb3403e99so73951741cf.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779912242; x=1780517042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JS/LEa6gfD4DUFFTnfcGueUYqBiQXNELuv5Iu0pn34M=;
 b=eV/SYvC3EIk4mC2ZDqtUqwQE6xAj6b8n3WBmptgvBHZoXmQW34seFWji3Bf/mbFINX
 IVIjgujJgBzBDNl+9j1GTmf9LrfNKirK/6l+aCkh1K+7JNb8putfZ7frsfSiwGO49czu
 6klcGevgDXdnWgYlPThnhqX8Vx7BF4WZxDJfGsJVYzcfUzvXieik9zMkeIuVqw0IeH1h
 m0c9LWueHv0EZ//qv9HpJpa9Bc/KJW1KGeoP/5Q0FN2CGCxtg71RiJ7x3b7I6/jc4hTo
 fiKjIWllsHiazXfhJ5xgDROJXCXXKtUnbQdZSDYbJ0JtF9U0p0FgFUeJviCMxB1xliVm
 TFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912242; x=1780517042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JS/LEa6gfD4DUFFTnfcGueUYqBiQXNELuv5Iu0pn34M=;
 b=K6BenS9OnSN9bfHoJn9GpPw13//ZYckiE2bHHOo2kde8/1ekSqvw2tmDz5mEiWDVkP
 +BdfGJ8WgvCB5PzZJvZEGNbVUZsOdMziobr0nqGIm9/oMtAtt7T8gscvKSrZtGTbepaB
 64zta5cEpBgwsTbn2CHUrET9cf6wXCghoY/9oTljuEayUmdXuDJnXwxs8MSvVAAkfDJD
 FUWwfIUPdeLYEKc2Zd6bOOx3Q57QdewrgXyz+uce7xambqmkbwFCqTuAqRCGY2fOoFj0
 DeQm7BjJIORjGv8fg6Byv3XcQdX/p9CUvln/HkkbEt+TztcXFtm+2cwwahEWUSkGnCOQ
 AX5Q==
X-Gm-Message-State: AOJu0YweWf9xem+c/sXmV7DvnmQeRa67b8Mxi7NxVvgrj+5YoWXcAxfF
 4T71k1pS0T17sB8b2ULLX4NEcFYtQmB+jMl8dHbK3fGXHhjiNGVPxmxEtCPF70XqWON/JgAQd07
 NsfR7LZDuIwSccEOo3nK5f/f6mmBHiKQ9Dg8wIa5WNgWzjB0lnUdUVwsWXdFowqR6KA==
X-Gm-Gg: Acq92OF4g5UaSu0nvPxSgthW5Yx2F7AiWBD90YvKeINf7wAjXrmTn/EMG8ynXGNSoWY
 UVWJTAsITpPIHtqPBtEWJFK5WJ3lm93nwP9K3bNspPNEJUvb8CPFHFv4ERKRpumyqea4p0loZ6P
 3VnO5QkpEsiy8bGkZRizBVfkwHbX8QJ4B9EsPkbFCwx3MYO6Ly+S6+g3MjuDJkPpYDwl7iM5E4c
 ZX64+3vVlur4Enna/NiK5FoxQKte5LkPWroIQ3/R2+sM+PQNT0gV1cFz2/dKkRG/MQwU1uu0k5z
 4r7LDuJ5y6656XjVNUpybhQf2q5CdCli2A7cghwkhTVGhy+bjCzI2hMISYjWPqW9JgIwgM1LD2W
 8DFjsb6RtnSp93F9d8IYQ0j9UvcpSQAT8KS1r5jCgcWrdLIdcy3nysRylsT0L0u5Htzrx+A==
X-Received: by 2002:ac8:5cd5:0:b0:509:2b02:c1bd with SMTP id
 d75a77b69052e-516d442805fmr361157241cf.12.1779912242227; 
 Wed, 27 May 2026 13:04:02 -0700 (PDT)
X-Received: by 2002:ac8:5cd5:0:b0:509:2b02:c1bd with SMTP id
 d75a77b69052e-516d442805fmr361156701cf.12.1779912241770; 
 Wed, 27 May 2026 13:04:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517069f2464sm52069441cf.2.2026.05.27.13.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 13:04:01 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 1/1] disas/riscv.c: fix inst_length()
Date: Wed, 27 May 2026 17:03:55 -0300
Message-ID: <20260527200355.2068879-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
References: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIwMCBTYWx0ZWRfX/IDu5xYMwYrc
 9yLn0ohsb0gcinxlw8gAFvW3XM8ItnXyfS0dphwyT/hjIffkuHE2SUwzZq4ige5wfx7PypgIv/P
 EwBxeey5muiFNwzVA8RALoDJMTdXx4uX2KfgXECNoNlV0xPZ4ZGH4VFTGTY5sxvsTgD3sbaExhB
 tXz/ziSazp5G96B3EKof5E1wpWWtc+o1fnzqz/2b27HVph0KRy3mNFTp/YdIAyCf7kR1wQgt4BN
 KTvehOWB2hVc6rs4fBjUcy4MddZVon7WGimZWuhw0fLTkCN+2/8rO0aWBq+x+5kOtoOgHTznRpy
 ASbFTF2x0LFTSOwhxANe211hgSD4pf7o+ceG84gvjaRLP99NEQEnxJveu2T2JGO/c9oYjUN3D9M
 LyYqjFZSt92b23p4sdz5ZArtGs8QHAjWrDspnyuKP85kxQp8ciA3KUxBBFd2oz5OMv6XUSP4FwL
 AfvK1fYSk7VhzfSNfLg==
X-Proofpoint-GUID: mHCatsiJap48TaMLTCaFCdpZllur6BIa
X-Proofpoint-ORIG-GUID: mHCatsiJap48TaMLTCaFCdpZllur6BIa
X-Authority-Analysis: v=2.4 cv=VqoTxe2n c=1 sm=1 tr=0 ts=6a174e32 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=B_Bt5t653FmGCJzbuxMA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

inst_length() can return 0 if 'inst' happens to not match any known
encoding (like [1]).  Returning 0 is not desirable, even for unknown
encodings, given that it will cause a loop in target_disas() later on.

The most recent version of the RISC-V unpriv spec ditched the
sophisticated instruction-length encoding.  We're now supporting only
16-bit and 32-bit length instructions, where:

"All the 32-bit instructions in the base ISA have their lowest two bits
set to 11.  The optional compressed 16-bit instruction-set extensions
have their lowest two bits equal to 00, 01, or 10."

So the code is now simpler, never returning 0, and in fact it's the same
thing we're already doing in insn_len() from target/riscv/internals.h.
Due to include shenarigans we can't use that function in disas/riscv.c,
but I believe we can cut ourselves some slack this time and not lose
sleep over a 1 line of duplicated logic.  We're documenting it though!

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3479

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..fbdb24fcea 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5057,26 +5057,10 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
     return true;
 }
 
-/* instruction length */
-
+/* Same as insn_len() from target/riscv/internals.h */
 static size_t inst_length(rv_inst inst)
 {
-    /* NOTE: supports maximum instruction size of 64-bits */
-
-    /*
-     * instruction length coding
-     *
-     *      aa - 16 bit aa != 11
-     *   bbb11 - 32 bit bbb != 111
-     *  011111 - 48 bit
-     * 0111111 - 64 bit
-     */
-
-    return (inst &      0b11) != 0b11      ? 2
-         : (inst &   0b11100) != 0b11100   ? 4
-         : (inst &  0b111111) == 0b011111  ? 6
-         : (inst & 0b1111111) == 0b0111111 ? 8
-         : 0;
+    return (inst & 3) == 3 ? 4 : 2;
 }
 
 /* format instruction */
-- 
2.43.0


