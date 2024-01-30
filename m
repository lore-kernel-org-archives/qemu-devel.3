Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D6FC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUsDy-0008Q6-IG; Tue, 30 Jan 2024 12:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsDx-0008Pm-5d
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:48:41 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsDu-0001xe-TA
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:48:40 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d040a62a76so29152301fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706636917; x=1707241717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ajcHImPHMG5j+T6mgo3IE1RNBq4zS9VSGtDNA+nOrE=;
 b=ncQkRzqS85l8eakvu6b8A36BzP9A9rFWX23a8SwAid0MDF+WxRUJWWIskAtoMxagaX
 9I7CYjVYMBUFCeK/Tn/Jk4aDscjyooKDWVDXqcoihz/AqGT0fhsegolxezHae68CdZtD
 DHzZWcG77MzX1Kz58kllkblKlL9Vx+f+hRrXx4w8aFXFQ5Vk0eklbV66iu6lZlhK+XaG
 tfxFR0rMblLQSQmcJR6EmecvRbghSjSP80aCtHoAsorjN8Dfj3sSjzbu853S9ex/PGsV
 GyiwM+qO3w5v+6dt5hT0dUYZGID86uV1Kw4khkXQMjAe+S2xeMpA1wEFopGmjB1Arkqb
 pLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706636917; x=1707241717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ajcHImPHMG5j+T6mgo3IE1RNBq4zS9VSGtDNA+nOrE=;
 b=dmgfM+E4t+yKhJSpBaRz4p/V8QfbOosxNRa/YKdYb5MiwPUrH4d5QAVXqe9Na+zL6R
 SXrbMyrG7RSszzZIQoCFjP/CTlIGpXx8hienZZezjSkZe4Ix+c3ui63QbZuiZzllzDt0
 mZaUtm9tZkG1aCeLkD8AWEq96DBz/mQMSUU5t91Dk9/TNjiCNZ61FvGQjy5tOGTcM2ps
 TOyYK1GpjSP8LRAJKMks7BMhk5btF37XuzGPg6CRlqolRaCxYGQGdYFHfHDBEtI2f35+
 vYUGYA0a4uRwTsx0yF2FcAZr6HLYgakPISf0vpwIvoV9U9z4tiY625VStUee+uOWP3Wn
 gl8g==
X-Gm-Message-State: AOJu0Yyx8U1SZXCZ0eDIdnCeLJFGOSqzDz40wubMX27Za6ibOHmiSNUY
 VL5dSJGouyD/2tj0ugAORRyRflQl3dUhd01YqeLXteVQ+9cExlAO0VRKoAIWdu2YnyWLoLU7SoN
 nq3jyauRYxq1IdcvzB9BtlwLDxSWFU0dQ6CbCsg==
X-Google-Smtp-Source: AGHT+IE8+y4spQ+a2Emh84h7nE7IJYsiMzT726kmrTPgGImbgzJ+0htDmX0SOPT1Sxtpf0nl82hWku6OFIN+U/NDzy0=
X-Received: by 2002:a05:651c:14f:b0:2cd:fafc:1700 with SMTP id
 c15-20020a05651c014f00b002cdfafc1700mr5411843ljd.53.1706636916836; Tue, 30
 Jan 2024 09:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20240125194247.1589037-1-nabihestefan@google.com>
 <20240125194247.1589037-2-nabihestefan@google.com>
In-Reply-To: <20240125194247.1589037-2-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 17:48:25 +0000
Message-ID: <CAFEAcA94oEX6Rc9Gf7QPgNWjhhXfP4mXoacJmurbSF0h0U7ybA@mail.gmail.com>
Subject: Re: [PATCH v15 1/9] hw/misc: Add Nuvoton's PCI Mailbox Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 25 Jan 2024 at 19:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> The PCI Mailbox Module is a high-bandwidth communcation module
> between a Nuvoton BMC and CPU. It features 16KB RAM that are both
> accessible by the BMC and core CPU. and supports interrupt for
> both sides.
>
> This patch implements the BMC side of the PCI mailbox module.
> Communication with the core CPU is emulated via a chardev and
> will be in a follow-up patch.
>
> This patch also adds documentation on the PCIe Protocol used
> by the chardev device.
>
> Change-Id: Iaca22f81c4526927d437aa367079ed038faf43f2
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  docs/specs/pci_mbox_chardev.rst    | 159 ++++++++++++++

Sphinx insists that every .rst file under docs
is specifically listed in a table of contents somewhere.
In this case that means you should list the new file
in docs/specs/index.rst.

If you configure with '--enable-docs' that should ensure
that you have all the prerequisites to build the documentation
and you ought then to get an error message during build
about the missing toc entry problem, so you can be sure you've
fixed it correctly.

You'll also find that there are other markup syntax errors you
need to fix (eg on my system sphinx complains
"pci_mbox_chardev.rst:29:Unexpected indentation.").

You should also look at the generated HTML to make sure
it renders as you expect it to. I suspect that your ascii-art
diagrams of the protocol packets are not going to render
correctly as they stand.

>  hw/misc/meson.build                |   1 +
>  hw/misc/npcm7xx_pci_mbox.c         | 335 +++++++++++++++++++++++++++++
>  hw/misc/trace-events               |   5 +
>  include/hw/misc/npcm7xx_pci_mbox.h |  81 +++++++
>  5 files changed, 581 insertions(+)
>  create mode 100644 docs/specs/pci_mbox_chardev.rst
>  create mode 100644 hw/misc/npcm7xx_pci_mbox.c
>  create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
>
> diff --git a/docs/specs/pci_mbox_chardev.rst b/docs/specs/pci_mbox_chardev.rst
> new file mode 100644
> index 0000000000..2a26e6bb8f
> --- /dev/null
> +++ b/docs/specs/pci_mbox_chardev.rst
> @@ -0,0 +1,159 @@
> +Remote PCIe Protocol
> +====================
> +
> +Design
> +------
> +The communication or this device is done via a chardev. It is bidirectional:

"of" ?

> +QEMU can send requests to devices and the device can send MSI/DMA requests
> +to QEMU. All registers are encoded in Little Endian.

Lower case for "little endian".

> +
> +To distinguish between the two types of messages, any message with an error
> +code described below is a response, otherwise it is a request. The remote
> +PCIe device is responsible for guaranteeing the messages sent out are
> +integrated.

What does it mean to "integrate" a message ?

> +
> +The highest bit for the first byte reflects whether a message is a request
> +or response - 0 for request and 1 for response.
> +
> +For responses, the rest of the bits reflect the error code.
> +For requests, the rest of the bit is the command code specified below.
> +
> +
> +Initialization
> +--------------
> +During initialization of the remote PCIe device in QEMU, it needs to specify
> +a few configuration parameters. The PCIe connector is responsible for
> +getting these configuration parameters and passing them in as QDev
> +properties
> +The fields include:
> + 1. PCI endpoint device identifiers (google3/platforms/asic_sw/proto/device_identifiers.proto).

A google internal filename isn't much use to the rest of us :-)

> +     a. Vendor ID
> +     b. Device ID
> +     c. Subsystem Vendor ID
> +     d. Subsystem Device ID
> +     e. Class Code
> +     f. Subclass
> +     g. Programming Interface
> +     h. Revision ID
> + 2. Number of BARs and the size of each BAR
> + 3. Whether DMA is supported.
> + 4. Number of MSI vectors supported (must be power of 2, up to 32)
> +
> +Request and Reponse Breakdowns
> +------------------------------
> +PCI Endpoint R/W Request
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +QEMU can send this request to endpoint.
> +ReadData
> +Request:
> ++------+------+--------+-----------+-----------+
> +| Byte | 0    | 0x1    | 0x2 ~ 0x9 | 0xa       |
> +| Data | 0x01 | bar_no | offset    | read_size |
> ++------+------+--------+-----------+-----------+
> +(read_size in number of bytes, must be between 1 and 8)
> +Response:
> +Success:
> ++------+------+-------------------+
> +| Byte | 0    | 0x1 ~ read_size+1 |
> +| Data | 0x80 | data              |
> ++------+------+-------------------+
> +Failure:
> ++------+-------------------+
> +| Byte | 0                 |
> +| Data | 0x80 | error_code |
> ++------+-------------------+

This doesn't seem to match what your test code does:
it sends an OP_READ 0x1 then a 4-byte offset then
a 1 byte size, with no "bar_no" field. Also there seems
to be some confusion of direction here -- the test
case is sending this command to QEMU, not receiving it
from QEMU.

You also don't seem to define what valid error codes are.

> +
> +WriteData
> +Request:
> ++------+------+--------+-----------+------------+------+
> +| Byte | 0    | 0x1    | 0x2 ~ 0x9 | 0xa        | 0xb~ |
> +| Data | 0x02 | bar_no | offset    | write_size | data |
> ++------+------+--------+-----------+------------+------+
> +(write_size in number of bytes, must be between 1 and 8)
> +Response:
> ++------+-------------------+
> +| Byte | 0                 |
> +| Data | 0x80 | error_code |
> ++------+-------------------+

Similarly the test code does not send a bar_no when it
does an OP_WRITE.

This version of your patches still do not pass "make check"
on a big-endian host:

# random seed: R02Sa53abdba65b5f469bda76c1ea679af7e
# port=51945
# starting QEMU: exec ./build/aarch64/qemu-system-aarch64 -qtest
unix:/tmp/qtest-1105084.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-1105084.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine
npcm750-evb -chardev
socket,id=npcm7xx-pcimbox-chr,host=localhost,port=51945,reconnect=10
-global driver=npcm7xx-pci-mbox,property=chardev,value=npcm7xx-pcimbox-chr
-accel qtest
1..3
# Start of aarch64 tests
# Start of npcm7xx_pci_mbox tests
ok 1 /aarch64/npcm7xx_pci_mbox/invalid_op
# sending 8 bytes
# response code: 0
# sending 4 bytes
# response code: 0
ok 2 /aarch64/npcm7xx_pci_mbox/read
# receiving 8 bytes
# response code: 0
# receiving 4 bytes
# response code: 0
**
ERROR:../../tests/qtest/npcm7xx_pci_mbox-test.c:215:test_guest_write:
assertion failed (strncmp(data, buf, len) == 0): (-1 == 0)
Bail out! ERROR:../../tests/qtest/npcm7xx_pci_mbox-test.c:215:test_guest_write:
assertion failed (strncmp(data, buf, len) == 0): (-1 == 0)
Aborted (core dumped)

Please find a big-endian system and make sure that "make check"
passes on it before submitting the next round of this patchset.


I think the reason for the failure is:

> +static void npcm7xx_pci_mbox_send_response(NPCM7xxPCIMBoxState *s, uint8_t code)
> +{
> +    qemu_chr_fe_write(&s->chr, &code, 1);
> +    if (code == NPCM7XX_PCI_MBOX_OK && s->op == NPCM7XX_PCI_MBOX_OP_READ) {
> +        qemu_chr_fe_write(&s->chr, (uint8_t *)(&s->data), s->size);

s->data is a uint64_t field, but here we cast its address
to a uint8_t* and then send that data directly out to the
chardev. That will send different data depending on the endianness
of the host. You need to send the s->size low-order bits
of s->data in little endian order, if that's what your protocol
spec defines, which you aren't doing.

Also, if you call qemu_chr_fe_write() you need to handle
the return value. This is a *non-blocking* write, and it
returns the number of bytes it managed to write. If this is
less then you asked for then you need to arrange to try again
later to write the rest of the data (eg using qemu_chr_fe_add_watch()
to arrange for a callback when the chardev frontend is ready
to accept more data).

(If working with the non-blocking write is really impossible,
then the blocking function is qemu_chr_fe_write_all(), but that
then has the possibility of hanging QEMU if the thing on the
other end of the chardev doesn't ever read the data.)

> +    }
> +}
> +
> +static void npcm7xx_pci_mbox_handle_read(NPCM7xxPCIMBoxState *s)
> +{
> +    uint8_t offset_bytes[4];
> +    MemTxResult r = memory_region_dispatch_read(
> +        &s->ram, s->offset, &s->data, MO_LE | size_memop(s->size),
> +        MEMTXATTRS_UNSPECIFIED);
> +
> +    stl_le_p(offset_bytes, r);

This is really weird. MemTxResult is a QEMU internal value
which tells you whether the transfer succeded or not, but we
do a byteswap to LE on it and then look at the least significant
byte in the array. That ends up with exactly the same thing that
you could have got by just passing 'r' as the argument to
npcm7xx_pci_mbox_send_response(). But you don't want to do
that anyway, because MemTxResult is a QEMU internal type, and you
need to convert from that to whatever your protocol defines as the
permitted/valid error/success values.

> +    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);
> +}
> +
> +static void npcm7xx_pci_mbox_handle_write(NPCM7xxPCIMBoxState *s)
> +{
> +    uint8_t offset_bytes[4];
> +    MemTxResult r = memory_region_dispatch_write(
> +        &s->ram, s->offset, s->data, MO_LE | size_memop(s->size),
> +        MEMTXATTRS_UNSPECIFIED);
> +
> +    stl_le_p(offset_bytes, r);
> +    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);

Same remarks here about weird use of stl_le_p().

> +}

> +static const VMStateDescription vmstate_npcm7xx_pci_mbox = {
> +    .name = "npcm7xx-pci-mbox-module",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, NPCM7xxPCIMBoxState,
> +                             NPCM7XX_PCI_MBOX_NR_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +// The chardev device is expected to run using Little Endian protocol
> +// All requests and responses should be expected to be in LE, and if
> +// not should be translated into LE to assure proper working of the device.

This is not in the standard QEMU comment style.

> +static Property npcm7xx_pci_mbox_properties[] = {
> +    DEFINE_PROP_CHR("chardev", NPCM7xxPCIMBoxState, chr),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void npcm7xx_pci_mbox_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "NPCM7xx PCI Mailbox Controller";
> +    dc->vmsd = &vmstate_npcm7xx_pci_mbox;
> +    dc->realize = npcm7xx_pci_mbox_realize;
> +    rc->phases.enter = npcm7xx_pci_mbox_enter_reset;
> +    rc->phases.hold = npcm7xx_pci_mbox_hold_reset;
> +    device_class_set_props(dc, npcm7xx_pci_mbox_properties);
> +}
> +
> +static const TypeInfo npcm7xx_pci_mbox_info = {
> +    .name               = TYPE_NPCM7XX_PCI_MBOX,
> +    .parent             = TYPE_SYS_BUS_DEVICE,
> +    .instance_size      = sizeof(NPCM7xxPCIMBoxState),
> +    .class_init         = npcm7xx_pci_mbox_class_init,
> +    .instance_init      = npcm7xx_pci_mbox_init,
> +};
> +
> +static void npcm7xx_pci_mbox_register_type(void)
> +{
> +    type_register_static(&npcm7xx_pci_mbox_info);
> +}
> +type_init(npcm7xx_pci_mbox_register_type);

thanks
-- PMM

