Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E892DC25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYVl-0001Yt-0A; Mon, 27 May 2024 07:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sBYVh-0001YF-NV
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:27:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sBYVf-0000ey-BI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:27:25 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44RAFo4s014027
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:27:21 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3Dapx?=
 =?UTF-8?Q?qL25Gqw9LAhrVIiaX0BzMHmqlGGo2EHr8Bd8NJy0=3D;_b=3DWdWcRAb0uibpNx?=
 =?UTF-8?Q?iJL0DmqWsjVpTIAR5mlJM+EoEGCyT5tFkfo2m4h6qAe/3IR1G+lakN_0joFOKju?=
 =?UTF-8?Q?f+VsP9S0Zx0DC6Bq9xJ/1kuJ6RMof21VAV/bqi6p9loJfUUcUG3H1KdDUl1h_9T?=
 =?UTF-8?Q?YF0hZ+r0dkLaaEKuUj1OJhB/+SBz5sIXHDt/kzNTYLSd1hHPIX4TN+MJjwj2I0q?=
 =?UTF-8?Q?KWr_cWkMGpmLgBTiSAiKq0pCtsNFVUbcnFJvPmedYDwsxGRfQ6/er++1Pp+2IkP?=
 =?UTF-8?Q?pKF2XyMSN_wZdTuKcwxj6B+qUKmKe5Mji7/WrsrxAQE35mnlu+oL+dx61UUh9uf?=
 =?UTF-8?Q?ULibFQZR1jlAyPk_BQ=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycr55r56x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:27:20 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44RBRJdx027316
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:27:19 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycr55r56v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 11:27:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R9eJ7a027163; Mon, 27 May 2024 11:27:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhkgbey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 11:27:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44RBRDkk34406934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 11:27:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F3DF2004E;
 Mon, 27 May 2024 11:27:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA21020043;
 Mon, 27 May 2024 11:27:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.83.141])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 27 May 2024 11:27:12 +0000 (GMT)
Date: Mon, 27 May 2024 13:27:10 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Boris Fiuczynski
 <fiuczy@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <20240527132710.4a7c372f.pasic@linux.ibm.com>
In-Reply-To: <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WGz_Egd541p0z8uNltQ_oTvtbh_scuiP
X-Proofpoint-GUID: VMC9o6TvzkM0OFqPSN_0FSU1HUbGTEC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_01,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 16 May 2024 10:39:42 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

[..]
> >---
> >
> >This is a minimal fix, that follows the current patterns in the
> >codebase, and not necessarily the best one.  
> 
> Yeah, I did something similar with commit 562a7d23bf ("vhost: mask 
> VIRTIO_F_RING_RESET for vhost and vhost-user devices") so I think for 
> now is the right approach.
> 
> I suggest to check also other devices like we did in that commit (e.g.  
> hw/scsi/vhost-scsi.c, hw/scsi/vhost-user-scsi.c, etc. )

Hi Stefano!

Thank you for chiming in, and sorry for the late response. I was hoping
that Michael is going to chime in and that I can base my reply on his
take. Anyway here I  go.

A very valid observation! I do agree that we need this for
basically every vhost device, and since:
* net/vhost-vdpa.c
* hw/net/vhost_net.c
* hw/virtio/vhost-user-fs.c
already have it, that translates to shotgun it to the rest. Which
isn't nice in my opinion, which is why I am hoping for a discussion
on this topic, and a better solution (even if it turns out to be
something like a common macro).
[..]
> >
> >The documentation however does kind of state, that feature_bits is
> >supposed to contain the supported features. And under the assumption
> >that feature bit not in feature_bits implies that the corresponding bit
> >must not be set in the 3rd argument (features), then even with the
> >current implementation we do end up with the intersection of the three
> >as stated. And then vsock would be at fault for violating that
> >assumption, and my fix would be the best thing to do -- I guess.
> >
> >Is the implementation the way it is for a good reason, I can't judge
> >that with certainty for myself.  
> 
> Yes, I think we should fix the documentation, and after a few years of 
> not looking at it I'm confused again about what it does.
> 

I would prefer to fix the algorithm and make whole thing less fragile.

> But re-reading my commit for VIRTIO_F_RING_RESET, it seems that I had 
> interpreted `feature_bits` (2nd argument) as a list of features that 
> QEMU doesn't know how to emulate and therefore are required by the 
> backend (vhost/vhost-user/vdpa). Because the problem is that `features` 
> (3rd argument) is a set of features required by the driver that can be 
> provided by both QEMU and the backend.

Hm. I would say, this does sound like the sanest explanation, that might
justify the current code, but I will argue that for me, it isn't sane
enough.

Here comes my argument. 

1) The uses is explicitly asking for a vhost device and giving the user
a non vhost device is not an option.

2) The whole purpose of vhost is that at least the data plane is
implemented outside of QEMU (I am maybe a little sloppy here with
dataplane). That means a rather substantial portion of the device
implementation is not in QEMU, while QEMU remains in charge of the
setup.

3) Thus I would argue, that all the "transport feature bits" from 24 to
40 should have a corresponding vhost feature because the vhost part needs
some sort of a support. 

What do we have there in bits from 24 to 40 according to the spec?
* VIRTIO_F_INDIRECT_DESC
* VIRTIO_F_EVENT_IDX
* VIRTIO_F_VERSION_1
* VIRTIO_F_ACCESS_PLATFORM
* VIRTIO_F_RING_PACKED
* VIRTIO_F_IN_ORDER
* VIRTIO_F_ORDER_PLATFORM
* VIRTIO_F_SR_IOV
* VIRTIO_F_NOTIFICATION_DATA
* VIRTIO_F_NOTIF_CONFIG_DATA
* VIRTIO_F_RING_RESET
and for transitional:
* VIRTIO_F_NOTIFY_ON_EMPTY
* VIRTIO_F_ANY_LAYOUT
* UNUSED

I would say, form these only VIRTIO_F_SR_IOV and
VIRTIO_F_NOTIF_CONFIG_DATA look iffy in a sense things may work out
for vhost devices without the vhost part doing something for it. And
even there, I don't think it would hurt to make vhost part of the
negotiation (I don't think those are supported by QEMU at this point).

I would very much prefer having a consolidated and safe handling for
these.

4) I would also argue that a bunch of the device specific feature bits
should have vhost feature bits as well for the same reason:
features are also such that for a vhost device, the vhost part needs
some sort of a support.

Looking through all of these would require a lot of time, so instead
of that, let me use SCSI as an example. The features are:
* VIRTIO_SCSI_F_INOUT
* VIRTIO_SCSI_F_HOTPLUG
* VIRTIO_SCSI_F_CHANGE
* VIRTIO_SCSI_F_T10_PI

The in the Linux kernel we have
        VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG) |
                                               (1ULL << VIRTIO_SCSI_F_T10_PI)
but in QEMU kernel_feature_bits does not have 
VIRTIO_SCSI_F_T10_PI which together does not make much sense to me. And I would
also expect VIRTIO_SCSI_F_INOUT to be a part of the negotiation, because 
to me that the side that is processing the queue is the one that should
care about it, but I don't think it is supported by QEMU at all, and
then not negotiating it is fine. VIRTIO_SCSI_F_HOTPLUG is in QEMU's
kernel_feature_bits and thus negotiated. in  So the only one that can be
done purely in QEMU seems to be VIRTIO_SCSI_F_CHANGE.

And for vsock we have
VIRTIO_VSOCK_F_SEQPACKET and VIRTIO_VSOCK_F_STREAM, with VIRTIO_VSOCK_F_STREAM
being strange in a sense that the spec says "If no feature bit is set,
only stream socket type is supported. If VIRTIO_VSOCK_F_SEQPACKET has
been negotiated, the device MAY act as if VIRTIO_VSOCK_F_STREAM has also
been negotiated."

VIRTIO_VSOCK_F_SEQPACKET is negotiated with vhost.

It seems for whatever reason we just assume that the vhost device
supports VIRTIO_VSOCK_F_STREAM and that is why we don't negotiate it. I
would assume based on what I see that the feature VIRTIO_VSOCK_F_STREAM
was retrofitted, and that is what we ended up with. Thus I guess now
we have an implicit rule that any QEMU compatible vhost-vsock
implementation would have to support that. But in practice we care only
about Linux, and thus it does not matter.

5) Based on the following, I would very much prefer a per device list of
features with the semantic "hey QEMU can do that feature without any
specialized vhost-device support (e.g. like VIRTIO_SCSI_F_CHANGE)" over
the current list with the semantics "these are the features that
need vhost backend support, and anything else will just work out". That
way if an omission is made, we would end up with the usually safer
under-indication  instead of the current over-indication.


@Michael, Jason: Could you guys chime in?

> 
> >
> >But I'm pretty convinced that the current approach is fragile,
> >especially for the feature bits form the range 24 to 40, as those are
> >not specific to a device.
> >
> >BTW vsock also lacks VIRTIO_F_ACCESS_PLATFORM, and VIRTIO_F_RING_RESET
> >as well while vhost-net has both.  
> 
> VIRTIO_F_RING_RESET is just above the line added by this patch.
> 

My bad! :)
> >

> >If our design is indeed to make the individual devices responsible for
> >having a complete list of possible features in feature_bits, then at
> >least having a common macro for the non-device specific features would
> >make sense to me.  
> 
> Yeah, I agree on this!

I guess, "possible features" shifted towards "possible features that QEMU
can not provide without the vhost backend".

But some sort of a common list does seem viable. I would however prefer
a can do without list, or maybe even two ("can do without because I do it
myself and alone" and "can do without, because although I must rely on a
vhost capability to provide that feature, the presence of that capability
is not indicated via the feature bits and based on knowing how things are
I'm assuming the capability is there although not specifically
indicated".

> 
> >
> >On the other hand, I'm also very happy to send a patch which changes the
> >behavior of vhost_get_features(), should the community decide that the
> >current behavior does not make all that much sense -- I lean towards:
> >probably it does not make much sense, but things like
> >VIRTIO_F_ACCESS_PLATFORM, which are mandatory feature bits, need careful
> >consideration, because there vhost can't do so we just won't offer it
> >and proceed on our merry way is not the right behavior.
> >
> >Please comment!  
> 
> Maybe we should discuss it in another thread, but I agree that we should 
> fix it in someway. Thank you for raising this discussion!
> 

Hm, I ended up replying in this thread because we still don't have
closure on this patch. But if you think it makes, feel free to start a
different thread, and please do include me.


> >
> >Regards,
> >Halil
> >---
> > hw/virtio/vhost-vsock-common.c | 1 +
> > 1 file changed, 1 insertion(+)  
> 
> This patch LGTM, but as I mention we should fix other devices as well,
> but maybe we can do with the common macro you suggested in another 
> patch.

I agree, this should be definitely another patch or even series
depending on how the discussion pans out.

Regards,
Halil 

