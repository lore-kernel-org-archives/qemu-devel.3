Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC9DCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 16:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utqgd-00034P-1E; Wed, 03 Sep 2025 12:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utqgU-00031B-NX; Wed, 03 Sep 2025 12:50:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utqgK-0005DZ-FU; Wed, 03 Sep 2025 12:50:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5838LqwI024416;
 Wed, 3 Sep 2025 16:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BGgVPh
 A+e79IMMmuEKoPnYspO2G2waS9H/4cKORNQ18=; b=eBSD1+kzsyasRNVp51MVgs
 L8X7Vw6JngsOKPDld5g2fxp5lfFch7ElYkWmes+egJoDdSAh9GTOrGrV9950EjuI
 65N+oSY7ST1TBA0pg4AfAb6w/gNfi/H6i+m7JxgUnzx4Op3HFnEdC1CoEpUWT5LW
 tC+0hBWIzYYBWOWCvEco8e2paSZQVaylkS06DU6WBJnKDY2vYskBQI4N3YdNP5Eo
 cri+602wShaYhYvGuBS54COrp8tCOIOgKVSwH6H6z2tGP64Ginx10vyCN5ks69jE
 UBq0T3kGW1pUb8txdS8NOFer6ZRvc1CjrJliXECJDczvFFGsAqK3YzWV2QXsUXvA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvfw886-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 16:49:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583Eiv0I021184;
 Wed, 3 Sep 2025 16:49:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmprdnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 16:49:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 583Gnn9t30999134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Sep 2025 16:49:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5448758053;
 Wed,  3 Sep 2025 16:49:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AEA958043;
 Wed,  3 Sep 2025 16:49:48 +0000 (GMT)
Received: from [9.61.246.70] (unknown [9.61.246.70])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Sep 2025 16:49:48 +0000 (GMT)
Message-ID: <17b1213d-d076-4e0f-b43e-657abc002e9c@linux.ibm.com>
Date: Wed, 3 Sep 2025 09:49:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] vfio/pci: Add an architecture specific error
 handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-3-alifm@linux.ibm.com>
 <0699f897-3aeb-4104-919b-c96cdab4d4e7@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <0699f897-3aeb-4104-919b-c96cdab4d4e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b871af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=4C1YyXFA__UUwgCo5VYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oQodvPEjFLLpeK-G1a9G2RMzC1TuZr_N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXzNhXbWwxkAh2
 lUvXs/fIi6O5dOkw9i+a/fvUOOnIb9DFkl4O9MPiJK/k6zlgJoSAcd7GY9jr5kD3en0c8tJKm91
 Xx9+vEphuQR1hzuuLb2o/EeKOBXl+6Ab1uf3KrLIaxPBDf/fZH8xcSv0cMJ6MkP4mto4Apel3tT
 J9FSCPLrLraPOhtIV/UdL3RpH2F6yEszhtH5TjM7t/p9YHaoDtg6PERoLNMn1Cga2BOt0u1FZUW
 EUYwmVwukXowpr8czpY/vq4smlCEcVq+vMlkzebofmpI1js++oElXGA/vADGKeBnA1QSklX4wLt
 mdf7eld3rP3/Khhvx8CI8mlnb71XRTA/EOaQaumRoBFrmHHlzGCkIgKAe3v4ZBlVcLJDXpDcHRg
 RH4tC23A
X-Proofpoint-GUID: oQodvPEjFLLpeK-G1a9G2RMzC1TuZr_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/1/2025 4:28 AM, Cédric Le Goater wrote:
> On 8/25/25 23:24, Farhan Ali wrote:
>> Provide a architecture specific error handling callback, that can be 
>> used
>> by platforms to handle PCI errors for passthrough devices.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c | 5 +++++
>>   hw/vfio/pci.h | 1 +
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 07257d0fa0..3c71d19306 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3026,6 +3026,11 @@ static void vfio_err_notifier_handler(void 
>> *opaque)
>>           return;
>>       }
>>   +    if (vdev->arch_err_handler) {
>> +        vdev->arch_err_handler(vdev);
>
>
> I am not sure that the "architecture specific error handling"
> will be implemented this way but we need to check for potential
> errors.

Thanks for reviewing, do you have any suggestions on how to implement 
the architecture/device specific error handling?


>
> So, please make the handler return a bool and add an extra
> 'Error **' parameter.
>
>
Sure, I can change that. Are you suggesting the change to bool return 
for the handler to report any failures in the handler (through errp)?

Thanks

Farhan

>
> Thanks,
>
> C.
>
>
>
>
>> +        return;
>> +    }
>> +
>>       /*
>>        * TBD. Retrieve the error details and decide what action
>>        * needs to be taken. One of the actions could be to pass
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 810a842f4a..45d4405e47 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -145,6 +145,7 @@ struct VFIOPCIDevice {
>>       EventNotifier err_notifier;
>>       EventNotifier req_notifier;
>>       int (*resetfn)(struct VFIOPCIDevice *);
>> +    void (*arch_err_handler)(struct VFIOPCIDevice *);
>
>>       uint32_t vendor_id;
>>       uint32_t device_id;
>>       uint32_t sub_vendor_id;
>
>

