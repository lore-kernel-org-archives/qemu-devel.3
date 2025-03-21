Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2756C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfZ5-0005O1-RZ; Fri, 21 Mar 2025 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tvfZ3-0005Nr-Qn
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:49:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tvfZ1-0001GB-6h
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:49:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LGXoZn023400;
 Fri, 21 Mar 2025 16:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uu2P7J
 ncFjJ/OHGaQYTVsjMseRBYfRdMyzQTgaj6sEI=; b=s4R65XzyZD9pnt2o7RiRxH
 PrNawHjakpRDaA8ulKTBibvI84RXDwC4HFQRcntQY1uscv+a/cWg3ckNPSSGS127
 0AEAM1vkfR+F18GDSsYl6pak4ZFCHMNj+SZocnlzpaaqI9+Pww81nPk7x5iheFcB
 2CIPLyC+DQbDJao5oHsQP+b7ziIDJmfcjnNKzIyB2B+EFbNcnEakJkVFHKrC+DuQ
 Tlm01/v8S5VEI+Wqwp8izZ74ytZ/3RdIuvcb8Q/eFheLvLZZTxpG5jvkwlFhHUZb
 cVRU0vmE1Hy9qpGSvF10gSbetroBu8fX2XARLZ2IqoGisEbriKO+2duNxa1zLbRw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gq6w5wfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Mar 2025 16:49:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52LFIMso004637;
 Fri, 21 Mar 2025 16:49:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvtxdrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Mar 2025 16:49:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52LGnYaN31720088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Mar 2025 16:49:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9AD5803F;
 Fri, 21 Mar 2025 16:49:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92B895804E;
 Fri, 21 Mar 2025 16:49:33 +0000 (GMT)
Received: from [9.61.252.206] (unknown [9.61.252.206])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Mar 2025 16:49:33 +0000 (GMT)
Message-ID: <47c6f487-f170-4a30-b594-74e12819c44e@linux.ibm.com>
Date: Fri, 21 Mar 2025 09:49:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Userspace NVMe driver and multiple iothreads
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net
References: <0fe1ff1e-2388-453e-9fd9-b550b6be0c41@linux.ibm.com>
 <20250320191746.GB2541643@fedora>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250320191746.GB2541643@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: igYFAUY0eHz1VYwRgEcX7fWmYBC0O4d6
X-Proofpoint-ORIG-GUID: igYFAUY0eHz1VYwRgEcX7fWmYBC0O4d6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=958
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 3/20/2025 12:17 PM, Stefan Hajnoczi wrote:
> On Thu, Mar 20, 2025 at 11:13:04AM -0700, Farhan Ali wrote:
>> Hi,
>>
>> I have been experimenting with the QEMU Userspace NVMe driver on s390x
>> architecture. I have noticed an issue when assigning multiple virtqueues and
>> multiple iothreads to the block device. The driver works well with a single
>> iothread, but when using more than one iothread we can hit a problem where 2
>> iothreads can update the completion queue head doorbell register with the
>> same value within microseconds of each other. As far as I understand this
>> would be an invalid doorbell write as per NVMe spec (for eg spec version 1.4
>> section 5.2.1 defines this as an invalid write). This causes the NVMe device
>> not to post any further completions. As far i understand this doesn't seem
>> to be specific to s390x architecture.
>>
>> I would appreciate some guidance on this to see if there is some known
>> limitations with the userspace NVMe driver and multi queue/multi iothread?
> Yes, the block driver only supports 1 IOThread. The code uses
> bdrv_get_aio_context(bs) rather than qemu_get_current_aio_context(), so
> it will only operate in one AioContext.
>
> Code changes would be necessary to support multiple IOThreads.
>
> By the way, this block driver is experimental. There are several bugs
> filed against it in bugzilla.redhat.com. It's currently only useful to
> QEMU developers and I wouldn't rely on it for production VMs.
>
> Stefan

Hi Stefan,

Thanks for your response. This clarifies my suspicions, and provides 
more context on the stability of the driver.

Thanks

Farhan


>> This is an example xml snippet i used to define the nvme block device
>>
>> ...
>>
>> <disk type='nvme' device='disk'>
>>        <driver name='qemu' type='raw' queues='8' packed='on'>
>>              <iothreads>
>>                    <iothread id='1'/>
>>              </iothreads>
>>        </driver>
>>        <source type='pci' managed='yes' namespace='1'>
>>              <address domain='0x0004' bus='0x00' slot='0x00' function='0x0'/>
>>        </source>
>>        <target dev='vde' bus='virtio'/>
>>        <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0002'/>
>>
>> </disk>
>> ....
>>
>> Appreciate any help on this!
>>
>> Thanks
>> Farhan
>>

