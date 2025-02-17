Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16068C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwQv-0006uk-G8; Mon, 17 Feb 2025 03:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjwQs-0006uG-QI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:24:50 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjwQm-0001kD-PM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739780685; x=1771316685;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CuIT/DSW+7c6MXjNpTu3KqgUd3IuJQjeCONMJ87IwE4=;
 b=flK7tFC1LnDx4air1vuYhtnt4ULqJhs9ZYrX+rsevEgWM5DQJ+OsTLEO
 jv0FdU2xy1eYtcTf30VMz5Ve1yIQswVG79Ee2Z0WntJLJu+VNMf2Ve9NB
 YKvuJNRGkCuD6y8O/MJDmxrbdCE0+5BkxHO8B1vixDLgmCFGGsp+iwj0K
 dy0Nzb5NpWExtq97Nv7sZisVYW3QQnK9IIo53JP/D2u7lSKmwPKBAoAB4
 +9Tdd1pUaWFzpFYZ3AX0wdfZLeJnzUbii4Zkf2yEbCtCxqMSU+R3kdlaR
 l0130EMqM96JPBAwINPh4HQpP4W+jytvqcdty35wG1CCzKn7vM/LjgQfb A==;
X-CSE-ConnectionGUID: s3XWmVQMQO+auEAMauoeXQ==
X-CSE-MsgGUID: 3791jUAaQriqmfK20bqMJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40482650"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="40482650"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:24:42 -0800
X-CSE-ConnectionGUID: SUpDHisKQT2AM257A6wX0Q==
X-CSE-MsgGUID: QGrn1bytQz+qCIRGJBmumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="113991582"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 17 Feb 2025 00:24:42 -0800
Date: Mon, 17 Feb 2025 16:44:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hpet: do not overwrite properties on post_load
Message-ID: <Z7L2338isu0OBprC@intel.com>
References: <20250216092853.4169458-1-pbonzini@redhat.com>
 <Z7LdS0JkMBqUugRZ@intel.com>
 <CABgObfanbj8bxibKOVfk3erKMx8o6_ar-X7OqEKhxnde3iyCNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfanbj8bxibKOVfk3erKMx8o6_ar-X7OqEKhxnde3iyCNA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 17, 2025 at 09:02:24AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Feb 2025 09:02:24 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2] hpet: do not overwrite properties on post_load
> 
> Il lun 17 feb 2025, 07:35 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > > @@ -347,14 +330,13 @@ static const VMStateDescription vmstate_hpet = {
> > >      .version_id = 2,
> > >      .minimum_version_id = 1,
> > >      .pre_save = hpet_pre_save,
> > > -    .pre_load = hpet_pre_load,
> > >      .post_load = hpet_post_load,
> > >      .fields = (const VMStateField[]) {
> > >          VMSTATE_UINT64(config, HPETState),
> > >          VMSTATE_UINT64(isr, HPETState),
> > >          VMSTATE_UINT64(hpet_counter, HPETState),
> > > -        VMSTATE_UINT8_V(num_timers, HPETState, 2),
> > > -        VMSTATE_VALIDATE("num_timers in range",
> > hpet_validate_num_timers),
> > > +        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
> >
> > This change is safe since it doesn't change the vmstate layout so that
> > there's no need for bumping up the version.
> >
> > But I still have the question as the comment in v1 [*]. User doesn't
> > have any way to modify the number of timers, why not just replace this
> > vmstate field with "VMSTATE_UNUSED_V(2, 1)"?
> >
> 
> Because I didn't want to bump the version; your suggestion is indeed
> simpler but it would break migration to past versions of QEMU, which check
> that num_timers is in range. VMSTATE_UNUSED would write a zero.

Yes, this way needs to tweak num_timers in post_load.

> For Rust, I think it's easier to place the check in the post_load callback
> BTW.

Yes, I agree. Will honor this change on Rust side.

Well, pls let me add my r/b tag as well,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


