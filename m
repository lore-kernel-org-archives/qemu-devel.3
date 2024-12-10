Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DF9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2PB-0002fi-TM; Tue, 10 Dec 2024 10:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2P9-0002fT-Kn; Tue, 10 Dec 2024 10:44:07 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2P7-00022h-H9; Tue, 10 Dec 2024 10:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733845446; x=1765381446;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pDWZ/cee+vIPlZALlx6jDXoxQc7ILwuIIDd+JeIrWI8=;
 b=dV9ffb7zZuskz95ipv8gIVcBTPT83Cb5sC3Qc4Ju1PGXvj+uQZPMtZh7
 Vp7Qk/s9BEguUHXX53f737wrwGctM4oIB2+yy56xmbTTRKOdkQ1GaNjtH
 LI9/kXM4xazBkLdIKQLFgrFhPDvNIFJOCpMUPxyJbG9iSjdw14KLrkWjE
 IaDGkFCqgnXWjh4CQJQbQQ74RPvXghJRTA5zg/nRHiLMXPOOF0WdjGDAd
 FFdH9TMug/U5HznlspnEPuq2NA9SSaFdgMw1YpMkuaqiI5IDnYU09352Z
 +UOM1Vdr/Fed+su/bFClBRLbz9dDe6tZH8W7vYylr2AlrtCaN931SwalW w==;
X-CSE-ConnectionGUID: bfkyQsKoTKauUn980FC8aA==
X-CSE-MsgGUID: R0pQgHXSSZO8Um5B/BvTdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34249165"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="34249165"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:44:02 -0800
X-CSE-ConnectionGUID: /uxuTAKQSWil5IwJGzdXtw==
X-CSE-MsgGUID: bupINUsXQHmacpMaTDpOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="95645703"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 10 Dec 2024 07:44:01 -0800
Date: Wed, 11 Dec 2024 00:02:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
Message-ID: <Z1hmB4znBSsJV6uO@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

> +unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
> +    // SAFETY: obj is an instance of T, since rust_instance_init<T>
> +    // is called from QOM core as the instance_init function
> +    // for class T
> +    unsafe { T::INSTANCE_INIT.unwrap()(&mut *obj.cast::<T>()) }
> +}

Here's the difference, why doesn't init() narrow the unsafe scope like
post_init() does?

> +unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut Object) {
> +    // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
> +    // is called from QOM core as the instance_post_init function
> +    // for class T
> +    //
> +    // FIXME: it's not really guaranteed that there are no backpointers to
> +    // obj; it's quite possible that they have been created by instance_init().
> +    // The receiver should be &self, not &mut self.
> +    T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
> +}
> +



