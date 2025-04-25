Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D78C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OxB-0002tl-DP; Fri, 25 Apr 2025 15:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Owo-0002jb-9v
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:42:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Owj-0007cX-NY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:42:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2240b4de12bso43107765ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610167; x=1746214967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HdLbEDNeOQ9vfLdL78v2yIL8/OlgVgyNxEboX96dXIE=;
 b=z0+feC+OB4kZAVT6sp7K/qJvYBb2r8a41w7PJcULCp225OSvdHkPiq0zlvC0AxEi0J
 iIzwjOX9IwrzftsN9XnsNkazSVuXM90jRWTtfChmde02+KvLf/c5yXAXBAaOFNEriear
 ponMX1Hhr0Wzgs7mfLooDQYV1/fG67rsTw2Xj957saybsgWAXNyaO/oTYspb+hMvtNOn
 0lkDxo3n644TDTFelCUq3C5lCQ3dXlr8v7TTUZbbc/Twx6GSIVY+2vE11Uy0pM6mpCrD
 QTsPXSVmRW7qMxjvrXxVg0eFN7H6BABNef918muM5lCkurUxapmMxtmabXAmoUekBpr0
 dvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610167; x=1746214967;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HdLbEDNeOQ9vfLdL78v2yIL8/OlgVgyNxEboX96dXIE=;
 b=sqDvIQmmJKxmAWmzC0VBDSzkvcKhzKJ8ozGO0iUBlyzXQpEWL9wf/O4eM6jKA+m18H
 1FNWiohWz4RhK9kN3JEBgULnCuWAXLfJrnrTJD30A8j+f/lWx062iayQVdEOhQ0zTaX1
 efZvM3Da56WSp23KSn+56i04q0CcdDm8KqqGIAsfkIVqb5ZYAGLlH9D8IgqjJTqdurZu
 /1KnklG4xp8LXMlceoZ2VKI2TMLcDmzW2xa9WwWo21H5YCdH1q0FIvWOO6sG8x7+f3xE
 0cBhvhZhsmJBp+h8JAkNqf/vtarF8jSLss8N7n0cDgES8hlMXq/GbnD+90Jt6H8vgMaF
 /UUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwl0voBcHDeQqoX6hZ1uM2k9fBbBZUPdYDkJiNL4OCF5Cpl8K6qOc6lN4YjczSbXpGWojqTv6hlt6l@nongnu.org
X-Gm-Message-State: AOJu0YzBjhqiMAug/ol/7T6H7xBHGmb6mRvNHmyWgVfiKbh7/QGYuYzt
 XLkNtf0HZcMxMnWf48rM8smJh+U8JM5y0ybR9iEns2Dyd8s4ciI4NNZkh62OxOM=
X-Gm-Gg: ASbGncvyjzhgzhOtlI99x5i1neVKAGkV9XNfoGtj0t+4CVFG2T9HX+cS2+UJvfFhHbt
 ecdNl2AbHznCR/qVdDtQuozndH5URBV5Vp8SsaocVvprzOG/D6q/ELG692Nr/+fOcwTZLtF6tyd
 8neJcf5YQ6S7d0d3Mw3KoKGq3oEuMa9rx2Kvv/kx65NoZqsQurnWvAKh2EE+iEsWx97WJhHKqDA
 OIJ0+d0aL40jr/TDkvvnvZgHYWTmIMAYeEkBWh8PJrfgLKkZTL9a7eb5ruUSR4UunqF9/G+K2WB
 9/zsMIVSXl8qJtzrcEz2JUfoxFZsy1prwVYi3qLadtz3VuP1E3pS8g==
X-Google-Smtp-Source: AGHT+IHnRazjryzr4k/YJvFr19lkPfpf8PfnufJPOMKmAewCRehm+4tRNAZD9wQVle/CdoPui8ekkw==
X-Received: by 2002:a17:903:3d0e:b0:229:1717:8812 with SMTP id
 d9443c01a7336-22dc6826e1dmr12288435ad.0.1745610167574; 
 Fri, 25 Apr 2025 12:42:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dc7d5fsm36543065ad.103.2025.04.25.12.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:42:47 -0700 (PDT)
Message-ID: <29647f99-e12c-49c0-9517-5a4cdf83e621@linaro.org>
Date: Fri, 25 Apr 2025 12:42:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] accel/tcg: Merge internal-target.h into
 internal-common.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> There's nothing left in internal-target.h that is
> target specific.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 29 +++++++++++++++++++++++
>   accel/tcg/internal-target.h | 46 -------------------------------------
>   accel/tcg/cpu-exec.c        |  1 -
>   accel/tcg/cputlb.c          |  1 -
>   accel/tcg/tb-maint.c        |  1 -
>   accel/tcg/translate-all.c   |  1 -
>   accel/tcg/user-exec.c       |  1 -
>   7 files changed, 29 insertions(+), 51 deletions(-)
>   delete mode 100644 accel/tcg/internal-target.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


