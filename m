Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2607FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKwo-0007G4-5V; Wed, 12 Feb 2025 17:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKwm-0007Fj-UN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:11:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKwk-0005ti-Ob
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:11:08 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f4af4f9ddso2414105ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739398265; x=1740003065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJEgVJV7DP7dqm/emYDtHrqkv2lycXlY8AkEUZPN9QU=;
 b=ywy/Cc81azHMly8RcgzMx15oEJX9FgKyea1E2IMpuWaQHcR5+xIpGYLJT5uK2wpDzY
 5mk19m0NLtnhmOOTv6+pcqt3oxtZnxwRk+KNFgTgRYffTc4V9N+9x6bBdgN1RYiX9Afu
 D5cotVjSoECgaTL8QJAdCeG1WIB17HmiWYTeIlWxbvz58LkFSqejzqdTTCpCADZAVBe1
 KOCKIhTssphLx51AqGU+3viu5Mp3jCk5uiriodFE0h7Xk4KhfusgyrqjxJ18YxIXhu6A
 QJS4WQBo6ihMVc6WM5rbYMaCVlihBGcIO6o2XdYrc68UVF+N5ArkzLOSWg0RBBhJb2IR
 PlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739398265; x=1740003065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJEgVJV7DP7dqm/emYDtHrqkv2lycXlY8AkEUZPN9QU=;
 b=M2/amRd5nf+OQXQLxbDTt19apCJOWi2ZrtQJx1c1G+783YZp7XXs62vdfKPSzgSgx2
 Kh28jp44Rj76LZ55CtNWClRP8bjpMf6zEt3eO+Ky9PkiIN1rVLzMhONiM+V1lxRK/iwx
 1urxDAmMan0G8cW/S7+nkuVG/IVJqlvRn1u3K6q5+S+qaVBM63SSTFqqDBLVG7JDU8+U
 7ogMY/lzNoFXsDwQNenbwqWNddmRNAuNvE6dzVcg62+CgO3Nun4PNjkLBmHSNwUlg+fH
 aOBUg+qN9X/ViU4jhEierF3f668xC2nyWbY4M4wdLFiqnNYmRWpIvJSEFpofV3p2haSj
 937w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGJ84GeYJ8BymvTuidcwVCEZ0uNqZod8XeAF9+yRbFFbWK+ns7YFJvt8wvfDwJLVM8wcoRJDlMOKgc@nongnu.org
X-Gm-Message-State: AOJu0Ywtl186TBGeSjjWykloCKwxc1wqW8PldkJUuZBzFTw5uIecketl
 IyV43POV6FgldcTYbkJ14hFj937kOQCQ0uej0/IQ5SxNP4atby//+8iRHb/Jp54=
X-Gm-Gg: ASbGncsS9M1onlc1G+AQC+CZIZ4T/a4z90+/hkKI28xTR1LBBVc9IFYWWNxw3W32pbj
 2H4yO40lSxUqTur5Qm7zlxi9IDo0JPH8Zcw0l8CXSvfPiuKLGNVXxUPhyWJZQmyywFy0SbVD6K1
 o2EmVnzOXAiulZ5thy/frgqTjGS3HiaYsNlYW3Buw+iJ5YrlIT1wkDQI10+B8m+GcxB5rsq20WG
 8K73DU+3gqn55/Gu/k3fiiQl33PxFPugd4yIZz4rWz8K4A1kHuh95fHl5ArblMyUva5AuCajLPG
 L02EGvUTvU/eOfTBkTRUqvqlEVfRLb4KnyLj3ojKEb1VxgBNUp+qmiY=
X-Google-Smtp-Source: AGHT+IErFB2GgKNRGbtyzcaN3EBKnZBn+iz6kIBKlliusdjk2mn4emMrtrzLt0dm55V9e+jWtevpQA==
X-Received: by 2002:a05:6a21:999a:b0:1ea:ddd1:2fcf with SMTP id
 adf61e73a8af0-1ee6b2e1d78mr1887454637.4.1739398265154; 
 Wed, 12 Feb 2025 14:11:05 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad555e8f22bsm4674618a12.68.2025.02.12.14.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 14:11:04 -0800 (PST)
Message-ID: <40b1b0b1-e019-400b-9d06-079ca472b7e1@linaro.org>
Date: Wed, 12 Feb 2025 14:11:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] qom: Require TypeInfo::class_data points to
 const data
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212213249.45574-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/12/25 13:32, Philippe Mathieu-Daudé wrote:
> All TypeInfo::class_data point to const data.
> Enforce that in the structure, so future class_data
> stays in .rodata.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qom/object.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1d5b0337242..31adc2ef174 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -488,7 +488,7 @@ struct TypeInfo
>   
>       void (*class_init)(ObjectClass *klass, const void *data);
>       void (*class_base_init)(ObjectClass *klass, const void *data);
> -    const void *class_data;
> +    const void *const class_data;
>   
>       const InterfaceInfo *interfaces;
>   };


This doesn't do what you think it does.
I'm surprised it compiles.


r~

