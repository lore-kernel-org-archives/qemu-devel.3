Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771FEC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLJZ-0008O5-MI; Mon, 27 Jan 2025 04:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLJV-0008Nm-R6; Mon, 27 Jan 2025 04:21:50 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcLJT-0003G4-3F; Mon, 27 Jan 2025 04:21:49 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so5481495a12.1; 
 Mon, 27 Jan 2025 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737969704; x=1738574504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UuFjFlXx2cpy2FEWdZ5KX6cphMe20KLc2czhmRa7OM=;
 b=FkTagHrW5GaQsB3ZlYN4R3nfmn8/ND27HQqSgUug1WpOmFQ6dnVlxcjBLsqPPX2PKi
 Nh8bXRVbhGqs6N525ttwuZvz1VIvHQ/CZRh/bAP4SNQVo0IVBv5LbqH1ZUvCyjvK/w65
 aXaJEAnNR/cHTOz6H/1Kyxv2LDsjcKFj9BKgqwxk69p5NSy1kVlXxFEfS5+QTmDxZl81
 C/kNmWsfapWfLgej+WsQrtrENNXRlxxAS2EJC3SspVYpWdABat3k49vfoSb1zmElzaAd
 /Ta7yUG3EbfM1YxwD1ECjDdTXLXn6TG0G6bEMeGd/Ed9pAlAFv/s/pB8C9dl1A9eU9Z/
 xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737969704; x=1738574504;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UuFjFlXx2cpy2FEWdZ5KX6cphMe20KLc2czhmRa7OM=;
 b=Ij85QD80W/0w+Gnl+MbLlvZWmGUu4wHYGNnHA+QWw51Wa40yDJ7YpQQYM3o9y9UfZv
 KUboyY+ZviqARCAiPL09gH7u+GnYM/YaS5z0R9CD9n4vx+Jts1QH8DwCAWU8Kzi8dUN3
 UVla5UbvXU0HVorFyrDkaHkmRGIpxCOA+X6nNHgxZdGVpp5Xs6RArcNjM4vl/l4apOhQ
 hfF2wbPEFPdv2rwkmVy4EBln0DFo/wwJj0GLP3MzPbJ7FKbYlt3i2wXTP8t7nYmfCOhz
 APM5ZHpjeoBwleVG8QpjXOByKv7vSdnO1b4c/QxSHlM2H5mObQdN8P6/Pa5KYrDlH0dL
 2TAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1oDeForzxvmRph+mng4d6QTrGr/9TvSlw0absPGl4ywKVDUEjHXRQZ9aZ3q9MBtObC6avW4Govrhv@nongnu.org,
 AJvYcCUoXD/rkkMzPmE5ixeJ/KSGfWJM6XnR39NOFfpPceyN0WkMF9HPbZOMJGt3Z+BlucaheUdws440T6Y=@nongnu.org
X-Gm-Message-State: AOJu0YxvHDu+9ujxTHVNBBJNp28wvdRZjuNfiv7XtYgZtUvDS0BwAet+
 t469py5uw3xOmxy+ZycqfNYj9GDq3a4eOUeAu0TjKtamPw9wEaja
X-Gm-Gg: ASbGncv5esFfSTrhMDYQQLdGgJXDFjM51CtW/yQ5jxVatSEDg6D4EpDMV5+NdKSgS/B
 g4yCT900Plxtg4zXlb/RKkEJD9HytXovyxkJPJllvKKRYEpkWiAhgXpHSLE0KueUneXkTcokI8x
 Kv811xEwWQWgQSvxPPj0VYbmzC8qWXpZ2785h58lzKjzyeUmUg2FUaECJencZH5ESDRQEN4s9/s
 PzsA8qxwqNfMwawzZSC5kn6+Z5VlNn3e3AGPF46wRzBbqlVECXl9WdnFPoqAFdaNBxdPYq4RbKU
 z8WW6AZaDs05DoIP8PlITdm7ZxIC07lLef5uJyer+jwJkpBKEqmp4OKBicuc+RyZNI4=
X-Google-Smtp-Source: AGHT+IEkfmy1lj+GPVFBL2FtqWCYO3YjtUx8arnMB2aNAPatwxoDM48FZF5ggzn93a2OlFcmqgnFTQ==
X-Received: by 2002:a17:906:f5a2:b0:aab:c78c:a7ed with SMTP id
 a640c23a62f3a-ab38b3db4d1mr3880527066b.49.1737969703759; 
 Mon, 27 Jan 2025 01:21:43 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-047-181.93.128.pool.telefonica.de.
 [93.128.47.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760b76acsm548940966b.113.2025.01.27.01.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 01:21:43 -0800 (PST)
Date: Mon, 27 Jan 2025 09:21:42 +0000
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_7/9=5D_hw/net=3A_Have_eTSEC_dev?=
 =?US-ASCII?Q?ice_inherit_from_DYNAMIC=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <20250125181343.59151-8-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-8-philmd@linaro.org>
Message-ID: <0EF260B4-A6E0-47A5-9EA4-7E90F7261F5B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 25=2E Januar 2025 18:13:41 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Because the network eTSEC device can be optionally plugged on the
>TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>
Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/net/fsl_etsec/etsec=2Ec | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/hw/net/fsl_etsec/etsec=2Ec b/hw/net/fsl_etsec/etsec=2Ec
>index 781b9003954=2E=2E3ce4fa2662d 100644
>--- a/hw/net/fsl_etsec/etsec=2Ec
>+++ b/hw/net/fsl_etsec/etsec=2Ec
>@@ -425,14 +425,12 @@ static void etsec_class_init(ObjectClass *klass, vo=
id *data)
>     dc->realize =3D etsec_realize;
>     device_class_set_legacy_reset(dc, etsec_reset);
>     device_class_set_props(dc, etsec_properties);
>-    /* Supported by ppce500 machine */
>-    dc->user_creatable =3D true;
> }
>=20
> static const TypeInfo etsec_types[] =3D {
>     {
>         =2Ename          =3D TYPE_ETSEC_COMMON,
>-        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>+        =2Eparent        =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,
>         =2Einstance_size =3D sizeof(eTSEC),
>         =2Eclass_init    =3D etsec_class_init,
>         =2Einstance_init =3D etsec_instance_init,

