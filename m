Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DDC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCBE-0005Cx-MD; Wed, 26 Aug 2026 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCBD-0005BL-Kg; Wed, 26 Aug 2026 07:52:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzCBC-0003tt-2r; Wed, 26 Aug 2026 07:52:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAWRb02615729; Wed, 26 Aug 2026 11:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=QmRZc1gAcWITvcuX4Ds8B8Gcy0271J
 Q4UGe94nNJ8YI=; b=fr3Xc1GJgUy8IMKrKd6YgeF59LiNxIKHpxfq67SSfBp/R5
 7nGUdoIDzg0VuwigFsQlEyxEbDEdSINzuPHQD0jyx2vcrXsCdc0aAqu+9CvLBmgq
 /ztTdSVePjPERxzQ1wuJm/GYANRgEMSfpv2eonMuFD5p4WNIYM/f2uJp3gv+vxtR
 QoEjvKcOxgwwyIlcWmzP4hYmQLoyTozRTevYOmKfTg0lkq5p61hUBK3ScY8KVSYn
 sZ0fpICGZOaG+05F5BB3frXdOomGNii7KC6FIb/TYlN6ngUIP5T3qpS7KwqdEn4P
 Y2PhjrHFXv/U/dKKL1tks0ILHo5jv07gCToFS+cQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726epae7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:52:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QBfPkp009755;
 Wed, 26 Aug 2026 11:52:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9fk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 11:52:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QBqNYo34931146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 11:52:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E84D20043;
 Wed, 26 Aug 2026 11:52:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E75DC20040;
 Wed, 26 Aug 2026 11:52:19 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 11:52:19 +0000 (GMT)
Date: Wed, 26 Aug 2026 17:22:22 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 09/37] target/ppc: Convert mcrf to decode tree
Message-ID: <20260826172132.2c76bd2e-19-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-10-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-10-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ed37c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=rYngLhrirbw-PHEOdeQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5NiBTYWx0ZWRfX4cY3GjTsRrIc
 ZUTznJ//HLo6QxL4ibSUZ+OA7Kn+TTSlIE5RATLd1srIa5aXjOGTaQIZ0bvjgbpD85yfTu24jdA
 8bM57PZPXNnVaUAV2pOOeshk0P9Mt1U=
X-Proofpoint-GUID: IBQ3BFmpDsGVE0effgwFFbJ6NERz3TkN
X-Proofpoint-ORIG-GUID: Gv10q6ModiNXSEH0Vs1IyXGh1jgAHe4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5NiBTYWx0ZWRfX4tXTZHBzONht
 fy6RtdCZZOoBvwtMkQPfTNBysiR6n/7GFbTK2Q7jWif43inGJngD6jc0Ca30HTO8SKF1/+i2FwS
 D3Bu0Mie3/94aXS5l6kePogjc3djryF4kNwAzb/Og9W5G1vH8D55N1NFcojFOO048JNEDLoPghn
 DOSbI8YW94yDSqs3joIhhlymj132hRaLHLm2igjQ1S8Qc3jYy456mt+ch2FhEy4yxUZ4yad7xC3
 bAPitxrgAMaebnoZQ3reZD4rYf4BPeD7IJqHg5k+xsCfRLTAgxUR6SQp8GVBHC3s7l2HRYrqbCX
 CXxTLAv6vViWg7vsec7qwjASVry/Ct54fWDurDBis2ZyAjBYJijRRzdt/rTdzKclyq3zisxyB/4
 5XYF+MMDPnY0AwpR+lxKKslqVCxN0sMtQT3r2GeC59BwTIqhszTI5Ac51xZF2OsVR0SJJ40RVB3
 QrlL+kKXOjDVwsjaELQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260096
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> From: Shivani Nittor <shivani@linux.ibm.com>
> 
> Convert mcrf to decode tree specification.The functionality

minor: s/The/ The/

> was tested by comparing the qemu -D log -d op,in_asm output
> as well as single stepping gdb.
> 
> Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/insn32.decode             | 6 ++++++
>  target/ppc/translate.c               | 7 -------
>  target/ppc/translate/misc-impl.c.inc | 6 ++++++
>  3 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index af35a44223..7d792d2318 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1455,6 +1455,12 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
>  SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
>  EIEIO           011111 ----- ----- ----- 1101010110 -
>  
> +# Condition Register Field Instruction
> +
> +&XL_bfa         bf bfa
> +@XL_bfa         ...... bf:3 .. bfa:3 .. ..... ..... ..... .
> +MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
> +
>  # Branch History Rolling Buffer (BHRB) Instructions
>  
>  &XFX_bhrbe      rt bhrbe
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f00071aa91..55b515cec7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3642,12 +3642,6 @@ GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
>  /* crxor */
>  GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
>  
> -/* mcrf */
> -static void gen_mcrf(DisasContext *ctx)
> -{
> -    tcg_gen_mov_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfS(ctx->opcode)]);
> -}
> -
>  /***                           System linkage                              ***/
>  
>  /* rfi (supervisor only) */
> @@ -5722,7 +5716,6 @@ GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
>  GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
>  GEN_HANDLER_E(bctar, 0x13, 0x10, 0x11, 0x0000E000, PPC_NONE, PPC2_BCTAR_ISA207),
> -GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
>  GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
> index cbf82b1ea0..890fbb209e 100644
> --- a/target/ppc/translate/misc-impl.c.inc
> +++ b/target/ppc/translate/misc-impl.c.inc
> @@ -155,3 +155,9 @@ static bool trans_ATTN(DisasContext *ctx, arg_ATTN *a)
>      return false;
>  #endif
>  }
> +
> +static bool trans_MCRF(DisasContext *ctx, arg_MCRF *a)
> +{
> +    tcg_gen_mov_i32(cpu_crf[a->bf], cpu_crf[a->bfa]);
> +    return true;
> +}
> -- 
> 2.55.0
> 

