Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD46FC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8gv-0004Gz-10; Mon, 28 Sep 2026 06:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB8gU-0004BG-DO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:34:13 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB8gS-0003u0-Dl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790591648; x=1822127648;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=R4wqFfpd54dEkrthMBlaKEQmqyx9HQ4Ka95jdTtQBns=;
 b=jLL36GRsQqihSNrmrKGl7zMHn9DoeWpT5zte1OxCotdSqJ2R4G5L7031
 nz6u8OPZ3B4m9Jsz1kbs6Dzm0SpmCj0fzwEU9zoGMvtXv0uXdiIEEFmTt
 PVxV0QeKWy9oyxRqJ8NoHOnU6EBBRROqSykCSizH39Zg0XNSiuH5l81N2
 8JvMT/xiSO3oqBIBqolA3CiyMHLoC3pHhszh8r8+ymadkyUTQ1e94RmV8
 ayI7u4snMLHuMNMIXVu6QCF1L0AWr9nyAl54J6hNaGYTze4Tf+wJOH306
 V8Ce0r3vAknmyDkqoer8BODvbPih9UyvB04DWa3b7d1humo8jsRvhtkFG w==;
X-CSE-ConnectionGUID: dRWnlnRXTFy8VU7LAqoHfg==
X-CSE-MsgGUID: LXaPl3nwS3S4MKYvDP/eLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="116816086"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="116816086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:34:06 -0700
X-CSE-ConnectionGUID: RCmrsxoORHqZN+cUDaxYjQ==
X-CSE-MsgGUID: pgP1eVwFQlO0osmN705FoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="278379420"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa004.jf.intel.com with ESMTP; 28 Sep 2026 03:34:04 -0700
Date: Mon, 28 Sep 2026 18:34:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 chang.seok.bae@intel.com, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
Message-ID: <arpCm2czQxjKaPwi@intel.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-14-pbonzini@redhat.com>
 <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, Sep 24, 2026 at 08:17:17AM -0700, Richard Henderson wrote:
> Date: Thu, 24 Sep 2026 08:17:17 -0700
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: Re: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
> 
> On 9/23/26 10:30, Paolo Bonzini wrote:
> > +    case X86_EVEX_APX:
> > +    case X86_EVEX_APX_cmp:
> > +    case X86_EVEX_APX_pp2:
> > +    case X86_EVEX_APX_zu:
> > +        /* Only reached through EVEX map 4.  */
> > +        assert(!(s->prefix & PREFIX_VEX));
> > +        if (s->vex_l) {
> > +            goto illegal;
> > +        }
> > +        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)) {
> > +            return false;
> > +        }
> 
> They're only reached by map4, so surely
>
>     assert(s->prefix & PREFIX_EVEX);
> 
> is more appropriate, and the subsequent test for evex moot.

I think the code comment is misleading (and assert seems right).

Not only evex map4, but also some legacy decoding reaches here, and
those legacy decoding share the decode helpers with evex map4, e.g.
decode_group1/decode_group3/decode_group4_5. And REX2 could also reach
here since it reuses legacy decoding table in decode_REX2_map0.

Maybe we can refine the commnet like:

/* EVEX map4/REX2/legacy all may reach here. Only VEX won't */

or we can drop that comment directly? :-)

Regards,
Zhao


