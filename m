Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A448C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuT8-0008Vh-LF; Wed, 02 Jul 2025 06:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uWuT6-0008Sy-UF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:13:32 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uWuT4-0003UP-AO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:13:32 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so50760011cf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751451209; x=1752056009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY1OBI651DFTCEr6TUHXePFroeUhAoGonXd8Ao0/cN4=;
 b=MNKoS4KqZzQqrJVWwFQLaJu1LRVAx5mD+s+izmYJ4qRgBQXVQFFQK0OeyXf2TxbE9c
 47BxUyLjNanoBkCzlL+V5ZUDr2d1kpq+DctzGCUr4sywp5Urt8C+uZjvRmtdb40SU7er
 r1t6fI9s7ryr5SxwhFGIcLXQNWIq1U6CO2/nYXkKS8atWfsEYFmDol5WDssU+CY5FpAW
 QzTt0I7o90erBR/Rm+fcYoKGxLZBmcwiLoqTXf4tQrkQPKcs0TzOuy8xkPKt2GB0zbt2
 Lv1Jzbolwy7d+kPBen8JwyQg7RbIsW8zUUGi6BTYR9tWHBLG8fw2XsWX8mXgHFf2pZ/S
 5HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751451209; x=1752056009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY1OBI651DFTCEr6TUHXePFroeUhAoGonXd8Ao0/cN4=;
 b=cU7R2ubExVwRjOHZA3j3eRe/JWAtPR3QXxFoEXw2sb5A2QMan2uY7qeGgu5Nt/dpJW
 ncb5yQdCsnliv1lhschkpGLesEMYGSBmNtaSZZVwA0Hl7/ZMkE9DZEEWP8+dAwwzQfW6
 q7qAv9lnU45pB6rhI7UikPA0y81bwNu6mdf5bOmAqVVmYwnuMRAZ228fmWCZkHxKPPdi
 muGPx9XtHPy/RvMehVjFk+9NBUY7ei3k7gCNtBjcyCVhTIc/CsdrjNXKrhe6N5XCPoHy
 qZyK8a3m63FHb/UEMMAUVs7n8mCH8GXL3jcVh6+YnqFIZ3oElbyUouBW3iDuhF1zJ5Is
 patg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGBT0Rx3wWhcCf0YfPx2nKOICjxSuEpTPeX0OXlDksTi94VVA/0XIAj7szJwS1bbxghxt5BtoaDJmO@nongnu.org
X-Gm-Message-State: AOJu0YwXviymIb9WgABVvOfogFc+3l0TtwL9R1dgGJH1xCeVqxQOMki3
 wSjkt/NX58OBnM3z72PA9Z5ckMYxTU2ISyaDAmbChFr+NE+SsN2dGKOENCUIYxJ11FoXio46AyX
 bBWRw9Co8CvBqR8pz15jxl/5fkMOMy0LV1FVj
X-Gm-Gg: ASbGncsoR15RyNQxVs0tSbdrkotv1x5NmPR64KfSL4Ai1IQBHlDM5Pbin4ZK3XG+BNx
 Q9J4R9ZxOJUHlvIL/Velil2oVnWMDMtFhaqm2QpGZa+BDVfFCdx6cW8k4p0GUAnGD8xr2oh0Liv
 vZtNjE2EuPhSBTSMUmN61lo8QeofYrVXmqt6QGowFQdCgaAhQn/e1X+TLQR8Ynk9oUSMYnyB3EW
 Qz6
X-Google-Smtp-Source: AGHT+IG/xl80awv0nz+yE952H2FiavuRwh6BkWQW29P9nHTPCuA9WklP26AZPVeCS9Em81n3ujDnWuxRk42Y83iPKek=
X-Received: by 2002:a05:622a:1aa2:b0:4a6:f0da:82ab with SMTP id
 d75a77b69052e-4a9769f03c6mr41148151cf.52.1751451208319; Wed, 02 Jul 2025
 03:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250701205652.3536098-1-ankeesler@google.com>
 <20250701205652.3536098-2-ankeesler@google.com>
In-Reply-To: <20250701205652.3536098-2-ankeesler@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Jul 2025 14:13:17 +0400
X-Gm-Features: Ac12FXygeBGLq_3EFHCs0VZdfbi2yGBJSj4qc2fFTWaLel6-qulEPbjFX0joe9E
Message-ID: <CAJ+F1CK_x32tL8g1xPd2SRzetXHy3XNPvEOWNm6_opT8AyDjJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] hw/display: Allow injection of virtio-gpu EDID name
To: Andrew Keesler <ankeesler@google.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Wed, Jul 2, 2025 at 12:57=E2=80=AFAM Andrew Keesler <ankeesler@google.co=
m> wrote:
>
> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> Identification Data) is propagated by QEMU such that a virtual display
> presents legitimate metadata (e.g., name, serial number, preferred
> resolutions, etc.) to its connected guest.
>
> This change adds the ability to specify the EDID name for a particular
> virtio-vga display. Previously, every virtual display would have the same
> name: "QEMU Monitor". Now, we can inject names of displays in order to te=
st
> guest behavior that is specific to display names. We provide the ability =
to
> inject the display name from the frontend since this is guest visible
> data. Furthermore, this makes it clear where N potential display outputs
> would get their name from (which will be added in a future change).
>
> Note that we have elected to use a struct here for output data for
> extensibility - we intend to add per-output fields like resolution in a
> future change.
>
> It should be noted that EDID names longer than 12 bytes will be truncated
> per spec (I think?).
>
> Testing: verified that when I specified 2 outputs for a virtio-gpu with
> edid_name set, the names matched those that I configured with my vnc
> display.
>
>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>               },
>               {
>                  "name":"BBB",
>               },
>             ]}'

This is not a valid syntax, you have to remove trailing ','.

>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> ---
>  hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
>  hw/display/virtio-gpu-base.c        | 26 +++++++++++++++++
>  include/hw/display/edid.h           |  2 ++
>  include/hw/qdev-properties-system.h |  5 ++++
>  include/hw/virtio/virtio-gpu.h      |  3 ++
>  qapi/virtio.json                    | 18 ++++++++++--
>  6 files changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index 24e145d870..1f810b7ddf 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -1299,3 +1299,47 @@ const PropertyInfo qdev_prop_vmapple_virtio_blk_va=
riant =3D {
>      .set   =3D qdev_propinfo_set_enum,
>      .set_default_value =3D qdev_propinfo_set_default_value_enum,
>  };
> +
> +/* --- VirtIOGPUOutputList --- */
> +
> +static void get_virtio_gpu_output_list(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    VirtIOGPUOutputList **prop_ptr =3D
> +        object_field_prop_ptr(obj, opaque);
> +
> +    visit_type_VirtIOGPUOutputList(v, name, prop_ptr, errp);
> +}
> +
> +static void set_virtio_gpu_output_list(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    VirtIOGPUOutputList **prop_ptr =3D
> +        object_field_prop_ptr(obj, opaque);
> +    VirtIOGPUOutputList *list;
> +
> +    if (!visit_type_VirtIOGPUOutputList(v, name, &list, errp)) {
> +        return;
> +    }
> +
> +    qapi_free_VirtIOGPUOutputList(*prop_ptr);
> +    *prop_ptr =3D list;
> +}
> +
> +static void release_virtio_gpu_output_list(Object *obj,
> +    const char *name, void *opaque)
> +{
> +    VirtIOGPUOutputList **prop_ptr =3D
> +        object_field_prop_ptr(obj, opaque);
> +
> +    qapi_free_VirtIOGPUOutputList(*prop_ptr);
> +    *prop_ptr =3D NULL;
> +}
> +
> +const PropertyInfo qdev_prop_virtio_gpu_output_list =3D {
> +    .type =3D "VirtIOGPUOutputList",
> +    .description =3D "VirtIO GPU output list [{\"name\":\"<name>\"},...]=
",
> +    .get =3D get_virtio_gpu_output_list,
> +    .set =3D set_virtio_gpu_output_list,
> +    .release =3D release_virtio_gpu_output_list,
> +};
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 9eb806b71f..a06b6775d4 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -19,6 +19,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/display/edid.h"
>  #include "trace.h"
> +#include "qapi/qapi-types-virtio.h"
>
>  void
>  virtio_gpu_base_reset(VirtIOGPUBase *g)
> @@ -56,6 +57,8 @@ void
>  virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
>                                struct virtio_gpu_resp_edid *edid)
>  {
> +    size_t output_idx;
> +    VirtIOGPUOutputList *node;
>      qemu_edid_info info =3D {
>          .width_mm =3D g->req_state[scanout].width_mm,
>          .height_mm =3D g->req_state[scanout].height_mm,
> @@ -64,6 +67,13 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int sc=
anout,
>          .refresh_rate =3D g->req_state[scanout].refresh_rate,
>      };
>
> +    for (output_idx =3D 0, node =3D g->conf.outputs;
> +         output_idx <=3D scanout && node; output_idx++, node =3D node->n=
ext) {
> +        if (output_idx =3D=3D scanout && node->value && node->value->nam=
e) {
> +            info.name =3D node->value->name;

break?

> +        }
> +    }
> +
>      edid->size =3D cpu_to_le32(sizeof(edid->edid));
>      qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
>  }
> @@ -172,6 +182,8 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>                                 VirtIOHandleOutput cursor_cb,
>                                 Error **errp)
>  {
> +    size_t output_idx;
> +    VirtIOGPUOutputList *node;
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(qdev);
>      VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(qdev);
>      int i;
> @@ -181,6 +193,20 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>          return false;
>      }
>
> +    for (output_idx =3D 0, node =3D g->conf.outputs;
> +         node; output_idx++, node =3D node->next) {
> +        if (output_idx =3D=3D g->conf.max_outputs) {
> +            error_setg(errp, "invalid outputs > %d", g->conf.max_outputs=
);
> +            return false;
> +        }
> +        if (node->value && node->value->name &&
> +            strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
> +            error_setg(errp, "invalid output name '%s' > %d",
> +                       node->value->name, EDID_NAME_MAX_LENGTH);
> +            return false;
> +        }
> +    }
> +
>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          error_setg(&g->migration_blocker, "virgl is not yet migratable")=
;
>          if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
> diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
> index 520f8ec202..91c0a428af 100644
> --- a/include/hw/display/edid.h
> +++ b/include/hw/display/edid.h
> @@ -1,6 +1,8 @@
>  #ifndef EDID_H
>  #define EDID_H
>
> +#define EDID_NAME_MAX_LENGTH 12
> +
>  typedef struct qemu_edid_info {
>      const char *vendor; /* http://www.uefi.org/pnp_id_list */
>      const char *name;
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-proper=
ties-system.h
> index b921392c52..9601a11a09 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -32,6 +32,7 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
>  extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
>  extern const PropertyInfo qdev_prop_endian_mode;
>  extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
> +extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
>
>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
> @@ -110,4 +111,8 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_bl=
k_variant;
>                           qdev_prop_vmapple_virtio_blk_variant, \
>                           VMAppleVirtioBlkVariant)
>
> +#define DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST(_name, _state, _field) \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_virtio_gpu_output_list,=
 \
> +                VirtIOGPUOutputList *)
> +
>  #endif
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index a42957c4e2..9f16f89a36 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -20,6 +20,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "qemu/log.h"
>  #include "system/vhost-user-backend.h"
> +#include "qapi/qapi-types-virtio.h"
>
>  #include "standard-headers/linux/virtio_gpu.h"
>  #include "standard-headers/linux/virtio_ids.h"
> @@ -128,6 +129,7 @@ struct virtio_gpu_base_conf {
>      uint32_t xres;
>      uint32_t yres;
>      uint64_t hostmem;
> +    VirtIOGPUOutputList *outputs;
>  };
>
>  struct virtio_gpu_ctrl_command {
> @@ -167,6 +169,7 @@ struct VirtIOGPUBaseClass {
>
>  #define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       =
\
>      DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    =
\
> +    DEFINE_PROP_VIRTIO_GPU_OUTPUT_LIST("outputs", _state, _conf.outputs)=
, \
>      DEFINE_PROP_BIT("edid", _state, _conf.flags, \
>                      VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
>      DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 73df718a26..eb6a907c40 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -963,17 +963,31 @@
>  { 'struct': 'IOThreadVirtQueueMapping',
>    'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
>
> +##
> +# @VirtIOGPUOutput:
> +#
> +# Describes configuration of a VirtIO GPU output.
> +#
> +# @name: the name of the output
> +#
> +# Since: 9.0

Needs to be 10.1

> +##
> +
> +{ 'struct': 'VirtIOGPUOutput',
> +  'data': { 'name': 'str' } }
> +
>  ##
>  # @DummyVirtioForceArrays:
>  #
>  # Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
> -# internally
> +# and VirtIOGPUOutputList internally
>  #
>  # Since: 9.0
>  ##
>
>  { 'struct': 'DummyVirtioForceArrays',
> -  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] }=
 }
> +  'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'],
> +            'unused-virtio-gpu-output': ['VirtIOGPUOutput'] } }
>
>  ##
>  # @GranuleMode:
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>


--=20
Marc-Andr=C3=A9 Lureau

