Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D349BCDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFLd-0001M1-3U; Fri, 27 Sep 2024 14:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1suFLZ-0001Kh-Ba; Fri, 27 Sep 2024 14:05:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1suFLW-0006kH-VG; Fri, 27 Sep 2024 14:05:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RFYX7F027562;
 Fri, 27 Sep 2024 18:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 Y9W9FSyXuR01a0dKG+mIyAmOQpa0o8SZT/D95/zydg8=; b=d9u7wTsC/YlE3JYV
 2exz+e14K9JHQH1Up+ttEh/7O1JtfEM+XEhIZD+hiQwzxZRknhwsFRaQ6lOhhQrA
 8LBH9bDZ2BKyz61hHkO7bSHxLL4fb9h6QKasG2TRhs3os9PYV6ag6tLK1QeKGHAO
 MG6LFFXlNTd+RLnA+lTcS+PHa8hScrI6IWe7JXx7RqX+v2q8A4wXWDTVedAT6cva
 WnATEiuvs9YOTNbI67iCoZNCSL2g8zCHw5jK46oBozJPCjZsYZju+j6BA+Z/crW1
 ySl20G5rfhoRYZ8VJRPoJjiaFZpbgF0lYuaBvfL4SwxjF3Qfxu3tEsq414KSUJBc
 PCsAdQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt1w6c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 18:05:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RI5XxW028874;
 Fri, 27 Sep 2024 18:05:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt1w6c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 18:05:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RGP5PK014009;
 Fri, 27 Sep 2024 18:05:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9ynee7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 18:05:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48RI5SLb31326598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:05:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77DF82004D;
 Fri, 27 Sep 2024 18:05:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A361C20040;
 Fri, 27 Sep 2024 18:05:27 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.33.236])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 27 Sep 2024 18:05:27 +0000 (GMT)
Date: Fri, 27 Sep 2024 20:05:25 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
Message-ID: <20240927200525.5a90f172.pasic@linux.ibm.com>
In-Reply-To: <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gVGtEWRfqc91mkyr4QEhsGftlEZxNSe1
X-Proofpoint-GUID: C9bsIH-wNKUp8iTPBZIAfWr8d0QwKVcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On Thu, 12 Sep 2024 10:19:00 +0200
Thomas Huth <thuth@redhat.com> wrote:

> > diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
> > index b7ac29f444..f0ca62bcbb 100644
> > --- a/hw/s390x/s390-hypercall.h
> > +++ b/hw/s390x/s390-hypercall.h
> > @@ -18,6 +18,7 @@
> >   #define DIAG500_VIRTIO_RESET            1 /* legacy */
> >   #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
> >   #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
> > +#define DIAG500_STORAGE_LIMIT           4
> >   
> >   int handle_diag_500(CPUS390XState *env);  
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Sounds very reasonable to me - but it would be good to get an 
> Ack/Reviewed-by from IBM folks here (in case they prefer a different 
> interface)... hope they'll join the discussion!
> 
>   Thomas

According to Documentation/virt/kvm/s390/s390-diag.rst in the
linux source tree DIAG 500 is for kvm virtio funcions. 

Based on the commit message this storagelimit DIAG is rather loosely
tied to virtio if at all, so from that perspective DIAG may not be a
perfect fit. OTOH I don't see a better fit either. I would prefer to
have Christian's opinion on this. I have no strong opinion myself.

If we decide to go with a DIAG, I would like to see
Documentation/virt/kvm/s390/s390-diag.rst
updated accordingly.

Also if decide to go with DIAG 500, maybe leaving some space
between the codes more closely tied to virtio and between
the ones less closely tied to virito (for the unlikely case
that we end up wanting another DIAG 500 subcode for virtio) 
might make sense. I.e e could make DIAG500_STORAGE_LIMIT 
8 or 16 instead of 4. Again nothing important, just an idea.

Regards,
Halil

