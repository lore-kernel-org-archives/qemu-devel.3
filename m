Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D5C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x961t-0008Qw-Jb; Tue, 22 Sep 2026 15:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x961m-0008Q7-ID; Tue, 22 Sep 2026 15:19:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x961k-00026n-Mr; Tue, 22 Sep 2026 15:19:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7A8u4143683; Tue, 22 Sep 2026 19:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HGIc4i
 tAwTd3YjReuOIxIV4yLwmYgpTPJmlfP8lY+/k=; b=ggod5GXJewSjTa5NA7zfsB
 ToCFJLyCQDB33McfeY0Pw7ZL8rKP0iAOjRT85FiiQmsSPS+AkQHRRJ9IBCuGfPoW
 Y48Zmvv0pnIXMJslhzvD/g1v+c3ZpkdgiN4wj9esvuTT+umVLfwqamiXtjGD12/c
 ziz1Qw6Zoyq/eBGtShMVR7dmQOK3p8zL5dfv7sPjumk7ujQQl4DHAgT6FXzFtbVa
 GHaSqctvbyj+AWU5Y/q+92Ygrik4nWD7t5j7ap/qAOdHWBIHFpsG3VhD4p3rwLI4
 lg5pea2I+6liL1bF7teraB9+VDXintntmwXtLf9QoHCU12Pk5DD1ur3Wfd55QmYQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqf6ty-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:19:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHdD83279475; Tue, 22 Sep 2026 19:19:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqb9qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:19:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJJYrC29294860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:19:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1B3C58055;
 Tue, 22 Sep 2026 19:19:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 952095804B;
 Tue, 22 Sep 2026 19:19:33 +0000 (GMT)
Received: from [9.61.245.87] (unknown [9.61.245.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:19:33 +0000 (GMT)
Message-ID: <304a37b7-2005-44a8-811f-0bf0e09f7511@linux.ibm.com>
Date: Tue, 22 Sep 2026 12:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/16] s390x/pci: implement IOMMU replay
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260922183654.798470-1-kshk@linux.ibm.com>
 <20260922183654.798470-2-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260922183654.798470-2-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2d4c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=w1SutkxEYv_CDO9ESt8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfXwYThEd2nDNt3
 OSJZ7dhjp5iqNwfM6X/rhjMJFTwUh6NE6QaFiuSVbIoGfAwbMMQpSsPmLJZymcBa6qc9tQT/7ja
 1rPR7527E/X5bt43nco9YMyRrNOMoQJDcudfenHyUMjSGOa5YMAQANcQNZJOnHvgKGYchbRFUzN
 2K1liE8vXgx5ESzBisACO+WeCyqFAeqffvCSoMfrCWi+Z4/S7EnpZEtambI5VmQ/w5lzCcmaaMc
 vimGj3o8U3vhM1zsiVZiWWZNAWphmbGNs7tZvZC3YKrMQSXoIlItRQlOsqJFBBNZ6VazeKTe3wb
 JSuNrraMq9Dw8JimYf0sWFp/FiLnEp1URa59MkdFfBrZpjphPbr873/oE1UijQjvDaaZ5b4ic24
 n1avCjCRFYd4JobGFWScvDBtlspGUcwZt7hEDdziaCwXmELuESNlULxmz8Z2lcd0DLb+eu5uBRp
 xZX8wfL0EoYzxPnA+mQ==
X-Proofpoint-ORIG-GUID: 2n_TxVmejPLHO-rzVFv-Mc8T8wz3-FsO
X-Proofpoint-GUID: 2n_TxVmejPLHO-rzVFv-Mc8T8wz3-FsO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX7SLrdtj7gVfW
 8VAsUR8GV3ESLZEaWSjRcDxrJ/WPeo+vWqTIdR4rbArfbs4PAUQx6IP09ooKAM3gW40zsm89rAb
 XVKsJcCdz0PutbX6OQ/f07rw+tqyGR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220280
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/22/2026 11:36 AM, Konstantin Shkolnyy wrote:
> From: Matthew Rosato<mjrosato@linux.ibm.com>
>
> There are a few scenarios where IOMMU replay can potentially be needed
> for zPCI device, namely VFIO device reset scenarios where the guest
> continues running and expects the contents of its IOMMU to be replayed
> upon IOAT re-registration and migration scenarios where the destination
> must reconstruct the IOMMU on the destination.
>
> zPCI migration is not supported yet, but the IOMMU replay function is
> implemented so that it can be called both from IOMMUMemoryRegionClass
> now and migration post_load later.
>
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          | 68 +++++++++++++++++++++++++++++---
>   hw/s390x/s390-pci-inst.c         |  4 +-
>   include/hw/s390x/s390-pci-inst.h |  1 +
>   3 files changed, 65 insertions(+), 8 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



