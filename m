Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A1FC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfK0S-0003iR-Od; Thu, 02 Jul 2026 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfK0R-0003iE-NQ; Thu, 02 Jul 2026 12:11:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfK0P-0000KM-3g; Thu, 02 Jul 2026 12:11:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EICZT074639; Thu, 2 Jul 2026 16:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1Ouurz
 tmjU54GM4oYbCh2ipt/vT5dOAixlTr1nnWNhQ=; b=aBiFXhvIzSXhStXjnZMvQU
 Q0OfzVchobUOkbKhoVc9I9/0Rlk8wEea91V25FPk5wtCy2Cbnl8NbePqE/uBPyqb
 PywIOrHFq4ZdNiKN0NNxM6Z1v7ridLybnJMXZiY5MywzB/e4UBzAX3OxWuLXf/6L
 wRRQUaDl25HlsY6d9QToS5Shbp5s961VmR2K9sohjcCB80i9g/N2jzyRYM7GXaN/
 G9iPgZBXA9V00gbUWA4PQEQYLCY6BAH69Kxrta8H8nK+B0+jfj7N939RI4ta9KPj
 Vb5a3Jm0XHr84jeXwBVvcpWim9gQUD9I5Krvkhyk6eckpJmoreRELB2+XuY0nFvw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgauhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:11:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662G4i0h019363;
 Thu, 2 Jul 2026 16:11:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukcrcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:11:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662GB6UL13566528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 16:11:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07BA458059;
 Thu,  2 Jul 2026 16:11:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1BEF58058;
 Thu,  2 Jul 2026 16:11:04 +0000 (GMT)
Received: from [9.61.149.146] (unknown [9.61.149.146])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 16:11:04 +0000 (GMT)
Message-ID: <73ef786b-6c65-4b7d-88e3-5b4099fbbb86@linux.ibm.com>
Date: Thu, 2 Jul 2026 12:11:03 -0400
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
 <d8fb862c-1e18-4989-b16f-4fb33330e5d1@linux.ibm.com>
 <8c406a31-8c43-4d6a-a729-d3568b515fce@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <8c406a31-8c43-4d6a-a729-d3568b515fce@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a468d9c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_mz74e-EMjZrI4tHwz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfX+nB2naap9/BZ
 Mgh5D1ePNmQb9n1sjhRPuPv+tH0t8+jO0URAepBqAQbLzYajkYUDKNCEKmNpTYIOC5IXV4zsQcU
 iVPgOUbxW+NlyX0yHeTN3ubRX+9WgEI=
X-Proofpoint-GUID: 6Zsa7US7-sy6NB8EDGK-3fC8An-XblIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfX2opp6ymjyRS0
 QRLnMcMk0oPhF91ZBmfEdtzUDizn3eSvbfseX6GIPAl4Cz2zbDdyxE16XftmBByhPOo/WnRPMXS
 rrOXykKFVEL1yJXnYpDmDYZLTEeegdnl/SXk5a5S15Mk6wpXaqRvUSqTe1LVctQphDtbBkkBRdl
 valCEDph9p1n8YHLFcqLPL1GtakJY75sPlqN9nRxiLR+qm+V3/R3e/L53K3OEnwT0xcdzGKfgQe
 YW2XRpBF0XallJSjghtFrcxITiZnCrLhgpEc7mToIYscbc43yZ85OkoSrd3X+/hh7eNCudAKVNw
 vsu42csKDK2kiAvtNm8xryV0knoHtPprIGoMOWPxkx3F8w2mN64F3XmQZk/dIOwc4Si3IEsgUai
 j/L0HR5rUdLOkGbUmmChKDiKp8gY1DHPMaK2WGeRA1c2XS6Jv0ieDCdpu+1oP7hlIcY02m4ZvCh
 JCsi8jfqO30MPOcBXBQ==
X-Proofpoint-ORIG-GUID: 6Zsa7US7-sy6NB8EDGK-3fC8An-XblIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020166
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



On 7/2/26 11:26 AM, Zhuoying Cai wrote:
> Thanks for the feedback!
>
> On 7/2/26 10:13 AM, Jared Rossi wrote:
>>
>> On 7/1/26 4:49 PM, Zhuoying Cai wrote:
>>> Enable secure IPL in audit mode, which performs signature verification,
>>> but any error does not terminate the boot process. Only warnings will be
>>> logged to the console instead.
>>>
>>> Secure IPL in audit mode requires at least one certificate provided in
>>> the key store along with necessary facilities (Secure IPL Facility,
>>> Certificate Store Facility and secure IPL extension support).
>>>
>>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>>> virtio-blk/virtio-scsi devices.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>    docs/system/s390x/secure-ipl.rst |  15 ++
>>>    pc-bios/s390-ccw/Makefile        |   2 +-
>>>    pc-bios/s390-ccw/bootmap.c       |  27 +++
>>>    pc-bios/s390-ccw/bootmap.h       |   9 +
>>>    pc-bios/s390-ccw/jump2ipl.c      |   7 +
>>>    pc-bios/s390-ccw/main.c          |  18 +-
>>>    pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>>>    pc-bios/s390-ccw/sclp.c          |  27 +++
>>>    pc-bios/s390-ccw/sclp.h          |   6 +
>>>    pc-bios/s390-ccw/secure-ipl.c    | 362 +++++++++++++++++++++++++++++++
>>>    pc-bios/s390-ccw/secure-ipl.h    | 116 ++++++++++
>>>    11 files changed, 607 insertions(+), 2 deletions(-)
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>>
>> [...]
>>> +
>>> +void update_cert_list(IplSignatureCertificateList *cert_list)
>>> +{
>>> +    IplSignatureCertificateEntry *cert_entry;
>>> +    uint8_t *cert_buf;
>>> +
>>> +    cert_buf = (uint8_t *)qipl.ipl_data;
>>> +
>>> +    for_each_rb_entry(cert_entry, cert_list) {
>>> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
>>> +        cert_entry->addr = (uint64_t)cert_buf;
>>> +        cert_buf += cert_entry->len;
>>> +    }
>>> +}
>> This looks like the correct idea but I think it needs additional
>> validation.  Firstly, as Eric mentioned, there is no check that the size
>> of our cert entries don't exceed the qipl.ipl_data space.  I know there
>> are implicit factors such as maximum certificate size and such that
>> limit it in a way that it shouldn't be possible, but we should still check.
>>
> At the beginning of zipl_run_secure(), I added a check to ensure that
> there is enough space to store the certificates required for the current
> IPL. We store the certificates directly in the qipl.ipl_data area rather
> than storing cert entries (IplSignatureCertificateEntry) in qipl.ipl_data.
>
> As discussed previously and documented here
> (<https://www.ibm.com/docs/en/linux-on-systems?topic=keys-required-signatures>),
> an IPL requires at most two, and possibly three, signed components,
> meaning that at most three certificates are needed. Based on that, I
> check that MAX_SIGNED_COMP * CERT_BUF_MAX_LEN does not exceed
> CERT_BUF_SIZE, ensuring there is sufficient space for the certificates
> used by the current IPL. Please let me know if you think any additional
> validation is needed.

That check is good.  I think it could be a compile time check though 
since everything is constant.

I guess the reason this feels fragile is because the size of the 
iplb_chain array determines the size of the ipl_data area, and the chain 
array size itself is determined by a magic number 7 in hw/ipl.c.  We 
need to change that line anyway to initialize the chain to zero as Eric 
pointed out, so lets also use MAX_BOOT_DEVS - 1 instead of just magic 
7.  This way we can also add another compile time check:

(sizeof(IplParameterBlock) * (MAX_BOOT_DEVS - 1)) == CERT_BUF_SIZE

which will ensure that any potential changes to the either the cert 
buffer size and/or number of allowed boot devices will be kept in sync 
for the shared buffer area.

>
>> Secondly and more critically, you need to reset the qipl.ipl_data
>> address to it's initial value before reusing it.  I don't think I saw
>> that done anywhere.  The address is incremented after each IPLB is
>> loaded from the chain (see the load_next_iplb() function in iplb.h), so
>> if we in theory had started with 7 IPLBs in the chain and loaded all of
>> them, and if we then copied the maximum allowed size of certificate
>> entry data, we would exceed the qipl.ipl_data upper limit and probably
>> clobber the kernel.
>>
>> I think the easiest way to restore the qipl.ipl_data address to its
>> initial value is to track how many IPLBs we've used, multiply that by
>> the size of the IPLB, and then move the address back by that amount.
>>
> Thanks for pointing this out. I missed resetting the qipl.ipl_data
> address before reusing it. I'll restore it to its initial value before
> copying the certificate data. Thanks!
>
>> Regards,
>> Jared Rossi

Thanks,
Jared Rossi

