Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F246C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlhPa-0003yh-ST; Mon, 20 Jul 2026 02:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wlhPY-0003y3-0R
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wlhO3-0004TQ-5V
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784528518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2J32L+1lxi3jmodmKqNcQ9Aq+wBdXHzlDhywa4t9PSY=;
 b=O2OtTbvulnkzFk3omfrfsBnlavVx9KHUCdzpMx31uloAZ+lvC1s5sqYNLitW4w02dQ2iEd
 iImgvwDQhd9pPxQLodAC7Q5OskJQXjYOnzUfDwiI6hfy9FNrQRfkv5QQHVb18cfjKjnFS5
 VqTQDDYabXQ6UBSuGV+xG+wYl8yBJTA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-cZP0I-3lPxG3RxwvSYasHg-1; Mon, 20 Jul 2026 02:21:56 -0400
X-MC-Unique: cZP0I-3lPxG3RxwvSYasHg-1
X-Mimecast-MFC-AGG-ID: cZP0I-3lPxG3RxwvSYasHg_1784528515
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cce870a060so171750355ad.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 23:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784528515; cv=none;
 d=google.com; s=arc-20260327;
 b=rEBs3/QPrCVTjcIOcE3Nrv083p0InXcTymnX/jyidM5FHBFYLCzWGLYbFUu0x5OXqe
 weoBtUQv3aP+bq1DdfVM0MpfymZH5CjkT1GgEynFuVeG/eSf2jVJTnCdI+YsXjvtfpn2
 7jUif4CYNC3FHQzlra2A3ijvM2IfqpgQaCAr9NgQR5lI0o1hsSND8Q7/tSgR/ZL3GGUE
 bAbD6CCC/qmYhge49PU0qadQHvuX/3OTvt6LLUzsRozPM0oksxVKvALXfFLzoc2ZMklK
 AEPxiBlJfl/w1tQSuf9QdSlEOXainZciYbQoG6amF24u2AZZhoSv/COpjWh/qdJPMTM7
 Sp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2J32L+1lxi3jmodmKqNcQ9Aq+wBdXHzlDhywa4t9PSY=;
 fh=yzz1aAekw7vcfFMXgh0u/CQjH9sG1XpAIfAVugbAa9o=;
 b=I37/tn2Osp/3ZDgU6g1/XOre43gjryeC02K2Zk16NdAp+Gks5CHXMXoxPS9ESU/mQs
 nDrFqOfZWtIZ9qoBU1L1QQFNYUUun65MIllbITupZDuIaBkgcj1WLD4dzkjfXxnuVBdI
 jlMhiWcKV6GxflTMxJ4DixNGvLd3CjrPM3vRBhjY7QmouKWnlzbPNLm4A3LTcrVi2eRD
 rejomUPYZCDdHO/Xkqi+u5MIZPts8d2N72TJjSRXgT1eh2rJ2m1n/PdwemtQ7s0h7zWB
 5MNOIa6WZpwh5ReC6rqll1/mqgdwXh9jwB9SCFtgTzx3KQk1rkzuPY45UorUhj2AnXSq
 D7Ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784528515; x=1785133315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2J32L+1lxi3jmodmKqNcQ9Aq+wBdXHzlDhywa4t9PSY=;
 b=lvKe4I+k1A0wYgrSvwfRIC44rUpUjdGEqq/nnYzcfPaDkC34LvbwmxrtZbL48jGE8U
 3QU3KszbZAjCeQKzDyK/C5fc7vxUa6yKxLg2r1Q4IT4qeND6Ry+LVDQULYguBZH6PJ3L
 pkqbWa5Cnch9wgBLNOlTWn2F9NCc1XcqeH/fLzPl3lsW/rxtNNvUrRk0rlqrhf3n65Gc
 e3jjuJHgB8XYOyUv8ow8hOLXksZLudn9PawbHnmUpAJ5qTzrUqUe2juI3BtgmoWNo8mf
 sQi0xYu/Oi0bz9hJrmiT8H5Nxzzfrs80ZpKqYqjOLD+OQe+rvuACqFVbe/jOwTaQnNVr
 Tczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784528515; x=1785133315;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2J32L+1lxi3jmodmKqNcQ9Aq+wBdXHzlDhywa4t9PSY=;
 b=Y026swv4JWiNvrc7ih5iD+aBem0A4On6yjdQLC+oJqiAtEogsUuJ/6o1NK8/4+3ylB
 08re/tVpMs22d6EMmwTxf9IRfASwSkvLjaeSEHBAVNslyWv3tn/65/oo8r7o6oqKg+KF
 cZeT81wtOtmYAR+G2VxQDf5NCzGimi4U9iyjfql6A8yt0moaMCXb6LyBd7Wn5den9N5r
 DNmDMYaBuTSl6+tGN3FerM4l0rOe4d5ultBCEoifSx8ThwFsvcee+9sZfNX597g7PsfX
 YM2ntY96pqqYwdI11m4b8iHfG71U72/sAN4TjfBS0T7I9Dg/mOLmfSdVqaV2D0L0gMiU
 Gp1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqEgBhT2Se3Z3oc9XIKMVz2wb9c0sbzOgv8yOesjHSrdnz/a5Uo5QRNjDEgcLoLpbjfSAMJtCbpJSX@nongnu.org
X-Gm-Message-State: AOJu0YyKoC005HH5wz9gfUe/L71MhxpG2EHnx4IQbORjJQ+D6peivFhk
 mspHtiP8m4VOtpzK2eAFXUbr9t3WDM1KsbFWjv4GsNJD/waGWCHkyQiFtHOjamqDkJL/ZF4oOXp
 xXLffE1Ou8wqXodnISPwiI1BViN2hjgGV3qxtKLfOMoXMpWXnyMuIKxJqZmZOmRtvb0Y9ugpPc9
 VJEUShPzKkWFXwrO6wrX6U1usynPrfnL0=
X-Gm-Gg: AfdE7cmwHhRxQ8nRlRNsNrKWI5qMcify/4SWFvSrD/sEDDxNee8b8Jezer/6pZc05z7
 FyOfN7i9bcYRwZUwFkh6GwAKs9OIw/PfIU+BVO3IlXD8ALKa9VQK8PqXoAO3hQUPWIX8hBeGUE6
 buAlVe3gqGiAhuAOiMIivGdrmEGwoyyjspENO8SxQKK1jMr+3C4BB2/RcFzPCPGffLnrugDescx
 BIPzVE/QVK21a79w/vzceiGY6imcsi1s1uFCHcZYYIaSkhUzX+FIaTsS/i8HRYvSyto1wTiXMV/
 zw==
X-Received: by 2002:a17:902:e890:b0:2ca:1bd2:d57b with SMTP id
 d9443c01a7336-2cf34633722mr134146025ad.0.1784528514771; 
 Sun, 19 Jul 2026 23:21:54 -0700 (PDT)
X-Received: by 2002:a17:902:e890:b0:2ca:1bd2:d57b with SMTP id
 d9443c01a7336-2cf34633722mr134145755ad.0.1784528514184; Sun, 19 Jul 2026
 23:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
 <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
In-Reply-To: <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 10:21:39 +0400
X-Gm-Features: AUfX_mzROiUXuP_0MQ9leRrxkx3q9iH8v_1GK_DjvLq52hX0dkMH2e-CZo_B3v8
Message-ID: <CAMxuvaw3hj2o2tQh5aUDtE_ZuP8SG+z-obXUMByZiNHY403SBA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: unregister vm_change_state handler and
 BHs on device exit (CVE-2026-63322)
To: Thomas Huth <thuth@redhat.com>
Cc: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org, philmd@mailo.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, qemu-stable@nongnu.org, 
 Haotian Jiang <sundayjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 10:15=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
>
> Thanks for the patch! ... I've got a question below...
>
> On 20/07/2026 04.48, jianghaotian.sunday@gmail.com wrote:
> > From: Haotian Jiang <sundayjiang@tencent.com>
> >
> > qxl_realize_common() registers a vm_change_state handler via
> > qemu_add_vm_change_state_handler() and creates three bottom halves
> > (update_irq, update_area_bh, cursor_bh), but none are ever cleaned up.
> > The return value of qemu_add_vm_change_state_handler() is discarded, so
> > the handler is never removed from the global list, and there is no
> > PCIDeviceClass.exit callback to delete the BHs.
> >
> > When a secondary QXL device (hotpluggable by default) is hot-unplugged
> > via device_del, the PCIQXLDevice memory is freed but the vm_state
> > handler and BH entries remain with dangling opaque pointers. On the
> > next VM state change (stop/cont/migrate) or BH dispatch, the callback
> > dereferences freed memory, causing a use-after-free.
> >
> > Fix this by storing the VMChangeStateEntry returned by
> > qemu_add_vm_change_state_handler() and adding a qxl_exit() callback
> > that deletes the vm_state handler, all three BHs, and the
> > guest_surfaces.cmds allocation before the device memory is freed.
> >
> > Fixes: a19cbfb34642 ("spice: add qxl device")
> > Fixes: CVE-2026-63322
> > Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaot=
ian.sunday@gmail.com>
> > Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3607

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> > ---
> >   hw/display/qxl.c | 15 ++++++++++++++-
> >   hw/display/qxl.h |  1 +
> >   2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> > index 74258afa58..c9323672a6 100644
> > --- a/hw/display/qxl.c
> > +++ b/hw/display/qxl.c
> > @@ -2203,7 +2203,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl,=
 Error **errp)
> >           error_report_err(err);
> >       }
> >
> > -    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl)=
;
> > +    qxl->vmstate_handler =3D
> > +        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, =
qxl);
> >
> >       qxl->update_irq =3D qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
> >                                             &DEVICE(qxl)->mem_reentranc=
y_guard);
> > @@ -2475,6 +2476,17 @@ static const Property qxl_properties[] =3D {
> >           DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
> >   };
> >
> > +static void qxl_exit(PCIDevice *dev)
> > +{
> > +    PCIQXLDevice *qxl =3D PCI_QXL(dev);
> > +
> > +    g_clear_pointer(&qxl->vmstate_handler, qemu_del_vm_change_state_ha=
ndler);
> > +    g_clear_pointer(&qxl->update_irq, qemu_bh_delete);
> > +    g_clear_pointer(&qxl->update_area_bh, qemu_bh_delete);
> > +    g_clear_pointer(&qxl->ssd.cursor_bh, qemu_bh_delete);
> > +    g_clear_pointer(&qxl->guest_surfaces.cmds, g_free);
> > +}
> > +
> >   static void qxl_pci_class_init(ObjectClass *klass, const void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -2482,6 +2494,7 @@ static void qxl_pci_class_init(ObjectClass *klass=
, const void *data)
> >
> >       k->vendor_id =3D REDHAT_PCI_VENDOR_ID;
> >       k->device_id =3D QXL_DEVICE_ID_STABLE;
> > +    k->exit =3D qxl_exit;
> The resources are allocated during the realize() function of the qxl devi=
ce,
> so not sure, but using the PCI->exit() function might be the wrong spot?
> Could you put the clean-up into a unrealize() function instead, i.e. add
> this via "k->unrealize =3D ..." in qxl_primary_class_init() and
> qxl_secondary_class_init() ?
>
> Also, there are some more resources allocated in the realize() function, =
e.g. :
>
>      qemu_mutex_init(&qxl->track_lock);
>      qemu_mutex_init(&qxl->async_lock);
> ...
>      qxl->guest_surfaces.cmds =3D g_new0(QXLPHYSICAL, qxl->ssd.num_surfac=
es);
>
> Should these get deleted, too, to avoid leaking memory?
>
>   Thomas
>


