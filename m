Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C843FC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94Ui-0008Dt-Lr; Tue, 22 Sep 2026 13:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94Uf-0008D5-7G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94Ub-0007cj-T6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790098880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZd30P9CSdIgwU178RFVVjmbForznkG8/oHZMwvUt44=;
 b=BuHhZtyZotCUnxi2shm8pPYuiIBvZVMqaDYcvGOOcjq7dsfJHqXi/YDNeNZMm2tIFmJ7/n
 0oRb3KMVyjJdu05TuaLdVsAj+OQywJRU6nIFFT4CIZAZiJKS9aQMArw+Z0Ih05dHYunnCR
 8qtOLUTOoerxRcLzddY4+pn0kbjQC4o=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-dhBmD1yTOe2DezT1yLGHCA-1; Tue, 22 Sep 2026 13:41:19 -0400
X-MC-Unique: dhBmD1yTOe2DezT1yLGHCA-1
X-Mimecast-MFC-AGG-ID: dhBmD1yTOe2DezT1yLGHCA_1790098879
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66f81a0f5c9so55585d50.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790098879; cv=none;
 d=google.com; s=arc-20260327;
 b=Jj/aNZJ1kUDPDnR0yIkFmB5yQMdEGZUKwFHiq+fYWXzKE58A6cl780R6CixrQMtDp5
 4X2fvNXOHqPb5gzcAuWVB3chVisjFI84vDLouGWIzWt3hlouEYDSC7h9N10I+dCzCOsw
 eoH8ttRg1EW7TWCzABkxWp+LNnOlLe2XyRNM9lYIAexp8AdSdOLbMFrxX1AiU76abHJK
 4QuTZo9+QBkaHPhLjLvgu1CRynOYEqso2RuRmEJthdU0Jswm4IlU6Wzv7w4Yg3mVcA/m
 +ahtDl6U2AMvU/fCpcugJ58kdJhSudL7QJwHpDLV8SW4XcypCa3A9VP9xx7hX4NBVx3V
 rgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SZd30P9CSdIgwU178RFVVjmbForznkG8/oHZMwvUt44=;
 fh=4SpBrKxBueTKlh2nVNOI1f4PgGJNaXa+zdI/ORe/sas=;
 b=kR3ogJIGUu5djBr+GKdDvH3aftWz6FHhVlYGL5GZCy7nBDes6zV5Dtg7y03ymBE6On
 GweN3O220THoU7bnmeMw1I2KhI7vgG3zYISFu1SIpV9D80GwTrjEi0GeSmD2iYhIs5T8
 deUYlOWpmciTkPQvvbhf5SNoad3pTLqHSgfB4/ToAcU/Ftlr3r+KFJmx/14q6d3GjNn/
 G4PtG7CFeifmMQAQ//K8a2uyURMCDlL8L2+reSJYwOkWSF7iouJar7MvVTnvyJriI6eC
 Vdk6wRqs2nFkTYVr8pVLlFQIuUNTcWNJI9W/wCUuER/B8Vdl8+IqJjKaQ/tN2oGnM16G
 WB5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790098879; x=1790703679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SZd30P9CSdIgwU178RFVVjmbForznkG8/oHZMwvUt44=;
 b=fbx4EzBL9onxv5MMRlxk5aYDD0fEFXIQi1pLPb5EJXIn0wBPE/LJ2tOy9s8BiH1vUv
 /l7bjHWO6/6I+udrcmtfFN+ZvJfs9WAsfP+exkarQa2VrIZP007aRBVXdEnG2xUFBx5I
 9JOXrRMHMy7MUg2t3RGORzR3YDHWSiT9IAW/AXoM3acD4YiJL7afkGzJ5fCRi+3acRAq
 sKQyZw8/E24fuy4iLPpTJBcYyuh8cHxWMg7Oik3JrhoV25B+QIRcoL4g0cpgsFfY3Mc1
 z7lSyHWX/bSdS6ZPDk7BV265xyw78vP0PLddVCtzV985RAkPbOO8I8uOeZYT3TVq7YdF
 0cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098879; x=1790703679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SZd30P9CSdIgwU178RFVVjmbForznkG8/oHZMwvUt44=;
 b=zV+16jTrTvHpLUl/59AhOz5RNFthYqEkEbcdTPMFUSsAI1D5x9OA9UDlsVVR8zi/VG
 IWQGDSr0/M7oGwiG3L8bSR3E6BTs9ppwW4iawLfR28MgPuxSgRKZ4B8QV5bhl+CVJoab
 OOhiMXdtQEcwb7zVxcRNq85rp5MC+NoHhKu5ByDm8STFk6Ug7YROVxonnfdXmOdxVoMD
 uVRNW5bLTCKqQYFodobXK7x4DHEuvyLdQRMBlSRuVdTX/WpyNjZT02SQj61d8CMaqElj
 0ooDJd06UOKslIzsN43k1ckCBP6DJ1WxUXv6hvQQVxWHG0QA2t0700thNM2V5I05Wiwk
 rTtw==
X-Gm-Message-State: AFuF++m9JZ+1BpiN2q0YU5RS0K3o8NmzkdqMfwZdtIErOCq8iVUU5SWv
 /9whIKHlofD3f1JbOu/CEHAPCF/OsXbPqKMAVwpz6sHog2mqFSWwzJq9sJ2rAitJoP2HglcXxv5
 nEg3J5o0mUwXSLiKd9aAs7qBHObJYmhpi2xk+AwiylivwTjAt79l3D1hZ0P6b0MHJzO7xvVP2Ft
 RZaQtGvYdBvFZ6ZdgTxSXH7b9mDAYcFeo=
X-Gm-Gg: AYBFou1vX+Ml61Orht5wU6fjemGHCu4PV1WHFuUsu87qNvwn0+xqB7/h7QNRdceRrW9
 1viwaxTre1we8aMwZ8AWstoJo66ScKaULPDRm5TD3koIegc5XIOZEQyVkWwgp5ZPnSszXnwQTwy
 y9o3KOAwWxnGcmNETbmAXvZT4rAH5zgwACc+RhUrxFxH72HvQBfMHgo15fdad5cbsWKrgtzfF99
 73JWMJz1SU5V0IT
X-Received: by 2002:a53:d00a:0:b0:671:5c2e:82a8 with SMTP id
 956f58d0204a3-672d5860cc0mr131319d50.52.1790098878717; 
 Tue, 22 Sep 2026 10:41:18 -0700 (PDT)
X-Received: by 2002:a53:d00a:0:b0:671:5c2e:82a8 with SMTP id
 956f58d0204a3-672d5860cc0mr131299d50.52.1790098878271; Tue, 22 Sep 2026
 10:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-8-jsnow@redhat.com>
 <874ifh499p.fsf@pond.sub.org>
In-Reply-To: <874ifh499p.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 13:41:07 -0400
X-Gm-Features: AcwNN1XKAqaiUGp-T_ic9_Q3kmYUYVIeF3HfCLBqlslnjZgQaTuCakqvLJbI_-g
Message-ID: <CAFn=p-ZvFoEfcMj0R6TGWyoYDvbgwSAdJseei0oE41McmSB2Pg@mail.gmail.com>
Subject: Re: [PATCH 7/9] qapi: convert intro sections for
 docs/interop/firmware.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 22, 2026 at 11:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > All conversions in this patch do not create a new documentation
> > insertion point, except for one at the very end.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/interop/firmware.json | 76 ++++++++++++++++----------------------
> >  1 file changed, 31 insertions(+), 45 deletions(-)
> >
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index 421bee0e5ed..1efd32c6315 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
>
> [...]
>
> > @@ -250,12 +244,11 @@
> >
> >  ##
> >  # @FirmwareFlashFile:
> > -#
> > -# Defines common properties that are necessary for loading a firmware
> > -# file into a pflash chip.  The corresponding QEMU command line option
> > -# is "-drive file=3D@filename,format=3D@format".  Note however that th=
e
> > -# option-argument shown here is incomplete; it is completed under
> > -# @FirmwareMappingFlash.
> > +#     Defines common properties that are necessary for loading a
> > +#     firmware file into a pflash chip.  The corresponding QEMU
> > +#     command line option is "-drive file=3D@filename,format=3D@format=
".
> > +#     Note however that the option-argument shown here is incomplete;
> > +#     it is completed under @FirmwareMappingFlash.
> >  #
> >  # @filename: Specifies the filename on the host filesystem where the
> >  #     firmware file can be found.
>
> This smells like it could use a split, but it doesn't really matter;
> let's move on.
>
> [...]
>
> > @@ -467,9 +454,8 @@
> >
> >  ##
> >  # @Firmware:
> > -#
> > -# Describes a firmware (or a firmware use case) to management
> > -# software.
> > +#     Describes a firmware (or a firmware use case) to management
> > +#     software.
> >  #
> >  # It is possible for multiple @Firmware elements to match the search
> >  # criteria of management software.  Applications thus need rules to
>
> This is the split you mentioned in the commit message.  Correct?

Yep. Plan is to move this considerably long plaintext section below
the fold when the ordering series hits.


