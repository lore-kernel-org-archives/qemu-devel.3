Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC67C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3gPz-0006oa-Lk; Mon, 07 Sep 2026 16:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3gPy-0006oL-2V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 16:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3gPv-00076t-HO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 16:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788814693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lcz6wnwBeUwmYk7g58pxo1+p1sMOqCjUDtVcuNfk6C0=;
 b=Svzl29+RcX8GL50MV8/yVZKGkd2B6yPrwDK6bYGbdRJCGcucw8fFO8dTm8FXWCyB1orfhC
 Z8ooiY/MKf4+JwIrb/UwvsxARwoMxm4ptkWEWdkfJfJhVh3Em6AZ7yZFvtaigOo88YM8vm
 xzYRdQBBrcGaefVr8ed4/wCFabZKBZo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-wVHG2FtFNGCJ4bm3U0uVCw-1; Mon, 07 Sep 2026 16:58:07 -0400
X-MC-Unique: wVHG2FtFNGCJ4bm3U0uVCw-1
X-Mimecast-MFC-AGG-ID: wVHG2FtFNGCJ4bm3U0uVCw_1788814686
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48439ef42d8so3198627f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788814686; x=1789419486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lcz6wnwBeUwmYk7g58pxo1+p1sMOqCjUDtVcuNfk6C0=;
 b=Mgxz5KXNffGckwE6qPhZG+KQVCRkPGv96cxeAUIclBU4MDy1qdxeoYbIt1PevSyNoY
 DgOdps+mmHXqfVd59zoWibqLn9fTo3iPo/l9tgleumolowbOrv1J2+wGX98ZSirxyn3r
 KjFMRsvy2GIh/vEEq3fxuZJAX6WYkaL/tVraKsIHhbWCLQsQfQEZTWz/yjV5KACdbRda
 WxC2J4oREyUmOrwuAk1fx1ncAXnwNRvmWev84hyfqbr0xQuTr1eQBA2J6aGjdWcEEliZ
 qCDlmc1+WKvP7xeHujBYg0N8FRDuUDgXmrxitLv0ZHA6wYfmYc2wzyeIKXGyZoKBFI8D
 qkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788814686; x=1789419486;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lcz6wnwBeUwmYk7g58pxo1+p1sMOqCjUDtVcuNfk6C0=;
 b=dnuvb7EcqqHRyagUL9cED/sjeAwFenIIvz5ELEC+PJODUXbe60baAAz9t1vWeDNCeG
 u1WPfWDykOBQ/yl0bkY65roE0sHVyzK/TBIdRfhryPnwaKNavAO4tZwI4grsJBG/wlmv
 pj6o2CDXWW7qgQbg19tNfNtcvLgufBAEKKrcTLNy8icfLJc2tzRoQe7qI0D6tFf2D0b4
 CnuKPNW4657tGY5oifiNcNzECmrVLJlTJJT6NcUNFw+K2fH5kkvI8+QWPeF11osqARty
 3AhoR81c9GmvpPFhlFGu0eYtL9+mo13wErollRyUBAmU7zEdcMHTVDbWUPeQUPBbjusb
 VHLA==
X-Gm-Message-State: AFuF++nELdRpwep3KFP7WDlZgmSh/I1itr3IOmber3zMT6KKSKYuTxuH
 MGKOnfZvMtb428cBKuFaP9qCXUPenvf8wCsruu/9MumwyfKuX2zOjl5z7+w8uSygl5+u91R+M+h
 GcyC23st6IMr/4v2w0Cq8emkmCGmACJEKGiTixNsrxy9mjStWaexi9HmW
X-Gm-Gg: AYBFou1Dx4mrWRAsf6xtP2tcDA3QShccAG09mlf2iMZ6805prpLeUIXMYwzCEFGBBAc
 ah0lmKxQjI7KTfuQPscXgAeoWtkMyysoIOkvCqWJDi4wNsE0n8RjzejW8FOhAjB/Q5NTgwNbvth
 O55GLd2Oh+hl4y5QR7gStprw9nCLJ4nzYhco1iySrtwc4Io/3T5qnAD0OI7pMOKl0i/xzZcRJdk
 WpUG43VqBNVewhtNJXwggbkUvxz72m0t6ByOClLNq8R8EG4cUI27Iv3yQ2DQIRiIlh5THmjh5Wd
 MNR9y/b/YXfdkgNE8t78NMMvlu0SMtBiBXSV6FWJqpQQN0L3fznzvo9OgT1jK6zoBfd+hvSCPmy
 0FgMn8tUyAkTzDcnMXsU1MfpAT1hKoxGdKW7SHhJKqQ==
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49cf826818dmr257818555e9.11.1788814685756; 
 Mon, 07 Sep 2026 13:58:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49cf826818dmr257818355e9.11.1788814685277; 
 Mon, 07 Sep 2026 13:58:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm29290976f8f.36.2026.09.07.13.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 13:58:04 -0700 (PDT)
Message-ID: <91423389-8f61-475d-8993-2966286f4f4f@redhat.com>
Date: Mon, 7 Sep 2026 22:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] igb: Add x-vf-migration property and DVSEC
 extended capability
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-2-clg@redhat.com>
 <20260903135736.6b527d04@shazbot.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260903135736.6b527d04@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/3/26 21:57, Alex Williamson wrote:
> On Wed,  2 Sep 2026 21:20:46 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
>> new file mode 100644
>> index 000000000000..4dfebd82344c
>> --- /dev/null
>> +++ b/hw/net/igb_migration.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * QEMU Intel 82576 SR/IOV VF Migration Support
>> + *
>> + * Copyright (c) 2026 Red Hat, Inc.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/pci/pci_device.h"
>> +#include "hw/pci/pcie.h"
>> +#include "igb_common.h"
>> +#include "igb_migration.h"
>> +
>> +static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
>> +{
>> +    IgbVfMigState *ms = &s->mig;
>> +    PCIDevice *dev = PCI_DEVICE(s);
>> +    uint32_t status;
>> +
>> +    status = ms->mig_state & IGB_MIG_STATUS_STATE_MASK;
>> +
>> +    if (err) {
>> +        status = IGB_MIG_STATE_ERROR | IGB_MIG_STATUS_ERR(err);
>> +    }
>> +
>> +    pci_set_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_STATUS, status);
>> +}
>> +
>> +
>> +bool igbvf_add_migration_dvsec(PCIDevice *dev, Error **errp)
>> +{
>> +    uint16_t offset = IGB_MIG_DVSEC_OFFSET;
>> +    uint32_t caps;
>> +
>> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_DVSEC, 1, offset,
>> +                        IGB_MIG_DVSEC_SIZE);
>> +
>> +    /* DVSEC header 1: length[31:20] | rev[19:16] | vendor_id[15:0] */
>> +    pci_set_long(dev->config + offset + 0x4,
>> +                 (IGB_MIG_DVSEC_SIZE << 20) |
>> +                 (IGB_MIG_DVSEC_VER << 16) |
>> +                 PCI_VENDOR_ID_INTEL);
> 
> Let's not co-opt an Intel DVSEC ID, we should use a vendor ID that we
> have a claim to, the RedHat/Qumranet one, I'd guess.  We may need to
> add DVSEC IDs to the spreadsheet for whoever is tracking Device IDs.
> Gerd?
> 
>> +
>> +    /* DVSEC header 2: DVSEC ID */
>> +    pci_set_word(dev->config + offset + 0x8, IGB_MIG_DVSEC_ID);
>> +
>> +    /* CAPS: features (state migration only) */
>> +    caps = IGB_MIG_CAP_F_STATE;
>> +    pci_set_long(dev->config + offset + IGB_MIG_CAPS, caps);
>> +
>> +    /* STATUS: initial state is RUNNING */
>> +    pci_set_long(dev->config + offset + IGB_MIG_STATUS,
>> +                 IGB_MIG_STATE_RUNNING);
>> +
>> +    /* BUF_ADDR_LO and BUF_ADDR_HI are writable */
>> +    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_LO, 0xff, 4);
>> +    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_HI, 0xff, 4);
>> +
>> +    return true;
>> +}
> ...
>> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
>> index 9a165c7063ee..30dfdb574ac7 100644
>> --- a/hw/net/igbvf.c
>> +++ b/hw/net/igbvf.c
>> @@ -38,27 +38,21 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/range.h"
>>   #include "hw/core/hw-error.h"
>>   #include "hw/net/mii.h"
>>   #include "hw/pci/pci_device.h"
>>   #include "hw/pci/pcie.h"
>> +#include "hw/pci/pcie_sriov.h"
>>   #include "hw/pci/msix.h"
>>   #include "net/eth.h"
>>   #include "net/net.h"
>>   #include "igb_common.h"
>>   #include "igb_core.h"
>> +#include "igb_migration.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   
>> -OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
>> -
>> -struct IgbVfState {
>> -    PCIDevice parent_obj;
>> -
>> -    MemoryRegion mmio;
>> -    MemoryRegion msix;
>> -};
>> -
>>   static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
>>   {
>>       switch (addr) {
>> @@ -199,10 +193,35 @@ static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
>>       return HWADDR_MAX;
>>   }
>>   
>> +static bool igbvf_addr_in_dvsec(uint32_t addr, int len)
>> +{
>> +    return ranges_overlap(addr, len,
>> +                          IGB_MIG_DVSEC_OFFSET, IGB_MIG_DVSEC_SIZE);
>> +}
>> +
>> +static uint32_t igbvf_read_config(PCIDevice *dev, uint32_t addr, int size)
>> +{
>> +    IgbVfState *s = IGBVF(dev);
>> +
>> +    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, size)) {
>> +        return igbvf_mig_config_read(s, addr, size);
>> +    }
>> +
>> +    return pci_default_read_config(dev, addr, size);
>> +}
>> +
>>   static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
>>       int len)
>>   {
>> +    IgbVfState *s = IGBVF(dev);
>> +
>>       trace_igbvf_write_config(addr, val, len);
>> +
>> +    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, len)) {
>> +        igbvf_mig_config_write(s, addr, val, len);
>> +        return;
>> +    }
>> +
>>       pci_default_write_config(dev, addr, val, len);
>>       if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
>>                                    "x-pcie-flr-init", &error_abort)) {
>> @@ -282,13 +301,27 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
>>       }
>>   
>>       pcie_ari_init(dev, 0x150);
>> +
>> +    if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
>> +                                 "x-vf-migration", &error_abort)) {
>> +        s->vfn = pcie_sriov_vf_number(dev);
>> +        s->migration_enabled = true;
>> +        if (!igbvf_add_migration_dvsec(dev, errp)) {
>> +            return;
>> +        }
> 
> The migration blocker noted later in the docs should be added here.
> Trivial to add, avoids the internal migration state being reset by the
> L0 VM being migrated, doesn't seem worth extending this driver's VMState
> while the feature is experimental.
> 
>> +    }
>>   }
>>   
>>   static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
>>   {
>>       PCIDevice *vf = PCI_DEVICE(obj);
>> +    IgbVfState *s = IGBVF(vf);
>>   
>>       igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
>> +
>> +    if (s->migration_enabled) {
>> +        igbvf_mig_state_reset(s);
>> +    }
> 
> Hmm, I think reset is more complicated that this.  This seems to define
> that any device reset will reset the migration state.  The vfio
> migration protocol only defines that a VFIO_DEVICE_RESET returns the
> device to running.
> 
> Consider the case of an FLR triggered by the L2 guest.  L1 QEMU passes
> through the config space write, that lands in vfio-pci core config
> space handling in the L1 variant driver, which turns into a
> pci_reset_function() in the L1 kernel and I think lands here in the L0
> QEMU.  Therefore, it seems like the L2 guest can corrupt the migration
> state.
> 
> As above, the migration state is defined to be reset via the RESET
> ioctl, which also turns into a pci_reset_function() in the L1 kernel.
> So L0 QEMU can't tell the difference here.
> 
> I think that means that the variant driver itself needs to own this
> part of the protocol, performing the migration state housekeeping on
> RESET ioctl, while both allow the state to persist on other resets.  In
> that sense QEMU cannot emulate this DVSEC as normal config space, it's
> a persistent control plane that lives in the VMM and happens to be
> accessed through config space.  Thanks,


Hi Alex,
  
You are right. The key principle: The DVSEC is a persistent control
plane living in the VMM, not device state. Device reset (VFIO ioctl
and L2 FLR) resets the device, not the mailbox. The variant driver
owns the reset, not the emulated device in L0 QEMU.

I missed two things : 1. transferring the DVSEC hiding (as it was done
for the mig BAR) and 2. reset of migration state.

Looking closer at it, the changes are small.

In QEMU:

The cold boot initialization sets all fields to defaults (zero). The
only change from today is that the initial state is ERROR, which means
migration isn't operational until the driver binds. The variant driver
activates the control plane by cycling the machine state to RUNNING.

The VF functional registers (queues, DMA rings, interrupts ... ) are
reset normally by igb_core_vf_reset(), and the migration control plane
(IgbVfMigState) persists in memory. It survives pci_do_device_reset()
and the variant driver sets the fields as needed through the normal
DVSEC command flow.

BUF_ADDR could be restored from the IgbVfMigState cache values since
it's a RW reg, but even that isn't a strong requirement.

So igbvf_mig_state_reset() is no longer needed in the reset path.
That's all for QEMU.

Driver :

Variant driver owns all the cleanup after reset: closes migration fds,
disables dirty tracking, reads and cycles the DVSEC state back to
RUNNING.

The first path, VFIO_DEVICE_RESET, needs a custom ioctl handler to run
the cleanup.

Second path, L2 FLR. To hide the DVSEC range from the L2 guest, the
driver implements custom VFIO config space reads and writes. The
config write handler can detect the FLR and implement the same cleanup
logic.

That's for v3.

Thanks,

C.



