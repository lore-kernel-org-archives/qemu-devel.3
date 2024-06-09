Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D9EC27C65
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNEN-0003kz-1r; Sun, 09 Jun 2024 14:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNEJ-0003kO-LQ; Sun, 09 Jun 2024 14:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNEH-00084r-DE; Sun, 09 Jun 2024 14:25:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459IO78I029900;
 Sun, 9 Jun 2024 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=b
 U0ckHiQLtQ3dFnfsuEhcu/IYhmcwWr2822zw1Hq1jg=; b=PtasDzIi9j13ApIpy
 XqCSAlW3gntk6suRTvCOYlHPUVaaoVQeBIEOEmY/SpfhAmp06nxh8PrM0LjdylZL
 C/hs0p/+x3QCoKfnovFPSQl0nmwuOkajd4ZG11/pzBfC88ArwH9tKXz2DUTGQIRI
 VY5Hm8puHtoql1TbjIKXdLq+NA2qaUD2ChXVch9qumY0/8lCp9Q0vYxMxH7HVklv
 aKTUG2Ccpioj3Y+Ek04Oruw1/HI6ESVuQUF0SiwQafbMLqM5HP1DBd/0HNU47ptD
 noI1eEJ5z/er2oGAwAYKFQRRzND3U+SHWF8PIVPse9LuVkjTivRRwmbUFhenLAS0
 Fdotw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynfkp0664-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:25:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 459IOvVg030710;
 Sun, 9 Jun 2024 18:25:18 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynfkp0663-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:25:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 459H5uWW008719; Sun, 9 Jun 2024 18:25:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b2twk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:25:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 459IPCTL28771070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Jun 2024 18:25:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D8162004E;
 Sun,  9 Jun 2024 18:25:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2454620040;
 Sun,  9 Jun 2024 18:25:10 +0000 (GMT)
Received: from [9.171.49.220] (unknown [9.171.49.220])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Jun 2024 18:25:09 +0000 (GMT)
Message-ID: <ff22f709-0c3d-4cf7-b88c-18adde978af1@linux.vnet.ibm.com>
Date: Sun, 9 Jun 2024 23:55:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/ppc: Move VSX vector storage access insns to
 decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-4-rathc@linux.ibm.com>
 <28ea359e-fdbf-4a4f-b004-19e558d8d96f@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <28ea359e-fdbf-4a4f-b004-19e558d8d96f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4_IxO5F73nNmtJr5joKgLpD1xapj8zuM
X-Proofpoint-GUID: ii1QwQC4qO2mRm1Q-C39JCKXYq_u4gOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=911 clxscore=1015 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406090145
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Richard,

On 6/7/24 21:16, Richard Henderson wrote:
> On 6/7/24 07:49, Chinmay Rath wrote:
>> Moving the following instructions to decodetree specification:
>>
>>    lxv{b16, d2, h8, w4, ds, ws}x   : X-form
>>    stxv{b16, d2, h8, w4}x          : X-form
>>
>> The changes were verified by validating that the tcg-ops generated 
>> for those
>> instructions remain the same, which were captured using the '-d 
>> in_asm,op' flag.
>>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   target/ppc/insn32.decode            |  10 ++
>>   target/ppc/translate/vsx-impl.c.inc | 199 ++++++++++++----------------
>>   target/ppc/translate/vsx-ops.c.inc  |  12 --
>>   3 files changed, 97 insertions(+), 124 deletions(-)
>
> Because the ops are identical,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> But you really should update these to use tcg_gen_qemu_ld/st_i128 with 
> the proper atomicity flags.  This will fix an existing bug...
>
^ Surely Richard, I have noted this suggestion of yours from an earlier 
patch, and plan to do this change and implement a few of your other 
suggestions,
     which I couldn't implement earlier, along with some clean-ups this 
week.
     I refrained from doing it with the decodetree movement, to take 
proper time to understand and test.

     Should send out those patches soon.

     Thanks & Regards,
     Chinmay
>> +static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
>>   {
>>       TCGv EA;
>>       TCGv_i64 t0;
>> +
>> +    REQUIRE_VSX(ctx);
>> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
>> +
>>       t0 = tcg_temp_new_i64();
>>       gen_set_access_type(ctx, ACCESS_INT);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>>       gen_qemu_ld64_i64(ctx, t0, EA);
>> +    set_cpu_vsr(a->rt, t0, true);
>
> where the vector register is partially modified ...
>
>>       tcg_gen_addi_tl(EA, EA, 8);
>>       gen_qemu_ld64_i64(ctx, t0, EA);
>
> before a fault from the second load is recognized.
> Similarly for stores leaving memory partially modified.
>
>
> r~
>
>


