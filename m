Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D8CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbe8W-0005M0-P1; Mon, 22 Jun 2026 08:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe8T-0005Ll-BZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe8R-000609-HQ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+n4grWRAvSgnrvjZSWyAPpv8dv0aMvl/FrdFz11jLF4=;
 b=I0d+vEbFELFylemEFUF7cW7pdIzboaA6/bLoywkN6j41guC6eSA8ACW6NPC9d96Dran7lF
 7rG1nq9FVA6ANhCiJwRAocXyuvkimHgzVHpbZ7h5ADYRys9jby+jAU5lrDnRh+F0KGyeyD
 eNR5w3Vva08v/XC+R/nu3l3JMUi+ZkQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-yB_WkZdkMcOsRyTj820LOw-1; Mon, 22 Jun 2026 08:52:14 -0400
X-MC-Unique: yB_WkZdkMcOsRyTj820LOw-1
X-Mimecast-MFC-AGG-ID: yB_WkZdkMcOsRyTj820LOw_1782132733
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-461c8319c73so3485943f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782132733; x=1782737533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n4grWRAvSgnrvjZSWyAPpv8dv0aMvl/FrdFz11jLF4=;
 b=phvebq1atUDHl43TmcqxtB51acSq5hIfKheIVqnb0ikKtGU2fv/IpYwgjQ/D99KiKh
 5VTSGMQbownjCuo7j9hMQmUm3cI8yxsvNjnZM/oqcn6AKuWQ2qLTEIKBlLXh8X0yH6FF
 9tmsCVVzYqr+ZbvErWVS21uu6DNzN+Tlx7n1MBvh/7gjJDMr4wR/DTMgi4c6OVdijT5c
 wyyp2CIwCp3t3adPrbN+i0XZWjs2KeguypPlx8HRTHs/AFqvNv8+722oADTNP4lIatjg
 I//qfiWDz5L03xmDEFz4P9XAkw3qP5KLX6kUXERK74wjhlLb8d1OrslEVj8clRvara6o
 CKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132733; x=1782737533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+n4grWRAvSgnrvjZSWyAPpv8dv0aMvl/FrdFz11jLF4=;
 b=bAkL808nwrzMxX1UjK8cXYzEuDIhK4DxROfPWiroVhUDVLP0Bh3tT/WotEQMzvZYnL
 qsH39JIy3eexkpvVxGKeKQBwwFJG5K3m3a9orN1hZIW+p5jpaYrY/ipsKsphfDpaa/CY
 BRTtD9ZvAZqJQDjqu1qq/bO6T+nlw8PA+WZZaZmxjbwqgZj0uyjyRdFAViSYdWHZj5+9
 IgwxDvB8UKCxTxPb3qoORltftkVzNmd5JxV62zw+38quDxFa4/e5dYEUH7BJpazcTtth
 GCoifV++s00iMItX1WhEr7NBmt7r5/a6Ub/S5+Xi+311h8vIs5UQNAyGajM2sKxQbniA
 Xwog==
X-Gm-Message-State: AOJu0YxJNK6RCsVXNt7T8N4AccMlu1lSnuFFbolhfQEY2C+XRX2qchhO
 kEgY62spRCNpLWgfzeUN0Nh69/5r4fxQCaRW50Rkys5Mi01T7YwS/ulm6sE7+BR0cMLVMeqlcJm
 G4s3ccafVlbzM2T5iKmSaufeN4CS6rLzJWGtxec6FYZpOb03Rzeud0Pd9
X-Gm-Gg: AfdE7ckfQJtsnvgEdyBbO22RH5I/CjC27PQRXDL6bXi9A5pHAW+xVeQAuwGSuYAHWXD
 kt8ZwSFpxNxgOYGNzW+ym3iaOs7l8xmU/Q3h6Hpx+9rwXPSU2tZy7LoJ4ToC0GGvHitUGGy6hck
 CfW4B1+ZqyOEcdrMPxE7yBc4aYqGHEQVyMiv/zWpd4PaEHqNLNSZ8dZfi32ljpC+wcuwhYVS2+4
 o2n5wnYwoaWAiFwTFo1DpplUSKLAipKvsjvKrD11i7nsfnsZvy6GiKUmKbq/M8Py7YTGJlPoCAp
 jH1Gkt80nQxnLKJElAs21LCG7/q3h6ChYhY7tGV/8bzSBI6+Jqz30CqynVVmquPQ2rgyqdY=
X-Received: by 2002:adf:e3c1:0:b0:460:18cc:dcfe with SMTP id
 ffacd0b85a97d-46508afa647mr20384724f8f.34.1782132733142; 
 Mon, 22 Jun 2026 05:52:13 -0700 (PDT)
X-Received: by 2002:adf:e3c1:0:b0:460:18cc:dcfe with SMTP id
 ffacd0b85a97d-46508afa647mr20384660f8f.34.1782132732444; 
 Mon, 22 Jun 2026 05:52:12 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57a0esm24351198f8f.27.2026.06.22.05.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:52:11 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:52:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 02/10] qapi, hmp: introspection for the sp-mem device
Message-ID: <20260622145209.35cc66b8@imammedo>
In-Reply-To: <20260619111136.3481329-3-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-3-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 19 Jun 2026 19:11:28 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devices`
> reports each sp-mem instance (id, addr, size, node, memdev), and print it
> from HMP `info memory-devices`.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
>  hw/core/machine-hmp-cmds.c | 11 ++++++++++
>  hw/mem/sp-mem.c            | 19 +++++++++++++++++
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..777cfc81e1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1413,6 +1413,32 @@
>            }
>  }
>  
> +##
> +# @SpMemDeviceInfo:
> +#
> +# sp-mem device state information
> +#
> +# @id: device's ID
> +#
> +# @addr: physical address, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @node: NUMA proximity domain to which the device is assigned
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpMemDeviceInfo',
> +  'data': { '*id': 'str',
> +            'addr': 'size',
> +            'size': 'size',
> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfoKind:
>  #
> @@ -1426,11 +1452,13 @@
>  #
>  # @hv-balloon: since 8.2.
>  #
> +# @sp-mem: since 11.1.
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'MemoryDeviceInfoKind',
>    'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> -            'hv-balloon' ] }
> +            'hv-balloon', 'sp-mem' ] }
>  
>  ##
>  # @PCDIMMDeviceInfoWrapper:
> @@ -1482,6 +1510,16 @@
>  { 'struct': 'HvBalloonDeviceInfoWrapper',
>    'data': { 'data': 'HvBalloonDeviceInfo' } }
>  
> +##
> +# @SpMemDeviceInfoWrapper:
> +#
> +# @data: sp-mem device state information
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpMemDeviceInfoWrapper',
> +  'data': { 'data': 'SpMemDeviceInfo' } }
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
> @@ -1499,7 +1537,8 @@
>              'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>              'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
>              'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> -            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
> +            'sp-mem': 'SpMemDeviceInfoWrapper'
>            }
>  }
>  
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 46846f741a..686304bafa 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -279,6 +279,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      PCDIMMDeviceInfo *di;
>      SgxEPCDeviceInfo *se;
>      HvBalloonDeviceInfo *hi;
> +    SpMemDeviceInfo *spmi;
>  
>      for (info = info_list; info; info = info->next) {
>          value = info->value;
> @@ -350,6 +351,16 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                      monitor_printf(mon, "  memdev: %s\n", hi->memdev);
>                  }
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
> +                spmi = value->u.sp_mem.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               spmi->id ? spmi->id : "");
> +                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
> +                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
> +                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
> +                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
> index d088222f54..962d0f937e 100644
> --- a/hw/mem/sp-mem.c
> +++ b/hw/mem/sp-mem.c
> @@ -53,6 +53,24 @@ static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
>      return host_memory_backend_get_memory(spm->hostmem);
>  }
>  
> +static void sp_mem_fill_device_info(const MemoryDeviceState *md,
> +                                    MemoryDeviceInfo *info)
> +{
> +    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
> +    SpMemDevice *spm = SP_MEM(md);
> +    DeviceState *dev = DEVICE(md);
> +
> +    di->id = dev->id ? g_strdup(dev->id) : NULL;
> +    di->addr = spm->addr;
> +    di->size = memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem));
> +    di->node = spm->node;
> +    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
> +
> +    info->u.sp_mem.data = di;
> +    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
> +}
> +
>  static void sp_mem_realize(DeviceState *dev, Error **errp)
>  {
>      SpMemDevice *spm = SP_MEM(dev);
> @@ -91,6 +109,7 @@ static void sp_mem_class_init(ObjectClass *oc, const void *data)
>      mdc->set_addr            = sp_mem_set_addr;
>      mdc->get_memory_region   = sp_mem_get_memory_region;
>      mdc->get_plugged_size    = memory_device_get_region_size;
> +    mdc->fill_device_info    = sp_mem_fill_device_info;
>  }
>  
>  static const TypeInfo sp_mem_types[] = {


