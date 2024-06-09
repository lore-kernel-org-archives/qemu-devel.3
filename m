Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A6C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNPH-0000hE-Kr; Sun, 09 Jun 2024 14:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNPF-0000gG-E0; Sun, 09 Jun 2024 14:36:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNPD-00020u-Cp; Sun, 09 Jun 2024 14:36:41 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459IR9eg031635;
 Sun, 9 Jun 2024 18:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=M
 Y7YFpoIG1Q0Q4gPYMk69h17oUzHNsqwttRhK8/7L2Y=; b=kLoZ0FVqB3a614gja
 uxseaAGP/kr99Lkb2z6r0v9dWD2qDEldUEgbNBpwyQyxeaxMUHyd2gESxXoxshEo
 /kwverYxxczs3N5FYacJnB/mEdg3eVaRgzV5X6DmXEygaWMwN2leV76QvcjfIzF2
 ikuOng/HpcFRgYGE/FhqLkwnEFBcBbe8RfTRD3FWnYmaKffVaR581zZTBABkDcI6
 b0LDmPv7XDNJasdWbneNrujMEp+nl8US9t48hbxPi6x/D3FZPe7tD0mkeyBi6c2l
 zVbW+lQjNkViPFW7w6y0L8snPihQ2nw1aoAfUgsHA8tO1r3MBZs0MYoS27GDPt1d
 wnmGw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yngcpr4uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:36:35 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 459IaZtb012555;
 Sun, 9 Jun 2024 18:36:35 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yngcpr4ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:36:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 459HpmgN028716; Sun, 9 Jun 2024 18:36:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mtunn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:36:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 459IaSCL53150046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Jun 2024 18:36:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E045320043;
 Sun,  9 Jun 2024 18:36:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A316020040;
 Sun,  9 Jun 2024 18:36:26 +0000 (GMT)
Received: from [9.171.49.220] (unknown [9.171.49.220])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Jun 2024 18:36:26 +0000 (GMT)
Message-ID: <6cd07c61-82f9-48ac-bbeb-57ead4ed126b@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2024 00:06:25 +0530
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
X-Proofpoint-ORIG-GUID: yF7i-ADFXNZE8tRozHC4ijwqvJUvGEkc
X-Proofpoint-GUID: b0TNSorzclPH38p_AxYYjSLKszQzWMTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406090145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
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

My apologies for the ill formatted reply in this patch series. Just 
realized it now. The cliched 'Tab' issue with the mail client XD.
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
^
Surely Richard, I have noted this suggestion from earlier patch and plan 
to do this, and a few others which I couldn't implement earlier, along 
with some clean-ups this week.

I refrained from doing it with the decodetree movement, to take time to 
properly understand and test. Should send out those patches soon.

Thanks & Regards,
Chinmay
>
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


