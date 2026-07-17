Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA2EC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeEL-0002wY-Iz; Fri, 17 Jul 2026 04:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkeEJ-0002vr-Oc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:47:35 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkeEH-00040E-OZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:47:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so4122048a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784278052; cv=none;
 d=google.com; s=arc-20260327;
 b=fbK2kgbtoaMfOuOS9qpxoxMqDicw3hGJ2ucupM6ltyed2ZaTFXX1MEBd9AEHRkRR/A
 tFAayOjjcw8XKCnVxSuQFMf+XJY4qpy1rCLpoB4H7gFA3l3odm1V7KgkBX51vleGBcAp
 /QPi8XTJgcJSlDWBnfhZg5So/ZaqHoTU/Wma9IPfG3xJbgkSt8IOWsGN49NTAX9+oR6P
 4BEdN7xwCTPD5jQWnZyLe7gbcizmEx1xDeS3E2if3r21n0/BkPB8myq+U8X0B8/EOIel
 f1IEGeVi/5qmQ7HqjJfi5YmjEwpOtCJExXprunkahSaWnTegI4Ln15a62SjhGzvpa1rj
 gHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VBVQdNb+mUOrlkcSdaPvF8dAh8794ap8PN6AZJQyEaU=;
 fh=xBmFfvi1CIxcv4xit7QIpsd2+YAL5haLXAfECwFCXKw=;
 b=Q1GNDcAZ07NUAF3dy25ZU1bWbeh9/ReQJy7xMYOBO09P+diIhTp//tn2af0lfHfb8M
 LUnQ1DS3URqcdkUISM+T9AWlneAbYdsxIk4dNyTuZnW8Q82pS2V71s0gPpDgI9ajiSz3
 +Dnm7A593QNEvEhb7Zfe+/KLgwrIpzy1EBpIexC1/2d9WQuzT4rQJp4rptuQ03RZ8zSB
 OyYufJ1zvaKanueISdF5XloO6zdVg6fu9PQrNvoTC9M6yXQ7ytJy3lHHTeqBtBgBTJWM
 NfdLp5YXLQN3aayYMdN8gyGVsMPmA1kW+oP2l4Lityz+//5ibcEpJutOvVkCIUuwHh/a
 Aqpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784278052; x=1784882852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VBVQdNb+mUOrlkcSdaPvF8dAh8794ap8PN6AZJQyEaU=;
 b=DAYHgW7erqBVMBUWmGfa6+gokE/h7fQqwtGdzXzp19gnyMuA7ExbsZB6cpgtIzepxW
 ReYTMaxUgIrwTR0bzaaomT6K8YnPnkH57WzyzEBqt/NeZJ/oHAz0vEQ1uQAHuKCNx11l
 ZziTyu3+dFK6JyAqIyva/AwZKpkjHHcVmHqIwUoLXrUSiz3Yf9hR85EpLr5yMPBA7jGv
 Oy0T8QkMp77sBsDc/8KImxRpw0uBCytjxquXYdOXDzqA2rwzB7oHpCx+T8KVbXCuNpog
 j3Z/m3VSUFPf1VXkSKZVyI3k68YbyDYDR4m1pmebSbWGA6k/mIAbiiprJWQaZWDP0Eio
 xuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784278052; x=1784882852;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VBVQdNb+mUOrlkcSdaPvF8dAh8794ap8PN6AZJQyEaU=;
 b=ffTqCB2KJf/A55TiYtsGrXLTrR+zs9mB0QSZXg/1prx7GT8MpUrrBlLbunhTMdIqAo
 nORNZ4SKY83FhcqKjDHrJ+S85a1iVPK2OGGhCHDg05PSen+dWp60SYdlhv+Z96IYXx+T
 mgQ+EFjpsCwthIQA8YKWwPgcQ91MOMXSDs8w8e9mARjneBf8g+qjuC/2zR3+qlf8DLoU
 zsdFY+k/pM+il409WohPWUEpXU3HO9icA2t1lLJSz6WNIX0j5dy6FsUtoHw+zro2u34O
 mlKyqkKyD1Sq/DhcyFLZC9Kmw6RJt9TYfiCWI0pdpF6gdWQefdTPRjJzQMAodz4mn8hV
 IDLg==
X-Gm-Message-State: AOJu0YyoFYJCPxAHE1Qd1JiY1fdMTdGSdC4L90+CGRBZzz94RgFOlsog
 qbpdrVkfRoR/aOCvy/BKOLFeV5ReZEIyOhkCSmYZdLcWSjWWYGSGZ9wPQakhwnngI1+ubWM/Mc3
 asPut+86bzYXSjaKa4Cij/kF+jXDfyyo=
X-Gm-Gg: AfdE7cmzx+wvF9nf3LLglq+K6cAlDU+OAf5H5VGJG6HI3eR5H3Gu2Md90PiZjZbzfu1
 JBDB1B0XT/ohDx3e3IDG0OawNBwkydDbaFbd+i97jtugNH88d8YY8HSU4c6KUv+a+UCuXtcb6Ly
 Q0m19tkG9cMGiMROqawxFjvuG65EmNIddZbCest2+ijMcyX9mncE9DxwLcIzJMwYfMtW0nT0SuP
 +xQ0eGvi70NH3hysPnqg3+8+GWs61NKFr0WHIKhmC86v7SUlE8O2T9ZoBSCfDG1T+ltY9YYWz/2
 CDAY+VJeqFpUqO8Vgg==
X-Received: by 2002:a05:6a20:e282:b0:3c3:91f5:82ba with SMTP id
 adf61e73a8af0-3c3ad975d54mr1919804637.57.1784278052089; Fri, 17 Jul 2026
 01:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260717045253.4004241-1-jianghaotian.sunday@gmail.com>
In-Reply-To: <20260717045253.4004241-1-jianghaotian.sunday@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 12:47:19 +0400
X-Gm-Features: AUfX_mxkkoB9Aq_YlLYEH12WK1XVdMqBY1O89k82YbqJqJT-DYKZvKD2-8suaJk
Message-ID: <CAJ+F1CLUcxOzbFo5Pf_jNuxcdvjoczMpoFyzjYRG9=S=F-JGfQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: unregister vm_change_state handler and
 BHs on device exit (CVE-2026-63322)
To: jianghaotian.sunday@gmail.com
Cc: qemu-devel@nongnu.org, philmd@mailo.com, vsementsov@yandex-team.ru, 
 thuth@redhat.com, farosas@suse.de, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x530.google.com
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

On Fri, Jul 17, 2026 at 8:54=E2=80=AFAM <jianghaotian.sunday@gmail.com> wro=
te:
>
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
>
> qxl_realize_common() registers a vm_change_state handler via
> qemu_add_vm_change_state_handler() and creates three bottom halves
> (update_irq, update_area_bh, cursor_bh), but none are ever cleaned up.
> The return value of qemu_add_vm_change_state_handler() is discarded, so
> the handler is never removed from the global list, and there is no
> PCIDeviceClass.exit callback to delete the BHs.
>
> When a secondary QXL device (hotpluggable by default) is hot-unplugged
> via device_del, the PCIQXLDevice memory is freed but the vm_state
> handler and BH entries remain with dangling opaque pointers. On the
> next VM state change (stop/cont/migrate) or BH dispatch, the callback
> dereferences freed memory, causing a use-after-free.
>
> Fix this by storing the VMChangeStateEntry returned by
> qemu_add_vm_change_state_handler() and adding a qxl_exit() callback
> that deletes the vm_state handler, all three BHs, and the
> guest_surfaces.cmds allocation before the device memory is freed.
>
> Fixes: a19cbfb34642 ("spice: add qxl device")
> Fixes: CVE-2026-63322
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotia=
n.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3607
> ---
>  hw/display/qxl.c | 29 ++++++++++++++++++++++++++++-
>  hw/display/qxl.h |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 74258afa58..23608f988a 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2203,7 +2203,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, E=
rror **errp)
>          error_report_err(err);
>      }
>
> -    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
> +    qxl->vmstate_handler =3D
> +        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qx=
l);
>
>      qxl->update_irq =3D qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
>                                            &DEVICE(qxl)->mem_reentrancy_g=
uard);
> @@ -2475,6 +2476,31 @@ static const Property qxl_properties[] =3D {
>          DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
>  };
>
> +static void qxl_exit(PCIDevice *dev)
> +{
> +    PCIQXLDevice *qxl =3D PCI_QXL(dev);
> +
> +    if (qxl->vmstate_handler) {
> +        qemu_del_vm_change_state_handler(qxl->vmstate_handler);
> +        qxl->vmstate_handler =3D NULL;
> +    }
> +    if (qxl->update_irq) {
> +        qemu_bh_delete(qxl->update_irq);
> +        qxl->update_irq =3D NULL;
> +    }
> +    if (qxl->update_area_bh) {
> +        qemu_bh_delete(qxl->update_area_bh);
> +        qxl->update_area_bh =3D NULL;
> +    }
> +    if (qxl->ssd.cursor_bh) {
> +        qemu_bh_delete(qxl->ssd.cursor_bh);
> +        qxl->ssd.cursor_bh =3D NULL;
> +    }


Please use g_clear_pointer(&bh, qemu_bh_delete).

> +
> +    g_free(qxl->guest_surfaces.cmds);
> +    qxl->guest_surfaces.cmds =3D NULL;

And g_clear_pointer(&..cmds, g_free)

Hard to say without careful examination if other fields should be
unref/free here...

> +}
> +
>  static void qxl_pci_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -2482,6 +2508,7 @@ static void qxl_pci_class_init(ObjectClass *klass, =
const void *data)
>
>      k->vendor_id =3D REDHAT_PCI_VENDOR_ID;
>      k->device_id =3D QXL_DEVICE_ID_STABLE;
> +    k->exit =3D qxl_exit;
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      device_class_set_legacy_reset(dc, qxl_reset_handler);
>      dc->vmsd =3D &qxl_vmstate;
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index ad8a912878..48d664f777 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -83,6 +83,7 @@ struct PCIQXLDevice {
>
>      /* thread signaling */
>      QEMUBH             *update_irq;
> +    VMChangeStateEntry *vmstate_handler;
>
>      /* ram pci bar */
>      QXLRam             *ram;
> --
> 2.34.1
>
>

