Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB6F3C255
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzacz-0004Tu-OY; Mon, 09 Mar 2026 09:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzacv-0004Td-5v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:26:29 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzact-0002cB-1n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773062787; x=1804598787;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nHD3zBwE4d4TXKS2rsH9dqaZ9W5gGdXCpw9MjvPzGNc=;
 b=Goh+frfHkOIIV9bSFx68f8oJnE9TVimVIZQPcY0m5LwvazSVvspDCgvg
 IiFpUCwb22YQpkvYCMt1J0B6O3tiwymv7Zz/awXHzeF6wtO7S/AGwMvqV
 9KaYCT6WFqVezF/zKgoYKUALzUwBb9/MduvEcmNd27vIGr4LSlJPevIlD
 1xdgOOJf2vVBU4nepxX4DLExYl3GM/J3m/wBC1ZY8oY1Wu1TWd6Tl0epo
 xwqn1VeY20d0/h8bkGBILNRuWFy1JCTSMAxOykvoqxkGHje9WaqvKzAjl
 SPNtO9necEFek54dQn7d7OXNxACQfVk8ihjwWi6izCJwFjdlzdFTn36zs g==;
X-CSE-ConnectionGUID: ao2Nxlc1Si2YbJxOIqqffw==
X-CSE-MsgGUID: WZi0Y1dqTMirSSzrhDn4rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74163397"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74163397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:26:24 -0700
X-CSE-ConnectionGUID: dMEEoMHyRHun91CpBDceVg==
X-CSE-MsgGUID: x2ik7fq0RrmSB7fPhBsitA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="242775445"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2026 06:26:20 -0700
Date: Mon, 9 Mar 2026 21:52:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <aa7QngAWMaspv6Gu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com> <877brpjof7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877brpjof7.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> Not entirely true.
> 
> QAPI/QMP uses special feature flag @deprecated, i.e. a boolean.
> 
> We cannot emit a "user facing message": QMP cannot transport warnings.
> We could at best log one, in the hope that the user finds it.  But we
> don't.
> 
> Instead the deprecation note is in the documentation.
> 
> The deprecation flag is visible in QAPI/QMP introspection.  Management
> application developers need this; see Peter Krempa's reply.
> 
> QEMU can be configured to reject input that makes use of deprecated
> stuff, and to hide deprecated stuff in output.  This is intended for
> "testing the future".

I think a way is to add 'deprecated' flag (bool) in ObjectPropertyInfo,
just like CpuDefinitionInfo did. Then only when property has a
deprecation_note string, the 'deprecated' flag will be set for QAPI/QMP
query.

> >> Yes, rich deprecation hint is better. I think this still depends on
> >> USER_SET - distinguish internal/external or not :-(.
> >> 
> >> Since when we mark a property as deprecated, its code remains in the
> >> code tree, and internal calls should not trigger warnings. Deprecation
> >> hints are intended to reminder external users.
> >
> > This depends on where you put the deprecation check. IIUC, all the user
> > facing codepaths for setting properties end up calling through
> > object_set_properties_from_qdict, but internal codepaths don't use that.
> 
> This may well be true (I didn't check), but how can we ensure it remains
> true?

Perhaps this interface requires documentation - and strongly caution that
it *should not* be used for internal calls. Might this help prevent
potential misuse?

Thanks,
Zhao


