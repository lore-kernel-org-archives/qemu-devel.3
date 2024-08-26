Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C562C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 01:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siOOM-00039E-TA; Sun, 25 Aug 2024 21:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1siOOL-00038f-L3
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 21:19:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1siOOI-0008Gw-47
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 21:19:33 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bec87ececeso4091939a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724635167; x=1725239967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wF+WaWG2nghgwRymtmlWgu1+/PXICL9nmT0jfdY6j0g=;
 b=gxSQf2fzI4snkGQ7AhvBIG7FPe4vqerQCg3ngAe2QEAmgi2EF/M+quH9H9Zq58zvL7
 BqHWzI90qtrCrNiONb9ALQwZqYCVeUiuLbngkSRJd/2EwfQww90KegE5oQ4Z10I0Ukg7
 dscSyrTz3tzs3dCrE8uZ2Wo5mazw5n7PY7KfMjffDTzKiRDF3NPIas8hR0tkjMUUgi7+
 CwJl8ghJPunYVkHVUnp3dftCl0cNeMXfkN9t3a8FnxLQOBRq36O5BmCkDGajwVArhsTL
 jkZW1WBlcUIxXto/A0CH8db4AjvdFbRF1H4qKr3byeOMwpc2sq66BAEo2toQSB2ZGH9S
 mqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724635167; x=1725239967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wF+WaWG2nghgwRymtmlWgu1+/PXICL9nmT0jfdY6j0g=;
 b=KaGnQz0rvn80vtcq5B8oDSi2OP7I+fGz6X6/3Iv1YTPXwI6nQnvxlBNkNT50UJldIe
 VCLeOv7qu7itZuEfAp9oIEq0vEpkiiXOAaGR7tUYb74Ggy9zHsLYN1p6FL38HRJbXmvo
 8Ib35lFfCbejcJYOjqHGcH/YGhf+/UrbAnBbDDxICYORXFLuO6EbZI2m05V4W398f4a4
 V0JSwrqSmyw2JaVns8rOdzCgGmF/qSleWKRSVmACLr8t6DX91zxz6HPwnXEt8lX1mXwe
 EVo1I8PrtQ+S/Z609l5vSqDWrow//fdEjE7JF1vJwnwjD4Eu+RA1eYTWiNyUS2kyZbbd
 YeMA==
X-Gm-Message-State: AOJu0Ywd5HmIWT7pT0LHNtI2ZBVFKVOMZ56xhjWPwXqW+EFsVO+9q3aW
 ARakiuBQErAuvN57su2zKOQ0yEOdZOXC84io+0loDBAPcjAQ9WDR9QQMkptks6nj02IexI6m4NU
 jgg2lkAzTPgU4J7bf//LHWwdYlu9IGw==
X-Google-Smtp-Source: AGHT+IET2xlwwIonYqL1fU53+9ub14+4BP5vp0zZvrLoEOeEXaQKUyT+bAv/R03EC1y7GjAYc55UJsw5SWkGdf3SBLY=
X-Received: by 2002:a05:6402:40c7:b0:5be:dbbb:2d49 with SMTP id
 4fb4d7f45d1cf-5c08915f381mr5981814a12.1.1724635166154; Sun, 25 Aug 2024
 18:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP_GjX7aA@mail.gmail.com>
 <CAAXNugCTpOOeEv_FvjZqV_H_55FYm-Vqx4WC6pCEb4e7C2NTXA@mail.gmail.com>
In-Reply-To: <CAAXNugCTpOOeEv_FvjZqV_H_55FYm-Vqx4WC6pCEb4e7C2NTXA@mail.gmail.com>
From: Zero Tang <zero.tangptr@gmail.com>
Date: Mon, 26 Aug 2024 09:19:13 +0800
Message-ID: <CAAXNugD6OW5bdt5tkS37ORaUT1V5_UjLaiM4WE1FBq3sQ55NrQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Add a virtual PCILeech device
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: multipart/alternative; boundary="0000000000007226ee06208beaf1"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zero.tangptr@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000007226ee06208beaf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'd like to *PING* this patch once again. Please review this patch. If
there is anything missing or ambiguous in the patch, please let me know.

Thanks,
Zero Tang

On Sun, Aug 18, 2024 at 1:30=E2=80=AFAM Zero Tang <zero.tangptr@gmail.com> =
wrote:

> Hello,
>
> I'd like to ping this patch in that the QEMU-PCILeech plugin is now merge=
d
> into the PCILeech repository:
> https://github.com/ufrisk/LeechCore-plugins/pull/10
> The Patchew link is:
> https://patchew.org/QEMU/CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP._5F=
GjX7aA@mail.gmail.com/
>
> Kind Regards,
> Zero Tang
>
> On Tue, Aug 6, 2024 at 5:28=E2=80=AFPM Zero Tang <zero.tangptr@gmail.com>=
 wrote:
>
>> This virtual PCILeech device aims to help security researchers attack th=
e
>> guest via DMA and test their IOMMU defenses.
>> This device is intended to support any systems with PCI, but I am only
>> able to test x86-based guests.
>> For what PCILeech is, check PCILeech GitHub repository:
>> https://github.com/ufrisk/pcileech
>> The QEMU-PCILeech plugin is currently awaiting merging:
>> https://github.com/ufrisk/LeechCore-plugins/pull/10
>>
>> This is my first time contributing to QEMU and I am sorry that I forgot
>> to include a "[PATCH]" prefix in the title from my previous email and th=
at
>> I didn't cc to relevant maintainers.
>> If needed, add my name and contact info into the maintainer's list.
>>
>> Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
>> ---
>>  hw/misc/Kconfig     |   5 ++++
>>  hw/misc/meson.build |   1 +
>>  hw/misc/pcileech.c  | 291
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>>  3 files changed, 297 insertions(+)
>>
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 1e08785b83..6c3ea7bf74 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -30,6 +30,11 @@ config EDU
>>      default y if TEST_DEVICES
>>      depends on PCI && MSI_NONBROKEN
>>
>> +config PCILEECH
>> +    bool
>> +    default y
>> +    depends on PCI
>> +
>>  config PCA9552
>>      bool
>>      depends on I2C
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index 2ca8717be2..e79931b9a6 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -1,5 +1,6 @@
>>  system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
>>  system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
>> +system_ss.add(when: 'CONFIG_PCILEECH', if_true: files('pcileech.c'))
>>  system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c')=
)
>>  system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>>  system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'=
))
>> diff --git a/hw/misc/pcileech.c b/hw/misc/pcileech.c
>> new file mode 100644
>> index 0000000000..252a570161
>> --- /dev/null
>> +++ b/hw/misc/pcileech.c
>> @@ -0,0 +1,291 @@
>> +/*
>> + * QEMU Virtual PCILeech Device
>> + *
>> + * Copyright (c) 2024 Zero Tang
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtainin=
g
>> a
>> + * copy of this software and associated documentation files (the
>> "Software"),
>> + * to deal in the Software without restriction, including without
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom th=
e
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> SHALL THE
>> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTH=
ER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> + * DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/hw.h"
>> +#include "hw/pci/msi.h"
>> +#include "qemu/timer.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/qdev-properties-system.h"
>> +#include "qom/object.h"
>> +#include "qemu/main-loop.h" /* iothread mutex */
>> +#include "qemu/module.h"
>> +#include "qapi/visitor.h"
>> +
>> +#define TYPE_PCILEECH_DEVICE "pcileech"
>> +
>> +struct LeechRequestHeader {
>> +    uint8_t endianness; /* 0 - Little, 1 - Big */
>> +    uint8_t command;    /* 0 - Read, 1 - Write */
>> +    uint8_t reserved[6];
>> +    /* Variable Endianness */
>> +    uint64_t address;
>> +    uint64_t length;
>> +};
>> +
>> +struct LeechResponseHeader {
>> +    uint8_t endianness; /* 0 - Little, 1 - Big */
>> +    uint8_t reserved[3];
>> +    MemTxResult result;
>> +    uint64_t length;    /* Indicates length of data followed by header =
*/
>> +};
>> +
>> +/* Verify the header length */
>> +static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);
>> +static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);
>> +
>> +struct PciLeechState {
>> +    /* Internal State */
>> +    PCIDevice device;
>> +    QemuThread thread;
>> +    QemuMutex mutex;
>> +    bool endianness;
>> +    bool stopping;
>> +    /* Communication */
>> +    char *host;
>> +    uint16_t port;
>> +    int sockfd;
>> +};
>> +
>> +typedef struct LeechRequestHeader LeechRequestHeader;
>> +typedef struct PciLeechState PciLeechState;
>> +
>> +DECLARE_INSTANCE_CHECKER(PciLeechState, PCILEECH, TYPE_PCILEECH_DEVICE)
>> +
>> +static void pci_leech_process_write_request(PciLeechState *state,
>> +                                            LeechRequestHeader *request=
,
>> +                                            int incoming)
>> +{
>> +    char buff[1024];
>> +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
>> +        struct LeechResponseHeader response =3D { 0 };
>> +        char* response_buffer =3D (char *)&response;
>> +        const uint64_t writelen =3D (request->length - i) <=3D sizeof(b=
uff) ?
>> +                                         (request->length - i) :
>> sizeof(buff);
>> +        ssize_t recvlen =3D 0, sendlen =3D 0;
>> +        while (recvlen < writelen) {
>> +            recvlen +=3D recv(incoming, &buff[recvlen], writelen -
>> recvlen, 0);
>> +        }
>> +        response.endianness =3D state->endianness;
>> +        response.result =3D pci_dma_write(&state->device, request->addr=
ess
>> + i,
>> +                                                            buff,
>> writelen);
>> +        if (response.result) {
>> +            printf("PCILeech: Address 0x%lX Write Error! MemTxResult:
>> 0x%X\n",
>> +                    request->address + i, response.result);
>> +        }
>> +        response.length =3D 0;
>> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
>> +            sendlen +=3D send(incoming, &response_buffer[sendlen],
>> +                            sizeof(struct LeechResponseHeader) -
>> sendlen, 0);
>> +        }
>> +    }
>> +}
>> +
>> +static void pci_leech_process_read_request(PciLeechState *state,
>> +                                            LeechRequestHeader *request=
,
>> +                                            int incoming)
>> +{
>> +    char buff[1024];
>> +    for (uint64_t i =3D 0; i < request->length; i +=3D sizeof(buff)) {
>> +        struct LeechResponseHeader response =3D { 0 };
>> +        char* response_buffer =3D (char *)&response;
>> +        const uint64_t readlen =3D (request->length - i) <=3D sizeof(bu=
ff) ?
>> +                                    (request->length - i) : sizeof(buff=
);
>> +        ssize_t sendlen =3D 0;
>> +        response.endianness =3D state->endianness;
>> +        response.result =3D pci_dma_read(&state->device, request->addre=
ss
>> + i,
>> +                                                            buff,
>> readlen);
>> +        if (response.result) {
>> +            printf("PCILeech: Address 0x%lX Read Error! MemTxResult:
>> 0x%X\n",
>> +                    request->address + i, response.result);
>> +        }
>> +        response.length =3D (request->endianness !=3D state->endianness=
) ?
>> +                                            bswap64(readlen) : readlen;
>> +        while (sendlen < sizeof(struct LeechResponseHeader)) {
>> +            sendlen +=3D send(incoming, &response_buffer[sendlen],
>> +                            sizeof(struct LeechResponseHeader) -
>> sendlen, 0);
>> +        }
>> +        sendlen =3D 0;
>> +        while (sendlen < readlen) {
>> +            sendlen +=3D send(incoming, &buff[sendlen], readlen - sendl=
en,
>> 0);
>> +        }
>> +    }
>> +}
>> +
>> +static void *pci_leech_worker_thread(void *opaque)
>> +{
>> +    PciLeechState *state =3D PCILEECH(opaque);
>> +    while (1) {
>> +        LeechRequestHeader request;
>> +        char *request_buffer =3D (char *)&request;
>> +        ssize_t received =3D 0;
>> +        int incoming;
>> +        struct sockaddr address;
>> +        socklen_t addrlen;
>> +        /* Check if we are stopping. */
>> +        qemu_mutex_lock(&state->mutex);
>> +        if (state->stopping) {
>> +            qemu_mutex_unlock(&state->mutex);
>> +            break;
>> +        }
>> +        qemu_mutex_unlock(&state->mutex);
>> +        /* Accept PCILeech requests. */
>> +        /* Use HTTP1.0-like protocol for simplicity. */
>> +        incoming =3D accept(state->sockfd, &address, &addrlen);
>> +        if (incoming < 0) {
>> +            puts("WARNING: Failed to accept socket for PCILeech!
>> Skipping "
>> +                 "Request...\n");
>> +            continue;
>> +        }
>> +        /* Get PCILeech requests. */
>> +        while (received < sizeof(LeechRequestHeader)) {
>> +            received +=3D recv(incoming, &request_buffer[received],
>> +                            sizeof(LeechRequestHeader) - received, 0);
>> +        }
>> +        /* Swap endianness. */
>> +        if (request.endianness !=3D state->endianness) {
>> +            request.address =3D bswap64(request.address);
>> +            request.length =3D bswap64(request.length);
>> +        }
>> +        /* Process PCILeech requests. */
>> +        qemu_mutex_lock(&state->mutex);
>> +        if (request.command) {
>> +            pci_leech_process_write_request(state, &request, incoming);
>> +        } else {
>> +            pci_leech_process_read_request(state, &request, incoming);
>> +        }
>> +        qemu_mutex_unlock(&state->mutex);
>> +        close(incoming);
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static void pci_leech_realize(PCIDevice *pdev, Error **errp)
>> +{
>> +    PciLeechState *state =3D PCILEECH(pdev);
>> +    struct sockaddr_in sock_addr;
>> +    char host_ip[16];
>> +    struct hostent *he =3D gethostbyname(state->host);
>> +    if (he =3D=3D NULL) {
>> +        puts("gethostbyname failed!");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    /* Initialize the socket for PCILeech. */
>> +    state->sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
>> +    if (state->sockfd < 0) {
>> +        puts("Failed to initialize socket for PCILeech!");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    sock_addr.sin_family =3D AF_INET;
>> +    sock_addr.sin_addr =3D *(struct in_addr *)he->h_addr;
>> +    sock_addr.sin_port =3D htons(state->port);
>> +    inet_ntop(AF_INET, &sock_addr.sin_addr, host_ip, sizeof(host_ip));
>> +    if (bind(state->sockfd, (struct sockaddr *)&sock_addr,
>> sizeof(sock_addr))
>> +                                                                    < 0=
)
>> {
>> +        puts("Failed to bind socket for PCILeech!");
>> +        close(state->sockfd);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    if (listen(state->sockfd, 10) < 0) {
>> +        puts("Failed to listen to socket for PCILeech!");
>> +        close(state->sockfd);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    printf("INFO: PCILeech is listening on %s:%u...\n", host_ip,
>> state->port);
>> +    /* Initialize the thread for PCILeech. */
>> +    qemu_mutex_init(&state->mutex);
>> +    qemu_thread_create(&state->thread, "pcileech",
>> pci_leech_worker_thread,
>> +                                            state, QEMU_THREAD_JOINABLE=
);
>> +}
>> +
>> +static void pci_leech_finalize(PCIDevice *pdev)
>> +{
>> +    PciLeechState *state =3D PCILEECH(pdev);
>> +    puts("Stopping PCILeech Worker...");
>> +    qemu_mutex_lock(&state->mutex);
>> +    state->stopping =3D true;
>> +    qemu_mutex_unlock(&state->mutex);
>> +    close(state->sockfd);
>> +    qemu_thread_join(&state->thread);
>> +    qemu_mutex_destroy(&state->mutex);
>> +}
>> +
>> +char pci_leech_default_host[] =3D "0.0.0.0";
>> +
>> +static void pci_leech_instance_init(Object *obj)
>> +{
>> +    int x =3D 1;
>> +    char* y =3D (char *)&x;
>> +    PciLeechState *state =3D PCILEECH(obj);
>> +    /* QEMU's String-Property can't specify default value. */
>> +    /* So we have to set the default on our own. */
>> +    if (state->host =3D=3D NULL) {
>> +        state->host =3D pci_leech_default_host;
>> +    }
>> +    /* Save Our Endianness. */
>> +    state->endianness =3D (*y =3D=3D 0);
>> +}
>> +
>> +static Property leech_properties[] =3D {
>> +    DEFINE_PROP_UINT16("port", PciLeechState, port, 6789),
>> +    DEFINE_PROP_STRING("host", PciLeechState, host),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pci_leech_class_init(ObjectClass *class, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(class);
>> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);
>> +    k->realize =3D pci_leech_realize;
>> +    k->exit =3D pci_leech_finalize;
>> +    /* Change the Vendor/Device ID to your favor. */
>> +    /* These are the default values from PCILeech-FPGA. */
>> +    k->vendor_id =3D PCI_VENDOR_ID_XILINX;
>> +    k->device_id =3D 0x0666;
>> +    k->revision =3D 0;
>> +    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
>> +    device_class_set_props(dc, leech_properties);
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +}
>> +
>> +static void pci_leech_register_types(void)
>> +{
>> +    static InterfaceInfo interfaces[] =3D {
>> +        {INTERFACE_CONVENTIONAL_PCI_DEVICE},
>> +        {},
>> +    };
>> +    static const TypeInfo leech_info =3D {
>> +        .name =3D TYPE_PCILEECH_DEVICE,
>> +        .parent =3D TYPE_PCI_DEVICE,
>> +        .instance_size =3D sizeof(PciLeechState),
>> +        .instance_init =3D pci_leech_instance_init,
>> +        .class_init =3D pci_leech_class_init,
>> +        .interfaces =3D interfaces,
>> +    };
>> +    type_register_static(&leech_info);
>> +}
>> +
>> +type_init(pci_leech_register_types)
>>
>

--0000000000007226ee06208beaf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d like to <b>PING</b> this patch once again. Please =
review this patch. If there is anything missing or ambiguous in the patch, =
please let me know.<div><br></div><div>Thanks,</div><div>Zero Tang</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sun, Aug 18, 2024 at 1:30=E2=80=AFAM Zero Tang &lt;<a href=3D"mailto:zero.t=
angptr@gmail.com">zero.tangptr@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hello,</div><=
div><br></div>I&#39;d like to ping this patch in that the QEMU-PCILeech plu=
gin is now merged into the PCILeech repository:=C2=A0<a href=3D"https://git=
hub.com/ufrisk/LeechCore-plugins/pull/10" target=3D"_blank">https://github.=
com/ufrisk/LeechCore-plugins/pull/10</a><div>The Patchew link is:=C2=A0<a h=
ref=3D"https://patchew.org/QEMU/CAAXNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMG=
P._5FGjX7aA@mail.gmail.com/" target=3D"_blank">https://patchew.org/QEMU/CAA=
XNugBYhpx249dUWgyXOtGjkxWatRHJSq94LrVFMGP._5FGjX7aA@mail.gmail.com/</a></di=
v><div><br></div><div>Kind Regards,</div><div>Zero Tang</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 6,=
 2024 at 5:28=E2=80=AFPM Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail=
.com" target=3D"_blank">zero.tangptr@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><font f=
ace=3D"arial, sans-serif">This virtual PCILeech device aims to help securit=
y researchers attack the guest via DMA and test their IOMMU defenses.</font=
></div><div><font face=3D"arial, sans-serif">This device is intended to sup=
port any systems with PCI, but I am only able to test x86-based guests.</fo=
nt></div><div><font face=3D"arial, sans-serif">For what PCILeech is, check =
PCILeech GitHub repository:=C2=A0</font><a href=3D"https://github.com/ufris=
k/pcileech" target=3D"_blank">https://github.com/ufrisk/pcileech</a></div><=
div>The QEMU-PCILeech plugin is currently awaiting merging:=C2=A0<a href=3D=
"https://github.com/ufrisk/LeechCore-plugins/pull/10" target=3D"_blank">htt=
ps://github.com/ufrisk/LeechCore-plugins/pull/10</a></div><div><br></div><d=
iv>This is my first time contributing to QEMU and I am sorry that I forgot =
to include a &quot;[PATCH]&quot; prefix in the title from my previous email=
 and that I didn&#39;t cc to relevant maintainers.</div><div>If needed, add=
 my name and contact info into the maintainer&#39;s list.</div><div><br></d=
iv><div>Signed-off-by: Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.c=
om" target=3D"_blank">zero.tangptr@gmail.com</a>&gt;</div><font face=3D"mon=
ospace"><div><font face=3D"monospace">---</font></div>=C2=A0hw/misc/Kconfig=
 =C2=A0 =C2=A0 | =C2=A0 5 ++++<br>=C2=A0hw/misc/meson.build | =C2=A0 1 +<br=
>=C2=A0hw/misc/pcileech.c =C2=A0| 291 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++<br>=C2=A03 files changed, 297 inse=
rtions(+)<br><br>diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>index 1e=
08785b83..6c3ea7bf74 100644<br>--- a/hw/misc/Kconfig<br>+++ b/hw/misc/Kconf=
ig<br>@@ -30,6 +30,11 @@ config EDU<br>=C2=A0 =C2=A0 =C2=A0default y if TES=
T_DEVICES<br>=C2=A0 =C2=A0 =C2=A0depends on PCI &amp;&amp; MSI_NONBROKEN<br=
>=C2=A0<br>+config PCILEECH<br>+ =C2=A0 =C2=A0bool<br>+ =C2=A0 =C2=A0defaul=
t y<br>+ =C2=A0 =C2=A0depends on PCI<br>+<br>=C2=A0config PCA9552<br>=C2=A0=
 =C2=A0 =C2=A0bool<br>=C2=A0 =C2=A0 =C2=A0depends on I2C<br>diff --git a/hw=
/misc/meson.build b/hw/misc/meson.build<br>index 2ca8717be2..e79931b9a6 100=
644<br>--- a/hw/misc/meson.build<br>+++ b/hw/misc/meson.build<br>@@ -1,5 +1=
,6 @@<br>=C2=A0system_ss.add(when: &#39;CONFIG_APPLESMC&#39;, if_true: file=
s(&#39;applesmc.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_EDU&#39;,=
 if_true: files(&#39;edu.c&#39;))<br>+system_ss.add(when: &#39;CONFIG_PCILE=
ECH&#39;, if_true: files(&#39;pcileech.c&#39;))<br>=C2=A0system_ss.add(when=
: &#39;CONFIG_FW_CFG_DMA&#39;, if_true: files(&#39;vmcoreinfo.c&#39;))<br>=
=C2=A0system_ss.add(when: &#39;CONFIG_ISA_DEBUG&#39;, if_true: files(&#39;d=
ebugexit.c&#39;))<br>=C2=A0system_ss.add(when: &#39;CONFIG_ISA_TESTDEV&#39;=
, if_true: files(&#39;pc-testdev.c&#39;))<br>diff --git a/hw/misc/pcileech.=
c b/hw/misc/pcileech.c<br>new file mode 100644<br>index 0000000000..252a570=
161<br>--- /dev/null<br>+++ b/hw/misc/pcileech.c<br>@@ -0,0 +1,291 @@<br>+/=
*<br>+ * QEMU Virtual PCILeech Device<br>+ *<br>+ * Copyright (c) 2024 Zero=
 Tang<br>+ *<br>+ * Permission is hereby granted, free of charge, to any pe=
rson obtaining a<br>+ * copy of this software and associated documentation =
files (the &quot;Software&quot;),<br>+ * to deal in the Software without re=
striction, including without limitation<br>+ * the rights to use, copy, mod=
ify, merge, publish, distribute, sublicense,<br>+ * and/or sell copies of t=
he Software, and to permit persons to whom the<br>+ * Software is furnished=
 to do so, subject to the following conditions:<br>+ *<br>+ * The above cop=
yright notice and this permission notice shall be included in<br>+ * all co=
pies or substantial portions of the Software.<br>+ *<br>+ * THE SOFTWARE IS=
 PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br>+ =
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<=
br>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL THE<br>+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER<br>+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHE=
RWISE, ARISING<br>+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR TH=
E USE OR OTHER<br>+ * DEALINGS IN THE SOFTWARE.<br>+ */<br>+<br>+#include &=
quot;qemu/osdep.h&quot;<br>+#include &quot;qemu/units.h&quot;<br>+#include =
&quot;hw/pci/pci.h&quot;<br>+#include &quot;hw/hw.h&quot;<br>+#include &quo=
t;hw/pci/msi.h&quot;<br>+#include &quot;qemu/timer.h&quot;<br>+#include &qu=
ot;hw/qdev-properties.h&quot;<br>+#include &quot;hw/qdev-properties-system.=
h&quot;<br>+#include &quot;qom/object.h&quot;<br>+#include &quot;qemu/main-=
loop.h&quot; /* iothread mutex */<br>+#include &quot;qemu/module.h&quot;<br=
>+#include &quot;qapi/visitor.h&quot;<br>+<br>+#define TYPE_PCILEECH_DEVICE=
 &quot;pcileech&quot;<br>+<br>+struct LeechRequestHeader {<br>+ =C2=A0 =C2=
=A0uint8_t endianness; /* 0 - Little, 1 - Big */<br>+ =C2=A0 =C2=A0uint8_t =
command; =C2=A0 =C2=A0/* 0 - Read, 1 - Write */<br>+ =C2=A0 =C2=A0uint8_t r=
eserved[6];<br>+ =C2=A0 =C2=A0/* Variable Endianness */<br>+ =C2=A0 =C2=A0u=
int64_t address;<br>+ =C2=A0 =C2=A0uint64_t length;<br>+};<br>+<br>+struct =
LeechResponseHeader {<br>+ =C2=A0 =C2=A0uint8_t endianness; /* 0 - Little, =
1 - Big */<br>+ =C2=A0 =C2=A0uint8_t reserved[3];<br>+ =C2=A0 =C2=A0MemTxRe=
sult result;<br>+ =C2=A0 =C2=A0uint64_t length; =C2=A0 =C2=A0/* Indicates l=
ength of data followed by header */<br>+};<br>+<br>+/* Verify the header le=
ngth */<br>+static_assert(sizeof(struct LeechRequestHeader) =3D=3D 24);<br>=
+static_assert(sizeof(struct LeechResponseHeader) =3D=3D 16);<br>+<br>+stru=
ct PciLeechState {<br>+ =C2=A0 =C2=A0/* Internal State */<br>+ =C2=A0 =C2=
=A0PCIDevice device;<br>+ =C2=A0 =C2=A0QemuThread thread;<br>+ =C2=A0 =C2=
=A0QemuMutex mutex;<br>+ =C2=A0 =C2=A0bool endianness;<br>+ =C2=A0 =C2=A0bo=
ol stopping;<br>+ =C2=A0 =C2=A0/* Communication */<br>+ =C2=A0 =C2=A0char *=
host;<br>+ =C2=A0 =C2=A0uint16_t port;<br>+ =C2=A0 =C2=A0int sockfd;<br>+};=
<br>+<br>+typedef struct LeechRequestHeader LeechRequestHeader;<br>+typedef=
 struct PciLeechState PciLeechState;<br>+<br>+DECLARE_INSTANCE_CHECKER(PciL=
eechState, PCILEECH, TYPE_PCILEECH_DEVICE)<br>+<br>+static void pci_leech_p=
rocess_write_request(PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *req=
uest,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int incoming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>=
+ =C2=A0 =C2=A0for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=3D siz=
eof(buff)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader res=
ponse =3D { 0 };<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D =
(char *)&amp;response;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t write=
len =3D (request-&gt;length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (request-&gt;length - =
i) : sizeof(buff);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t recvlen =3D 0, s=
endlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (recvlen &lt; writelen)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recvlen +=3D recv(incoming=
, &amp;buff[recvlen], writelen - recvlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.endianness =3D state-&gt;endi=
anness;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.result =3D pci_dma_write(&=
amp;state-&gt;device, request-&gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buff, writelen);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (response.result) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0printf(&quot;PCILeech: Address 0x%lX Write Error! MemTxResult:=
 0x%X\n&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0request-&gt;address + i, response.result);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0response.length =3D 0;<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen &lt; sizeof(struct LeechResponse=
Header)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(=
incoming, &amp;response_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(struct LeechResponseHeader) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void pci_leech_process_read_=
request(PciLeechState *state,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LeechRequestHeader *request,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int incoming)<br>+{<br>+ =C2=A0 =C2=A0char buff[1024];<br>+ =C2=A0 =
=C2=A0for (uint64_t i =3D 0; i &lt; request-&gt;length; i +=3D sizeof(buff)=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct LeechResponseHeader response =3D=
 { 0 };<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char* response_buffer =3D (char *)&=
amp;response;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t readlen =3D (r=
equest-&gt;length - i) &lt;=3D sizeof(buff) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(request-&gt;length - i) : sizeof(buff);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0response.endianness =3D state-&gt;endianness;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0response.result =3D pci_dma_read(&amp;state-&gt;device, request-&=
gt;address + i,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0buff, readlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (response.resu=
lt) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;PCILeech: =
Address 0x%lX Read Error! MemTxResult: 0x%X\n&quot;,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request-&gt;address + i=
, response.result);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0response.length =3D (request-&gt;endianness !=3D state-&gt;end=
ianness) ?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bswap64(readlen) : readlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0while (sendlen &lt; sizeof(struct LeechResponseHeader)) {<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D send(incoming, &amp;respons=
e_buffer[sendlen],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct LeechResponse=
Header) - sendlen, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sendlen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sendlen=
 &lt; readlen) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sendlen +=3D=
 send(incoming, &amp;buff[sendlen], readlen - sendlen, 0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+static void *pci_leec=
h_worker_thread(void *opaque)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState *state =
=3D PCILEECH(opaque);<br>+ =C2=A0 =C2=A0while (1) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0LeechRequestHeader request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0char =
*request_buffer =3D (char *)&amp;request;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
size_t received =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int incoming;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr address;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0socklen_t addrlen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if we=
 are stopping. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;stat=
e-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;stopping) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;state-&gt=
;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&am=
p;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Accept PCILeech requ=
ests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use HTTP1.0-like protocol for s=
implicity. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0incoming =3D accept(state-&gt=
;sockfd, &amp;address, &amp;addrlen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i=
ncoming &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;=
WARNING: Failed to accept socket for PCILeech! Skipping &quot;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Request...\n&quot;);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get PCILeech requests. *=
/<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while (received &lt; sizeof(LeechRequestH=
eader)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received +=3D recv(=
incoming, &amp;request_buffer[received],<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof=
(LeechRequestHeader) - received, 0);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Swap endianness. */<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (request.endianness !=3D state-&gt;endianness) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.address =3D bswap64(request.addre=
ss);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0request.length =3D bswap=
64(request.length);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Process PCILeech requests. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0qemu_mutex_lock(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (request.command) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_lee=
ch_process_write_request(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_le=
ech_process_read_request(state, &amp;request, incoming);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;stat=
e-&gt;mutex);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(incoming);<br>+ =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0return NULL;<br>+}<br>+<br>+static void pci_leech=
_realize(PCIDevice *pdev, Error **errp)<br>+{<br>+ =C2=A0 =C2=A0PciLeechSta=
te *state =3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0struct sockaddr_in sock_add=
r;<br>+ =C2=A0 =C2=A0char host_ip[16];<br>+ =C2=A0 =C2=A0struct hostent *he=
 =3D gethostbyname(state-&gt;host);<br>+ =C2=A0 =C2=A0if (he =3D=3D NULL) {=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;gethostbyname failed!&quot;);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0/* Initialize the socket for PCILeech. */<br>+ =C2=A0 =C2=A0s=
tate-&gt;sockfd =3D socket(AF_INET, SOCK_STREAM, 0);<br>+ =C2=A0 =C2=A0if (=
state-&gt;sockfd &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Faile=
d to initialize socket for PCILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0sock_addr.sin_=
family =3D AF_INET;<br>+ =C2=A0 =C2=A0sock_addr.sin_addr =3D *(struct in_ad=
dr *)he-&gt;h_addr;<br>+ =C2=A0 =C2=A0sock_addr.sin_port =3D htons(state-&g=
t;port);<br>+ =C2=A0 =C2=A0inet_ntop(AF_INET, &amp;sock_addr.sin_addr, host=
_ip, sizeof(host_ip));<br>+ =C2=A0 =C2=A0if (bind(state-&gt;sockfd, (struct=
 sockaddr *)&amp;sock_addr, sizeof(sock_addr))<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt; 0=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(&quot;Failed to bind socket for PC=
ILeech!&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =
=C2=A0 =C2=A0if (listen(state-&gt;sockfd, 10) &lt; 0) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0puts(&quot;Failed to listen to socket for PCILeech!&quot;);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0close(state-&gt;sockfd);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0exit(EXIT_FAILURE);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0prin=
tf(&quot;INFO: PCILeech is listening on %s:%u...\n&quot;, host_ip, state-&g=
t;port);<br>+ =C2=A0 =C2=A0/* Initialize the thread for PCILeech. */<br>+ =
=C2=A0 =C2=A0qemu_mutex_init(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0qemu_=
thread_create(&amp;state-&gt;thread, &quot;pcileech&quot;, pci_leech_worker=
_thread,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0state, QEMU_THREAD_JOINABLE);<br>+}<br>+<br>+static voi=
d pci_leech_finalize(PCIDevice *pdev)<br>+{<br>+ =C2=A0 =C2=A0PciLeechState=
 *state =3D PCILEECH(pdev);<br>+ =C2=A0 =C2=A0puts(&quot;Stopping PCILeech =
Worker...&quot;);<br>+ =C2=A0 =C2=A0qemu_mutex_lock(&amp;state-&gt;mutex);<=
br>+ =C2=A0 =C2=A0state-&gt;stopping =3D true;<br>+ =C2=A0 =C2=A0qemu_mutex=
_unlock(&amp;state-&gt;mutex);<br>+ =C2=A0 =C2=A0close(state-&gt;sockfd);<b=
r>+ =C2=A0 =C2=A0qemu_thread_join(&amp;state-&gt;thread);<br>+ =C2=A0 =C2=
=A0qemu_mutex_destroy(&amp;state-&gt;mutex);<br>+}<br>+<br>+char pci_leech_=
default_host[] =3D &quot;0.0.0.0&quot;;<br>+<br>+static void pci_leech_inst=
ance_init(Object *obj)<br>+{<br>+ =C2=A0 =C2=A0int x =3D 1;<br>+ =C2=A0 =C2=
=A0char* y =3D (char *)&amp;x;<br>+ =C2=A0 =C2=A0PciLeechState *state =3D P=
CILEECH(obj);<br>+ =C2=A0 =C2=A0/* QEMU&#39;s String-Property can&#39;t spe=
cify default value. */<br>+ =C2=A0 =C2=A0/* So we have to set the default o=
n our own. */<br>+ =C2=A0 =C2=A0if (state-&gt;host =3D=3D NULL) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0state-&gt;host =3D pci_leech_default_host;<br>+ =C2=
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0/* Save Our Endianness. */<br>+ =C2=A0 =C2=A0=
state-&gt;endianness =3D (*y =3D=3D 0);<br>+}<br>+<br>+static Property leec=
h_properties[] =3D {<br>+ =C2=A0 =C2=A0DEFINE_PROP_UINT16(&quot;port&quot;,=
 PciLeechState, port, 6789),<br>+ =C2=A0 =C2=A0DEFINE_PROP_STRING(&quot;hos=
t&quot;, PciLeechState, host),<br>+ =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),=
<br>+};<br>+<br>+static void pci_leech_class_init(ObjectClass *class, void =
*data)<br>+{<br>+ =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(class);<br>=
+ =C2=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);<br>+ =C2=A0 =
=C2=A0k-&gt;realize =3D pci_leech_realize;<br>+ =C2=A0 =C2=A0k-&gt;exit =3D=
 pci_leech_finalize;<br>+ =C2=A0 =C2=A0/* Change the Vendor/Device ID to yo=
ur favor. */<br>+ =C2=A0 =C2=A0/* These are the default values from PCILeec=
h-FPGA. */<br>+ =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_XILINX;<br>+=
 =C2=A0 =C2=A0k-&gt;device_id =3D 0x0666;<br>+ =C2=A0 =C2=A0k-&gt;revision =
=3D 0;<br>+ =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_NETWORK_ETHERNET;<br>=
+ =C2=A0 =C2=A0device_class_set_props(dc, leech_properties);<br>+ =C2=A0 =
=C2=A0set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>+}<br>+<br>+stat=
ic void pci_leech_register_types(void)<br>+{<br>+ =C2=A0 =C2=A0static Inter=
faceInfo interfaces[] =3D {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{INTERFACE_CONV=
ENTIONAL_PCI_DEVICE},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{},<br>+ =C2=A0 =C2=
=A0};<br>+ =C2=A0 =C2=A0static const TypeInfo leech_info =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_PCILEECH_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.parent =3D TYPE_PCI_DEVICE,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.ins=
tance_size =3D sizeof(PciLeechState),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.inst=
ance_init =3D pci_leech_instance_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.cla=
ss_init =3D pci_leech_class_init,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.interfac=
es =3D interfaces,<br>+ =C2=A0 =C2=A0};<br>+ =C2=A0 =C2=A0type_register_sta=
tic(&amp;leech_info);<br>+}<br>+<br>+type_init(pci_leech_register_types)</f=
ont><br></div>
</blockquote></div>
</blockquote></div>

--0000000000007226ee06208beaf1--

