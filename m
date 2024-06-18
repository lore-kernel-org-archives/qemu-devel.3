Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0971C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJU2O-0002Er-VY; Tue, 18 Jun 2024 04:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJU2N-0002EV-9F; Tue, 18 Jun 2024 04:17:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJU1z-0007aL-8j; Tue, 18 Jun 2024 04:17:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6v6lM024646;
 Tue, 18 Jun 2024 08:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=p
 4rG2YaqzrRIO+MMINsQ3D5buVJiWdOwd4tF3/5pfn4=; b=Zb5p2ybTcXxmmpqHS
 xOGf3Dl3xD74lRW3dhhhapDf96ABgLvXpUi1vvMWr5JiXeEXbFllS0iA5hIhKxgU
 vXZTkKRVKP/Q8scdD9hBaY4e/MwsgRzM9yK+hpTaHkCugSIVxTz8suacroDPbSsb
 WWKW0sJpIJgrRi5H1fEqDsDy0ehjpzvkHaBWzVSADIYWP1TfbPUpTtsxoOdMlJBz
 E3nUmflWBPuPwkTu5NVQZ+kcWGcVSax6o6wcVUO05jiskw9/PAY+YNUyASSZFJng
 lflhhQ6atdobVX/51Lup/tHeg+TQ95UcYzi10b0drYuouCbwCPL8ewKlndsKZc97
 NMORA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4jarbar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:17:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8H79W021541;
 Tue, 18 Jun 2024 08:17:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu4jarbag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:17:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I7B7EO023990; Tue, 18 Jun 2024 08:17:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9q161t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:17:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8Gtq546727628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:16:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 407F62004E;
 Tue, 18 Jun 2024 08:16:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5D3A20040;
 Tue, 18 Jun 2024 08:16:53 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:16:53 +0000 (GMT)
Message-ID: <326e17c7-ee1d-4f5d-9450-eba74ecd2110@linux.vnet.ibm.com>
Date: Tue, 18 Jun 2024 13:46:53 +0530
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
 <358b393d-7c43-4a28-b8da-8221df5031a5@linux.vnet.ibm.com>
 <76ba68c3-64ae-43dd-bed6-8312232b221c@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <76ba68c3-64ae-43dd-bed6-8312232b221c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RS6_MtzkqSuRfkQWVt1wNsDV9-qPBPPs
X-Proofpoint-GUID: j_QSGffaA6WZGssRlnB_IwWUj1KzmMEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=747 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180057
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



On 6/17/24 23:15, Richard Henderson wrote:
> On 6/17/24 03:40, Chinmay Rath wrote:
>> static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>> {
>>      TCGv EA;
>>      if (!ra) {
>>          return tcg_constant_tl(0);
>>      }
>>      if (NARROW_MODE(ctx)) {
>>          EA = tcg_temp_new();
>>          tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>>      } else {
>>          return cpu_gpr[ra];
>>      }
>>      return EA;
>> }
>>
>>> If you need to modify the resulting EA, then you also need to make a 
>>> copy for 0.
>>>
>> Hey, didn't properly get what you meant here.
>> Did you mean : Since I'm using a tcg_constant for 0, if the EA is to 
>> be modified later, this constant would be an issue, in which case, I 
>> should make a copy for it ??
>
> Yes.
>
>> Considering that, there are no tcg level modifications with this EA.
>
> Ok, good.
>
>
>> However, the underlying helper method, which considers this EA as a 
>> target_ulong type does modify it, which I don't think should be an 
>> issue.
>
> Correct, that's fine.
Awesome ! Thanks for the clarification.

Regards,
Chinmay
>
>
> r~
>


