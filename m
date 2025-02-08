Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D38C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 17:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgozS-0000pX-08; Sat, 08 Feb 2025 12:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgozE-0000ny-PR; Sat, 08 Feb 2025 12:51:27 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgozD-0001rP-7L; Sat, 08 Feb 2025 12:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739037083; x=1770573083;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nrGrtODF+1mKpVShCRsmn3DhnXQwMu1v/I3xBGebxpk=;
 b=SYNrkURI0JV350m+XQ0Pv8q1kbALbm/jhO7ZumnTXnjDt18Ks7rhDPjL
 iM8pYLRAgnQCEvJXylXDzTsex8veE7ClMtOfFReNfHDPC1NGVVVj0GxzA
 7qc2M1mciQk/SEojyRYXPKR0NJG2gfVxoRdHhvPPb9xShRzZfOSv9uG8F
 quHfZhGAmSchZVTOof1vAGb7/3IBqDHDkYMh/lC9ImlUNyhEyPPUalaCB
 dOsRkqQONp7DrJP6mCyZRCFxDE14VxO5eLdER0LK726ACos0x/T4Zm2K1
 cjMUdPIk5gm++YiLMLgIzvpbOVo3tMsbiSoCApwR5JUdgUN8eQzLpIXak Q==;
X-CSE-ConnectionGUID: lBcRvtaiRXuwINV1ElWxOQ==
X-CSE-MsgGUID: Hd1EHCT6SHWzcrOFDsO0uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="62139005"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; d="scan'208";a="62139005"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 09:51:21 -0800
X-CSE-ConnectionGUID: nyAFOmPHSOScZmfPGagrMQ==
X-CSE-MsgGUID: m6GVumN1TwG7RYoBXjzfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; d="scan'208";a="116849665"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 08 Feb 2025 09:51:18 -0800
Date: Sun, 9 Feb 2025 02:10:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
 [InterruptSource] to [*mut IRQState]
Message-ID: <Z6eeKCH0gaqNBFU/@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
 <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
 <Z6Wx/RGBIElMaeZy@intel.com> <Z6W56AH3J1qOx18m@intel.com>
 <CABgObfa+_VVQWvrGWf6fJjf39O0AkoNB5aoptDrhk7dDx_SNXQ@mail.gmail.com>
 <Z6c8qju9IJaKM6rK@intel.com>
 <CABgObfYJK_LsG6DwALpym1ZHk1TUA9G0Wa2JAit3yULeWkAgSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYJK_LsG6DwALpym1ZHk1TUA9G0Wa2JAit3yULeWkAgSA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

> I have sent a docs/devel/rust.rst sometime last week, it will be in the
> next pull request and then you can send a patch on top.
>

Nice, I'll also have a look at that patch

And I plan to post v2 tomorrow... as I'll leave at next week from Tuesday.
Try to catch your pull request train if possible. :-)

Thanks,
Zhao


