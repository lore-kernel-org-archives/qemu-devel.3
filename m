Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0B3D75E2A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERpP-0002zf-Hq; Fri, 22 Nov 2024 06:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tERpL-0002yW-LM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:27:56 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tERpH-0007kC-S5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:27:54 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.139.7])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XvtB92WtGzyWR;
 Fri, 22 Nov 2024 11:27:45 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 12:27:44 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00396a4dc3c-5bfc-4d65-bfe8-d4b9a69085dc,
 779FBE69B6F0E2356A26C58B36A0EABAAA1670E4) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Fri, 22 Nov 2024 12:27:43 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: Wafer <Wafer@jaguarmicro.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <eperezma@redhat.com>, <qemu-devel@nongnu.org>, <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] hw/virtio: Fix getting the correct ring number on loading
Message-ID: <20241122122743.0229a672@bahia>
In-Reply-To: <52aebd45-da0c-41a9-ab2f-acee8da5d7e4@linaro.org>
References: <20241122020002.564-1-Wafer@jaguarmicro.com>
 <52aebd45-da0c-41a9-ab2f-acee8da5d7e4@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 5f74a200-13a7-48c4-af55-10023659f54b
X-Ovh-Tracer-Id: 7687926039359166825
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuueeijedtleeluedthfetjeffieetffeuvefffeeftedvieefueejgfdugeetueenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddttddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepjedprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohephggrfhgvrhesjhgrghhurghrmhhitghrohdrtghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprghnghhushdrtghhvghnsehjrghguh
 grrhhmihgtrhhordgtohhmpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=bqNu3gXH1snuhIDOGSJZIX+L8pYZP8KMp3+kHU6Zg7g=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732274866; v=1;
 b=o2UJJ0WWwjY9323o6uQNSjgzzkdVT7C+Dlq+RzzWQZxx5fON68zMrSz5bADYDd8TmowdQuc0
 aATQAAbGk34klfCqj8vN5OUs43OeaT8j8bZDxAtrEShaRLi4Md5/xHwlJYSJwAshLBhDc4ce6CE
 JgdNi2WJlfVTsQdU/IJHny1tUczER/WLyNR6cKN9qT7MEXhv+wv3da/oOlHAXpMci3Uv9g1FTUB
 e899w1qZP318NZ8lVT7qFA/Yd6qd3je+TOvyPjEF4K9jSEV/chAFdG8a0sn7Daw3uK3Fpv9mloS
 bKroK0bUbUen47EK3yFYD6i48mjguZepRQeSQzP9+2uqA==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 22 Nov 2024 08:01:34 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Wafer,
>=20
> On 22/11/24 03:00, Wafer wrote:
> > From: Wafer Xie <wafer@jaguarmicro.com>
> >=20
> > The virtio-1.2 specification writes:
> >=20
> > 2.7.6 The Virtqueue Available Ring:
> > "idx field indicates where the driver would put the next descriptor ent=
ry
> > in the ring (modulo the queue size). This starts at 0, and increases"
>=20
> "modulo" ...
>=20
> >=20
> > The idx will increase from 0 to 0xFFFF and repeat,
> > So idx may be less than last_avail_idx.
> >=20
> > Fixes: 616a6552 (virtio: add endian-ambivalent support to VirtIODevice)
>=20
> This commit is only about endianness...=20

I totally agree with you Philippe (bonjour BTW). Commit 616a6552 simply
moves pre-existing VQ check code around. Contributor should `git blame`
deeper ;-)

> Do you mean 1abeb5a65d
> ("virtio: fix up VQ checks") or 258dc7c96b ("virtio: sanity-check
> available index")?
>=20

The code this patch is changing was originally introduced by the latter.

> >=20
> > Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> > ---
> >   hw/virtio/virtio.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index a26f18908e..ae7d407113 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int=
 version_id)
> >                   continue;
> >               }
> >  =20
> > -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].las=
t_avail_idx;
> > +            if (vring_avail_idx(&vdev->vq[i]) >=3D vdev->vq[i].last_av=
ail_idx) {
> > +                nheads =3D vring_avail_idx(&vdev->vq[i]) -
> > +                         vdev->vq[i].last_avail_idx;
> > +            } else {
> > +                nheads =3D UINT16_MAX - vdev->vq[i].last_avail_idx +
> > +                         vring_avail_idx(&vdev->vq[i]) + 1;
> > +            }
>=20
> ...           nheads %=3D UINT16_MAX; ?
>=20

Exactly and since everything is uint16_t there, we get that for free with
the existing code base. IOW both arms of the if produce exactly the same
result... I don't know the motivation behind this patch but it does not
change anything.

Cheers,

--
Greg

> >               /* Check it isn't doing strange things with descriptor nu=
mbers. */
> >               if (nheads > vdev->vq[i].vring.num) {
> >                   virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>=20

