Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B8C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 14:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tayYH-0001qu-N0; Thu, 23 Jan 2025 09:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tayYF-0001qe-QR; Thu, 23 Jan 2025 09:51:23 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tayYD-0002m1-RA; Thu, 23 Jan 2025 09:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737643881; x=1769179881;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7IbjoP/Bx83KuwwSb1OdPOOc69p3F1ccrmHcrvnT2Mo=;
 b=duCARaZE76AmSdJ6TZmaCYnDGWuDO+tEVa3FXkFO0obyoI7D8GVa11s8
 aD9sjcADmBG7B6prhIobFRUheVV/cg69pNNSt4YCV2Q3h681O1/sEiDbo
 jovqLsv/1oMYz0uwcPvFQehCYllxZA9iTuspuxTKkhJf8o23wuF3GJ1CU
 ErUC5Oli/EreUiqISZBK1JUXNK4BkVihYZHZdtDg0nsbBlH1PYUi18uwc
 6wbEe2bDZVZ9/Jt3cGo+cPxcQqHJh0q9OKEkGk0EXRyI8UtDPNgUNJgih
 2kPN9dHNS5ZqVPgb9dShNMbHVHmYRc93WDbXoaqE6qOSMoOs+JQv/grpa Q==;
X-CSE-ConnectionGUID: w68hYiVRQ4ywRY91ZeChfQ==
X-CSE-MsgGUID: qMtVtjguRm2S6I40U6CCeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48810582"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="48810582"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 06:51:18 -0800
X-CSE-ConnectionGUID: JRVbMgrGTeipZlKkUcvYMw==
X-CSE-MsgGUID: KRXpyF4SRSK5LNnqZRZQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="130769168"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 23 Jan 2025 06:51:16 -0800
Date: Thu, 23 Jan 2025 23:10:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
Message-ID: <Z5Jb7k3LLcYY5ZG6@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
 <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
 <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
 <Z45/MNYY5jD5fNET@intel.com>
 <e2920049-01c8-4ea2-8f52-b99ed0a559af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2920049-01c8-4ea2-8f52-b99ed0a559af@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Another solution would be to implement Zeroable for __BindgenBitfieldUnit in
> bindings.rs, but this is much nicer!  It works even with old Rust versions
> and, even though it needs manual implementation of the trait each type, it
> doesn't require enumerating the fields one by one.  So it's better than the
> current version of Zeroable and, if you wish, you can also replace existing
> implementations of Zeroable with const_zero.

I'm working on this, and it's just a simple patch.

But I'm not sure why Zeroable needs a Default constraint. I think Sized
seems to be enough, doesn't it?

Thanks,
Zhao


