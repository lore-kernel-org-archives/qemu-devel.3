Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1964FC61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsc2-0008AZ-6i; Fri, 28 Aug 2026 05:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzsc0-0008AQ-J3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:11:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzsby-0004ke-Ml
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787908258; x=1819444258;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k0exNkwZnQrFkD0fLA7OGD3heGe3FF0Bb1qxMN+a7sA=;
 b=BcHiY/W+1k98qxQtq7mBn9eFvfVkQLobrcBv0vup/GNMPdFO7UMITKGY
 D8LVz/fjAwsgyMuQdI86jSRib7pH1iEo7KiFN5t5GzVbeC+s27pJg9TKy
 Vj7w5wElXesfaSsGrkpCO+bRwizoUDUHiKDCudXfXrrWOivP2lS3BF8sJ
 UsMSes6EgFavdMiUoQ5X9ikixiCMJT8E2Jx8s4ruEN0ruhVFEqayRuIZm
 TOgui0T191ct5db14fjoW7w3xALmBQZ4ABHaJUfVEvQ00TdAMCLDs+G3C
 dJ3myZuZexPUoleeQPFxb0vvC3SOi+cZTKjp4O31fABIA0UUqvkZ3b90Z Q==;
X-CSE-ConnectionGUID: RfEsLo8vSrKQ49BR3sxzIQ==
X-CSE-MsgGUID: n90R20EZQmep8T8xnqRaOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88620835"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88620835"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 02:10:55 -0700
X-CSE-ConnectionGUID: GEuGdqYaSgSw6pGga8dLyg==
X-CSE-MsgGUID: e/5Gd+S5QM6k8jznI3+g5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="297994992"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa002.jf.intel.com with ESMTP; 28 Aug 2026 02:10:55 -0700
Date: Fri, 28 Aug 2026 17:10:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 14/20] target/i386/tcg: decode EVEX prefix
Message-ID: <apFQnRsdw4mOiJ13@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> +    case 0x62: /* EVEX */
> +        if (CODE32(s) && !VM86(s)) {
> +            int evex2 = x86_ldub_code(env, s);
> +
> +            if (!CODE64(s) && (evex2 & 0xc0) != 0xc0) {
> +                s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
> +                break;
> +            }
> +            if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ
> +                             | PREFIX_LOCK | PREFIX_DATA)) {
> +                goto illegal_op;
> +            }

Just a nit, per APX spec (section 3.1.2.3):

The prefix rules for the extended EVEX prefix are the same as for the
current EVEX prefix. The extended EVEX prefix must be the last prefix
preceding the main opcode byte. The only prefixes which may precede the
extended EVEX prefix are ASIZE override (0x67) and segment overrides.
The presence of any other prefix triggers #UD.

So we can also reject REX prefix like VEX did:

#ifdef TARGET_X86_64
            if (rex != -1) {
                goto illegal_op;
            }
#endif

Thanks,
Zhao


