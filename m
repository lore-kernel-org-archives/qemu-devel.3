Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134A3E6BF1B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 15:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlqVJ-0007ff-34; Fri, 30 Jan 2026 10:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlqVH-0007fR-8M; Fri, 30 Jan 2026 10:33:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlqVF-0004S7-HL; Fri, 30 Jan 2026 10:33:47 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60U2HJ4B022808;
 Fri, 30 Jan 2026 15:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UaMJQr
 HTT/lDL63OOQbqhkIszjiyQqNXrhG20Etkzsw=; b=lSSuofj7TBZY08lhqvfGbp
 vVdnvXIGacixJs4WsE9i/hZt3MINfY5Llb7EfwS57NkM9yx1ceFyCX18dMYtUvW7
 mmf+Bd/7p1kJGyBGv64c52HHG8Xahct6P6OeKhEhEXMfkjYy+P9cOxnlgDcPVc+6
 vkKRfdz7BguvQT/K8uoFvN5UwlGok1GjOgYEcxF8D5EZtcbTAQxFQCcycjmbI1wG
 uuoPNed3GTHXQbkGz9p/YAh2SPxt+zoMTPfp2seo+c5SS0jjK7Ua7NT3V4vX5oWv
 bgyCAVMA1jaEJHRaLtrwOi/vc5ijd5SaiL1Rail75RxR+l5VTnSDYBITICbyl+XA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn3hk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 15:33:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UB5uIl026384;
 Fri, 30 Jan 2026 15:33:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkpnud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 15:33:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60UFXcOj18350816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jan 2026 15:33:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD8BF5805C;
 Fri, 30 Jan 2026 15:33:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E7AF58051;
 Fri, 30 Jan 2026 15:33:37 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.188.113]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jan 2026 15:33:37 +0000 (GMT)
Message-ID: <28313ff2e6fc34f45304ba19b8b9380fc4ba167d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/23] virtio: move common part of
 _set_guest_notifier to generic code
From: Eric Farman <farman@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich	 <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth	 <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Date: Fri, 30 Jan 2026 10:33:37 -0500
In-Reply-To: <20260126230026.2664d565.pasic@linux.ibm.com>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
 <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
 <26198787-a1da-4858-8656-f5006d153d6e@yandex-team.ru>
 <20260126230026.2664d565.pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697ccf54 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mkMtH7XpAAAA:8 a=6R7veym_AAAA:8 a=eel-Nh6MelB4_e8R7-IA:9 a=QEXdDO2ut3YA:10
 a=WtO8poqlptoA:10 a=I9Slk6e--tAXHahELIuT:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: cbAzQL0-5fQYaET-8f15tkBMxyyyx2Ub
X-Proofpoint-ORIG-GUID: cbAzQL0-5fQYaET-8f15tkBMxyyyx2Ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfXwHC+gkj6jf+F
 q5BwaCqqJ8IkY4qFjjMaE99toFXFyKakMC/HXdOS4DJw0sLukcsOg7Vz5mW+cqY1c23Xymn78M2
 WLnP7EOmuH1eC7o8rAHvoXbUU0aM3fZlNpMh2De2cENeQB5UEd6JvQqnjt5r2lDB4Q9ModOjZrO
 LMSnZhvT4tL1kR4pgEXef6L8rMfE0wrototlZXNnw/yHY38KDxhN9Fw343ukVTpo3XdlbogcYW0
 qVhFu4iIQx9quqN4Lt5TfflduGJXKx89A5rrF/doadBzdeGgVgsUrfLtMoKnjhqmgWSHScBxrVC
 MTY9CbxIZ7IadqU9wzsQIrqpdtRjDT4nn+PMuVbN5N8NSycMHko2do5g5690o70Kim1ggkiNBvT
 pVsS2sq6tq+hDJj92HYaAgRblVZYHQPleWGdIMv7t33b9O4ABRPN82ScydVF56oimrLAz29LEpq
 Mu02Eg8WVlqIxpsjdhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2026-01-26 at 23:00 +0100, Halil Pasic wrote:
> On Mon, 26 Jan 2026 19:40:09 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>=20
> > > > +/**
> > > > + * virtio_queue_set_guest_notifier - set/unset queue or config gue=
st
> > > > + *     notifier
> > > > + *
> > > > + * @vdev: the VirtIO device
> > > > + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notife=
r =20
> > >=20
> > > Semantically are mixing queue numbers and interrupt indexes here. =
=20
> >=20
> > That's preexisting logic in virtio_pci_set_guest_notifier_fd_handler().
> >=20
> > But, you are right, that's doesn't answer the question, is it good to s=
hare
> > the logic with mmio and ccw.
> >=20
> > Is config notifier only pci specific, or similar feature may appear in =
future
> > for mmio and/or ccw?
>=20
> AFAIR there is no  notifier for ccw. A possible explanation for
> that is, that AFAIK that config space notifications (device -> driver)
> are always classic I/O interrupts while queue indicators can be so called
> adapter I/O interrupts and irqfd is only available for adapter I/O
> interrupts.=20
>=20
> If you like you can have a look at=20
> "4.3.2.6 Setting Up Indicators" in
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.ht=
ml#x1-1940003
>=20
> I see no reason why virtio_config_guest_notifier_read() based, i.e
> !irqfd virtio config notifier should not exist or would not work. And I
> guess it is needed for certain vhost things. But nevertheless, I can't
> find the place where a virtio-ccw config notifier is set up.
>=20
> Eric, what is your opinion on this? My current thinking is that
> virtio-ccw not having a config notifier is basically a bug.

(Sorry that I missed this; thanks for the ping, Halil)

Yeah, we don't have have such a config notifier and I don't recall the hist=
ory behind it.
But I don't know that it's a bug; spec points out config notifications for =
ccw come as unsolicited
interrupts versus config notifier, so not having one is fine by me as far a=
s this refactoring goes.
I'll add it to a list of things to play around with, though.

Thanks, Eric

