Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44431C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 06:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfwSW-00074Y-0M; Fri, 01 Mar 2024 01:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwS2-00071Q-K9; Fri, 01 Mar 2024 01:33:01 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwRx-0006XV-Fb; Fri, 01 Mar 2024 01:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709274773; x=1740810773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XlPH2iOo+/b+XmyQZlGc/W7/nerXRtlPAXfPaGiyqAs=;
 b=G9l4hXOl0mLrBQqgz/ki2hXUidfnR58HFnFys0bEhygaCQN1kGpGCJ4l
 lj9ncafEaRyKJNO2HsaV8igBN/B4pGHdPVBDQiMLEjwQvOaz9Yo6349uu
 SgES3HbfIA4xNIjIcYyxCVMWbTKkylyMWBQYRrOhRmmSiC3m1sgfuiK8K
 XjenbR8h5SIzOQ0MP+W+vuy/nFs+Fc0E3fAyclLiGFzhuchA3XBLeXYC3
 SzbxozQCdtN5lj5P5XG1jFSe2nEAhJbFIn9Pt8H0LEICHDutE9kX8Glbg
 dVaD4aCDyavgYPow0JNHKEcH2dLs0leMbi8fPTZt+qbaqjT3NI/A0p37m Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4374035"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="4374035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 22:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="12644182"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 29 Feb 2024 22:32:32 -0800
Date: Fri, 1 Mar 2024 14:46:16 +0800
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
Message-ID: <ZeF5uBvdkHPcIwzm@intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-18-zhao1.liu@linux.intel.com>
 <6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7eff95-cfd3-46f9-9937-7597b2e4f3ee@redhat.com>
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

> > diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> > index a63d990e4e8e..1a1c09612271 100644
> > --- a/target/s390x/cpu_models.c
> > +++ b/target/s390x/cpu_models.c
> > @@ -503,6 +503,7 @@ static void error_prepend_missing_feat(const char *name, void *opaque)
> >   static void check_compatibility(const S390CPUModel *max_model,
> >                                   const S390CPUModel *model, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       S390FeatBitmap missing;
> >       if (model->def->gen > max_model->def->gen) {
> > @@ -566,6 +567,7 @@ S390CPUModel *get_max_cpu_model(Error **errp)
> >   void s390_realize_cpu_model(CPUState *cs, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       Error *err = NULL;
> 
> I think that function could use an additional clean-up now: Remove the local
> "err" variable and use "errp" only instead.
>

Thanks! It's cleaner. Will do this.

Regards,
Zhao


