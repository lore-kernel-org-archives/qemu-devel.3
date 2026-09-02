Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0DFC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1fNY-00030X-GE; Wed, 02 Sep 2026 03:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1fNW-0002yf-1y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:27:26 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1fNU-0004Y9-33
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788334044; x=1819870044;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dfQ3rgpYpKGeZk88VBW1/S/GXq9i4zbr26/RFrzOUTA=;
 b=JrH/ywSAOgmo8kYjYqVtZsWgXdUnoQjML6mrjWRfri/cFykl5zn/mKMu
 yedhU1nEBn25b+Ph/A8xtaJOpdg/lYdgO7wEzR9wGhGMNPTXbSdjGCAPU
 16lZwyvGQ0u7i8lu2zQQ1yD+JXnnVa/G/yPHmVJPpi8kK9MAar8uUCza6
 vZnG8NT7NBt+Lyafu9vfbPtxcCgzJ2VaXGtKBLNHMWS3EIkf8UuoxqhW2
 OdE7GjpsuVGUcRxoLBAUItsJGc4BfjWAJi8WTgtHP0ufIFgeZmELXxgxH
 cUQd/ZBxAMJbJ1SGkBAtk3T1xN0dUvlsGtEdu+FpexnwMCky2l2+9Igrw A==;
X-CSE-ConnectionGUID: sQCtXx4zTeyUEIcTWO7ekg==
X-CSE-MsgGUID: MTmi+TiHTx6N0Smafj424g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="91294467"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="91294467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 00:27:21 -0700
X-CSE-ConnectionGUID: tH0nIOAaQXS/8OTWBcfHTg==
X-CSE-MsgGUID: lAIUhK3bQfyopNGCtVmgBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="307549652"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa001.jf.intel.com with ESMTP; 02 Sep 2026 00:27:20 -0700
Date: Wed, 2 Sep 2026 15:27:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 18/20] target/i386/tcg: decode APX instructions
Message-ID: <apfP1yeRYgJeGzIC@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-19-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-19-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

> +#ifdef TARGET_X86_64
> +static void gen_PUSH2(DisasContext *s, X86DecodedInsn *decode)
> +{
> +    TCGLabel *aligned = gen_new_label();
> +
> +    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
> +    gen_helper_raise_gpf(tcg_env);
> +    gen_set_label(aligned);
> +    gen_push_v(s, s->T0);
> +    gen_push_v(s, s->T1);
> +}
> +#endif

Or maybe we can refer gen_pusha() to update RSX in one goes. But I'm
still not sure, because there are still two memory writes.

What if the 1st memory write succeeds, but 2nd fails due to #PF? I'm
just not sure if this case actually exists - I don't think that's very
likely since POP2 requires 16B-aligned.

Though APX spec said "For PUSH2, the two register values being pushed
are either both written to memory or neither one is written", however,
it seems difficult to fully comply with this rule.

Thanks,
Zhao


