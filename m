Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEFC106F2EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5fgI-0006gd-Bt; Thu, 26 Mar 2026 04:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5fgG-0006gU-OS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5fgB-00085k-Lg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774512177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Awjq4Yj3N0BTR6TqSs78a5NIbuNaZVh+hfK4iv2nQLM=;
 b=BlwJXVBYTZ/bxBgbLc90MP6/beY642lQTzNaqCaL/UQVGfjcwIePhh7cRq62+6++W/oqJp
 e52LipYtJ2MNY+5yv7N5s4eLu6S+QCl0yQDbIQZOLVM1TyjjMLlKAZtTAFaulRqNnEwWT7
 +wpTzSb+u93RTBeHsYSuyfsJi/FDDcE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-jyTmfBLMOi-ZPahdIRveew-1; Thu, 26 Mar 2026 04:02:55 -0400
X-MC-Unique: jyTmfBLMOi-ZPahdIRveew-1
X-Mimecast-MFC-AGG-ID: jyTmfBLMOi-ZPahdIRveew_1774512175
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7986c067508so21674167b3.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 01:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774512175; cv=none;
 d=google.com; s=arc-20240605;
 b=NYmf3hsOT2C/8ZdYYSYTNaWLuJPaYRKLSn9zQ05mKW30VP4XppNxLJtiwMAqBRtcsZ
 Lyp2LZg7HYwqMU0C2HxpVdman2Abn/DaFWf1rDKSmbofO8aglOP4cLAwCvzNxqy4Hg8W
 FzhPC0F2puzKdFjTlZw6oR6GjaOzSdEVNyxJTW5faYi7VoSgGtwgqBQz3fk3sjPu1fG7
 zReRN3evCju0WFAtRiQOOkmNkjEBRYKpWWaRc2MZw5dBOZKJ46Lg6BuUxMxXJ9JckKWf
 nJlPdI7eVtAdB/7JIIOfgvWsv5nFsI7WxET9EqozQm68XCuTYWWYiUDn8LgvLqA4wLN7
 GhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Awjq4Yj3N0BTR6TqSs78a5NIbuNaZVh+hfK4iv2nQLM=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=GgYUw/ARTneRjDW5JMX+YpKiA7Xg++v7zC/j+4aSqGk6h2Y5ml9knn38va/b+JinY1
 ModoC8Kcg/RX99UeF35fZvKcRkxcFnp8AhA+/UAB6ywRZI/tWKkmg6C4negaoNi/NO+M
 yosUUUE9BsrENCrDatqIjdctrIAAwUTYlRTi3aTpD9vxhbGiR8a1EnucqfRNg85ERs3g
 tb3WIKXzzNfdtqvgAsb7UwX9auFYqv9uRjj3STGUz555PgHNPvzMPyLSclyPuFVTAp1n
 +FwijHtUHPXEzSMzyDTUk3hnMHA+O7ZMM/wPa5qUym2i0F7VbqT8CPW0zI2byxnJPAfC
 D7cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774512175; x=1775116975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Awjq4Yj3N0BTR6TqSs78a5NIbuNaZVh+hfK4iv2nQLM=;
 b=CpUl84u74iGUDNW1d6G79SOVRDEu0R9EpQRq0ic05YqpgvCpkpa5o7bOiZ1L2dO68k
 EL1i7nUNO3Q55syxvhoX3HCGK6eFFmPbQkBkLpOf3siy9xUCPC93GU+LJJK/GFisie0I
 bUpAqPQ+7803oWiMCbElVFElvhLPUPK3HKNwDNynuhm/AMrAFQSC7U3k9ALPCcnr/gok
 RIySNylMUMS9TY1g3eJe6ob+Xzncat6Uuu8ZolE8wN+VFb1B3H6ZWRev3RRJpR+VVODB
 DkrkMFU1OxDNMZqkFkc/kVkMz63fAG+VDcQis+hXNzEFkKm2I22GCKTCxus8u1Y/9iKe
 rUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774512175; x=1775116975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Awjq4Yj3N0BTR6TqSs78a5NIbuNaZVh+hfK4iv2nQLM=;
 b=r2E+c2Um2BBj7nTFlT7zbjOkAZLlTBAint5FEcabSRdTPqX7vyBTUvZRtGWwJFRmjN
 pGkJz481X5CkOA2KSrhXaCeu2pyeLeB6RhGdPoZqUmPryAVmRC2dXUgO9P3XsKmZkwCo
 aKymk6u3SD0XqDvYuGWkkGmD5GntVMZZId8wEgjQhyPnw78gZRX+T95irEAi+hoQm3pw
 RB235EKWrpX5Lo6L0/fLw7ltBvAs3jkSPZF5rvsLJVxsAzAN04pVrjUYHORGePyE9rtQ
 GCpfDZXUzN9oeumgtkLg6n07vDOzflfRrPZV9w1EaawtgQtfrQyO8f69Zlgk50ZU0UDd
 cZaA==
X-Gm-Message-State: AOJu0YwxqmqNB+qBEJOAVJRCciAQ57WVlNTUAOXlx8AtF5+ZruIUD7Va
 lHzDCebaezPuFmne0OG6w7UI+JeT4+UQtyzuo1RSe+tqVa01pidCsB6FpBf4DROy6Lxwis6x9Kl
 NYDnF+KeXEXF4HNp8VyHeMkfHNdZDMc8v2NlIDUug6PdANf1MFQu6EA8NwY1T2uOXoNVzVXzXmS
 gkM63X3zqBn+hChK0ygC8cxH1AQ7iTIHA=
X-Gm-Gg: ATEYQzwfZGb+HhDhp6CecR/6m7Npk48He9iJxy/4tuiZUAY8ftzwYVGdGxOdA5Llw0W
 mrdWTBccwNcMlltpCwfjmPyNzKfYt7J2XCcJpCZYpvghmhhUNuYbdJkguN+ZoxTUlqtxZrC1MFI
 DGbGp9+g1S96JxE+SvhbrdWLx9KCLPTJMrKtKQGDAD+yGEn40IiMDcy7M8nHufhaJYq6P8cyiEi
 Qd7qQ==
X-Received: by 2002:a05:690e:4090:b0:64a:d1ac:4528 with SMTP id
 956f58d0204a3-64ee61203dcmr5792237d50.39.1774512175166; 
 Thu, 26 Mar 2026 01:02:55 -0700 (PDT)
X-Received: by 2002:a05:690e:4090:b0:64a:d1ac:4528 with SMTP id
 956f58d0204a3-64ee61203dcmr5792201d50.39.1774512174509; Thu, 26 Mar 2026
 01:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-2-jonah.palmer@oracle.com>
 <CAJaqyWf5==jZxJErazeAea1NxpGB2SFNdpAPh7bi5tc69FytTw@mail.gmail.com>
 <cbe7eff3-179d-4bc7-8fcb-ab0ab805a46e@oracle.com>
In-Reply-To: <cbe7eff3-179d-4bc7-8fcb-ab0ab805a46e@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Mar 2026 09:02:17 +0100
X-Gm-Features: AaiRm520nZ9fuYd_C_cj0Gt3vBqYsn_x2ivDWv1J580FkKmXF3qB74INUBKx3Ao
Message-ID: <CAJaqyWdR2Rrk=V2rdap16PKvHCzbPSXwakj33gxGruo03tN4Sw@mail.gmail.com>
Subject: Re: [RFC v2 01/14] machine,virtio-net: add early-mig property
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 24, 2026 at 3:07=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/23/26 6:25 AM, Eugenio Perez Martin wrote:
> > On Fri, Mar 20, 2026 at 3:20=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Introduce a new 'early-mig' property that enables the early migration
> >> path for virtio-net devices on machine types >=3D 10.2:
> >>
> >>   - virtio-net-device,early-mig=3Don
> >>   - virtio-net-pci,early-mig=3Don
> >>   - virtio-net-pci-transitional,early-mig=3Don
> >>   - virtio-net-pci-non-transitional,early-mig=3Don
> >>   - virtio-net-ccw,early-mig=3Don
> >>
> >> To preserve compatibility for older machine types (<=3D 10.1), add com=
pat
> >> overrides in hw_compat_10_1 to keep the legacy default (off).
> >>
> >> With this, machine types 10.2 and newer enable early migration by
> >> default while older machine types retain the previous behavior. Users
> >> may still override explicitly via:
> >>
> >>   -device virtio-net-pci,early-mig=3Doff
> >>   or
> >>   -global virtio-net-device.early-mig=3Doff
> >>
> >> Follow-up patches will implement the actual early migration feature fo=
r
> >> virtio-net devices.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/core/machine.c              | 5 +++++
> >>   hw/net/virtio-net.c            | 1 +
> >>   include/hw/virtio/virtio-net.h | 1 +
> >>   3 files changed, 7 insertions(+)
> >>
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 6cf0e2f404..1b6c7db119 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -45,6 +45,11 @@ const size_t hw_compat_10_2_len =3D G_N_ELEMENTS(hw=
_compat_10_2);
> >>
> >>   GlobalProperty hw_compat_10_1[] =3D {
> >>       { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> >> +    { "virtio-net-device", "early-mig", "off" },
> >> +    { "virtio-net-pci", "", "off" },
> >> +    { "virtio-net-pci-transitional", "early-mig", "off" },
> >> +    { "virtio-net-pci-non-transitional", "early-mig", "off" },
> >> +    { "virtio-net-ccw", "early-mig", "off" },
> >
> > Is this needed even if we mark the VMState as optional?
> >
> > The source might not be able to send the device configuration in some
> > cases. For example, if it cannot shadow CVQ. If the destination knows
> > this field is optional, the QEMU source version is irrelevant.
> >
>
> I think it is still needed, yes. This series adds new VMSDs that are
> registered as top-level savevm sections, and, IIUC, a destination guest
> using an older version of Qemu would not be able to ignore these
> "unknown" sections, even if they're optional for the source to send.
>
> The compat property also preserves the pre-10.2 machine-type default, so
> a 10.1 machine type doesn't silently change the migration behavior when
> it's being run on a newer Qemu version.
>

Ok good point. I'm tempted to propose removing the cmdline argument
then, but I see virtio-mem "x-early-migration" also adds it. I don't
think increasing the migration's complexity by adding command-line
cases is worth it, but I guess there is a reason for that. What about
setting it to true by default?

Also, maybe it is worth exploring using the same name for both
properties. At the same time, I remember that x- prefix was
discouraged so... I'll be happy with any option
{x-,}early-mig{,ration}.

Again, I wouldn't object to adding the cmdline parameter, I'm just
trying to make this as easy to maintain in the future as possible :).

> I do agree though that being unable to shadow some state should be
> handled as a runtime check for early migration (like we do for
> vhost-user), but that's separate from a machine-type compat default.
>

Yes, I missed that vhost-user and vhost-vdpa were out of the series at
this patch. It happened with a few comments. I should have gone back
and solved them myself; apologies! If possible, and if you see it
makes sense, you can expand the patch descriptions with the info.


