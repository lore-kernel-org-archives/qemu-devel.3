Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6645606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPnI3G5X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRDNH-00007n-8J; Wed, 11 Nov 2026 13:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRDNC-0008Vj-67; Wed, 11 Nov 2026 13:48:42 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xRDN9-000686-Vk; Wed, 11 Nov 2026 13:48:41 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6300663285;
 Wed, 11 Nov 2026 18:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3441F00A06;
 Wed, 11 Nov 2026 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794422916;
 bh=sIzJZ1rz5oCWqX8e6H6QmXB0Qewr1m4B6vxthdmI3T0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LPnI3G5XUaHfwwxvfl0aFBoY/fwdQ5EgQRhLWGq+quSWZ0zwbYDbTZL6uNV7Fl3gU
 dKNsG81vvI5i7ksVLyMwIAuJYYn/pA0Lwnz8HqtD/stx7cCTnheQPma6Ek8ax7eWkd
 u2cF0a01rl9Sxqg/mp9YGga9o+lahlUOLsrWms53MJFbkCK2XiFryzOxKwQOb3hALU
 wHDpIdveWkW83nXnejpVUDoDWY9cJOOQHBk4KPMG9wF9GHCDX4UUKCUoHIgQ4a4xZD
 7y1zeik6lcxrW5ABjfOsS9S45Yxie5urI+LBRBIGps2WFSEK8B3bCVqVbH2ry+r3Id
 KdzFDQSi+bEVQ==
Date: Wed, 11 Nov 2026 10:48:34 -0800
From: Drew Fustini <fustini@kernel.org>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [PATCH v7 4/6] hw/riscv: implement CBQRI bandwidth controller
Message-ID: <avS4gmUdTuByzCnb@thelio>
References: <20261101-riscv-ssqosid-cbqri-v7-0-92d1aae43e48@kernel.org>
 <20261101-riscv-ssqosid-cbqri-v7-4-92d1aae43e48@kernel.org>
 <c9bc3a82-61ea-491a-ab1f-0e09e6d55a54@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bc3a82-61ea-491a-ab1f-0e09e6d55a54@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 10:09:29AM -0300, Daniel Henrique Barboza wrote:
> On 11/1/2026 5:25 PM, Drew Fustini wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Implement a bandwidth controller according to the Capacity and Bandwidth
> > QoS Register Interface (CBQRI) which supports these capabilities:
> > 
> >    - Number of access types: 2 (code and data)
> >    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> >    - Event IDs supported: None, Total read/write byte count, Total
> >                           read byte count, Total write byte count
> >    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> > 
> > The controller gives the Linux resctrl support for CBQRI a device to
> > configure and read back bandwidth limits per RCID on the virt machine.
> > Only the register interface is modeled. The configured limits are not
> > enforced and the monitoring counters are always marked INVALID because
> > QEMU does not model memory bandwidth usage.
> > 
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: rpfx and p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> 
> LGTM overall.  A few comments:

Thanks for reviewing!

[..]
> > +typedef struct BandwidthAllocation {
> > +    uint32_t Rbwb:16;
> > +    uint32_t Mweight:8;
> > +    uint32_t sharedAT:3;
> > +    bool useShared:1;
> > +} BandwidthAllocation;
[..]
> I believe BandwidthAllocation could be renamed to RiscvCbrqiBandwidthAllocation for
> naming consistency.

Good idea, I'll change it.

> > +#define RISCV_CBQRI_BC(obj) \
> > +    OBJECT_CHECK(RiscvCbqriBandwidthState, (obj), TYPE_RISCV_CBQRI_BC)
> > +
> > +/*
> > + * All bandwidth allocation records are contiguous to simplify
> > + * allocation. The first one is used to hold the BC_BW_ALLOC register
> > + * content, followed by respective records for each AT per RCID.
> > + *
> > + * Records are indexed by the AT encoding, so each RCID has one record
> > + * per AT value whether or not the controller supports the code access
> > + * type. is_valid_at() rejects an unsupported AT before a record is
> > + * selected.
> > + */
> > +static unsigned int bw_alloc_index(uint32_t rcid, uint32_t at)
> > +{
> > +    assert(at < BC_NB_ATS);
> 
> Please use g_assert() instead of assert().

Okay, I will change it.

[..]
> > +static void riscv_cbqri_bc_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    dc->realize = riscv_cbqri_bc_realize;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    dc->desc = "RISC-V CBQRI Bandwidth Controller";
> > +    device_class_set_props(dc, riscv_cbqri_bc_properties);
> > +    dc->legacy_reset = riscv_cbqri_bc_reset;
> 
> We're moving away from legacy_reset for new devices.  We're now declaring a Resettable
> interface and setting reset phases.
> 
> For this device a simple way of doing it is to slightly change th reset callback params:
> 
> 
> static void riscv_cbqri_bc_reset(Object *obj, ResetType type)
> 
> And then during class_init:
> 
>     ResettableClass *rc = RESETTABLE_CLASS(klass);
> 
>     rc->phases.hold = riscv_cbqri_bc_reset;

Thanks for letting me know. I will switch to the Resettable interface.

[..]
> > +DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> > +                                   const RiscvCbqriBandwidthCaps *caps)
> > +{
> > +    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_BC);
> > +
> > +    qdev_prop_set_uint64(dev, "mmio_base", addr);
> > +    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
> > +    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
> > +    qdev_prop_set_uint16(dev, "nbwblks", caps->nbwblks);
> > +    qdev_prop_set_uint16(dev, "mrbwb", caps->mrbwb);
> > +
> > +    qdev_prop_set_bit(dev, "at_code",
> > +                      caps->supports_at_code);
> > +    qdev_prop_set_bit(dev, "alloc_op_config_limit",
> > +                      caps->supports_alloc_op_config_limit);
> > +    qdev_prop_set_bit(dev, "alloc_op_read_limit",
> > +                      caps->supports_alloc_op_read_limit);
> > +    qdev_prop_set_bit(dev, "mon_op_config_event",
> > +                      caps->supports_mon_op_config_event);
> > +    qdev_prop_set_bit(dev, "mon_op_read_counter",
> > +                      caps->supports_mon_op_read_counter);
> > +    qdev_prop_set_bit(dev, "mon_evt_id_none",
> > +                      caps->supports_mon_evt_id_none);
> > +    qdev_prop_set_bit(dev, "mon_evt_id_rdwr_count",
> > +                      caps->supports_mon_evt_id_rdwr_count);
> > +    qdev_prop_set_bit(dev, "mon_evt_id_rdonly_count",
> > +                      caps->supports_mon_evt_id_rdonly_count);
> > +    qdev_prop_set_bit(dev, "mon_evt_id_wronly_count",
> > +                      caps->supports_mon_evt_id_wronly_count);
> > +
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    return dev;
> > +}
> 
> We don't have any callers for riscv_cbqri_bc_create() in the series so I can't
> see how the intended use would be.  In particular with the RiscvCbqriBandwidthCaps *caps
> attribute.

Good catch. They were for the fixed example SoC for v1 back in the 2023
v1. v2 switched to -device and nothing has called them since.

> Note that riscv_cbqri_bc_create() is blindly applying all settings from 'caps' to
> the device.  This is fine, but note that extra care is required when retrieving 'caps'
> w.r.t the defaults established.
> 
> E.g. in riscv_cbqri_bc_properties[] we have:
> 
> > +    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriBandwidthState, nb_mcids, 256),
> 
> > +    DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb, 819),
> > +
> > +    DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
> > +                     supports_at_code, true),
> 
> 
> Now let's say that we'll add the device in the 'virt' machine, and I want to change just
> nb_mcids to 512 and nothing else. If I do this:
> 
> 
> RiscvCbqriBandwidthCaps caps = {.nb_mcids = 512};
> 
> (...)
> 
> riscv_cbqri_bc_create(addr, &caps);
> 
> 
> 
> I'll create a TYPE_RISCV_CBQRI_BC nb_mcids = 512 and everything else will be zeroed, disregarding
> all defaults from riscv_cbqri_bc_properties[].
> 
> 
> My suggestion here is to create a riscv_cbqri_bc_caps_init(RiscvCbqriBandwidthCaps *caps) helper
> that callers can use to set the struct defaults first.  We would then do:
> 
> 
> RiscvCbqriBandwidthCaps caps;
> 
> riscv_cbqri_bc_caps_init(caps);
> caps.nb_mcids = 512;
> 
> (...)
> 
> riscv_cbqri_bc_create(addr, &caps);
> 
> 
> We have precedent for this pattern - most RISC-V boards use riscv_boot_info_init() to init
> a boot_info struct.

Thanks for the guidance. I will add riscv_cbqri_bc_caps_init() and
riscv_cbqri_cc_caps_init() to set the property defaults in the caps
struct.

Thanks,
Drew

