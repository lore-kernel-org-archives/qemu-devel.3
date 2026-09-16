Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D50DC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yrc-00005t-4w; Wed, 16 Sep 2026 19:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrZ-00005K-RC; Wed, 16 Sep 2026 19:16:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrY-0002kX-7b; Wed, 16 Sep 2026 19:16:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1cHF4057214; Wed, 16 Sep 2026 23:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j9puRZ
 L83afb/NvCT1Gf8rxb7OGbe0u7x0KYZ7HQaGI=; b=Mcqq/J+lYW+QsTNIEcuUY8
 CWxI1qMO3GvS1Yy1gXCnmU3xmQlhqvu6hIwGsvhpkEHL4wUUpuYQGHi+x6mhivuv
 AZSrzIJCZKGEOu/x5LiRqUCrOnL9ks9x3eKjUT4fQme84lfw/u8kgxD3u/l1D4Lj
 GffRtC+Qk1rcftQCx09WM3tMoMFwSRmHj+PdTtsdpQYb5JkLmkj/zGhoFEIgX31h
 MpkJi3pC2VkRyNqkyHQ0yYTJ6RQBVL+GM7UjvoovCODzm3a5D67wHMCGcZcNdXQP
 NTo1QIf1ed1qymT0beHBCWxy/SjlT4NasZPbbBbBTaxeXS2iVuT/y9RQzOon/zrQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hyac3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMpgDr1663471; Wed, 16 Sep 2026 23:16:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089ru96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNGKv526215098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:16:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D12A958052;
 Wed, 16 Sep 2026 23:16:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2442758045;
 Wed, 16 Sep 2026 23:16:20 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:16:19 +0000 (GMT)
Message-ID: <2df66cbd-0906-447c-b09b-958a3127da07@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:16:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] s390x/sclp: Reject short headers in PV case
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Janosch Frank <frankja@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-10-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX+B/QD0vQAj68
 pxs3h58cbc9ufKk4d2jff8E0bfdZI010WS3EtYqjQ+zzuT2BtA+IXfahXoTpBfdsP48PxWQEBA4
 bP02IRcAqjNT4hDi7d7CAyca776+/ex33a5P1vYc+287ZXwE3subW3d3xkTZ7CG28seUhFxZu9K
 Gnun52kIVTe7GJIzzvHumxbmTzymlj1KKQB5O6OULgBdMZhybmipy2p6/fwZnAjreokHTkJDhBu
 bMow8Ni6NO/UcZeSUCJLX4PT24Bt/IMU0ORZBkceGozgED+L58Sw4/Ko3OToQnKHogzt1m6/tFt
 mqjSynv8LtR98JOErP7p3KxjsabW4tEXAZHGzYnqsNvzmJrfggUIfVi8QF3aqy4Gyf/Xne7SdKm
 CkPciBqIpXu8eLLjcFbOiUImh/1DyvdL/mKGdTrc0Ldp1w9MUl1NtKZF/D1NaJQocOAXN5ZAW5S
 ex06XaZQgJv4kN5qoAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX6plsNAybil5J
 mic03u95Hs/SYMA/ICwbw7Ev3BLb05P+xFnQA1Y+1ZgHEHX7OBQvIo0NL3L13I3HkQ75Qiya0RM
 FEeXWk0UJvA/OihSyoLHc3+bzUsAlkg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab2346 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pT-1LJTGLAckAGZmZzQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RjsrIBZetjMfel2prn7CZUcqwTeGjyao
X-Proofpoint-GUID: RjsrIBZetjMfel2prn7CZUcqwTeGjyao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> An invalid length in an SCCB header correctly generates a specification
> exception for the regular (non-PV) codepath that processes an SCLP
> instruction intercept. The PV case doesn't, even though such a thing
> should already be sanitized. Since a short length will cause problems
> later down the line with the storage that will be allocated based on
> that size, put up a defensive check and return if it is too short.
> 
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided length")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Seems like cc stable would make sense here, it sounds exploitable if the
sanitization assumption were to fall apart.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d8b655efcc..ad8129a5d8 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>  
>      s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
>  
> +    /* Do nothing if the header appears malformed */
> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
> +        goto out_no_write;
> +    }
> +
>      work_sccb = g_malloc0(be16_to_cpu(header.length));
>      s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
>                           be16_to_cpu(header.length));
> @@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
>                            be16_to_cpu(header.length));
> +out_no_write:
>      sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>      return 0;
>  }


