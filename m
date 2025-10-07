Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED91CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 22:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Fx4-0003Pq-81; Tue, 07 Oct 2025 18:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v6Fx2-0003P8-Ay; Tue, 07 Oct 2025 18:14:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v6Fwz-0004At-DW; Tue, 07 Oct 2025 18:14:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597DPNXV032558;
 Tue, 7 Oct 2025 22:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xi7RcV
 G7eaDCczJgS1d/ux1t9XnwhYp6HwZw8T9XZ+8=; b=CYms7OWDTY+YRvnGfhLN4M
 XhhXJwuQqvsNW1Phl7t717vkJMegfhWl3UDCer9Np/rYmbhvzJmZ+tkTLO5hFnYw
 hGpoZiBak32cUnWnXRiXLVfJcSJW9TnSwrqS61qrASgBdsfqYor25sBHfzbMzbKj
 T7GYiHtt+xQ1ONe4TxUIOwJHdNT9ACUDNprAnCBItpMrWv1NXWFjBvtug8ZBdBi9
 oHSyLmB0rgFsfhN5k4wPOb/Aoux6ig+vf7g1F2zlhuecWRD5WDQipDJlRzQuXwJk
 7vAfrStl6nei8pEEwRzfIfS9oV7pu6D5fpgGeWCvUyDq78yZuzy0YWMOPesJqGkA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0phaea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 22:14:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597JxaO7001863;
 Tue, 7 Oct 2025 22:14:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9y5rqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 22:14:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 597MELRd34013722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Oct 2025 22:14:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B64D58053;
 Tue,  7 Oct 2025 22:14:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 571CD58043;
 Tue,  7 Oct 2025 22:14:20 +0000 (GMT)
Received: from [9.61.254.85] (unknown [9.61.254.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Oct 2025 22:14:20 +0000 (GMT)
Message-ID: <72ae1a7e-8cb9-4bdd-a7b8-1bfcf68e602c@linux.ibm.com>
Date: Tue, 7 Oct 2025 15:14:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: set kvm_msi_via_irqfd_allowed
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20251007205614.188365-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251007205614.188365-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e590bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=oDUlcF5mch2PdcvZY34A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: c70rScdOpy-zMulTFrxlIe1UyljhvmgM
X-Proofpoint-GUID: c70rScdOpy-zMulTFrxlIe1UyljhvmgM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX1Nov6jZJEn5b
 bGV9I1xiDMp+iODwWZxlB/azGW6PhHtsbE98V/3295HJq9nQ7BADEMDZbaqN5rlvjixAjaukBQB
 T66isEXIPVxJ+WOgcBvw03vPl1DrNArzsKOue2oxlha3JCegEGa03Lts4LFOVL9lX92I+cCLd8v
 A4EzjgcD3Y7AKUdlaXvd4EbuBTAsvvGmpW6tmpbKLRgYkC8kPRITthxd3NVkCRuOXXSK5Ws76Xk
 W/KtHQQYdjraZRsg8XmQySPB+5kvQxP4JU9m/BScfOstyxhBNL2rQNxgOw8n8yuQT7MDSEib783
 nZKXFVp3YukaM2rAmr2JM3p8kqLvqiJR2awA+tE3cEKmXyus9CdmZT8MRUmReN67/324y0MJTG8
 UQbKPzyjJKd5R/BcbnwcVdhWZxkHbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 10/7/2025 1:56 PM, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> v2:
>   - add review tag
>   - tweak commit message (David)
> ---
>   hw/s390x/s390-pci-bus.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..88852acf45 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>       s390_pci_init_default_group();
>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                                S390_ADAPTER_SUPPRESSIBLE, errp);
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>   }
>   
>   static void s390_pcihost_unrealize(DeviceState *dev)

