Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD78CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6VMT-0001z1-Tt; Wed, 08 Oct 2025 10:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1v6VMM-0001w9-GS; Wed, 08 Oct 2025 10:41:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1v6VMC-0000V8-Ny; Wed, 08 Oct 2025 10:41:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598AU4Bg010446;
 Wed, 8 Oct 2025 14:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VML/es
 fWXwoZS6cKZkBynH9o5dO77/xZLYaRq2z4+Xc=; b=GVQk12vIQl8U5VfBED6U4a
 cYYTkVc9M7Y5WrgDb0x9UiMmHJRQ5kVu9ElW54IfvUYREBN2t4AmeN18NYoaO8Uh
 VH7m0jr05diBZ6hv0zf5aQJ0re1Lzs4kegEsBF74hDbxMp7x4fFPDN6R+me5ufbD
 F7EczFYC/nGwKpjp/HMHPNBuCz0u85iYIioDjYfnGu5rzFet8VifswGhLcAUy+6P
 Ao/uDRp55zgr4ikOLzzgX3eDopmcF5gEomdj7DywnSXPZTQ26DjMIMJzFEkD8Mn3
 bCNM4sLxo3dTpV6bye5Sl+9AxS62MJJiLPkJ5sRwK8uRnj/nhjso5Yr4rAWpK5LA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93nnad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 14:41:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598DNWER028435;
 Wed, 8 Oct 2025 14:41:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewn8ydx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 14:41:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598EfNP435258864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 14:41:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B7D45804E;
 Wed,  8 Oct 2025 14:41:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B4235803F;
 Wed,  8 Oct 2025 14:41:22 +0000 (GMT)
Received: from [9.67.164.117] (unknown [9.67.164.117])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Oct 2025 14:41:22 +0000 (GMT)
Message-ID: <11dca13e-f86a-46f5-93aa-f7f44d748ec3@linux.ibm.com>
Date: Wed, 8 Oct 2025 10:41:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/s390x/sclp: Do not ignore
 address_space_read/write() errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251007015802.24748-1-philmd@linaro.org>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20251007015802.24748-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sJpPPybtEjIqBWeFWNC8g01WANLzc2Uj
X-Proofpoint-ORIG-GUID: sJpPPybtEjIqBWeFWNC8g01WANLzc2Uj
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e67815 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=AV9cg1KQIC2RSJ_KDIYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX0UDShEywF2s+
 T10sFPOAxzSk2gT14x5+Bjio7dpXoyRbRdwBsxku8kvPQDtOXO9Z7ADvKBztIv6UkSpQzmwOIpf
 Q+5gyra/ehhyDCvPsH232telcw3isvi7oA9nawq54482zDSXHalhAnihyvLXEoa+owyvSSLVQ4J
 1nbUkQx2oMNwSPTPxMVxKhZlKskVpzj60d4h3D7t1CFUjszqO/PKXMQAKlmSecHo6+smq+46KaU
 Vi8BYQ11/03PFtWvcRvIeSSv0lFRziTWIDyBQVTTAnFxL9c2hrZLv3Wb1pHG1i1Nfzo8oyVBDV1
 IjsUhvF+E5OZzQGH8rgncMFVTcU5LBIubUZXjrZ3Oo2ycFoWeQJwJsaOWl/YGkEiZ+fG79n9XN4
 wBh0gucNtf1grGvA7AKNYWfANPI0tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/6/25 9:58 PM, Philippe Mathieu-Daudé wrote:
> If address_space_read() fails, return PGM_ADDRESSING. In the
> unlikely case address_space_write() fails (we already checked
> the address is readable), return PGM_PROTECTION.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251007014958.19086-1-philmd@linaro.org>
> ---
>   hw/s390x/sclp.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d7cb99482b2..8604cd305e5 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -305,6 +305,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>       SCCBHeader header;
>       g_autofree SCCB *work_sccb = NULL;
>       AddressSpace *as = CPU(cpu)->as;
> +    MemTxResult ret;
>   
>       /* first some basic checks on program checks */
>       if (env->psw.mask & PSW_MASK_PSTATE) {
> @@ -319,8 +320,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>       }
>   
>       /* the header contains the actual length of the sccb */
> -    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                       &header, sizeof(SCCBHeader));
> +    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                             &header, sizeof(SCCBHeader));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_ADDRESSING;
> +    }
>   
>       /* Valid sccb sizes */
>       if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
> @@ -333,8 +337,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>        * the host has checked the values
>        */
>       work_sccb = g_malloc0(be16_to_cpu(header.length));
> -    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                       work_sccb, be16_to_cpu(header.length));
> +    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                             work_sccb, be16_to_cpu(header.length));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_ADDRESSING;
> +    }
>   
>       if (!sclp_command_code_valid(code)) {
>           work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> @@ -348,8 +355,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   
>       sclp_c->execute(sclp, work_sccb, code);
>   out_write:
> -    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
> -                        work_sccb, be16_to_cpu(header.length));
> +    ret = address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
> +                              work_sccb, be16_to_cpu(header.length));
> +    if (ret != MEMTX_OK) {
> +        return -PGM_PROTECTION;
> +    }
>   
>       sclp_c->service_interrupt(sclp, sccb);
>   

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

