Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678F2C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIke-0004gI-51; Wed, 29 May 2024 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sCIkX-0004fB-RO
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:49:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sCIkP-0007m6-HL
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:49:49 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TClDYv023075
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=l7+5RtmWOqIW/nsWbCqfiMY3Yu3QqMW7BOlEGHHsByQ=;
 b=CPnsHDyIV2GsA1v64qiOEPth/7Z6OU7D4dYqbZKBHcN7zjEp+HIZcVZDlZdmpXxK+xhs
 iPza/F07xIiwILDr2RE2Nwp9FWYus7r6gCb047XDQQhMTnUFZoj5LhYwPvXkIXp/clwG
 g5Yz25RYQJwefzf+G5kN1YjXolQb0t0/Bs3Mslm4mk+HlvmBTrV2q543IbRHrk7nlI4V
 7o5xf2HH90Lw49HMDq9vAHfAo7xYk9cb4XcfizDR7xcAFPc88tlwdpTtaSb/YTcxzKKM
 4uiUMfmxd1VbP90LQSkwH2WO55R9DTT9AANB1lxFiLnFsRgh/KWTyNAIFlYTLdvAPNIN mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye4nv80eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:49:38 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TCnbdn029135
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:49:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye4nv80ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 12:49:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TBtX8u024758; Wed, 29 May 2024 12:49:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydphqkr33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 12:49:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TCnUIe51708162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 12:49:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87FD420043;
 Wed, 29 May 2024 12:49:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB13220040;
 Wed, 29 May 2024 12:49:29 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.28.55])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 29 May 2024 12:49:29 +0000 (GMT)
Date: Wed, 29 May 2024 14:49:28 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Marc Hartmayer <mhartmay@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Boris Fiuczynski
 <fiuczy@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <20240529144928.182b34b1.pasic@linux.ibm.com>
In-Reply-To: <glq3neyd4vyzu4wgdrlq2a2ws7h4tn35dg2xaw4klc73zfj25k@pwotfsysvgqr>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
 <glq3neyd4vyzu4wgdrlq2a2ws7h4tn35dg2xaw4klc73zfj25k@pwotfsysvgqr>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2vZgVxK-G0Ab6SiBXKWn1nGqeS62Kb0t
X-Proofpoint-ORIG-GUID: 70vhRt1YgZPnSxrP7F79x2P6VkGBYl41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290087
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

On Tue, 28 May 2024 17:32:26 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> >1) The uses is explicitly asking for a vhost device and giving the user
> >a non vhost device is not an option.  
> 
> I didn't get this point :-( can you elaborate?

I was thinking along the lines: QEMU gets told what devices to
provision, and that includes things like what virtio features,
and what kind of a backend.

In this example, the default for vsock-vhost is no VIRTIO_F_RING_PACKED,
but if we tell QEMU to create a vsock-vhost device with the feature
VIRTIO_F_RING_PACKED, things go south in a not nice way.

Given that vhost not supporting VIRTIO_F_RING_PACKED as of today is a
fact of life we must accept, there are multiple ways how such a situation
can be handled.

For instance vhost-net is handling this by the device not offering the
VIRTIO_F_RING_PACKED feature. This is at least what I think I have
observed, but I would not mind somebody confirming it. But for the sake
of the argument, let us look at other options.

The straightforward one would be to not realize the device, because we
can't provide what we have been asked to provide. And this actually
makes me think about migration! What would happen, were we to
eventually introduce, packed to vhost and vhost net, and then attempt to
migrate between a host that has this new feature and host that has not. I
guess things would pretty much blow up in a very unpleasant way!

Then for some devices, at least in theory, it might be possible to
abandon not the feature but the backend. Along the lines we were asked to
provide the feature X with backend Y but since backend Y does not
support that feature and backed Z does, we will determistically go
with backend Z. But IMHO this is a purely theoretical consideration, and
we shall not go this way.

In any case if we are asked to provide with properties such that we
can't actually do that, something has to go out of the window: either
some of the properties, or the entire device.

Regards,
Halil


