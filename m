Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A640CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYXM-0002M8-5Q; Fri, 22 May 2026 18:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYXK-0002IR-Ea
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYXI-0003JN-R0
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so5568519b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779489607; x=1780094407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5wRLdIWXEJGvDFG1i0A2b78nhmqAXr8XFGLd6/UKsFs=;
 b=GVVJH2PsRjWr3GJBtxwGzERJNPRKodgYvWBSOW5OS39Hjks/0mczOSRIR7TLtIfUss
 C+Iy0Y/h6u9Wb1VOEOUmjpXz4en6QFgxBvqEs9/i3RNsZK2gUVtuNoLjRSzc4A4o0MN2
 dm0r0klMB1bYgZselwJepmmxbhkOfTP3xCn8mztF9BNdV6XxEn3/F/JhQikQNFKH7jhw
 ffkdcQDdt6eHw17vIV1KmXva5ujJVow7A+EMqmfIkWEHHj5DfqBioQn75vJ15suybiuc
 2LgLsCnqQbb6D+FjaNbqnNUDG/ZjiHA6EQmAKxlEYoumos38riIrNGUngnyg0k5Jomh2
 I4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489607; x=1780094407;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wRLdIWXEJGvDFG1i0A2b78nhmqAXr8XFGLd6/UKsFs=;
 b=kGRtn19B72fTdb6VuEj3kNy29OoP+cYRw2sFU+h0nH6xZP11jBYOq8ljfD66VOf4GN
 biOQjURKnEqfjxgM8KtqQ1qjUR0l63C63l4KgNVDjzSaNkT2zBHbnx+tAJHMDDV6Pv2B
 CbX49bWEBNDwToQXWPsBO4U2tBIr7jbzFaCmzSVs+TDP0r7f5UlTYvpQh8tZaH/TeeYg
 B1mJptWdFjH/601VGaViMzmP22Sb4l23SpykoF6P2t+iJd0lgvFwv4zfNdpDH3tnVbhX
 +wmbZNC40ZuJKux45tsypHYpZbn9z6L67yPcE1PUG9RDLxbvcL3JlrUVblvVva1J0eD8
 eIRQ==
X-Gm-Message-State: AOJu0Yw0UcGH0Enb0yRseOl4Hff8yzVFtuadS2EVFEOVYRgelz62uU0Y
 i/50M71Bso5kLKm3iQ7WwiqO8wACfrfvUKmxqw43+9irqs96rFv4e/X8nCTOamUSyOntn4VG31M
 IHBPk
X-Gm-Gg: Acq92OHWj9eT8mKrmmeZgg0unOUbYSEbvSLsGNR+5Q7ISJ1utrB/iB9GXRxEHY+F/JX
 zSj4EfGjSE9+ja496UupAyPjoUw3CnqlGvuCT3m6A9q6C1Ll12aWquenGuXDGrjK8sr09zULtSE
 Xm9cw+rNUr8w7J2HRaOZacMiw2/TItHfRMjh48KUyPl5SpJd4BDM0xYx6h3ly+LkZt4MflHm7i9
 iF9/PMWpmyWjgNBKi+OLUYAuqt6IdVMI7wI7J+RekMXUvZTBy3inILGp3q4iRQzHVzAQv2DfICM
 6ay3v2TRctm+Iikhelp4qW5UFHMbC0PRzC3kYltK8XI5p6RCD3T6agEG/vf3BP8O9Sk/eaJhFiC
 svJtQU0dHMGpcHLLjvtR6TsbX2JWMIaztq8Mw07A+ZF+GXD0IkeJjASbiRZBkG/WrZHhkfougM0
 wfwCbxs0q2SAuI/h6J9E34JiQbwNM6EHlgQL8mSjm7
X-Received: by 2002:aa7:9a85:0:b0:82d:603f:f3a with SMTP id
 d2e1a72fcca58-8415f5dcd16mr5012523b3a.24.1779489607216; 
 Fri, 22 May 2026 15:40:07 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fe97c0sm2650892b3a.53.2026.05.22.15.40.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:40:06 -0700 (PDT)
Message-ID: <4f6b3740-d5ad-4fd6-a7d4-7e804642b189@linaro.org>
Date: Fri, 22 May 2026 15:40:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/riscv: Register generic riscv[32|64] QOM
 interfaces
To: qemu-devel@nongnu.org
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-1-d1123ea63d9c@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-1-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/20/26 06:12, Anton Johansson via qemu development wrote:
> Defines generic 32- and 64-bit riscv machine interfaces for machines to
> implement.
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/hw/riscv/machines-qom.h | 20 ++++++++++++++++++++
>   target-info-qom.c               |  9 +++++++++
>   2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

