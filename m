Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB6C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PuO-0001Ls-UK; Tue, 01 Sep 2026 10:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1PuN-0001Eq-1k
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:56:19 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1PuK-0001B8-Jf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788274577; x=1819810577;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kpf2GqHB9Dn8DrmcjfxL0mQ2wkKfJ6iYF86KX9k3bvc=;
 b=Cg3eDX+qUvlmkgPpgu4ljhm0cEDLGpCHu8Aa+B6etKUG9uTCBRIoiQVg
 gbRRpV5CNQ5GnQpwZJ2p4+hoqCBPU6K8+S9QSmhKKgNEZyFYOE/6D8cKC
 Bf7ymq+XqdqIjlR+WJWhTiCdBsZdbjy5P76Axo4FHcTjFHEkB4kkG3iw2
 MzRtclkcQn6TvuWhDZxyFewb8rtmseYYivewPydawwj3dwykdHkQ+KIyV
 c+96B0UoHjxpLZIDAD1qcLHAChjKP1FzpJdWtbiEyuV7waqbAmiXdps+M
 qr+tcYfI15bsRPIbifWNgFIhm/GTwkSU8I78JsCOkWrJ2modU5y/5VVtq A==;
X-CSE-ConnectionGUID: VSohj3nURqaNbrTQ+eVqSg==
X-CSE-MsgGUID: 47cPHoEVSraJPwOu7VT/OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88912731"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88912731"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 07:56:12 -0700
X-CSE-ConnectionGUID: 6L0rxf+1Q02ymKDxrHD9pA==
X-CSE-MsgGUID: sALNVKyCRxOlvJhxy8RnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265879775"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2026 07:56:11 -0700
Date: Tue, 1 Sep 2026 22:56:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 16/20] target/i386/tcg: add decode functionality for APX
Message-ID: <apbnifW+9SOZirfr@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-17-pbonzini@redhat.com>
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

> +    case X86_EVEX_APX_pp2:
> +        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK) ||
> +            !EVEX_APX_ND(s) ||
> +            (e->op0 != X86_TYPE_None && s->vex_v == ((decode->b & 7) | REX_B(s))) ||
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^

> +            ((decode->b & 7) | REX_B(s)) == 4 ||
                ^^^^^^^^^^^^^^^^^^^^^^^^^^

Typo? For B register, here I think it should check ModRM:

(s->modrm & 7) | REX_B(s)

> +            s->vex_v == 4) {
> +            goto illegal;
> +        }
> +        evex4_mask = 0x18;
> +        break;
> +

