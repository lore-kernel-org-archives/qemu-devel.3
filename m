Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3468AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 01:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1c3C-0001rs-Rn; Mon, 29 Apr 2024 21:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1c3A-0001re-Uc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:12:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1c37-00078Y-5z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:12:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43U13C9X011441; Tue, 30 Apr 2024 01:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PYAT3a7lcFf1KEt5ef+OMX5bdrrww1iNPYOQzy6tqbA=;
 b=dePbQUYDZxYgz6cPA16ivKsFglAxXpZAQlgQJGJ3X5wK6V7xnwVelX19M4UbHpoTPauR
 JBbGgikazPszoClTRCEqraRDrwVtJVZVgmf/o6A3qkuk/Qpu1hJYEhcVSsh738A5G/fQ
 J5peggYPOOwMlGMPZJXSnJXw55DnNDXx1Xx2lvQB+cpXJHzN/cEA6HKo1mP3dlW/J+ds
 wbAFNRQJtnwv0CCuK1f8dm/JHNHD0799L651jNOUPImMkLHweFwh5oRG4CUpeCEoirI4
 sOMUk3mMmaDpp/mm80sAm5l6G+N2RacXWU4G1yc2AhPPvG9qKHJYk1Xek+3e7EeGkl0V Ng== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtpmjr0db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 01:12:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TLiVwj003210; Tue, 30 Apr 2024 01:12:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppacvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 01:12:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43U1Cch015728920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 01:12:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C62B2004F;
 Tue, 30 Apr 2024 01:12:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D63072004B;
 Tue, 30 Apr 2024 01:12:37 +0000 (GMT)
Received: from heavy (unknown [9.171.51.254])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Apr 2024 01:12:37 +0000 (GMT)
Date: Tue, 30 Apr 2024 03:12:36 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH v2 10/13] accel/tcg: Remove NULL check in
 tcg_flush_jmp_cache()
Message-ID: <hb6uqj3e5yowzwj2tq7tmmjgq6fir7hyojz3u2bdwlovyijaj5@ghv4ajqqvpkf>
References: <20240429213050.55177-1-philmd@linaro.org>
 <20240429213050.55177-11-philmd@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240429213050.55177-11-philmd@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WO-5WZU_Yj9x371iiDAsvVRLe6yYue3n
X-Proofpoint-ORIG-GUID: WO-5WZU_Yj9x371iiDAsvVRLe6yYue3n
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300007
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 29, 2024 at 11:30:47PM +0200, Philippe Mathieu-Daudé wrote:
> I /think/ this check added in commit 4e4fa6c12d ("accel/tcg:
> Complete cpu initialization before registration") is now
> unnecessary, but I don't have the WASM reproducer mentioned
> in:
> https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/
> to confirm. Ilya, do you mind testing? If so, we could
> squash this with the previous patch.
> 
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/translate-all.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index ca1e193633..9b02f21b23 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -652,14 +652,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>   */
>  void tcg_flush_jmp_cache(CPUState *cpu)
>  {
> -    CPUJumpCache *jc;
> +    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
>  
> -    /* During early initialization, the cache may not yet be allocated. */
> -    if (unlikely(cpu->accel == NULL)) {
> -        return;
> -    }
> -
> -    jc = &cpu->accel->tb_jmp_cache;
>      for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
>          qatomic_set(&jc->array[i].tb, NULL);
>      }
> -- 
> 2.41.0
> 

Sure, I'll have a look tomorrow.

