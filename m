Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6457CD2F7C9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRS8u-0002Vh-9Q; Fri, 05 Dec 2025 04:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRS8q-0002UZ-Da; Fri, 05 Dec 2025 04:30:20 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRS8o-0003NP-Iv; Fri, 05 Dec 2025 04:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764927018; x=1796463018;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bXhnoCKrPvnz5fpUNMS3NxozDccefiop93z/URA4KqA=;
 b=Eg+Kfjpy9ryDzrGvPUDtperteeQoaTr+hrWfdEYEBgRqbI1ro/5mugUV
 6ZEpzbyTzqbshyzD9bAt6LSP1qVF8bauxsFqBOUYR05czXqFGUbqCTlVN
 2xow8Y1v9ncmphRypo4iRHvW/4SK4F+EQHrT002aGgNRsl4cAwpoE7oWX
 yz30X0CmaZmI5sLA7iMPVIfBFq2USHHhokYAzkIQoJ0Pj1HmCLq+ZMe0s
 ZUWN3EF+itCmk2ZD2e/Gt9ZShrILzh9gFCR69oq/m130WEVRwJy2P2OMm
 WoStq+k1V2F7RLw5hlwn+1AyspupMl4rKEjNEb6HgNPvwOz6IRwkU1ziM g==;
X-CSE-ConnectionGUID: 37Kz9vHmT/2jWsqMoHKSjg==
X-CSE-MsgGUID: YezY33jfSjCMlD25S+rD4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="69552903"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="69552903"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 01:30:15 -0800
X-CSE-ConnectionGUID: ZxWR96hDT/CN28uhSGt6WA==
X-CSE-MsgGUID: 7JyG4rO5RYmCpr4+q6fDgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="195281968"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 05 Dec 2025 01:30:14 -0800
Date: Fri, 5 Dec 2025 17:54:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 06/14] rust: add Deserialize implementation for QObject
Message-ID: <aTKr8RD3pdHwqk7q@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001080051.1043944-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 10:00:43AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:43 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/14] rust: add Deserialize implementation for QObject
> X-Mailer: git-send-email 2.51.0
> 
> This allows QObject to be created from any serializable format, for
> example JSON via serde_json.
> 
> This is not too useful, since QObjects are produced by
> C code or by serializing structs, but it can be used for testing
> and it is part of the full implementation of a serde format.
> 
> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/meson.build                |   1 +
>  rust/util/src/qobject/deserialize.rs | 134 +++++++++++++++++++++++++++
>  rust/util/src/qobject/mod.rs         |   1 +
>  3 files changed, 136 insertions(+)
>  create mode 100644 rust/util/src/qobject/deserialize.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


