Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16266CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 19:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Ziz-000691-1X; Wed, 08 Oct 2025 15:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v6Ziv-00066a-R1
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:21:18 -0400
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v6Zim-0001eb-HV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:21:16 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0C4AC6C232C;
 Wed, 08 Oct 2025 19:21:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com
 (trex-green-1.trex.outbound.svc.cluster.local [100.114.113.86])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 770236C27FF;
 Wed, 08 Oct 2025 19:20:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759951255; a=rsa-sha256;
 cv=none;
 b=caatB9lKE6zFG2TYUIK2nDq5xa9HJTnWFm08nWtEEpHqAu+n4OPkqoA2IZ2KVDSRNLVXPA
 55hBwGLyGH37y9uj0EU0DF6cLIUEtKhy2PbEXUiseP7LC31hi8PVeAMHZbYevyGe7NRzD0
 1+az3k3MBaVHLyWHX/YTPqfknRY6Foq+hRtitA6r3MjmO6T6XvdX/67fUYZqRBkYtxkanb
 Fzb9MmHCXgOi9QbqOR3Nx98BFfc60i5V0F5y3UvorBZcWBuGeqn2ChVmOIWv4/eSRE+fba
 HiYZwqe8ENujw1g3x7EECIWoZVnElhb794Jt8Tno8ryrQeCcvWc5cVNFJMvuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1759951255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=KJ1Op03WI2x/dk6yMtHipbmkKXsf9y6mdKjG6wS82Uk=;
 b=fr+K3V4OlfouC5rTLKU/Jj2axnNITU0+efOEN/ra5VxHHHmh/n8b6YnA7oZjs3eQBnq5qH
 unQhrfu/VyIuhZwZDKdcwgKSZoBmCJLGxqQnGgCs824j80P/xpeMEFaw6XKkJ+T56aALmw
 dqQJ+nU9n1dJjIEgXxk3hM87QYETM14nMh1GrY7n4O35ekfPk6cBeQ2jQahnLAkf7LAvfD
 CbiGI/npWQ5wnX+eBN46ChaIIWKDGG5JsUXp1Qf0UL7myO134D6OTm6479zJGIVArzLZDJ
 pCuHtX0JGzObBLx/wNbAEaRI6bVVcibCIRyR9ARCWWVbUEfIQWZF5camjSLYtw==
ARC-Authentication-Results: i=1; rspamd-777888ddf6-5t7sn;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Invention: 20e519c20c392525_1759951259799_2734449751
X-MC-Loop-Signature: 1759951259799:1509360160
X-MC-Ingress-Time: 1759951259799
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.114.113.86 (trex/7.1.3); Wed, 08 Oct 2025 19:20:59 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4chjXQ5mv3z47; 
 Wed,  8 Oct 2025 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1759951255;
 bh=KJ1Op03WI2x/dk6yMtHipbmkKXsf9y6mdKjG6wS82Uk=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=B+ybFnG4DRj+yPK8mQnnNSvIhAQY5Mp44HgRAMreERHPHqSfFsT8fCF07nIH7+GsW
 T2vLgUUhtszPgXGn6n3tkn7d3bw2URR/TmnBkj9/xVhHNtXavaXIHaxYy+mMPQ5xL2
 Cr3Z/i9+vwtM8xbaGAOF/ODaYAmlFiSivIH3F9/uBGb776PCkmU1cgmhgN07gmEANZ
 e+o7g9IFzU42VgA6Ix7Yf3dlPE3PYjbQfoHdsvll9ynO8O2WhnqsFLGOSN1A154Dbn
 KZLZrGWcHupj75xMVY5u+IXm6HJOx8PLIviUIy30KZAZ5z+bWM2WsJ1CGNMjvXHdpV
 ANxlal637ToVw==
Date: Wed, 8 Oct 2025 12:20:52 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: ira.weiny@intel.com, lucerop@amd.com, a.manzanares@samsung.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, ravis.opensrc@micron.com
Subject: Re: [PATCH 1/5] hw/pcie: Support enabling flit mode
Message-ID: <20251008192052.hu5qtgdcvwwoz42n@offworld>
References: <20250930032153.1127773-1-dave@stgolabs.net>
 <20250930032153.1127773-2-dave@stgolabs.net>
 <20250930161903.00006583@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250930161903.00006583@huawei.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 30 Sep 2025, Jonathan Cameron wrote:

>On Mon, 29 Sep 2025 20:21:49 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
>> fundamental change in how data is transmitted over the bus to
>> improve transfer rates. It shifts from variable-sized Transaction
>> Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).
>>
>> As with the link speed and width training, have ad-hoc property for
>> setting the flit mode and allow CXL components to make use of it.
>>
>> For the CXL root port and dsp cases, always report flit mode but
>> the actual value after 'training' will depend on the downstream
>> device configuration.
>>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr,
>
>A few comments inline. Main one is that I think we need the CAP to still
>say we support 68B flits on the CXL devices and just mess with the
>status.
>
>> ---
>>  hw/mem/cxl_type3.c                        |  9 ++++++---
>>  hw/pci-bridge/cxl_downstream.c            | 11 +++++++----
>>  hw/pci-bridge/cxl_root_port.c             | 11 +++++++----
>>  hw/pci-bridge/cxl_upstream.c              | 19 +++++++++++--------
>>  hw/pci-bridge/gen_pcie_root_port.c        |  1 +
>>  hw/pci/pcie.c                             | 23 +++++++++++++++++++----
>>  include/hw/cxl/cxl_device.h               |  1 +
>>  include/hw/pci-bridge/cxl_upstream_port.h |  1 +
>>  include/hw/pci/pcie.h                     |  2 +-
>>  include/hw/pci/pcie_port.h                |  1 +
>>  10 files changed, 55 insertions(+), 24 deletions(-)
>>
>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>> index c4658e0955d5..891b75618892 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -533,9 +533,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>>                                 GPF_DEVICE_DVSEC_REVID, dvsec);
>>
>>      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
>> -        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
>> +                                   /* 68B (maybe), IO, Mem, non-MLD */
>> +        .cap                     = ct3d->flitmode ? 0x6 : 0x26,
>
>Do we need this capability bit change?  The bit says the device is capable of doing it,
>not that we currently are.   I think from a spec point of view we aren't allowed to
>not support this.  Applies int the various other places as well.

I agree, we should leave it alone, for which when in flitmode lspci shows:

		FBCap:	Cache- IO+ Mem+ 68BFlit+ MltLogDev- 256BFlit- PBRFlit-

... noting that that misleading 256BFlit- output is dependent on bit 13 (as reported
by Ravi), but that in fact is the latency optimized version, which is not mandatory.

>
>>          .ctrl                    = 0x02, /* IO always enabled */
>> -        .status                  = 0x26, /* same as capabilities */
>> +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */
>
>This is correct but if we do leave teh cap alone we probably need to note
>that flitmode means we aren't in the old 68B flit mode.

		FBSta:	Cache- IO+ Mem+ SynHdrByp- DrftBuf- 68BFlit- MltLogDev- 256BFlit- PBRFlit-

... which that 68BFlit- in fact implies regular 256B flit mode.

Thanks,
Davidlohr

>
>>          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
>>      };
>>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>> @@ -1501,7 +1502,8 @@ void ct3d_reset(DeviceState *dev)
>>      uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
>>      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
>>
>> -    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
>> +    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
>> +                              ct3d->flitmode);
>>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>>      cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
>>
>> @@ -1540,6 +1542,7 @@ static const Property ct3_props[] = {
>>                                  speed, PCIE_LINK_SPEED_32),
>>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
>>                                  width, PCIE_LINK_WIDTH_16),
>> +    DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
>>      DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
>>  };
>>
>> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
>> index 6aa8586f0161..f8d64263ac08 100644
>> --- a/hw/pci-bridge/cxl_downstream.c
>> +++ b/hw/pci-bridge/cxl_downstream.c
>
>>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index eaeb68894e6e..cc8e7c3cbf3f 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>
>> @@ -1106,6 +1111,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>>      if (!target || !target->exp.exp_cap) {
>>          lnksta = lnkcap;
>>      } else {
>> +        uint16_t lnksta2;
>> +
>>          lnksta = target->config_read(target,
>>                                       target->exp.exp_cap + PCI_EXP_LNKSTA,
>>                                       sizeof(lnksta));
>> @@ -1119,6 +1126,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>>              lnksta &= ~PCI_EXP_LNKSTA_CLS;
>>              lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
>>          }
>> +
>> +        lnksta2 = target->config_read(target,
>> +                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
>> +                                      sizeof(lnksta2));
>> +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
>> +                                     PCI_EXP_LNKSTA2_FLIT);
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2, lnksta2 &
>> +                                   PCI_EXP_LNKSTA2_FLIT);
>
>Odd linewrap. Kind of makes some sense for the linksta one I guess you based this
>on but here, we can fit the whole parameter on one line.
>
>
>>      }
>>
>>      if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
>

