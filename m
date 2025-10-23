Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63397CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtiK-0000h2-CQ; Thu, 23 Oct 2025 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBtiI-0000gj-7X
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:42:38 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBtiG-0001WR-1m
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:42:37 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3c8fb195c23so504923fac.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761219754; x=1761824554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hzYvB1A0osd0xUYB/vF1LOzfOo+y3oks8gFbyc5/KHU=;
 b=IGL6VRaLcqfbKUJ6NMbOHOkRdcMzAz1nACcyCW+rEo36DW1Fj5j7Va8kgGJhD7emDK
 k/gWk7a0261o2J2anYFO7cb8ffSaFZxlsjHOxi34dCg2GR+Vhsvf99M8qdsnUFk1jmOw
 dRsCwRyBMpjfQKslaPlThc4cwALiFiSybbMI3RSO7qAhB5Zgb0DJqnnP/DCjq1gNJtWT
 n+1zLwPn80hNCDshHmsukaPjiwblynJUVm+/2c4hmOnTNuEUyWwdCGVVSnphgOJ5Lj7q
 NoAC9CQqBswfWrv9NGs1tB69YBGV/qjHPRItt8XuQErF3gdSvvl8Pgog3RA+1+S8JF9B
 NsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761219754; x=1761824554;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzYvB1A0osd0xUYB/vF1LOzfOo+y3oks8gFbyc5/KHU=;
 b=obFmH1jIQCwB7xQBttsUbCEmSb1HhKnT9beL6Bd7ps3eavP8dTRauNBhTNC5TmiL9M
 2rDnscRISbzy501r3xS9KpCkJtfV0TJ6VG6tHJXJY+c885LuI613ehfP2aM9GdEOSqCG
 tAJN50y0vaN71z5bhkbD4xbHd4JTF+BO18z4HqCP5yXjacsY7avpPkyktmPfn7A9229k
 el1gZkwjwHqk8A4Ng5f8NaGOxLBFkoJ4l9getkdnub8zQ+S6bIC9rwZ4FkBVGH2Kq6yy
 L6O+B8tHTFL1jw/Sgf1BJQPUZ/WsRpg9UO8bNADjbXlzZuW67yzw5QEPGh7xU6IBpE9W
 972Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV47s2nSVZNzgrwU/BcrmrSru7hfBHy5kOF6H5d56CD5yTn57zpOva4QW1nSd2UGeJIwY1e1tTbIFju@nongnu.org
X-Gm-Message-State: AOJu0YwLrC/LriC5tXXxgxBOkv7Y9xc23eYQXgTdmCckreBcVR6crBAd
 kCxKl378SbetmCgzZmLK0QhozqF1ZatdpbT9a+6QjRc0SOICKz4ZOElX1/uORkaC4Ss=
X-Gm-Gg: ASbGnctReDl20SoGAmLPCuuT0OnHdqkkhVzVR/4AGzLrN/xeZb1GW1uNu3jk2Lb6wcO
 MI6UAJYsB6dh5SrCc6DdkE4dQFvCn8SF8ucEqO/bSwvhxC5qgT36lBe2NHA6/iC7mIV7EzercD9
 58g1O5ob9OD/36/uZvHLnzElEc/aMd4dIyElaIjopzWeZUze4ONKsfQORw/XxMHp3qtw3lfHcVX
 miHgn4Lw1WvyhsIQ8QKOJ4BSV2pGv9b7Aq7Ntmz/qAjg5bEDdblxRqxyZXGpAKoi83y6zNVNdHp
 PFTNpuwgNFHEjSfGzHS+4dAdO0CXgRrd+RS+nc7+3/9t1WWC646Z55DSiWlMNpcvlnRZP6EIEOp
 Y2SW/Yx6ZYU/jXFpniPsx0LFukoqHyqxdwytuaHLOJKNBZhBOEizu/f1Ui1pJqTU0/YYnFseO0c
 Vo7vgaFcaqt1xNHCOoRA2Dq8XFoNh3B3p+P8kBxGDPmKkw6IClxN+qof2j/y3ly+aigqlvYP4=
X-Google-Smtp-Source: AGHT+IEDVnPYvwWPoDYHf8yPZW0aeMG+PohSX8wFSQQoFIs9VwnWldzngcIlbbca9J04hf6aYQMFmw==
X-Received: by 2002:a05:6871:1c8:b0:3c9:415b:a28a with SMTP id
 586e51a60fabf-3c98cf733cbmr9737756fac.11.1761219753734; 
 Thu, 23 Oct 2025 04:42:33 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec0:c638:dc7f:7860:6bb4:85f1?
 ([2607:fb90:5ec0:c638:dc7f:7860:6bb4:85f1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3cdc4c081f6sm639567fac.10.2025.10.23.04.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 04:42:33 -0700 (PDT)
Message-ID: <94bccb3b-9d41-4ff1-acc8-fecfd70cfc34@linaro.org>
Date: Thu, 23 Oct 2025 06:42:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Add assert to arm_to_core_mmu_idx()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251023101339.1983809-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023101339.1983809-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/23/25 05:13, Peter Maydell wrote:
> Before commit f76cee647c ("target/arm: Introduce mmu indexes for
> GCS") it was impossible for arm_to_core_mmu_idx() to return an
> invalid core MMU index, because NB_MMU_MODES was 16 and
> ARM_MMU_IDX_COREIDX_MASK was 0xf.
> 
> That commit raises ARM_MMU_IDX_COREIDX_MASK to 0x1f and NB_MMU_MODES
> to 22, so it's now possible for a bogus Arm mmu index to result in an
> out of range core mmu index (which can then get used as an array
> index in the CPUTLB struct arrays). Coverity complains that this
> might result in an out-of-bounds access.
> 
> The out-of-bounds access can't happen because we construct all the
> ARMMMUIdx values we will use for TLBs to have valid core MMU indexes
> in the COREIDX field.  But we can add an assert() so that if we ever
> do end up operating on a corrupted or wrong ARMMMUIdx value we get an
> assert rather than silently indexing off the end of an array. This
> should also make Coverity happier.
> 
> Coverity: CID 1641404
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f539bbe58e1..026548ec34f 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -968,7 +968,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
>   
>   static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
>   {
> -    return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
> +    int coreidx = mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
> +    assert(coreidx < NB_MMU_MODES);
> +    return coreidx;
>   }
>   
>   static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

