Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE67I-0008Te-7M; Mon, 03 Jun 2024 07:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sE67G-0008T2-8e
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:44:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sE67D-00049V-Ov
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:44:41 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 453BREXK020215
 for <qemu-devel@nongnu.org>; Mon, 3 Jun 2024 11:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=8ObL3Jl4H0bkTGv9lvxj51YTMwiHOsk9zMFe5vWivso=;
 b=aswccyASENYUAg1ei/nL3dFOlSpzkC4O82D9GehOThQbdg8kK/kiPygSRjWpgdb/G+EI
 5q2Pbjq0urEUVF8c92WpEc46/n7KEwuJIntKypU8/rXkFtJ+/mVLxkHTM1s6/RZBkEwt
 5aVo+it1eX3pHfk/BWaFkSv/i4Ir8Nf4MyWA8UBcFlIsVzCP3Fu4rjbTXYCRe5e0WVkF
 tEqsW/Y1h4rkAlUQNrg/JCKFWDraU6e4r0F8+Y7xOAu/AsYQ1FRE9f7OKGYpcqxNhPas
 iJ0/jll5BcdG6niiz1SAuKKelxlgYa+ULK+HQDgK5te9LWPY4+vvKooaKyG9Imm5fuQ3 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhcyf01fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 11:44:33 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453BiW3I022435
 for <qemu-devel@nongnu.org>; Mon, 3 Jun 2024 11:44:32 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhcyf01fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:44:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 453B7DvC026549; Mon, 3 Jun 2024 11:44:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp2q4w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:44:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 453BiQY751380724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jun 2024 11:44:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1704C20043;
 Mon,  3 Jun 2024 11:44:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E3A020040;
 Mon,  3 Jun 2024 11:44:25 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.83.163])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon,  3 Jun 2024 11:44:25 +0000 (GMT)
Date: Mon, 3 Jun 2024 13:44:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Marc Hartmayer
 <mhartmay@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <20240603134423.5d71dbde.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEtoxSne90b75GEWWKaYOXzvvo5=rUS96ufjYsWYfN0ykA@mail.gmail.com>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
 <CACGkMEtqpdAE1bs-egAH6YLCFY+DtctN2HgXUxqygwE3M6fGpw@mail.gmail.com>
 <20240529141746.2a74ce14.pasic@linux.ibm.com>
 <CACGkMEtoxSne90b75GEWWKaYOXzvvo5=rUS96ufjYsWYfN0ykA@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GkGkppbFqQFc2OkR11ZBRC4XT22hwCQ-
X-Proofpoint-ORIG-GUID: ZfMvUJoiXu4YlKczBkKs09S1gicuwrhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030098
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

On Thu, 30 May 2024 10:34:55 +0800
Jason Wang <jasowang@redhat.com> wrote:

> >
> > IMHO changing the semantic of the VHOST_GET_FEATURES ioctl is not viable,
> > but also not necessary. What I am proposing is changing the (in QEMU)
> > logic of processing the features returned by VHOST_GET_FEATURES, while
> > preserving the outcomes (essentially realize the same function in a
> > mathematical sense, but with code that is less fragile), modulo bugs like
> > the one addressed with this patch of course.  
> 
> Ok, I think I misunderstood you here. Maybe an RFC to see?

I will try to hack up an RFC that involves vsock and net so we can
discuss the approach. Unfortunately I currently have a lots of other
(non-development) stuff on my plate, please bear with me.

I suggest to go forward with this patch for fixing vsock, and look if we
can do something better for the rest.

By the way in the thread with Stefano, I've raised a question about live
migration (i.e. what would happen of someone were to implement
packed layout for vhost and make add the feature to vhost/net). I would
very much like to have your opinion on that!

Regards,
Halil

