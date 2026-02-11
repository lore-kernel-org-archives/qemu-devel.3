Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF77FEB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq425-0006WQ-L9; Wed, 11 Feb 2026 01:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq423-0006WD-Fq
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:49:03 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq420-0006a3-T7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770792540; x=1802328540;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tlOYJ6ki0dpPiBaT8jqM/qjC6/opucgq7DX08ulKuDU=;
 b=lre5wVJTNTu6FgOxo02gZxiTuXHcDWkZ0KT5D6MwK8Mx9glNGedCMWIp
 rXeZ8oqz8cst+Z/HgEnE4Sx4FaYXyDTrZsekJPqxghpZ311b+ACVXrDKe
 gr6LI0sqVV+vXccwtK0YYi0rfKXbJkT2Niwz/uBKKI0mLg7tuJu6gsyjR
 d28Ir86k6BLgm4R4bmdl6qjg7rI/0e8PAZDj7skcapj5EisyVl1d2JnYA
 l4GvxGVKR44RrayH7sjaMNNKFP4bZ35j8fKIiOZOLf8YkAInUfd3WCW2F
 LhgWMid5qS2vYmjXunHAUNcHfQwj07CVXo52Kv0JPBYXHgGZ13sjQTotI Q==;
X-CSE-ConnectionGUID: NoTMEE12Q/uAguwkgjI0Cg==
X-CSE-MsgGUID: 11kRlbYiRJ+EKE1QtP2YuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="97390432"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="97390432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:48:58 -0800
X-CSE-ConnectionGUID: BY5hsOYFTS+3JBooxAtOGg==
X-CSE-MsgGUID: 431lHukmT+qvvVJr2p6p4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211258541"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 10 Feb 2026 22:48:55 -0800
Date: Wed, 11 Feb 2026 15:14:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 03/21] qom/object: factor out
 object_class_property_try_add()
Message-ID: <aYwsbBgjoz9uFCzZ@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-4-zhao1.liu@intel.com>
 <42a44ab0-feb6-6e9d-df20-2e6d8d50a30c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a44ab0-feb6-6e9d-df20-2e6d8d50a30c@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 10, 2026 at 03:41:48PM +0100, BALATON Zoltan wrote:
> Date: Tue, 10 Feb 2026 15:41:48 +0100
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH v2 03/21] qom/object: factor out
>  object_class_property_try_add()
> 
> On Tue, 10 Feb 2026, Zhao Liu wrote:
> > Similar to object_property_try_add(), factor out
> > object_class_property_try_add().
> > 
> > This allows adding more arguments to the core implementation without
> > changing the signature of object_class_property_add(), avoiding the
> > need to modify the extensive number of callers distributed throughout
> > the code tree.
> > 
> > While at it, add documentation for these functions.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > include/qom/object.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
> > qom/object.c         | 34 ++++++++++++++++++++-------
> > 2 files changed, 82 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 05706d4d7e3a..060db136988b 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1147,6 +1147,62 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
> > 
> > void object_property_del(Object *obj, const char *name);
> > 
> > +/**
> > + * object_class_property_try_add:
> 
> This is renamed two patches later so maybe should be named like that here
> and drop the renaming patch.

Indeed, these two patches seem trivial, but I still prefer to separate the
renaming patch. Reviewing patches related to renaming is always
straightforward and maybe relaxing. :)

Thanks,
Zhao


