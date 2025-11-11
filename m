Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF5CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 13:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIoRO-0004g4-0g; Tue, 11 Nov 2025 08:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vIoRL-0004Wp-6w; Tue, 11 Nov 2025 08:29:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vIoRI-0003XO-Gm; Tue, 11 Nov 2025 08:29:42 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5S6y5MqtzHnGjn;
 Tue, 11 Nov 2025 21:29:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id DCAE4140136;
 Tue, 11 Nov 2025 21:29:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 13:29:31 +0000
Date: Tue, 11 Nov 2025 13:29:29 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Message-ID: <20251111132929.000064ce@huawei.com>
In-Reply-To: <20251105154657.37386-5-skolothumtho@nvidia.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 5 Nov 2025 15:46:52 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Install an event handler on the vEVENTQ fd to read and propagate host
> generated vIOMMU events to the guest.
>=20
> The handler runs in QEMU=E2=80=99s main loop, using a non-blocking fd reg=
istered
> via qemu_set_fd_handler().
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
A few minor suggestions inline.  Otherwise set looks good to me, though
I'm very far from an expert of this stuff!

Jonathan

> ---
>  hw/arm/smmuv3-accel.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  2 ++
>  2 files changed, 64 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 210e7ebf36..e6c81c4786 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -383,6 +383,62 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUS=
tate *bs, SMMUPciBus *sbus,
>      return accel_dev;
>  }
> =20
> +static void smmuv3_accel_event_read(void *opaque)
> +{
> +    SMMUv3State *s =3D opaque;
> +    SMMUv3AccelState *s_accel =3D s->s_accel;
> +    SMMUViommu *vsmmu =3D s_accel->vsmmu;
> +    struct iommu_vevent_arm_smmuv3 *vevent;
> +    struct iommufd_vevent_header *hdr;
> +    ssize_t readsz =3D sizeof(*hdr) + sizeof(*vevent);
> +    uint8_t buf[sizeof(*hdr) + sizeof(*vevent)];
Could you wrap this up in a structure to make it a tiny
bit more obvious what is going on?

    struct {
        struct iommufd_vevent_header hdr;
        struct iommufd_vevent_arm_smmuv3 vevent;
    } buf;

Should allow sizeof(buf);
and accessing elements directly without casts.

> +    uint32_t last_seq =3D vsmmu->last_event_seq;
> +    ssize_t bytes;
> +    Evt evt =3D {};
Given you copy into this based on sizeof(evt) I can't see why you need
to initialize.

> +
> +    bytes =3D read(vsmmu->veventq->veventq_fd, buf, readsz);
> +    if (bytes <=3D 0) {
> +        if (errno =3D=3D EAGAIN || errno =3D=3D EINTR) {
> +            return;
> +        }
> +        error_report("vEVENTQ: read failed (%s)", strerror(errno));
> +        return;
> +    }
> +
> +    if (bytes < readsz) {
> +        error_report("vEVENTQ: incomplete read (%zd/%zd bytes)", bytes, =
readsz);
> +        return;
> +    }
> +
> +    hdr =3D (struct iommufd_vevent_header *)buf;
> +    if (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
> +        error_report("vEVENTQ has lost events");
> +        return;
> +    }
> +
> +    vevent =3D (struct iommu_vevent_arm_smmuv3 *)(buf + sizeof(*hdr));
> +    /* Check sequence in hdr for lost events if any */
> +    if (vsmmu->event_start) {
> +        uint32_t expected =3D (last_seq =3D=3D INT_MAX) ? 0 : last_seq +=
 1;
> +
> +        if (hdr->sequence !=3D expected) {
> +            uint32_t delta;
> +
> +            if (hdr->sequence >=3D last_seq) {
> +                delta =3D hdr->sequence - last_seq;
> +            } else {
> +                /* Handle wraparound from INT_MAX */
> +                delta =3D (INT_MAX - last_seq) + hdr->sequence + 1;
> +            }
> +            error_report("vEVENTQ: detected lost %u event(s)", delta - 1=
);
> +        }
> +    }
> +    vsmmu->last_event_seq =3D hdr->sequence;
> +    vsmmu->event_start =3D true;
> +    memcpy(&evt, vevent, sizeof(evt));
> +    smmuv3_propagate_event(s, &evt);
Why is the copy needed?  Can't you just use the vevent in place?
> +}



