Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AF6CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW84-0005ZL-HA; Wed, 09 Oct 2024 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syW7x-0005Xo-S9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:49:18 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syW7t-0006er-G4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:49:17 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-50ac27e3530so487720e0c.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728478151; x=1729082951;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oPm1he9/FDOXRLEfi7epLWeNRiGUJWX/4NhDJcBQcFE=;
 b=XXN7oXXW413q6tvRJz+Gz+6G7JPaWP1WmFvWQdur2pCvBWtoCrF6MuZ8DFLusvMqxQ
 zlUyEBH/V+cC+HXaoZTujsKiWjHG0IumuIUiCwmoIWDdMzTkeJchMqBKmIYxPIRP3XQq
 CM9cOCarY1zLd3ryBvFzaClMxatrlxmxy6G3e7rYmrhp+lLczKwIHI3TuPjHM/4BD73O
 QNgaYdqaUWjmpixbkUOmRD5UMMRGFNYBsXeGauAUY2yw9t3eK/ngbyRfYYWgglQPn575
 hxeJ6kTZlL7LQWs3r4TE4jPq3xDYek30v/wDaYsuGRPpovWZGtk2AkLXMOL+84ofr//r
 bJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728478151; x=1729082951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oPm1he9/FDOXRLEfi7epLWeNRiGUJWX/4NhDJcBQcFE=;
 b=psZIHUA6npGjSYoJPrCMJroMIJ2LFGR1O/EZfkxo+vNhg+C0y5mDkVVp0Wn9gU0hWR
 KOS+OjBBkg/RE8OKQSYW1l79Uhd+uxlQ6AXFmoI8LxvzluY8RvsyP1aBOC5wNDSwMzDE
 E6QblJ47ldGWcefd8G7APJOyw6A8T9FaGnFiJGRZsIfhpZ0PVLMYUcZo5Tx5qgYFfjK+
 +Ro5Sbuj92bNLx8O5W0+jx1eNU2NOiUpV8J3W8zie3VFmWwZG1zM3rt75y4uX+q+Ai0+
 sIX8UWiQAqI7jauZC+YSc3mDRGtiQo2WamhIfLWxFc2AjR292IsJoDO0rOYmb1iDwPSU
 2HMw==
X-Gm-Message-State: AOJu0YyAFlQpY4fRZXXmxkjT1jloJ6VmoaRGzzsDC1h2S17Mhht2qpAP
 +oyHfVjy7xn5tv7aK6BIDLg9g90QSax+gwV2dDIURQKfS7JX0KweIr6xZHbYCluFAw4aEI5U3Kb
 vZrwzcP45mX1rSGBrAcH5MPRA09t9Hwy1KtcM
X-Google-Smtp-Source: AGHT+IEFfE/vFjby47wgj7j6Hc8/kqJMVdzHVUV77g/PAGUayZPypBy9S0GRTosJhLjxThdIUkk3aNvWrezBYwwAwrs=
X-Received: by 2002:a05:6122:1daa:b0:50c:d988:a567 with SMTP id
 71dfb90a1353d-50cd988ac5amr1427574e0c.4.1728478151002; Wed, 09 Oct 2024
 05:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-11-phil@philjordan.eu>
 <6f0e5a6a-ea1b-48ae-b3d5-6a68cc0366d2@daynix.com>
In-Reply-To: <6f0e5a6a-ea1b-48ae-b3d5-6a68cc0366d2@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 14:48:59 +0200
Message-ID: <CAAibmn1S9HZDnpTe5tY7+AxFZV_qmt4mEWQ2TrtM9cTu0Z0EZA@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] hw/vmapple/aes: Introduce aes engine
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000316da506240aae7a"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000316da506240aae7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 at 07:32, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > VMApple contains an "aes" engine device that it uses to encrypt and
> > decrypt its nvram. It has trivial hard coded keys it uses for that
> > purpose.
> >
> > Add device emulation for this device model.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >
> > ---
> > v3:
> >
> >   * Rebased on latest upstream and fixed minor breakages.
> >   * Replaced legacy device reset method with Resettable method
> >
> >   hw/vmapple/Kconfig      |   2 +
> >   hw/vmapple/aes.c        | 584 +++++++++++++++++++++++++++++++++++++++=
+
> >   hw/vmapple/meson.build  |   1 +
> >   hw/vmapple/trace-events |  19 ++
> >   4 files changed, 606 insertions(+)
> >   create mode 100644 hw/vmapple/aes.c
> >
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index 8b137891791..a73504d5999 100644
> > --- a/hw/vmapple/Kconfig
> > +++ b/hw/vmapple/Kconfig
> > @@ -1 +1,3 @@
> > +config VMAPPLE_AES
> > +    bool
> >
> > diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
> > new file mode 100644
> > index 00000000000..074fbdd9c36
> > --- /dev/null
> > +++ b/hw/vmapple/aes.c
> > @@ -0,0 +1,584 @@
> > +/*
> > + * QEMU Apple AES device emulation
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/irq.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "trace.h"
> > +#include "hw/sysbus.h"
> > +#include "crypto/hash.h"
> > +#include "crypto/aes.h"
> > +#include "crypto/cipher.h"
> > +
> > +#define TYPE_AES          "apple-aes"
> > +#define MAX_FIFO_SIZE     9
> > +
> > +#define CMD_KEY           0x1
> > +#define CMD_KEY_CONTEXT_SHIFT    27
> > +#define CMD_KEY_CONTEXT_MASK     (0x1 << CMD_KEY_CONTEXT_SHIFT)
> > +#define CMD_KEY_SELECT_SHIFT     24
> > +#define CMD_KEY_SELECT_MASK      (0x7 << CMD_KEY_SELECT_SHIFT)
> > +#define CMD_KEY_KEY_LEN_SHIFT    22
> > +#define CMD_KEY_KEY_LEN_MASK     (0x3 << CMD_KEY_KEY_LEN_SHIFT)
> > +#define CMD_KEY_ENCRYPT_SHIFT    20
> > +#define CMD_KEY_ENCRYPT_MASK     (0x1 << CMD_KEY_ENCRYPT_SHIFT)
> > +#define CMD_KEY_BLOCK_MODE_SHIFT 16
> > +#define CMD_KEY_BLOCK_MODE_MASK  (0x3 << CMD_KEY_BLOCK_MODE_SHIFT)
> > +#define CMD_IV            0x2
> > +#define CMD_IV_CONTEXT_SHIFT     26
> > +#define CMD_IV_CONTEXT_MASK      (0x3 << CMD_KEY_CONTEXT_SHIFT)
> > +#define CMD_DSB           0x3
> > +#define CMD_SKG           0x4
> > +#define CMD_DATA          0x5
> > +#define CMD_DATA_KEY_CTX_SHIFT   27
> > +#define CMD_DATA_KEY_CTX_MASK    (0x1 << CMD_DATA_KEY_CTX_SHIFT)
> > +#define CMD_DATA_IV_CTX_SHIFT    25
> > +#define CMD_DATA_IV_CTX_MASK     (0x3 << CMD_DATA_IV_CTX_SHIFT)
> > +#define CMD_DATA_LEN_MASK        0xffffff
> > +#define CMD_STORE_IV      0x6
> > +#define CMD_STORE_IV_ADDR_MASK   0xffffff
> > +#define CMD_WRITE_REG     0x7
> > +#define CMD_FLAG          0x8
> > +#define CMD_FLAG_STOP_MASK       BIT(26)
> > +#define CMD_FLAG_RAISE_IRQ_MASK  BIT(27)
> > +#define CMD_FLAG_INFO_MASK       0xff
> > +#define CMD_MAX           0x10
> > +
> > +#define CMD_SHIFT         28
> > +
> > +#define REG_STATUS            0xc
> > +#define REG_STATUS_DMA_READ_RUNNING     BIT(0)
> > +#define REG_STATUS_DMA_READ_PENDING     BIT(1)
> > +#define REG_STATUS_DMA_WRITE_RUNNING    BIT(2)
> > +#define REG_STATUS_DMA_WRITE_PENDING    BIT(3)
> > +#define REG_STATUS_BUSY                 BIT(4)
> > +#define REG_STATUS_EXECUTING            BIT(5)
> > +#define REG_STATUS_READY                BIT(6)
> > +#define REG_STATUS_TEXT_DPA_SEEDED      BIT(7)
> > +#define REG_STATUS_UNWRAP_DPA_SEEDED    BIT(8)
> > +
> > +#define REG_IRQ_STATUS        0x18
> > +#define REG_IRQ_STATUS_INVALID_CMD      BIT(2)
> > +#define REG_IRQ_STATUS_FLAG             BIT(5)
> > +#define REG_IRQ_ENABLE        0x1c
> > +#define REG_WATERMARK         0x20
> > +#define REG_Q_STATUS          0x24
> > +#define REG_FLAG_INFO         0x30
> > +#define REG_FIFO              0x200
> > +
> > +static const uint32_t key_lens[4] =3D {
>
> I suggest deriving the size from CMD_KEY_KEY_LEN_MASK.
>
> > +    [0] =3D 16,
> > +    [1] =3D 24,
> > +    [2] =3D 32,
> > +    [3] =3D 64,
> > +};
> > +
> > +struct key {
>
> Please add typedef.
>
> > +    uint32_t key_len;
> > +    uint32_t key[8];
> > +};
> > +
> > +struct iv {
> > +    uint32_t iv[4];
> > +};
> > +
> > +struct context {
> > +    struct key key;
> > +    struct iv iv;
> > +};
> > +
> > +static struct key builtin_keys[7] =3D {
>  > +    [1] =3D {> +        .key_len =3D 32,
> > +        .key =3D { 0x1 },
> > +    },
> > +    [2] =3D {
> > +        .key_len =3D 32,
> > +        .key =3D { 0x2 },
> > +    },
> > +    [3] =3D {
> > +        .key_len =3D 32,
> > +        .key =3D { 0x3 },
> > +    }
> > +};
> > +
> > +typedef struct AESState {
> > +    /* Private */
>
> This private/public comments are unnecessary; this struct can be
> referenced only from this file and all members are automatically private.
>
> > +    SysBusDevice parent_obj;
> > +
> > +    /* Public */
> > +    qemu_irq irq;
> > +    MemoryRegion iomem1;
> > +    MemoryRegion iomem2;
> > +
> > +    uint32_t status;
> > +    uint32_t q_status;
> > +    uint32_t irq_status;
> > +    uint32_t irq_enable;
> > +    uint32_t watermark;
> > +    uint32_t flag_info;
> > +    uint32_t fifo[MAX_FIFO_SIZE];
> > +    uint32_t fifo_idx;
> > +    struct key key[2];
> > +    struct iv iv[4];
> > +    bool is_encrypt;
> > +    QCryptoCipherMode block_mode;
> > +} AESState;
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(AESState, AES)
> > +
> > +static void aes_update_irq(AESState *s)
> > +{
> > +    qemu_set_irq(s->irq, !!(s->irq_status & s->irq_enable));
> > +}
> > +
> > +static uint64_t aes1_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    AESState *s =3D opaque;
> > +    uint64_t res =3D 0;
> > +
> > +    switch (offset) {
> > +    case REG_STATUS:
> > +        res =3D s->status;
> > +        break;
> > +    case REG_IRQ_STATUS:
> > +        res =3D s->irq_status;
> > +        break;
> > +    case REG_IRQ_ENABLE:
> > +        res =3D s->irq_enable;
> > +        break;
> > +    case REG_WATERMARK:
> > +        res =3D s->watermark;
> > +        break;
> > +    case REG_Q_STATUS:
> > +        res =3D s->q_status;
> > +        break;
> > +    case REG_FLAG_INFO:
> > +        res =3D s->flag_info;
> > +        break;
> > +
> > +    default:
> > +        trace_aes_read_unknown(offset);
>
> Use: LOG_UNIMP
>
> > +        break;
> > +    }
> > +
> > +    trace_aes_read(offset, res);
> > +
> > +    return res;
> > +}
> > +
> > +static void fifo_append(AESState *s, uint64_t val)
> > +{
> > +    if (s->fifo_idx =3D=3D MAX_FIFO_SIZE) {
> > +        /* Exceeded the FIFO. Bail out */
> > +        return;
> > +    }
> > +
> > +    s->fifo[s->fifo_idx++] =3D val;
> > +}
> > +
> > +static bool has_payload(AESState *s, uint32_t elems)
> > +{
> > +    return s->fifo_idx >=3D (elems + 1);
> > +}
> > +
> > +static bool cmd_key(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0];
> > +    uint32_t key_select =3D (cmd & CMD_KEY_SELECT_MASK) >>
> CMD_KEY_SELECT_SHIFT;
> > +    uint32_t ctxt =3D (cmd & CMD_KEY_CONTEXT_MASK) >>
> CMD_KEY_CONTEXT_SHIFT;
> > +    uint32_t key_len;
> > +
> > +    switch ((cmd & CMD_KEY_BLOCK_MODE_MASK) >>
> CMD_KEY_BLOCK_MODE_SHIFT) {
> > +    case 0:
> > +        s->block_mode =3D QCRYPTO_CIPHER_MODE_ECB;
> > +        break;
> > +    case 1:
> > +        s->block_mode =3D QCRYPTO_CIPHER_MODE_CBC;
> > +        break;
> > +    default:
> > +        return false;
> > +    }
> > +
> > +    s->is_encrypt =3D !!((cmd & CMD_KEY_ENCRYPT_MASK) >>
> CMD_KEY_ENCRYPT_SHIFT);
>
> CMD_KEY_ENCRYPT_SHIFT is unnecessary as in case of
> CMD_FLAG_RAISE_IRQ_MASK. "!!" is also unnecessary; it will be implicitly
> casted into bool.
>
> > +    key_len =3D key_lens[((cmd & CMD_KEY_KEY_LEN_MASK) >>
> CMD_KEY_KEY_LEN_SHIFT)];
> > +
> > +    if (key_select) {
> > +        trace_aes_cmd_key_select_builtin(ctxt, key_select,
> > +                                         s->is_encrypt ? "en" : "de",
> > +
>  QCryptoCipherMode_str(s->block_mode));
> > +        s->key[ctxt] =3D builtin_keys[key_select];
>
> I guess this should be: builtin_keys[key_select - 1]
>

I don't think it should: the builtin keys start at index 1. This seems
fine, and I'd rather leave the indices alone to avoid needing to do
arithmetic on them. However in that case, builtin_keys needs to have 8
elements not 7 as it currently does to avoid overflow. I'll fix this and
use symbolic constants.

(Thanks for the other review comments, I've reworked those parts for v4.)


> > +    } else {
> > +        trace_aes_cmd_key_select_new(ctxt, key_len,
> > +                                     s->is_encrypt ? "en" : "de",
> > +
>  QCryptoCipherMode_str(s->block_mode));
> > +        if (key_len > sizeof(s->key[ctxt].key)) {
> > +            return false;
> > +        }
> > +        if (!has_payload(s, key_len / sizeof(uint32_t))) {
> > +            /* wait for payload */
> > +            return false;
> > +        }
> > +        memcpy(&s->key[ctxt].key, &s->fifo[1], key_len);
> > +        s->key[ctxt].key_len =3D key_len;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static bool cmd_iv(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0];
> > +    uint32_t ctxt =3D (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SH=
IFT;
> > +
> > +    if (!has_payload(s, 4)) {
> > +        /* wait for payload */
> > +        return false;
> > +    }
> > +    memcpy(&s->iv[ctxt].iv, &s->fifo[1], sizeof(s->iv[ctxt].iv));
> > +    trace_aes_cmd_iv(ctxt, s->fifo[1], s->fifo[2], s->fifo[3],
> s->fifo[4]);
> > +
> > +    return true;
> > +}
> > +
> > +static char hexdigit2str(uint8_t val)
> > +{
> > +    g_assert(val < 0x10);
> > +    if (val >=3D 0xa) {
> > +        return 'a' + (val - 0xa);
> > +    } else {
> > +        return '0' + val;
> > +    }
> > +}
> > +
> > +static void dump_data(const char *desc, const void *p, size_t len)
> > +{
> > +    char *hex =3D alloca((len * 2) + 1);
>
> Don't use alloca(); use a fixed-length array instead.
>
> > +    const uint8_t *data =3D p;
> > +    char *hexp =3D hex;
> > +    size_t i;
> > +
> > +    if (len > 0x1000) {
> > +        /* Too large buffer, let's bail out */
> > +        return;
> > +    }
> > +
> > +    for (i =3D 0; i < len; i++) {
> > +        uint8_t val =3D data[i];
> > +        *(hexp++) =3D hexdigit2str(val >> 4);
> > +        *(hexp++) =3D hexdigit2str(val & 0xf);
> > +    }
> > +    *hexp =3D '\0';
>
> Let's move this to: util/hexdump.c
>
> > +
> > +    trace_aes_dump_data(desc, hex);
> > +}
> > +
> > +static bool cmd_data(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0];
> > +    uint32_t ctxt_iv =3D 0;
> > +    uint32_t ctxt_key =3D (cmd & CMD_DATA_KEY_CTX_MASK) >>
> CMD_DATA_KEY_CTX_SHIFT;
> > +    uint32_t len =3D cmd & CMD_DATA_LEN_MASK;
> > +    uint64_t src_addr =3D s->fifo[2];
> > +    uint64_t dst_addr =3D s->fifo[3];
> > +    QCryptoCipherAlgo alg;
> > +    QCryptoCipher *cipher;
> > +    char *src;
> > +    char *dst;
> > +
> > +    src_addr |=3D ((uint64_t)s->fifo[1] << 16) & 0xffff00000000ULL;
> > +    dst_addr |=3D ((uint64_t)s->fifo[1] << 32) & 0xffff00000000ULL;
> > +
> > +    trace_aes_cmd_data(ctxt_key, ctxt_iv, src_addr, dst_addr, len);
> > +
> > +    if (!has_payload(s, 3)) {
> > +        /* wait for payload */
> > +        trace_aes_cmd_data_error("No payload");
>
> Use: LOG_GUEST_ERROR
>
> > +        return false;
> > +    }
> > +
> > +    if (ctxt_key >=3D ARRAY_SIZE(s->key) ||
> > +        ctxt_iv >=3D ARRAY_SIZE(s->iv)) {
> > +        /* Invalid input */
> > +        trace_aes_cmd_data_error("Invalid key or iv");
> > +        return false;
> > +    }
> > +
> > +    src =3D g_malloc0(len);
> > +    dst =3D g_malloc0(len);
> > +
> > +    cpu_physical_memory_read(src_addr, src, len);
>
> Use: dma_memory_read()
>
> > +
> > +    dump_data("cmd_data(): src_data=3D", src, len);
> > +
> > +    switch (s->key[ctxt_key].key_len) {
> > +    case 128 / 8:
> > +        alg =3D QCRYPTO_CIPHER_ALGO_AES_128;
> > +        break;
> > +    case 192 / 8:
> > +        alg =3D QCRYPTO_CIPHER_ALGO_AES_192;
> > +        break;
> > +    case 256 / 8:
> > +        alg =3D QCRYPTO_CIPHER_ALGO_AES_256;
> > +        break;
> > +    default:
> > +        trace_aes_cmd_data_error("Invalid key len");
> > +        goto err_free;
>
> Use g_autoptr instead of goto and g_free().
>
> > +    }
> > +    cipher =3D qcrypto_cipher_new(alg, s->block_mode,
> > +                                (void *)s->key[ctxt_key].key,
> > +                                s->key[ctxt_key].key_len, NULL);
> > +    g_assert(cipher !=3D NULL);
> Handle this error as you do for qcrypto_cipher_setiv(),
> qcrypto_cipher_encrypt() and qcrypto_cipher_decrypt().
>
> > +    if (s->block_mode !=3D QCRYPTO_CIPHER_MODE_ECB) {
> > +        if (qcrypto_cipher_setiv(cipher, (void *)s->iv[ctxt_iv].iv,
> > +                                 sizeof(s->iv[ctxt_iv].iv), NULL) !=3D=
 0)
> {
> > +            trace_aes_cmd_data_error("Failed to set IV");
> > +            goto err_free_cipher;
> > +        }
> > +    }
> > +    if (s->is_encrypt) {
> > +        if (qcrypto_cipher_encrypt(cipher, src, dst, len, NULL) !=3D 0=
) {
> > +            trace_aes_cmd_data_error("Encrypt failed");
> > +            goto err_free_cipher;
> > +        }
> > +    } else {
> > +        if (qcrypto_cipher_decrypt(cipher, src, dst, len, NULL) !=3D 0=
) {
> > +            trace_aes_cmd_data_error("Decrypt failed");
> > +            goto err_free_cipher;
> > +        }
> > +    }
> > +    qcrypto_cipher_free(cipher);
> > +
> > +    dump_data("cmd_data(): dst_data=3D", dst, len);
> > +    cpu_physical_memory_write(dst_addr, dst, len);
> > +    g_free(src);
> > +    g_free(dst);
> > +
> > +    return true;
> > +
> > +err_free_cipher:
> > +    qcrypto_cipher_free(cipher);
> > +err_free:
> > +    g_free(src);
> > +    g_free(dst);
> > +    return false;
> > +}
> > +
> > +static bool cmd_store_iv(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0];
> > +    uint32_t ctxt =3D (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SH=
IFT;
> > +    uint64_t addr =3D s->fifo[1];
> > +
> > +    if (!has_payload(s, 1)) {
> > +        /* wait for payload */
>
> Add a log as it's done for cmd_data().
>
> > +        return false;
> > +    }
> > +
> > +    if (ctxt >=3D ARRAY_SIZE(s->iv)) {
> > +        /* Invalid context selected */
> > +        return false;
> > +    }
> > +
> > +    addr |=3D ((uint64_t)cmd << 32) & 0xff00000000ULL;
> > +    cpu_physical_memory_write(addr, &s->iv[ctxt].iv,
> sizeof(s->iv[ctxt].iv));
> > +
> > +    trace_aes_cmd_store_iv(ctxt, addr, s->iv[ctxt].iv[0],
> s->iv[ctxt].iv[1],
> > +                           s->iv[ctxt].iv[2], s->iv[ctxt].iv[3]);
> > +
> > +    return true;
> > +}
> > +
> > +static bool cmd_flag(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0];
> > +    uint32_t raise_irq =3D cmd & CMD_FLAG_RAISE_IRQ_MASK;
> > +
> > +    /* We always process data when it's coming in, so fire an IRQ
> immediately */
> > +    if (raise_irq) {
> > +        s->irq_status |=3D REG_IRQ_STATUS_FLAG;
> > +    }
> > +
> > +    s->flag_info =3D cmd & CMD_FLAG_INFO_MASK;
> > +
> > +    trace_aes_cmd_flag(!!raise_irq, s->flag_info);
> > +
> > +    return true;
> > +}
> > +
> > +static void fifo_process(AESState *s)
> > +{
> > +    uint32_t cmd =3D s->fifo[0] >> CMD_SHIFT;
> > +    bool success =3D false;
> > +
> > +    if (!s->fifo_idx) {
> > +        return;
> > +    }
> > +
> > +    switch (cmd) {
> > +    case CMD_KEY:
> > +        success =3D cmd_key(s);
> > +        break;
> > +    case CMD_IV:
> > +        success =3D cmd_iv(s);
> > +        break;
> > +    case CMD_DATA:
> > +        success =3D cmd_data(s);
> > +        break;
> > +    case CMD_STORE_IV:
> > +        success =3D cmd_store_iv(s);
> > +        break;
> > +    case CMD_FLAG:
> > +        success =3D cmd_flag(s);
> > +        break;
> > +    default:
> > +        s->irq_status |=3D REG_IRQ_STATUS_INVALID_CMD;
> > +        break;
> > +    }
> > +
> > +    if (success) {
> > +        s->fifo_idx =3D 0;
> > +    }
> > +
> > +    trace_aes_fifo_process(cmd, success ? 1 : 0);
> > +}
> > +
> > +static void aes1_write(void *opaque, hwaddr offset, uint64_t val,
> unsigned size)
> > +{
> > +    AESState *s =3D opaque;
> > +
> > +    trace_aes_write(offset, val);
> > +
> > +    switch (offset) {
> > +    case REG_IRQ_STATUS:
> > +        s->irq_status &=3D ~val;
> > +        break;
> > +    case REG_IRQ_ENABLE:
> > +        s->irq_enable =3D val;
> > +        break;
> > +    case REG_FIFO:
> > +        fifo_append(s, val);
> > +        fifo_process(s);
> > +        break;
> > +    default:
> > +        trace_aes_write_unknown(offset);
> > +        return;
> > +    }
> > +
> > +    aes_update_irq(s);
> > +}
> > +
> > +static const MemoryRegionOps aes1_ops =3D {
> > +    .read =3D aes1_read,
> > +    .write =3D aes1_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static uint64_t aes2_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    uint64_t res =3D 0;
> > +
> > +    switch (offset) {
> > +    case 0:
> > +        res =3D 0;
> > +        break;
> > +    default:
> > +        trace_aes_2_read_unknown(offset);
> > +        break;
> > +    }
> > +
> > +    trace_aes_2_read(offset, res);
> > +
> > +    return res;
> > +}
> > +
> > +static void aes2_write(void *opaque, hwaddr offset, uint64_t val,
> unsigned size)
> > +{
> > +    trace_aes_2_write(offset, val);
> > +
> > +    switch (offset) {
> > +    default:
> > +        trace_aes_2_write_unknown(offset);
> > +        return;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps aes2_ops =3D {
> > +    .read =3D aes2_read,
> > +    .write =3D aes2_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void aes_reset(Object *obj, ResetType type)
> > +{
> > +    AESState *s =3D AES(obj);
> > +
> > +    s->status =3D 0x3f80;
> > +    s->q_status =3D 2;
> > +    s->irq_status =3D 0;
> > +    s->irq_enable =3D 0;
> > +    s->watermark =3D 0;
> > +}
> > +
> > +static void aes_init(Object *obj)
> > +{
> > +    AESState *s =3D AES(obj);
> > +
> > +    memory_region_init_io(&s->iomem1, obj, &aes1_ops, s, TYPE_AES,
> 0x4000);
> > +    memory_region_init_io(&s->iomem2, obj, &aes2_ops, s, TYPE_AES,
> 0x4000);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem1);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem2);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> > +}
> > +
> > +static void aes_realize(DeviceState *dev, Error **errp)
> > +{
> > +}
>
> This shouldn't be necessary.
>
> > +
> > +static void aes_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +
> > +    rc->phases.hold =3D aes_reset;
> > +    dc->realize =3D aes_realize;
> > +}
> > +
> > +static const TypeInfo aes_info =3D {
> > +    .name          =3D TYPE_AES,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(AESState),
> > +    .class_init    =3D aes_class_init,
> > +    .instance_init =3D aes_init,
> > +};
> > +
> > +static void aes_register_types(void)
> > +{
> > +    type_register_static(&aes_info);
> > +}
> > +
> > +type_init(aes_register_types)
> > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> > index e69de29bb2d..bcd4dcb28d2 100644
> > --- a/hw/vmapple/meson.build
> > +++ b/hw/vmapple/meson.build
> > @@ -0,0 +1 @@
> > +system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> > diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> > index 9ccc5790487..1c9a3326eb4 100644
> > --- a/hw/vmapple/trace-events
> > +++ b/hw/vmapple/trace-events
> > @@ -1,2 +1,21 @@
> >   # See docs/devel/tracing.rst for syntax documentation.
> >
> > +# aes.c
> > +aes_read_unknown(uint64_t offset) "offset=3D0x%"PRIx64
> > +aes_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +aes_cmd_key_select_builtin(uint32_t ctx, uint32_t key_id, const char
> *direction, const char *cipher) "[%d] Selecting builtin key %d to %scrypt
> with %s"
> > +aes_cmd_key_select_new(uint32_t ctx, uint32_t key_len, const char
> *direction, const char *cipher) "[%d] Selecting new key size=3D%d to %scr=
ypt
> with %s"
> > +aes_cmd_iv(uint32_t ctx, uint32_t iv0, uint32_t iv1, uint32_t iv2,
> uint32_t iv3) "[%d] 0x%08x 0x%08x 0x%08x 0x%08x"
> > +aes_cmd_data(uint32_t key, uint32_t iv, uint64_t src, uint64_t dst,
> uint32_t len) "[key=3D%d iv=3D%d] src=3D0x%"PRIx64" dst=3D0x%"PRIx64" len=
=3D0x%x"
> > +aes_cmd_data_error(const char *reason) "reason=3D%s"
> > +aes_cmd_store_iv(uint32_t ctx, uint64_t addr, uint32_t iv0, uint32_t
> iv1, uint32_t iv2, uint32_t iv3) "[%d] addr=3D0x%"PRIx64"x -> 0x%08x 0x%0=
8x
> 0x%08x 0x%08x"
> > +aes_cmd_flag(uint32_t raise, uint32_t flag_info) "raise=3D%d
> flag_info=3D0x%x"
> > +aes_fifo_process(uint32_t cmd, uint32_t success) "cmd=3D%d success=3D%=
d"
> > +aes_write_unknown(uint64_t offset) "offset=3D0x%"PRIx64
> > +aes_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +aes_2_read_unknown(uint64_t offset) "offset=3D0x%"PRIx64
> > +aes_2_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +aes_2_write_unknown(uint64_t offset) "offset=3D0x%"PRIx64
> > +aes_2_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +aes_dump_data(const char *desc, const char *hex) "%s%s"
> > +
>
>

--000000000000316da506240aae7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 4 Oct 2024 at 07:32, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; VMApple contains an &quot;aes&quot; engine device that it uses to encr=
ypt and<br>
&gt; decrypt its nvram. It has trivial hard coded keys it uses for that<br>
&gt; purpose.<br>
&gt; <br>
&gt; Add device emulation for this device model.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Phil Dennis-Jordan=C2=A0&lt;<a href=3D"mailto:phil@phi=
ljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream and fixed minor breakages.<br=
>
&gt;=C2=A0 =C2=A0* Replaced legacy device reset method with Resettable meth=
od<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<b=
r>
&gt;=C2=A0 =C2=A0hw/vmapple/aes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 584 ++++++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace-events |=C2=A0 19 ++<br>
&gt;=C2=A0 =C2=A04 files changed, 606 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/aes.c<br>
&gt; <br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index 8b137891791..a73504d5999 100644<br>
&gt; --- a/hw/vmapple/Kconfig<br>
&gt; +++ b/hw/vmapple/Kconfig<br>
&gt; @@ -1 +1,3 @@<br>
&gt; +config VMAPPLE_AES<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..074fbdd9c36<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/vmapple/aes.c<br>
&gt; @@ -0,0 +1,584 @@<br>
&gt; +/*<br>
&gt; + * QEMU Apple AES device emulation<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;crypto/hash.h&quot;<br>
&gt; +#include &quot;crypto/aes.h&quot;<br>
&gt; +#include &quot;crypto/cipher.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_AES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;apple-aes&qu=
ot;<br>
&gt; +#define MAX_FIFO_SIZE=C2=A0 =C2=A0 =C2=A09<br>
&gt; +<br>
&gt; +#define CMD_KEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br>
&gt; +#define CMD_KEY_CONTEXT_SHIFT=C2=A0 =C2=A0 27<br>
&gt; +#define CMD_KEY_CONTEXT_MASK=C2=A0 =C2=A0 =C2=A0(0x1 &lt;&lt; CMD_KEY=
_CONTEXT_SHIFT)<br>
&gt; +#define CMD_KEY_SELECT_SHIFT=C2=A0 =C2=A0 =C2=A024<br>
&gt; +#define CMD_KEY_SELECT_MASK=C2=A0 =C2=A0 =C2=A0 (0x7 &lt;&lt; CMD_KEY=
_SELECT_SHIFT)<br>
&gt; +#define CMD_KEY_KEY_LEN_SHIFT=C2=A0 =C2=A0 22<br>
&gt; +#define CMD_KEY_KEY_LEN_MASK=C2=A0 =C2=A0 =C2=A0(0x3 &lt;&lt; CMD_KEY=
_KEY_LEN_SHIFT)<br>
&gt; +#define CMD_KEY_ENCRYPT_SHIFT=C2=A0 =C2=A0 20<br>
&gt; +#define CMD_KEY_ENCRYPT_MASK=C2=A0 =C2=A0 =C2=A0(0x1 &lt;&lt; CMD_KEY=
_ENCRYPT_SHIFT)<br>
&gt; +#define CMD_KEY_BLOCK_MODE_SHIFT 16<br>
&gt; +#define CMD_KEY_BLOCK_MODE_MASK=C2=A0 (0x3 &lt;&lt; CMD_KEY_BLOCK_MOD=
E_SHIFT)<br>
&gt; +#define CMD_IV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2<br>
&gt; +#define CMD_IV_CONTEXT_SHIFT=C2=A0 =C2=A0 =C2=A026<br>
&gt; +#define CMD_IV_CONTEXT_MASK=C2=A0 =C2=A0 =C2=A0 (0x3 &lt;&lt; CMD_KEY=
_CONTEXT_SHIFT)<br>
&gt; +#define CMD_DSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3<br>
&gt; +#define CMD_SKG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt; +#define CMD_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x5<br>
&gt; +#define CMD_DATA_KEY_CTX_SHIFT=C2=A0 =C2=A027<br>
&gt; +#define CMD_DATA_KEY_CTX_MASK=C2=A0 =C2=A0 (0x1 &lt;&lt; CMD_DATA_KEY=
_CTX_SHIFT)<br>
&gt; +#define CMD_DATA_IV_CTX_SHIFT=C2=A0 =C2=A0 25<br>
&gt; +#define CMD_DATA_IV_CTX_MASK=C2=A0 =C2=A0 =C2=A0(0x3 &lt;&lt; CMD_DAT=
A_IV_CTX_SHIFT)<br>
&gt; +#define CMD_DATA_LEN_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xffffff<br>
&gt; +#define CMD_STORE_IV=C2=A0 =C2=A0 =C2=A0 0x6<br>
&gt; +#define CMD_STORE_IV_ADDR_MASK=C2=A0 =C2=A00xffffff<br>
&gt; +#define CMD_WRITE_REG=C2=A0 =C2=A0 =C2=A00x7<br>
&gt; +#define CMD_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +#define CMD_FLAG_STOP_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(26)<br>
&gt; +#define CMD_FLAG_RAISE_IRQ_MASK=C2=A0 BIT(27)<br>
&gt; +#define CMD_FLAG_INFO_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00xff<br>
&gt; +#define CMD_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
&gt; +<br>
&gt; +#define CMD_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028<br>
&gt; +<br>
&gt; +#define REG_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc<br>
&gt; +#define REG_STATUS_DMA_READ_RUNNING=C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define REG_STATUS_DMA_READ_PENDING=C2=A0 =C2=A0 =C2=A0BIT(1)<br>
&gt; +#define REG_STATUS_DMA_WRITE_RUNNING=C2=A0 =C2=A0 BIT(2)<br>
&gt; +#define REG_STATUS_DMA_WRITE_PENDING=C2=A0 =C2=A0 BIT(3)<br>
&gt; +#define REG_STATUS_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt; +#define REG_STATUS_EXECUTING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(5)<br>
&gt; +#define REG_STATUS_READY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BIT(6)<br>
&gt; +#define REG_STATUS_TEXT_DPA_SEEDED=C2=A0 =C2=A0 =C2=A0 BIT(7)<br>
&gt; +#define REG_STATUS_UNWRAP_DPA_SEEDED=C2=A0 =C2=A0 BIT(8)<br>
&gt; +<br>
&gt; +#define REG_IRQ_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>
&gt; +#define REG_IRQ_STATUS_INVALID_CMD=C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
&gt; +#define REG_IRQ_STATUS_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0BIT(5)<br>
&gt; +#define REG_IRQ_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1c<br>
&gt; +#define REG_WATERMARK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x20<br>
&gt; +#define REG_Q_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24<br>
&gt; +#define REG_FLAG_INFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x30<br>
&gt; +#define REG_FIFO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20=
0<br>
&gt; +<br>
&gt; +static const uint32_t key_lens[4] =3D {<br>
<br>
I suggest deriving the size from CMD_KEY_KEY_LEN_MASK.<br>
<br>
&gt; +=C2=A0 =C2=A0 [0] =3D 16,<br>
&gt; +=C2=A0 =C2=A0 [1] =3D 24,<br>
&gt; +=C2=A0 =C2=A0 [2] =3D 32,<br>
&gt; +=C2=A0 =C2=A0 [3] =3D 64,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct key {<br>
<br>
Please add typedef.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint32_t key_len;<br>
&gt; +=C2=A0 =C2=A0 uint32_t key[8];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct iv {<br>
&gt; +=C2=A0 =C2=A0 uint32_t iv[4];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct context {<br>
&gt; +=C2=A0 =C2=A0 struct key key;<br>
&gt; +=C2=A0 =C2=A0 struct iv iv;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct key builtin_keys[7] =3D {<br>
=C2=A0&gt; +=C2=A0 =C2=A0 [1] =3D {&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key_l=
en =3D 32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key =3D { 0x1 },<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 [2] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key_len =3D 32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key =3D { 0x2 },<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 [3] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key_len =3D 32,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key =3D { 0x3 },<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct AESState {<br>
&gt; +=C2=A0 =C2=A0 /* Private */<br>
<br>
This private/public comments are unnecessary; this struct can be <br>
referenced only from this file and all members are automatically private.<b=
r>
<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Public */<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem1;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem2;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t status;<br>
&gt; +=C2=A0 =C2=A0 uint32_t q_status;<br>
&gt; +=C2=A0 =C2=A0 uint32_t irq_status;<br>
&gt; +=C2=A0 =C2=A0 uint32_t irq_enable;<br>
&gt; +=C2=A0 =C2=A0 uint32_t watermark;<br>
&gt; +=C2=A0 =C2=A0 uint32_t flag_info;<br>
&gt; +=C2=A0 =C2=A0 uint32_t fifo[MAX_FIFO_SIZE];<br>
&gt; +=C2=A0 =C2=A0 uint32_t fifo_idx;<br>
&gt; +=C2=A0 =C2=A0 struct key key[2];<br>
&gt; +=C2=A0 =C2=A0 struct iv iv[4];<br>
&gt; +=C2=A0 =C2=A0 bool is_encrypt;<br>
&gt; +=C2=A0 =C2=A0 QCryptoCipherMode block_mode;<br>
&gt; +} AESState;<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AESState, AES)<br>
&gt; +<br>
&gt; +static void aes_update_irq(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, !!(s-&gt;irq_status &amp; s-&gt=
;irq_enable));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t aes1_read(void *opaque, hwaddr offset, unsigned size)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AESState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint64_t res =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_IRQ_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;irq_status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_IRQ_ENABLE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;irq_enable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_WATERMARK:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;watermark;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_Q_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;q_status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_FLAG_INFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;flag_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_read_unknown(offset);<br>
<br>
Use: LOG_UNIMP<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_read(offset, res);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void fifo_append(AESState *s, uint64_t val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;fifo_idx =3D=3D MAX_FIFO_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Exceeded the FIFO. Bail out */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;fifo[s-&gt;fifo_idx++] =3D val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool has_payload(AESState *s, uint32_t elems)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;fifo_idx &gt;=3D (elems + 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cmd_key(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0];<br>
&gt; +=C2=A0 =C2=A0 uint32_t key_select =3D (cmd &amp; CMD_KEY_SELECT_MASK)=
 &gt;&gt; CMD_KEY_SELECT_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctxt =3D (cmd &amp; CMD_KEY_CONTEXT_MASK) &gt;=
&gt; CMD_KEY_CONTEXT_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 uint32_t key_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch ((cmd &amp; CMD_KEY_BLOCK_MODE_MASK) &gt;&gt; CM=
D_KEY_BLOCK_MODE_SHIFT) {<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;block_mode =3D QCRYPTO_CIPHER_MODE_=
ECB;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;block_mode =3D QCRYPTO_CIPHER_MODE_=
CBC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;is_encrypt =3D !!((cmd &amp; CMD_KEY_ENCRYPT_MASK=
) &gt;&gt; CMD_KEY_ENCRYPT_SHIFT);<br>
<br>
CMD_KEY_ENCRYPT_SHIFT is unnecessary as in case of <br>
CMD_FLAG_RAISE_IRQ_MASK. &quot;!!&quot; is also unnecessary; it will be imp=
licitly <br>
casted into bool.<br>
<br>
&gt; +=C2=A0 =C2=A0 key_len =3D key_lens[((cmd &amp; CMD_KEY_KEY_LEN_MASK) =
&gt;&gt; CMD_KEY_KEY_LEN_SHIFT)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (key_select) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_key_select_builtin(ctxt, ke=
y_select,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;is_encrypt ? &quot;en&quot; : &quot;de&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0QCryptoCipherMode_str(s-&gt;block_mode));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;key[ctxt] =3D builtin_keys[key_sele=
ct];<br>
<br>
I guess this should be: builtin_keys[key_select - 1]<br></blockquote><div><=
br></div><div>I don&#39;t think it should: the builtin keys start at index =
1. This seems fine, and I&#39;d rather leave the indices alone to avoid nee=
ding to do arithmetic on them. However in that case, builtin_keys needs to =
have 8 elements not 7 as it currently does to avoid overflow. I&#39;ll fix =
this and use  symbolic constants.</div><div><br></div><div>(Thanks for the =
other review comments, I&#39;ve reworked those parts for v4.)<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_key_select_new(ctxt, key_le=
n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;is_enc=
rypt ? &quot;en&quot; : &quot;de&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCryptoCiphe=
rMode_str(s-&gt;block_mode));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (key_len &gt; sizeof(s-&gt;key[ctxt].k=
ey)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_payload(s, key_len / sizeof(uint=
32_t))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* wait for payload */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;s-&gt;key[ctxt].key, &amp;s-&=
gt;fifo[1], key_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;key[ctxt].key_len =3D key_len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cmd_iv(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0];<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctxt =3D (cmd &amp; CMD_IV_CONTEXT_MASK) &gt;&=
gt; CMD_IV_CONTEXT_SHIFT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!has_payload(s, 4)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* wait for payload */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 memcpy(&amp;s-&gt;iv[ctxt].iv, &amp;s-&gt;fifo[1], size=
of(s-&gt;iv[ctxt].iv));<br>
&gt; +=C2=A0 =C2=A0 trace_aes_cmd_iv(ctxt, s-&gt;fifo[1], s-&gt;fifo[2], s-=
&gt;fifo[3], s-&gt;fifo[4]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static char hexdigit2str(uint8_t val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_assert(val &lt; 0x10);<br>
&gt; +=C2=A0 =C2=A0 if (val &gt;=3D 0xa) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;a&#39; + (val - 0xa);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &#39;0&#39; + val;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void dump_data(const char *desc, const void *p, size_t len)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char *hex =3D alloca((len * 2) + 1);<br>
<br>
Don&#39;t use alloca(); use a fixed-length array instead.<br>
<br>
&gt; +=C2=A0 =C2=A0 const uint8_t *data =3D p;<br>
&gt; +=C2=A0 =C2=A0 char *hexp =3D hex;<br>
&gt; +=C2=A0 =C2=A0 size_t i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (len &gt; 0x1000) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Too large buffer, let&#39;s bail out *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; len; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t val =3D data[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(hexp++) =3D hexdigit2str(val &gt;&gt; 4=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(hexp++) =3D hexdigit2str(val &amp; 0xf)=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 *hexp =3D &#39;\0&#39;;<br>
<br>
Let&#39;s move this to: util/hexdump.c<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_dump_data(desc, hex);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cmd_data(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0];<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctxt_iv =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctxt_key =3D (cmd &amp; CMD_DATA_KEY_CTX_MASK)=
 &gt;&gt; CMD_DATA_KEY_CTX_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 uint32_t len =3D cmd &amp; CMD_DATA_LEN_MASK;<br>
&gt; +=C2=A0 =C2=A0 uint64_t src_addr =3D s-&gt;fifo[2];<br>
&gt; +=C2=A0 =C2=A0 uint64_t dst_addr =3D s-&gt;fifo[3];<br>
&gt; +=C2=A0 =C2=A0 QCryptoCipherAlgo alg;<br>
&gt; +=C2=A0 =C2=A0 QCryptoCipher *cipher;<br>
&gt; +=C2=A0 =C2=A0 char *src;<br>
&gt; +=C2=A0 =C2=A0 char *dst;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 src_addr |=3D ((uint64_t)s-&gt;fifo[1] &lt;&lt; 16) &am=
p; 0xffff00000000ULL;<br>
&gt; +=C2=A0 =C2=A0 dst_addr |=3D ((uint64_t)s-&gt;fifo[1] &lt;&lt; 32) &am=
p; 0xffff00000000ULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_cmd_data(ctxt_key, ctxt_iv, src_addr, dst_add=
r, len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!has_payload(s, 3)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* wait for payload */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&quot;No payload=
&quot;);<br>
<br>
Use: LOG_GUEST_ERROR<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ctxt_key &gt;=3D ARRAY_SIZE(s-&gt;key) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctxt_iv &gt;=3D ARRAY_SIZE(s-&gt;iv)) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Invalid input */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&quot;Invalid ke=
y or iv&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 src =3D g_malloc0(len);<br>
&gt; +=C2=A0 =C2=A0 dst =3D g_malloc0(len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_read(src_addr, src, len);<br>
<br>
Use: dma_memory_read()<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dump_data(&quot;cmd_data(): src_data=3D&quot;, src, len=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (s-&gt;key[ctxt_key].key_len) {<br>
&gt; +=C2=A0 =C2=A0 case 128 / 8:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alg =3D QCRYPTO_CIPHER_ALGO_AES_128;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 192 / 8:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alg =3D QCRYPTO_CIPHER_ALGO_AES_192;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 256 / 8:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alg =3D QCRYPTO_CIPHER_ALGO_AES_256;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&quot;Invalid ke=
y len&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free;<br>
<br>
Use g_autoptr instead of goto and g_free().<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 cipher =3D qcrypto_cipher_new(alg, s-&gt;block_mode,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)s-&gt;key[ctxt_key].key,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;key[ctxt_key].key_len, NUL=
L);<br>
&gt; +=C2=A0 =C2=A0 g_assert(cipher !=3D NULL);<br>
Handle this error as you do for qcrypto_cipher_setiv(), <br>
qcrypto_cipher_encrypt() and qcrypto_cipher_decrypt().<br>
<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;block_mode !=3D QCRYPTO_CIPHER_MODE_ECB) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qcrypto_cipher_setiv(cipher, (void *)=
s-&gt;iv[ctxt_iv].iv,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(s-&gt;iv[ctxt_iv].i=
v), NULL) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&q=
uot;Failed to set IV&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_cipher;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;is_encrypt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qcrypto_cipher_encrypt(cipher, src, d=
st, len, NULL) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&q=
uot;Encrypt failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_cipher;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qcrypto_cipher_decrypt(cipher, src, d=
st, len, NULL) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_cmd_data_error(&q=
uot;Decrypt failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_cipher;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qcrypto_cipher_free(cipher);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dump_data(&quot;cmd_data(): dst_data=3D&quot;, dst, len=
);<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_write(dst_addr, dst, len);<br>
&gt; +=C2=A0 =C2=A0 g_free(src);<br>
&gt; +=C2=A0 =C2=A0 g_free(dst);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; +err_free_cipher:<br>
&gt; +=C2=A0 =C2=A0 qcrypto_cipher_free(cipher);<br>
&gt; +err_free:<br>
&gt; +=C2=A0 =C2=A0 g_free(src);<br>
&gt; +=C2=A0 =C2=A0 g_free(dst);<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cmd_store_iv(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0];<br>
&gt; +=C2=A0 =C2=A0 uint32_t ctxt =3D (cmd &amp; CMD_IV_CONTEXT_MASK) &gt;&=
gt; CMD_IV_CONTEXT_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 uint64_t addr =3D s-&gt;fifo[1];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!has_payload(s, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* wait for payload */<br>
<br>
Add a log as it&#39;s done for cmd_data().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ctxt &gt;=3D ARRAY_SIZE(s-&gt;iv)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Invalid context selected */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 addr |=3D ((uint64_t)cmd &lt;&lt; 32) &amp; 0xff0000000=
0ULL;<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_write(addr, &amp;s-&gt;iv[ctxt].iv,=
 sizeof(s-&gt;iv[ctxt].iv));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_cmd_store_iv(ctxt, addr, s-&gt;iv[ctxt].iv[0]=
, s-&gt;iv[ctxt].iv[1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;iv[ctxt].iv[2], s-&gt;iv[ctxt].iv[3]);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cmd_flag(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0];<br>
&gt; +=C2=A0 =C2=A0 uint32_t raise_irq =3D cmd &amp; CMD_FLAG_RAISE_IRQ_MAS=
K;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* We always process data when it&#39;s coming in, so f=
ire an IRQ immediately */<br>
&gt; +=C2=A0 =C2=A0 if (raise_irq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status |=3D REG_IRQ_STATUS_FLAG=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;flag_info =3D cmd &amp; CMD_FLAG_INFO_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_cmd_flag(!!raise_irq, s-&gt;flag_info);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void fifo_process(AESState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd =3D s-&gt;fifo[0] &gt;&gt; CMD_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 bool success =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;fifo_idx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (cmd) {<br>
&gt; +=C2=A0 =C2=A0 case CMD_KEY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D cmd_key(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CMD_IV:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D cmd_iv(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CMD_DATA:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D cmd_data(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CMD_STORE_IV:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D cmd_store_iv(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CMD_FLAG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D cmd_flag(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status |=3D REG_IRQ_STATUS_INVA=
LID_CMD;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (success) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fifo_idx =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_fifo_process(cmd, success ? 1 : 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aes1_write(void *opaque, hwaddr offset, uint64_t val, uns=
igned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AESState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_write(offset, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_IRQ_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_status &amp;=3D ~val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_IRQ_ENABLE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_enable =3D val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_FIFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo_append(s, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo_process(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_write_unknown(offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aes_update_irq(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps aes1_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D aes1_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D aes1_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static uint64_t aes2_read(void *opaque, hwaddr offset, unsigned size)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t res =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_2_read_unknown(offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aes_2_read(offset, res);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aes2_write(void *opaque, hwaddr offset, uint64_t val, uns=
igned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 trace_aes_2_write(offset, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aes_2_write_unknown(offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps aes2_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D aes2_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D aes2_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aes_reset(Object *obj, ResetType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AESState *s =3D AES(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;status =3D 0x3f80;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;q_status =3D 2;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;irq_status =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;irq_enable =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;watermark =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aes_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AESState *s =3D AES(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem1, obj, &amp;aes1=
_ops, s, TYPE_AES, 0x4000);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem2, obj, &amp;aes2=
_ops, s, TYPE_AES, 0x4000);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &amp;s-&gt;iomem1);=
<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(s), &amp;s-&gt;iomem2);=
<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(SYS_BUS_DEVICE(s), &amp;s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aes_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +}<br>
<br>
This shouldn&#39;t be necessary.<br>
<br>
&gt; +<br>
&gt; +static void aes_class_init(ObjectClass *klass, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold =3D aes_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D aes_realize;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo aes_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AES,<b=
r>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AESState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D aes_class_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D aes_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aes_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;aes_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(aes_register_types)<br>
&gt; diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build<br>
&gt; index e69de29bb2d..bcd4dcb28d2 100644<br>
&gt; --- a/hw/vmapple/meson.build<br>
&gt; +++ b/hw/vmapple/meson.build<br>
&gt; @@ -0,0 +1 @@<br>
&gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_AES&#39;,=C2=A0 if_true: file=
s(&#39;aes.c&#39;))<br>
&gt; diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events<br>
&gt; index 9ccc5790487..1c9a3326eb4 100644<br>
&gt; --- a/hw/vmapple/trace-events<br>
&gt; +++ b/hw/vmapple/trace-events<br>
&gt; @@ -1,2 +1,21 @@<br>
&gt;=C2=A0 =C2=A0# See docs/devel/tracing.rst for syntax documentation.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# aes.c<br>
&gt; +aes_read_unknown(uint64_t offset) &quot;offset=3D0x%&quot;PRIx64<br>
&gt; +aes_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&quot;PRIx6=
4&quot; res=3D0x%&quot;PRIx64<br>
&gt; +aes_cmd_key_select_builtin(uint32_t ctx, uint32_t key_id, const char =
*direction, const char *cipher) &quot;[%d] Selecting builtin key %d to %scr=
ypt with %s&quot;<br>
&gt; +aes_cmd_key_select_new(uint32_t ctx, uint32_t key_len, const char *di=
rection, const char *cipher) &quot;[%d] Selecting new key size=3D%d to %scr=
ypt with %s&quot;<br>
&gt; +aes_cmd_iv(uint32_t ctx, uint32_t iv0, uint32_t iv1, uint32_t iv2, ui=
nt32_t iv3) &quot;[%d] 0x%08x 0x%08x 0x%08x 0x%08x&quot;<br>
&gt; +aes_cmd_data(uint32_t key, uint32_t iv, uint64_t src, uint64_t dst, u=
int32_t len) &quot;[key=3D%d iv=3D%d] src=3D0x%&quot;PRIx64&quot; dst=3D0x%=
&quot;PRIx64&quot; len=3D0x%x&quot;<br>
&gt; +aes_cmd_data_error(const char *reason) &quot;reason=3D%s&quot;<br>
&gt; +aes_cmd_store_iv(uint32_t ctx, uint64_t addr, uint32_t iv0, uint32_t =
iv1, uint32_t iv2, uint32_t iv3) &quot;[%d] addr=3D0x%&quot;PRIx64&quot;x -=
&gt; 0x%08x 0x%08x 0x%08x 0x%08x&quot;<br>
&gt; +aes_cmd_flag(uint32_t raise, uint32_t flag_info) &quot;raise=3D%d fla=
g_info=3D0x%x&quot;<br>
&gt; +aes_fifo_process(uint32_t cmd, uint32_t success) &quot;cmd=3D%d succe=
ss=3D%d&quot;<br>
&gt; +aes_write_unknown(uint64_t offset) &quot;offset=3D0x%&quot;PRIx64<br>
&gt; +aes_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&quot;PRIx=
64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +aes_2_read_unknown(uint64_t offset) &quot;offset=3D0x%&quot;PRIx64<br=
>
&gt; +aes_2_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&quot;PRI=
x64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +aes_2_write_unknown(uint64_t offset) &quot;offset=3D0x%&quot;PRIx64<b=
r>
&gt; +aes_2_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&quot;PR=
Ix64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +aes_dump_data(const char *desc, const char *hex) &quot;%s%s&quot;<br>
&gt; +<br>
<br>
</blockquote></div></div>

--000000000000316da506240aae7a--

