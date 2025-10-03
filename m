Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DD7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 02:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4V7B-0005Zr-HZ; Thu, 02 Oct 2025 22:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V77-0005ZU-R0
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 22:01:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V6r-0000zf-Rh
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 22:01:40 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b456d2dc440so269835266b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759456875; x=1760061675; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQoS8N4ft+p06dFzWPHzjp3hsgMtpSvf21aBPuen7ig=;
 b=aI2hUImF+f7dB35xV7A/SMK8O3TcJ0Yp4V4CgewuEBiCobJDLNu2iZdeDcMBZnuQrz
 iPD5e8BxrIXSOg50lmdoULgDS/sPFhdq2fNpg2604QpkO8gQDDS1nb6OSUVhGj/WGKqQ
 meXSQdprS3f8VKIjWsVwGOr4mPx5tLpzroTgGwUlkQqNA1GAznGfKFI7VlQOP8+uxMeQ
 tzBynft7rp+mM8t8BjApZhl1urB4jumBojYCy5Ll9f0o6m6Bu/1yk/EaEi230xZfopsn
 MprvfoPOsmR4CbjbuJkIURclSyNz6tbqgvXg/snQc5Ky7Fu5pyBbeyZygmaivgVaRY2z
 TUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759456875; x=1760061675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQoS8N4ft+p06dFzWPHzjp3hsgMtpSvf21aBPuen7ig=;
 b=JBhUCjXFZAtf0TppvcR9514gXgpTx0bEcR1Lajfb++xdipeIs1ojC9477skP/FlkfQ
 yeLKz7EzNhDmbrNPVDQbVS5qBXX1zgIsU2J7I9nORsxSHi7MZUx0tmtjE8HnYQWTY7OW
 sN3xHo3RfBSBDT3wgzCs1AL3oO2kyf7lCVt186GmNuuxEhcWTe7mQebEAvlhPMajy1xD
 AKArn2TP2rpV6Gd5zq4yMOEOXtjl5tlxjIVgJ3ISLujaP7Ypm+0quhFcdOvsP5Lejl4g
 A8j+dIWRt17+6P8cgJF0ua00FN5gjCU9cVlxdCAjn9FdCt4ZnkkYJU3WH8F+YiXQKK0h
 W0LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7F4EZYtNKcsNOt0Khudo4eBw0Xlr9+LoSoQScrLTXtQEdGiieg4D+ZoR6I4Onwe2hh/4xwzmx9t54@nongnu.org
X-Gm-Message-State: AOJu0YxXfgtSOUKzmZ+hyEWMIUL0ys3Ldrd6H0pkT6OOxXqC6z/kEq6R
 /Z4HKdj52XQKAcjGGZ1m3IWHbQAE9LtQSmnCiBWB3ngfBG24Z3Q1EWa9GDkk6FvG1emExekkRlA
 a54OtC6sTuWvHAqVe3c43e0gIgTHsnug=
X-Gm-Gg: ASbGncsZL7LmnnC1rVY7jsn/Fpp56ejXD1K+B8+t6q7MOV6OeEig9LtXn0M80CnV5OD
 i0gnaUwc8hLAHdadm6vCkaapbdQy/Uwgr6ix3MLdoLYwQAfLlmHOhnyuBxXEzOqmyDkDHauhchR
 2eVvDAflaBLuCJAOp9uJpEA4jO0/Zf4oiwo8YUkVZgy6eoYJqhEklnJ5BIREFaWqFUyYcNIh1S9
 iAcGd+DArWAlb0cXtj0mQ7bCDpY80jARhmY2NuQG4u291QWiEuelwi80kHyhA==
X-Google-Smtp-Source: AGHT+IGrLeFjAWlPlGVEqzoHQJNn/wbw0Lk+v0+F9CoNPcLDVkt2erEJbKkpU/K3jVPpiBbvI/mWvl4AvP+dbUuRooE=
X-Received: by 2002:a17:907:2685:b0:b45:1063:fb65 with SMTP id
 a640c23a62f3a-b49c3936225mr165215166b.39.1759456874873; Thu, 02 Oct 2025
 19:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-5-wilfred.opensource@gmail.com>
In-Reply-To: <20250912021152.46556-5-wilfred.opensource@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 12:00:47 +1000
X-Gm-Features: AS18NWCI0_ZmIrSrtcos6t2dymM9JJBRkKl9439tFLWCkh7VDiZY7Lwjkkd4RcQ
Message-ID: <CAKmqyKM3so6iYYyve=6K3cbo+kvRnUe0Pzi+vPV-uajDTZt_qw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] spdm: define SPDM transport enum types
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 12, 2025 at 12:13=E2=80=AFPM Wilfred Mallawa
<wilfred.opensource@gmail.com> wrote:
>
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>
> SPDM maybe used over different transports. This patch specifies the
> trasnport types as an enum with a qdev property definition such that
> a user input transport type (string) can be mapped directly into the
> respective SPDM transportenum for internal use.
>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  backends/spdm-socket.c       | 23 +++++++++++++++++++++++
>  include/system/spdm-socket.h | 19 +++++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index ab74a02d9c..6d8f02d3b9 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -13,6 +13,9 @@
>  #include "qemu/osdep.h"
>  #include "system/spdm-socket.h"
>  #include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/core/qdev-prop-internal.h"
>
>  static bool read_bytes(const int socket, uint8_t *buffer,
>                         size_t number_of_bytes)
> @@ -246,3 +249,23 @@ void spdm_socket_close(const int socket, uint32_t tr=
ansport_type)
>      send_platform_data(socket, transport_type,
>                         SPDM_SOCKET_COMMAND_SHUTDOWN, NULL, 0);
>  }
> +
> +const QEnumLookup SpdmTransport_lookup =3D {
> +    .array =3D (const char *const[]) {
> +        [SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC] =3D "unspecified",
> +        [SPDM_SOCKET_TRANSPORT_TYPE_MCTP] =3D "mctp",
> +        [SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE] =3D "doe",
> +        [SPDM_SOCKET_TRANSPORT_TYPE_SCSI] =3D "scsi",
> +        [SPDM_SOCKET_TRANSPORT_TYPE_NVME] =3D "nvme",
> +    },
> +    .size =3D SPDM_SOCKET_TRANSPORT_TYPE_MAX
> +};
> +
> +const PropertyInfo qdev_prop_spdm_trans =3D {
> +    .type =3D "SpdmTransportType",
> +    .description =3D "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
> +    .enum_table =3D &SpdmTransport_lookup,
> +    .get =3D qdev_propinfo_get_enum,
> +    .set =3D qdev_propinfo_set_enum,
> +    .set_default_value =3D qdev_propinfo_set_default_value_enum,
> +};
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index f0c8b64d1b..9d0b85f8cc 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -110,11 +110,22 @@ typedef struct {
>  #define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
>  #define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
>
> -#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
> -#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> -#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
> -
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
>  #define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
>
> +typedef enum SpdmTransportType {
> +    SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC =3D 0,
> +    SPDM_SOCKET_TRANSPORT_TYPE_MCTP,
> +    SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
> +    SPDM_SOCKET_TRANSPORT_TYPE_SCSI,
> +    SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +    SPDM_SOCKET_TRANSPORT_TYPE_MAX
> +} SpdmTransportType;
> +
> +extern const PropertyInfo qdev_prop_spdm_trans;
> +
> +#define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
> +    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
> +                         qdev_prop_spdm_trans, SpdmTransportType)
> +
>  #endif
> --
> 2.51.0
>
>

