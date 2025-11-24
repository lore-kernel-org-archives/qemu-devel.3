Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126DCCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNeD-0005BF-UT; Sun, 23 Nov 2025 22:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNe7-0005Am-RX
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:53:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNe6-0001ti-03
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:53:47 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso2338534f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 19:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763956424; x=1764561224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtSvn6UYWSN8ScFk2HhKHM3bcegsK+6BHk7XZhuw+ko=;
 b=Ky3Z5QTd4GdDC92Ija7K49wkAEQo4hUdw+xRcgQksTMlTaHN7lHAvKe8NYHAi+dIXm
 g/2Xr/OMdTkZjuDOGaZky4kbLKDmMYh5NQy4fz/4T+z8h7kDxLNTdBASUoNi38H0DCsT
 BDEonviMgsfblZZsDNkFNNs0q13KGgxditXeM2HUEFBO2B/NW26pWNBfPEf91J5iZ+DE
 QmzAGYwLSeEoUg1DfqfW5VVXCcPemLFuFwrTJKKfm9YBFLb9R8alYZhOpLi3ecOh4u4/
 yyFhfOkGk0eFCosyuDYQhazhCKJyxK3dC9GnVY3Y52MDE28dIkRjCeJ8c5EY0nea/o3B
 tMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763956424; x=1764561224;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GtSvn6UYWSN8ScFk2HhKHM3bcegsK+6BHk7XZhuw+ko=;
 b=qDv5IOLNR2wc53kuXZjl/cLtGKXdQlxrBpx7YVvHdvHo5Tb1mTyzqx47YC5bc8EDqG
 OElPNTt0QLx7uvgRDChdgnNqMKro33MWHzxCUAPmHYx3hJfw3HpvJjKgoDTE3/X6jO/e
 ZMrmhdHWGZlXpxbpp6BcXQ3q6yeygjyyO2Von4uZrz66GcRk4c6mulPzjSNSAyRKJUEM
 vt5J8vZJpf9nU/XvkxNTFu1Evoocw5lOCigbm82N38w8hXj2MQuyuu4JyAlxcFRHRWRr
 4brbL1Ytd7PPUFwn6E4ack/8YzhCH1cW88+fxkoFcy9wfpoTitbVRk1XgbpFwtCOwER/
 rvVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9LaEpQ2arGKSoYaevV8c1P4FXuh7LWVlmRSweBPd9iTxX1FwHKuc0HZaHHI0X6IzjBMsWiYzxB+J@nongnu.org
X-Gm-Message-State: AOJu0YwzZgYKkakqvzD0rXbBL/sqBY67fa32dshHKLv6wP/nwLWWD3fG
 DbO0ivKNSA5zESQAf+zwwv39mCnh5TMFMrhXnZTHTQQrPHXES+QqvPh0iMy2Gqt6jJ8=
X-Gm-Gg: ASbGnctkqIzocGvxgDvHHEAZbaRaVNtg+Wu0z87xIYJtlrVcRlUNlbL9qH0aPBYdyoI
 5BA9qLvOQUFSweqSLCqDmsl5BVkE0O8FTkOaEeYNF0y3Z1dI+hUuwrM/T2GXoQUmeiSGENqarun
 DHPCD7MIYt6MfA489AA/JcN4FswWUbtmyTSW+41ysWJGIbysRypyUsnkPodn38xw4VeLa/Ilyab
 AF2gDF0uPpbVoKMX+OboQjcNFRsMxrO2bKbMKe2LeC030cITtYTc4mezahpO23aCkqdA8S4Rs90
 VLsJ01oXdY8zej5yka0XeO+kkcVGjLwanyn/UV2Wm1ebSeOy9xyXM5E7xqPqs9C6Th1vsL4ihmP
 tM21g9K54oczCz/auKrFHatiwoPfE35YCqoN83Yf+7/f1Cff6LDp0P+B7lCWDos8zNbK4h03f5s
 aHaOMZCmNomx0FKFz1i4h4T2K3w62LbGkG34og/HoC+T5U3q4EpVKU1A==
X-Google-Smtp-Source: AGHT+IEbCitFxA4xW5/lCtV7ZF4I+8TvifCfJuNmrl3KQnVS3r70tKZCRTt+ovcM5v99twA9BNTShQ==
X-Received: by 2002:a05:6000:2dca:b0:42b:48bc:49b0 with SMTP id
 ffacd0b85a97d-42cba7b435fmr16366650f8f.21.1763956424169; 
 Sun, 23 Nov 2025 19:53:44 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aafb3sm142583625e9.0.2025.11.23.19.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 19:53:43 -0800 (PST)
Message-ID: <8244536a-404e-408f-b3d4-38b96d180dbd@linaro.org>
Date: Mon, 24 Nov 2025 04:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 16/17] hw/pci-bridge: format special OFW unit
 address for PXB host
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin O'Connor <kevin@koconnor.net>
References: <1435326248-24291-1-git-send-email-mst@redhat.com>
 <1435326248-24291-17-git-send-email-mst@redhat.com>
 <c782890b-1dc5-4ac6-9792-d31a07c2354e@linaro.org>
In-Reply-To: <c782890b-1dc5-4ac6-9792-d31a07c2354e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

ping

On 12/11/25 23:35, Philippe Mathieu-Daudé wrote:
> Hi Michael and Marcel,
> 
> (old patch...)
> 
> On 26/6/15 15:46, Michael S. Tsirkin wrote:
>> From: Laszlo Ersek <lersek@redhat.com>
>>
>> We have agreed that OpenFirmware device paths in the "bootorder" fw_cfg
>> file should follow the pattern
>>
>>    /pci@i0cf8,%x/...
>>
>> for devices that live behind an extra root bus. The extra root bus in
>> question is the %x'th among the extra root buses. (In other words, %x
>> gives the position of the affected extra root bus relative to the other
>> extra root buses, in bus_nr order.) %x starts at 1, and is formatted in
>> hex.
>>
>> The portion of the unit address that comes before the comma is 
>> dynamically
>> taken from the main host bridge, similarly to sysbus_get_fw_dev_path().
>>
>> Cc: Kevin O'Connor <kevin@koconnor.net>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   hw/pci-bridge/pci_expander_bridge.c | 53 +++++++++++++++++++++++++++ 
>> ++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/ 
>> pci_expander_bridge.c
>> index 70708ef..57f8a37 100644
>> --- a/hw/pci-bridge/pci_expander_bridge.c
>> +++ b/hw/pci-bridge/pci_expander_bridge.c
>> @@ -43,6 +43,8 @@ typedef struct PXBDev {
>>       uint16_t numa_node;
>>   } PXBDev;
>> +static GList *pxb_dev_list;
> 
> This list is static ...
> 
>> +
>>   #define TYPE_PXB_HOST "pxb-host"
>>   static int pxb_bus_num(PCIBus *bus)
>> @@ -89,12 +91,45 @@ static const char 
>> *pxb_host_root_bus_path(PCIHostState *host_bridge,
>>       return bus->bus_path;
>>   }
>> +static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>> +{
>> +    const PCIHostState *pxb_host;
>> +    const PCIBus *pxb_bus;
>> +    const PXBDev *pxb_dev;
>> +    int position;
>> +    const DeviceState *pxb_dev_base;
>> +    const PCIHostState *main_host;
>> +    const SysBusDevice *main_host_sbd;
>> +
>> +    pxb_host = PCI_HOST_BRIDGE(dev);
>> +    pxb_bus = pxb_host->bus;
>> +    pxb_dev = PXB_DEV(pxb_bus->parent_dev);
>> +    position = g_list_index(pxb_dev_list, pxb_dev);
>> +    assert(position >= 0);
> 
> ... and for some reason when calling pxb_host_ofw_unit_address() twice
> it triggers the following:
> 
> Assertion failed: (position >= 0), function pxb_host_ofw_unit_address, 
> file pci_expander_bridge.c, line 154.
> 
> Any idea why it got implemented this way and how to modify to
> avoid the assertion? All other devices implementing the
> SysBusDeviceClass::explicit_ofw_unit_address handler don't abort
> when being called multiple times, what is so particular here?
> 
> Thanks,
> 
> Phil.
> 
>> +
>> +    pxb_dev_base = DEVICE(pxb_dev);
>> +    main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
>> +    main_host_sbd = SYS_BUS_DEVICE(main_host);
>> +
>> +    if (main_host_sbd->num_mmio > 0) {
>> +        return g_strdup_printf(TARGET_FMT_plx ",%x",
>> +                               main_host_sbd->mmio[0].addr, position 
>> + 1);
>> +    }
>> +    if (main_host_sbd->num_pio > 0) {
>> +        return g_strdup_printf("i%04x,%x",
>> +                               main_host_sbd->pio[0], position + 1);
>> +    }
>> +    return NULL;
>> +}
>> +
>>   static void pxb_host_class_init(ObjectClass *class, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(class);
>> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
>>       PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
>>       dc->fw_name = "pci";
>> +    sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
>>       hc->root_bus_path = pxb_host_root_bus_path;
>>   }
>> @@ -149,6 +184,15 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int 
>> pin)
>>       return pin - PCI_SLOT(pxb->devfn);
>>   }
>> +static gint pxb_compare(gconstpointer a, gconstpointer b)
>> +{
>> +    const PXBDev *pxb_a = a, *pxb_b = b;
>> +
>> +    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
>> +           pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
>> +           0;
>> +}
>> +
>>   static int pxb_dev_initfn(PCIDevice *dev)
>>   {
>>       PXBDev *pxb = PXB_DEV(dev);
>> @@ -192,9 +236,17 @@ static int pxb_dev_initfn(PCIDevice *dev)
>>                                  PCI_STATUS_66MHZ | 
>> PCI_STATUS_FAST_BACK);
>>       pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
>> +    pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
>>       return 0;
>>   }
>> +static void pxb_dev_exitfn(PCIDevice *pci_dev)
>> +{
>> +    PXBDev *pxb = PXB_DEV(pci_dev);
>> +
>> +    pxb_dev_list = g_list_remove(pxb_dev_list, pxb);
>> +}
>> +
>>   static Property pxb_dev_properties[] = {
>>       /* Note: 0 is not a legal a PXB bus number. */
>>       DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
>> @@ -208,6 +260,7 @@ static void pxb_dev_class_init(ObjectClass *klass, 
>> void *data)
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>       k->init = pxb_dev_initfn;
>> +    k->exit = pxb_dev_exitfn;
>>       k->vendor_id = PCI_VENDOR_ID_REDHAT;
>>       k->device_id = PCI_DEVICE_ID_REDHAT_PXB;
>>       k->class_id = PCI_CLASS_BRIDGE_HOST;
> 


