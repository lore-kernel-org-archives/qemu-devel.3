Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E59C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJU4r-0003Iy-At; Tue, 18 Jun 2024 04:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJU4q-0003IZ-5l; Tue, 18 Jun 2024 04:20:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJU4U-0007u1-Gb; Tue, 18 Jun 2024 04:20:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I75YIA029476;
 Tue, 18 Jun 2024 08:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
 3BaxC2uAfWIIJMv4rQdaKwNRRdQxZcKJEOSPQns5Ko=; b=eez0h61/j1PFMO3qv
 hOushOubXyX9oDbt025eTlhGSbcwfBY+4NKbXTrfbkTWMWotP98u6EXPS7kitnuj
 F4qPJrjvn9LCfbC37CGE//a/ejZSZejjxoPMzcvAMb5SFjxvqvmknkln641+DmWE
 fkFDfAdNUh8vPT8a4bHDu0zT5JVqSLMghtT0mfzfIQpW/SHnHfRyOgLjWkdXpTdN
 6opLl4VzzwAUBXNckcrWHxW5j8P4bI4Qsd8dMzPdL0QHUvBzyQ4DFRJnHLB3kciM
 zSipbkiX40anx4Q/nf1OUVkNkBIJkxYKeaHEc/gPs5gn6TpFMtEmmZS1d2O84U7Z
 BCZcg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4ja8ar0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:19:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8JloL017858;
 Tue, 18 Jun 2024 08:19:47 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4ja8aqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:19:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I7nP2r009422; Tue, 18 Jun 2024 08:19:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgmgv14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:19:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8Jfr456557934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:19:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8802B20043;
 Tue, 18 Jun 2024 08:19:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E6502004D;
 Tue, 18 Jun 2024 08:19:40 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:19:40 +0000 (GMT)
Message-ID: <46f033b8-a94c-4479-a9ae-8e8edcbf127d@linux.vnet.ibm.com>
Date: Tue, 18 Jun 2024 13:49:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240613093318.314913-1-rathc@linux.ibm.com>
 <20240613093318.314913-3-rathc@linux.ibm.com>
 <6638b813-f4ef-4587-b94f-3c24d90ca09e@linaro.org>
 <94d97af2-62e2-4fde-909b-c57af8ef814f@linux.vnet.ibm.com>
 <a50d339b-d44a-41c1-bb28-82eb761771a1@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <a50d339b-d44a-41c1-bb28-82eb761771a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dYQhDw3TEsLwooFpZwcQzWHUi_5x33Do
X-Proofpoint-ORIG-GUID: eiQwhnKdObQ-COoIrTDIUrDB_a7cn9Az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406180057
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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



On 6/17/24 23:27, Richard Henderson wrote:
> On 6/17/24 04:51, Chinmay Rath wrote:
>>
>>
>> Hi Richard,
>> On 6/17/24 00:43, Richard Henderson wrote:
>>> On 6/13/24 02:33, Chinmay Rath wrote:
>>>> +/* EA <- (ra == 0) ? 0 : GPR[ra] */
>>>> +static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>>>> +{
>>>> +    TCGv EA;
>>>> +    if (!ra) {
>>>> +        EA = tcg_constant_tl(0);
>>>> +        return EA;
>>>> +    }
>>>> +    EA = tcg_temp_new();
>>>> +    if (NARROW_MODE(ctx)) {
>>>> +        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>>>> +    } else {
>>>> +        tcg_gen_mov_tl(EA, cpu_gpr[ra]);
>>>
>>> Why are you making a copy, rather than just returning cpu_gpr[ra]?
>>> If you need to modify the resulting EA, then you also need to make a 
>>> copy for 0.
>>>
>> Please ignore my previous response.
>> I think do_ea_calc_ra should allow modification to the resulting EA, 
>> hence below change appears more appropriate to me :
>>
>> /* EA <- (ra == 0) ? 0 : GPR[ra] */
>> static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>> {
>>      TCGv EA = tcg_temp_new();
>>      if (!ra) {
>>          tcg_gen_movi_tl(EA, 0);
>>          return EA;
>>      }
>>      if (NARROW_MODE(ctx)) {
>>          tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>>      } else {
>>          tcg_gen_mov_tl(EA, cpu_gpr[ra]);
>>      }
>>      return EA;
>> }
>
> If that's what's needed by the callers of do_ea_calc_ra, then yes.
> You can drop the first return EA and use else if instead.
Sure.
I shall stick to keeping EA modifiable, (even though it is not modified 
by the callers in this patch),
to allow its proper usage by (p){lx, stx}vp insns in future.

Thanks & Regards,
Chinmay
>
>
> r~


