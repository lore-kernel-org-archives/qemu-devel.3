Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD9C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 18:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGNFQ-0004rY-5z; Sun, 09 Jun 2024 14:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNFO-0004qv-IO; Sun, 09 Jun 2024 14:26:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1sGNFM-0008NF-Fh; Sun, 09 Jun 2024 14:26:30 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459HvYFj006897;
 Sun, 9 Jun 2024 18:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
 mlkVrY7gT71KkYGQdV9cb4PgzrKPlGc3xGNV5Nm4zk=; b=l2xQPQ7d9xd+YlPNf
 LkKX5Tivfl44R9hviR25ZMtDpMGET5jRvALBuld9Cwf0eW2W7ZzonOEhmMyNlXkQ
 JDD7xIuhzNg3/riXjui7Szc/o+3aWkflgJWJEIDckq2Vh95E7xpP291RllC+p2qm
 R1J/BrF0dcqHp4WJJzYQyc53tDEbyq7C/gVB5M2ZShHZTaxrng7GrOzeWQkbctJF
 EJNmGUYgc77agn6YQ0NvW5H5y0XyWL2R2OUuuySHSc1EQtLdQp3iE53+qBEKk+Gm
 YMUuR6O8fNP3JjZuhPTV6kQInSCCYrdg3KEo/jqm7u+MrN7IAC76elNOqMYjdIjV
 Q+DWQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yngtwr2r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:26:25 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 459IQOhZ017631;
 Sun, 9 Jun 2024 18:26:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yngtwr2r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:26:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 459F2LMP020048; Sun, 9 Jun 2024 18:26:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34mk9wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 18:26:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 459IQHWN41550232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Jun 2024 18:26:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F76D2004B;
 Sun,  9 Jun 2024 18:26:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 495E020040;
 Sun,  9 Jun 2024 18:26:15 +0000 (GMT)
Received: from [9.171.49.220] (unknown [9.171.49.220])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Jun 2024 18:26:14 +0000 (GMT)
Message-ID: <74394b4b-20da-4091-809c-acda19d9583c@linux.vnet.ibm.com>
Date: Sun, 9 Jun 2024 23:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/ppc: Move VSX fp compare insns to decodetree.
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-5-rathc@linux.ibm.com>
 <5419796e-f56f-49e6-8094-dd6795866c0b@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <5419796e-f56f-49e6-8094-dd6795866c0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cKCmJOaesxaksP5pau6LMuAPYffbkIjQ
X-Proofpoint-GUID: _CgALOlCPz-tuYOrxzpRTD-mynX17PfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=913 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
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



On 6/7/24 21:25, Richard Henderson wrote:
> On 6/7/24 07:49, Chinmay Rath wrote:
>> +static bool do_cmp(DisasContext *ctx, arg_XX3_rc *a,
>> +            void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_ptr, 
>> TCGv_ptr))
>> +{
>> +    TCGv_i32 ignored;
>> +    TCGv_ptr xt, xa, xb;
>> +    REQUIRE_VSX(ctx);
>> +    xt = gen_vsr_ptr(a->xt);
>> +    xa = gen_vsr_ptr(a->xa);
>> +    xb = gen_vsr_ptr(a->xb);
>> +    if (a->rc) {
>> +        helper(cpu_crf[6], tcg_env, xt, xa, xb);
>> +    } else {
>> +        ignored = tcg_temp_new_i32();
>> +        helper(ignored, tcg_env, xt, xa, xb);
>> +    }
>
> Better to unify the helper call.  E.g.
>
>     dest = a->rc ? cpu_crf[6] : tcg_temp_new_i32();
>     helper(dest, ...)
>
^
Sure Richard, will do in v2.

Thanks & Regards,
Chinmay
>
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


