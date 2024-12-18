Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFACE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNumf-0001HL-Ln; Wed, 18 Dec 2024 09:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNumb-0001Er-0B; Wed, 18 Dec 2024 09:12:13 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNumZ-00071h-3j; Wed, 18 Dec 2024 09:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734531131; x=1766067131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dtVLVjcGMGv3WzoMW4E+eWrZx/eWQnpVTKr7VONHlTo=;
 b=VX76J87rYiF8BFmZL72T0+X+vltH7DihieAJSag1RjkepjWBN9ShELuu
 pl9+7d04dk8xEXvGKQcQ/xneTkPL7Cb4jhQQPGHeATxcKmTE6YTCQqp+N
 yT23houl82k2haruutBadHTntyy4+KemnFFcBROsRpU/M+1aSsqByOP9J
 9oAsp91wCm4OgItPZhX0CISHPSKq9duDnIEDhCSAF+P+7tzZZm6QVjV7N
 cMyXBi0tKRT8vpZZIp41AXv/ReL0ybrf6pIk4zHo0qZqeIAPB+oRkQlkD
 b7Wykkq6+4+Co2Tur/W1nRdV+del222+EEBd7fxyrKhV5T0coP/J+2288 Q==;
X-CSE-ConnectionGUID: URT38MyeTj2S2CrUSCzEMQ==
X-CSE-MsgGUID: 4KPdqzYpR+GLxD6hzPcLmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38943293"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="38943293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 06:12:07 -0800
X-CSE-ConnectionGUID: ESr1MCOKTDadDkh6reX+EQ==
X-CSE-MsgGUID: g6334WAQRTmn3sVaDB6Ebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="102483547"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 18 Dec 2024 06:12:06 -0800
Date: Wed, 18 Dec 2024 22:30:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
Message-ID: <Z2LclR0SuCdEV03z@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
 <Z2D2zk2Wdlqc5q2k@intel.com>
 <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
 <Z2JycooziPsfV8vX@intel.com>
 <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> No, Self is not PL011Class. Self is PL011State (or PL011Luminary/ and it
> always remains the same. What changes is *what part* of the class is
> overwritten, but the order of calls from qom/object.c follows the same
> logic in both C and Rust.

Thanks! Now I feel I see!

For C side, type_initialize() will allocate a new class instance by
`ti->class = g_malloc0(ti->class_size)`, then actually C side's parent
class_init will initialize that new class instance.

For Rust side, the initialization call chain will initialize Self's
embedded parent class, one by one.

So that's fine!

> > Maybe the confusion is because I implemented class_init twice instead of
> > > using a separate trait "PL011Impl"?
> >
> > Ah, yes! But I think the Rust call chain should not use class_init anymore
> > but should use a different method. This way, the original class_init would
> > only serve the C QOM. A separate trait might break the inheritance
> > relationship similar to ClassInitImpl.
> >
> 
> Do you still think that this is the case?

No, now this patch is fine for me!

Thanks,
Zhao


