Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E974CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadBy-0004zV-Ac; Fri, 19 Jun 2026 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wadBg-0004y8-Ak; Fri, 19 Jun 2026 13:39:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wadBe-0004M7-EN; Fri, 19 Jun 2026 13:39:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDISUa2320852; Fri, 19 Jun 2026 17:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=48ITVt
 DQ+Pnh//0cHTVuhBE6bqj+EyOxTeA4bvTr6n0=; b=sGUNI/urmlVIPkxAto4YFH
 iS/mkNkMfH5k+kX+NWVaaEbvYjUk/3Cxj03mNZU7Nwkc0KyyG+G8XIf8upWTIOeU
 iBYPixfx1suEOVZbST9e5h6g+XbIztmgiG5PlNvfzYConxTYsXwL1bC8IUbmc1kF
 kxLNpKlDw+qaHxQPc7l1/P6OZlgNqvZspNgwghtkfeYAD6osilXztoT0Mtsb7Yfw
 QtiuZCWvPTmtPfNgFYhh4mG04ho3MfdNYZNn4SkwRoIYc2LjLgy+NJ8nEp9YeC7y
 0dk/jPKJJkbHkYfWm9Dt9RLB+JX0XhmmU997TyTFsvM483AbnwOg3MfE0xxVhZUg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxpmh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 17:39:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JHZ1ml000943;
 Fri, 19 Jun 2026 17:39:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hw7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 17:39:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JHdJn321168890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 17:39:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38E925805F;
 Fri, 19 Jun 2026 17:39:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A4B958053;
 Fri, 19 Jun 2026 17:39:18 +0000 (GMT)
Received: from [9.61.19.86] (unknown [9.61.19.86])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2026 17:39:18 +0000 (GMT)
Message-ID: <1db93e1b-b7a6-4aa4-8432-fa7f114b9985@linux.ibm.com>
Date: Fri, 19 Jun 2026 13:39:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-14-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260605021728.1125090-14-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a357ec9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=BXDEjGdoi0IGRwZHYXQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NCBTYWx0ZWRfX2dDlrEi0uTXL
 OJO65TACohTDIHUkcqHHKBKi/zBJtrT2TTHDrXd+z1pb0vgcS4VKGkdUCn4kbi6I6HxUPI4yw2L
 y0H5UD8Zl2xCuzrZAqHqb1JW4QkTK2959tbOOm2zPbuHa5hq5wUw+FuMhjlMK9CajSVCx7UjOv/
 uRmSHtcxPCmp9ydY0BNLdOChlhHoXkrwbpQbldFd7udr1rSe1/M7cJkfXCy/H7Ye9HcZ8odssUd
 wvRPRd4m4eN31B8njzB9zbGLf6E5vk9phAjSNa9hT7PmAwoKM3Op9VDK4oMg3gs7ppLtoN0NhQk
 Sjfx+FM/0dwIXcV58hnDbiJEcXCKVFwR4CGLm20ci7ZK4pNNbRuD7FBVALAGabygZzGe9k/9RRs
 Ugt/zAZrepkGgmgsJ0vJiBHi3Sc0oHnI33v56aMAqrGDnsrt9rKPiOipM1B08JFm4TJFTeBNb2v
 wedCkIgpFEhBY2qgz8Q==
X-Proofpoint-GUID: fn2ZOme4eUdyEtvoGZD48gKaY3ZDQcvv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NCBTYWx0ZWRfXyHnz8Pw40LxM
 4tA040/TE8KnLgBCtMFcX0GdP+uevnpYDwAvH2H1qeU3zbFkoseo6O5LW+/9VgTkPzrNMhGdIDM
 auQQaEP9W+NTU6wsQypK37VtxVjBbSo=
X-Proofpoint-ORIG-GUID: fn2ZOme4eUdyEtvoGZD48gKaY3ZDQcvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190164
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 6/4/26 10:17 PM, Konstantin Shkolnyy wrote:
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Commit message needs something here -- You don't need to include the
explanation of the structure (that's in the commit itself) but maybe
describe the context (e.g. you're adding the comment because you just
moved most of the contents of the structure out in support of migration
and are now describing the remaining purpose)

> ---
>  include/hw/s390x/s390-pci-bus.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index e3cbee2695..2fab28e6e0 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -271,6 +271,14 @@ typedef struct S390PCIDMACount {
>      QTAILQ_ENTRY(S390PCIDMACount) link;
>  } S390PCIDMACount;
>  
> +/*
> + * This structure holds the PCI device AddressSpace that QEMU needs to link
> + * into its internal structures before the zPCI and PCI devices are fully
> + * initialized. It's a QEMU requirement to provide this "root" AddressSpace
> + * early. The AddressSpace is only actually used for I/O while the PCI
> + * device is plugged in and configured by the guest, at which time it gets
> + * additional memory subregions from zPCI device, that can do real work.
> + */

To be more clear, it's not that it is required 'early' so much as that
it is required to be there at the time the PCI device is plugged.

The lifecycle has always been a bit odd here; it is an attribute of the
zPCI device, but is required by the PCI device in order to function and
the necessary linkage between the 2 (PCI->zPCI) is established via the
iommu_table in the S390pciState.  Would be good to work some of that
into this explanation.

>  struct S390PCIIOMMU {
>      Object parent_obj;
>      AddressSpace as;


