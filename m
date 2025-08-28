Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CCFCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 06:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urWUn-0000dR-O2; Thu, 28 Aug 2025 02:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urWUm-0000ce-4c; Thu, 28 Aug 2025 02:52:28 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urWUh-00080O-Fh; Thu, 28 Aug 2025 02:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756363943; x=1787899943;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7wwSM/QgRCu1i/KZOqVDJmmLgbesqWKyyhQSawNEvv8=;
 b=MHNT+BzZ3j4X9Yls5MqMBii3Ad62MA4GAdDeKEIBwPF7OaPNqFEWCftN
 E44xCbvFdwpuCfZcbeRnsd49EoGmJj1b4mTHTiqSzfUw+unQJxUo0hcvg
 4h+xqHdQdU7IPB8dwB4dA1c/gHWicM18mNnAxs4gkzT7bV2swfpMe6x4g
 nttFeGuvShnnvX5ogxo+pxBBUfot87a2GZtmOa1gJMBz1IUpNYTpblDhM
 wCDYkfknbb6jGvHghre2xAIfWZckTc0DK0EkhP4eg0JUvM5+z9qCOEH39
 cpD0loBu579HFsGE40qWETpEtFIIRjql2MPCfRQJtgL8flz0KbsTtIVN6 g==;
X-CSE-ConnectionGUID: 99IZcuhsQ7mzUclhOhV8yQ==
X-CSE-MsgGUID: CDfPgU8GQpiEWS64VXc7Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58554077"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="58554077"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 23:52:21 -0700
X-CSE-ConnectionGUID: iemhMvoMS023zvux7Ghrpg==
X-CSE-MsgGUID: pzrAf6FiQTKSBZizJkAGGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175307235"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2025 23:52:19 -0700
Date: Thu, 28 Aug 2025 15:14:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 04/22] rust: make build.rs generic over various
 ./rust/projects
Message-ID: <aLABvvuKnrdpGQrg@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:26PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:26 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 04/22] rust: make build.rs generic over various
>  ./rust/projects
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Guess the name of the subdir from the manifest directory, instead of
> hard-coding it. In the following commits, other crates can then link to
> this file, instead of maintaining their own copy.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api/build.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
> index 29d0945625..92237183ec 100644
> --- a/rust/qemu-api/build.rs
> +++ b/rust/qemu-api/build.rs
> @@ -9,12 +9,14 @@
>  use std::{env, fs::remove_file, io::Result, path::Path};
>  
>  fn main() -> Result<()> {
> +    let manifest_dir = env!("CARGO_MANIFEST_DIR");
>      let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
> -        format!("{root}/rust/qemu-api/bindings.inc.rs")
> +        let sub = get_rust_subdir(manifest_dir).unwrap();
> +        format!("{root}/{sub}/bindings.inc.rs")
>      } else {
>          // Placing bindings.inc.rs in the source directory is supported
>          // but not documented or encouraged.
> -        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
> +        format!("{}/src/bindings.inc.rs", manifest_dir)

Only a nit: cargo clippy suggests this inline style:

format!("{manifest_dir}/src/bindings.inc.rs")

>      };
  

