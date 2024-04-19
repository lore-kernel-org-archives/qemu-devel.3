Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF60C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkNg-0008Cm-Vc; Fri, 19 Apr 2024 05:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkNb-0008Bt-82; Fri, 19 Apr 2024 05:17:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rxkNZ-0004B5-9b; Fri, 19 Apr 2024 05:17:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J9EuSt018664; Fri, 19 Apr 2024 09:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Mlu+qLuym7zPjp3367tjSQ7Zhn9dbqTt5gPP/xG30zQ=;
 b=RNj2WpMdhlYo57eXrBwvsFObbQZYSsllOvJXRVRv/lQy7NPzIjZhsaBqzjPEvU5KXkTv
 walFah9IFHRXohJCjuvpebqYwpE0+RiqezzeW0oB+MgK2km7bH07L8ARr5f0u4uoDcG4
 ViEQ99NnzMRpWcQNlhRz8+nb/i/tkoKBNNsU6BhWrCXu4BWYIpz1+/dt91Y1ENo/wOK1
 xcgAkwGU9WLFFt4eBS0OUA8ybI3DxpNlRpDQQI3jMDY0x3dU5rAVqSmiBBo4v2XG/yKc
 gZ7Aqu3b95uAh1aibaTyyQezJfOTqgGFuNl4wGuIVuS2X4ckrv35BMYcVqWNdYcLiDTy gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknsjg08g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:17:54 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J9HriB023797;
 Fri, 19 Apr 2024 09:17:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xknsjg08f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:17:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J8cNUC022019; Fri, 19 Apr 2024 09:17:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbk92ra8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 09:17:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J9HleN42795416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 09:17:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2966820040;
 Fri, 19 Apr 2024 09:17:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 956042004B;
 Fri, 19 Apr 2024 09:17:45 +0000 (GMT)
Received: from [9.171.89.59] (unknown [9.171.89.59])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 09:17:45 +0000 (GMT)
Message-ID: <02e342b0-2e25-4b77-b932-611b06576ed5@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2024 14:47:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/ppc: Make divw[u] handler method decodetree
 compatible.
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-3-rathc@linux.ibm.com>
 <be3dd6e4-2e9f-4a75-a744-327fb5f8e262@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <be3dd6e4-2e9f-4a75-a744-327fb5f8e262@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -CNB9WZ_DU_GeJfmCDZYcR1yd19jtkj7
X-Proofpoint-GUID: S7mGG3DuznqfYS-rdsZxNcDPP-OxGlaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190068
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

On 4/16/24 23:27, Richard Henderson wrote:
> On 4/15/24 23:39, Chinmay Rath wrote:
>> The handler methods for divw[u] instructions internally use 
>> Rc(ctx->opcode),
>> for extraction of Rc field of instructions, which poses a problem if 
>> we move
>> the above said instructions to decodetree, as the ctx->opcode field 
>> is not
>> popluated in decodetree. Hence, making it decodetree compatible, so 
>> that the
>> mentioned insns can be safely move to decodetree specs.
>>
>> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
>> ---
>>   target/ppc/translate.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
Thank you.
>> +static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
>> +                                     TCGv arg1, TCGv arg2, bool sign,
>> +                                     bool compute_ov, bool compute_rc0)
>
> Could drop the inline at the same time.
> Let the compiler decide.
>
I kept inline as is, as there are multiple gen_op_* routines with inline and
if necessary we could consider removing inline for all of them together 
in a separate patch :

grep inline target/ppc/translate.c | grep gen_op

static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int crf)
static inline void gen_op_cmp32(TCGv arg0, TCGv arg1, int s, int crf)
static inline void gen_op_cmpi32(TCGv arg0, target_ulong arg1, int s, 
int crf)
static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
static inline void gen_op_arith_modw(DisasContext *ctx, TCGv ret, TCGv arg1,
static inline void gen_op_arith_modd(DisasContext *ctx, TCGv ret, TCGv arg1,
static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
static inline void gen_op_mfspr(DisasContext *ctx)

Thanks,
Chinmay
>
> r~


