Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB18C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubBe-0005Am-DE; Tue, 18 Mar 2025 13:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tubBC-0004vT-K4; Tue, 18 Mar 2025 13:56:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tubBA-0004eV-Gp; Tue, 18 Mar 2025 13:56:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IH0CpC011598;
 Tue, 18 Mar 2025 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=s4diKx
 qATOqG1uW9vqSe0NqDYjpzx6p2ss0iB3zxQu4=; b=aDF55qK5Zzrv3A/JIUVREn
 6LWfj7ovJSNPzX+d9jet9zpb/WIMeiacOP9dOOuBeD9AJwkkhYHaVNyRFc6Qer+i
 BA6H2Z/1z7tWS49d1YmgarThFBgEH5w6dUIRxjKS8GQOvRiw2uwiEeSqZE2y2aWK
 cFlePvm859AA0yR6yoDf4K/GhhSI0D/a1FGiJ/m3ExVUw53IUrP4vOPi4yPyrdDx
 BPieve84KQbqnRRRB5abo0y7HBd3qUpZcuv1onjyIXighiuR2uSRioA5G+xXxrmB
 NQy/RISI5cUnIvJFiCFx0nYqf9r9y9hjVByU4DAZSdu4Bw1YaZ78zLmmPh3Ke4qA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55wcn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:56:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IHcdvX024753;
 Tue, 18 Mar 2025 17:56:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55wcn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:56:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IG075D005742;
 Tue, 18 Mar 2025 17:56:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2cum6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:56:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52IHuXAT22217028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Mar 2025 17:56:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0294C2004B;
 Tue, 18 Mar 2025 17:56:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9E3720043;
 Tue, 18 Mar 2025 17:56:31 +0000 (GMT)
Received: from [9.124.209.248] (unknown [9.124.209.248])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Mar 2025 17:56:31 +0000 (GMT)
Message-ID: <808b7010-6a72-478d-a616-9dccbb6f1bbe@linux.ibm.com>
Date: Tue, 18 Mar 2025 23:26:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Skip enabling INTx if the IRQ line is also
 unassgined
To: Alex Williamson <alex.williamson@redhat.com>
Cc: clg@redhat.com, vaibhav@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <173834353589.1880.3587671276264097972.stgit@linux.ibm.com>
 <20250131150201.048aa3bf.alex.williamson@redhat.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20250131150201.048aa3bf.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I2bVDQDGXJQ7EmSU4QVPa_Mur4JdUpeO
X-Proofpoint-GUID: fzUWuzOG7sn6nFXq9EUZFkaMNbXV5bV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi Alex,

Thanks and Sorry about the delay in responding. I had to figure out
many nuances for answering your questions.

Replies inline..

On 2/1/25 3:32 AM, Alex Williamson wrote:
> On Fri, 31 Jan 2025 17:15:01 +0000
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
>> Currently, the PCI_INTERRUPT_PIN alone is checked before enabling
>> the INTx. Its also necessary to have the IRQ Lines assigned for
>> the INTx to work. So, check the PCI_INTERRUPT_LINE against 0xff
>> indicates no connection.
>>
>> The problem was observed on Power10 systems which primarily use
>> MSI-X, and LSI lines are not connected on all devices under a
>> PCIe switch. In this configuration where the PIN is non-zero
>> but the LINE was 0xff, the VFIO_DEVICE_SET_IRQS was failing as
>> it was trying to map the irqfd for the LSI of the device.
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ab17a98ee5..69a519d143 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -264,12 +264,12 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>>   static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>> +    uint8_t line = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_LINE, 1);
>>       Error *err = NULL;
>>       int32_t fd;
>>       int ret;
>>   
>> -
>> -    if (!pin) {
>> +    if (!pin || (line == 0xFF)) {
>>           return true;
>>       }
>>   
> vfio_intx_enable() should be the backup that catches users trying to
> configure INTx, but we should also be indicating there's no INTx
> through the IRQ_INFO ioctl.
I posted the kernel fix for this here [1]
> The value in the line register is also not
> defined by the PCI spec, it's implementation specific, therefore for
> what architectures is this interpretation of the line register valid?

You are right, I figured the LINE value is not really dependable even within

different PPC machines.

> Should we at the same time virtualize the pin register as zero?

I verified atleast on PPC it doesn't help as the device tree properties

are given precedence over the PIN value during probe.  Trying to see

how to handle this, wonder at the same time if this wont have any impact

on other architectures.

> Maybe it's also time to implement similar checking for dev->irq ==
> IRQ_NOTCONNECTED.  Do Power systems make use of the IRQ_NOTCONNECTED
> convention?  Thanks,

I see the IRQ_NOTCONNECTED convention is not followed by PPC and

hard to adapt now with many arch specific drivers defaulting on irq = 0

for the same. So, my kernel fix[1] is checking for irq = 0 only for PPC and

not IRQ_NOTCONNECTED.

I have posted my v2 here [2] with the IRQ_INFO check as suggested.

References:

[1] : 
https://lore.kernel.org/all/174231895238.2295.12586708771396482526.stgit@linux.ibm.com/ 


[2] : 174232032506.3739.465958546360660842.stgit@linux.ibm.com

Thanks and Regards,

Shiva


