Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162E8C982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 01:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x70ov-0007EO-Rn; Wed, 16 Sep 2026 21:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x70ou-0007E6-35; Wed, 16 Sep 2026 21:21:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x70os-0004wV-FT; Wed, 16 Sep 2026 21:21:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1YBt3041096; Thu, 17 Sep 2026 01:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qRvktH
 oOneSDLoCY2z4sOQa6829ioxNPOukzmLtNSGs=; b=emsUk4ULDm5WZ8cbGqsONC
 3ZI6uPzRcY/1vVjjcUYxxAuUsejy2I5K8FHafZd9YW3txkiv3NDNCIlMWZ4Ybfkd
 6PrevFhEuxqiAEeT8luj6kmsFHW5cSRjnDVRkYxrcjgZy8uTDk7gTchE4LFzsWI2
 CSe9cFLnITLEyS5rmvBOGUeV62+c2oW9bjwZv/qM1quylIgC/h4Dvrw0/hOYncv0
 utRVdJyPgErU8N4MShnekTVJ0i2CsXqUAA6FYzk1vxuhlao4wgEoeCWHEk/PVDIw
 iTfPZUnehlcc7FMvuKFNYWZve3EKt3ZVauNIsWRSRL92cq08m+tpuJY88R8KEXhw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e7fag-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 01:21:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H0DCHS2266348; Thu, 17 Sep 2026 01:21:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjg6hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 01:21:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H1LgFq32047756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 01:21:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8555458045;
 Thu, 17 Sep 2026 01:21:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A50B658050;
 Thu, 17 Sep 2026 01:21:41 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 01:21:41 +0000 (GMT)
Message-ID: <2ff23698-675f-4e4f-9257-51a31445ef30@linux.ibm.com>
Date: Wed, 16 Sep 2026 21:21:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] s390x/pci: Add PCI error handling for vfio pci
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, farman@linux.ibm.com
Cc: cohuck@redhat.com, alex@shazbot.org, armbru@redhat.com
References: <20260914174420.12309-1-alifm@linux.ibm.com>
 <20260914174420.12309-3-alifm@linux.ibm.com>
 <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAxMCBTYWx0ZWRfX42ZnXOgOGgWO
 WWrQorD1dDowYA0ERBfdKSC4/QHPG6D9NIuBdJI0RVlL2jiU8gdFtFmaUld5g07wCBtdoQ0F4tn
 UHGvv9++dkTAmRz6U42XBY9zxYzcpH9eji+IsMwoB26Xsu2Ho2UBQSlwVrV0RNVHqT/O5z5kr63
 EMh6bLHhjD+3vxeDx502p4XzCSUxMyrhCYiuLPtVyM6wROem94lm0cgYcBxudsaWUZCXJEbqNiE
 IlywlsSSi0SvCayGIK5BLw6h/pROaKVYTm+lLlBusdRnzNM/eRRpKWcUKamMO/d6ntcd/JAWFXV
 DR0C3rr+nyW7B8OO4vypS9FE0+5f7ThmJx2mi7dRBWuPmxZMR0xI5mcwZ2lRJx6veERO45GwFg8
 4K/YlgKVoR3pCMyq2jO2n1/2s/v1ZRznyzf1nc5+ESy82IOzX2ld6R8hvrAKh75zfjZagEU9Knd
 LLPTdxiTmEjqarGsVhg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab40a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rUF3qzU5dkveDuQpHHEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IHtNR8EM79pe898gUxRvGHR9sbph13BD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAxMCBTYWx0ZWRfXwfRg89yTUgb3
 L0tfjs5JKUq5kc4nTSb8Epk7nLSYqCsyFx8w1+AG1CS4E5ZfLLV+0TPBR4V67vDi2wknYPfz8fk
 d6rqHgj8KceylLHDp2Njnw0/0958jbE=
X-Proofpoint-GUID: IHtNR8EM79pe898gUxRvGHR9sbph13BD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170010
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


>> +    }
>> +
>> +    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
>> +    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);

@Eric - Since this version of the series is now all living in s390x
code, I expect it will eventually go via an s390x PR -- but I'd like to
make sure we at minimum get an ACK from Alex and/or Cédric for this
patch due to the change above.

I already see Cédric giving review comments (thank you!) but wanted to
make the requirement explicit.
Thanks,
Matt

