Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D7FC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 06:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTwlf-0004if-Co; Tue, 24 Jun 2025 02:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTwld-0004iM-Eg; Tue, 24 Jun 2025 02:04:25 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTwlb-0004yR-45; Tue, 24 Jun 2025 02:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750745063; x=1782281063;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TFJmV5L5V8xaJ+OtJMXsOdVwtyd31h4ycfHa8SFGLig=;
 b=A4l0I8tLfk1+ZwUqiK7zqKLpj1OkvrRd9eZb7YRObSZDvcvVeV732m8m
 kbRZb5/DMQf4cJMp8/Y5z1nSI8tBM7b2yHFFBMghH4wQ5sTdiQHrVKDMD
 pFJmT5YT1f2ZxPFZMqZ6nJZgu/5Bo/AoLwfdHk28fThgjyXtMQGjyr3Ym
 TAwfPH3IcA+hEJS8HlqESyU/WkBUp/22R5ynJphVcrooZ0khxP5X/yaB+
 8HZMeIiUGuVU5UMxMzGeTo5OhM4I5h4dlG4AwF3vAN69XtOcOFJGHVXsJ
 bft/KWTBvA/OihpfXN0a7RMgRDulpK526JAmuyZxxR1F3WkwchmadlDv6 w==;
X-CSE-ConnectionGUID: 8sAd/FvtSnuoRNjzqaEGiw==
X-CSE-MsgGUID: QyK8DrY1TMyXcG+pNvaRIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70540245"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="70540245"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 23:04:15 -0700
X-CSE-ConnectionGUID: 8rQc3CDCQ86K46OI8bKTtQ==
X-CSE-MsgGUID: A/pZ1EaQRWyaIy9K/q8HQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; d="scan'208";a="156203168"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Jun 2025 23:04:14 -0700
Date: Tue, 24 Jun 2025 14:25:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org, shentey@gmail.com
Subject: Re: [PATCH] rust: log: implement io::Write
Message-ID: <aFpE3y5B7tS2efvA@intel.com>
References: <20250617081213.115329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617081213.115329-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> +/// A RAII guard for QEMU's logging infrastructure.  Creating the guard
> +/// locks the log file, and dropping it (letting it go out of scope) unlocks
> +/// the file.
> +///
> +/// As long as the guard lives, it can be written to using [`std::io::Write`].
> +///
> +/// The locking is recursive, therefore owning a guard does not prevent
> +/// using [`log_mask_ln!()`](crate::log_mask_ln).
> +pub struct LogGuard(NonNull<bindings::FILE>);

Nice! I happen to be implementing a similar RAII for FlatView:

pub struct FlatViewRefGuard(NonNull<FlatView>);

> +impl LogGuard {

...

> +    /// Writes a formatted string into the log, returning any error encountered.
> +    ///
> +    /// This method is primarily used by the [`log_mask_ln!()`](crate::log_mask_ln)
> +    /// macro, and it is rare for it to be called explicitly.
> +    pub fn log_fmt(args: std::fmt::Arguments) -> io::Result<()> {
> +        if let Some(mut log) = Self::new() {
> +            use io::Write;

I think it's better to place this "use" at the beginning of the file.

> +            log.write_fmt(args)?;
> +        }
> +        Ok(())
> +    }
> +}

Overall, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



