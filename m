Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228AAC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9mv-00007E-Sn; Mon, 17 Jun 2024 06:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJ9mu-00006f-3u; Mon, 17 Jun 2024 06:40:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sJ9mr-0002v7-QS; Mon, 17 Jun 2024 06:40:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAM6fR006872;
 Mon, 17 Jun 2024 10:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=I
 if0/jIeBhoDxdaPq3MPJ0x/PDF8IpTg33GN8IVNyUo=; b=kYf+HrPFORsgXs+Fm
 XeDcBgpwPjwosGyNcNkdnTF0eWXwDFr3yuHO4vmKFCa00T7bn3YV/yJSfpjq3ZiU
 sTqmy++hYfFZtdhNY5IyQMLUizneXHGmzGL/mNsW+d7VPsWQgI1am6ZCsmb/Enrc
 MbieYbR81Q68w61MWQQuqRZR4LNg0z3b0gc7tOItRekyPuAH1/BiY8XWP7ZY3x1s
 OXUYLNbMbAU4gM35W/V0pzkC3Wji2eW8AkwT9Ma7fALtzQL9WFCNJ+gVdcgKHH9W
 QDTdb2sQpViNz3rDWxt32eY2iLTl3ZpyQMkSF85jKids9yMmMctRvY1fxLrldABF
 T6CIg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yth7jgbxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:40:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HAeSWV001519;
 Mon, 17 Jun 2024 10:40:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yth7jgbxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:40:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45H9GxMc019670; Mon, 17 Jun 2024 10:40:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0sba8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:40:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HAeLsf46858660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 10:40:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DEF920043;
 Mon, 17 Jun 2024 10:40:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3826F20040;
 Mon, 17 Jun 2024 10:40:19 +0000 (GMT)
Received: from [9.179.24.169] (unknown [9.179.24.169])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 10:40:18 +0000 (GMT)
Message-ID: <358b393d-7c43-4a28-b8da-8221df5031a5@linux.vnet.ibm.com>
Date: Mon, 17 Jun 2024 16:10:17 +0530
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
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <6638b813-f4ef-4587-b94f-3c24d90ca09e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ujcveigVstEZJZH58W7hqzrRsFzQHLss
X-Proofpoint-ORIG-GUID: qIY-kiPwH97opVhf9n6JPqsTOvLLe7H7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=764
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170076
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

On 6/17/24 00:43, Richard Henderson wrote:
> On 6/13/24 02:33, Chinmay Rath wrote:
>> +/* EA <- (ra == 0) ? 0 : GPR[ra] */
>> +static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>> +{
>> +    TCGv EA;
>> +    if (!ra) {
>> +        EA = tcg_constant_tl(0);
>> +        return EA;
>> +    }
>> +    EA = tcg_temp_new();
>> +    if (NARROW_MODE(ctx)) {
>> +        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>> +    } else {
>> +        tcg_gen_mov_tl(EA, cpu_gpr[ra]);
>
> Why are you making a copy, rather than just returning cpu_gpr[ra]?
True, this tcg move is redundant. Was carried away to maintain 
uniformity with the original do_ea_calc function. My bad!

This can rather just be :
/* ea <- (ra == 0) ? 0 : GPR[ra] */
static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
{
     TCGv EA;
     if (!ra) {
         return tcg_constant_tl(0);
     }
     if (NARROW_MODE(ctx)) {
         EA = tcg_temp_new();
         tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
     } else {
         return cpu_gpr[ra];
     }
     return EA;
}

> If you need to modify the resulting EA, then you also need to make a 
> copy for 0.
>
Hey, didn't properly get what you meant here.
Did you mean : Since I'm using a tcg_constant for 0, if the EA is to be 
modified later, this constant would be an issue, in which case, I should 
make a copy for it ??

Considering that, there are no tcg level modifications with this EA. 
However, the underlying helper method, which considers this EA as a 
target_ulong type does modify it, which I don't think should be an issue.

Please let me know if I missed something.

Thanks & Regards,
Chinmay
> r~
>


