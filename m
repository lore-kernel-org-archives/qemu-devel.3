Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB274E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 07:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKYBv-00051L-No; Mon, 09 Dec 2024 02:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKYBu-000513-8V; Mon, 09 Dec 2024 02:28:26 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKYBr-00087F-Aq; Mon, 09 Dec 2024 02:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733729303; x=1765265303;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=F5pBLLFvUtiHKYH0oeEWoJGCsUU3wTP7lL98qNGVMC8=;
 b=ACGQO74AV46ygpyO5eNgPheiBmHPNJcdj3tGzhow3+jQaA0Ec24qw1Nf
 RJljLWhr9xbXnsgwpvvn/xGxO88ih1546N2vqNdK5NznQFvpgMQyy/c85
 4SDtKirfYUZozp85uXoycCchDHeb9DGAKHwlWqsM4wlP9IB/ymM+rGTpS
 Cw/4muYn637kXcIGrHPAyNEDgr8NYSYxusN4B+y5rNnsA0k1xiiIFSlXW
 OY2c/a2xAy7wv7WxAYypvAzN1BSN6aIZ4SkDDdWJ4DXQxM4QTs3TwOGvb
 mtOglDvI9fHqARbO78igELvLNIMvouoEWzNlqd2CXT2bb7777eel2O4wb Q==;
X-CSE-ConnectionGUID: zXP6zXiOQ+iFsKeOCeNRgQ==
X-CSE-MsgGUID: tTK1UKiNQOmaBNuWOqmg+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37691787"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; d="scan'208";a="37691787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2024 23:28:19 -0800
X-CSE-ConnectionGUID: 7SsGGPXlSACUBE3wmVDf0Q==
X-CSE-MsgGUID: RX5YxjrbT/aQRxMNJMHlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="100021619"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 08 Dec 2024 23:28:13 -0800
Date: Mon, 9 Dec 2024 15:46:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 11/13] rust/timer/hpet: add basic HPET timer & state
Message-ID: <Z1agU6385snA9Xc4@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-12-zhao1.liu@intel.com>
 <b107c5c3-9ee4-4939-a4e3-eff0cd92bad6@redhat.com>
 <CABgObfbojr4fkXq8tuuXCAGUdr3Vefddx=ERtMUx9w6Bqy0a3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbojr4fkXq8tuuXCAGUdr3Vefddx=ERtMUx9w6Bqy0a3g@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
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

On Thu, Dec 05, 2024 at 10:20:47PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 22:20:47 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 11/13] rust/timer/hpet: add basic HPET timer & state
> 
> On Thu, Dec 5, 2024 at 9:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > +    /// Instance id (HPET timer block ID).
> > > +    hpet_id: BqlCell<usize>,
> > > +}
> > > +
> > Like flags this does not need to be a cell.
> 
> Well, this *should not* need to be a cell (ideally fw_cfg would call a
> C function to generate FW_CFG_HPET) but it can't be done yet, so you
> can keep it. flags need not be a BqlCell though.

Thank you! I'll look at how to implement C function's workflow.

At least, I'll leave a TODO to remind me to cleanup this BqlCell.
(Now I did overuse the BqlCell a bit! :-) This is also an opportunity
for me to carefully review the correct usage.)

Regards,
Zhao


