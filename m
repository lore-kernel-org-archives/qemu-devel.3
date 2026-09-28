Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E12C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6Lq-0000Xp-Rm; Mon, 28 Sep 2026 04:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB6Ln-0000V8-EA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB6Lk-0006u7-R9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790582674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7zGMNSGiOBiHw0UbHXwSN1rcLKnYYbiB05VA7qKpNc=;
 b=B7FXSjYCw1OiQWEoNdUpiqz2jIRh0WJ7YuvVA82EJzylUJHGb4V57zarNkcBW5G2NRnwsX
 JLMN6r0DnsDsqtzoadYcA54e+QcUCHiDY8FRsAzfw5AH2Cg/ujZuRXJGsd7rye8QcDYjyi
 6pjkY5WyVtzRGwf7Pe7klPnIZULJLd0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-hnZsQRq1OnKuADxcTQPV2w-1; Mon,
 28 Sep 2026 04:04:32 -0400
X-MC-Unique: hnZsQRq1OnKuADxcTQPV2w-1
X-Mimecast-MFC-AGG-ID: hnZsQRq1OnKuADxcTQPV2w_1790582671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F4EA1800623; Mon, 28 Sep 2026 08:04:31 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4657B1800473; Mon, 28 Sep 2026 08:04:30 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:04:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/pci-bridge: honour CONFIG_CXL in PXB
Message-ID: <arofcCkkCUgow61-@redhat.com>
References: <20260922115613.1926083-1-berrange@redhat.com>
 <bdfbdd6f-afae-46ea-9de4-70191b9e42a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdfbdd6f-afae-46ea-9de4-70191b9e42a3@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 26, 2026 at 12:12:52PM +0200, Philippe Mathieu-Daudé wrote:
> On 22/9/26 13:56, Daniel P. BerrangÃ© wrote:
> > If CONFIG_CXL=n is added to the Kconfig, the build fails to link
> > the PXB device:
> > 
> > /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
> > /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
> > /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
> > /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'
> > 
> > Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index 40ffbc4e082..8977243a804 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -123,12 +123,14 @@ static const TypeInfo pxb_pcie_bus_info = {
> >       .class_init    = pxb_bus_class_init,
> >   };
> > +#ifdef CONFIG_CXL
> >   static const TypeInfo pxb_cxl_bus_info = {
> >       .name          = TYPE_PXB_CXL_BUS,
> >       .parent        = TYPE_CXL_BUS,
> >       .instance_size = sizeof(PXBBus),
> >       .class_init    = pxb_bus_class_init,
> >   };
> > +#endif /* CONFIG_CXL */
> This does not build:
> 
> FAILED: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o
> ../hw/pci-bridge/pci_expander_bridge.c:126:8: error: attempt to use poisoned
> "CONFIG_CXL"
>   126 | #ifdef CONFIG_CXL
>       |        ^

Doh, I'm sorry, I tested with CONFIG_CXL *removed* from the default
devices list, and clearly failed to then re-test with it added back :-(

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


