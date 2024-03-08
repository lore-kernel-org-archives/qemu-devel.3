Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2116AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWzw-0002LA-95; Fri, 08 Mar 2024 04:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riWzu-0002Ke-CS; Fri, 08 Mar 2024 04:58:38 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riWzs-0006cV-6t; Fri, 08 Mar 2024 04:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709891916; x=1741427916;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0W33DEmPRpOiuGSjT1D4e0m9SzJ7kilI9CrMrdy02LQ=;
 b=UTdkRUqIObq9PykaUeIk78ltJ8wo4uknOjQ0J0Tgkdsg8CttVkBPbjf5
 6V49aNwpB+PCKlAZu+qgd815awjxu8EQCFden5jEykDVq2LBS4KaW3/bw
 s5O4g4GNsyuUv1PgAbJNLuaFkorC+KrfnLVipQHhlwUI7J7N6p9kud8hH
 41SK1cS37G4sHUP+UigCRcEJoEsY8cOW7vu1o4maoDWSeBD+o0Ink37Rb
 t+iBbD2RAOzET52tv8A1ArxpCLGZlzLjPnsrxsgRhhwtwkyI2iytk4Y8O
 05SOwBB3NTaSaDZRgmOlmeHugP6/3oZ9aTBBeOzs7LlpHPI323CalrXeL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="16037969"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="16037969"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 01:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="10320807"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 01:58:28 -0800
Date: Fri, 8 Mar 2024 18:12:15 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 17/17] target/s390x/cpu_models: Fix missing ERRP_GUARD()
 for error_prepend()
Message-ID: <Zerkf6nNsrUTXIrb@intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-18-zhao1.liu@linux.intel.com>
 <6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com>
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Thomas,

> >   void s390_realize_cpu_model(CPUState *cs, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       Error *err = NULL;
> 
> I think that function could use an additional clean-up now: Remove the local
> "err" variable and use "errp" only instead.
>

Since many cases check @err to determine if the callee function fails,
it's better also make those functions reture something like boolean
instead of void. Then we could avoid checking @err/@errp.

Thus, the remaining cleanups include:
* related conversion of local @err to @errp and
* make the callee function return someting,

I can do these centrally in another series, and this series (part 1 +
part 2, 33 patches in total) will only be used for adding ERRP_GUARD(),
which makes it easier to review as well as easier to merge.

Do you agree? ;-)

Thanks,
Zhao


