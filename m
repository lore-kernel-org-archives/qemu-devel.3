Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F0F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTW-0007Fx-5E; Fri, 10 Apr 2026 15:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wBHTU-0007DB-5K; Fri, 10 Apr 2026 15:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wBHT9-0002c6-DX; Fri, 10 Apr 2026 15:24:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ACe27O2393155; Fri, 10 Apr 2026 19:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eZC1DD
 bUT/KZmhAHpwpl79/7zhP4dRDixCREEA+6lmA=; b=XwohZSoufAbrU4+IXf6MN4
 nQgVKh+TqJKylSjk4c013UwXxz9auU4C39xXmOjH+SbM+ufS38OtCR3F9BLeyVTw
 lh2LUUOGnoOor7Px69iJclQazNp19eI3fPV96z/e9jv6wNYNkGGyeTllm664wRxI
 rDLGPN08MPlFCpAK7YWD74h/BvluWgJzAVumRi9TcEkux6bxkabPog8mP7Op55g/
 +l7eDJcaNvODPv45G0tVTIgE+wkln4UwDZk/ee1U/F+9+2XzkoozrepSGF7zRAiI
 YlwTv7L/niHS+g4WuvFLblQWWCi0afr3vbrAohQfXOSMNTvUqoZHcw8L+eIqlvew
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ktjw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 19:24:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AGfTQX013827;
 Fri, 10 Apr 2026 19:24:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4hner-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 19:24:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AJOZZM10420796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 19:24:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBBCA5805F;
 Fri, 10 Apr 2026 19:24:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E7F58054;
 Fri, 10 Apr 2026 19:24:33 +0000 (GMT)
Received: from [9.61.102.229] (unknown [9.61.102.229])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Apr 2026 19:24:33 +0000 (GMT)
Message-ID: <cdea49f0-cf04-4f5a-b830-dc8ae3583ab4@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:24:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/30] pc-bios/s390-ccw: Refactor zipl_run()
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-18-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE4MSBTYWx0ZWRfX9/6e321xqjua
 ESl826gd3+g2OjufbrKzIxLvy6hywK+GvLAycPrhEOm2u3ORnyXTOd06g12nzp0HBBN3+kxCr4R
 TQaz7uwCPbp8K8jL3pdjyaNLnYGM+Y5fNPb5ux9ZBH5wZzvHy+RA/weINGEeE5Bc6NgJTkd2DEH
 JDsvTfJwbyRgKl9Pkv0FdSungbtA5UBlr7ByC9xJyvns3utrUbpF/B/yYd1hMz/kom0GSi65uJ8
 1TTX3zDy8wnGOE++UvK6HruK35vlLL1hBKr9iObe9HMNcw43BSrz0CJUFAKPZrzVCA4CTLzIsyp
 lCdPcYeFMZXMzzmhaEUru9oVxeaP+vOdBF9mnomd43fqakj5Gdn0+ULSU/ead2fDKPpuIoVES61
 qCYwr3O1Jhiw1H+jIkzVRyMZTRQwsyIrgaemfsl+GeW455iO1R0WjR+Wnn9x6+OkXzg2iwyhFMl
 4zJ02/SbW5nS/lr5krg==
X-Proofpoint-ORIG-GUID: NNmgdv7JJFMas5YXo9HKIWe9f6Fd9E0o
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d94e75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=qUDVhwQ4_YTjJ83ndlkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NNmgdv7JJFMas5YXo9HKIWe9f6Fd9E0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100181
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 4/2/26 6:14 PM, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 51 ++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 420ee32eff..b9ba004cfc 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -674,12 +674,42 @@ static int zipl_load_segment(ComponentEntry *entry)
>       return 0;
>   }
>   
> +static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> +{
> +    ComponentEntry *entry = *entry_ptr;
> +
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        /* Secure boot is off, so we skip signature entries */
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            entry++;
> +            continue;
> +        }
> +
> +        if (zipl_load_segment(entry)) {
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    *entry_ptr = entry;
> +    return 0;
> +}
> +
>   /* Run a zipl program */
>   static int zipl_run(ScsiBlockPtr *pte)
>   {
>       ComponentHeader *header;
>       ComponentEntry *entry;
>       uint8_t tmp_sec[MAX_SECTOR_SIZE];
> +    int rc;
>   
>       if (virtio_read(pte->blockno, tmp_sec)) {
>           puts("Cannot read header");
> @@ -700,25 +730,10 @@ static int zipl_run(ScsiBlockPtr *pte)
>   
>       /* Load image(s) into RAM */
>       entry = (ComponentEntry *)(&header[1]);
> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> -           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -
> -        /* We don't support secure boot yet, so we skip signature entries */
> -        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -            entry++;
> -            continue;
> -        }
> -
> -        if (zipl_load_segment(entry)) {
> -            return -1;
> -        }
>   
> -        entry++;
> -
> -        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
> -            puts("Wrong entry value");
> -            return -EINVAL;
> -        }
> +    rc = zipl_run_normal(&entry, tmp_sec);
> +    if (rc) {
> +        return rc;
>       }
>   
>       if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {

Reviewed by: Jared Rossi <jrossi@linux.ibm.com>

