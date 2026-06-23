Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C4CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbpBY-0004dC-R4; Mon, 22 Jun 2026 20:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wbpBW-0004ci-Pu; Mon, 22 Jun 2026 20:40:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wbpBV-0003F3-3j; Mon, 22 Jun 2026 20:40:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmmNQ3896521; Tue, 23 Jun 2026 00:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iIihPr
 3z2JqIz+vXut6CXh9xBxclum/dLyX0A+NUz74=; b=B9jjhj9v+7oYniHEUznmWj
 q03etdVX1IpIbzIpQQ7z2F12zisOys9pL254lGMkibKsqVZm7PReYSfKnD+VMc1d
 G+CYPnMR/0Rdsd28uesuL63SbB/VYLpmtSrMa0cyS1WzmKoy62sxKttTx/lNZP+8
 +pQISGvt8vQ0mf9RyC+gl8YqlE/PWcSRg0ZjklMW8JEVyLvWgU/xUHStc+8rQaJ0
 5EAkQEFOp4zlsKMGyuoVmz0G6fT5yIsBXoUdlqOh3LnXceg3PNelwBdOY/6GPHqN
 0YG2oF7xd7LQig34lXR5uh9/3bz8fKf74+gAKg0VaZwbwm+WwnAeqLewhjapiIbQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hm7f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:39:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0YdKa011998;
 Tue, 23 Jun 2026 00:39:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg0jqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:39:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0dsjG36700820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:39:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C726E58054;
 Tue, 23 Jun 2026 00:39:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8B45805C;
 Tue, 23 Jun 2026 00:39:53 +0000 (GMT)
Received: from [9.61.116.241] (unknown [9.61.116.241])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 Jun 2026 00:39:53 +0000 (GMT)
Message-ID: <04b7331b-3ebd-4084-96ab-45d4a8c86216@linux.ibm.com>
Date: Mon, 22 Jun 2026 20:39:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pc-bios/s390-ccw: write IPLB location for
 virtio-blk-pci IPL
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, nrb@linux.ibm.com
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-4-jrossi@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260623002539.126124-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qcY8DgeBrxET0JZ0rz5gIEnpvImAvuWI
X-Proofpoint-GUID: qcY8DgeBrxET0JZ0rz5gIEnpvImAvuWI
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39d5dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1QwwLMC8RHuqkPhqMQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX3TDS0H19y1L4
 kfvuKUTLtTGG16m47jKGCcLTdkHw+OmkP3UB2x3JR1oP3a45xGaELw6B0HKR+9OUAfk1WYEQDPa
 v/cUUteUEgAKxAI+OMyLNroFhe/oBy/2fNQuy6NJrdMlxgaNh4+nbDojczz96tUeLWTBk1vkURx
 KgGP1BuenvXh/fy+/9lmvfDrHxfDx8a6oFI3/Ieo1vcvc36zB3Qd0eh7cqrh7tj9FZ85MLtXgk+
 QaWLzFL8vF1nMZ71q5jtfLxx2yoi9TUxKiC76ihVuJSt9n8T6UYW+3sufD9vCi8ZlzopxOEfrLG
 h96r3q3ys8LUbX0qQelpJoK8KON9lDggXVuhGkVS3JTnK5lZ2xNH0X3a35+fPk8DDT91ml2ff2q
 8y4fHi79Hd9GiH2iS3Mg94sHrwj3pCm6LbqaHv6J1Y+oyj8ZTcRFshI2xIkwncWnnnZisEQgdZ5
 yRgh2sXsL4KHKwFeMHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX7cUpUGq68p1f
 /Kdwzg+FHJ6Zj9AG2SSqMGb1+1IYpvuY1wYv5JobKhrV+TE1MDXqZQ5Ti+tJ7c8i5IQ/2rCIqEk
 sVyQeW3c23MXmw4PGpXZ1KSIy0u73lo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
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

Sorry all, I had a mental lapse when adding my sign-off to a couple patches
in this series.

Disregard <jrossi@us.ibm.com>
It should be:

signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

On 6/22/26 8:25 PM, jrossi@linux.ibm.com wrote:
> From: Joshua Daley <jdaley@linux.ibm.com>
>
> When IPL type is PCI, cutype is unknown, so the IPLB location does not
> get written to lowcore. Update the condition to check IPL type as well.
>
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> signed-off-by: Jared Rossi <jrossi@us.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 26287cfd81..1059fda03c 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -52,7 +52,8 @@ void write_subsystem_identification(void)
>   
>   void write_iplb_location(void)
>   {
> -    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
> +    if ((cutype == CU_TYPE_VIRTIO || iplb.pbt == S390_IPL_TYPE_PCI) &&
> +        virtio_get_device_type() != VIRTIO_ID_NET) {
>           lowcore->ptr_iplb = ptr2u32(&iplb);
>       }
>   }


