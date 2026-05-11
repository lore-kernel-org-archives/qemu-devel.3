Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUkU-0001Uz-Ue; Mon, 11 May 2026 13:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMUjw-00010y-SI; Mon, 11 May 2026 13:48:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMUjv-0008UE-7W; Mon, 11 May 2026 13:48:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BDjNhS238892; Mon, 11 May 2026 17:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v3oMsq
 yFC3K/Ijy6z4+hC5JlUbwLSx27QeuEAKRHR5A=; b=OVrqToKQ8ZNiYhsf7innSH
 wg7yH1ucWK2SkeFi3zeatStISu76svqyenvP2udiYkmD8xAbVzzgaHcFlU+DcFFF
 OcQYpc4B7oYQawPr0GjHvOIubIbTZeh8tLxEmygkGxYKkDGWTUBIByazzxnzspQH
 xqUmDNnYP9vi69rdRi+/gkaAgAjQBnhj2umlk60unKH4AqWKkZ2zaKqWo6dRXU/v
 YCCohvLrZSNteDtZRePYYBsljYSkOoR8PCU0zGqaNGXEyNh5KP2mMIvbbEeVqHxm
 PeGmsFAe5dx6qrr1zhex9Wkzyl/X6ZLKifEYLcDMhCzi5aJErlGoo1pkRW0rS0Kw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhs4q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 17:48:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BHOUdD002451;
 Mon, 11 May 2026 17:48:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh6a2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 17:48:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BHmIUV27329074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 17:48:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 915105805E;
 Mon, 11 May 2026 17:48:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86DFB58058;
 Mon, 11 May 2026 17:48:17 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 17:48:17 +0000 (GMT)
Message-ID: <0e376d73-acb5-47b5-8ac1-6b3851dfbc6c@linux.ibm.com>
Date: Mon, 11 May 2026 13:48:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: restore cpu_models for system builds
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260511163541.192533-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a021664 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=maQemdB9CxkyP7EGjgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C6ajyHAlx8ul4AXNJL0WtEDKGycAx7ui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE4OCBTYWx0ZWRfX1Wxymxgqo98f
 0gTKxxNmzHT3Kzh1U+X+r8aGapoUhm+BwZtbnzHvqnYA1x1MqeRK5x0F4MwLwkT6bPOidzLIR9S
 ++YX/0Z7qChu0ZEyRNvJmfNTJLFkJWc3y7RTdLLklMZLYoRzgczUAPsxYEXDRO9YxiDwr2mGTuw
 0fZAWDjAWFCP300KxY6PSLZptL4+8K049YNnpqcB3hmEueRt4S5aWqqsGAaQNriACikjai3V2xd
 75/cw5ZZlUqzNfYPK8kjJ66uWHNrA1jZtPJzwOCJn9IPXE8cb9O+Qnip0U3THdkSTKz9nAvp48N
 pf2W8kUAurvXA7BVEOsmrjH1WOvykVouFiRItUs5CEn4tCLSkKDvupMx2CzQeg+pGSHDCCqkfd1
 NBC/G4A416391R+XHR8JbRnIV0nvtj7dWiB1RmpkJRN4466FWJ9Lq5SMRFfylT6teWfI3yXoCxh
 R5h32/4P0dBparNu4ZQ==
X-Proofpoint-GUID: C6ajyHAlx8ul4AXNJL0WtEDKGycAx7ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110188
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/11/26 12:35 PM, Eric Farman wrote:
> Commit 0b83acf2f05 stated:
> 
>     Introduce a source set common to system / user. Start it
>     with the files built in both sets: 'cpu_models_user.c'
>     and 'gdbstub.c' No logical change intended.
> 
> Except that's not true:
> 
>     git show 0b83acf2f0 | grep cpu_models
>         with the files built in both sets: 'cpu_models_user.c'
>     +  'cpu_models_user.c',
>     -  'cpu_models_system.c',
>     -  'cpu_models_user.c',
> 
> Restore the s390x_user_ss section, move "cpu_models_user.c" back
> into it, and re-add "cpu_models_system.c" to the common_system
> section.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---

Thanks Eric.

Besides PCI passthrough this also broke at least s390x virtio-pci due
to missing facilities; I verified both are working again after this
fix.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>  target/s390x/meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> index 44f58ac291..6adc2b896d 100644
> --- a/target/s390x/meson.build
> +++ b/target/s390x/meson.build
> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-features.h',
>  
>  s390x_common_ss.add(gen_features_h)
>  s390x_common_ss.add(files(
> -  'cpu_models_user.c',
>    'gdbstub.c',
>  ))
>  
> @@ -38,6 +37,11 @@ s390x_common_system_ss.add(files(
>    'mmu_helper.c',
>    'sigp.c',
>    'cpu-system.c',
> +  'cpu_models_system.c',
> +))
> +
> +s390x_user_ss.add(files(
> +  'cpu_models_user.c',
>  ))
>  
>  subdir('tcg')


