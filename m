Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F4E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 17:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJyBE-0007sn-CT; Sat, 07 Dec 2024 12:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJyAQ-0007gN-7V; Sat, 07 Dec 2024 12:00:36 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJyAM-0001eh-Ss; Sat, 07 Dec 2024 12:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733590827; x=1765126827;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tnQC/BzXvfNbpGusQMKMUD9pjUUU8pMbWPrAlvOejHA=;
 b=ZqXL7D+NP29gWmngEf0+JSc0Kfkru59hliZoHe+SvHjFfoX91J4NSHQf
 P0L4Evu9t6/l+5EdOS3pE//NqOD7QHjf7+fLewVxB6tx8rsx70FE8UqEN
 y0T/LghyUIRogf7zQhUFznDiq43cs8D1pVEhx19PXp4bPwUvy8kJzQHZ+
 en3badHVSovoaSXKKH+3IShPTuZvr/gPHB1CKEKdfXOB174TJLNTiKp6B
 Xzb+ceGDwbh8hGd3zVIhCmWyYL8CvnAeW9EaDiCiXgTg3ZVehC0PjtVhk
 OB5vjo1B2I4BvtL7ZfXPhaR4IKDRpF7/0Rnoe/tgvH8Syrg+BnEOuTPwR w==;
X-CSE-ConnectionGUID: sVqBtCNnRDSz3XW0eDMACw==
X-CSE-MsgGUID: EZFOolQWTuu4edcJWlWNNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="44536333"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="44536333"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 09:00:24 -0800
X-CSE-ConnectionGUID: 3LJP2KvCSci8Du6DB/KKug==
X-CSE-MsgGUID: s/5bWN61Q5qiBk6Y1ApXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="95125938"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 07 Dec 2024 09:00:15 -0800
Date: Sun, 8 Dec 2024 01:18:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 07/13] rust: add bindings for timer
Message-ID: <Z1SDZOCywqmKCOX3@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <cc6cc13d-ec95-45d2-8722-e12f3b82ff92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6cc13d-ec95-45d2-8722-e12f3b82ff92@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

> It might be cleaner to move all of those static inline into timer.c.
> I don't see anything performance sensitive there...

I agree, thanks! I'll submit a patch to clean up this.

Regards,
Zhao


