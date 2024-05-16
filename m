Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E748C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dpN-0003tM-Jy; Thu, 16 May 2024 12:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s7dpL-0003rb-6T; Thu, 16 May 2024 12:19:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s7dpJ-000232-7b; Thu, 16 May 2024 12:19:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GG14Jv004316; Thu, 16 May 2024 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UP+2U+Hsl4wp8yZF+Y7//mbHmHPUyA4rjz1ydsvKI6U=;
 b=DH8nGNjss8pye2vGnqYJi6gFv1fsy0rBvRC8g4U75B7PM/yxsaj9sd5BnWaY1Zbe05+i
 fYMO0RgYviH9fmYIjkKcHZHCoENJ6VOsPuE1NjemuSVaygsPjwXqz/+0Eynm3+9XeDLC
 OH86BUk7BTTVYWDglOx0MsWLdG2sEZIi+6x4JDhpnjLMvYJgNNLrHKZX01HFd2mh3lfm
 bymovq6tQOjZok4y33X9c7xOcJ63c+xVkSbYArFHTS53N/tHyEu2EdgGn18Wp/wFrefk
 vqO0WNuy+dPNXE9ydAGMF6x/efI20wAOy6AkT5dn40pelchsrHNA6yBna8fYtLFIPVMf rA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5n5yr26p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:19:16 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GGJG99003324;
 Thu, 16 May 2024 16:19:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5n5yr26k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:19:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GEBDE5002252; Thu, 16 May 2024 16:19:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pjwth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:19:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44GGJ8wQ54657520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 16:19:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B913820049;
 Thu, 16 May 2024 16:19:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9637620040;
 Thu, 16 May 2024 16:19:06 +0000 (GMT)
Received: from [9.171.75.240] (unknown [9.171.75.240])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 16:19:06 +0000 (GMT)
Message-ID: <77730b44-4291-4199-8cde-8edd57b7795b@linux.vnet.ibm.com>
Date: Thu, 16 May 2024 21:49:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: target/ppc: Move VMX int add/sub saturate insns to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, lucas.araujo@eldorado.org.br
References: <20240512093847.18099-1-rathc@linux.ibm.com>
 <b85e90da-cf99-431c-8a64-80cbba21ea89@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <b85e90da-cf99-431c-8a64-80cbba21ea89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XPxdQNmj2XpLKOHge1IdDlW0jN60K0UZ
X-Proofpoint-GUID: OHdKzigRHoRgYwodBs20wlnMAacky_vB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160116
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/12/24 15:59, Richard Henderson wrote:
> On 5/12/24 11:38, Chinmay Rath wrote:
>> 1. vsubsbs and bcdtrunc :
>>
>> In this pair, bcdtrunc has the insn flag check PPC2_ISA300 in the
>> vmx-impl file, within the GEN_VXFORM_DUAL macro, which does this flag
>> check.
>> However it also has this flag check in the vmx-ops file.
>> Hence I have retained the same in the new entry in the vmx-ops file.
>> This is consistent with the behaviour in done in the following commit :
>> https://github.com/qemu/qemu/commit/b132be53a4ba6a0a40d5643d791822f958a36e53 
>>
>> So even though the flag check is removed from the vmx-impl file, it is
>> retained in the vmx-ops file. All good here.
>>
>> 2. vadduhs and vmul10euq :
>>
>> In this pair, vmul10euq has the insn flag check PPC2_ISA300 in the
>> vmx-impl file, check done within the GEN_VXFORM_DUAL macro.
>> However the same flag was NOT originally present in the
>> vmx-ops file, so I have NOT included in its new entry in the vmx-ops
>> file. I have done this, following the behaviour done in the following
>> commit :
>> https://github.com/qemu/qemu/commit/c85929b2ddf6bbad737635c9b85213007ec043af 
>>
>> So this flag check for vmul10euq is excluded now. Is this not a 
>> problem ?
>> I feel that this leads to the flag check being skipped now, however this
>> behaviour was followed in the above mentioned commit.
>
> This second link is for VAVG* and VABSD*.
>
> Yes you are correct that this second case was done incorrectly. 
> Thankfully the mistake was fixed in the very next commit, when VABSD* 
> was converted to decodetree as well.
>
Thank you very much for the clarification !
>
> r~
Regards,
Chinmay

