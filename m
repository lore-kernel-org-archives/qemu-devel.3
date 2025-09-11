Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B67CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweP6-0005mf-Ek; Thu, 11 Sep 2025 06:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1uweOs-0005hW-S9; Thu, 11 Sep 2025 06:19:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1uweOp-0008HB-VK; Thu, 11 Sep 2025 06:19:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B3iKPM020767;
 Thu, 11 Sep 2025 10:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vwdyRv
 6GGRxU6NnWVIrx66TDZUlTKSpFu9niax3bomY=; b=nUDzGjRZWfDAKDXc3z6lNT
 Wl9F5eanCypXeQARwE1+c4KkOkrQjshpR/MMhPamXBvyV4lAfjmmlxy/uGe6KDrq
 CrihzbzpsQwf4eKke2o/glgvimftlCDtXq6SFGqv1Y8hgtIYpNJSSrpdqbJhSBXp
 az5rURW2V/b7+wd7CXGWi2pE4zQQIoA02HEXc3d6B+h2dardpN1pV8v2iiuFqKzk
 Q+BKCcgRy8jm6AkGUkboWSh0Mn0G6vzup1LLxgHB38UCf8Kc5rf898xf42De20ez
 lcGIPMasgXxxcUvqmjK1be3I73H2Cv55Lmp2lWCAmorAfccNgFhRrO/KGzjV+VYw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrbdaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 10:19:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BAFTPX016738;
 Thu, 11 Sep 2025 10:19:26 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrbda6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 10:19:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B84TXJ011428;
 Thu, 11 Sep 2025 10:19:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9unhgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 10:19:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58BAJOv117170732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 10:19:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4876D2004D;
 Thu, 11 Sep 2025 10:19:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD0172004B;
 Thu, 11 Sep 2025 10:19:20 +0000 (GMT)
Received: from [9.39.16.89] (unknown [9.39.16.89])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Sep 2025 10:19:20 +0000 (GMT)
Message-ID: <57e06839-34f3-4da9-9304-8ba15d957879@linux.ibm.com>
Date: Thu, 11 Sep 2025 15:49:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: init lrdr-capapcity phys with ram size if
 maxmem not provided
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
References: <20250506042903.76250-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20250506042903.76250-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tj6a82LM4jzAYN6WPIJBplWyb6yMog5o
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c2a22f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=q167Eno9kCxE3xRhu44A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fOH9nqX7B10KU8frgaSlhGeOcX3Wo3ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX+kuxDhheMzwC
 SJovIz+N6v9VFqMEOXc0hLdzC/Fzg0smnwkd+nFtnoGW4bS+2ocbTQ4BASPyHcbLpCdasVg0lkH
 arA4bABhT8S19/MEXVwhA9cY7CSfxUb4XLmqa2yz82zbe74z/elGWFhR7+grEG30zWH8nkWOvEa
 OZ+pbO72rHa/BAZrxOGtD17+WRUWCEriPSPgCgkurCoDUN9Ulzfs58uQtK7WqnzM3bq74Px2ZKp
 8l5z9a0v6HRkog8q4UZxWkI07MqG+QA21PscYexanU65wfFJOJuJXtjal6vtZEVCTfevA0d+dRx
 qLhYHodexnf9q6dwK4XEJpEMrDgl5D+O/i8N5xAmv3paJaCAf0mSSFWIrmeAXBXzfjVP5PoAc4w
 n5gp90n2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 5/6/25 9:59 AM, Harsh Prateek Bora wrote:
> lrdr-capacity contains phys field which communicates the maximum address
> in bytes and therefore, the most memory that can be allocated to this
> partition. This is usually populated when maxmem is provided alongwith
> memory size on qemu command line. However since maxmem is an optional
> param, this leads to bits being set to 0 in absence of maxmem param.
> Fix this by initializing the respective bits as per total mem size in
> such case.
>
> Reported-by: Gaurav Batra <gbatra@us.ibm.com>
> Tested-by: David Christensen <drc@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 702f774cda..9f18642734 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -907,6 +907,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>       int rtas;
>       GString *hypertas = g_string_sized_new(256);
>       GString *qemu_hypertas = g_string_sized_new(256);
> +    uint64_t max_device_addr = 0;
>       uint32_t lrdr_capacity[] = {
>           0,
>           0,
> @@ -917,13 +918,15 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>   
>       /* Do we have device memory? */
>       if (MACHINE(spapr)->device_memory) {
> -        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
> +        max_device_addr = MACHINE(spapr)->device_memory->base +
>               memory_region_size(&MACHINE(spapr)->device_memory->mr);
> -
> -        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
> -        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
> +    } else if (ms->ram_size == ms->maxram_size) {
> +        max_device_addr = ms->ram_size;
>       }
>   
> +    lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
> +    lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
> +

Since maxmem accounts for pcdimm and/or nvdimm cases, this would work

fine for all probable scenarios in this code path.


Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>


Thanks,

Shivaprasad


