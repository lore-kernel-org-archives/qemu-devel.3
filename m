Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E5AE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAxf-0002m6-Ou; Thu, 05 Dec 2024 07:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJAxd-0002lF-Dd; Thu, 05 Dec 2024 07:28:01 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJAxa-0005No-Sl; Thu, 05 Dec 2024 07:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733401679; x=1764937679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=R3cvo7UCjBrkosfaR7DMNE86/sLoF69l0f0xPT/L72I=;
 b=AXP9EVvB2V7wkpdmUhwJZA4tmVL2XA6ArxsiWkE0PeeaLYdRqJ27D2nq
 dXu2ySUywnOm9e5v4R375BFgjKuXeOGyB+0DUid/L3Kidu5CMq3d2R7pT
 JXU67mPcQkD0Ngb8KIUBLMUVi4bEOuSZ+TeuWYfmZ963IBuR3otBpQNVV
 NZBk5atAazTF/0NRW0AUjGy9rjNu7KeFhdWHOhxvgrDNEu8FPBVK18hPC
 yVj1vMz9wVj8NUL+CkpH77G/YM91tQOArQbvfwiOiVxB2PAmi0MEcdyMg
 EC9ebNYP9LwVLtQUv01RGr4GFUGZnb+OyuZy5r+X2GwuGoLxsG3DXIBb7 Q==;
X-CSE-ConnectionGUID: k6KEleOoRi2JEZu5DEydKg==
X-CSE-MsgGUID: q2IFqEwOTNS4jwu+vZ5lRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33042702"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33042702"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 04:27:56 -0800
X-CSE-ConnectionGUID: nD8+nR2rRkKUsMlCWo1Cag==
X-CSE-MsgGUID: gAxxQp6iTT+fZt+wRzWaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="124995048"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Dec 2024 04:27:53 -0800
Date: Thu, 5 Dec 2024 20:46:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
Message-ID: <Z1GgjZOCc8vkkB3A@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Philippe,

On Thu, Dec 05, 2024 at 01:04:58PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Thu, 5 Dec 2024 13:04:58 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
> 
> On 5/12/24 07:07, Zhao Liu wrote:
> > HPET device needs to access and update hpet_cfg variable, but now it is
> > defined in hw/i386/fw_cfg.c and Rust code can't access it.
> > 
> > Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
> > allows Rust HPET device implements its own global hpet_fw_cfg variable,
> > and will further reduce the use of unsafe C code access and calls in the
> > Rust HPET implementation.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/i386/fw_cfg.c        |  4 +---
> >   hw/timer/hpet.c         | 16 +++++++++-------
> >   include/hw/timer/hpet.h |  2 +-
> >   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> 
> > diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> > index d17a8d43199e..dbf709251a8f 100644
> > --- a/include/hw/timer/hpet.h
> > +++ b/include/hw/timer/hpet.h
> > @@ -74,7 +74,7 @@ struct hpet_fw_config
> >       struct hpet_fw_entry hpet[8];
> >   } QEMU_PACKED;
> > -extern struct hpet_fw_config hpet_cfg;
> > +extern struct hpet_fw_config hpet_fw_cfg;
> 
> Could this field belong to the (yet unexisting) HPETClass?

Several instances would share the same class, so HPETClass could manage
multiple HPETState info.

But in fw_cfg.c, do you have idea about how to get the HPETClass?

Regards,
Zhao


