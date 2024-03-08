Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31483C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYN8-00053a-1C; Fri, 08 Mar 2024 06:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riYMq-0004z5-7s; Fri, 08 Mar 2024 06:26:25 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riYMk-0005QX-1N; Fri, 08 Mar 2024 06:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709897179; x=1741433179;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=phMUmCnzlh5IRbgVfIlvSACSCm84/sl/XLRrfcVWj2I=;
 b=a34MOyDxEAcDcN0n0hD11RBM41wmmDPFYv41eBKoHZxqqGzz0qVeoWgo
 vH0le+sC02n/JM1w5putjRK0y2MZ0zc00ZkKdfnnBkckRfmBDcdni66ac
 cg/49oCsxxUZ0FWK/p61kwYq3yQn3g2udBrjxW3CFRGzITaM0BV/LZOx+
 Ch52i2wruKOOgmgtKeAL0uqeHuNj6c1B5mw9xunhVw1geN1EAVvloZLBU
 p+X1hZhJMrVy3qNr2LCNAo+ZWjdajeMRcN5YIskbeLNdJha6uIrYI06pJ
 1UBJSkU5L2fwT6b+O6Ex9M4rgHE8MxYRBLgV8hc3WCOcaIzmRnUBbhniP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8433862"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8433862"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 03:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="14991643"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 08 Mar 2024 03:26:11 -0800
Date: Fri, 8 Mar 2024 19:39:58 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Anthony Krowiak <akrowiak@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Subject: Re: [PATCH 05/17] hw/vfio/ap: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <Zer5DmlB454EltBJ@intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-6-zhao1.liu@linux.intel.com>
 <7dadf54c-5a6f-4fe4-8dd3-1137e43c1756@redhat.com>
 <0fa974fe-6be5-4468-8581-85bccd4b720b@linux.ibm.com>
 <3a7a9d7e-3639-4adc-84a5-1126f7a13a0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7a9d7e-3639-4adc-84a5-1126f7a13a0c@redhat.com>
Received-SPF: none client-ip=198.175.65.15;
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

Hi Thomas, (and also ping Markus) ;-)

> > > > vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
> > > >     static void vfio_ap_realize(DeviceState *dev, Error **errp)
> > > >   {
> > > > +    ERRP_GUARD();
> > > >       int ret;
> > > >       Error *err = NULL;
> > > 
> > > Now this function looks like we need both, ERRP_GUARD and the local
> > > "err" variable? ... patch looks ok to me, but maybe Markus has an
> > > idea how this could be done in a nicer way?
> > 
> > 
> > Correct me if I'm wrong, but my understanding from reading the prologue
> > in error.h is that errp is used to pass errors back to the caller. The
> > 'err' variable is used to report errors set by a call to the
> > vfio_ap_register_irq_notification function after which this function
> > returns cleanly.
> 
> Right, no objections, that's what I meant with "this function looks like we
> need both" ...
> But having both, "err" and "errp" in one function also looks somewhat
> confusing at a first glance. No clue how this could be done much better
> though, maybe rename "err" to "local_err" to make it clear that the two
> variables are used independently?
>

I agree, the "local_err" is a better name and it seems we can't get rid
of this local varibale. (I can also cleanup this in the follow-up
series).

From other use cases, @err is usually used to play with @errp and
@local_err is (sometimes) used for local error handling.

I'm also unsure if this variable naming is a convention of error
handling though... Markus, what do you think about this understanding?

Thanks,
Zhao


