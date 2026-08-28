Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9ACC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzs0j-0008Cl-MO; Fri, 28 Aug 2026 04:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzs0h-0008CP-T4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:32:27 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzs0f-0006dp-Fh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787905945; x=1819441945;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Igy7TtCD4u72/0P+SptapTBoU9Z9T5doWAh+VBr8PJI=;
 b=VhP6GmnkWmUqVeogIwBM6zrS+uvoGTish5JGf6PKRn0xmAOnRxvt7aqT
 FtNiYQ4+08sIvxe9ZAcbTO9KwWu1Q4QMwod939+uy3BxWg8e6b2gE8JSR
 iqDDrronTphLDH/j4eBMYRrjTevVn1r2UHa/KbMV866cmDWsSJ9QPadWb
 9D71LriTmE0xWJqZxjQJj0OEah1k4SZlZceGLtgUMnB+JJCpEF1Q+DOq0
 cray28W50cy1uxqPU9xahVnyAgVvN2pa/ZKRmZG6eMzKgaaQWEEBNk8So
 mM+ENbBWxEzP+3JciqSq75QDO7si3elaav8scO2oIEHK9BdAAmk5qI6CT g==;
X-CSE-ConnectionGUID: tAjSYLJIRt6CTknaWZNXFw==
X-CSE-MsgGUID: 2Yj/CctvSrWNLypGUAnULQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88336408"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88336408"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 01:32:21 -0700
X-CSE-ConnectionGUID: ULGS8MNjS9KHP1SXoWqnoA==
X-CSE-MsgGUID: NK00OHjNQMevGXSLPXh3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="264848470"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa007.fm.intel.com with ESMTP; 28 Aug 2026 01:32:20 -0700
Date: Fri, 28 Aug 2026 16:32:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 12/20] target/i386/tcg: move VEX validation early
Message-ID: <apFHk7MeukU2jICP@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-13-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

> @@ -2717,9 +2733,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
>              if (s->vex_l) {
>                  goto illegal;
>              }
> -            assert(decode->e.s2 == X86_SIZE_x);
> -            if (decode->op[2].has_ea) {
> -                decode->op[2].ot = s->prefix & PREFIX_REPZ ? MO_32 : MO_64;
> +            assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
> +            if ((s->modrm >> 6) != 3) {
> +                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;

Missing the decode->op[2].ot adjustment?

I think here we still need:

decode->op[2].ot = s->prefix & PREFIX_REPNZ ? MO_64 : MO_32;

otherwise ot is still MO_128 (MO_256 is filtered by the s->vex_l check),
which is set by X86_SIZE_x in decode_insn() before validate_vex(), and
we don't have the opportunity to adjust the size later.

Thanks,
Zhao

