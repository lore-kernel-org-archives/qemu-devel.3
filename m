Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6EBC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCFl-0001cM-P8; Wed, 29 May 2024 01:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sCCFj-0001bn-VW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:53:36 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sCCFi-0001Ox-4E
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962014; x=1748498014;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=LY/ObYTUvXzeB7cV/aKSw+GkKWORF0JdKHFTljKvWC8=;
 b=YBx2MoFEMBZgnTDCXUO2Ur1lrcvZf8WZMkRkgGTzhiAVnwz7PTmC8Ua+
 cR88jbIKXGVBUv+lfk/iRDe83wITpvpFF9Gbsu4CDhKuL3alrvUkZb7BN
 61D1qLxvn3XazlPyXwiGZ6QWMHY+VFyP/jTOqVIL+7q4mmT/qCEmITWtI
 hZOvMWZiiKFVWtywYAgps3CQtzV6S2iOVWnFXpryBM3vzjdKKT8+a15dQ
 K3eoxdZ0t/vtuFDj4Xh/EyDgiCXC7zp6Lgh4fZZj+MQXWgnmd7j5QSdVd
 t8XDoPfyaHevKLsUyZBI9cfBVjJfdegVAyvFLfQ2SBLu0O1FpFON32rLz Q==;
X-CSE-ConnectionGUID: qOpFVVtjTD++h+iaSoc4aA==
X-CSE-MsgGUID: FDsqBvWiQpq9SzFVffazeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13116779"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13116779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 22:53:32 -0700
X-CSE-ConnectionGUID: N1LOOWoHSMeTgDUgSRhEYg==
X-CSE-MsgGUID: 89yjPDPzQrGOwORe9d+oCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40303084"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.124.244.145])
 ([10.124.244.145])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 22:53:31 -0700
Message-ID: <57900ae8-b4b3-4455-b8e5-d7d7e269916e@intel.com>
Date: Wed, 29 May 2024 13:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/bitops.h: Locate changed bits
To: Tong Ho <tong.ho@amd.com>, qemu-devel@nongnu.org
References: <20240529045909.1796787-1-tong.ho@amd.com>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <20240529045909.1796787-1-tong.ho@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/2024 12:59, Tong Ho wrote:> Add inlined functions to obtain a mask of
changed bits.  3 flavors
> are added: toggled, changed to 1, changed to 0.
> 
> These newly added utilities aid common device behaviors where
> actions are taken only when a register's bit(s) are changed.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  include/qemu/bitops.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 2c0a2fe751..7a701474ea 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -148,6 +148,39 @@ static inline int test_bit(long nr, const unsigned long *addr)
>      return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
>  
> +/**
> + * find_bits_changed - Returns a mask of bits changed.
> + * @ref_bits: the reference bits against which the test is made.
> + * @chk_bits: the bits to be checked.
> + */
> +static inline unsigned long find_bits_changed(unsigned long ref_bits,
> +                                              unsigned long chk_bits)
> +{
> +    return ref_bits ^ chk_bits;
> +}
> +
> +/**
> + * find_bits_to_1 - Returns a mask of bits changed from 0 to 1.
> + * @ref_bits: the reference bits against which the test is made.
> + * @chk_bits: the bits to be checked.
> + */
> +static inline unsigned long find_bits_to_1(unsigned long ref_bits,
> +                                           unsigned long chk_bits)
> +{
> +    return find_bits_changed(ref_bits, chk_bits) & chk_bits;
> +}
> +
> +/**
> + * find_bits_to_0 - Returns a mask of bits changed from 1 to 0.
> + * @ref_bits: the reference bits against which the test is made.
> + * @chk_bits: the bits to be checked.
> + */
> +static inline unsigned long find_bits_to_0(unsigned long ref_bits,
> +                                           unsigned long chk_bits)
> +{
> +    return find_bits_to_1(chk_bits, ref_bits);
> +}
> +
>  /**
>   * find_last_bit - find the last set bit in a memory region
>   * @addr: The address to start the search at

Reviewed-by: Lei Wang <lei4.wang@intel.com>

