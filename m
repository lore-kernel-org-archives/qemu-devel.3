Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1472ACEDDAE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syi7z-0002xb-2G; Wed, 09 Oct 2024 21:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7x-0002wz-NR; Wed, 09 Oct 2024 21:38:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7w-0007XB-7a; Wed, 09 Oct 2024 21:38:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A1IHBP004688;
 Thu, 10 Oct 2024 01:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=K
 QjUH2/LZ1OOFwRFAlKl/Cofos10RIlQoFRo55Bpxeo=; b=Nh0bu9OSfJj5n97NV
 6OKx7vtoPb51qoZSmVK+Hvwhjh0TWhp89b8xmk1Q+otCbYSxMzwyVxZ1Xt3QihR3
 retHzwsQrWn5GQUoDOg8h7/oDTU0EspVONlzBaqWC8w79Kf4N6kJqR6AT7dcF9Le
 w/rkSbGylXsUdNx2DLm7S6C60+aaMck0QGpz9jypOaakOBje6QNOIU3cLmbvvaxp
 5anLf6QO5QCXQayg1QNiTy3id1J2j0jzAkjF4Au097RQug6IXGmrEE5HjSActTtp
 WUeqipp0QxJF9HMvV/2P9IoFS/Xzy/8MTJceTdL8gp+eortTdPg8usqbXPuKbhFi
 r5uMA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42653qg1e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:38:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A1c2VU008287;
 Thu, 10 Oct 2024 01:38:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42653qg1e6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:38:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499MfYg8022856;
 Thu, 10 Oct 2024 01:38:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9k52xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:38:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A1c16u16056928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 01:38:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 084975805E;
 Thu, 10 Oct 2024 01:38:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F75F58056;
 Thu, 10 Oct 2024 01:38:00 +0000 (GMT)
Received: from [9.61.177.235] (unknown [9.61.177.235])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Oct 2024 01:38:00 +0000 (GMT)
Message-ID: <7211ed56-4b62-4cec-8a88-13ee60842406@linux.ibm.com>
Date: Wed, 9 Oct 2024 21:37:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] pc-bios/s390-ccw: Remove panics from SCSI IPL
 path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-10-jrossi@linux.ibm.com>
 <911b4020-c60e-4a74-a61d-3ce370a3a878@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <911b4020-c60e-4a74-a61d-3ce370a3a878@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Q6PxwNSoEG4-hh0cjM-BnnqTzaDphQx
X-Proofpoint-GUID: X5BqT_tT0vugIgV5lOcFPR_SgnXFvKKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_22,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100005
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/9/24 7:18 AM, Thomas Huth wrote:
> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>> +    if (!vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title)) {
>> +        puts(title);
>
> Should there be a "return" with a non-0 value here? ...
>
>> +    }
>> +
>> +    return 0;
>>   }
>>     /* SCSI protocol implementation routines */
>>   -static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
>> +static int scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
>>                            void *data, uint32_t data_size)
>>   {
>>       ScsiCdbInquiry cdb = {
>> @@ -110,12 +122,13 @@ static bool scsi_inquiry(VDev *vdev, uint8_t 
>> evpd, uint8_t page,
>>           { data, data_size, VRING_DESC_F_WRITE },
>>       };
>>   -    vs_run("inquiry", inquiry, vdev, &cdb, sizeof(cdb), data, 
>> data_size);
>> +    int cc = vs_run("inquiry", inquiry,
>> +            vdev, &cdb, sizeof(cdb), data, data_size);
>
> ... since the caller site now obviously checks for a non-zero value!
>
>> -    return virtio_scsi_response_ok(&resp);
>> +    return cc ? cc : virtio_scsi_response_ok(&resp);
>>   }
> ...
>> @@ -207,7 +221,7 @@ static int virtio_scsi_locate_device(VDev *vdev)
>>       static uint8_t data[16 + 8 * 63];
>>       ScsiLunReport *r = (void *) data;
>>       ScsiDevice *sdev = vdev->scsi_device;
>> -    int i, luns;
>> +    int i, cc, luns;
>>         /* QEMU has hardcoded channel #0 in many places.
>>        * If this hardcoded value is ever changed, we'll need to add 
>> code for
>> @@ -233,13 +247,21 @@ static int virtio_scsi_locate_device(VDev *vdev)
>>           sdev->channel = channel;
>>           sdev->target = target;
>>           sdev->lun = 0;          /* LUN has to be 0 for REPORT LUNS */
>> -        if (!scsi_report_luns(vdev, data, sizeof(data))) {
>> +        cc = scsi_report_luns(vdev, data, sizeof(data));
>> +        if (cc < 0) {
>> +            return cc;
>> +        }
>
> By the way, calling a variable "cc" reminds me of the CC of the PSW, 
> so I'd expect values from 0 to 3 for this variable. Obviously this was 
> meant to convey negative error codes instead, so I'd like to suggest 
> to rename that variable to "ret" or something similar instead.
>
>> +        else if (cc == 0) {
>>               if (resp.response == VIRTIO_SCSI_S_BAD_TARGET) {
>>                   continue;
>>               }
>>               printf("target 0x%X", target);
>> -            virtio_scsi_verify_response(&resp, "SCSI cannot report 
>> LUNs");
>> +            if (!virtio_scsi_verify_response(&resp, "SCSI cannot 
>> report LUNs")) {
>> +                return -EIO;
>> +            }
>>           }
>
>  Thomas
>

Fixed the missing return and also changed the variable to "ret" instead 
of "cc" as suggested.

     Jared

