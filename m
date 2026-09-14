Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C28C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x618t-0000L6-R6; Mon, 14 Sep 2026 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x618s-0000KA-5l
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:30:18 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x618o-0006Qd-SU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:30:17 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc4bdf8acd6so1150923a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789371011; x=1789975811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S7+AL5afegpb0To3hlGT44wY+oi7DzN3AXe14w/8OVo=;
 b=SH5lbHwpU+xvOzMLCxSbmaLXqTdCCCSdGiIUF5YGqmZJ9Q65eL87SRQ47D3LYqugAD
 OIsWR8az3hN8cPpYogVJeinwzQZCFXWwY+WRObq2+duo1zdwTMQ9XDZNiZRKsD9mG6qi
 /XEZcrMQZZRITahnS10TTXT5fcO/qr7xoDGUuzaM2pdgxDpXLUcqVLxzCuXpWWN/y2Na
 kHXU9KEtsVb51g16xKd65ZqnTHGednse0k9ckqYCE1kAMp2QxD78V9RETVGNhSQVIgTA
 oGC2gYd5zkIOkX2g7Tux0rdkY6o0sxHLYK0VhgiuNGzHR8YlgVDfD8dPjUhXRtvrpNMI
 G34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371011; x=1789975811;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S7+AL5afegpb0To3hlGT44wY+oi7DzN3AXe14w/8OVo=;
 b=QVTyoDpYB7rahUjYITOBn/bxmeY4x3FxkZFdtgDDGsnxa4x8q925BIIL8jKQQ9a4yi
 oiVkzI3mjurCktWRrtTa3j2D7MH0Cjx8+ekdXKsPldfdbUW65A7xetclJJseP7CDxQV/
 XuV/kjbKwManmJjdRTpSQvGWjG0DJC1v5Un4+8wB71ETFZISfigd9GbzeZ/V1feTpWAa
 eA/SGtOoW2icnL4E2qioQZcj1Cs1iX/jaCDwfFSj4x/5E/oNO+uxZIZgy8+1G4x1yyUf
 5ulzpkjH7a7G4M0QQjp02yoOxSjxOYJnuN2xXUxtsogJzdXAmleuTO8ZZwawRjDbGkK3
 k46g==
X-Gm-Message-State: AFuF++nRgW23vp00shWzSQMtim5PrUqk8DxBof/C1iMkGFarHpLEKbXV
 4+GVRj+1NXsPA9qWNgXtJJO39EDPZZS004AJ7BxK5c7NjjLSFzj2fg5FJucoWIYZzpY=
X-Gm-Gg: AYBFou1HAc4ZURPI9IjQhAUXiKCykAuicZqk5I+iqbeUJ+4dP5ndXnmpc6X0tYgUHza
 uAD2p7FxyWgNYN2MtUeARULPxrn/uB6b7TxhpaoWNbC3MuzlsEYV6CLbcfIubyVD65dulf8GrBT
 pDtC2lFTyfy1TM0iigKCTkb/3WBVm+6s7yGMPaBAe+XcjcQlw8jE1l8CoaEogOnkEAl0S624OJj
 Hki1d1GTJfXt0HmBkWLbcYEcVXWrOhR6Dr4EnTEW/UdUqdaYA2MAH5AzK6YeqrmEhMOsNiafrml
 z9Lg/9tBAS1eaFXSt75yWV6ewx83826KsjTkquxuhVzmCilp2d2DOEVfg4pRScA2WwwpUI4Ced2
 dZU3Gd5RyFir1HXf/P5pl6+EW/prGsLxwI03zpTCEH37YTn622sxBnIanAxe9ivzEnFJJf3cTg5
 2Bi7V9/rek3uOokWt+o95Um9WcQQuglwsdgKKrMTTU2R4wkltWIavhs7oxvE1HndogyZuEmmbj+
 CDSh477IpIHAeCM3Bzaghf+RyoYgxDwzVTwbXjRvW+u2SHR8fzD3xYBj0shJg==
X-Received: by 2002:a05:6a20:c901:b0:3cf:a7a5:e310 with SMTP id
 adf61e73a8af0-3db404aebb2mr2897193637.9.1789371011433; 
 Mon, 14 Sep 2026 00:30:11 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bd8ad03ccsm4847348eec.2.2026.09.14.00.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:30:11 -0700 (PDT)
Message-ID: <39f55a2a-8cf8-47a6-b218-042f31f4b572@linaro.org>
Date: Sun, 13 Sep 2026 21:30:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] accel/tcg: Replace size with first/last in
 probe_access_internal
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-11-richard.henderson@linaro.org>
 <CAFEAcA-MVRya=Y8i+rURHqizQzJLh=Gp5tQxHSK_VNBUQCAzdg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-MVRya=Y8i+rURHqizQzJLh=Gp5tQxHSK_VNBUQCAzdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/1/26 05:28, Peter Maydell wrote:
>> @@ -1440,6 +1440,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>>                             MMUAccessType access_type, int mmu_idx,
>>                             void **phost, CPUTLBEntryFull **pfull)
>>   {
>> +    vaddr last = size ? addr + size - 1 : addr;
> 
> This can never overflow for the convenient reason that all four callers to
> probe_access_full_mmu() pass a size of zero :-)
> 
> Do we update probe_access_full_mmu() to the first/last convention later
> in this series ? I couldn't see anywhere we do that, but maybe I missed it.
No, I didn't do that one -- perhaps a mistake.
This function is supposed to be only for page table walks.

r~

