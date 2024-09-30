Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44599CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEJl-0003xp-90; Mon, 30 Sep 2024 07:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svEJh-0003wj-Vg; Mon, 30 Sep 2024 07:11:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svEJe-00023U-Ry; Mon, 30 Sep 2024 07:11:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2wHio011674;
 Mon, 30 Sep 2024 11:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
 PcQ0eay/IHtdtrt3SVvYdCZvbhIB6jtid2xJbRbJIk=; b=bXeQznFdMLuF2G+Mv
 RGXOmsPHy8jDYc7ugF+Zfm8UGRzY7UprxS5oFmuIu3kZTH2mP1aEpt/IEe6tJFl9
 QTMns+ZF+lulzlJ9hVlOIiJgv64snpX4WmVTjW8doXdbMd0wX8JUZz5cDfsPchO3
 7D+sVfKU7L18WMgDHfMB/nMg8Om8wzPHEGJesUWfM1DvPh8KPDImO0mQyrHRpteo
 LQzuVQT/uKZSl4f+zQcOPxugBj8FKoB73w4j2ttECe1M4ARnjYXbm2JRH97JHrSv
 WFx1UHBKSr7AdEBIOwWFU19bn+m9bBUG950tu5DLeSqsnC9c9pCXurgLSlzYDInC
 P/1yA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb1dup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:11:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UBBd4P023539;
 Mon, 30 Sep 2024 11:11:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb1duh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:11:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8h6Ha013047;
 Mon, 30 Sep 2024 11:11:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj5xc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:11:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UBBW1Z50987308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 11:11:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5BE420040;
 Mon, 30 Sep 2024 11:11:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B0952004E;
 Mon, 30 Sep 2024 11:11:32 +0000 (GMT)
Received: from [9.179.23.43] (unknown [9.179.23.43])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Sep 2024 11:11:32 +0000 (GMT)
Message-ID: <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
Date: Mon, 30 Sep 2024 13:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
To: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240927200525.5a90f172.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -WvjBlwq_6i5YIc6BlMLkVTWMJSac77V
X-Proofpoint-ORIG-GUID: kqXooJhOgG9LldU08eNrQonUlJoxWJrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_09,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300078
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 27.09.24 um 20:05 schrieb Halil Pasic:
> On Thu, 12 Sep 2024 10:19:00 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>>> diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
>>> index b7ac29f444..f0ca62bcbb 100644
>>> --- a/hw/s390x/s390-hypercall.h
>>> +++ b/hw/s390x/s390-hypercall.h
>>> @@ -18,6 +18,7 @@
>>>    #define DIAG500_VIRTIO_RESET            1 /* legacy */
>>>    #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
>>>    #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
>>> +#define DIAG500_STORAGE_LIMIT           4
>>>    
>>>    int handle_diag_500(CPUS390XState *env);
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Sounds very reasonable to me - but it would be good to get an
>> Ack/Reviewed-by from IBM folks here (in case they prefer a different
>> interface)... hope they'll join the discussion!
>>
>>    Thomas
> 
> According to Documentation/virt/kvm/s390/s390-diag.rst in the
> linux source tree DIAG 500 is for kvm virtio funcions.
> 
> Based on the commit message this storagelimit DIAG is rather loosely
> tied to virtio if at all, so from that perspective DIAG may not be a
> perfect fit. OTOH I don't see a better fit either. I would prefer to
> have Christian's opinion on this. I have no strong opinion myself.

Some remarks:
500 with a new subcode would work, it is marked as KVM hypervisor call
in our docs. 501 was used in the past for software breakpoints.
So we could use 502 as the next free one (This is reserved for KVM).
We do have kvm_stat counters for 500, not sure if people debugging virtio
will care.
The only important question for me is, what code is generated by gcc for
the switch statement and will any variant slow down the virtio doorbell.
diag.c has
         if (!vcpu->kvm->arch.css_support ||
             (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
                 return -EOPNOTSUPP;

So 500+4 should probably not cause any harm apart from branch prediction
going wrong the first 2 or 3 notifies.

502 will make kvm_s390_handle_diag larger.

So I tend to go with 500+4.

