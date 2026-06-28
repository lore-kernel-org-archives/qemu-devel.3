Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E34C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 23:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdygj-0004HC-Jk; Sun, 28 Jun 2026 19:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wdyge-0004GM-5A; Sun, 28 Jun 2026 19:13:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wdyga-0003cb-Uk; Sun, 28 Jun 2026 19:13:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SMIcNG1370932; Sun, 28 Jun 2026 23:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/mWraU
 tU2/9FfwBVHKENylovzpp0liloE7tmOIovQ/Q=; b=hPsKwC3BGW57+sia1Ub/Ky
 GCW91lewZKNEki7m1l3qa5pKBlaPHsUEIKK8lysXUHbdrKtPO6hhT/2tXzWiEbmp
 nFC8gMG4Zrl1IIkd+1MgBkSeXFAxJly1D2TUl8yojjomO/a3ocMR8rRGd+tUs7Rx
 6/h/ahiewntMTOZJyg0IZdHGJD47maD3yzq0MzxV7uUPb2EnuvGhWHB5176dTtPu
 zshhl6Br5BX5+rDk7D4XST9XaVwg+6UxeemG+k0jcwkT+5VVux8ekxSRwjjqJ+ZO
 qoXaEl77Cxy/acCRJVKRQjNL3t8SLSOZ+6PRaWO84b4CTNWTgGBIxNKam1E5ltnQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjeh62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 23:13:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65SN4nmM019828;
 Sun, 28 Jun 2026 23:13:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh2yd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 23:13:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65SND8F317826326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Jun 2026 23:13:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0DB58056;
 Sun, 28 Jun 2026 23:13:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 693BB58052;
 Sun, 28 Jun 2026 23:13:07 +0000 (GMT)
Received: from [9.61.16.187] (unknown [9.61.16.187])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 28 Jun 2026 23:13:07 +0000 (GMT)
Message-ID: <e9f04399-5168-4c55-b569-26828394fd00@linux.ibm.com>
Date: Sun, 28 Jun 2026 19:13:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pc-bios/s390-ccw: Verify virtio support when booting
 from PCI device on s390x
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jjherne@linux.ibm.com
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-5-jrossi@linux.ibm.com>
 <6e9b03193bf4c9f91fc3b048bb5351214fd6cbe5.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <6e9b03193bf4c9f91fc3b048bb5351214fd6cbe5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX3ir23ZFXdxml
 OqD1IR6yYNgyRZg6wX3FFBEtMVaWd16ZQSMAp2ZFNmiudFlVvQcum4kkwM0Byexl71KQcsKbB9G
 7l0jt/vEHANFmLP32Us6k7qnENOAMznyg4iPmb4trnlx5Wl3JrRTyf/hmDqoPB7lf5GNQp6su0r
 tzGjM26wlMpn010gJK5JAZrW5GBulr6wtDtAqbi7YGV2HH7vcTarzjusnWOZBfSc/6go9OR8rAP
 bBpSsGjzGXgXYDjidKE3mQT7FH+iHh3PABXL0TK9z0jbcNxsnzCiYPjXLugvucHiGEXJ1H6LbtR
 DgdUdfR4bYwC+kCH+DiDJ2zkwiIwrnfFb/VsrhwhHGNyDw20fuqFB5pTLQ83bbQsiNofv1b3utS
 OdvVLiNUa1IxFwHbsNVzXvt6nTmD7I4zABNCbjrjtszOYZdf09NcPuHmwPstuFATJ9ptcMfmycz
 thoJ/uJTX+HAOALUt3w==
X-Proofpoint-GUID: QY8pAgYAk4Bp6cIuSBr1H1rKOlSaVp62
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a41aa85 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=t0ilmJCUEOi8B3HbffUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX9MOeu7gWHsbj
 RMozDAg/nkS6hdb1jtLsP+q2GjFLfFXVyY3fNCNutQ3KreMN0TaGbfbn62wRYmypIGqVtbC/8/0
 94v2/7U3N+lld/FlPwEeMeeziRW/+84=
X-Proofpoint-ORIG-GUID: QY8pAgYAk4Bp6cIuSBr1H1rKOlSaVp62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280206
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



On 6/23/26 3:34 PM, Eric Farman wrote:
> On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> The virtio specification requires that each PCI device has a vendor ID of
>> 0x1AF4.  Verify this value before continuing with boot process.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c       |  1 +
>>   pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
>>   pc-bios/s390-ccw/virtio.h     |  1 +
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 1059fda03c..567e97bf32 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -164,6 +164,7 @@ static bool find_fid(uint32_t fid)
>>       }
>>   
>>       vdev->pci_fh = entry.fh;
>> +    vdev->vendor_id = entry.vendor_id;
>>       virtio_pci_id2type(vdev, entry.device_id);
>>   
>>       return vdev->dev_type != 0;
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
>> index 2c83ec4f13..07b53b894f 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.c
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
>>       return 0;
>>   }
>>   
>> +bool virtio_pci_is_supported(VDev *vdev)
>> +{
>> +    if (vdev->vendor_id == 0x1AF4) {
> I'd prefer this hex value be lowercase, as they usually are in code.
>
> Not sure where a good place would be, but defining a constant for the PCI Vendor ID 0x1af4 (similar
> to `#define CU_TYPE_VIRTIO          0x3832`) would provide some good context of what's happening
> here.
Good ideas, will do.

>
>> +        switch (vdev->dev_type) {
>> +        case VIRTIO_ID_BLOCK:
>> +            return true;
>> +        default:
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   int virtio_pci_setup(VDev *vdev)
>>   {
>>       VRing *vr;
>> @@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
>>       vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>>       vdev->cmd_vr_idx = 0;
>>   
>> +    if (!virtio_pci_is_supported(vdev)) {
> Why is this done here, versus called from virtio_is_supported() such that it covers both -ccw and -
> pci paths?
>
> I'm guessing it's because the CLP data that contains the vendor_id isn't read until find_fid(),
> which runs against the possible call in probe_boot_device()->is_dev_possibly_bootable(). If there's
> a way to straighten out that chicken/egg I think that'd be useful.
The short answer is that this is an analogous call to the one in the 
virtio CCW setup that also calls the bus specific check directly (which 
seems reasonable given that we are doing the bus specific setup). The 
call from is_device_possibly_bootable() serves a different purpose from 
the ones in the virtio setup functions; both are needed and there isn’t 
any chicken/egg problem with that.


Although you are correct that the virtio_is_supported() generic wrapper 
should contain the case for PCI, so I will fix that now.

>
>> +        puts("Virtio PCI unsupported for this device ID");
>> +        return -ENODEV;
>> +    }
>> +
>>       if (virtio_pci_read_pci_cap_config()) {
>>           puts("Invalid virtio PCI capabilities");
>>           return -EIO;
>> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
>> index 75ae5bdbc2..aa307025e0 100644
>> --- a/pc-bios/s390-ccw/virtio.h
>> +++ b/pc-bios/s390-ccw/virtio.h
>> @@ -259,6 +259,7 @@ struct VDev {
>>       bool scsi_device_selected;
>>       ScsiDevice selected_scsi_device;
>>       uint32_t pci_fh;
>> +    uint16_t vendor_id;
>>       uint32_t max_transfer;
>>       uint32_t guest_features[2];
>>   };
Thanks for the feedback,

Regards,
Jared Rossi

