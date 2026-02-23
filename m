Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4465E98DEF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 07:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQMa-0004Hw-Df; Mon, 23 Feb 2026 02:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuQMZ-0004Ho-9I
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuQMX-0005kL-5c
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771831690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ql62sgQpESqAHw8IeepxHilxQcPVR34tWpH69aNGeVA=;
 b=HHWkjT/x57FSY4QZusN2ZOYUW+IWvhJJ/5F+RAhA6QFUHp4XI3uQ5iFCB8EUe2iqFg620+
 rjRswvt/Yuqa8H0B5jjIW6P49WePjNUZXrdySywm6P06AUwaAQbCJ4MCMlAtC5jz63Zf4B
 ctEYa6TT0nR9YtvpUs6G/Drc0HEQioo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-ADg6lJLZOGGGFoQxsHMzaQ-1; Mon, 23 Feb 2026 02:28:08 -0500
X-MC-Unique: ADg6lJLZOGGGFoQxsHMzaQ-1
X-Mimecast-MFC-AGG-ID: ADg6lJLZOGGGFoQxsHMzaQ_1771831687
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so49483245e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771831687; x=1772436487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql62sgQpESqAHw8IeepxHilxQcPVR34tWpH69aNGeVA=;
 b=a4BgD1Un2rDsIi9C5ZHOB14skFY+uM4xqi05SgRsdjlU/AkRXhNFcvwJs0deeRfcBK
 cRuUv68GqM77hxPzwgRAVY09AOh6Dud0gMf1ufBI8aYFcub2DntVnxNLiNwVUZCektEJ
 FbbNnWjySaop/1FoEcxRh1Y4hXWblEMZD92fCh852h9fKeV007F9J10W7nQGLST7psjk
 ou5G5dn2b40Qq23DSSfVkh+lp1noKY6lMc0NQaxHLiLna0Y1tCv3dndmDkrvHCi1KrB/
 SPUgBUNDQkrwa3QFayliMQJbcVoiDFEfwjqmk47ayjOaUwuHuno9xbaukad5Q6m+fomZ
 jVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771831687; x=1772436487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ql62sgQpESqAHw8IeepxHilxQcPVR34tWpH69aNGeVA=;
 b=lC4vvHNdYkyQJk1uC8B084nUt0LsZQg2cxtsAPr5co/TrQGafHn/XgxEpoWKKCL+Km
 k9u1T0ylqGN57O7CE3HcVIpOmW1oa4fzNj5VrTSNiS86iV9jOjPFY1xNt10SRBhBwMlc
 C8rVDdlotZakmNUb8AkAaJ16TGiWpGqDH+5PVIDfnuY7QsFtwRgKW4C47DqMGmTBNDN5
 HC+19+8s9VAE/rd42tX8e0BF/GUv+OxmzlHCOdmZ9O2srYtSdpqDYcJL4+dm3Zkp8DbF
 KJcsu1qu1gktntW+gnYWLf0b7PGj5sKn2eLa839uOTqb6XHMAC6aAtp39hmhKIZKaKxc
 oEGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/vPHvYJ2/4oMI7XhGrVM7PnFTfnO/MDQ9eopsvLheQiD4R4i423buSzfnvB9CM/TXADbV0IH4oQBL@nongnu.org
X-Gm-Message-State: AOJu0Yz0V7u6+PxBH1XPCN/+I4ADI2saiB5OUagWmwwEX00akY47ksqB
 PXwZmeB1PpLa8Csj/KfgFzsE5TCbZidNpdtiNWU4NYfVApjcuHLYLuEIwJ+mCJGhhhtemx643Gg
 aGperPYf7VFNiC9/AEAGchghRgg3ImRaSnfrzA3W9hRu1yK8TraUoRcBw
X-Gm-Gg: AZuq6aLf0Py69RoXToG9fk6sX5+O+ms7XKoU+Grny60Arq3AiAw1EKHvARvZ7dGO7uS
 yCyYtlLIVQ4fyVmgzk+UW+5s5EaJk6TegKFKdvlRNty3h7FD0LvYJq7bndJdIG0fyvnSjz5OU+W
 ofaV4ljpjj2kxoKxdP0QwQaDreduyRRCzR3nzug7uIkgu/t4r5iRwfhk+XZRamZPWhYvbiPS2Cb
 LmP9NDorwJ1DmmIURwwvhd6imeiKP3vzMZfDh7P8Q7lqUMXpSW5lJ5FlIlzPzg7jRwsR4Pvilrq
 WZ5hP+wrenV7q+0y/6aEZDnxAQQIJpDLnZHYavRx6l5kte/W/kOpsM+sNBDFxqCFfcSonnrxmHG
 6/+66ug==
X-Received: by 2002:a05:6000:40ca:b0:436:233c:c7c1 with SMTP id
 ffacd0b85a97d-4396f15a797mr12818938f8f.23.1771831687007; 
 Sun, 22 Feb 2026 23:28:07 -0800 (PST)
X-Received: by 2002:a05:6000:40ca:b0:436:233c:c7c1 with SMTP id
 ffacd0b85a97d-4396f15a797mr12818908f8f.23.1771831686540; 
 Sun, 22 Feb 2026 23:28:06 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fc12sm14960673f8f.24.2026.02.22.23.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 23:28:06 -0800 (PST)
Date: Mon, 23 Feb 2026 08:28:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: <ankita@nvidia.com>
Cc: <vsethi@nvidia.com>, <jgg@nvidia.com>, <skolothumtho@nvidia.com>,
 <alex@shazbot.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260223082804.0d293861@imammedo>
In-Reply-To: <20260222020812.26475-1-ankita@nvidia.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, 22 Feb 2026 02:08:12 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> During creation of the VM's SRAT table, the generic initiator entries
> are added. Currently the order in the entries are not controllable from
> the qemu command. This is due to the fact that the code queries the
> object tree which may not be in the order objects were inserted.
> 
> As a fix the patch maintains a GPtrArray of generic initiator objects
> that preserves their insertion order. Objects are automatically added
> to the array when initialized and removed when finalized. When building
> the SRAT table, objects are processed in the order they were first
> inserted.

so question would be, why does it matter?
Is ther a requirement in spec for SRAT entries being put in a particular order?

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
>  hw/acpi/pci.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index 8c7ed10479..d97e6e9105 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -88,18 +88,30 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
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
> +    }
>      g_free(gi->pci_dev);
>  }
>  
> @@ -145,20 +157,15 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
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
> @@ -178,8 +185,22 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
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
> @@ -295,9 +316,8 @@ static int build_acpi_generic_port(Object *obj, void *opaque)
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


