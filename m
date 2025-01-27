Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE3CC0218F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLhF-0003aO-3R; Mon, 27 Jan 2025 04:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLhA-0003Nj-Lp; Mon, 27 Jan 2025 04:46:16 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLh8-0005pv-Px; Mon, 27 Jan 2025 04:46:16 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab651f1dd36so841494166b.0; 
 Mon, 27 Jan 2025 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737971173; x=1738575973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=musWy1n7TogM8KXZsXOnvhQhrXqQAkckhg6RXEq4Bko=;
 b=dfXvlODoGkd5A7uyB559QzK7D3xxMr+Kk5cJUd1dLFV8v7xsoVDs3NvdQjg1r2zLIO
 jAqStIrbQv9UvK/Q2LWV0GjAfJN95uCZP1H7RwZ+xgnFsOCH1C68Zvkh3k9DP/bc0crr
 RRwAr0ba6QkpHktRuqSRnL5ZCP1+5IK6QgCC7CNc13F5Q97B+vpWOU1CbshiVR6SXN0c
 rA6q1wJNR2q17Gm5P88dHLzDsgTm0uQJ3cdaXxHtFZbKPa0yoH1XJ4+OZEKVP2m5GbTq
 iFLDBTE7hCQsDR6zty89CLXLfrOxuvrGeeWBgqmJKQ+SfbXVVRv4HKTjzDeWvBfBaJ2U
 DlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737971173; x=1738575973;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=musWy1n7TogM8KXZsXOnvhQhrXqQAkckhg6RXEq4Bko=;
 b=EVVoykembeN3JRXdeEl+1g0RyEeP+DplrG8/RrXd5vqUdOWPphnu6aDiAxR3PFaBzK
 zJO34cPClkyLtgEkWBcILSIKnfVoaYMuduG9+4ICGEpZw6QQgR1EakO8gY4Dw4xqVe8l
 mp0pHSavt+XcZaDdBvscGQCDF4wH5VuxD/2R8OtIYnyxcgIs1z/1aNe8i0VH1gYwal7Y
 gyRo65KmbAlg8OSyw1mmbwjJf7zxATvdCRWlqQrLvCqIqth1O2OhnhV6zht7sIq+6fjp
 Iu0uKWqM0sWySkatsnZ2VZM6ycPhCwQB/Lln9cSecA+3EcR2DpOXwcMbEArT7LmEGUpy
 7Ecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdXaipMBd3t1WGo8Lb+gsKBVdj/o8BYGcvZ5bCXNmkLiSHQw0Tv7EOL3zeU+nquFIzXbT0xaf3+wY=@nongnu.org,
 AJvYcCUsguGK4R0vGEOO8aNvfZ8AVNNGRKLvIrHsgmSOw57qqOu4yOi38r6E0paUA007Xf31mPc3nq7uzYqP@nongnu.org
X-Gm-Message-State: AOJu0YxB/KNIqtiyHhGxPmYYgh0+WrQRckxK23WnWuvI8yXyUxw8tDLG
 pBiBrqU79uE4cjr7D05Pjgqqd7Pz3Mm4dTlOdlQY9DPwPMKYsv5380X7mQ==
X-Gm-Gg: ASbGnctQajNhuH6tZefDwOXwU0gOEIh9V2PP5hd+9MvBuVEGkJQrR3WN9TW2nxoH8l1
 7NnI3/MUxeaIOV/grPZ2mzVrUd0FF3QHJu0apIB+mA8Qju7DGJR9IuyCUeBrZ3C8S/qBk8b5Ecp
 1Ti99uYe7hwpMTPOHSdcnByc4bP/uQShuFu3LGfMyTnc6nxImlo2Paxhz7N3n43tPUrWIGl8HAW
 VTVRjYl3OzUC1mGx5RkYVk/Aa3TPVq8AnSUh2PlEtdid21PTwejtN+U6XbXyFukZjxZlE5ugO6u
 dRIetoLVp8wJv0tJd9me0BAqB1tZ3LXrWCqxkJzynmLAzomlhsnsYWLU
X-Google-Smtp-Source: AGHT+IHG0IaOyPVMUP/MqBB9v9/fX+0a85D1lpF7KinDYCL9eJYDjqGVvqsM8FHH5W5762wb2tK/pA==
X-Received: by 2002:a17:907:6ea4:b0:ab2:bffb:4b5c with SMTP id
 a640c23a62f3a-ab38b24bd9emr3486146266b.18.1737971172417; 
 Mon, 27 Jan 2025 01:46:12 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-047-181.93.128.pool.telefonica.de.
 [93.128.47.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e12505sm564891866b.17.2025.01.27.01.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 01:46:12 -0800 (PST)
Date: Mon, 27 Jan 2025 09:46:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_9/9=5D_hw/xen=3A_Have_legacy_Xen?=
 =?US-ASCII?Q?_backend_inherit_from_DYNAMIC=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <20250125181343.59151-10-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-10-philmd@linaro.org>
Message-ID: <9A2B297A-6270-4482-B1B6-81F518C07C1E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 25=2E Januar 2025 18:13:43 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Because the legacy Xen backend devices can optionally be plugged on the
>TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE=2E
>Remove the implicit TYPE_XENSYSDEV instance_size=2E
>
>Untested, but I'm surprised the legacy devices work because they
>had a broken instance size (QDev instead of Sysbus=2E=2E=2E), so accesses
>of XenLegacyDevice fields were overwritting sysbus ones=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/xen/xen_pvdev=2Eh  | 3 ++-
> hw/xen/xen-legacy-backend=2Ec | 7 ++-----
> 2 files changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/include/hw/xen/xen_pvdev=2Eh b/include/hw/xen/xen_pvdev=2Eh
>index 0c984440476=2E=2E48950dc2b57 100644
>--- a/include/hw/xen/xen_pvdev=2Eh
>+++ b/include/hw/xen/xen_pvdev=2Eh
>@@ -32,7 +32,8 @@ struct XenDevOps {
> };
>=20
> struct XenLegacyDevice {
>-    DeviceState        qdev;
>+    SysBusDevice parent_obj;

This then needs sysbus=2Eh rather than qdev-core=2Eh include=2E

Moreover, the patch in the reply needs to be inserted into the series befo=
re this patch=2E

Both are needed for the patch to compile=2E

Best regards,
Bernhard

>+
>     const char         *type;
>     int                dom;
>     int                dev;
>diff --git a/hw/xen/xen-legacy-backend=2Ec b/hw/xen/xen-legacy-backend=2E=
c
>index 118c571b3a7=2E=2E4d079e35d83 100644
>--- a/hw/xen/xen-legacy-backend=2Ec
>+++ b/hw/xen/xen-legacy-backend=2Ec
>@@ -640,16 +640,14 @@ static void xendev_class_init(ObjectClass *klass, v=
oid *data)
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>-    /* xen-backend devices can be plugged/unplugged dynamically */
>-    dc->user_creatable =3D true;
>     dc->bus_type =3D TYPE_XENSYSBUS;
> }
>=20
> static const TypeInfo xendev_type_info =3D {
>     =2Ename          =3D TYPE_XENBACKEND,
>-    =2Eparent        =3D TYPE_DEVICE,
>+    =2Eparent        =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,
>     =2Eclass_init    =3D xendev_class_init,
>-    =2Einstance_size =3D sizeof(struct XenLegacyDevice),
>+    =2Einstance_size =3D sizeof(XenLegacyDevice),
> };
>=20
> static void xen_sysbus_class_init(ObjectClass *klass, void *data)
>@@ -672,7 +670,6 @@ static const TypeInfo xensysbus_info =3D {
> static const TypeInfo xensysdev_info =3D {
>     =2Ename          =3D TYPE_XENSYSDEV,
>     =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>-    =2Einstance_size =3D sizeof(SysBusDevice),
> };
>=20
> static void xenbe_register_types(void)

