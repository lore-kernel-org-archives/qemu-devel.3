Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA794E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9ef-0000MI-MO; Tue, 07 Jan 2025 08:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tV9eS-0000Lh-9C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tV9eQ-0002JY-Aa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736256580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+Xep6c17SHmb/pGZYwZG/RX0nmuxvQcJ7gFzQUVS/s=;
 b=Ndl6Ee05h8J2nDhh07mYrRokIf8WOdrkQhUTbZjKaPYBedJ6bgPOs5LLk637fm+biMNwpU
 I4cVqZx1PMF6ubVRJ0ocZJwexo56uTHsmcOSUhwGf8LvUbGHKbEFzPXX0p+VgMUdQN3nbt
 XobSHxhatO6W68erLSskCecvTJWXp9Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-h_ivOboWN_GAtF73M_1-gA-1; Tue, 07 Jan 2025 08:29:38 -0500
X-MC-Unique: h_ivOboWN_GAtF73M_1-gA-1
X-Mimecast-MFC-AGG-ID: h_ivOboWN_GAtF73M_1-gA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee86953aeaso21991792a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 05:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736256578; x=1736861378;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+Xep6c17SHmb/pGZYwZG/RX0nmuxvQcJ7gFzQUVS/s=;
 b=mlHAFaao7g3D16sSY/Jzyze3oJpZGqXS1Ej5zja8BZZHTw/qW9X5lr9WdfpB/gXjKP
 FXtQjt4OQ+cJ/O/AhWgjcZSFjQUpefssMEhZfAAty6xlLGFQpkF037QKUZ1f1Kmvdo5h
 2J7wWGI7qgdCyhnxXvicsGsnazxXhw2208k+cF7zJwoxlQGlxEpHD1IJDO2xGKNG2ghd
 ZLraDXjzOjyrMyGntv5nop5Oopwm08dViVVI+chFnymJQRZ5FLATFDKBh5Xc4OdZ0l0z
 4hAAhZ5g9od1sk7Je2hsltMJb/rigaBcoliUByDPVeNuWB8M7I8MiAEcNAlbUAEQO+3H
 AGNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfF73/oKtUoK3KiXvIJEXsRjm0kFpl+DBmecNuGfIbFdUpMBEJc7MqESgX3cRAdYRktLqENCPTSaUb@nongnu.org
X-Gm-Message-State: AOJu0YzrsvjCN4Y7UhJ0EZHFhlKrzggalEox8L8zCfcFb4C6v/Sr0EwP
 dXmeIZjZVzVMwudluc5LSbAODWB5OVYm/UFE9CJyqvI1B6+xmiSoWvKakshEDaOt3DKS8Lu5xUF
 SXx7GXZzXY+wfKBk+a4uqxTjFmN5JjaxJqbZW2uPVHvlB96J/YBqj
X-Gm-Gg: ASbGncte39CgAo/VqfcGI4+ufIlVUhkf0uYAqKsUHFjs0EOgpnr7Y+s9lGzAol2FFX0
 8jA2/CwFZqXe4kO20bngjJhe3uAqhmoiw2fU6Z9wve5Z2BePLbA3niFlEtPIpBllcIA8Th/0q64
 Hm75100XfF9WlXZHTQ8aVIWSj4jlpmoik3hol0R6kgqNb5KOwV4zBO6nN3h+b1hz2MEM9QOEkYE
 p2ujlrC5m23wvythU2K1WYUAKspXbAn+rZNYdoVZWH3aor/i3GC7LT/ppzi8Ev54dIrb7D81Q==
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr82769447a91.32.1736256577810; 
 Tue, 07 Jan 2025 05:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7IPZt8qS0ESiGCgXupNz047ecN9Bqo3fRXe2y2F+BjjyDLEBVffWjn0G6m47oz+XxkCOnHw==
X-Received: by 2002:a17:90b:134d:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f452eed773mr82769415a91.32.1736256577331; 
 Tue, 07 Jan 2025 05:29:37 -0800 (PST)
Received: from smtpclient.apple ([115.96.125.221])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478ac7dbsm35879322a91.50.2025.01.07.05.29.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2025 05:29:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20250107125802.139479-1-anisinha@redhat.com>
Date: Tue, 7 Jan 2025 18:59:22 +0530
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52B9F983-9401-4368-953D-D2445702CA0F@redhat.com>
References: <20250107125802.139479-1-anisinha@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



> On 7 Jan 2025, at 6:28=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> At present, the libqos/fw_cfg.c library does not support the modern =
DMA which
> is required to write to the fw_cfg files. It only uses the IO =
interface.
> Implement read and write methods based on DMA. This will enable =
developers to
> write tests that writes to the fw_cfg file(s). The structure of the =
code is
> taken from edk2 fw_cfg implementation. It has been tested by writing a =
qtest
> that writes to a fw_cfg file. This test will be part of a future patch =
series.
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Clearly I sent this out a tad bit early.

> ---
> tests/qtest/libqos/fw_cfg.c | 150 ++++++++++++++++++++++++++++++++++++
> tests/qtest/libqos/fw_cfg.h |   4 +
> 2 files changed, 154 insertions(+)
>=20
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 89f053ccac..1b855fbb15 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -17,6 +17,8 @@
> #include "../libqtest.h"
> #include "qemu/bswap.h"
> #include "hw/nvram/fw_cfg.h"
> +#include "malloc-pc.h"
> +#include "libqos-malloc.h"
>=20
> void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> {
> @@ -60,6 +62,59 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> }
>=20
> +static void
> +qfw_cfg_dma_transfer(QFWCFG *fw_cfg, void *address, uint32_t length,
> +                     uint32_t control)
> +{
> +    FWCfgDmaAccess access;
> +    uint32_t addr;
> +    QGuestAllocator guest_malloc;
> +    uint64_t guest_access_addr;
> +    uint64_t gaddr;
> +
> +    pc_alloc_init(&guest_malloc, fw_cfg->qts, ALLOC_NO_FLAGS);
> +
> +    /* create a data buffer in guest memory */
> +    gaddr =3D guest_alloc(&guest_malloc, length);
> +    g_assert(gaddr);
> +    qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
> +
> +    access.address =3D cpu_to_be64(gaddr);
> +    access.length =3D cpu_to_be32(length);
> +    access.control =3D cpu_to_be32(control);
> +
> +    guest_access_addr =3D guest_alloc(&guest_malloc, sizeof(access));
> +    g_assert(guest_access_addr);
> +    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, =
sizeof(access));
> +
> +    /* lower 32 bits */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
> +    /* upper 32 bits */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> =
32));
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
> +
> +    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
> +
> +    guest_free(&guest_malloc, guest_access_addr);
> +    guest_free(&guest_malloc, gaddr);
> +    alloc_destroy(&guest_malloc);
> +}
> +
> +static void
> +qfw_cfg_write_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, int len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_WRITE);
> +}
> +
> +static void
> +qfw_cfg_read_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, int len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_READ);
> +}
> +
> /*
>  * The caller need check the return value. When the return value is
>  * nonzero, it means that some bytes have been transferred.
> @@ -104,6 +159,101 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const =
char *filename,
>     return filesize;
> }
>=20
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
> + * buffer, then the first len bytes were read.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually read.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + */
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
> +                         void *data, size_t buflen)
> +{
> +    uint32_t count;
> +    uint32_t i;
> +    unsigned char *filesbuf =3D NULL;
> +    size_t dsize;
> +    size_t len =3D 0;
> +    FWCfgFile *pdir_entry;
> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count =3D be32_to_cpu(count);
> +    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> +    filesbuf =3D g_malloc(dsize);
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> +    for (i =3D 0; i < count; ++i, ++pdir_entry) {
> +        if (!strcmp(pdir_entry->name, filename)) {

This code is repeated in multiple functions. So I will refactor this =
into a helper.

> +            len =3D be32_to_cpu(pdir_entry->size);
> +            uint16_t sel =3D be16_to_cpu(pdir_entry->select);
> +            if (len > buflen) {
> +                len =3D buflen;
> +            }
> +            qfw_cfg_read_entry(fw_cfg, sel, data, len);
> +            break;
> +        }
> +    }
> +    g_free(filesbuf);
> +    return len;
> +}
> +
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
> + * buffer, then the buffer has been partially written.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually =
written.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + */
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
> +                          void *data, size_t buflen)
> +{
> +    uint32_t count;
> +    uint32_t i;
> +    size_t len =3D 0;
> +    uint32_t id;
> +    unsigned char *filesbuf =3D NULL;
> +    size_t dsize;
> +    FWCfgFile *pdir_entry;
> +
> +    /* write operation is only valid if DMA is supported */
> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count =3D be32_to_cpu(count);
> +    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> +    filesbuf =3D g_malloc(dsize);
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> +    for (i =3D 0; i < count; ++i, ++pdir_entry) {
> +        if (!strcmp(pdir_entry->name, filename)) {
> +            len =3D be32_to_cpu(pdir_entry->size);
> +            uint16_t sel =3D be16_to_cpu(pdir_entry->select);
> +            if (len > buflen) {
> +                len =3D buflen;
> +            }
> +            qfw_cfg_write_entry(fw_cfg, sel, data, len);
> +            break;
> +        }
> +    }
> +    g_free(filesbuf);
> +    return len;
> +}
> +
> static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> {
>     uint8_t *ptr =3D data;
> diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
> index b0456a15df..62221a9500 100644
> --- a/tests/qtest/libqos/fw_cfg.h
> +++ b/tests/qtest/libqos/fw_cfg.h
> @@ -33,6 +33,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t =
key);
> uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                         void *data, size_t buflen);
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
> +                          void *data, size_t buflen);
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
> +                         void *data, size_t buflen);
>=20
> QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
> --=20
> 2.45.2
>=20


