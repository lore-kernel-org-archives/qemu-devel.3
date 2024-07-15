Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E78C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLAX-0007Nv-Fu; Mon, 15 Jul 2024 08:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTLAB-00071y-Gc
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:50:46 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTLA9-0005cy-6R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721047841; x=1752583841;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Rgral5svhFwCi3vWx43JmcmPhf8C/VaAbMaiPVt2Yuw=;
 b=G8ostIw/1cEijK3i6iVLmfV0YAjkvqPHeehJgqGyiRqfRYRrG8s0NzX+
 rnqkHuXA49v/LgfbT0doLvLwzKJDW2sw+hOPREVFgigaxhP56pDi6dlAX
 QqlGx/aqG6DSgvaGqop4OxQ3/lJZ0OUaNNlIMypG/HJ+i0acuNeD8bB3f
 ZrS1BnA6MFtgZo4F+czwzTmO/7G64jRNlkNs1pEDhHMFfIyBS2k3q8Txp
 OSciZ6Di6CboZ32u1yw0ivwpJC8D4n5q3tAO4bizvgOc0N05ITs0HtZnf
 TbzHJCoj31OyqAQe8N1DAcCPrvDTBUEkZKO7O3M5uRFfmutZDQPSrsb8E w==;
X-CSE-ConnectionGUID: OHvL2y+9RoOoQRmICK4ZJw==
X-CSE-MsgGUID: jOU+PpVATbe+IcK7IcWEmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21337174"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="21337174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 05:50:38 -0700
X-CSE-ConnectionGUID: uRymZ0oPS6e3ous1uHPOWA==
X-CSE-MsgGUID: greVYBDgQ0OH28D+ndl9xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="50381433"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 15 Jul 2024 05:50:36 -0700
Date: Mon, 15 Jul 2024 21:06:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] qga/commands-posix: Make ga_wait_child() return boolean
Message-ID: <ZpUeycPmb3VHh5LL@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <20240715095939.72492-3-zhao1.liu@intel.com>
 <1cf2b5cc-0837-4725-bf41-95bffd5a9b80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cf2b5cc-0837-4725-bf41-95bffd5a9b80@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, Jul 15, 2024 at 11:59:29AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon, 15 Jul 2024 11:59:29 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] qga/commands-posix: Make ga_wait_child() return boolean
> 
> On 15/7/24 11:59, Zhao Liu wrote:
> > As the comment in qapi/error, dereferencing @errp requires
> > ERRP_GUARD():
> > 
> > * = Why, when and how to use ERRP_GUARD() =
> > *
> > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > * - It must not be dereferenced, because it may be null.
> > ...
> > * ERRP_GUARD() lifts these restrictions.
> > *
> > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > * @errp can then be used without worrying about the argument being
> > * NULL or &error_fatal.
> > *
> > * Using it when it's not needed is safe, but please avoid cluttering
> > * the source with useless code.
> > 
> > Though currently ga_run_command() only gets &local_err instead of NULL
> > @errp, it's still better to follow the requirement to add the
> > ERRP_GUARD().
> > 
> > But as error.h suggested, the best practice for callee is to return
> > something to indicate success / failure.
> > 
> > So make ga_wait_child() return boolean and check the returned boolean in
> > ga_run_command() instead of dereferencing @errp, which eliminates the
> > need of ERRP_GUARD().
> 
> I'd avoid mentioning ERRP_GUARD and just describe:
> 
>   Make ga_wait_child() return boolean and check the returned boolean
>   in ga_run_command() instead of dereferencing @errp.
> 
> For the code change:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Many thanks for your words and review!

Will use your words in the next version.



