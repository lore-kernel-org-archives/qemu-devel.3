Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2374FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbRu-0004cR-2j; Tue, 28 Apr 2026 01:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbRp-0004bN-70
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:57:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbRn-0003bP-6R
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:57:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so187064425e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355845; x=1777960645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58NWE18BxBgpTyWIA+sI/0wlxjjj334LHi5XYAo8o6I=;
 b=EMP59MM1OLfFkkRHb4harwvNaihRbJ/PYpP18d7Of0m10Ar+xA1V3GF7WhwzWzYV+j
 D/oWOyvvjhIvSKG8wI6tFVaM/BSpT0A7f7AkMj/WCpp7OU029kS+pzHHWRCBBApW6h7S
 XO6ar2M3UxX5jURQvU4km9jzAZ+jQMzwg3XFMyBWd179RlWz1dTe4ULalcYC4IdOjgDG
 r07sUN9g1BJXMGGKsK1sTHTshhCA8tJDZXKyPbcjvyLnD9Oh2CgW9ax2fUyM+a6Wb7hg
 Nt9McUf2c/3xPm/15wC3CkOnnrrbOhmN1xJpr9i72wpc1vZ0D2QZOfbfkckk3pHbt1fD
 A6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355845; x=1777960645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58NWE18BxBgpTyWIA+sI/0wlxjjj334LHi5XYAo8o6I=;
 b=k+OLOGYyhwQPFfHYEB83M/NTp5R1xyE2Id9tADMHIloS87jWSOXs9Zj5d/yXnZxabw
 iHQ2VD8iYdPM43GpIXopRIFuDxV41fmyDmxfDdXUUl4UZa6yn7t9XzqdNz5eDvX2krs5
 OjtFOT7IfyHAYbz0QJG0Ky2pnoCKbFpAR7JmrqnxmHMkHGz+DxXhZi6cDAkv+Kmxtvit
 6FRVbcF8dd2PM1ki6xi+IUzYDthiMNQOk7QEOOVMQPLESyAJEf7CAzzJty3tgWyVHB+z
 MAktrU0qkkKz/3mSCuFDQfOu3VLpE8m5SxCU6A52wQLZXMXefHYkUCzVTVWhGhAz2FhI
 mRIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Gqlrqx2QvhDgv7HpK46d6KNQbz3B4oah3GskDIfFaftA/0FNFGGHgAJQKwC6JzFeG6e6Zn67F1xeS@nongnu.org
X-Gm-Message-State: AOJu0YyuhQGerw15XlyVCG+X2kXGYbgcB4Cb51t8/Eegp3ZIzS+3bNbI
 vdQwl8kNgYXqUHP/Ffnq97zzdHLdV8MWnuWdlMPSdyM5kYmbRhZ7FkMyqDSPCXoh+K0=
X-Gm-Gg: AeBDievhFaCd+3UNkg5p/Hyp3+IDh1VrGqphPYsaRhd6ya6YFZCDYEnk5qDvRpNiVcr
 MRT+VwDRbGZVs/fFyVcCtiqY60cWEetl+5J/cgPt2BlJgqMTEJ3kmKd8P8xmVeIDLEdTMPwJWwq
 02eQrDiTrfFdauXwru2LXc05kxPxbHOb6e4T+GHTvFGGUGSPEBWrbhWnVrhe+oxhs+WQI3FhG14
 CYOJS4j0PKsr/gzVrU2RhaYDuuMP64AZ1lOdpjJW52r2YQGTHjs0V+TVKMPnCil9UW1+SuwWA/y
 EhDemZzTuwnX35aks/7ybBlisop72lE0VcBIql4zsYjUVhvbPElMBzZmng/cQ9Xnp/QqrUsWUUr
 vBRVqRwWwjkP/mYvAdZSMsdjZavdItHJNTQ0U3jYeRpNT32r8Pvw3bcZmB3C47HDuZkdDL/uRvJ
 IEJdqr1di85nV98M/wfOtwW7KUxZdKZgat0X4KEfsVIMDLzcjno/bWfYIv2e6AN3W0melujVOIy
 bfa
X-Received: by 2002:a05:600c:8b52:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48a77b1a4aemr26466575e9.25.1777355845165; 
 Mon, 27 Apr 2026 22:57:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f270sm3681230f8f.9.2026.04.27.22.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:57:24 -0700 (PDT)
Message-ID: <04a43cf5-b140-40e5-b397-250e2f6b7a2f@linaro.org>
Date: Tue, 28 Apr 2026 07:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/84] fpu: Drop parts_compare
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts{64,128}_compare at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

