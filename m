Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27810EB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq49C-0007ew-B6; Wed, 11 Feb 2026 01:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq49A-0007eo-V7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:56:24 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq499-0008Mn-6y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770792983; x=1802328983;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0LyxVWvvREX0A4Hq/9c98w6MTu5CtWSzfVL9UpSuopE=;
 b=HS2N7zc/ZLrRfgH5ryZrbbQWcku/4zfhm12tkMi+I6aRe9i+ktRX/r8w
 kgRujkKNDq/ji4bh1+q/jpHxzswtXjT3YeKBOMQFlO6Bqc2NlU48ec+lu
 XRJQb9+tRbggd20wzpDen3Ep1qFRIT+yOJOOzj2zyuPeHTuRHB+WJBj12
 hwdm4qBp7Hb9VGgv5YZj+3Ts2kAhoOzDEyoAOz8PsMcIeMnX3vA/+0HXH
 kcl2RLNmyyBFkFVPkEwkj2176DKOXYRLPsaqqyXcOfUdPJEbjDL0qZiHa
 gC2Y6SJ129COGdGflf58Y/zlqwzL/vQYy3qaZStFxDLzYfgeQbDHuY/yJ g==;
X-CSE-ConnectionGUID: BKthiIaORAKven60ywKRrg==
X-CSE-MsgGUID: 342N7FLRRoS01be26RiRsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75780361"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75780361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:56:19 -0800
X-CSE-ConnectionGUID: 4hIhQYhyTei75kwjyMVKkg==
X-CSE-MsgGUID: nY4x91VkTcihFpBSz8XQ+w==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 10 Feb 2026 22:56:15 -0800
Date: Wed, 11 Feb 2026 15:22:14 +0800
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
Subject: Re: [PATCH v2 07/21] qom/object: introduce user interaction flags
 for properties
Message-ID: <aYwuJsM4PgG/Nps8@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-8-zhao1.liu@intel.com>
 <d5d64a1d-bfac-261b-b9a6-cec6a7aad7d6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d64a1d-bfac-261b-b9a6-cec6a7aad7d6@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

Hi BALATON,

> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 856b12e7289c..1b77429aa28b 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -109,6 +109,30 @@ typedef enum {
> >      * will automatically add a getter and a setter to this property.
> >      */
> >     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> > +    /*
> > +     * The property was explicitly set by an external user.
> > +     *
> > +     * This flag is set whenever the property is modified via external interfaces
> > +     * (CLI, QMP, HMP). It allows internal code to distinguish whether the
> > +     * property has been modified by the user.
> > +     *
> > +     * Once set, this flag persists even if the property value is subsequently
> > +     * overwritten by internal logic. It is NOT automatically cleared and must
> > +     * be explicitly cleared using object_property_clear_flags().
> > +     */
> > +    OBJ_PROP_FLAG_USER_SET = BIT(2),
> 
> As this isn't strictly for user set maybe jusr call it
> OBJ_PROP_FLAG_EXTERNAL? (Can be set by external management application or
> global compat prop in later patches so user set is not quite right name,)

This flag is dynamic - when external user touched a property via
CLI/HMP/QMP, then this flag will be set.

Even though later some QEMU internal logic re-set the property, this
flag is still there.

So, this flag means external user *has touched/set* the property.

Thanks,
Zhao



