Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F5CF256B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLe1K-0002vH-FW; Wed, 19 Nov 2025 03:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vLe19-0002uP-5P; Wed, 19 Nov 2025 03:58:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vLe17-0005av-H5; Wed, 19 Nov 2025 03:58:22 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6vE2G002608;
 Wed, 19 Nov 2025 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2xzst+
 M/KECevNyRuf3JejQbSnCIPyxhzMIOIN04hPE=; b=bAPkIQCTic/Nvf0n5x0t8p
 JpO9G4NPdp1/0SOVItAdICCsTdqwCjo7zyYxut8HIkTzzwQydKLToI0Mf8NXuIow
 BffwgsQfPez/7yfOVYgEHSSAs3BUyK6L2QDyGQ29yUhajWfYERZMBqH31PDqnkp8
 DeHENMlafbdGlv3KMkazTGC840SWs95QiIsFyRnmvgwF2oiiFUKp4b898dyaztcZ
 P2/ST8ur37mydCK30w1grHXfv7qW3Nk8sikO/D6q4e4C/pPDuZNw+QoTLUG6DxfS
 1TT0FgqBfpyahaHR3r0MjFx6oMJBGv34k2qo7NWOSFAuk50uKWxANgEhY+MC+wYQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1fg7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 08:58:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7n6t6005065;
 Wed, 19 Nov 2025 08:58:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk7p9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 08:58:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AJ8wB1n25100638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Nov 2025 08:58:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CEAB20043;
 Wed, 19 Nov 2025 08:58:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D877D20040;
 Wed, 19 Nov 2025 08:58:10 +0000 (GMT)
Received: from [9.155.199.94] (unknown [9.155.199.94])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Nov 2025 08:58:10 +0000 (GMT)
Message-ID: <45475213-9f68-40e0-b2ee-a1a7b73591c8@linux.ibm.com>
Date: Wed, 19 Nov 2025 09:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251118174047.73103-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691d86a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=DF9jzra27_ti4jtxTWgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6ZVMm47n9C2S1mtolpi42YfW007y2X9e
X-Proofpoint-ORIG-GUID: 6ZVMm47n9C2S1mtolpi42YfW007y2X9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3Q5jT9BkiDaH
 SaDhqdzFMBhK8Rf8g8GizOvjq/BB6iGKvPD2dqiamLoJ52vaECvd6Z7sLXlegp+d6AE3EcuqqGB
 Iht6oyn9Ppe/Kes1mN5ufsKgfFTA7OxnBt67XGCGx+JlvrlSA1TgcyoVHARUXMugXcxaLhjQgDb
 HzW0sfXbejWo88K+EK/lwIqw+QnRWloAtlxjZkh3UlhoqUhq0R8dqksVjI31pj3ildeFQubO70C
 tzDUlXjX3KLkLwH7oXYa1/fyDBzO0GoAaBZFcR74+i+OQe2eFdovyR5IfrkyD4nYg6AqAHp1OLt
 4zFV/ftXYJkRT0M4fAsOxHWYr9qq79BfkLSuDVfcsLt00Kio3M1H4dpWLA1afDNisaB6dIL3I2I
 KThCNnljNIDUTOD3FVe6BDd0rWhfPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


Am 18.11.25 um 18:40 schrieb Thomas Huth:
> From: Thomas Huth <thuth@redhat.com>
> 
> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.
> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
> 
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices. Like in the
> other branches that detect wrong settings, we return -EINVAL from the
> function, which will later be placed in GPR2 to inform the guest about
> the error.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Certainly a good first step. If needed we can improve further in the future.

