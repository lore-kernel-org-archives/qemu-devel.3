Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E30E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 22:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMEQq-0005ol-U5; Fri, 13 Dec 2024 17:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEQo-0005nz-MH; Fri, 13 Dec 2024 17:46:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEQm-0007Pu-Uh; Fri, 13 Dec 2024 17:46:46 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfaeM001235;
 Fri, 13 Dec 2024 22:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/9D0F1
 F1Iq1MZJJX4xLv/GsrRNmsvpzzof8lSIL+Ez8=; b=YJn+xmcftaLVVJi0Dk3fLT
 dpjC1ckl1Fs6sHl2cd29WlzfYhUKLzpZE/h0gTzdT910EjPRNTFS/bP+3SyG4Pmz
 io7a1BBnOl5t4u1xvgXRmvlE+F//gvoUyP89HqRrq6hhvxv1kyEB6YkSYyGYD6Si
 QG8XFXzKptJs37qoBliura1IXFr624Lfes9hvKnX+/p7BJTmInSmNbZRlxMrfOeD
 7TjfE7/Jjx5rNrvXRSh0Mwx7pSUvmzn3RJhAoXzyxD9GenRar8FHbXZJEDhEuUpC
 eIeo6YqSjiIMq8Z+qj2WBmaAWqCiQqweKv4G9BQlAV8PJZrsIQRg2Jq9/bvaeqgQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gpd5t7eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:46:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJVKH9016926;
 Fri, 13 Dec 2024 22:46:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yr9m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:46:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BDMkdbd24380026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 22:46:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04FD55804B;
 Fri, 13 Dec 2024 22:46:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D8E558055;
 Fri, 13 Dec 2024 22:46:37 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2024 22:46:37 +0000 (GMT)
Message-ID: <0e8321be-6cd1-471a-935a-eb6e0c61a113@linux.ibm.com>
Date: Fri, 13 Dec 2024 17:46:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
 <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
 <7bd2018a-df16-4ede-b7d7-dfdb9cbfc7c0@redhat.com>
 <a6bfbf15-cbe4-4023-9a8e-d172cf8c8128@linux.ibm.com>
 <f38ed904-d235-43b5-a351-ea64e54984b4@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <f38ed904-d235-43b5-a351-ea64e54984b4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hkt-iY1555waNUzsyDh_l1406UipzNaL
X-Proofpoint-ORIG-GUID: hkt-iY1555waNUzsyDh_l1406UipzNaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/10/24 3:58 AM, David Hildenbrand wrote:

> Maybe there is a reason s390x needs to handle this using memory_region_notify_iommu() callbacks instead of doing it similar to "struct vfio_memory_listener" when registered on &address_space_memory without a viommu.
> 

Hi David,

I think I sorted a way to handle this such that, when direct mapping, we use a memory region alias instead so that vfio can ultimately handle all of the pinning/unpinning in the non-iommu path of vfio_listener_region_add/del, just like it does for other platforms.  But for s390 the alias is needed to provide the SDMA offset so as to ensure that e.g. GPA X maps to iova SDMA+X.  Looks to be working nicely so far with my rework of the associated kernel series -- Going to send as part of v2, would appreciate it if you'd give that a look.

Thanks,
Matt

