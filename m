Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E084ECCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGj4U-0007qF-2R; Wed, 05 Nov 2025 14:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vGj4N-0007pY-VZ; Wed, 05 Nov 2025 14:21:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vGj4L-0008Qj-DX; Wed, 05 Nov 2025 14:21:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5E3OwL011939;
 Wed, 5 Nov 2025 19:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zeu9XB
 wEgk8P6Xn7F56VVlq5oYgj1VPg/kRxUXaoEiw=; b=C0DC5dM6s7Ytr5pPjJXzYg
 CDWbPBMY+JE2qdUNcjJkIOPgwwBfVVdbIbd7eJGJBf+rfKaDgTeh6fdoZePI7DIj
 B86jGQ5tQbifp7xWfwxRe0INwqRTuynn9E5fGQycw+UVVQuFVM5NCyQ9hCesf4xq
 tHprZyqpnr91kN4vcc1X3wqOHvCi0WahpWQa3bUO/nH85lm53mdFAOcWp/pLgjrd
 ligpsi6ceKx0D24hanaz6yMvqZLMdYJj2oem5fLXw31kdbPScmzYDrOrltbzimbJ
 GkJaDODIgjEsPkaqg9+M5ptCc5BIH6LbXRJbfcP7X2KIzYX+OTi7JA2Xsv9Li3ng
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v22rnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Nov 2025 19:21:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HaRju025582;
 Wed, 5 Nov 2025 19:21:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhst0fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Nov 2025 19:21:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A5JL2xc28312290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Nov 2025 19:21:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AC4058054;
 Wed,  5 Nov 2025 19:21:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF6FC58050;
 Wed,  5 Nov 2025 19:21:13 +0000 (GMT)
Received: from [9.61.59.158] (unknown [9.61.59.158])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Nov 2025 19:21:13 +0000 (GMT)
Message-ID: <89a7f911-4d50-4e03-a64e-b11e866f3bd0@linux.ibm.com>
Date: Wed, 5 Nov 2025 14:21:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v6 00/28] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <09faff84-3245-4704-aab6-e7cbb76e1130@redhat.com>
Content-Language: en-US
In-Reply-To: <09faff84-3245-4704-aab6-e7cbb76e1130@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: USd0iV3sGVnpHvYEcbTtybSOY7jpr8_7
X-Proofpoint-ORIG-GUID: USd0iV3sGVnpHvYEcbTtybSOY7jpr8_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXxBQmAQboWfqz
 aiCx/3aqJtAPwQJ78uIvcUZDqs6+c3UcPcojdUf0Nzsf2TCIch0cqqsqkykOMDqIpdkcgRART94
 9Rv6kRdWanlSvbIyafWKx5MJqKwtD35OpwgomvLh9y5mVsWvIJDaKr+rj9HbhpiGe2abc2m3npv
 s+FuaBTEbeWzBevDxFjVM54CPMBgIfYjryoIhkCI1xd7oRW64YFjPvhFvhPrQX0JN30qP/lK3dO
 klycIyZK273ZdDV8zs8tsghyPnt2YcwuScu/97tut19btcXzXozW/2x0ml5FLE+dkYjKk6++Ap8
 NJ11xJol7Svlo3qsNaFNV+/bq5YhLnAOc8YdTifXpzv5FWVE7qTGLsIpEiDGndFyyulI34PGm8F
 ZxWMAqYpdEt2P2qd376E8DEfZWQA9g==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690ba3ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=B4th_E4vnFSxtE3qebAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/26/25 8:38 AM, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
> ...
>>   crypto/meson.build                  |   5 +-
>>   crypto/x509-utils.c                 | 423 +++++++++++++++
>>   docs/specs/s390x-secure-ipl.rst     | 165 ++++++
>>   docs/system/s390x/secure-ipl.rst    | 181 +++++++
>>   hw/s390x/cert-store.c               | 213 ++++++++
>>   hw/s390x/cert-store.h               |  39 ++
>>   hw/s390x/ipl.c                      |  62 +++
>>   hw/s390x/ipl.h                      |  27 +-
>>   hw/s390x/meson.build                |   1 +
>>   hw/s390x/s390-virtio-ccw.c          |  52 ++
>>   hw/s390x/sclp.c                     |   2 +
>>   include/crypto/x509-utils.h         | 131 +++++
>>   include/hw/s390x/ipl/diag308.h      |  34 ++
>>   include/hw/s390x/ipl/diag320.h      |  91 ++++
>>   include/hw/s390x/ipl/diag508.h      |  38 ++
>>   include/hw/s390x/ipl/qipl.h         |   7 +-
>>   include/hw/s390x/s390-virtio-ccw.h  |   3 +
>>   include/hw/s390x/sclp.h             |   4 +-
>>   pc-bios/s390-ccw/Makefile           |   3 +-
>>   pc-bios/s390-ccw/bootmap.c          | 107 +++-
>>   pc-bios/s390-ccw/bootmap.h          |  11 +
>>   pc-bios/s390-ccw/iplb.h             |  96 +++-
>>   pc-bios/s390-ccw/jump2ipl.c         |   6 +-
>>   pc-bios/s390-ccw/main.c             | 111 +++-
>>   pc-bios/s390-ccw/netmain.c          |   8 +-
>>   pc-bios/s390-ccw/s390-ccw.h         |  19 +
>>   pc-bios/s390-ccw/sclp.c             |  52 ++
>>   pc-bios/s390-ccw/sclp.h             |   7 +
>>   pc-bios/s390-ccw/secure-ipl.c       | 781 ++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h       | 212 ++++++++
>>   qapi/machine-s390x.json             |  22 +
>>   qapi/pragma.json                    |   1 +
>>   qemu-options.hx                     |  10 +-
>>   target/s390x/cpu_features.c         |   7 +
>>   target/s390x/cpu_features.h         |   1 +
>>   target/s390x/cpu_features_def.h.inc |   5 +
>>   target/s390x/cpu_models.c           |   7 +
>>   target/s390x/diag.c                 | 555 +++++++++++++++++++-
>>   target/s390x/gen-features.c         |   7 +
>>   target/s390x/kvm/kvm.c              |  34 ++
>>   target/s390x/s390x-internal.h       |   4 +
>>   target/s390x/tcg/misc_helper.c      |  14 +
>>   42 files changed, 3488 insertions(+), 70 deletions(-)
>>   create mode 100644 docs/specs/s390x-secure-ipl.rst
>>   create mode 100644 docs/system/s390x/secure-ipl.rst
>>   create mode 100644 hw/s390x/cert-store.c
>>   create mode 100644 hw/s390x/cert-store.h
>>   create mode 100644 include/hw/s390x/ipl/diag308.h
>>   create mode 100644 include/hw/s390x/ipl/diag320.h
>>   create mode 100644 include/hw/s390x/ipl/diag508.h
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
>   Hi,
> 
> looking at the file list, there does not seem to be any test in this series 
> ... could you please add some functional tests to make sure that the feature 
> is working as expected?
> 
>   Thanks,
>    Thomas
> 

Hi Thomas,

I’m currently working on the functional tests for secure IPL and have
encountered a few blockers, so I wanted to reach out for some guidance.

The main challenge is determining how to provide signed components and
signatures within the tests. In a manual secure IPL setup, we would
generate certificates, use the sign-file script to sign the components
(stage3 binary and kernel), and prepare zipl inside the guest.
Additionally, the signed components would include Secure Code Loading
Attribute Blocks (SCLABs) appended for further validation. These steps
are difficult to reproduce in a functional test environment.

Our current idea is to create a bootable image using the SCSI scheme
with a minimal boot map that includes fake signed components with
hard-coded signatures (and SCLABs if feasible), similar to the approach
used in prepare_image() in tests/qtest/cdrom-test.c. However, this
approach is more complex than expected, and we are unsure how viable it is.

Do you have any suggestions on our current plan or other recommendations
for how we might approach testing secure IPL? I’d appreciate your guidance.

Thank you,
Joy



