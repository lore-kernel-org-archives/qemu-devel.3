Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98D9C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIFm-0000zJ-Rq; Wed, 29 May 2024 08:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sCIFl-0000yj-Dj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:18:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sCIFj-00024q-0b
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:18:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TCHnjf011854
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=+Rw/xGkJ/6hsrnD8AB6dkn41lWetHT2AuNxzBufvwNk=;
 b=asvbeCPcXVWOFRzHQeap9LD58QCewJORST45h3H7IHB1sYzIqJr5BD04ejcXEZ3punPj
 8WiE0po7SPG64zAyNatHSpzGK9ATIFeGifp15kk0DeR0Ek4bjj94rbaY1BTiG/6iqenc
 XpZDaysHpeT7dWe8/dViiRXrcLuL5vX8QjB4aVUEgWPG3PbvAHwjtOsYA+jDgvRcV6fj
 512OfqfGIAtcSuxHKMgg6Gd7bG/G862bKTbWUs73nYjD6LzoB0vANe9Kka5LJcPqqMgx
 nH7MLqQj/1a2BqEG9Ph6tc/SkkE7Xwm++ny888UUnG5moExEhRArgVZCMLL/qU9rYx3C 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye47w801y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:17:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TCHtql011915
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:17:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye47w801w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 12:17:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TBWSkQ028981; Wed, 29 May 2024 12:17:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpaykp3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 12:17:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TCHmvb57016576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 12:17:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 716B82004B;
 Wed, 29 May 2024 12:17:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E661220049;
 Wed, 29 May 2024 12:17:47 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.28.55])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 29 May 2024 12:17:47 +0000 (GMT)
Date: Wed, 29 May 2024 14:17:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Marc Hartmayer
 <mhartmay@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <20240529141746.2a74ce14.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEtqpdAE1bs-egAH6YLCFY+DtctN2HgXUxqygwE3M6fGpw@mail.gmail.com>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
 <CACGkMEtqpdAE1bs-egAH6YLCFY+DtctN2HgXUxqygwE3M6fGpw@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: amM4DW1pc4KB4hrpXk_Hhp6GPfg8RhdD
X-Proofpoint-GUID: UEYv7igtsOVs25N4sOPARIZRoaY4BfFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 28 May 2024 11:25:51 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > 5) Based on the following, I would very much prefer a per device list of
> > features with the semantic "hey QEMU can do that feature without any
> > specialized vhost-device support (e.g. like VIRTIO_SCSI_F_CHANGE)"  
> 
> Indeed the current code is kind of tricky and may need better
> documentation. But the problem is some features were datapath related
> and they are supported since the birth of a specific vhost device. For
> example, some GSO related features (actually, it's not a feature of
> vhost-net but TUN/TAP).
> 
> And I've found another interesting thing, for RING_REST, actually we
> don't need to do anything but we have the following commits:
> 
> 313389be06ff6 ("vhost-net: support VIRTIO_F_RING_RESET")
> 2a3552baafb ("vhost: vhost-kernel: enable vq reset feature")
> 
> Technically, they are not necessary as RING_RESET for vhost-kernel
> doesn't require any additional new ioctls. But it's too late to change
> as the kernel commit has been merged.
> 
> > over
> > the current list with the semantics "these are the features that
> > need vhost backend support, and anything else will just work out". That
> > way if an omission is made, we would end up with the usually safer
> > under-indication  instead of the current over-indication.
> >
> >
> > @Michael, Jason: Could you guys chime in?  
> 
> Another issue is that it seems to require a change of the semantic of
> VHOST_GET_FEATURES. If my understanding is true, it seems a
> non-trivial change which I'm not sure it's worth to bother.

I don't quite understand. Would you mind to elaborate on this?

For starters, what is the current semantic of VHOST_GET_FEATURES, and
where is it documented? You mean the ioctl, right?

Then why do you think the semantic of VHOST_GET_FEATURES should change?

IMHO changing the semantic of the VHOST_GET_FEATURES ioctl is not viable,
but also not necessary. What I am proposing is changing the (in QEMU)
logic of processing the features returned by VHOST_GET_FEATURES, while
preserving the outcomes (essentially realize the same function in a
mathematical sense, but with code that is less fragile), modulo bugs like
the one addressed with this patch of course.

Regards,
Halil


