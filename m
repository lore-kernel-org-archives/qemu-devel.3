Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22237C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXFz-0003Mi-JN; Thu, 13 Aug 2026 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuXFy-0003MF-3i
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:22:10 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuXFw-0003Ew-Lh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:22:09 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-738bcf9a573so270447137.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786634527; x=1787239327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ws5ZZw25AWp6Ml2Mw5eDhL53JPwysncj633tllAp9Js=;
 b=cZxiF2HXloQ/Sf4zhyqg3iPabFWZWRNCVC6aLOsHz9kmXEw701KN3Sp69Sd48bpeFJ
 UVfZQS8+g2CX+pDJSXZcX3K/jtHXAwSnBQCwc/5fGOLGxNLKeoH5XtzU9FVRTm46dEGN
 5JVxUesPIidZBLG41quOoMOC+Lo4vid+fNCm8GwXLkSSytGv6fxER99RnvSQbm9O1cGS
 IN4eCwTd+yYh3X2bVrhBV8u9nQV/ioA+xFR3OCAVFIjUBV7paCWN9kirGXqlW15XhGY4
 k9unfB9xSEu53KA8psd5FNx0VabPiWbXOpKwsV0fT2mHNdJp+25+CKIOAWLVcaQmPTIk
 mh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786634527; x=1787239327;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ws5ZZw25AWp6Ml2Mw5eDhL53JPwysncj633tllAp9Js=;
 b=El9LevAHi+5GkJ9PdvKH0t0AHANE94zY6NgHgfuvj5mjqaa1EVHMJ6Sm25zbqO7uVt
 BWH9jHlEqzg+28s8nZBeeJNvG4oozdLeTXUa7PZhXPGZRDl3pmENdxPLCDkEDvOaGwar
 BDlw6K/Hr88IzEq9xvBIZUNpKG9Pj65z+js0mD5bqjkg9nTOybllvfxjk3bR3WnO59OW
 Ix6IUZyyG/fauEmRTUVW60acXJxYOBhoADtzJZYzaDmwK1cejRiAQezPW0w5hTa09Tav
 vt+vU8UW34Ov8FEBnSFuDsGyhfvltZW7fj4TyfM/iqr2IBCmR1hCGcoK1MuLR51vdJJR
 RFFw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3ZPNvpAv2rBMLyiw74om6sxp+yUgOgZrKnNGckHzai/zAtqC5J1lAOOmPnTGvnPTXavqnLQGI/dtn@nongnu.org
X-Gm-Message-State: AOJu0YwbTfKqCtw8Jv+c5Onp/uuWAa++x9UmgdD0M/ie7PxQvooolBiv
 urSrlgILbnFGvzSOhB0iIOmss0vv/QzdIJbXO4bSv0dAKqoFeF7EFl3LMnNXP/vjYGw=
X-Gm-Gg: AR+sD12M+gY4kdknsDDXKJnRdsUIlNNkZnAeEoev0tdJHE4pb3ygj+KQbRCsqo8GBUR
 kgHDfnbYzlJnZGVdnWN8SzRcIrsXj6Z+DODo+nii6T2cjDtgozQ09B7kxRnR2HeI3Zwhdq6EC5d
 vF1ZQxKFB07sMFP39FTc5s9H7ybrjs7KXrvwhmEY8hUAAUmT94xekWO5GQqi01pWLVmlhnXYptW
 J0l5t3wQKDRmzp5Xd3q6CkKreJrzRE+Opk2FTAdIjYWaDZHGkU0o8Co8VURbCms/xzrgBsFdbZY
 k2yd9fjHweBdVk44Zy8FnFZUcZXmL7/jeOrZ347Gd5+CaIGuWAVav14tBRymXECMzBBp4iBPV1w
 W8P+49K/rTz6WZ2HpzoITGKE7OHNd3F4iQt0WMY97lKgHBbZIV6BkesVg9AygWgm3eZL+6f4aAT
 FGSOS1LFC+CdP1enPfFnDiNGs34Jjs9J8pUyCS+gOsdTIPSC9xhHoXdgp+DNjQqwUrUkPlkgs00
 NlM3g9PnC3YRcbvjHAmUCXKf1kiH5gd6f9wg+IW
X-Received: by 2002:a05:6102:2913:b0:747:4dcf:189e with SMTP id
 ada2fe7eead31-76db5c7fa7bmr1452158137.5.1786634526841; 
 Thu, 13 Aug 2026 08:22:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-76ef89a1567sm52542137.4.2026.08.13.08.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 08:22:06 -0700 (PDT)
Message-ID: <522d4daf-2711-4640-9d1c-4d7b96dc0e99@linaro.org>
Date: Thu, 13 Aug 2026 08:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] Next patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260813134431.2678787-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260813134431.2678787-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe35.google.com
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

On 8/13/26 06:44, Peter Xu wrote:
> The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:
> 
>    Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> 
> for you to fetch changes up to 89f15c1362970150bf5711cdb84b9742c0db0cd8:
> 
>    migration: Fix rare hang of migration_channel_read_peek() (2026-08-13 09:41:40 -0400)
> 
> ----------------------------------------------------------------
> migration/mem pull for 11.2
> 
> v2: fixes macos build error
> 
> - Dongli's patch to add cpr-transfer support for HMP
> - Fabiano's doc update for migration on security issues
> - Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
> - Sam's migration test build fix for !ASN1
> - Peter's a few migration hardening fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

