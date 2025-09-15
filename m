Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9170DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9cO-0001bA-50; Mon, 15 Sep 2025 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uy4mz-0008ES-0l
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:42:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uy4mm-0002UI-4b
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:42:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F0lHnU013144;
 Mon, 15 Sep 2025 08:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J1lm84
 ULTZXed6oqC699109lgXjsMMrE9rICy5hMNFM=; b=Qb59NMk1O0HWUxA6RcnprV
 H/HbsBEmiDswesR7FaO+34xA4L7oVz+WRT1eAM6h5Z6sNp9OSP5suuy5KVcUSgsF
 VoiuDbNCTrBQN5houqng6fli95DM5tCaMboVMEXGZT4oAfR8hvCGqIKNSdYbf4jG
 PE5h+rI0IOiODUBWEWdsRheXNOYE4M//JkoiiE2wSI/izfK9FmzhqVykYNOE0YjI
 1L56haoe01VfCtzm4t+24H4p05QEayrrZSbtgiL9LRmUfhn3qQj406V3Nnwrlkj+
 4MoztuxfRtAUlNI5coz65Dx52zznqJyhD8ykVxoER6BT5FHuHDRzcy7tuDyqcCxw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b1g9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 08:41:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58F8frtM002711;
 Mon, 15 Sep 2025 08:41:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b1g9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 08:41:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58F52MJY009363;
 Mon, 15 Sep 2025 08:41:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3568p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 08:41:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58F8focS51052890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Sep 2025 08:41:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58B5E20043;
 Mon, 15 Sep 2025 08:41:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96CE420040;
 Mon, 15 Sep 2025 08:41:45 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.61.137.228]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Sep 2025 08:41:45 +0000 (GMT)
Message-ID: <866f7190cf6423a7fc1e85070e2059ae7014c231.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	 <marcandre.lureau@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Amit
 Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum	 <marcel.apfelbaum@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, Szymon Lukasz
 <noh4hss@gmail.com>
Date: Mon, 15 Sep 2025 10:41:44 +0200
In-Reply-To: <aMPe1vB3cZAlNBq1@redhat.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912042910-mutt-send-email-mst@kernel.org>
 <aMPe1vB3cZAlNBq1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX3qJnnTRzN3sa
 XXUNqLYVQEl2hnIAwdhagw8ErqjPZ7nL33pO+HTzk8XQnXa5aFWgmSgqbkm3u0ItdlehpdFksTE
 DOxKP6zLdfYFNJOuiqhXzrXuy0O34PwP97h51iZSMz3sr4kF41p13BY+wEjbAawo7oknCC+m+8n
 njTYxE+QmaJ/871X4A/P2FJX0Z1HvzMk2m5dfE/f38qm04AvNhUA07EM7nvJVlvM+rVXf4q/Dr5
 hddwbsGTsBWVQazfVcWXsmJBzNw02wrj3qtXEQ1XdYk7nQO4Lf2NR75Hxu1Q5rUewr5xWThM8BO
 QDBvPxGsl3bN99jypAqFbOQcZ3bpBhNf5vA0jrgr8VpvvCGD5zuUl7uQqt5WQjbuZEoebi4unxv
 QPs+HBGz
X-Proofpoint-ORIG-GUID: s50Xwt9cs5S7B4ju5QL01CKMIrmu7yCh
X-Authority-Analysis: v=2.4 cv=dt/bC0g4 c=1 sm=1 tr=0 ts=68c7d151 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=69wJf7TsAAAA:8 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=sfQK5_NHEOywqs1JQfQA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: izfb5NfokCkeihxYheGn8ILfqGXW8zoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Sep 2025 09:51:38 -0400
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

On Fri, 2025-09-12 at 09:50 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Sep 12, 2025 at 04:41:02AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 12, 2025 at 05:39:45AM +0200, Filip Hejsek wrote:
> > > The goal of this series is to have a resizable terminal into a
> > > guest
> > > without having to set up networking and using, e.g. ssh.
> > >=20
> > > The virtio spec allows a virtio-console device to notify the
> > > guest about
> > > terminal resizes in the host. Linux Kernel implements the driver
> > > part of
> > > the spec. This series implement the device part in QEMU.
> > >=20
> > > This series adds support for a resizable terminal if a virtio
> > > console
> > > device is connected to the stdio backend.
> > >=20
> > > This series also introduces resize messages that can be sent over
> > > QMP to
> > > notify QEMU about the size of the terminal connented to some
> > > chardev.
> > > In the libvirt setting, it will allow to implement a resizable
> > > terminal
> > > for virsh console and other libvirt clients.
> > >=20
> > > This patch series was originally authored by Szymon Lukasz and
> > > submitted
> > > to qemu-devel about 5 years ago. The previous submission can be
> > > found at
> > > <
> > > https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09591.
> > > html>.
> > > I have updated the patches to be compatible with latest master
> > > and made
> > > a few small changes of my own, including the addition of Windows
> > > support.
> > >=20
> > > Probably the most important change I made is the swapping of rows
> > > and
> > > cols fields in resize messages. I would like to hear some
> > > feedback on
> > > this change from reviewers. The problem is that for a long time,
> > > the
> > > Linux kernel used a different field order from what was specified
> > > in the
> > > virtio spec. The kernel implementation was apparently merged
> > > around 2010,
> > > while the virtio spec came in 2014, so when a previous version of
> > > this
> > > patch series was being discussed here on this mailing list in
> > > 2020, it
> > > was decided that QEMU should match the Linux implementation, and
> > > ideally,
> > > the virtio spec should be changed.
> > >=20
> > > However, recently, the Linux kernel implementation was changed to
> > > conform
> > > to the spec:
> > > <https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c70
> > > 56ddd>.
> > > As a result, to be compatible with latest kernel releases, QEMU
> > > needs to
> > > also use the field order matching the specification. I have
> > > changed the
> > > patch to use the spec-compliant order, so it works correctly with
> > > latest
> > > kernels now.
> > >=20
> >=20
> > Well this is not in any release yet. If you want me to revert that
> > one, let me know ASAP. Maximilian?
> >=20
> > > That leaves the issue of older kernels. There are about 15 years'
> > > worth
> > > of kernel versions with the swapped field order, including the
> > > kernel
> > > currently shipped in Debian stable. The effects of the swapped
> > > dimensions
> > > can sometimes be quite annoying - e.g. if you have a terminal
> > > with
> > > 24 rows, this will be interpreted as 24 columns, and your shell
> > > may limit=20
> > > line editing to this small space, most of which will be taken by
> > > your
> > > prompt. The patch series in its current form provides no way to
> > > disable
> > > the console size functionality,
> >=20
> > Well I see the console-size property, no?
>=20
> At least in the case of libvirt managed VMs, this series does
> nothin by default, as they won't be using the 'stdio' chardev,
> they'll require libvirt to first wire up the new QMP command,
> and then apps using libvirt to call it. So in that sense, it'll
> take a while before the effects are seen by users.

Correct me if I'm wrong on this, but shouldn't the 'pty' chardev also
be able to take advantage of the same size change mechanisms as the
'stdio' chardev (receiving SIGWINCH and being able to use the ioctl
TIOCGWINSZ)? If so the work for the 'stdio' chardev should probably be
replicated for the 'pty' chardev.=20

>=20
> > > so users may end up worse off than if
> > > the functionality were not implemented at all.
> >=20
> > If we want to keep the Linux patch, the straight forward way is to
> > send
> > the fix to stable@ then poke at Debian at al to fix their kernels.
> >=20
> > Another option is to make the property default to off, have
> > management turn it on when guest is up to date.
> >=20
> > But it really sounds like we should revert that Linux patch.
> > I posted a revert, pls comment.
>=20
> What about other non-Linux guest OS that may have correctly
> implemented the virtio spec ?
>=20
> At least FreeBSD appears to /not/ implemenmt resize at all:
>=20
> =C2=A0
> https://github.com/freebsd/freebsd-src/blob/main/sys/dev/virtio/console/v=
irtio_console.c#L884
>=20
> Do we have a Windows impl of virtio-console with resize support ?
>=20
> Any other places we should check ?
>=20
> With regards,
> Daniel


