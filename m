Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80721FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABW4-0007k2-Dk; Tue, 07 Apr 2026 14:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTk-0003Gt-47
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA4Al-0008Fj-PG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 07:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775559642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuPptOE91voemWPh+8fu0Uj5eLtTbrt9H3+Iyzfqp3U=;
 b=aFtuflKQOU4si09KMMFlFP7dV3835aJ4q8kbR1ZHYTDopW/s9XjU9f9yscrWm2B4jeu2qh
 cQbeEN836jiTaQIrB6ngSlc+C5jZZ3LZa7a6kj2GT/KMR6as8HcLE8wMtXoTs4aX1J5Bdt
 kgomvbhvkSzfQ/yehODl/dKYl7GtC2o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-XHiVAyqDMVyiKaS0RJMb_A-1; Tue, 07 Apr 2026 07:00:41 -0400
X-MC-Unique: XHiVAyqDMVyiKaS0RJMb_A-1
X-Mimecast-MFC-AGG-ID: XHiVAyqDMVyiKaS0RJMb_A_1775559640
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c741c4cebf3so3160350a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 04:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775559640; cv=none;
 d=google.com; s=arc-20240605;
 b=jesj1rrtCwTNhJ0xF4iM8tpzJMjGEm0OPH0hV0iLbwPtJpKsi5R5xm/xNrnNOEHAi+
 0D2wbwesYYM2gHkLa4lf3qCRxEsIYbqjRi+Iy1MigL6QhGDYXlihh9NpmsqlUYaSf76V
 Xy0oaf6hfgsjlc7MewwidbG+HroBb3IL6JPofQmNcfNlab2++HPOaATQRNPF7idOMWyn
 OTYOFfSLh1plZ/qQP+ZyhC5qVF6IABBuSKjcVaE7Adg1svh3xrosjkPsenFS9ufa77OE
 qnPGJdwyjkDutM76ah43XGEUO2YysA1TqjayZs9HUO0OM+wQDk0KPQfL2q8WP1nMxApq
 xymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HuPptOE91voemWPh+8fu0Uj5eLtTbrt9H3+Iyzfqp3U=;
 fh=7VmVtnx17niWKB7xvFxSuDPzFCTtk4tzwtJlwbYBWrw=;
 b=XSAS7bLgXg5HeBRK+TG2IyZjJddohUnRkmD+iTO1YL+NUn21DqkU+0K/C7FK8xE4mt
 MP/5isxoasjIVxb0e/yOhLsfmQgttl/g0dHqAfJr0wRr0qe+CznP4nxbJF81mYCJDScJ
 O7ow1+wWn15cqdekwdpoYQbP/Gap3qcBJKfbDu9K62F1FZJn7QRUlHDp+gme9SDdcxuB
 GlfhJ7QVbU47SsaG4Gy6TI+S/4xVRA1I/qXGkrXt8eFtONRvuHBkDRT9uxxmKVvZ2Yrq
 ZftTcrCn+5WEX0HaH1pIIRDZIRIbqFBtxisHwBOXmCkdHMvVw9uz2BTzYqA3NsYNqMHD
 C77w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775559640; x=1776164440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuPptOE91voemWPh+8fu0Uj5eLtTbrt9H3+Iyzfqp3U=;
 b=bcuRLCU+0s0KSWZqcnUpNYLqIg1NbTZs3Mhjo45QKH5qqkhS7s9vlO49vJQ7FKEbOT
 9/p3AeVSz6IlT+l5YzjsMis+xUz0BVmlVdIOIfkWZGi4ihpO9/v6gDxFZymdmJ5EcxA8
 5aPaeEkCAQCdFGDxXE5iZgm+hEZUX/QksSdco6THZQdPeVhpo1kUcwk1tnhXU2OK7zdI
 bL2Y/oElZpWTf84zanKBo0z2jD2CTs1nu17H8d6PneBX6fA1yGLQStwFnMW980n4903E
 SYZ2PuF1u2rIVI3P17asae27Um+mM3em0L8x1MnzoeUFBEygS1bxJFfxLEIPmpRfM9RB
 wdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559640; x=1776164440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HuPptOE91voemWPh+8fu0Uj5eLtTbrt9H3+Iyzfqp3U=;
 b=DWU5NjeCQUA9jGe+RVadSwe1GbXDo8CAv5D0j28KBXpXBYSJ8CDByKSvEEyZWit5h3
 AAnr0HgPk1eZND2d41EnStRpFdUNZMEidGmnz7qPEWdyRnxwd+qe8AD0dXmMXtBpyrju
 QKm++jHBo1BNRrORnRfiDrtCgpOJEKMZC7NwpT+guag5+CqO14vClCs2vg5pGQaFzmok
 VyJZz2O4ixxGr6WbwQN3/5L08Xc1VPLn6QrTobmsO0zZRvXQ6eQn86myeNRgwY4SUNVm
 +8F78QKCUjcRJc3UzaN2XJa69lOGo5ZDZkmfUWs0otY07BTEJs4sBMdlGUbyxnPWe6U1
 1Sog==
X-Gm-Message-State: AOJu0Yx5ZH3uatYiHyHXbHn1aylMOH194JUbh/co5an2fbfxafEJs34G
 Itl19jkezpLwdYT/nbdb9g9I1aiPLSphLtCsP3V8g+2bf2rEsqkO9KPIMYVBttHiQzSwlbB7UkA
 /HGiKHqMCXoTE9yYeeoicJA5dXim6XCxR/Vmxt6D8WoSX0gwq4rId3MfwjoBLNNf4FA+sUkM6iq
 J9uy0PIAi6j43UIyymSqAVU6O8vsiIb3k=
X-Gm-Gg: AeBDieu7cV/Hd5FiEX1Q1h7EeYHDoq4L7ykYh+6ej6r6jtrcfZVBzfjW+VIbA3hsWUa
 jkbaSY1L23nIilwC4KH9SzByvBDkpc6Nz0SgqDI/oOAJcDUEIPMsLZ3G7wi9z6eqfZSbLYX8aL4
 FJW82RaEkbiyU4ta7yMZpztpIufKcIVCn2vc1ulev2DTowVaRscz3qIlacdDOD67HbseM+iDGUk
 yfwiWHOTL/1GRuGp7GkqqZ9ldHyRFAMn6CXu90R32USPVftsv2SpjayEsa+pyvYAzj/ZfOF+sBF
 rpE6zJDbaP8g7gYtcbsf8HU=
X-Received: by 2002:a05:6a20:2586:b0:39f:29ab:b364 with SMTP id
 adf61e73a8af0-39f2ee108c8mr16949708637.22.1775559639397; 
 Tue, 07 Apr 2026 04:00:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:2586:b0:39f:29ab:b364 with SMTP id
 adf61e73a8af0-39f2ee108c8mr16949652637.22.1775559638904; Tue, 07 Apr 2026
 04:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-7-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-7-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 15:00:27 +0400
X-Gm-Features: AQROBzANbt-uegiHwzUNOGSQsbqiNqPMfs0eDbBf_VSu8HKSXcArX5Ykog9ysQU
Message-ID: <CAMxuvaw1Zaui2mSw2o6M6OzC7vnwN8CW1hgnZEtz1BiZmsT1kg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> - Add subsection in VMState for TPM CRB with the newly introduced
>   command and response buffers, along with a needed callback, so that
>   newer QEMU only sends the buffers if it is necessary.
> - Add hw_compat blocker because the feature is only supported for
>   machine type 11.1 and higher.
> - If the VM has no pending chunked TPM commands in the internal buffers
>   during a VM migration, or if the machine type does not support newly
>   introduced buffers, then the needed callback will return false, as it
>   checks the hw_compat blocker and thus the subsection will not be sent
>   to the destination host.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  hw/core/machine.c |  4 +++-
>  hw/tpm/tpm_crb.c  | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1abc8ae737..fb290c6c53 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,7 +38,9 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
>
> -GlobalProperty hw_compat_11_0[] =3D {};
> +GlobalProperty hw_compat_11_0[] =3D {
> +    { "tpm-crb", "migrate-buffers", "off"},

If this is not intended to be user visible, we should use x- prefix

The problem is that the previous code changes expose CapChunk to the
guest unconditionally.

If running with <=3D11.0 we should not enable chunk transfer by default
- or we need to prevent/block migration... otherwise we may lose
VM/device state, expose a differente device etc.

What about having a "cap-chunk" property? Enable it by default with >=3D11.=
1.

If enabled when <=3D11.0, then also disable migration.

> +};
>  const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);
>
>  GlobalProperty hw_compat_10_2[] =3D {
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index b9f295db7a..81471dd9f8 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -49,6 +49,8 @@ struct CRBState {
>
>      bool ppi_enabled;
>      TPMPPI ppi;
> +
> +    bool migrate_buffers;
>  };
>  typedef struct CRBState CRBState;
>
> @@ -345,18 +347,47 @@ static int tpm_crb_pre_save(void *opaque)
>      return 0;
>  }
>
> +static bool tpm_crb_chunk_needed(void *opaque)
> +{
> +    CRBState *s =3D opaque;
> +
> +    if (!s->migrate_buffers) {
> +        return false;
> +    }
> +
> +    return ((s->command_buffer && s->command_buffer->len > 0) ||
> +            (s->response_buffer && s->response_buffer->len > 0));
> +}
> +
> +static const VMStateDescription vmstate_tpm_crb_chunk =3D {
> +    .name =3D "tpm-crb/chunk",
> +    .version_id =3D 0,
> +    .needed =3D tpm_crb_chunk_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
> +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
> +        VMSTATE_UINT32(response_offset, CRBState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_tpm_crb =3D {
>      .name =3D "tpm-crb",
>      .pre_save =3D tpm_crb_pre_save,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
>          VMSTATE_END_OF_LIST(),
> +    },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_tpm_crb_chunk,
> +        NULL,
>      }
>  };
>
>  static const Property tpm_crb_properties[] =3D {
>      DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>      DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
> +    DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true)=
,
>  };
>
>  static void tpm_crb_reset(void *dev)
> --
> 2.53.0
>


