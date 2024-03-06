Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E6AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhr6A-000252-ID; Wed, 06 Mar 2024 08:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rhr69-00024u-Hk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:14:17 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rhr67-0005qT-BL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709730855; x=1741266855;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=p8ErNJLqEVurtuygwgHqoaWZ6GjvF3Rx52YwT8d3QIc=;
 b=EDDaUA1pYk9IrvXgTKQ4IUw6V74nrqMYruVNafCz1ZrXCT6CbK/ppWQO
 cmK1rpb0LpLGzsEroOsKSPWYJXP6ekAPyY3mD7gJF+NaUK8DtSwP1JTbx
 8NhaTafThswvbvEA7LFKL/PtJeXKbchl5RWag7CYZ+dWFCe4pkiXUsjZy
 mWJ67uf3wQrOWgQoGzaN07aEZdo03FGXqh+XRKxq7UZ7jRGZUADyQ4Die
 EbUeQul1c0uAYUioa+IRzf7Yd+hWjafhQcWOD0SQ2ZwdOdKbnshvBWVyR
 AWOrGZi/TR6+ZZGIV0W0niNiqtYM0yjY2CV5drzwaKIRXGFo8xDvxjedK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4493317"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4493317"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 05:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; d="scan'208";a="10174137"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 06 Mar 2024 05:14:07 -0800
Date: Wed, 6 Mar 2024 21:27:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 devel@lists.libvirt.org, David Hildenbrand <david@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH-for-9.1 02/18] hw/usb/hcd-xhci: Enumerate xhci_flags
 setting values
Message-ID: <ZehvWi8UhQOl3v8j@intel.com>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305134221.30924-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Tue, Mar 05, 2024 at 02:42:04PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue,  5 Mar 2024 14:42:04 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 02/18] hw/usb/hcd-xhci: Enumerate xhci_flags
>  setting values
> X-Mailer: git-send-email 2.41.0
> 
> xhci_flags are used as bits for QOM properties,
> expected to be somehow stable (external interface).
> 
> Explicit their values so removing any enum doesn't
> modify the other ones.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/usb/hcd-xhci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 98f598382a..37f0d2e43b 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -37,8 +37,8 @@ typedef struct XHCIEPContext XHCIEPContext;
>  
>  enum xhci_flags {
>      XHCI_FLAG_SS_FIRST = 1,
> -    XHCI_FLAG_FORCE_PCIE_ENDCAP,
> -    XHCI_FLAG_ENABLE_STREAMS,
> +    XHCI_FLAG_FORCE_PCIE_ENDCAP = 2,
> +    XHCI_FLAG_ENABLE_STREAMS = 3,
>  };
>

From the commit 290fd20db6e0 ("usb xhci: change msi/msix property
type"), the enum values were modified directly.

So it seems not necessary to bind enum type with specific value,
right?

Thanks,
Zhao



