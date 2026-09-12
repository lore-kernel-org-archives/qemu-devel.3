Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBFFC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5JrV-0002m5-NC; Sat, 12 Sep 2026 05:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5JrS-0002lq-9z; Sat, 12 Sep 2026 05:17:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5JrQ-0004cR-3K; Sat, 12 Sep 2026 05:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789204607; bh=yEf6zrh0FkpBp5VRN9w7S5TZ0QWnGIeRGwTsdvItsZM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tzbzAsCpqXF5DN9y/6GxVvoQjRjyWfhfCGc/QmVVNj7JNbZjbYgqTv1p/KZGEXivr
 LQnsOZzoqKTWjskTVTeF/uR40YNvyHQZMGME5sC5zR8WMfbqDxDXgu1xCrQ4dnHcM+
 nTHXBuUQF+JIebXlYcK+Ui9nN6y8CxuANsW1D4NimBh4+7HjNboOTenLa5Q4C6B8rf
 RaU/fYZqndG/v3DbYWf716+yWWUeMelcJl4iarQx0BD9NJl/IRWZRYUSAY1DIr5CEP
 Ejs+7e0JDIjHTdOoZgoeFBgmRbf62vG3j8TQMf6UiiBDenFAK7Xl55+uHK71TwMtp9
 S+s7lYYXfodtw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A37631D3F8D;
 Sat, 12 Sep 2026 12:16:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 399684264D8;
 Sat, 12 Sep 2026 12:17:22 +0300 (MSK)
Message-ID: <408b15ae-4a61-4082-9b19-800f2f934bcc@tls.msk.ru>
Date: Sat, 12 Sep 2026 12:17:22 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC
 when sn= is set
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: mst@redhat.com, Shrihari E S <shrihari.s@samsung.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260831022302.406740-1-junjie.cao@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260831022302.406740-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/31/26 05:23, Junjie Cao wrote:
> ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
> four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
> With sn= the Device Serial Number capability pushes the block to
> 0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
> the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
> catches this -- pcie_add_capability() checks bounds, not overlap, and
> the chain still walks because the DVSEC's next pointer becomes 0x190,
> inside its own body.  Most cxl-type3 examples in
> docs/system/devices/cxl.rst set sn=.
> 
> Derive the offset from the DVSEC block instead, as cxl_upstream.c
> already does.  Without sn= the layout is unchanged byte for byte; with
> sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
> type 3 device has no VMStateDescription, so its config space never
> reaches the migration stream.
> 
> Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

This feels like a qemu-stable material.  I'm picking it up, but please
have qemu-stable@ in mind when the change is worth picking up for the
older stable releases.  And please let me know if I should not pick it up.

Thanks,

/mjt

> ---
> Found while walking the extended capability chains for the UIO/SVC RFC
> V2 review; independent of that series.
> 
> Tested at bde2492aac on q35 (pxb-cxl / cxl-rp / cxl-type3), dumping the
> capability chain and raw config bytes from the guest with and without
> sn=: the Flex Bus DVSEC keeps its full 0x20 bytes and the DOE sits at
> 0x19c; without sn= the bytes are identical before and after.  cxl-test
> 12/12.
> 
> On cxl-2026-03-25-draft REG_LOC_DVSEC_LENGTH is 0x34, so the overlap is
> there without sn= too; with this change the DOE lands at 0x1a0/0x1ac.
> cxl-2026-01-09-draft also fixes doe_comp at 0x1b0, which would then
> collide -- the two want chaining.
> 
>   hw/mem/cxl_type3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 28f41fa623..e6eb2e0cba 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>       }
>   
>       /* DOE Initialization */
> -    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
> -                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
> +                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
>   
>       cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
>       cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
> 
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475


