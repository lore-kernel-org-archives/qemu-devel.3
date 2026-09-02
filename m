Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B4CC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1et4-0007NY-AJ; Wed, 02 Sep 2026 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1et2-0007NP-4Q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:55:56 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1et0-0001FV-9P
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788332154; x=1819868154;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YGRmuShcmU1fTeR/i/EaHJtCC/yTVFVPz1iWVrbsKAs=;
 b=Z/aH9w6fxuhHTJjNUVE0cOP2DWh1YFyIDg7dTOtvosXLZ9Pcra7jmUoT
 tlJGcSvmSAl8KI61LUpLXGpcjisepG5jrN0TD+Kkp+pWMeo7cB27cb8Yy
 wrcIjl2CeSfTXHQJzbFfTIrw6q2I3dvrQEtDb4gYA7/NpYsOhqafUtGTg
 n0p/D6AGHGOExDkHWKCYwwHOjb84+FwEnSW6IGrWlCoLpfSKCWbhFFrJ+
 P1jPUzqgqKTuds52TpJ+m5E9Xe0p0QmTD3ipMvNo/gFeNxiWr5Mx6NQk1
 MTRIxULCdmGsDaq23Z34bclV9pfkl6heMFvzNtSuDiyMn+eZLnniIWfXV w==;
X-CSE-ConnectionGUID: iBl9pgpKQnmHn9OZ09/rxA==
X-CSE-MsgGUID: FtqOGi8bQ9aijwAA/4rGyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100133607"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="100133607"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 23:55:51 -0700
X-CSE-ConnectionGUID: QNiEBdGBSrSdHmNe7v/UCg==
X-CSE-MsgGUID: WfNQ+9QPQDKP65n/1la2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269341321"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa007.jf.intel.com with ESMTP; 01 Sep 2026 23:55:50 -0700
Date: Wed, 2 Sep 2026 14:55:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 16/20] target/i386/tcg: add decode functionality for APX
Message-ID: <apfIdaRa6GSzN5wt@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-17-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

> +static bool validate_evex_apx(DisasContext *s, X86DecodedInsn *decode)
> +{
> +    X86OpEntry *e = &decode->e;
> +    uint8_t evex4_mask = 0;
> +
> +    assert(s->has_modrm);
> +    switch (e->vex_class) {
> +    case 13:
> +        /*
> +         * APX-EVEX-BMI and APX-EVEX-CMPCCXADD do not define EVEX.ND.
> +         * They only differ for checks on NF, which happen elsewhere.
> +         */
> +        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
> +            goto illegal;
> +        }
> +        evex4_mask = 0x0C;
> +        break;
> +
> +    case X86_EVEX_APX:
> +        /* APX-EVEX-INT.  Checks on NF happen elsewhere.  */
> +        assert(e->s0 == e->s1);

This assertion seems too strong, should we only check it for X86_TYPE_B?

Thanks,
Zhao

> +        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
> +            goto illegal;
> +        }
> +        if (!EVEX_APX_ND(s)) {
> +            s->vex_ndd = false;
> +        } else if (!s->vex_ndd) {
> +            goto illegal;
> +        }
> +        evex4_mask = 0x1C;
> +        break;

