Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF272CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v437V-0005Fb-1X; Wed, 01 Oct 2025 16:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v437Q-0005EV-GP; Wed, 01 Oct 2025 16:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v437E-00023W-Kw; Wed, 01 Oct 2025 16:08:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591DdpOM020699;
 Wed, 1 Oct 2025 20:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EjIWsP
 D+H5ScqpBzO60XswBHAlP4g76zKi4g3hou/oU=; b=hng8c+pD1iPjAasfuTS2MK
 S0dosopz+fXwVQjWTK2m+T59kF+dYtDWCgVv5b7dlS5h95KlrF557YIgNvoC4tLn
 avcj2LTRLONL/fTNf9onRNKp8CUT8Y4kh7NPoTUF+KtFK05/ycT7DerkLYzE6MpB
 wYk20n0jyd/WOR/caMSes0KWRaeAe9Mgv5rPZPlqEZ0/weFJFuUlorA8hmHHbCsf
 7oC/kS9vKNN4H1cxdHRFdNPgIFgTQ9MDk7Nmb54ew++/41dFQsK0gtGFesB+OjFt
 BWa1i6dd6ITZBAIkjQOOXD1mr6SdismPzm0luwg2ydw+0g89MwD/r00IZnfkknUQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwrq4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:07:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591JeOKm026746;
 Wed, 1 Oct 2025 20:07:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n2qed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 20:07:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 591K7i4Y65143196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Oct 2025 20:07:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2AD5805B;
 Wed,  1 Oct 2025 20:07:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 926075805C;
 Wed,  1 Oct 2025 20:07:43 +0000 (GMT)
Received: from [9.61.10.212] (unknown [9.61.10.212])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Oct 2025 20:07:43 +0000 (GMT)
Message-ID: <8c72fbf7-567b-40fb-a4bb-50c05d69ad06@linux.ibm.com>
Date: Wed, 1 Oct 2025 16:07:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/pci: set kvm_msi_via_irqfd_allowed
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20251001200511.325815-1-mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251001200511.325815-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXz9VOJTz7SWQD
 HZRmxe9man8Qogwr1ecVDvlzuzM5/lhCv04Mrdu9XtsHVQV+atNswD16gxw5Gj4nqQQHxgevTf5
 k1neY7AgjgWnhoO+dUTJrURGUiLIutkMMFzy98jmSarLaB/cjJ7O8N6eNOtC1ZJtXmU3AePtDZ2
 asS3Bk1Kr+xWIjYwiTNZwQ1p0Xb1EZK7VYAYOfN6vUt54kIeWYEzwGg07sC5tqxTnPgcUt2JomN
 LjDWgw3r6so5hS6jWwFq7AAPggjaJn/cxNzZyNOcED9eg5JLmylJck4yWvjFwppjY5FO3r/iDDQ
 iBhh9zDCsY8lYqKxK/N1alMI+I30Zf1/TF3NHT8+PvIEGRseT8Pjg2RJrPqvLRcOlijBKuvTRoj
 IFU8p8rTn83E+qakzT7KhmS2lx9MRA==
X-Proofpoint-ORIG-GUID: SfppuQXLKr93U1hzirGHX6rP__KLSkHP
X-Proofpoint-GUID: SfppuQXLKr93U1hzirGHX6rP__KLSkHP
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dd8a13 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VgWN9-jGRmiBVgsasd8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/1/25 4:05 PM, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---

FWIW we've been using this change in-house for a while now under test different scenarios - AFAICT failure to set this was just a past oversight since virtio-pci is not the default/recommendation for s390x.

>  hw/s390x/s390-pci-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..88852acf45 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>      s390_pci_init_default_group();
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                               S390_ADAPTER_SUPPRESSIBLE, errp);
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>  }
>  
>  static void s390_pcihost_unrealize(DeviceState *dev)


