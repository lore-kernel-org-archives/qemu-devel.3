Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EC0CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqFbn-0007nb-QY; Fri, 29 Mar 2024 13:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rqFbk-0007nQ-CQ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:01:36 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rqFbi-0000Vd-1W
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711731694; x=1743267694;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Hh7s7Vxln+H4nRXAfTXlH2klC9F05rO8lUWPQMNJ7J8=;
 b=ngl+sZIBIpl+AyTWNiBR7l/vYfDi+KCIXBlHd0JazzQ+VnVXyVX0vxsP
 ob58altFL16/mZhY91Q35wH91RcNFZ867/A2BtucYZ6h8LSNkc+nG3kIg
 KibAxAssDJPesz2GSe3FChm1WnOBCYIb+SSI7xk3kBChcInGVklkywkXQ
 UUmf5hmk3fG36jvBodJ3vYZIVaWz4Cvx5iXsaj/y0MWsGRyXuv109dSyL
 tsjVwc6fh16veMbpJCjNMSqaPhgkcavBy4fUyEYOf/fUg+YRGFHQyjkGP
 05U4MWvEuChYUloNWT41wjV04RN1OqDliS8wyJ/1zTNxn2mECEB7pqEaF A==;
X-CSE-ConnectionGUID: 8f30IWvxSyyknVcYQXi6Mg==
X-CSE-MsgGUID: WqZKrAwRSkKZLtNeB+/1kA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10709089"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="10709089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 10:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="21484728"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 10:01:29 -0700
Date: Sat, 30 Mar 2024 01:15:25 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: no-reply@patchew.org, qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC] util/error-report: Add "error: " prefix for error-level
 report
Message-ID: <Zgb3LWIBfco0eyf8@intel.com>
References: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
 <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
 <CABgObfb8EP+LZV8jF7sumQd2-hR1WTN-MCmcrK-NO0rGJu3b4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb8EP+LZV8jF7sumQd2-hR1WTN-MCmcrK-NO0rGJu3b4g@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

On Fri, Mar 29, 2024 at 12:10:17PM +0100, Paolo Bonzini wrote:
> Date: Fri, 29 Mar 2024 12:10:17 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC] util/error-report: Add "error: " prefix for error-level
>  report
> 
> On Fri, Mar 29, 2024 at 10:37 AM <no-reply@patchew.org> wrote:
> > > This was done in the context of inheriting the original error_report()
> > > interface without the prefix style. And it was also useful to have a
> > > means of error handling, such as exit(), when error occurs, so that the
> > > error message - the most serious level - can be noticed by the user.
> > >
> > > Nowadays, however, error_report() and its variants have a tendency to be
> > > "abused": it is used a lot just for the sake of logging something more
> > > noticeable than the "warn" or "info" level, in the absence of
> > > appropriate error handling logic.
> 
> Unfortunately, this is the reason why you _cannot_ do what this patch does.
> 
> For example:
> 
>   error_reportf_err(local_err, "Disconnect client, due to: ");
>   error_report("terminating on signal %d", shutdown_signal);
> 
> This should not be prepending "error" - it's not an error.

So I feel these 2 cases maybe should use info_report()?

>   error_report_once("%s: detected read error on DMAR slpte "
> 
> This is a guest error, so "error:" is probably not a good idea (it
> should use qemu_log_mask).

Yes, here I can do a cleanup.

> And so on. :(

error_report() and its variants have 2600+ use cases, and it's
impossible to distinguish whether ther're appropriate or not.

Thanks for your explanation, I understand this is not workable,
since there is too heavy the debt to sort out error_report().

Regards,
Zhao


