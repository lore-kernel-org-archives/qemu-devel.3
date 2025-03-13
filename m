Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A0C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgio-000309-Hi; Thu, 13 Mar 2025 07:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsgig-0002wk-3z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:27:27 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsgia-00037v-TU
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:27:21 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 2671F458E7;
 Thu, 13 Mar 2025 12:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741865233;
 bh=IAwbx/SP3vSiC+Qp3huknAR2nLvFlZn3agOaPAUllU0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1bZA4tGoVCWh9DLOjmctYhRX6rADMw2dzunbvgRLzuzUmyhZGyTDS3RwjySnBc2cT
 3e+ocnOwnJSekYYUQV16EarCepj+ZlXLDCjnmwpMNbWk8KH4wwARaOCUX8qXkq6C+L
 UUhI5FwpU0gZQ+Tnt2nGS2zh3AgNa5wAVQTo2NNJ91ZINcUqnBoehq5JjXJb21y0RF
 2aK9KL6/G+c9/VhXjeSyN7D4iTmYkHrtl3ScPq5wy3Rfq/O56T+4a8Ln2aLtlq2F1S
 HEDT3GpnhDKmS/3TqowgQFI9szAb/VmMgOaceQesIYiQgwCgPdRt26TuNBW4YT95lU
 JEMRwX/FIB0eQ==
Date: Thu, 13 Mar 2025 12:27:11 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9LBD_FnO2Gi2vMK@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Mar 13, 2025 at 04:39:15PM +0530, Ani Sinha wrote:
> Right so what we are proposing is generic enough so that if the VM
> wants to use an IGVM container as opposed to an actual firmware image
> in a FUKI, that is totally possible. Then you need to have that IGVM
> setup the memory in a well defined way like you suggest. Sure, the
> IGVM is not passed through a command line but it can be loaded by the
> guest in a well defined memory location and then its instructions can
> be executed.

That makes sense. In this scenario, how does the VMM detect that it got
an IGVM image instead of a firmware image? As I understood the current
documentation the defined behavior is to copy the guest-provided
FW-image to the BIOS region, no?

> In our proposal, we do not want to dictate how the guest would want to
> do that. So hopefully you see now that IGVM and our approach is not
> mutually exclusive but can be complementary to each other.

Fine with me. Just note that supporting the current non-IGVM process for
confidential guests still causes the implicit ABI issue I mentioned
before. But not being a KVM/QEMU maintainer I can live with that :)

Regards,

	Joerg

