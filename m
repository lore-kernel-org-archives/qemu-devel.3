Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865C1CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cgq-000646-Nx; Mon, 22 Sep 2025 05:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cgj-00063J-Ot
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:18:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cgd-0005FR-1K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:18:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso2151165e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758532692; x=1759137492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpTy6yPpw7tLksQPEgjlIBosTe/1435/F7gWK1htM1s=;
 b=Za7eudl9OooDqkTlduuLMq/jxMxFYrjji72ahuqkHIE17YYNKdyxA8J3uHOhdKYJHP
 30jfpZwMpSoldap01T/+HR8En77nyLuu8zPPgjzgYvieK8hQwFd5PTp2+zIGpwpfLd4i
 BVaV5vRIR0bd21nEwmEvwU//Pw0KP/z+WdgcCic7J4ofk5EE6l/5c0X7HYFT30Oah9TI
 +atR5oYqT6XoHazOKoUBdL5ORLeq1t/cFVMLq2Ao406kolGkpzjNcREE6bRyJ4m+6na+
 RhNraveYTEvNgwEhoUoBx7GUMKVnwwScUBDbs6pie9cI2+tFQ0RR3ShBiRipk3WspaUJ
 EzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758532692; x=1759137492;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cpTy6yPpw7tLksQPEgjlIBosTe/1435/F7gWK1htM1s=;
 b=LeCyZsB123XUdQFo2y5jVjapp/ot1Ycxs07D6NHM2j5cybkH8WqKgzx5BoynBk+2Yn
 y8B600ILT9BkyOxQ+BATz2BL/WEy2oLedwgpEFbMXZje/Fx7CBe9lO3bCmAvMNpcx1FA
 LFL3bdvLKYCSmQ200neg503HjHWvBjFfIU88wudPki+kMp4Mc7KQEwsNUItG5/4AD6iP
 hqsgT5MiGn0lwsRqYfThzfs9mmQBS4ILwewpfPOb7QNw+IsGTBQMazNwtwC2aC3X3Leq
 TwgwFgd+R5Mt5LbAKXWvO97TvpihNWEXLvzFzLkA8kuYOwp00sbrCFFuWHpvMVfvthV/
 IBBw==
X-Gm-Message-State: AOJu0YyCLjg+33wFBCsOYBpPteiV7hBnPxJXAZ5p+g54oKDf9M7SzxJD
 hXcuDpDZb0ZlAUB58YsUAZu4MoABdzSF2JybIDM4XE/H/gIX1KjSL5Vz4uy9OnlBcpg=
X-Gm-Gg: ASbGncuQyWXr5FVTxBEFomcP57gN5XP7o1rhpTEVmbvyq0uf4cbeD3mxzaHkEc92bsQ
 eBc5MJXSWehpJ7G9+/KrsFj4GYpjfZGuU2yQDOcefehpS/DFSCHoJE0825Wk/ZCZuesDo8oXLlK
 /HeZfLRHHNpGhtxlK1s10MtMxyfE6E6eizNu9q47Q7Yr3rwmHVsCiVSlT1WZTUwKpuVUfHkGq0n
 ETYnCTRP6gAgbY67SqTAIwSPrHMiWUxWx5bnNOyj3j+iqntVrkvCLTAR0ftJOkTmHZscnDAnTyJ
 OOpT/5UkH6vebPpM85l8JqBO1wvGzIWfXvo9ICjeKgd78LjTcArhV6Q9onxxkisjRozWG5Bzgmn
 pNksjYf8sFSRQ72IAjFAktlTNfuSBl6pv5w==
X-Google-Smtp-Source: AGHT+IEz84Z9nNc2+pwDOSUKAdtgyfAwhgzN10Id5aQGz76kkBUABNykTdYrmFYcxOGVUtJColia5Q==
X-Received: by 2002:a05:600c:4814:b0:46d:31dc:aad0 with SMTP id
 5b1f17b1804b1-46d31dcae0cmr16092725e9.33.1758532692363; 
 Mon, 22 Sep 2025 02:18:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dea20f833sm15138965e9.10.2025.09.22.02.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:18:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 891B15F7B1;
 Mon, 22 Sep 2025 10:18:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/2] hw/pci-host/dino: Don't call
 pci_register_root_bus() in init
In-Reply-To: <20250918114259.1802337-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 18 Sep 2025 12:42:58 +0100")
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
 <20250918114259.1802337-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 10:18:10 +0100
Message-ID: <87segeq20d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In the dino PCI host bridge device, we call pci_register_root_bus()
> in the device's instance_init. This is a problem for two reasons
>  * the PCI bridge is then available to the rest of the simulation
>    (e.g. via pci_qdev_find_device()), even though it hasn't
>    yet been realized
>  * we do not attempt to unregister in an instance_deinit,
>    which means that if you go through an instance_init -> deinit
>    lifecycle the freed memory for the host-bridge device is
>    left on the pci_host_bridges list
>
> ASAN reports the resulting use-after-free:
>
> =3D=3D1771223=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x527000018f80 at pc 0x5b4b9d3369b5 bp 0x7ffd01929980 sp 0x7ffd01929978
> WRITE of size 8 at 0x527000018f80 thread T0
>     #0 0x5b4b9d3369b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
>     #1 0x5b4b9d321566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
>     #2 0x5b4b9d3215e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-=
laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
>     #3 0x5b4b9d321fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
>     #4 0x5b4b9d390521 in dino_pcihost_init /mnt/nvmedisk/linaro/qemu-from=
-laptop/qemu/build/hppa-asan/../../hw/pci-host/dino.c:473:16
>
> 0x527000018f80 is located 1664 bytes inside of 12384-byte region [0x52700=
0018900,0x52700001b960)
> freed by thread T0 here:
>     #0 0x5b4b9cab185a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu=
/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: ca496bb2e4fc750ebd28=
9b448bad8d99c0ecd140)
>     #1 0x5b4b9e3ee723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-l=
aptop/qemu/build/hppa-asan/../../qom/object.c:734:9
>     #2 0x5b4b9e3e69db in object_unref /mnt/nvmedisk/linaro/qemu-from-lapt=
op/qemu/build/hppa-asan/../../qom/object.c:1232:9
>     #3 0x5b4b9ea6173c in qmp_device_list_properties /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5
>     #4 0x5b4b9ec4e0f3 in qmp_marshal_device_list_properties /mnt/nvmedisk=
/linaro/qemu-from-laptop/qemu/build/hppa-asan/qapi/qapi-commands-qdev.c:65:=
14
>
> previously allocated by thread T0 here:
>     #0 0x5b4b9cab1af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: ca496bb2e4fc750ebd=
289b448bad8d99c0ecd140)
>     #1 0x799d8270eb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5b4b9e3e75fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
>     #3 0x5b4b9e3e7409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
>     #4 0x5b4b9ea609a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11
>
> where we allocated one instance of the dino device, put it on the
> list, freed it, and then trying to allocate a second instance touches
> the freed memory on the pci_host_bridges list.
>
> Fix this by deferring all the setup of memory regions and registering
> the PCI bridge to the device's realize method.  This brings it into
> line with almost all other PCI host bridges, which call
> pci_register_root_bus() in realize.

Would it be worth adding a kdoc comment to the declaration of
pci_register_root_bus to explain this?

>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
> Fixes: 63901b6cc4d8b4 ("dino: move PCI bus initialisation to dino_pcihost=
_init()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/pci-host/dino.c | 90 +++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 49 deletions(-)
>
> diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
> index 11b353be2ea..924053499c1 100644
> --- a/hw/pci-host/dino.c
> +++ b/hw/pci-host/dino.c
> @@ -413,6 +413,47 @@ static void dino_pcihost_reset(DeviceState *dev)
>  static void dino_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      DinoState *s =3D DINO_PCI_HOST_BRIDGE(dev);
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> +
> +    /* Dino PCI access from main memory.  */
> +    memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
> +                          s, "dino", 4096);
> +
> +    /* Dino PCI config. */
> +    memory_region_init_io(&phb->conf_mem, OBJECT(phb),
> +                          &dino_config_addr_ops, DEVICE(s),
> +                          "pci-conf-idx", 4);
> +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> +                          &dino_config_data_ops, DEVICE(s),
> +                          "pci-conf-data", 4);
> +    memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
> +                                &phb->conf_mem);
> +    memory_region_add_subregion(&s->this_mem, DINO_CONFIG_DATA,
> +                                &phb->data_mem);
> +
> +    /* Dino PCI bus memory.  */
> +    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 4 * GiB);
> +
> +    phb->bus =3D pci_register_root_bus(DEVICE(s), "pci",
> +                                     dino_set_irq, dino_pci_map_irq, s,
> +                                     &s->pci_mem, get_system_io(),
> +                                     PCI_DEVFN(0, 0), 32, TYPE_PCI_BUS);
> +
> +    /* Set up windows into PCI bus memory.  */
> +    for (int i =3D 1; i < 31; i++) {
> +        uint32_t addr =3D 0xf0000000 + i * DINO_MEM_CHUNK_SIZE;
> +        char *name =3D g_strdup_printf("PCI Outbound Window %d", i);
> +        memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
> +                                 name, &s->pci_mem, addr,
> +                                 DINO_MEM_CHUNK_SIZE);
> +        g_free(name);

minor nit: this could be an autofree but I get you are just moving code
here.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

