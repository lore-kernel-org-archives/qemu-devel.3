Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96D0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2U7-0005ip-Tu; Tue, 10 Dec 2024 10:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2U6-0005iM-HE; Tue, 10 Dec 2024 10:49:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2U4-0002ec-J8; Tue, 10 Dec 2024 10:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733845753; x=1765381753;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kMu+D6zFqxfdlxyMBTsCF9O26ZYMYjrIvuxZXW/bCYo=;
 b=BBfpUfyQ+76eCrC4ThU//Ewl/j23gsUWvYIMkz94JhIlRULZV5j3B4yv
 Pd9HhOA/jlUNKaaVICwTHb0w5wDD7B5GN2wJ7+LVR3os+0Et1Aa34+VeF
 MnkUzZbqOvyZAeBBvoGGjfKKNhql0PnUJSNN4d6H9BQWNTbC7XrEoRjvM
 rbqFmsLc3QAv0cECLOJMsWzwUNtutFWvPEWfiElZKoWwKca19Qcm89zrp
 fhcTKa3H08M0ec4QFac4UEbwt7OT+gQNcQvkkrIz/Th6IgnwLAlfuyIL8
 PAQGM7qbWfEZG4bFneew7Yc2oL54p5P8dlDjeMj+fAhH1kfAnMJqqD4fU g==;
X-CSE-ConnectionGUID: FUM6p2XSQiScTO43B8HM0g==
X-CSE-MsgGUID: t8VYR7zHSAaR/tD3J1rm5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56677279"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="56677279"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:49:10 -0800
X-CSE-ConnectionGUID: MEKP4zOUTHaFKzk/lKuj5Q==
X-CSE-MsgGUID: vd6tKYr6S1agJ5WPEJOPPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="118692253"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2024 07:49:09 -0800
Date: Wed, 11 Dec 2024 00:07:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 12/26] rust: qdev: move bridge for realize and reset
 functions out of pl011
Message-ID: <Z1hnO3Q3ndNSPfcp@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Dec 09, 2024 at 01:37:03PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:03 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/26] rust: qdev: move bridge for realize and reset
>  functions out of pl011
> X-Mailer: git-send-email 2.47.1
> 
> Allow the DeviceImpl trait to expose safe Rust functions.
> rust_device_class_init<> adds thunks around the functions
> in DeviceImpl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       |  5 ++--
>  rust/hw/char/pl011/src/device_class.rs | 26 -------------------
>  rust/qemu-api/src/definitions.rs       |  2 +-
>  rust/qemu-api/src/device_class.rs      | 36 +++++++++++++++++++++-----
>  4 files changed, 33 insertions(+), 36 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


