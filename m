Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A72C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGN0m-0006a7-95; Sun, 09 Jun 2024 14:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGN0j-0006ZB-3e; Sun, 09 Jun 2024 14:11:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGN0h-0005g9-2L; Sun, 09 Jun 2024 14:11:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459HvdsX021589;
 Sun, 9 Jun 2024 18:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=k
 S0OgA1WV6qQTgqDIja3tD6mv69tsPjOplogpJ05p8A=; b=dseOpxPKrmB4bta28
 LnJtXtpAnXOgQKF76waSs9pSZv8YWYknG8fanT+PN5n/Da60Lgvip8sI7j7ugpIe
 OYXv2PPWTxOTfBv9uL5aQjWL9PTBKHyj/4l1qoxw3wNuuT2G6BhNqEwKjRS9Kg0W
 y8NpdsZW+MOlZFqgavtebNdaKgljvlBqEBwnOv8eG1lC1BQtC7sGrMwbVoXKOpcg
 BFxc/7gGkp92+8ywdI7StPYmkatS9lLcmuomld+/Juimwn8BIOg34v3vrPH9n6co
 Q1h6lOAV3wdYoY4wdODiQw7Rju+4hwIFgfXFXQAwNK4DRXQfsOIbiMkQvtpBhPk8
 T9VZA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynh8br111-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:11:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 459IBENw010168;
 Sun, 9 Jun 2024 18:11:14 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynh8br110-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:11:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 459H5pRK008716; Sun, 9 Jun 2024 18:11:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b2tv8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:11:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 459IB85c52560252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Jun 2024 18:11:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79AB020040;
 Sun,  9 Jun 2024 18:11:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3662820049;
 Sun,  9 Jun 2024 18:11:06 +0000 (GMT)
Received: from [9.171.49.220] (unknown [9.171.49.220])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Jun 2024 18:11:05 +0000 (GMT)
Message-ID: <d027b594-6fcc-49f6-a179-25b479be2be7@linux.vnet.ibm.com>
Date: Sun, 9 Jun 2024 23:41:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-3-rathc@linux.ibm.com>
 <91e78fa4-f844-4b79-ba09-46c722f35df8@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <91e78fa4-f844-4b79-ba09-46c722f35df8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k6aoxcLzTrbrpBLobzaCOJlT3IvOCwmp
X-Proofpoint-GUID: UU52eo8CIHOHQaUiuQ_oeJwA8Z95yQLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1011
 mlxlogscore=705 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406090141
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

On 6/7/24 21:11, Richard Henderson wrote:
> On 6/7/24 07:49, Chinmay Rath wrote:
>> +static bool do_ld_st_vl(DisasContext *ctx, arg_X *a,
>> +                        void (*helper)(TCGv_ptr, TCGv, TCGv_ptr, TCGv))
>> +{
>> +    TCGv EA;
>> +    TCGv_ptr xt;
>> +    if (a->rt < 32) {
>> +        REQUIRE_VSX(ctx);
>> +    } else {
>> +        REQUIRE_VECTOR(ctx);
>> +    }
>> +    xt = gen_vsr_ptr(a->rt);
>> +    gen_set_access_type(ctx, ACCESS_INT);
>> +
>> +    if (a->ra) {
>> +        EA = tcg_temp_new();
>> +        tcg_gen_mov_tl(EA, cpu_gpr[a->ra]);
>> +    } else {
>> +        EA = tcg_constant_tl(0);
>> +    }
>> +    if (NARROW_MODE(ctx)) {
>> +        tcg_gen_ext32u_tl(EA, EA);
>
> ra == 0, narrow mode, will crash, due to write into constant 0.
> Obviously 0 does not need extending, so this could be
>
>     if (!a->ra) {
>         ea = constant 0;
>     } else if (narrow mode) {
>         ea = tcg_temp_new();
>         tcg_gen_ext32u_tl(ea, cpu_gpr[a->ra]);
>     } else {
>         ra = cpu_gpr[a->ra];
>     }
>
^ Thank you Richard, will take care in v2.
>
> Aren't there existing helper functions for computing this address?
> And if not, better to create one.
^
The calculation of effective address in these instructions is slightly 
different than the others,
for which helper function exist :

EA for these insns : EA ← (RA=0) ? 0 : GPR[RA]
EA for rest storage access insns : EA ← ((RA=0) ? 0 : GPR[RA]) + GPR[RB]

This is why I could not reuse that function. Also, this calculation of 
EA is limited to these
4 insns above, and only 2 others (prefixed insns), which is why I did 
not create a new function
for this, considering it won't be reused for any other insn.

Please let me know if I should create a new function in this case as well.

Thanks and Regards,
Chinmay
>
>
> r~
>


