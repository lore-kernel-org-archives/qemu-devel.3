Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D828C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZuVJ-00023c-4Y; Mon, 20 Jan 2025 11:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuVG-00023R-46
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:19:54 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuVC-0005BX-SR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737389991; x=1768925991;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CbA2GnEOPDu3SGJ0SDfwD4v/VuuqOtnKHiG+E4e1hB8=;
 b=RWowc352tyH+l1sG2E0ahO4MYe0g0+ec6pTgGOU1PMdnCWeLbKPP+Bqt
 24GAqGOI5pnPgqBD8BC5KEVAmq0EOWBc4DpdhE7Ie0SkMuBGcdQstQW59
 H9FmO0nPFfwIrh5kF3+cKxGo2ldwAITViO5kTaoYqee5qo6Mw/RE+yFMx
 qLGS31QiakbSUjKZL5qP71AEvZUx7qKAzMnM8nJhtzqHiPPoWdot7dQVn
 sje0IlL2Joyg8R0xgj7hX7IsMRrMg8ftO1XpgyXoJuvRriD7vkNIVBeIx
 1jXpfRyHPAIu74fAZEgHrE/+e3Nn994wHhT/P4cd8FQT7LOHI9l2FXWxE Q==;
X-CSE-ConnectionGUID: bG4S+IJ8SR+dJ1khSvx+oA==
X-CSE-MsgGUID: PxVjJHNBR/GyUtAmBRonJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49206688"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="49206688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 08:19:47 -0800
X-CSE-ConnectionGUID: sG/beUKVSPK+3ykQYIP3Tg==
X-CSE-MsgGUID: ytWe6xW7RauXDOLkC4wauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; d="scan'208";a="106687918"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jan 2025 08:19:46 -0800
Date: Tue, 21 Jan 2025 00:38:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=C3?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] memattrs: Get rid of bit fields
Message-ID: <Z458D/RuBQ8Kq0al@intel.com>
References: <20250120074258.2204342-1-zhao1.liu@intel.com>
 <20250120074258.2204342-2-zhao1.liu@intel.com>
 <CAFEAcA_VAOU+p_BC5bpnk2GKa5piywjf+yhFTh=-3O7TGut+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_VAOU+p_BC5bpnk2GKa5piywjf+yhFTh=-3O7TGut+uA@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

Hi Peter,

> >      /*
> >       * PID (PCI PASID) support: Limited to 8 bits process identifier.
> >       */
> > -    unsigned int pid:8;
> > -} MemTxAttrs;
> > +    uint8_t pid;
> > +
> > +    /* Requester ID (for MSI for example) */
> > +    uint16_t requester_id;
> > +} QEMU_PACKED MemTxAttrs;
>
> If we pull the requester_id up to the top of the struct
> we don't need the QEMU_PACKED, I think? (You get worse codegen
> on some platforms if you use 'packed' when you don't need to.)

Yes! I agree.

> It would be good to note in the commit message:
> (1) that this doesn't change the size of MemTxAttrs,
> which is important because we pass it around directly,
> not via a pointer (or does it raise it from 4 to 8 bytes?)

MemTxAttrs is raised to 8 bytes (yes, I should mention this).

> (2) that it does mean we have no spare space in the
> struct for new fields without moving beyond 8 bytes.

Thanks for the reminder, yes it is currently full. I found I missed
a commnet from Paolo [*], that he suggested only convert `unspecified`
to a bool. My bad :-(

It still raises the size to 8 bytes but saves spare space, like:

typedef struct MemTxAttrs {
    unsigned int secure:1;
    unsigned int space:2;
    unsigned int user:1;
    unsigned int memory:1;
    unsigned int requester_id:16;
    unsigned int pid:8;
    bool unspecified;
    uint8_t _reserved1;
    uint16_t _reserved2;
} MemTxAttrs;

Similar to your comment above, to get pakced structure, I think I need
push `unspecified` field down to other bit fields.

The rust side would require extra work to ZERO the other bit fields
though. I'll go back to that mail thread and discuss the details again.

[*]: https://lore.kernel.org/qemu-devel/20241205060714.256270-1-zhao1.liu@intel.com/T/#m8b05874d630e3ec8834617babb97b32ec3b39fce

> In particular we're talking about maybe adding a
> "debug" attribute; so this is an unfortunate refactoring
> from that point of view.

Thank you for your comment. In v2, I will try converting only
`unspecified` to a bool. Will that meet your expectations?

Regards,
Zhao


