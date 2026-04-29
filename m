Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C8ECCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6yJ-0004EX-5P; Wed, 29 Apr 2026 11:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI6y7-00049X-Ux
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:37:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI6y6-0000oJ-7b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:36:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TB0OB73309760; Wed, 29 Apr 2026 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nhl+NQ
 cbt83YLupa/fPE40n2Y4IUUOxf6C35zWX/bos=; b=noOhR4ZGBk5IB8MzSrZQ1R
 f5V+jKyxAw/G7xsW1mkR/Md2OofqV1rzQSGcB31rh1TNsAvx4CgmKAa2Jso5sfpm
 ioVAhKhel9CUd98M5RvTzA4T9zb+SQ0ZWm0eg/JQAF4Dz9pRJXfkuBYqh/z8lu0C
 1tpQ24yyA26mOFWSli4iBdDLVcwjVq2HCcSHfbNS8FdtsIW80cAQt8wDZC3DgWxk
 LlbKrV/BeBHK41Lfe9alOAtgESxafphhaaLQx09yblW3kHitJorxl7GPkEl4POCc
 VYDyBDfNFHhewtPKGR+yu0wFPlas+Se4nags3DvMonN378y8dx/ph8yzsiM8xP1A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jt0ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 15:36:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TFNrKo006173;
 Wed, 29 Apr 2026 15:36:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gesdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 15:36:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TFafZM30212800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 15:36:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C335805D;
 Wed, 29 Apr 2026 15:36:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B31A058043;
 Wed, 29 Apr 2026 15:36:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 15:36:40 +0000 (GMT)
Message-ID: <4474547c-0d94-4585-8970-83950d3c75c3@linux.ibm.com>
Date: Wed, 29 Apr 2026 11:36:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260422103018.123608-7-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1NCBTYWx0ZWRfX31Iwz2ezavsu
 otRlxNnzXBe3j1HxAAnvphYRiYg/bw6Awrv3TKfv5xtKbKemOvoeXafynmcHijX25YT8TgtBsv/
 vYUcEO7sigT2wwPEMsmGZECNj0viv9YrW9Ke9YXzHeyd5MG+8b7eINNRgoEnJzZl9CFOodrOlvL
 atwtNAr57zB8ELLOI21zAGCTcaJ0FPoYOjuI5EU6orZzEjIeqSBXc7IS+ex+K1aOenMLyKUK73n
 aAW7my4OzjmJpxYp4IdQq1NcFM/P+jhgpNKOtnjOEjT6UzaDGlpsmhde7mQckqWYSggld/MloBl
 lyS/M/E4pITS+55IcQBZaE2UosQo1nbE1ilTHxUXY1+FgQO5guexfYYqM2zO7VSkFm1NJf5mgIf
 xMkRLDcxPG5ote2FhaaTsOnXua8OqYnHt4FBjcUv+rnxFI7FtUW4wBtkDz1ivPMBrwt59wcftPO
 ZXhHuzSKEE0TgI3ZZ7g==
X-Proofpoint-GUID: -f38caDSx_eaVxCpGum3MG4GLlnHAhQj
X-Proofpoint-ORIG-GUID: _Hu5a8AMFKv4PxOyzmUvjqFVrJVvx49t
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f2258b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=Jps-c9O8ptTWozCDsKcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290154
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 4/22/26 6:30 AM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> - Add subsection in VMState for TPM CRB with the newly introduced
>    command and response buffer GByteArrays, along with a needed callback,
>    so that newer QEMU only sends the buffers if it is necessary.
> - Implement a migration blocker to prevent migration of the VM if the
>    user manually enables chunking capability, cap-chunk, but the machine
>    type does not support it, using a new hw_compat property called
>    allow_chunk_migration.
> - Add a post_load_errp hook so that during a migration, the buffers are
>    validated before destination VM is started.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/core/machine.c |  1 +
>   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 72 insertions(+)
> 
> @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
>   static void tpm_crb_realize(DeviceState *dev, Error **errp)
>   {
>       CRBState *s = CRB(dev);
> +    int ret;
>   
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");
> @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> +    if (s->cap_chunk && !s->allow_chunk_migration) {
> +        error_setg(&s->migration_blocker,
> +                   "The tpm-crb device does not support chunk migration with "
> +                   "machine version less than 11.1");
> +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> +        if (ret < 0) {
> +            return;

Should this do an error_report() and exit(1)?


