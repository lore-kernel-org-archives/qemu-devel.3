Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40380C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 20:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpYX3-0006UC-7v; Tue, 04 Mar 2025 15:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tpYWl-0006RQ-Q2; Tue, 04 Mar 2025 15:06:07 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tpYWg-0003Ki-2l; Tue, 04 Mar 2025 15:06:05 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e4ebc78da5so8889829a12.2; 
 Tue, 04 Mar 2025 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741118759; x=1741723559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdqQJ/1EkYHP+Z5r3LsrMNCxln9OTY3dSihpgE+WLVw=;
 b=XZk4tUSTirzi+6Om1gf5m4tuILYUfsBazNfuPT/okdzUEZZjxbRCR/Y6UTB1QqQq7L
 /oBVwB4tUePrXhmu9JXbPGfNlq/P3QBIn/hIAo55WEzHDxzfLrtxLrYG8WFJs1EDcRzb
 7143otOgFgl5Ct1WBT4ZgKOrhfRNHEqC0pPcGEmabkU5WkVAD3pPMJ4Q+8GFQGRzLkDH
 9G3BBZGZpCmlMxzWCQkoNtqOlLoxLb+ZoHxUG6FKd9ZjICr771Xha9pRKYugcCPuItKZ
 +CwwZZQ+psCvbTgTz9sriHU0XsSWqIllCdOJHkcM40XD+qT4uoHwmACXSjGlXZ4bt/YW
 nsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741118759; x=1741723559;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdqQJ/1EkYHP+Z5r3LsrMNCxln9OTY3dSihpgE+WLVw=;
 b=E7ckQ83ux92mwdCP01C79dLdlt64QUV3lhvxTDkE+1wuqMZ5kLp/f66XNNnSxsRU+5
 PEm4YjeZ0cWSzfuUfas/I654WIFtnVpQlofiUFEHO8vf7wJKsc4IrRsl62srOSWfgEJE
 2uAD0A4evuc2KpUCigq8ZkN4Ta/IhM3OVQIgM66ZGO8nAJ+kyGdYEM8wmHAdwKmlIGrN
 P2PVF3Ay5FKucdZ/MdwD5eT5Eowk4uOpMLIEKxomdErtyZHRDrDfPEM4dI/3KlocLyry
 g/JavlVIW0yakN+JwGdhELFwYJ+BvEVuRw3pXcEJJ1MTaQsscrVVf9C9B8zcc6CQUW2O
 Ba2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXisczaIrHrJWzzpI+NTRpB1qvLyXEDpxa872c220iq7CScNLJkePVIy9hioHon6DosS/3eoBGZQQ==@nongnu.org
X-Gm-Message-State: AOJu0YwrXkx+Crz15XK8YE4v1VN43sh07kd1o/Toe59ODqDTqw6DOAj6
 NcolQlGtz8bqduzFeGfHAHsTt68Xm4ShGX/6Hj59NY7ZSTXXUzDMgGtExg==
X-Gm-Gg: ASbGncsIBbQPe/4OToUU8800HL5ASKSL+LlpJ/Fm7H8z5D1A3oWIeMLwKZWi6ppp024
 PaOgzSgUTWNZw0UBOC5eXa0rAO+ZAYDYgiCsfrxIUQ58whBQOeAgNSUps4mg7hkAE/AuGIAnEpM
 uLoTKt8/A/ebQd/uZGyXdAhKttYjr2BOxY7JuCI27bWidczu1rVsOYnUwiMutkz/aWTBFQQuRpn
 cohkFqtb67vG0d8XDI//cHa5EVvzJ2nCyy8UhhMxIbzCZ75TFaeP051JSLP4fmf7OlSULNK+rfq
 RYVRTzvdp+27Al3hi9xav8iTuutl64gVV3m3a2izwz1htj3LZlfsBupUuN20XqfOU7GuJqL16oh
 YDwAQvYCIHk9mvn52QF2WU2wIwYEC5OR+F2h3dtezKjQpQihfiRaA
X-Google-Smtp-Source: AGHT+IFlpDrwBI1nM/qbFRcOlsKL3osQCLFVSbElsj/+iAaCIYaKuue2MZRtrshFd3KcMmr85waLYA==
X-Received: by 2002:a05:6402:3485:b0:5d1:f009:925e with SMTP id
 4fb4d7f45d1cf-5e59f3c49d3mr358222a12.16.1741118759100; 
 Tue, 04 Mar 2025 12:05:59 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1d2d-ce00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1d2d:ce00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a55e0sm8591147a12.79.2025.03.04.12.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 12:05:58 -0800 (PST)
Date: Tue, 04 Mar 2025 18:53:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
In-Reply-To: <20250223114708.1780-19-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-19-shentey@gmail.com>
Message-ID: <77E3F57E-95D0-4E2F-838E-5E0334651349@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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



Am 23=2E Februar 2025 11:47:08 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>The implementation just allows Linux to determine date and time=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>---
> MAINTAINERS                |   2 +
> hw/rtc/rs5c372=2Ec           | 236 +++++++++++++++++++++++++++++++++++++
> tests/qtest/rs5c372-test=2Ec |  43 +++++++
> hw/rtc/Kconfig             |   5 +
> hw/rtc/meson=2Ebuild         |   1 +
> hw/rtc/trace-events        |   4 +
> tests/qtest/meson=2Ebuild    |   1 +
> 7 files changed, 292 insertions(+)
> create mode 100644 hw/rtc/rs5c372=2Ec
> create mode 100644 tests/qtest/rs5c372-test=2Ec

Ping for just this patch=2E I'd like to have it merged for 10=2E0=2E

Thanks,
Bernhard

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 489e426d85=2E=2E2552cfd65c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -828,10 +828,12 @@ F: hw/arm/imx8mp-evk=2Ec
> F: hw/arm/fsl-imx8mp=2Ec
> F: hw/misc/imx8mp_*=2Ec
> F: hw/pci-host/fsl_imx8m_phy=2Ec
>+F: hw/rtc/rs5c372=2Ec
> F: include/hw/arm/fsl-imx8mp=2Eh
> F: include/hw/misc/imx8mp_*=2Eh
> F: include/hw/pci-host/fsl_imx8m_phy=2Eh
> F: pc-bios/imx8mp*
>+F: tests/qtest/rs5c372-test=2Ec
> F: docs/system/arm/imx8mp-evk=2Erst
>=20
> MPS2 / MPS3
>diff --git a/hw/rtc/rs5c372=2Ec b/hw/rtc/rs5c372=2Ec
>new file mode 100644
>index 0000000000=2E=2E5542f74085
>--- /dev/null
>+++ b/hw/rtc/rs5c372=2Ec
>@@ -0,0 +1,236 @@
>+/*
>+ * Ricoh RS5C372, R222x I2C RTC
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * Based on hw/rtc/ds1338=2Ec
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/i2c/i2c=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "hw/resettable=2Eh"
>+#include "migration/vmstate=2Eh"
>+#include "qemu/bcd=2Eh"
>+#include "qom/object=2Eh"
>+#include "system/rtc=2Eh"
>+#include "trace=2Eh"
>+
>+#define NVRAM_SIZE 0x10
>+
>+/* Flags definitions */
>+#define SECONDS_CH 0x80
>+#define HOURS_PM   0x20
>+#define CTRL2_24   0x20
>+
>+#define TYPE_RS5C372 "rs5c372"
>+OBJECT_DECLARE_SIMPLE_TYPE(RS5C372State, RS5C372)
>+
>+struct RS5C372State {
>+    I2CSlave parent_obj;
>+
>+    int64_t offset;
>+    uint8_t wday_offset;
>+    uint8_t nvram[NVRAM_SIZE];
>+    uint8_t ptr;
>+    uint8_t tx_format;
>+    bool addr_byte;
>+};
>+
>+static void capture_current_time(RS5C372State *s)
>+{
>+    /*
>+     * Capture the current time into the secondary registers which will =
be
>+     * actually read by the data transfer operation=2E
>+     */
>+    struct tm now;
>+    qemu_get_timedate(&now, s->offset);
>+    s->nvram[0] =3D to_bcd(now=2Etm_sec);
>+    s->nvram[1] =3D to_bcd(now=2Etm_min);
>+    if (s->nvram[0xf] & CTRL2_24) {
>+        s->nvram[2] =3D to_bcd(now=2Etm_hour);
>+    } else {
>+        int tmp =3D now=2Etm_hour;
>+        if (tmp % 12 =3D=3D 0) {
>+            tmp +=3D 12;
>+        }
>+        if (tmp <=3D 12) {
>+            s->nvram[2] =3D to_bcd(tmp);
>+        } else {
>+            s->nvram[2] =3D HOURS_PM | to_bcd(tmp - 12);
>+        }
>+    }
>+    s->nvram[3] =3D (now=2Etm_wday + s->wday_offset) % 7 + 1;
>+    s->nvram[4] =3D to_bcd(now=2Etm_mday);
>+    s->nvram[5] =3D to_bcd(now=2Etm_mon + 1);
>+    s->nvram[6] =3D to_bcd(now=2Etm_year - 100);
>+}
>+
>+static void inc_regptr(RS5C372State *s)
>+{
>+    s->ptr =3D (s->ptr + 1) & (NVRAM_SIZE - 1);
>+}
>+
>+static int rs5c372_event(I2CSlave *i2c, enum i2c_event event)
>+{
>+    RS5C372State *s =3D RS5C372(i2c);
>+
>+    switch (event) {
>+    case I2C_START_RECV:
>+        /*
>+         * In h/w, capture happens on any START condition, not just a
>+         * START_RECV, but there is no need to actually capture on
>+         * START_SEND, because the guest can't get at that data
>+         * without going through a START_RECV which would overwrite it=
=2E
>+         */
>+        capture_current_time(s);
>+        s->ptr =3D 0xf;
>+        break;
>+    case I2C_START_SEND:
>+        s->addr_byte =3D true;
>+        break;
>+    default:
>+        break;
>+    }
>+
>+    return 0;
>+}
>+
>+static uint8_t rs5c372_recv(I2CSlave *i2c)
>+{
>+    RS5C372State *s =3D RS5C372(i2c);
>+    uint8_t res;
>+
>+    res  =3D s->nvram[s->ptr];
>+
>+    trace_rs5c372_recv(s->ptr, res);
>+
>+    inc_regptr(s);
>+    return res;
>+}
>+
>+static int rs5c372_send(I2CSlave *i2c, uint8_t data)
>+{
>+    RS5C372State *s =3D RS5C372(i2c);
>+
>+    if (s->addr_byte) {
>+        s->ptr =3D data >> 4;
>+        s->tx_format =3D data & 0xf;
>+        s->addr_byte =3D false;
>+        return 0;
>+    }
>+
>+    trace_rs5c372_send(s->ptr, data);
>+
>+    if (s->ptr < 7) {
>+        /* Time register=2E */
>+        struct tm now;
>+        qemu_get_timedate(&now, s->offset);
>+        switch (s->ptr) {
>+        case 0:
>+            now=2Etm_sec =3D from_bcd(data & 0x7f);
>+            break;
>+        case 1:
>+            now=2Etm_min =3D from_bcd(data & 0x7f);
>+            break;
>+        case 2:
>+            if (s->nvram[0xf] & CTRL2_24) {
>+                now=2Etm_hour =3D from_bcd(data & 0x3f);
>+            } else {
>+                int tmp =3D from_bcd(data & (HOURS_PM - 1));
>+                if (data & HOURS_PM) {
>+                    tmp +=3D 12;
>+                }
>+                if (tmp % 12 =3D=3D 0) {
>+                    tmp -=3D 12;
>+                }
>+                now=2Etm_hour =3D tmp;
>+            }
>+            break;
>+        case 3:
>+            {
>+                /*
>+                 * The day field is supposed to contain a value in the r=
ange
>+                 * 1-7=2E Otherwise behavior is undefined=2E
>+                 */
>+                int user_wday =3D (data & 7) - 1;
>+                s->wday_offset =3D (user_wday - now=2Etm_wday + 7) % 7;
>+            }
>+            break;
>+        case 4:
>+            now=2Etm_mday =3D from_bcd(data & 0x3f);
>+            break;
>+        case 5:
>+            now=2Etm_mon =3D from_bcd(data & 0x1f) - 1;
>+            break;
>+        case 6:
>+            now=2Etm_year =3D from_bcd(data) + 100;
>+            break;
>+        }
>+        s->offset =3D qemu_timedate_diff(&now);
>+    } else {
>+        s->nvram[s->ptr] =3D data;
>+    }
>+    inc_regptr(s);
>+    return 0;
>+}
>+
>+static void rs5c372_reset_hold(Object *obj, ResetType type)
>+{
>+    RS5C372State *s =3D RS5C372(obj);
>+
>+    /* The clock is running and synchronized with the host */
>+    s->offset =3D 0;
>+    s->wday_offset =3D 0;
>+    memset(s->nvram, 0, NVRAM_SIZE);
>+    s->ptr =3D 0;
>+    s->addr_byte =3D false;
>+}
>+
>+static const VMStateDescription rs5c372_vmstate =3D {
>+    =2Ename =3D "rs5c372",
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_I2C_SLAVE(parent_obj, RS5C372State),
>+        VMSTATE_INT64(offset, RS5C372State),
>+        VMSTATE_UINT8_V(wday_offset, RS5C372State, 2),
>+        VMSTATE_UINT8_ARRAY(nvram, RS5C372State, NVRAM_SIZE),
>+        VMSTATE_UINT8(ptr, RS5C372State),
>+        VMSTATE_UINT8(tx_format, RS5C372State),
>+        VMSTATE_BOOL(addr_byte, RS5C372State),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+static void rs5c372_init(Object *obj)
>+{
>+    qdev_prop_set_uint8(DEVICE(obj), "address", 0x32);
>+}
>+
>+static void rs5c372_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>+
>+    k->event =3D rs5c372_event;
>+    k->recv =3D rs5c372_recv;
>+    k->send =3D rs5c372_send;
>+    dc->vmsd =3D &rs5c372_vmstate;
>+    rc->phases=2Ehold =3D rs5c372_reset_hold;
>+}
>+
>+static const TypeInfo rs5c372_types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_RS5C372,
>+        =2Eparent        =3D TYPE_I2C_SLAVE,
>+        =2Einstance_size =3D sizeof(RS5C372State),
>+        =2Einstance_init =3D rs5c372_init,
>+        =2Eclass_init    =3D rs5c372_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(rs5c372_types)
>diff --git a/tests/qtest/rs5c372-test=2Ec b/tests/qtest/rs5c372-test=2Ec
>new file mode 100644
>index 0000000000=2E=2E0f6a9b68b9
>--- /dev/null
>+++ b/tests/qtest/rs5c372-test=2Ec
>@@ -0,0 +1,43 @@
>+/*
>+ * QTest testcase for the RS5C372 RTC
>+ *
>+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>+ *
>+ * Based on ds1338-test=2Ec
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "qemu/bcd=2Eh"
>+#include "libqos/i2c=2Eh"
>+
>+#define RS5C372_ADDR 0x32
>+
>+static void rs5c372_read_date(void *obj, void *data, QGuestAllocator *al=
loc)
>+{
>+    QI2CDevice *i2cdev =3D obj;
>+
>+    uint8_t resp[0x10];
>+    time_t now =3D time(NULL);
>+    struct tm *utc =3D gmtime(&now);
>+
>+    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
>+
>+    /* check retrieved time against local time */
>+    g_assert_cmpuint(from_bcd(resp[5]), =3D=3D , utc->tm_mday);
>+    g_assert_cmpuint(from_bcd(resp[6]), =3D=3D , 1 + utc->tm_mon);
>+    g_assert_cmpuint(2000 + from_bcd(resp[7]), =3D=3D , 1900 + utc->tm_y=
ear);
>+}
>+
>+static void rs5c372_register_nodes(void)
>+{
>+    QOSGraphEdgeOptions opts =3D { };
>+    add_qi2c_address(&opts, &(QI2CAddress) { RS5C372_ADDR });
>+
>+    qos_node_create_driver("rs5c372", i2c_device_create);
>+    qos_node_consumes("rs5c372", "i2c-bus", &opts);
>+    qos_add_test("read_date", "rs5c372", rs5c372_read_date, NULL);
>+}
>+
>+libqos_init(rs5c372_register_nodes);
>diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
>index 2fe04ec1d0=2E=2E315b0e4ecc 100644
>--- a/hw/rtc/Kconfig
>+++ b/hw/rtc/Kconfig
>@@ -26,3 +26,8 @@ config GOLDFISH_RTC
>=20
> config LS7A_RTC
>     bool
>+
>+config RS5C372_RTC
>+    bool
>+    depends on I2C
>+    default y if I2C_DEVICES
>diff --git a/hw/rtc/meson=2Ebuild b/hw/rtc/meson=2Ebuild
>index 8ecc2d792c=2E=2E6c87864dc0 100644
>--- a/hw/rtc/meson=2Ebuild
>+++ b/hw/rtc/meson=2Ebuild
>@@ -13,3 +13,4 @@ system_ss=2Eadd(when: 'CONFIG_GOLDFISH_RTC', if_true: f=
iles('goldfish_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-r=
tc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc=
=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372=2Ec'=
))
>diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
>index 8012afe102=2E=2Eb9f2852d35 100644
>--- a/hw/rtc/trace-events
>+++ b/hw/rtc/trace-events
>@@ -35,3 +35,7 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "=
mem write addr:0x%04x val
> # goldfish_rtc=2Ec
> goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " v=
alue 0x%08" PRIx64
> goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
>+
>+# rs5c372=2Ec
>+rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PR=
Ix8
>+rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PR=
Ix8
>diff --git a/tests/qtest/meson=2Ebuild b/tests/qtest/meson=2Ebuild
>index 8a6243382a=2E=2E9e5380ba7a 100644
>--- a/tests/qtest/meson=2Ebuild
>+++ b/tests/qtest/meson=2Ebuild
>@@ -298,6 +298,7 @@ qos_test_ss=2Eadd(
>   'pca9552-test=2Ec',
>   'pci-test=2Ec',
>   'pcnet-test=2Ec',
>+  'rs5c372-test=2Ec',
>   'sdhci-test=2Ec',
>   'spapr-phb-test=2Ec',
>   'tmp105-test=2Ec',

