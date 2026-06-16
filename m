Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE657CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTpR-00076R-4W; Tue, 16 Jun 2026 09:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZTpP-0006xt-8I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZTpN-0005xp-2h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 816B1418FE;
 Tue, 16 Jun 2026 13:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738E21F00A3F;
 Tue, 16 Jun 2026 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781616459;
 bh=0rOX7oqrz4F1I9mioWQ4LncFjgANd9LJdCpcf1wQ7Cw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=C/xEKhr6oWET9seuL8P3ngot9UC7LJZUGuWDq0dOYRoM9Z5oJx0TQT1f9Z4XAWC+h
 mLFLn0K3AAttFwjv2ikkGfc4bK8xkHTevit9ISBT/OF4nc/ZC6f5y5LBGGnXzAwtq7
 hJjZk2GG2rqZtGPxkOM0tSpwwmdWuBhV8IzIZxQwH77B4ynLK4YFB06AFsmdBFA/tT
 6bQdgwN+1uL+Kb0iIkZ0fKvFK0GWL+kN+OhxZXZwvYosjOiei0ZilTNoLxSttV9J/a
 TZtPxrm87GtI67Ts7LDGVlRZm2Uk8RB3V+hc4QtPl+7w03KSPorKIkAKx8/5wKGWNP
 KfKQ2zdnKge8w==
Date: Tue, 16 Jun 2026 14:27:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Message-ID: <20260616142730.7fb0a465@jic23-huawei>
In-Reply-To: <20260609105836.3702787-2-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>
 <20260609105836.3702787-2-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  9 Jun 2026 16:28:29 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> Move the 'flitmode' property from PCIESlot to PCIEPort. This change
> allows all the derived ports (PCIe ports or CXL ports) to use this
> property.
> 
> This is a structural refactor only. There is no functional change in
> existing behavior.
> 
> Note: This property was added from Davidlohr's BI patch series[1].
> 
> [1]: https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/
> 
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
This seems fine to me other than one small thing below.

Given the main changes are in PCIe code though it'll need review from
appropriate maintainers.

> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 0ee18ef5c3..df69c5200f 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c

>  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 1de0b1e4fd..d452199d85 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>      }
>  
> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
> +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);

I think we should use a cast to the parent object type rather than going directly
into s->parent_obj.  PCIE_PORT(s)->flitmode.

>  }


