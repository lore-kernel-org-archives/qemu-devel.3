Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8AD2F7CC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRSTo-0000cS-AN; Fri, 05 Dec 2025 04:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRSTm-0000bd-Bq; Fri, 05 Dec 2025 04:51:58 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRSTk-00075l-2Y; Fri, 05 Dec 2025 04:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764928316; x=1796464316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bCGZ6DQdtonXrOU1TaCOp0E2igJF926Ay2psHyCh7Wc=;
 b=Tk/9S0DJkT1solhCNnPqljeo12JTOO2d41oslskC8wG29Jx69TH/twGI
 f3w7Aa3oaA/EFl3FFkNYbuviur9SKf6r2M0vtjwc+pZmgvf4XFEOjvsEB
 DfSZgYP7YqfX7mlQAnBxNX4zTOp/pug+Nc0siC6KJAM4ZsoywiVhejOIy
 5ICYTAblbRgopewHrZncsRnGJ9oA1GFO+sU5T312cOZhZAuZpY2UcrunT
 ryaoUv8U0owJIbHGGaL2aoh9yf5ghFcKfMDKMHMQSFYvztHeAYy2nplUi
 Yla175y33nimuz2r60tOWkpgjjiDLo+7l5ri4ZHZoZ+RvYUqASVBxkGaw A==;
X-CSE-ConnectionGUID: 84/nPccMQ26M0wlkKyZaMw==
X-CSE-MsgGUID: LRtBAZG9Sy6Evj4vll0dgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="54508155"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="54508155"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 01:51:52 -0800
X-CSE-ConnectionGUID: mVVhOGC8RyarA7KT5shZeA==
X-CSE-MsgGUID: kukjKAaBT++4UZaKrDFkxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="194325199"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2025 01:51:51 -0800
Date: Fri, 5 Dec 2025 18:16:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 07/14] rust: add Deserializer (from_qobject)
 implementation for QObject
Message-ID: <aTKxAl9eCMnGcyi0@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001080051.1043944-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 10:00:44AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:44 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/14] rust: add Deserializer (from_qobject) implementation
>  for QObject
> X-Mailer: git-send-email 2.51.0
> 
> This allows creating any serializable data structure from QObject.
> 
> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                   |   1 +
>  rust/util/meson.build                 |   1 +
>  rust/util/src/qobject/deserializer.rs | 373 ++++++++++++++++++++++++++
>  rust/util/src/qobject/error.rs        |   8 +-
>  rust/util/src/qobject/mod.rs          |   2 +
>  5 files changed, 384 insertions(+), 1 deletion(-)
>  create mode 100644 rust/util/src/qobject/deserializer.rs

...

> diff --git a/rust/util/src/qobject/deserializer.rs b/rust/util/src/qobject/deserializer.rs
> new file mode 100644
> index 00000000000..a2fe417e72a
> --- /dev/null
> +++ b/rust/util/src/qobject/deserializer.rs
> @@ -0,0 +1,373 @@
> +//! `QObject` deserializer
> +//!
> +//! This module implements a [`Deserializer`](serde::de::Deserializer) that
> +//! produces `QObject`s, allowing them to be turned into deserializable data
       ^^^^^^^^
Only a nit,

This "produces" word puzzled me for a while. I think it should be
"consumes".

Then the logic of 4 things did in this series should be the following?

            serializer          serialize
Rust struct ----------> QObject ---------> JSON
            <----------         <---------
	    deserializer        deserialize

Maybe we could have the similar documentation/decription in mod.rs or
somewhere to provide a high-level overview :).

> +//! structures (such as primitive data types, or structs that implement
> +//! `Deserialize`).
> +

The implementation itself looks good,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



