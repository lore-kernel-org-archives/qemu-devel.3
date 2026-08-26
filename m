Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A588C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJKH-0001J5-IW; Wed, 26 Aug 2026 15:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzJKD-0001Im-P0; Wed, 26 Aug 2026 15:30:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzJKB-000438-4z; Wed, 26 Aug 2026 15:30:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1cYY3492597; Wed, 26 Aug 2026 19:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2tmQai
 eEKRnrbsqjglQqzLZyUZ5YRtic3uS1dAB/NYg=; b=EcS3a0Yejd83tpQijR8upq
 o3E+cEvOsms8Y6OIpaFBO5/bsxh3PwRfGM3A9gu3labmDQ431w95e92POtMHlU42
 2gAi58XeCSW2lTLitFjzHhGf4vmhARUd4bxvNEjjO9FbzcbS28mg/CGgnU9BSgjw
 CUu5OGKjv+aWCrvB/gaOLdiLjUms9GSf9owHyBfZ+rnQMLQR0PEF+N24Vytk4whE
 GYI78kh+gzzRAH+59FUXSPgXn09kKDBdPLZu/VICZLBJDBoHghr+1H2kK4MWOocA
 BjV/OcX/i6m1o6r7SPY/m99bt421KQpPHmqo4OochwqYuvmZU9lKk/wlUhy3dkoQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726erp55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 19:30:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QJQIb9013931;
 Wed, 26 Aug 2026 19:30:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwbvd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 19:30:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QJU9be53346686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 19:30:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B857758060;
 Wed, 26 Aug 2026 19:30:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C67565805D;
 Wed, 26 Aug 2026 19:30:08 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 19:30:08 +0000 (GMT)
Message-ID: <3b52a781-ea4c-4fec-b059-bebecc27ad3f@linux.ibm.com>
Date: Wed, 26 Aug 2026 15:30:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
 <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f3ec3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=0hWkgQBIRBhdqJmX-EYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX/mtIvIAuFQF0
 8TxopJ40+md/Wb+mUntkmeKYMptZ58756Edls4m/QrUzjnbnieSO6HLvwN9sdKVQRW+tezW2ppi
 mmpl4+ipMxJ/G2IPv2xSpYGUBcIM8Jg=
X-Proofpoint-GUID: zmyMupNJF1b5j3SB0hjzH_KSSKZ4edTw
X-Proofpoint-ORIG-GUID: zmyMupNJF1b5j3SB0hjzH_KSSKZ4edTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX9OwKI53qZ/1e
 MVbpNWj15PGaWPNkuPmBgG5OdaxHTyro3JZL2i4+GrEcNOy+EnJPQeVpp4siEYWQp2rfBHtf7pv
 /75pFU/pRXgR56HksmcOerjVCH6s3Ng/fo5Ox4+m1yvf1TnS1UzCraSuo+p4vc15NG9tboex/N5
 DQ2q9MGLrneHSqPdYFW9jpKn9lRuLJ6OdkQED/iySL+YIncEp680GiNyO2Pd0uXOBkAyVJS7T6w
 HK2Ec4TbJiJ07s3EQfziNW9ePmY81wKtkAil6LjJOzAYRnlw+rErznAyULyRilnk05rnqfOMsLU
 SQqnWVdu1v6VldgO8t8cj37CNi0cpRGm/poCjOG7GvMXSzTj4Ln0W6m2Qwy3cSF9R1Y0oAW/uGz
 3oyXx9rwyxi835m+kV0ruKMiVvm2YI/Kz/iQTXISi7fNwvpR3QYlqY0o19dxhpd0MTwzYmSBCpb
 LNHNUKxT35weJaxJqSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260159
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



On 8/26/26 1:33 PM, Matthew Rosato wrote:
>> +bool virtio_net_setup(void)
>> +{
>> +    switch (virtio_get_device()->ipl_type) {
>> +    case S390_IPL_TYPE_CCW:
>> +        return virtio_ccw_net_setup();
>> +    default:
>> +        return false;
>> +    }
>> +}
> This patch is largely renaming, but this does seem to have a subtle
> functional change right here.
>
> AFAICT before this patch attempting to netboot with anything other than
> a ccw device would hit
> IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
>
> Now, we will never call virtio_ccw_net_setup(), return false and instead
> bail out with
> "No virtio net device found."
>
> That is new behavior for !IPL_TYPE_CCW after this patch.  For
> IPL_TYPE_PCI, patch 4 will change the behavior again.
>
> That's not a deal-breaker, but I do think it's worth a mention in the
> commit message.  I then also wonder if the message
> "No virtio net device found"
> would be more accurate if it instead read something like:
> "No supported virtio net device found"
>
> Thanks,
> Matt
>

I’m not sure this is a valid concern.  A non-ccw net device would be
rejected before getting to virtio_net_setup() earlier at the
find_boot_device() step either way.  In the case of virtio-net-pci
specifically, it would fail because VIRTIO_ID_NET is not a supported PCI
type yet.  For some sort of non-ccw non-pci netboot device, I believe there
wouldn't ever be an IPLB built for it, so it wouldn’t be recognized as
boot eligible at all.  I don’t think this patch affects any of that.

Regards,
Jared Rossi

