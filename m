Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3FAC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZowy-0003Ji-D9; Tue, 13 Feb 2024 04:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZoww-0003J6-M7; Tue, 13 Feb 2024 04:19:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZowv-0004Q7-0Z; Tue, 13 Feb 2024 04:19:34 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41D97dpd023233; Tue, 13 Feb 2024 09:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=w0+J/AmKfNJEYO/4K+ADoOVazvC4T7sWa/DGzDJXgt0=;
 b=LJSqtyQ3kLuO4WDaOJK3OXyLQ2hSl4oFz0LFXxOt7T6vaSP9Q+EteNLq2qvYqUDvqpto
 HDQjpZ0a+ZGVs/G8Nyi2ohU0jRoWU9KgnhQ4s+JRdpfWVhwZmnuN6q1+LTa8prGkrwBI
 lZ0dqp6FHHFy/+I3xdpDH0LSbStXBmaC8NUrSzSLt1rMF79uqYlGQaw7XoYzS/xWeu0L
 t3ljv//WtIjJFmutkDmuw55TAt6N4UJbGLSEiysg4IUmykhE+OJc/0ygk/BRaops9u5b
 ih0sJmAxmSZF2lUkdoDWWyxycUIodFtrNqy+QpmbT5WCoLnAWyGhAwPNH+LVnWVqLwTA Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85h18brf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:19:14 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D97oOY024170;
 Tue, 13 Feb 2024 09:19:14 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85h18bqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:19:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41D9DPqq009680; Tue, 13 Feb 2024 09:19:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkp306-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:19:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41D9JAcT14287490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 09:19:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9378758061;
 Tue, 13 Feb 2024 09:19:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BE445805A;
 Tue, 13 Feb 2024 09:18:56 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Feb 2024 09:18:55 +0000 (GMT)
Message-ID: <a1a587b6-a2ff-4052-96d7-7a65baced4f9@linux.ibm.com>
Date: Tue, 13 Feb 2024 14:48:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxv/stxv MSR facility check
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Lucas Mateus Castro <lucas.castro@eldorado.org.br>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Joel Stanley <joel@jms.id.au>
References: <20240213083933.718881-1-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240213083933.718881-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OkaDFMXa4UqPLSic2a9E2BufKEtpNI2o
X-Proofpoint-ORIG-GUID: TaLahnb_MuVV2sdD5NCc6Ciz1iZwMhz7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=718 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402130072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/13/24 14:09, Nicholas Piggin wrote:
> The move to decodetree flipped the inequality test for the VEC / VSX
> MSR facility check.
> 
> This caused application crashes under Linux, where these facility
> unavailable interrupts are used for lazy-switching of VEC/VSX register
> sets. Getting the incorrect interrupt would result in wrong registers
> being loaded, potentially overwriting live values and/or exposing
> stale ones.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Joel Stanley <joel@jms.id.au>
> Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
> Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/translate/vsx-impl.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
> index 6db87ab336..0266f09119 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>   
>   static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
>   {
> -    if (paired || a->rt >= 32) {
> +    if (paired || a->rt < 32) {

Thanks for catching this,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>           REQUIRE_VSX(ctx);
>       } else {
>           REQUIRE_VECTOR(ctx);

