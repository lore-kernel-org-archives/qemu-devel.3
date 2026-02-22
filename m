Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7ACC636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAHJ-0005G1-BP; Sun, 22 Feb 2026 09:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAHG-0005FX-Jh
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAHA-0004fc-Px
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771769853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=igy5hS1Cp+YSvyjWEpjNmPfzea33gZnQOLa+LOckfL0=;
 b=SV2MNh6vd6z4+JygxroCY4RBa02xr09IblE1Ct0ioyO/2L4X6IsqT/jxBXqJJg57FPL9wp
 GZrOyi9NSVdqo7abd9QqyY/zjUigZ1xlKj9nHsMVobmqJnAnH8MRKE7DmZ4i9c6OCaOl2e
 TP1kMqW6vUcAZc8iJ78kHH6thpx5ouU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-ErgTM6exO-Cx2F7TBeQ3eA-1; Sun, 22 Feb 2026 09:17:31 -0500
X-MC-Unique: ErgTM6exO-Cx2F7TBeQ3eA-1
X-Mimecast-MFC-AGG-ID: ErgTM6exO-Cx2F7TBeQ3eA_1771769850
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4363333c102so2945093f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771769850; x=1772374650; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=igy5hS1Cp+YSvyjWEpjNmPfzea33gZnQOLa+LOckfL0=;
 b=rdi/avCc9OYAjE9Mb43D9x8rrdx1J9YFQKDoevCLPjk0K2A1tDbYyMQatX8hXJJiT4
 sB3dXzYCKkJEYEUWcpD1rRAW+i7ZT/+zXUwFKdKpDRarHZe5SxVkTSDJBwmhaCnQWTMl
 KIs4rwlcdJyy+587BwvHZdZNg7JVWbr90Z+cId8ueXOCd9rC1h4H9WYb2pjD9vkU2XPT
 /fx4oLqnMUGBKqblFkZm03X3mSdOP/irj80TgTg5lvfYDMQGbChLELRT+uMkf9W/P5it
 7l1W+9dYlo4gn/iuiCY+Kabftpt/mA5mMEZCKMY+aa31g24MsONHLxJGiiGDCIBOC8Rr
 Btmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771769850; x=1772374650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igy5hS1Cp+YSvyjWEpjNmPfzea33gZnQOLa+LOckfL0=;
 b=Metd4XbQwnH6x99Tb0jb/oHrW4eMjDGFuvFDkjUVdF36u+nuOu2qhwQhi5hC/xKwgt
 nj8Cgl/NJF7G4/cTI52bBuHuvTKKaOpJ7uO8c8APBf0l272LR+Qm4SM4mWYBG1ua+ZYK
 FrtgeiDfC2XToAc1j5hfEIMmjOrS+71zlzXh0HN+r19PdiUbxpZ7HwAxP3Ia3up8VwOo
 IAIArTylTSWXJCEh8DqGRRjM4X8KVfpkxoEnjsJjj6M9qm4SO5oeh/F4FzIuU7lhVX5a
 gYfkeVxLy2RBsJfI/gx9i/S4cMxa92UAPGq8dSA+DcB1y6lekJNSbSo4SL55f3jqTpVm
 DN3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Jj8lcRToS7LYrTYtO3XBHey/7L6BnxpMVuyte+T+HLH26SbGDbvEobsAyUC8qV0Sqhk12jJeuyTL@nongnu.org
X-Gm-Message-State: AOJu0YxifvYlFhjQbx/k7Kay2N14oLEzaQxWZuMWtLngB41cgiY0IPZZ
 4kXBNCv3HA3nJDEql+lVmuJgiuYeTxP7ahnYfnRa2FW2D3xMNUqnXILKVj86qYsA7ZRaC2eKb8z
 OffftjZrdIeK0BNu9tmMRfiAhpPcQtn4bp1t1v9lj9vUqljCEJZPdsjft
X-Gm-Gg: AZuq6aLFzi7hd3/OOpMl2anUSWZbzZ0F41uEsIrovgkl/W8HLarg0XsaWF7Sman/BnH
 OO1gEmQlqAk42OQpVFsuKZFeP2xJndfWUi8o4cLdxp2OsobISqEOqsvOV2nCgHRJ5j6NLflRPSh
 2lk8vPuhNxhjKp3hBjBwOChysIzFslKYOavepqWpuT6uwKG8zzb2Y1Gy9ukFvhyZqqhHdOZYouA
 z84PnZecDM88pZ8SbMSjbOa10/Bs9PD+Qow/3Tp+HrVK4JaF6bOz8ndJn0X30RSWcsIMsz6oaSx
 RB/Vn8ZYR/8ZJePC/huI/bg0iWSgobhyAsJM2kqZonF6DmJNj9RJIr62rSSMEaMfNQXJsNOGfrD
 wV0/qrK6B7rYnki4FBr2+NdwVS8zvFj/mj1F+qT5yqG9bow==
X-Received: by 2002:a5d:5885:0:b0:437:6b73:ffb1 with SMTP id
 ffacd0b85a97d-4396f17a9d1mr9909525f8f.30.1771769850325; 
 Sun, 22 Feb 2026 06:17:30 -0800 (PST)
X-Received: by 2002:a5d:5885:0:b0:437:6b73:ffb1 with SMTP id
 ffacd0b85a97d-4396f17a9d1mr9909482f8f.30.1771769849760; 
 Sun, 22 Feb 2026 06:17:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm13664718f8f.28.2026.02.22.06.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:17:29 -0800 (PST)
Date: Sun, 22 Feb 2026 09:17:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ankita@nvidia.com
Cc: vsethi@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 alex@shazbot.org, imammedo@redhat.com, anisinha@redhat.com,
 aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com,
 kjaju@nvidia.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260222091700-mutt-send-email-mst@kernel.org>
References: <20260222113526.6291-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222113526.6291-1-ankita@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Feb 22, 2026 at 11:35:26AM +0000, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> During creation of the VM's SRAT table, the generic initiator entries
> are added. Currently the order in the entries are not controllable from
> the qemu command. This is due to the fact that the code queries the
> object tree which may not be in the order objects were inserted.

why is this a problem?

> As a fix the patch maintains a GPtrArray of generic initiator objects
> that preserves their insertion order. Objects are automatically added
> to the array when initialized and removed when finalized. When building
> the SRAT table, objects are processed in the order they were first
> inserted.
> 
> E.g. for the following qemu command.
> ...
>             -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
>             -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
>             -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
>             -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
>             -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
>             -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
>             -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
>             -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> ...
> 
> Original PXM in the VM SRAT table:
> [1A4h 0420 004h]            Proximity Domain : 00000007
> [1C4h 0452 004h]            Proximity Domain : 00000006
> [1E4h 0484 004h]            Proximity Domain : 00000005
> [204h 0516 004h]            Proximity Domain : 00000004
> [224h 0548 004h]            Proximity Domain : 00000003
> [244h 0580 004h]            Proximity Domain : 00000009
> [264h 0612 004h]            Proximity Domain : 00000002
> [284h 0644 004h]            Proximity Domain : 00000008
> [2A2h 0674 004h]            Proximity Domain : 00000009
> 
> After the patch (preserves insertion order):
> [1A4h 0420 004h]            Proximity Domain : 00000002
> [1C4h 0452 004h]            Proximity Domain : 00000003
> [1E4h 0484 004h]            Proximity Domain : 00000004
> [204h 0516 004h]            Proximity Domain : 00000005
> [224h 0548 004h]            Proximity Domain : 00000006
> [244h 0580 004h]            Proximity Domain : 00000007
> [264h 0612 004h]            Proximity Domain : 00000008
> [284h 0644 004h]            Proximity Domain : 00000009
> 
> cc: Shameer Kolothum <skolothumtho@nvidia.com>
> Fixes: 0a5b5acdf2 ("hw/acpi: Implement the SRAT GI affinity structure")
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---

changelog since v1?

>  hw/acpi/pci.c | 49 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index 8c7ed10479..61d9a836c5 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -88,18 +88,35 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
>  
> +static GPtrArray *acpi_generic_initiator_list;
> +
>  static void acpi_generic_initiator_init(Object *obj)
>  {
>      AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
>  
>      gi->node = MAX_NODES;
>      gi->pci_dev = NULL;
> +
> +    /* Initialize array on first use */
> +    if (!acpi_generic_initiator_list) {
> +        acpi_generic_initiator_list = g_ptr_array_new();
> +    }
> +
> +    g_ptr_array_add(acpi_generic_initiator_list, gi);
>  }
>  
>  static void acpi_generic_initiator_finalize(Object *obj)
>  {
>      AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
>  
> +    if (acpi_generic_initiator_list) {
> +        g_ptr_array_remove(acpi_generic_initiator_list, gi);
> +
> +        if (acpi_generic_initiator_list->len == 0) {
> +            g_ptr_array_free(acpi_generic_initiator_list, true);
> +            acpi_generic_initiator_list = NULL;
> +        }
> +    }
>      g_free(gi->pci_dev);
>  }
>  
> @@ -145,20 +162,15 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
>          "NUMA node associated with the PCI device");
>  }
>  
> -static int build_acpi_generic_initiator(Object *obj, void *opaque)
> +
> +static void build_acpi_generic_initiator(AcpiGenericInitiator *gi,
> +                                         GArray *table_data)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> -    AcpiGenericInitiator *gi;
> -    GArray *table_data = opaque;
>      int32_t devfn;
>      uint8_t bus;
>      Object *o;
>  
> -    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> -        return 0;
> -    }
> -
> -    gi = ACPI_GENERIC_INITIATOR(obj);
>      if (gi->node >= ms->numa_state->num_nodes) {
>          error_printf("%s: Specified node %d is invalid.\n",
>                       TYPE_ACPI_GENERIC_INITIATOR, gi->node);
> @@ -178,8 +190,22 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>      assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
>  
>      build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> +}
>  
> -    return 0;
> +static void build_all_acpi_generic_initiators(GArray *table_data)
> +{
> +    AcpiGenericInitiator *gi;
> +    guint i;
> +
> +    if (!acpi_generic_initiator_list) {
> +        return;
> +    }
> +
> +    /* Iterate array in insertion order */
> +    for (i = 0; i < acpi_generic_initiator_list->len; i++) {
> +        gi = g_ptr_array_index(acpi_generic_initiator_list, i);
> +        build_acpi_generic_initiator(gi, table_data);
> +    }
>  }
>  
>  typedef struct AcpiGenericPort {
> @@ -295,9 +321,8 @@ static int build_acpi_generic_port(Object *obj, void *opaque)
>  
>  void build_srat_generic_affinity_structures(GArray *table_data)
>  {
> -    object_child_foreach_recursive(object_get_root(),
> -                                   build_acpi_generic_initiator,
> -                                   table_data);
> +    build_all_acpi_generic_initiators(table_data);
> +
>      object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
>                                     table_data);
>  }
> -- 
> 2.34.1


