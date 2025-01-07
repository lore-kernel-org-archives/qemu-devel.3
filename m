Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B348E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9r6-0003rv-KO; Tue, 07 Jan 2025 08:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tV9qz-0003rH-LE; Tue, 07 Jan 2025 08:42:42 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tV9qv-00055n-UQ; Tue, 07 Jan 2025 08:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736257358; x=1767793358;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yNliXUkL8tj6/zZ3Icw4QFTzFBtbTX7zCyWe9j1llBk=;
 b=ZVGxOum3FoPHTFaL4eI4xi2ugXtF8Fok6OXSfnGBNw5jx53PQxjKMLTg
 cqqf8Z+MWKM8UCr4L63Yw7FRYV+djy/xVGV4YV/BYvIeRIBRZDAvdax1F
 NEa9bNOG42AEJtbsJMcvUiBrN1Qu3hPQlCAx6T8r8E7TWlwfhR1k/XmET
 kKw55ui1blJz8vgMCXK2eKcZaDLy5BwgaIOIXYwpmsnPP4a8xy2GPEt8j
 LR0JSHd9kyakfu34Scpqsb7zw1Xv5oGEd9brDXFaodymt1+yuiM18ZmiF
 AYHuPqD9OIRCn5YRudBgz7cDcOlSmvNHn8KICII5hN3x8peUvaQ6wvFaj g==;
X-CSE-ConnectionGUID: sAO0pu1cRqqL0BtyVUIVVg==
X-CSE-MsgGUID: r023MZ0cQLmVsXyEFhizTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35672092"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="35672092"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 05:42:33 -0800
X-CSE-ConnectionGUID: kSfna26QR7muYxrDCs74VQ==
X-CSE-MsgGUID: gWD9EhGnQ8a/bZyZwRBt6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="107820698"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 07 Jan 2025 05:42:31 -0800
Date: Tue, 7 Jan 2025 22:01:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 1/9] rust: vmstate: add new type safe implementation
Message-ID: <Z30zr4Se4lhlHcyo@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-2-pbonzini@redhat.com>
 <Z3zstgKXAgeRrIU2@intel.com>
 <CABgObfbdFo9B1nedC+Bu2QQfjTL1TOpmSQt0p0a0d0iWev6UKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbdFo9B1nedC+Bu2QQfjTL1TOpmSQt0p0a0d0iWev6UKg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

> > Very flexible and powerful. (I even think this code could be released as
> > a new public crate.)
> 
> It's probably not _that_ useful in general, unless you're implementing
> this kind of reflection... otherwise I would have found an existing
> solution. :) But yes, it's very powerful.

Personally, I feel that projects that glue C and Rust together require
similar tricks more, making them more challenging.

> Out of curiosity, I asked claude.ai to explain it and it said "This is
> a rather advanced use of Rust's type system and macro capabilities to
> do compile-time reflection - basically inspecting the types of struct
> fields without runtime overhead. While creative, this pattern isn't
> commonly needed in everyday Rust code."
> 
> When fed the initial comment from the Rust forum it said "your comment
> about wanting to access <T as SomeTrait>::SOMETHING for a field's type
> is a classic serialization pattern - often used to get things like
> type IDs, serialization formats, or field metadata at compile time".
> That's actually pretty impressive; the LLM was also impressed and it
> started asking me more about it ("Are you building a custom
> serialization framework from scratch, or extending an existing one?").

Incredible, commercial LLMs are so proficient in Rust and provide such
professional comments (even a bit off-topic, it feels like LLMs could
even review patches).

Thank you for providing this interesting example. LLMs are indeed the
good tool to help get started with and practice Rust.

Thanks,
Zhao


