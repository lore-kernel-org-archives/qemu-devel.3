Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D627AD10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 06:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4ZtA-0000OT-Sp; Sat, 26 Oct 2024 02:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4Zt9-0000OA-Rn
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:03:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t4Zt7-000278-AI
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 02:03:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7203c74e696so1959658b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729922579; x=1730527379;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xgGDS/okxaXxp4wiISrFmSC0udFwGsiN96L6ZG/0uDw=;
 b=DmDi6WOooRPcXLJoG7fuS1d7m+tKcJAO/xfhNn3LR9x4KVxsMyW4pFk22F5oR2fFJm
 Xl1IGtKAhEcJF8HUMnMV7GFVDbzZ96RU1osvUOZBUu/x/6ofAqUVEPk4jC+Tjt45V29z
 RHIOuy7YHcW6EC2FPMA+4i6WUAwcXk3TkNmUNKLo93Z0wHHfVpVc+cgiL2cgKoxrmUhl
 xdwvzpudS0WIBHQvDkYXCFvRE5HqLkiW7lRXDxO7Fwl+iiApmFv/2jFVQpgh2mRz5yA7
 QxTsBpkx8Zx2GYTnDuCiTaGbLxrN7v3qS417PCIp8XWGT10BqmJY7O/tuMEve2VqevFK
 QcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729922579; x=1730527379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgGDS/okxaXxp4wiISrFmSC0udFwGsiN96L6ZG/0uDw=;
 b=tyYH2nwckthuPs62Jh7RorzL93RC9REjsq4TfhSQc0p0Nri8XAJSewA49lqEoyUfUN
 nbFPUt49kx3khPKkGPEKjYXb/SfAHY3EZWGw7TVaRGq5wHGi+18Qc13Icbb4L3eRgr4j
 T4zwf/F3yeB/f4vZ8eUoIl+0L9bFnHV1ohwzjRCp3sr9LUyGl0llP/cYVHM+QufDLLfV
 WYQWLGweMnNORvYpXY12hn8Bvx+y1YEAdAkb4oVHLNt9SEdzJyu8KAHWr93TKXJzw71j
 Wgd56fVD0x/BasG+t4NgftG7i40lR9PM1xduA3aZbtu1qSwcNn1wm8cCwleNL4/kGjyv
 EN8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0I/NfnIheAVTS79ntHMJ2+dqpRr9nrXc2MJZc3EGcSvAkMANxAG57oXCkqxDvdTVOB/cYF9ASW7In@nongnu.org
X-Gm-Message-State: AOJu0YzQHEB2qG7buA10A33Vqfdyc4jZWkMexvxkavITYrfSsGTBGLfY
 Q+jnGpkZEsxaS3vztj5b5n0Q25aQEpzD3aBt5dWGIUipr1kQ6Tc4/OPwzcbl8l0=
X-Google-Smtp-Source: AGHT+IG/NFtuxoesFiKAdSLnb8l2OnmlS1V8pQ2mfKOgD9021RWRobuE0VNtPsA187IJ4es3u//sQg==
X-Received: by 2002:a05:6a00:4b52:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-72062fb87b7mr2676209b3a.11.1729922579310; 
 Fri, 25 Oct 2024 23:02:59 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a1f18esm2145304b3a.146.2024.10.25.23.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 23:02:58 -0700 (PDT)
Message-ID: <d6f06847-ea02-41c9-a9e8-a944f74c0910@daynix.com>
Date: Sat, 26 Oct 2024 15:02:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-14-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024102813.9855-14-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new barrier
> command.
> 
> This patch first creates a mechanism for virtio-blk downstream classes to
> handle unknown commands. It then creates such a downstream class and a new
> vmapple-virtio-blk-pci class which support the additional apple type config
> identifier as well as the barrier command.
> 
> It then exposes 2 subclasses from that that we can use to expose root and
> aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> v4:
> 
>   * Use recommended object type declaration pattern.
>   * Correctly log unimplemented code paths.
>   * Most header code moved to .c, type name #defines moved to vmapple.h
> 
>   hw/block/virtio-blk.c          |  19 ++-
>   hw/vmapple/Kconfig             |   3 +
>   hw/vmapple/meson.build         |   1 +
>   hw/vmapple/virtio-blk.c        | 233 +++++++++++++++++++++++++++++++++
>   include/hw/pci/pci_ids.h       |   1 +
>   include/hw/virtio/virtio-blk.h |  12 +-
>   include/hw/vmapple/vmapple.h   |   4 +
>   7 files changed, 268 insertions(+), 5 deletions(-)
>   create mode 100644 hw/vmapple/virtio-blk.c
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9166d7974d4..9e8337bb639 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -50,12 +50,12 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>       req->mr_next = NULL;
>   }
>   
> -static void virtio_blk_free_request(VirtIOBlockReq *req)
> +void virtio_blk_free_request(VirtIOBlockReq *req)
>   {
>       g_free(req);
>   }
>   
> -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
>   {
>       VirtIOBlock *s = req->dev;
>       VirtIODevice *vdev = VIRTIO_DEVICE(s);
> @@ -966,8 +966,18 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>           break;
>       }
>       default:
> -        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> -        virtio_blk_free_request(req);
> +    {
> +        /*
> +         * Give subclasses a chance to handle unknown requests. This way the
> +         * class lookup is not in the hot path.
> +         */
> +        VirtIOBlkClass *vbk = VIRTIO_BLK_GET_CLASS(s);
> +        if (!vbk->handle_unknown_request ||
> +            !vbk->handle_unknown_request(req, mrb, type)) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +            virtio_blk_free_request(req);
> +        }
> +    }
>       }
>       return 0;
>   }
> @@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info = {
>       .instance_size = sizeof(VirtIOBlock),
>       .instance_init = virtio_blk_instance_init,
>       .class_init = virtio_blk_class_init,
> +    .class_size = sizeof(VirtIOBlkClass),
>   };
>   
>   static void virtio_register_types(void)
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 8bbeb9a9237..bcd1be63e3c 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -7,3 +7,6 @@ config VMAPPLE_BDIF
>   config VMAPPLE_CFG
>       bool
>   
> +config VMAPPLE_VIRTIO_BLK
> +    bool
> +
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index 64b78693a31..bf17cf906c9 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -1,3 +1,4 @@
>   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
> +system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))
> diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> new file mode 100644
> index 00000000000..3a8b47bc55f
> --- /dev/null
> +++ b/hw/vmapple/virtio-blk.c
> @@ -0,0 +1,233 @@
> +/*
> + * VMApple specific VirtIO Block implementation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * VMApple uses almost standard VirtIO Block, but with a few key differences:
> + *
> + *  - Different PCI device/vendor ID
> + *  - An additional "type" identifier to differentiate AUX and Root volumes
> + *  - An additional BARRIER command
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vmapple/vmapple.h"
> +#include "hw/virtio/virtio-blk.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +
> +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
> +
> +typedef struct VMAppleVirtIOBlkClass {
> +    /*< private >*/
> +    VirtIOBlkClass parent;
> +    /*< public >*/

No need for these comments. All members are private to this file.

> +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> +} VMAppleVirtIOBlkClass;
> +
> +typedef struct VMAppleVirtIOBlk {
> +    /* <private> */
> +    VirtIOBlock parent_obj;
> +
> +    /* <public> */
> +    uint32_t apple_type;
> +} VMAppleVirtIOBlk;
> +
> +/*
> + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
> +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI)
> +
> +#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
> +
> +#define VIRTIO_APPLE_TYPE_ROOT 1
> +#define VIRTIO_APPLE_TYPE_AUX  2
> +
> +static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
> +                                                      MultiReqBuffer *mrb,
> +                                                      uint32_t type)
> +{
> +    switch (type) {
> +    case VIRTIO_BLK_T_APPLE_BARRIER:
> +        qemu_log_mask(LOG_UNIMP, "%s: Barrier requests are currently no-ops\n",
> +                      __func__);
> +        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +        virtio_blk_free_request(req);
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +/*
> + * VMApple virtio-blk uses the same config format as normal virtio, with one
> + * exception: It adds an "apple type" specififer at the same location that
> + * the spec reserves for max_secure_erase_sectors. Let's hook into the
> + * get_config code path here, run it as usual and then patch in the apple type.
> + */
> +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VMAppleVirtIOBlk *dev = VMAPPLE_VIRTIO_BLK(vdev);
> +    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
> +    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
> +
> +    vvbk->get_config(vdev, config);
> +
> +    g_assert(dev->parent_obj.config_size >= endof(struct virtio_blk_config, zoned));
> +
> +    /* Apple abuses the field for max_secure_erase_sectors as type id */
> +    blkcfg->max_secure_erase_sectors = dev->apple_type;

Use stl_he_p(). The argument type indicates it be unaligned, and 
virtio_blk_update_config() also uses functions for unaligned stores.

> +}
> +
> +static Property vmapple_virtio_blk_properties[] = {
> +    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk, apple_type, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtIOBlkClass *vbk = VIRTIO_BLK_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_CLASS(klass);
> +
> +    vbk->handle_unknown_request = vmapple_virtio_blk_handle_unknown_request;
> +    vvbk->get_config = vdc->get_config;
> +    vdc->get_config = vmapple_virtio_blk_get_config;
> +    device_class_set_props(dc, vmapple_virtio_blk_properties);
> +}
> +
> +static const TypeInfo vmapple_virtio_blk_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_BLK,
> +    .parent        = TYPE_VIRTIO_BLK,
> +    .instance_size = sizeof(VMAppleVirtIOBlk),
> +    .class_init    = vmapple_virtio_blk_class_init,
> +};
> +
> +/* PCI Devices */
> +
> +struct VMAppleVirtIOBlkPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VMAppleVirtIOBlk vdev;
> +    uint32_t apple_type;
> +};
> +
> +
> +static Property vmapple_virtio_blk_pci_properties[] = {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
> +
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = virtio_pci_optimal_num_queues(0);
> +    }
> +
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = conf->num_queues + 1;
> +    }
> +
> +    /*
> +     * We don't support zones, but we need the additional config space size.
> +     * Let's just expose the feature so the rest of the virtio-blk logic
> +     * allocates enough space for us. The guest will ignore zones anyway.
> +     */
> +    virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F_ZONED);
> +    /* Propagate the apple type down to the virtio-blk device */
> +    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type", dev->apple_type);

The property is unnecessary if it is set internally. The value can be 
directly set using dev->vdev as done for conf->num_queues.

> +    /* and spawn the virtio-blk device */
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +
> +    /*
> +     * The virtio-pci machinery adjusts its vendor/device ID based on whether
> +     * we support modern or legacy virtio. Let's patch it back to the Apple
> +     * identifiers here.
> +     */
> +    pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
> +    pci_config_set_device_id(vpci_dev->pci_dev.config,
> +                             PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> +}
> +
> +static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
> +    k->realize = vmapple_virtio_blk_pci_realize;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_APPLE;
> +    pcidev_k->device_id = PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
> +}
> +
> +static void vmapple_virtio_blk_pci_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VMAPPLE_VIRTIO_BLK);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info = {
> +    .base_name     = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
> +    .generic_name  = "vmapple-virtio-blk-pci",
> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_blk_pci_instance_init,
> +    .class_init    = vmapple_virtio_blk_pci_class_init,
> +};
> +
> +static void vmapple_virtio_root_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type = VIRTIO_APPLE_TYPE_ROOT;
> +}
> +
> +static const TypeInfo vmapple_virtio_root_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_ROOT,
> +    .parent        = "vmapple-virtio-blk-pci",
> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_root_instance_init,
> +};
> +
> +static void vmapple_virtio_aux_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type = VIRTIO_APPLE_TYPE_AUX;
> +}
> +
> +static const TypeInfo vmapple_virtio_aux_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_AUX,
> +    .parent        = "vmapple-virtio-blk-pci",
> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_aux_instance_init,
> +};
> +
> +static void vmapple_virtio_blk_register_types(void)
> +{
> +    type_register_static(&vmapple_virtio_blk_info);
> +    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
> +    type_register_static(&vmapple_virtio_root_info);
> +    type_register_static(&vmapple_virtio_aux_info);
> +}
> +
> +type_init(vmapple_virtio_blk_register_types)
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index f1a53fea8d6..33e2898be95 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -191,6 +191,7 @@
>   #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
>   #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
>   #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
>   
>   #define PCI_VENDOR_ID_SUN                0x108e
>   #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index 5c14110c4b1..28d5046ea6c 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -24,7 +24,7 @@
>   #include "qapi/qapi-types-virtio.h"
>   
>   #define TYPE_VIRTIO_BLK "virtio-blk-device"
> -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
> +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
>   
>   /* This is the last element of the write scatter-gather list */
>   struct virtio_blk_inhdr
> @@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {
>       bool is_write;
>   } MultiReqBuffer;
>   
> +typedef struct VirtIOBlkClass {
> +    /*< private >*/
> +    VirtioDeviceClass parent;
> +    /*< public >*/
> +    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer *mrb,
> +                                   uint32_t type);
> +} VirtIOBlkClass;
> +
>   void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
> +void virtio_blk_free_request(VirtIOBlockReq *req);
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
>   
>   #endif
> diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
> index 984281b6a67..266dc826d38 100644
> --- a/include/hw/vmapple/vmapple.h
> +++ b/include/hw/vmapple/vmapple.h
> @@ -14,4 +14,8 @@
>   
>   #define TYPE_VMAPPLE_CFG "vmapple-cfg"
>   
> +#define TYPE_VMAPPLE_VIRTIO_BLK  "vmapple-virtio-blk"
> +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
> +#define TYPE_VMAPPLE_VIRTIO_AUX  "vmapple-virtio-aux"
> +
>   #endif /* HW_VMAPPLE_VMAPPLE_H */


