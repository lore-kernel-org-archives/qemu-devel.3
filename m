Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DBCC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCXO-0008Qx-9S; Tue, 21 Jul 2026 11:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmCXN-0008Qf-27
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:37:41 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmCXL-0000uy-6T
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:37:40 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso7714560a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784648257; cv=none;
 d=google.com; s=arc-20260327;
 b=DH3+CpEdjUll0IgSG2n2bF9a/TA7eqpjZ1EzhfZRjK99BerYl9m/8X6BwtViz1mPwS
 EhvGkF6Cv8FxXi/LdlO6dI+Q/sRUlwAEO5Irot8HSoTtFZ0QT1MQwJ94hpKkAMOWIn5I
 +xlfdU9B7CQ5lcLMueYmYYLGpQgUUHUExRsDK7wK4EL0A4D4m/VHz9jEghVK/b1zMi7Z
 0eqqCYz33W+rnnZXBzlPMydhrAickT2ISTa1iz44Y6CgndcoKTIj05wVZtwNJBQNWcvB
 LcUgv4d/XjxAF/3D/85M2iALk0mDewI+IOEBLJrBTC2WIlZWJEJySHwiB+NuqmyJ+wKc
 0VjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D5ONJfFqw/mmjsLn1JHmHskNf759puCRFMYF+y5ZD74=;
 fh=7tvvhpIZ2jXYGEgNiItaAHssD13lZ+FvwOgScSDtkcE=;
 b=R1NWXQTX26QJmXDyvlpl03lejCUlcEjmdR9R51hi3eQWYNdC32bO7JbXkHWLQr4oKe
 YRRH/UNdweUVqd+DvZ0r8nYyim0LIEuFth1r8res83nplVFJcBjWu5rM5lqmacfZ7V9u
 urKysFW1pmJw6vnBoGVgrkAqTFnJta5Yrs3bVb9WLQdqGacv2jYFEcDhRTF6AFvd6p46
 wraLi0ZdczHiobtgx3EZBfqj8YDhk0fFbKiuECeX/AI5rKXswjWFH/PkCsJ1amGh9OpH
 Zv806y72d4R9Byotj8LGZN4098FZH2soL/yOQ/WvTg22XW2EMUdERJIBz7GIvl3ylUJS
 uaRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784648257; x=1785253057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D5ONJfFqw/mmjsLn1JHmHskNf759puCRFMYF+y5ZD74=;
 b=pl1tWbe8ks6CZQkqQUXRhg6nFD4xtMXiB+UiUk//TSZhAOhWoPqvOpeIoDDP+WeTkf
 efVB05MymdYp3Xy2cbOsz79zGT7cP+6j7tVJf2U1IDo9gGOi+fwG1ayUu5swEuvHe8TG
 IN3qzcF652z6M3hEEtGVJlEDsb6bE0x/+rwG6JCYbScy1VxEBmdl1p72sU47CU2PzpcJ
 EItI2dJE/NnJj7NYH2W69s6ZHpckVyp4jmL0u36q8VztkVK5jyeeE5el769gjDDosFRI
 nkPdKVWkiFWDogQvdFPq6LqpcqKhFbRnmB7R9f9Cd0cs4e90pFbIBmWSJbIh6kY48oXJ
 fPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784648257; x=1785253057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D5ONJfFqw/mmjsLn1JHmHskNf759puCRFMYF+y5ZD74=;
 b=PYeX1O2O455Xg89164eTCkx5gh71XWiV9Xlvy/hfxQkwcEo5Nn/yvqfxLtjVBWwudT
 VqGCx2VFnr4vzsRpyMreKGIP3mfrFOnfErDtSxrybiSQpoA6ppj08n1++f8ZUqrn3GHl
 pQ6zVXVXgMwCOzp5cGjwPGjagSfyJpe1Ry/hdwpL/Z7rw9ekVsZku1OGLFuYDz5e8TdQ
 /kukwRA9Y34IvXEzxNJGCDgJTUkXabBX375fiUwBqoQqw7frbDxPf5YOGii95w+ET8ch
 DTNd9OXzPjISUuTt/255K4jomJeeBTX6dE+s6Fewpxo/99V2e/En4i2cfHhmDsD0J48T
 UHgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNxwkLZRjvbY/+I6wWStEfV2zajDHoKbbjKBpdqq43FMjoBjlnFEho5dVc4LZm6XtkCup2jAWRUvQV@nongnu.org
X-Gm-Message-State: AOJu0YxWV3tdu4nD9ILnVubLbTBxw3qKq04BVD7tJG68sS0MxRwksa2m
 bEHCQANP2P+KwXmHrP44Q20neSGnnSs/VCilIsHdvbBBU+2LIT0v5nt3lqnhcscV3ActNx/mGL6
 HTde4ZWgxnwZm7TDND/TZiGhPU7A7Ftg=
X-Gm-Gg: AfdE7ck0EaZQJwD0ERuTK/nZ3otsqBVnk8w/cDA8JJy4edS+DqdO3zOY0ANfvaDwrtI
 xO4jSVHv14uo4HMTtOIe0l5GUAocswZmPZVbqnT8PAyHMiLZso22R5zU7J0FIdZTxPTmdcVNS6H
 VehbvW2X43BtIU7JiVxOEOOoSeps4iLr+xf4EY/T2GcwdEtucKpwECF2W+TOieIelD2ZHVNV0WU
 FxQYwOVoTfODUD2hAp7PfYHo+XJpnvtdGcwKiUjUUK5k5NQr9/MOBt/cHZL+wR1hCTfuyRPB0Vs
 5VG2c9z5GGaz+IQt3g==
X-Received: by 2002:a05:6a20:a10a:b0:3c3:7f50:fc3a with SMTP id
 adf61e73a8af0-3c3ad7962e8mr20441127637.33.1784648257101; Tue, 21 Jul 2026
 08:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
 <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
In-Reply-To: <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Jul 2026 19:37:24 +0400
X-Gm-Features: AUfX_myMN8MmgtaKacJ6tNKwBoVpwR4LvLYrE4p2yKLfQDvFCvdv7m-7jvsFoyE
Message-ID: <CAJ+F1CJMSxZmXWdffp-RaOyx8sBx5v7fBMkrPTGMa+hpNS+Yhg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: unregister vm_change_state handler and
 BHs on device exit (CVE-2026-63322)
To: Thomas Huth <thuth@redhat.com>
Cc: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org, philmd@mailo.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, qemu-stable@nongnu.org, 
 Haotian Jiang <sundayjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Jul 20, 2026 at 10:16=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
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

I am afraid trying to fix the leaks is going into a rabbit hole (at
least I did). Probably it is best to queue this fix and handle the
leaks post 11.1 imho

@jianghaotian.sunday@gmail.com Are you working on a new version?

