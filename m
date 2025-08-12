Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD546C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulm8f-0001Oh-Kc; Tue, 12 Aug 2025 06:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ulm8d-0001OG-R5; Tue, 12 Aug 2025 06:21:51 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ulm8a-0000wP-RX; Tue, 12 Aug 2025 06:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754994109; x=1786530109;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LYvBduOsu5wSmNDUQZDQtXmrcMtse/oYwB2XsTWTOsU=;
 b=bHdGLGZzlceBCITE7q1uSjxZReisFTETprpK/CBb9gzuWnPG7elNre7u
 WLj/fv7/W3S5AiCqOWFDCEgtA4LjWfy93EEGfbIf2+WCGK1Jm/p4mnjMh
 CyB7qaPINlKMkN9A/tadxNb9CRJ7tDvM86QJOyeltFnUocu5NKpF4cGWW
 uPqk0A4pTWQkn+7ANW+riZ3qM6g8NYlE1ifMgAliFlhKiWEx3+kS8GJqB
 nEE7SKo39+KR5qIf72uRcSdvezurN3s1pPPKzMecBPHlcyJTx5QkknUlT
 BvyImM4YqhOhTyyZ9PFTmITOMtsiQzKFmBpgCZb1S4sfAiUVD3vSpyhdk g==;
X-CSE-ConnectionGUID: UfzbciOgTnOOLPvK5CW0Vw==
X-CSE-MsgGUID: Bz/N9tjgQyivzlQ5o7cWcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="60888910"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="60888910"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 03:21:43 -0700
X-CSE-ConnectionGUID: Zl4u5XNhTnyK4+l9fHV8GQ==
X-CSE-MsgGUID: beDK0mweRGaCUPRgxH/i4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="166450486"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 12 Aug 2025 03:21:40 -0700
Date: Tue, 12 Aug 2025 18:43:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
Message-ID: <aJsayGjIhHBRuySu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
 <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
 <aJb3C8qbXQ1zx306@intel.com>
 <CABgObfaVoYi09-HkwojkJT_-AJosdKNPwxMySHn6yn2cuS1Z5g@mail.gmail.com>
 <CAAjaMXbHOTj1ed=sbkvR=4Uhgk2TyrqaAsXAgZ6uH622cart9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjaMXbHOTj1ed=sbkvR=4Uhgk2TyrqaAsXAgZ6uH622cart9w@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> >> > impl AddressSpace {
> >> >    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {
> >>
> >> IIUC, this lifetime is using the "branded type" pattern as ParentInit.
> >>
> >
> > No, it's much simpler (that one uses the combination of for<'identity> and
> > PhantomData as explained in the comment). It says that the lifetime of the
> > returned reference cannot exceed the guard. It's just like
> >
> > pub fn get_item(&self, array: &'g [u8]) -> &'g u8 {
> >    &array[self.0]
> > }
> >
> > Except that the guard is only there to limit the lifetime and not to hold
> > data.

I see. It's clear for me now. Thank you!

> > In addition, about rcu_read_lock_held(), I thought at C side, there're
> >> so many comments are saying "Called within RCU critical section" but
> >> without any check.
> >>
> >> So I wonder whether we should do some check for RCU critical section,
> >> just like bql check via `assert!(bql_locked())`. Maybe we can have a
> >> Rcu debug feature to cover all these checks.
> >>
> >
> > In Rust you would just pass a &RcuGuard into the function (or store it in
> > a struct) for a zero-cost assertion that you are in the RCU critical
> > section.
> >
> 
> Agreed. You could put debug_asserts for sanity check for good measure.

Thanks!

Then I see, the most RCU critical part is accessing FlatView through
AddressSpace.

Here, require RCU by function signature (&RcuGuard) is very convenient:

pub fn get_flatview<'g>(&self, rcu: &'g RcuGuard) -> &'g FlatView;

As for the methods of FlatView itself and the lower-level interfaces
(e.g., the write & read detail methods), although RCU critical sections
are also required, there is no need to worry about them because the
upper-level access already ensures RCU lock is held. Of course, it would
be better to add &RcuGuard to some structures and check them with
debug_assert/assert.

Regards,
Zhao


