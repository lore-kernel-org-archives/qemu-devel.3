Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0C9CEB2C9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 21:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOGm-0002qL-G4; Mon, 30 Sep 2024 17:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1svOGk-0002p1-Ub; Mon, 30 Sep 2024 17:49:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1svOGj-0008A5-Ao; Mon, 30 Sep 2024 17:49:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBeUAu016540;
 Mon, 30 Sep 2024 21:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 phPWIgr4i37LGJ6OTIxaGIPA85hSWt/aWmWY3/tUZp0=; b=ljnkaL1KNlRPo14W
 Pq1ueyQZLTsaEC1flFD4WGYXVPY0jf4d+e+2DcQsgdQYvBX6uSgZcYcSBgrOFGYN
 L2Jqbivi5sN4hR70IlI5OaA6BI9Ot5WDG763W03UkYp+hMCYyytl93/zCrJutBRJ
 LRFbmR0WhftriOT7Z0K7bemPzbgj2UXvPHhE8gbFjCxOWaYqAjiAwHJUo2aHTDV1
 uxn20vnBZ/4yR3x74btyd4CfN5C/0g33HoEJHGoTfO3rFNVdB7RZGmIZ+XygqhRm
 wP8haAanQQPXG0/P0jFOAWXleVQlzU//UWh6DYDWxKonFm2a852og1c9ojaq9gYj
 MKI8EQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87kkxeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 21:49:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48ULnMSS006441;
 Mon, 30 Sep 2024 21:49:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87kkxe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 21:49:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UL0caw020408;
 Mon, 30 Sep 2024 21:49:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s10dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 21:49:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48ULnHvQ18612700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 21:49:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D77D32004E;
 Mon, 30 Sep 2024 21:49:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3129420040;
 Mon, 30 Sep 2024 21:49:17 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.8.58])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 30 Sep 2024 21:49:17 +0000 (GMT)
Date: Mon, 30 Sep 2024 23:49:12 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
Message-ID: <20240930234912.25acd03b.pasic@linux.ibm.com>
In-Reply-To: <7aea51e4-5514-44e7-9da0-cf6aa7a31439@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
 <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
 <20240911100415-mutt-send-email-mst@kernel.org>
 <871q1qurol.fsf@redhat.com>
 <ae1eb296-2737-4871-8769-cee78e459bca@redhat.com>
 <20240927202019.6d721171.pasic@linux.ibm.com>
 <7aea51e4-5514-44e7-9da0-cf6aa7a31439@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: egRz-BqJ1S-TSrHMCtAFrNyzgq2ip4yG
X-Proofpoint-ORIG-GUID: w55VlA1NJAidhkYRblAtzGr3AprZUwp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_20,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=647 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 27 Sep 2024 20:29:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 27.09.24 20:20, Halil Pasic wrote:
> > On Wed, 11 Sep 2024 21:09:27 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >>> Anyway, if we want to proceed with the gitlab project, would it make
> >>> sense to create an org for it, so that it doesn't look like David's
> >>> personal project?  
> > 
> > Frankly, I would prefer making Documentation/virt/kvm/s390/s390-diag.rst
> > the authoritative documentation on DIAGs.
> > 
> > My train of thought is DIAG 500 is a KVM thing, and KVM is a linux
> > kernel thing, so it just feels right for the documentatio to
> > live within the linux source tree.  
> 
> QEMU/TCG is the proof that KVM is not necessarily involved.
> 
> Are you sure that no other OS out there besides Linux implements virtio 
> on s390x, or would want to implement it? :)
>

As Christian has pointed out in another thread DIAG 500 is documented
as the KVM hypervisor call, and that made me argue it is a KVM thing.

You are right KVM is not necessarily involved, and neither is QEMU. For
me it is not about the components involved in the visualization, but
about the people, projects and governance.

IMHO this is basically extending the s390 architecture. We are guaranteed
to not collide with the Architecture because DIAG 500 is reserved for
KVM as a project I guess.

> > 
> > I may have missed some of the discussion: what were the benefits
> > of having this in its separate project/repository?  
> 
> Having it independent of the implementation.
> 

That is a valid point. But IMHO the benefit of having this independent,
does not justify the churn of having a separate project with its
own governance, and communication infrastructure. And I suppose for an
open(?) specification, one would need those things.

No strong opinions though. If Christian, Janosch and Claudio are in
favor of a separate "Specifications for open-source virtualization on
s390x (IBM z Systems)" project, I'm fine with it as well.

Regards,
Halil

