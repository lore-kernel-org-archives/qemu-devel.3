Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2A4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBpso-0006pL-3T; Tue, 28 May 2024 02:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBpsZ-0006jd-JG
 for qemu-devel@nongnu.org; Tue, 28 May 2024 02:00:13 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBpsK-0001QI-VI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 02:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716875998; x=1748411998;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aj7qE5TSncAkb7REi920hF/5AGisAH7X1jucfsyjKkk=;
 b=JsSWAnJqH58AncIHx0l3QNGMbSwpSvkq/I4dwHna3AwMJhu/F6BVyx7f
 b/y+VazPwsbsGKetgEdCc1Ft9O6cI9m79HElzU6BDYwYXp/fZ+7704+hG
 NBQuvd7GKgzpNNizM6WBiHZPHu5CGdsdqTdkMfFVUKU7SkLW5ch7R/dS1
 l4iEsddZTifINS4MkWAh7ZxVYPMHuuLGNGzl2Je4GH5cCmrFIHa4nRn3O
 dVTMDCcfxNEoSVZsZKVFtN2F8cwZV8wCmysRxc6nGpV3G7UIapAjDAEJL
 f5qX6jotJc8Uvz6iOs29V2RKuQxGHsVa1ZVJpJM/XbpvBKmnVTpEhac2W Q==;
X-CSE-ConnectionGUID: 5OVdqjJfR0GrUyAAQUXDxw==
X-CSE-MsgGUID: JfTubJ8OQ+CDbXJMDX3x6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="35713565"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="35713565"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 22:59:54 -0700
X-CSE-ConnectionGUID: Bj3L1IylTqOGoA6GwCMjTw==
X-CSE-MsgGUID: BOalfvZZT0W/5fE+Zo6Z1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="34851007"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 27 May 2024 22:59:51 -0700
Date: Tue, 28 May 2024 14:15:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?B?IkRhbmllbCBQIC4gQmVycmFuZ+ki?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <ZlV2ckPx8zcBMgF0@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <622493FA-7645-4425-9AE6-1C39A581149E@ynddal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622493FA-7645-4425-9AE6-1C39A581149E@ynddal.dk>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Hi Mads,

On Mon, May 27, 2024 at 12:49:06PM +0200, Mads Ynddal wrote:
> Date: Mon, 27 May 2024 12:49:06 +0200
> From: Mads Ynddal <mads@ynddal.dk>
> Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
> X-Mailer: Apple Mail (2.3774.600.62)
> 
> Hi,
> 
> Interesting work. I don't have any particular comments for the code, but I
> wanted to address a few of the points here.
> 
> > 2. Rust delivers faster parsing.
> 
> For me, the point of simpletrace.py is not to be the fastest at parsing, but
> rather to open the door for using Python libraries like numpy, matplotlib, etc.
> for analysis.
> 
> There might be room for improvement in the Python version, especially in
> minimizing memory usage, when parsing large traces.

Thanks for pointing this out, the Python version is also very extensible
and easy to develop.

Perhaps ease of scalability vs. performance could be the difference that
the two versions focus on?

> > Security
> > --------
> > 
> > This is an example.
> > 
> > Rust is very strict about type-checking, and it found timestamp reversal
> > issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> > deeper with more time)...in this RFC, I workingaround it by allowing
> > negative values. And the python version, just silently covered this
> > issue up.
> 
> I'm not particularly worried about the security of the Python version. We're not
> doing anything obviously exploitable.

I agree with this, this tool is mainly for parsing. I think one of the
starting points for providing a Rust version was also to explore whether
this could be an opportunity to integrate Rust into QEMU.

Thanks,
Zhao



