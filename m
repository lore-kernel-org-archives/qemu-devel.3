Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A9C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIAL-0002BW-AE; Thu, 02 Jul 2026 10:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfIAH-0002Aq-Mg; Thu, 02 Jul 2026 10:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfIAF-0006xV-CV; Thu, 02 Jul 2026 10:13:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KIwD2509464; Thu, 2 Jul 2026 14:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jBmQYn
 B/5qzq79sh4Ib1zpXghENZgr0eoQ5pRDEmzv4=; b=GmLYK/9zXHFTqdvt7N2TWN
 NQsYmvaKbcSnLGFeQZoxLXTkmoDB/v0lLgsTyY/Rkwy5dIjliC1uJQyen8RF/QXv
 8csr25Zth0xfjyFj8Vf55smhrTY8bPLcdLJoWMo6nkUghpyHWjZ0xuvYT3fxBgi7
 ft01RBxf73krvk8J1YZlFfw1oef9gsygk3v90c/zWedAD/RJcI92M6vshEtM7sJP
 2Q7uqEBUh3atg0WCthrAL7fITtSdzamt8XLnMhCS49MDIuTmmyM017XeYoaN+7Kr
 x2J/Khn74SaNfn1Lu4vP0jLG8Fw42UYnvdLnBWCNYo+j+HI2BmgyZfhAMgmdnqGA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peadh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 14:13:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662E5lFC030874;
 Thu, 2 Jul 2026 14:13:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wcdhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 14:13:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662ED8BJ27919084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 14:13:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B845D58056;
 Thu,  2 Jul 2026 14:13:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DFFB58052;
 Thu,  2 Jul 2026 14:13:07 +0000 (GMT)
Received: from [9.61.149.146] (unknown [9.61.149.146])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 14:13:07 +0000 (GMT)
Message-ID: <d8fb862c-1e18-4989-b16f-4fb33330e5d1@linux.ibm.com>
Date: Thu, 2 Jul 2026 10:13:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/35] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-24-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-24-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9M31_eo3CnDXjDBoWFmgeZAIo7QNMEd9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX/Oyikq8nWBOn
 6dzEQh9DunLRff0feiPIl8mb8eCQ6QR3ZVth7pkoBfp4e2Y1oqgPnqDqgjnjzcaDWEFvU/BXn8Q
 MjY5srv7q6i34SKI07NIqafKGpjy+uc=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4671f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UqHoEE1oasUoOjSkpRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxEw662l2raO5
 mOHPgJzbrSePLgiWW9wMSlCFqH7+0vbcilEb76PQhUeFl/p42pTBiH2J7R8uG+slsM3MxKqDlqQ
 dBINyagIQSUJhmfTG+F7BnqMA7NSIvluWypT6ReF9AWrYCm4ZaPnGb1XcWFlc+3oK8aTnZp02D1
 NjKCcc+HqMZITU3sDd7Tvmg2yWJ2YRMVxOQ0X5sKbPU3jF6epXZI+k3DfLybRHk8B/0qYBaQ+ME
 bIXNUG5ROVPTohxgIVuNGibd+fKGeRn5ynAsP5nFtknYXNonYs9KJFAEL8y8fG+cCBS83ToXzg2
 mSXUk4t3lj/Zedg7pfIuKNPLoD7z/uzCMr5rHfPdTY1L0fuLyAlwPB/c78Fo3uh0z4bdE2YW4Ql
 ZiIJ0rPmOhQMBAvKOfdnWRyaoTb4C1OjalJaIk/2wSs5IsTL32OXr8F0tDFFxNeocMK8/Yp5tPl
 pvz5ENAxmPT8jtb+WKg==
X-Proofpoint-ORIG-GUID: 9M31_eo3CnDXjDBoWFmgeZAIo7QNMEd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
>
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
>
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst |  15 ++
>   pc-bios/s390-ccw/Makefile        |   2 +-
>   pc-bios/s390-ccw/bootmap.c       |  27 +++
>   pc-bios/s390-ccw/bootmap.h       |   9 +
>   pc-bios/s390-ccw/jump2ipl.c      |   7 +
>   pc-bios/s390-ccw/main.c          |  18 +-
>   pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>   pc-bios/s390-ccw/sclp.c          |  27 +++
>   pc-bios/s390-ccw/sclp.h          |   6 +
>   pc-bios/s390-ccw/secure-ipl.c    | 362 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h    | 116 ++++++++++
>   11 files changed, 607 insertions(+), 2 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>
[...]
> +
> +void update_cert_list(IplSignatureCertificateList *cert_list)
> +{
> +    IplSignatureCertificateEntry *cert_entry;
> +    uint8_t *cert_buf;
> +
> +    cert_buf = (uint8_t *)qipl.ipl_data;
> +
> +    for_each_rb_entry(cert_entry, cert_list) {
> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
> +        cert_entry->addr = (uint64_t)cert_buf;
> +        cert_buf += cert_entry->len;
> +    }
> +}

This looks like the correct idea but I think it needs additional 
validation.  Firstly, as Eric mentioned, there is no check that the size 
of our cert entries don't exceed the qipl.ipl_data space.  I know there 
are implicit factors such as maximum certificate size and such that 
limit it in a way that it shouldn't be possible, but we should still check.

Secondly and more critically, you need to reset the qipl.ipl_data 
address to it's initial value before reusing it.  I don't think I saw 
that done anywhere.  The address is incremented after each IPLB is 
loaded from the chain (see the load_next_iplb() function in iplb.h), so 
if we in theory had started with 7 IPLBs in the chain and loaded all of 
them, and if we then copied the maximum allowed size of certificate 
entry data, we would exceed the qipl.ipl_data upper limit and probably 
clobber the kernel.

I think the easiest way to restore the qipl.ipl_data address to its 
initial value is to track how many IPLBs we've used, multiply that by 
the size of the IPLB, and then move the address back by that amount.

Regards,
Jared Rossi

