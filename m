Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F18BE8B377
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPD6-0003pf-Mf; Tue, 03 Feb 2026 17:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnPD4-0003pG-Ru
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnPD3-0003Bh-2S
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770158964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OSCnpuijEfbM0fiCq56tPrCFnB5RXxxeUhQrfFjEPA0=;
 b=DRfdYZ+3aJZrToF0Zh+1+IiHLdT+szgmT9pLVp8bAXwNOIckOWRtWUjXXO+cCOmVfBo4So
 vNmGSR+t/xh3nXCqg1ys7aF5E5HPraPW9P4qAu+8aiPY8q4z1xioFrUw8eqtBCFL8iyB+I
 ZQ/EujLvO9XS6y1lJs0i76S7A6zwbLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-gIWfm7hQMNSF0pPVAh-V-Q-1; Tue, 03 Feb 2026 17:49:22 -0500
X-MC-Unique: gIWfm7hQMNSF0pPVAh-V-Q-1
X-Mimecast-MFC-AGG-ID: gIWfm7hQMNSF0pPVAh-V-Q_1770158962
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso741055e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770158961; x=1770763761; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OSCnpuijEfbM0fiCq56tPrCFnB5RXxxeUhQrfFjEPA0=;
 b=epIIvnHHQGykQxidoqH19ju3jQ3XSFZsH4t0K2zEbhj+2PV1uFZGhCVXUUiB5E+E1O
 V1Bf4RtsMLUGF9/WbzLpx5gkbs2pBNB4NFNvcPzxlf/fXndCqozQ+YBuospX6gAnq3Ka
 bqORk4/qYpZRlTZef3CjPznPZktwonWxZX4LkL8Xr6fzG92HPhgMeea2kegsI+pV9Emp
 RXwVSgxgaw5348qCad5U4K9lyQOTGOAKO//BIObW26tsRN509EjqLS2Afhbj1mmsGEj7
 dm395u69qgwS9+2fgsnx33QHtsLHiFjHbSSvUuoKdWqW9rE14hiyve8JCXmFogzvZ6Z0
 onsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770158961; x=1770763761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSCnpuijEfbM0fiCq56tPrCFnB5RXxxeUhQrfFjEPA0=;
 b=WkwCGNJ8QPeLDe/kEeQrSFEAhN+NvD8/TfuXWPiB4w2mL1glfITViNUmRscIbjgrB5
 t1hPxk1wAMtIv+2M9PUNPiJPQOg7tpGl7siG0GC7jPTON4Bqj6JqLrmGN94hDl+HWAtc
 D3lSvY/lozNkXljPAJu+zXRHJHrEUekRg2OXwbrlxXaIvcjp4oPylb1XvN2MtK8SP/0F
 ktwFwZ+Fwky6ARuj0B0nVNcUW5jYcpA/YcL1LvwbDt1IkmiQbs+kJ5dCCocC8EMlVIlK
 fFmDfsWvieKozyGoTtTp0WVkUzw6xdFg/gOO9zTS/erJdJW90d5Q6KonEhgcz1bpsIn0
 4OOQ==
X-Gm-Message-State: AOJu0YwImilaABoyz7VvovVbz5R+rQlK2g9UJknIMEXczfYLHAYuU5cN
 YlHe5+5C/gDSrPh9rjDTHwky4l11eWQZ708SzokI2cEZJw7O09qI7mbV5jouElDkOZ7lEAIHKv0
 /LIzdwwOoRxDo6D3WXyKHZvlgo4rQt6cdBEF1W4ohFTubt2JPksjLD2iG6xZFLXVC
X-Gm-Gg: AZuq6aLYENx9Z/JQJmnVla0GPOofmHvGrSW0bOEygIbsxxUTFeCmba2jQv0+96QVCaQ
 18l66HH64tr6S1Ael9+mSPmh48KCrpHjvfnDw6NbU/d6Y9NwcjnZHihGLMZoWaFdIcoZViBV+Ai
 B7/1SB33DxI3k1xnQ/w9MXS1rtPXJyDCAaAyx6oEj3Llh6eIY7yEh02DzyAZ/WSUujJFmQt3ApC
 DfB0YGSqujjBdXou0PmCGgElTPjakFL/QXVG8t8uSlD1lmnXPxzqbZuWnyaruQsLvhWRQ4C7vO6
 3wfYyR7aHfmuxig+noJkNhSiQdUV3H82Yb/88t1Oe/8YEbQepd4zy4OI1lrKkumgcQ/mveq/2Ay
 /5ZKRq7bkGb2RE2tWVAAj8hz/OsdPZE8SjA==
X-Received: by 2002:a05:600c:820a:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4830e980379mr15613275e9.30.1770158961228; 
 Tue, 03 Feb 2026 14:49:21 -0800 (PST)
X-Received: by 2002:a05:600c:820a:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4830e980379mr15613125e9.30.1770158960797; 
 Tue, 03 Feb 2026 14:49:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483108d79c9sm1336995e9.1.2026.02.03.14.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 14:49:20 -0800 (PST)
Date: Tue, 3 Feb 2026 17:49:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Andrey Ryabinin <arbn@yandex-team.com>,
 qemu-stable@nongnu.org, michael.roth@amd.com
Subject: Re: [PATCH v2] q35: Fix migration of SMRAM state
Message-ID: <20260203174612-mutt-send-email-mst@kernel.org>
References: <20251211165454.288476-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211165454.288476-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Thu, Dec 11, 2025 at 05:54:54PM +0100, Igor Mammedov wrote:
> When migrating, dst QEMU by default has SMRAM unlocked,
> and since wmask is not migrated, the migrated value of
> MCH_HOST_BRIDGE_F_SMBASE in config space fall to prey of
> 
>   mch_update_smbase_smram()
>     ...
>     if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
>         *reg = 0x00;
> 
> and is getting cleared and leads to unlocked smram
> on dst even if on source it's been locked.
> 
> As Andrey has pointed out [1], we should derive wmask
> from config and not other way around.
> 
> Drop offending chunk and resync wmask based on MCH_HOST_BRIDGE_F_SMBASE
> register value. That would preserve the register during
> migration and set smram regions into corresponding state.
> 
> What that changes is:
> that it would let guest write junk values in register
> (with no apparent effect) until it's stumbles upon
> reserved 0x1 [|] 0x2 values, at which point it
> would be only possible to lock register and trigger
> switch to SMRAM blackhole in CPU AS.
> 
> While at it, fix up test by removing junk discard before negotiation hunk.
> 
> PS2:
> Instead of adding a dedicated post_load handler for it,
> reuse mch_update->mch_update_smbase_smram call chain
> that is called on write/reset/post_load to be consistent
> with how we handle mch registers.
> 
> PS3:
> for prosterity here is erro message Andrey got due to this bug:
>     qemu: vfio_container_dma_map(0x..., 0x0, 0xa0000, 0x....) = -22 (Invalid argument)
>     qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> 1) https://patchew.org/QEMU/20251203180851.6390-1-arbn@yandex-team.com/
> Fixes: f404220e279c ("q35: implement 128K SMRAM at default SMBASE address")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Cc: qemu-stable@nongnu.org
> Cc: mst@redhat.com
> Cc: arbn@yandex-team.com
> Cc: michael.roth@amd.com
> ---
>  hw/pci-host/q35.c      | 25 +++++++++++--------------
>  tests/qtest/q35-test.c |  6 ------
>  2 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index a708758d36..946342ba58 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -432,30 +432,27 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
>      }
>  
>      if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
> -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
> -            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
>          *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
>          return;
>      }
>  
>      /*
> -     * default/reset state, discard written value
> -     * which will disable SMRAM balackhole at SMBASE
> +     * reg value can come from register write/reset/migration source,
> +     * update wmask to be in sync with it regardless of source
>       */
> -    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
> -        *reg = 0x00;
> +    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        return;
>      }
> -
> -    memory_region_transaction_begin();
>      if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> -        /* disable all writes */
> -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
> -            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        /* lock register at 0x2 and disable all writes */
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
>          *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> -        lck = true;
> -    } else {
> -        lck = false;
>      }
> +
> +    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;

why not move the if here and then simply:

	if (lck) {
		/* lock register at 0x2 and disable all writes */
		pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
		*reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
	}

can be a patch on top.

> +    memory_region_transaction_begin();
>      memory_region_set_enabled(&mch->smbase_blackhole, lck);
>      memory_region_set_enabled(&mch->smbase_window, lck);
>      memory_region_transaction_commit();
> diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
> index 62fff49fc8..4e3a4457f6 100644
> --- a/tests/qtest/q35-test.c
> +++ b/tests/qtest/q35-test.c
> @@ -206,12 +206,6 @@ static void test_smram_smbase_lock(void)
>      qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
>      g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
>  
> -    /* check that writing junk to 0x9c before before negotiating is ignored */
> -    for (i = 0; i < 0xff; i++) {
> -        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
> -        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
> -    }
> -
>      /* enable SMRAM at SMBASE */
>      qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
>      g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x01);
> -- 
> 2.47.3
> 
> 


