Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFD606EE8F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icD+HxN2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgXe-000543-FG; Wed, 04 Nov 2026 14:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgXc-00053b-Ms
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:21:00 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xOgXa-0000JF-MV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:21:00 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2B9B402B8;
 Wed,  4 Nov 2026 19:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FA1F00A15;
 Wed,  4 Nov 2026 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793820056;
 bh=15TE1HJmTIqQgz1bY0wxN9TqpKz0XLV7CztDGaFfUe0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=icD+HxN2H43iq8QPYXtali6JgzNhdPlFw+IMCWuyY7CHL2rxHkQ+no1JEQufc2aCd
 prd7yTIy90DEYlCBfE4wSIRCfcquW7Hcpasihh6rrLVDyzh/q0IsOIL57YvVTLGo1W
 bG3/v9vZp7nYKJ2LXNfZ1XKBaEMpLyWJmogoDAC6az1w0XTb5Ir5KZzNY5SGRJh7KY
 xok3vNFxmUWWeFBdR+Pw7YCnmOmKBCfUnUVQwm1BZVZZa1bCUIBQNwQ+9iqhTgBAfv
 /owoLuI7UAluxqmziE2j/oaZxEhZD2utxs9Zw5VoOT6qEIba9kGHJpMpQI7MUAwP5m
 OQAFq7hifRnVw==
Date: Wed, 4 Nov 2026 19:20:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] hw/pci-bridge: Add pcie_add_dvsec_capability helper
Message-ID: <20261104192049.50d38b2f@jic23-hlaptop>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-1-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-1-212d2409563e@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 15:05:10 +0000
Jim MacArthur <jim.macarthur@linaro.org> wrote:
Hi Jim,

Some description is always good. Maybe in this case a spec reference
would be appropriate.


> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci/pcie.c         | 16 ++++++++++++++++
>  include/hw/pci/pcie.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42bcb9206d..42c4997b42 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1157,6 +1157,22 @@ void pcie_add_capability(PCIDevice *dev,
>      memset(dev->cmask + offset, 0xFF, size);
>  }
>  
> +/*
> + * Add a DVSEC capability. As per pcie_add_capability, the caller must
> + * ensure (offset, size) does not overlap any other capability or extend
> + * past the extended configuration space.
> + */
> +void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
> +                               uint8_t version, uint32_t offset,
> +                               uint16_t size_bytes, uint16_t vendor_id,
> +                               uint8_t dvsec_version, uint16_t dvsec_id)
> +{
> +    const uint32_t header1 = size_bytes << 20 | version << 16 | vendor_id;

I was going to suggest you just use the defines in pci_regs.h but
oddly those were only defined as extraction macros for these fields
not the other way around that you'd need here (or masks that could be used
for that). 

I'd add a blank line.
> +    pcie_add_capability(device, capability_id, version, offset, size_bytes);
> +    pci_set_long(device->config + offset + 0x4, header1);
and just pass the header value in here rather that using the local variable.

If you really want the variable declare it at the top then add the assignment
just before use.  Avoids the two getting separated if additional code gets
added here in the long run.

> +    pci_set_word(device->config + offset + 0x8, dvsec_id);
> +}

Always nice to justify a new helper by converting a few existing users.
Maybe not strictly necessary though..

> +
>  /*
>   * Sync the PCIe Link Status negotiated speed and width of a bridge with the
>   * downstream device.  If downstream device is not present, re-write with the
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de..86c29f7d8b 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -133,6 +133,10 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
>  void pcie_add_capability(PCIDevice *dev,
>                           uint16_t cap_id, uint8_t cap_ver,
>                           uint16_t offset, uint16_t size);
> +void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
> +                               uint8_t version, uint32_t offset,
> +                               uint16_t size_bytes, uint16_t vendor_id,
> +                               uint8_t dvsec_version, uint16_t dvsec_id);
>  bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                              uint16_t offset, uint16_t size);
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
> 


