Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C5DCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0P1-0007se-El; Mon, 18 May 2026 12:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0OU-0007eV-9h
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:00:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0OS-0004UZ-Dx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:00:38 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so1490959a91.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779120034; x=1779724834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VGCV16h08Xfg1x3t9NHDvM6Nl1AsEfBaID8dGW0YSjY=;
 b=NtaxLfurImV5B5SmRHylx99y++bp1SPhJYQDRN1AoYDiKEgosHLVYbW7YWxh4MfatB
 80gQYb3bHcjuQnCWF9HYQaLLBHSrkogEfnuRVbUp52e+8ylPqsI6gdJGsMIGvuTUM86s
 2ZckfnT1iAJghzWzqv4Zyel7m9XuuNs5drccgIGUWgWwE93d1dKLsh4XtdPvWyjKsaC/
 lPbmN0x6VHrkAi04w4ix6cpMm2GeegLVYAwWRAWRUEEfl15dlgVwlbtAPFX4THUlRgR1
 orseGaECxbR//ZNpajKrkKDtkYeaTfdFqqnO8DSmEUrK7kxXxzzrXd9g2GZRrJiEPE0b
 TvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120034; x=1779724834;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGCV16h08Xfg1x3t9NHDvM6Nl1AsEfBaID8dGW0YSjY=;
 b=K38Y7Njq31y8IHq5Oqvja7ki4vryv+sYoqnw0lsBgcH7kytc36vN6LBpZoequYzN0G
 +eMUgab+WyqKzF7RSBe6i6m4vr9xAr2QDdVjcdd8ACubEThIePQ0IjAl/m8sDEaOlRh7
 QCGW1LXKEaKim2cKKgkl5fhhxS8vHzPw26VRHjJgxbOA5beiywWiAmnrWla5H7h2ostD
 qMtbuli6RUo66xdFYqy9dKhOJ7Irm0dhBnxs+fm7jA+v8HYGhA+XilCkt532HKXX8hQE
 DyyR96NwpZkjwWxzxaeT0YqQlDbvPzilreyuV8LHxXKZp8n6G5v1ruLa4EaWsCIAJUnj
 8iZA==
X-Gm-Message-State: AOJu0YwPkZOheTd3sLLuNCWuI32+NHf2s654mdenaOfs1RifjhS4IGUA
 +Z1PMx4t9NNFb2uV4bCETbWysKAAA/qvjehK1t8+XuvVYoIpVQqUFPGI+o5PxdtbxxSt2Bqupaw
 EJsIxpEE=
X-Gm-Gg: Acq92OEtwqEGBbUI4vZ69qqVrnKZNBxQDDsXJiiobofmnwJqVsNzYYL1YlefgQ8MTGq
 u1Sg359g8eYA5/S2twquo0mW1WpOkibrCxkDsbbrKafwsGei1I8JtsR2f2YOYvOtoA5Tz60pST6
 Q8yglyLfgSNClatvv5KmU1IkpN8oitaf4NNd3El4RIwr4VJrT52kWW7gMeOuugkjMR+9Ivi7ZK6
 AsL+HO8TNpKzXF5aRWXqUrD2MQLzkylGGw/HO/Ls82BYxmU5CxfxC9mfZAgNLVtB6PTKN91kkMw
 wLH4ZYxNbD9d41j1ajCvsn++iYmcsLH/Gml4athHxlb/GeKMQf9WasOpvJEc84B3bzm1EU0kQ5G
 dSLYhQKEnMgEhpSBbl1AsJDmsHGKqYtNr4/GQQUYALIoFIzFW/rErX3bpw01fb+SdYECyDm0aCd
 w5gpsVk7adS3fQb7IFak5I4TiwhNrcH3duS4HmkKhQmUDYslueLkO4gUVTsQ==
X-Received: by 2002:a17:90a:1649:b0:369:946d:32fa with SMTP id
 98e67ed59e1d1-369946d3704mr5847476a91.5.1779120034022; 
 Mon, 18 May 2026 09:00:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951434eafsm11532844a91.10.2026.05.18.09.00.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:00:33 -0700 (PDT)
Message-ID: <ad637429-3b2c-47d1-a1ed-b4ea52b24ad4@linaro.org>
Date: Mon, 18 May 2026 09:00:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/14] target/arm/ptw: Flip sense of get_phys_addr
 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> This completes the conversion of this family of functions to
> returning true on success and false on failure.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h      | 2 +-
>   target/arm/ptw.c            | 2 +-
>   target/arm/tcg/m_helper.c   | 8 ++++----
>   target/arm/tcg/tlb_helper.c | 6 +++---
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

