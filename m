Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEEC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 05:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDC8-0003sT-Rs; Tue, 06 Aug 2024 01:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbDC1-0003qM-5F; Tue, 06 Aug 2024 01:57:09 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbDBz-00089I-DA; Tue, 06 Aug 2024 01:57:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0E34ECE009F;
 Tue,  6 Aug 2024 05:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCD4C32786;
 Tue,  6 Aug 2024 05:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722923823;
 bh=0Hejww234DES1PvMhUh245HUseCRhbD8DLK4u6Op7/4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z0b/J6Fp6towTBV4MzPGVYXKwddZrXbmJN3lrvlGMnmT5NF0RCvtzDN67nqqbIF8X
 tpaSL0Zm08Hq1vivs7cp+OMsnhs+0c3ChowrbHZGreE4Ce4Z092Wx2N/cN6dTa27ff
 BzNSP/nif+rL2JojCCAnE56QfXbcGBeExIh8NfekQkBijJBHTLYjrFYoeFg0X7X3O3
 O8879yvWMCzc4bPWSU6pcBpC1Siy48WKGo/0Z+E2C75VTTG11+5Ccnaa9dHTFex+8a
 69CzrO6CN93hRJwnzGZVP1ttwxUheroeQOrYUyIEkm6Y39lhAp6ufzKSC79HdaYi9J
 eEK1wk7L7gpBQ==
Date: Tue, 6 Aug 2024 07:56:57 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 3/7] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240806075657.2a43abcc@foz.lan>
In-Reply-To: <20240805175400.000028ad@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
 <20240805175400.000028ad@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Mon, 5 Aug 2024 17:54:00 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri,  2 Aug 2024 23:43:58 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> Do we need to rename this now there is a GED involved?
> Is it even technically a GPIO any more?
> Spec says in 18.3.2.7 
> HW-reduced ACPI platforms signal the error using a GPIO
> interrupt or another interrupt declared under
> a generic event device (Interrupt-signaled ACPI events)
> and goes on to say that a _CRS entry is used to
> list the interrupt.
> 
> Give the Generic Event Device has a _CRS
> with aml_interrupt() as the type I think we should
> even have the hest entry say it's an interrupt (external?)
> rather than a gpio.

True. I'll change patch description to:

    arm/virt: Wire up a GED error device for ACPI / GHES
    
    Adds support to ARM virtualization to allow handling
    a General Purpose Event (GPE) via GED error device.
    
    It is aligned with Linux Kernel patch:
    https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

As the spec at
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
revers to it as:

	"The implementation of Event notification requires the platform
	 to define a device with PNP ID PNP0C33 in the ACPI namespace, 
	 referred to as the error device."

> > Adds support to ARM virtualization to allow handling
> > a General Purpose Event (GPE) via GED error device.
> > 
> > It is aligned with Linux Kernel patch:
> > https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> > 
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Again, more or less fine with this
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> to go with that co-auth

Thanks!

Mauro

