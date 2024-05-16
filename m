Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37723C25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dts-0008Rt-0N; Thu, 16 May 2024 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s7dtW-0008J3-5I; Thu, 16 May 2024 12:23:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s7dtT-0003Yv-NC; Thu, 16 May 2024 12:23:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GGH5ZY012517; Thu, 16 May 2024 16:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QblUrjQl1JpgpqL/7InVY6qt6PjyamvFNRy0ynRgfHQ=;
 b=m8EVNgon40CcUddEMWPDq6T7falTMSeYcJjI+XMJO7HRCYfeZ7gsT8z5YllY6cWuIoTo
 CiDBN79BY9Aeyolj3NvJ/jTJ9lhTaYkg1z9Bz1xgxzclPHSNjQzMZ5jcr8/4kB5g71E3
 ZLgbwuWNK6vaBbG2KO7OdmBYGe9tWitcPkLcqahM7zOMYcBjK/MWyI+E/PSzuzGS9XM3
 bdzFFmmPYnYC10fzcdhMQcBdsKQ6oNcGJiIgkU3hv7RPu571oJFoVd1wtcDI3b84N5Go
 RpsBIA8hiKCS4JJ1kpCOr7FgMAqK7hWSD68A5vAWfJT6TmIlq7aeudLwP0WSXAhq9ZAr gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5kpu0ay8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:23:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GGNfsA022813;
 Thu, 16 May 2024 16:23:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5kpu0ay6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:23:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GDVRjR020368; Thu, 16 May 2024 16:23:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd0b311-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 16:23:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44GGNYED57409942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 16:23:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA5BD2004B;
 Thu, 16 May 2024 16:23:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF19F2004D;
 Thu, 16 May 2024 16:23:31 +0000 (GMT)
Received: from [9.171.75.240] (unknown [9.171.75.240])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 16:23:31 +0000 (GMT)
Message-ID: <3fb57ce4-e3a5-4053-9847-7654ebd2413b@linux.vnet.ibm.com>
Date: Thu, 16 May 2024 21:53:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/ppc: Move VMX integer add/sub saturate insns
 to decodetree.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, lucas.araujo@eldorado.org.br
References: <20240512093847.18099-1-rathc@linux.ibm.com>
 <20240512093847.18099-2-rathc@linux.ibm.com>
 <c5eeb863-93af-4a03-a392-4eaf999d6643@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <c5eeb863-93af-4a03-a392-4eaf999d6643@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3brQoSnH_J7MP2sk-8AdGsL7iFbRMzlT
X-Proofpoint-GUID: 41J9rJ0MCQtsuwaMQL09JUMapnRCMDxa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=904 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160116
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 5/12/24 17:08, Richard Henderson wrote:
> On 5/12/24 11:38, Chinmay Rath wrote:
>> @@ -2934,6 +2870,184 @@ static bool do_vx_vaddsubcuw(DisasContext 
>> *ctx, arg_VX *a, int add)
>>       return true;
>>   }
>>   +static inline void do_vadd_vsub_sat
>> +(
>> +    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
>> +    void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
>> +    void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
>> +{
>> +    TCGv_vec x = tcg_temp_new_vec_matching(t);
>> +    norm_op(vece, x, a, b);
>> +    sat_op(vece, t, a, b);
>> +    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
>> +    tcg_gen_or_vec(vece, sat, sat, x);
>> +}
>
> As a separate change, before or after, the cmp_vec may be simplified 
> to xor_vec.  Which means that INDEX_op_cmp_vec need not be probed in 
> the vecop_lists.  See
>
> https://lore.kernel.org/qemu-devel/20240506010403.6204-31-richard.henderson@linaro.org/ 
>
>
> which is performing the same operation on AArch64.
>
Noted ! Will do.
>
>> +static bool do_vx_vadd_vsub_sat(DisasContext *ctx, arg_VX *a,
>> +                                int sign, int vece, int add)
>> +{
>> +    static const TCGOpcode vecop_list_sub_u[] = {
>> +        INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
>> +    };
>> +    static const TCGOpcode vecop_list_sub_s[] = {
>> +        INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
>> +    };
>> +    static const TCGOpcode vecop_list_add_u[] = {
>> +        INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
>> +    };
>> +    static const TCGOpcode vecop_list_add_s[] = {
>> +        INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
>> +    };
>> +
>> +    static const GVecGen4 op[2][3][2] = {
>> +        {
>> +            {
>> +                {
>> +                    .fniv = gen_vsub_sat_u,
>> +                    .fno = gen_helper_VSUBUBS,
>> +                    .opt_opc = vecop_list_sub_u,
>> +                    .write_aofs = true,
>> +                    .vece = MO_8
>> +                },
.
.
.
>> +                {
>> +                    .fniv = gen_vadd_sat_s,
>> +                    .fno = gen_helper_VADDSWS,
>> +                    .opt_opc = vecop_list_add_s,
>> +                    .write_aofs = true,
>> +                    .vece = MO_32
>> +                },
>> +            },
>> +        },
>> +    };
>
> While this table is not wrong, I think it is clearer to have separate 
> tables, one per operation, which are then passed in to a common expander.
>
>> +
>> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
>> +    REQUIRE_VECTOR(ctx);
>> +
>> +    tcg_gen_gvec_4(avr_full_offset(a->vrt), offsetof(CPUPPCState, 
>> vscr_sat),
>> +                   avr_full_offset(a->vra), avr_full_offset(a->vrb), 
>> 16, 16,
>> +                   &op[sign][vece][add]);
>> +
>> +    return true;
>> +}
>> +
>> +TRANS(VSUBUBS, do_vx_vadd_vsub_sat, 0, MO_8, 0)
>
> I think it is clearer to use TRANS_FLAGS than to sink the ISA check 
> into the helper.  In general I seem to find the helper later gets 
> reused for something else with a different ISA check.
>
> Thus
>
> static const TCGOpcode vecop_list_vsub_sat_u[] = {
>     INDEX_op_sub_vec, INDEX_op_ussub_vec, 0
> };
> static const GVecGen4 op_vsububs = {
>     .fno = gen_helper_VSUBUBS,
>     .fniv = gen_vsub_sat_u,
>     .opt_opc = vecop_list_vsub_sat_u,
>     .write_aofs = true,
>     .vece = MO_8
> };
> TRANS_FLAGS(VSUBUBS, do_vx_vadd_vsub_sat, &op_vsububs)
>
> static const GVecGen4 op_vsubuhs = {
>     .fno = gen_helper_VSUBUHS,
>     .fniv = gen_vsub_sat_u,
>     .opt_opc = vecop_list_vsub_sat_u,
>     .write_aofs = true,
>     .vece = MO_16
> };
> TRANS_FLAGS(VSUBUHS, do_vx_vadd_vsub_sat, &op_vsubuhs)
>
> etc.
>
Will add those changes in v2.
>> -GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
>
> You are correct in your cover letter that this is not right.
> We should have been testing ISA300 for vmul10uq here.
>
Thank you very much for the clarification !
>> +GEN_VXFORM(vmul10euq, 0, 9),
>
> And thus need GEN_VXFORM_300 here.
>
>> +GEN_VXFORM(vmul10euq, 0, 9),
>> +GEN_VXFORM(bcdcpsgn, 0, 13),
>> +GEN_VXFORM(bcdadd, 0, 24),
>> +GEN_VXFORM(bcdsub, 0, 25),
> ...
>> +GEN_VXFORM(xpnd04_2, 0, 30),
>
> None of these are in the base ISA, so all need a flag check.
>
>
>
> r~
>
Thanks & Regards,
Chinmay

