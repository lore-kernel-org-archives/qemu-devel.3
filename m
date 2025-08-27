Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA792CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 02:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur61u-0007Ve-Sq; Tue, 26 Aug 2025 22:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ur61r-0007O9-6K; Tue, 26 Aug 2025 22:36:52 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ur61j-0004m4-Tr; Tue, 26 Aug 2025 22:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756262204; x=1787798204;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rts/0Q3cR6nRJCzrtg2wLNXiZ3VhT8rRBY6bKGvvPhM=;
 b=g98aK682eJ7+a/3JenardCkseMH7f1P6keKa85CzdkikkMa0PjhEy9ne
 eMAkEabp+OiddVUiAqUAFudYpfY3zDqzeAyU0bomuobpGPEmzMLsYylDt
 fKsZKYJghWgwyv72sv2Ip+G4dzeoUMKXaUZhDIM9cQvCcq4Mh/1uwuqoQ
 PirN1H6baqK8siamWkvnb9KHs+M3ZfQB8eB91c3QLQFGZYi5W2/aD/dTF
 qPP4Ngtwm6aqh/jwn28VPgncTprbjlzRfEIVQfzc+DnlRNUYz0844LUcW
 Wf59aRBrZ815a95I4leikux/F5nR33xhlQNsLHf4Hm5Q30IXGHxVqoGvD g==;
X-CSE-ConnectionGUID: X7sCn0yURRyu9Q3mfCC0fg==
X-CSE-MsgGUID: w6lLkgNBR4mK/5dVYyW8lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="83914131"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="83914131"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 19:36:34 -0700
X-CSE-ConnectionGUID: dhwEPE02R5uZErxgBfvP+w==
X-CSE-MsgGUID: 4KzYpUURSOm63wBRRO4j4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169641087"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 26 Aug 2025 19:36:32 -0700
Date: Wed, 27 Aug 2025 10:58:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/4] rust/qemu-api-macros: make derive(Object) friendly
 when missing parent
Message-ID: <aK50Sjm595hUDJXB@intel.com>
References: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
 <20250826133132.4064478-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826133132.4064478-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Tue, Aug 26, 2025 at 05:31:32PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Tue, 26 Aug 2025 17:31:32 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 4/4] rust/qemu-api-macros: make derive(Object) friendly
>  when missing parent
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


