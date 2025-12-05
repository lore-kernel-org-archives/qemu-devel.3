Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD99D2F7C4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRRUM-00018a-1E; Fri, 05 Dec 2025 03:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRRUK-00014l-7Z; Fri, 05 Dec 2025 03:48:28 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRRUH-00007D-MS; Fri, 05 Dec 2025 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764924504; x=1796460504;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZoowBp/+fqf4cU//YJtklxyItMkc7kAUBkJoMq3oo/0=;
 b=LWavgd+6m2tnZe/UV8vRsu3GLhSzek9jnkWelF5palh/URXYnM9jTJCV
 SYzrDcDZo3xytpZNbl2i3I3n+CH7J5wpL2plh+kGj5w8AjlM8pedR73KV
 hpM8PYkIoTEAPp16hfSMPHkLssKrKlhxAswCGpDLTchSkKhaHaIAP9jdn
 VzSDTirvoGxiAGVE8jxyloEZ7ZA8k5midKEzmbc6HlRoSaezWZIMKdEhk
 I5Agy5Rb5IfrGPw37anJ0cxJQ8Klj6ekQzpv0Fs6N1Pm8mZWXLXV8YLJE
 pb4ydhW8DUbPtqNFdjcxC0jL96w+TCsPoMD4lIr42juWcaorQSNgXHDqi g==;
X-CSE-ConnectionGUID: n6geb9nqQHijozemU4Q20Q==
X-CSE-MsgGUID: TxMYy5kjRiibaCoVdXU9AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78068209"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="78068209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 00:48:18 -0800
X-CSE-ConnectionGUID: yPzmA4VgQQG2+9KFKqi/Dw==
X-CSE-MsgGUID: FrkOlmO0TmKg/kACBzJvkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="194898947"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 05 Dec 2025 00:48:18 -0800
Date: Fri, 5 Dec 2025 17:13:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 05/14] rust: add Serializer (to_qobject) implementation
 for QObject
Message-ID: <aTKiHjOZxwZextt6@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001080051.1043944-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 10:00:42AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:42 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/14] rust: add Serializer (to_qobject) implementation for
>  QObject
> X-Mailer: git-send-email 2.51.0
> 
> This allows creating QObject from any serializable data structure.
> 
> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/meson.build               |   2 +
>  rust/util/src/qobject/error.rs      |  52 +++
>  rust/util/src/qobject/mod.rs        |   4 +
>  rust/util/src/qobject/serializer.rs | 585 ++++++++++++++++++++++++++++
>  4 files changed, 643 insertions(+)
>  create mode 100644 rust/util/src/qobject/error.rs
>  create mode 100644 rust/util/src/qobject/serializer.rs

Good implementation,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


