Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057ED15D9E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tSq-0003La-2O; Mon, 21 Oct 2024 10:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tSo-0003LB-GA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:32:54 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tSl-0008Ce-8m
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729521171; x=1761057171;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7oapRdL6rqiz0SXlEgDq9ctqB6zI/7cB4mtrzTqPhmA=;
 b=e2AD9Q8r2v3QCG9tbTj1mN3ZFRgCh5E5k/vifLHOYtCaq29d9LZ0slR7
 wB21kjib9VDOQ3BdA14hr7ZggH5rjMAyYrOOM2pFl4EUKZ/7EXZA5do9W
 7oqeD9gZSeK5KjxjW+73CcsAqdC4b+StVierooMaPS7YdANfZx4qLNEdb
 Z8JULGIwJZS/ioCFAtTk9A/Hv89nA8J3WlW3FeDda3XEbf/G6sVy8Gyew
 w96NsJKWAyBCfngCCnWFdNqZBWOSf6BkTPkhyAz64vEbk1HCTDKmqJbDU
 ed3WWRxHfe3mkt7sqe3cc+ANzJ5hWqLAz8kTTDPdHqinQP0yfVKqq1DPt A==;
X-CSE-ConnectionGUID: Fqp6Jw3XRxqusWZux+Nvkg==
X-CSE-MsgGUID: 9decDxGIRVKuwazFj3dJfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28463204"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="28463204"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:32:48 -0700
X-CSE-ConnectionGUID: YscHWyvkQ6S1XtGszIwbrQ==
X-CSE-MsgGUID: S/2+t2QSQliGF1JQXHMnDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="110389078"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 21 Oct 2024 07:32:47 -0700
Date: Mon, 21 Oct 2024 22:49:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
Message-ID: <ZxZp39giE4j/NWzy@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-4-pbonzini@redhat.com>
 <ZxX1jSkJ3Muk11zC@intel.com>
 <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 21, 2024 at 03:38:06PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 15:38:06 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
> 
> On Mon, Oct 21, 2024 at 8:16 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > unsafe_op_in_unsafe_fn is allowed in
> > rust/qemu-api/src/lib.rs. So should we wrap the bindings in a separate
> > lib (similar to the rust/bindings in the Linux kernel)?
> >
> > This way, the special lint settings can be applied only to the binding
> > files, while the default lint checks can cover the other user
> > development code.
> >
> > In addition, another thing that confuses me is why bindgen still
> > generates code that does not follow the unsafe_op_in_unsafe_fn
> > requirement. It seems that bindgen has supported unsafe_op_in_unsafe_fn
> > since v0.62 [1, 2], but binding code we generated still violates
> > unsafe_op_in_unsafe_fn. Is this a bug of bindgen?
> 
> The plan is to support older versions of bindgen (0.60.x) as long as
> Debian has them. One possibility to fix this is, as you said, to use a
> completely separate crate. Another is to add #![allow()] to just the
> bindings module, for example by changing bindgen.rs to
> 
> #![allow(...)]
> include!("bindgen.rs.inc")
> 
> This is related to the fact that we don't have yet a good way to run
> "clippy", because "cargo clippy" needs the bindgen.rs file. So we
> should probably look at these issues at once.

Thank you. I agree, it's a better way.

Regards,
Zhao


