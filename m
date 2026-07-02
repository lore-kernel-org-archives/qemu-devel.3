Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6GD-0001Ho-6X; Wed, 01 Jul 2026 21:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6GB-0001HS-Kv; Wed, 01 Jul 2026 21:30:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6G9-00008C-Vo; Wed, 01 Jul 2026 21:30:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Kked2347693; Thu, 2 Jul 2026 01:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4ph4dm
 DbGg92Qxbe0ukeL/r4twYB+v2nhHZv28Lr/2Y=; b=QitrYVZWh9oWHZ8Tu2723u
 yr8p/dx5IOX6CFzf9kX5DEfVYTjqJ5I14NDoxVl0hTtDadSy8zLCtbmcSqsEqmom
 JrvErbsyH0Z6YUaSgnHEm1hMFyObpiGtf5rHnLW/RtRPiPEO1ahWipN/oCOE4rmm
 N4/gJnsPlAog2CrYMLKkNSoOKtI5HIaiQ+utWWzJ+fK3IFayanJePqQjuMriWfOG
 j7w+AD0GBEdoQ5zmOwf1V1q9TZhZNzlgsv7xKAKFpb8bzbN18OyEZcgT5O4eZyEX
 G+dBn/XKno31Z8/WHGHIlJbk7SeWgIc+AgPBAzzXU6oxPbG5qzyn0j+weKk1eOQA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjy58r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:30:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621KBUl011044;
 Thu, 2 Jul 2026 01:30:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk9wdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:30:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621USf421299820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:30:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECB6C5805D;
 Thu,  2 Jul 2026 01:30:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C10FF58057;
 Thu,  2 Jul 2026 01:30:26 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 01:30:26 +0000 (GMT)
Message-ID: <ea3c9a29-3200-42f5-9e8a-b3e37b872b17@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:30:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/35] s390x/diag: generalize s390_ipl_read/write to
 accept void *
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-14-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX0t5y9DWn5IOo
 Y9gn9o9VcUB8J1UqtqEtUkqmG9nmVtTLnJJLCPS17xR8ZY4pnhPvb8AssovMch6iaz+ny8SJZ6e
 qv5UM4OWuEX87H6zjZ/Bj2sb9/Avuhdj/CI+dyQhkIGqNFr1CADYd+apagP1v6PfppglMbnDO0V
 LKN8cSGI+xa8UMi+yyUjGCccay0l5dnhtu6iKLD8JlTI9cGe6yxt1iL9T4Kk/fwh6cQBHuE1hm6
 0yCw/83u7KkPLF+9YRbslFL6tvWa7d2qpf7Axd7eeqNZbpUnrgO0Yhk2Gonw4T8nU/mAPxW3jI8
 X2MN3AaiItsPnc4Uy3rn+Z21+199tDF/z9JQ1nvWF8eviiNdwQdHSzscVWZrpYJj2jbvpWk3610
 YJjFdzsOXHIJ2ekJvYySiRnLlSoxIWpGo/oKB7KFQUi43dx+1cUYID/qOfYo2f2wcVY1rpia9CF
 GhZeIEeU1WbpbqbFn8Q==
X-Proofpoint-GUID: nFUOjEY0up_bZK1IaTlD0slvDwvp_sdb
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45bf36 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=sTRNxIo-pg_mbpwFFGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX1BwFhx6O9JOE
 YygYSMgDUMgYLdxYHMYdORJukCEoYkGafkD0DbzR5AzC4TELlkQa1iEBOTqDKI4+wRqszs8YJ/d
 YLo3PhHYYwvEeDk3mFWgIWTrwJ8aN3E=
X-Proofpoint-ORIG-GUID: nFUOjEY0up_bZK1IaTlD0slvDwvp_sdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/1/26 4:48 PM, Zhuoying Cai wrote:
> Change the data parameter of s390_ipl_read() and s390_ipl_write()
> from IplParameterBlock * to void *, so the helpers can be reused
> beyond DIAG 308.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   target/s390x/diag.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index f07d39ab07..aad2e8c6bc 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -83,24 +83,24 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>   }
>   
>   static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
> -                          IplParameterBlock *iplb, size_t size)
> +                          void *data, size_t size)
>   {
>       if (s390_is_pv()) {
> -        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
> +        s390_cpu_pv_mem_read(env_archcpu(env), 0, data, size);
>       } else {
>           address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
> -                           MEMTXATTRS_UNSPECIFIED, iplb, size);
> +                           MEMTXATTRS_UNSPECIFIED, data, size);
>       }
>   }
>   
>   static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
> -                           IplParameterBlock *iplb, size_t size)
> +                           void *data, size_t size)
>   {
>       if (s390_is_pv()) {
> -        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
> +        s390_cpu_pv_mem_write(env_archcpu(env), 0, data, size);
>       } else {
>           address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
> -                            MEMTXATTRS_UNSPECIFIED, iplb, size);
> +                            MEMTXATTRS_UNSPECIFIED, data, size);
>       }
>   }
>   

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

