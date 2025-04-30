Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A837C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACB3-0007qt-Qh; Wed, 30 Apr 2025 14:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACB2-0007ox-Qg
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:29:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACB0-00067T-Kr
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:29:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso264621b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746037737; x=1746642537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xf7StgsomvAyHveK2lC2y8EKqAE1ASvZR4bG/e1uZso=;
 b=mUeEmivFnY+bw3n1joRnuNxG/4nVSKgAoBUFIXgm5/8vB4iAtJgjL6QZO4561d4q92
 aVdy0pyS45IWmDJvq2fwc+p2fv8gXqBD4KmJPjrsjG8XKA87qontFJnK7N8EdEsVv733
 kvzbIfi3fi5tTbGOfrJiOO/uTqUrboX9/SO537kRf8mmkPAdbdk2UtvTJsmwunXYotRG
 +XzSAmqYFKyBGLxGTH6U2npbk0DBfO1qh8/vd0nOobWlIU6rQwxoqpTjtelAEXc7GUwv
 tVoUjdCo8vmEseRYLfxNPNKP9tGcVXatYb8J7hg1mggwHcMMFJH6Mdp6h+sWKrnSOutw
 33Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746037737; x=1746642537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xf7StgsomvAyHveK2lC2y8EKqAE1ASvZR4bG/e1uZso=;
 b=I1KBFiCmTHG4HMK+uh6GhLxQAuuJ5KF+DplMuOJoPAL2hvg5MJDaKpdaA9jh/1cPb0
 4D7Hmq24ZEZgs6iQ2dMLrUkmfyBcphYEh60wET/moi0CFO1hGYMCsjSmNU4YBBRNfxBW
 GYFVGq0wNCeXNSAy7IkI0l1hwlRLoEZunPEY9cdtekayjkYQhULVzlKnYaAym4QOzwmY
 Q1uqyB08JfWXx+tEv45Clp5+3nFoFVEaFvl+KSoOQPBneaLgUbwb/t/DDZUsiZ9ONika
 ukJPhpTRGgnzXtXfe9pW7LS5wdR2D15mCVL9rA8fSQs+CaMP2MUfagcOuA7Esy0kiVKc
 C1wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzEzOrWGYQEJF9KGkjXbfsEHbntFif8lweGPSHZJZYa1jsFHig7INZQgdnFVgOMOKemWDFlibVZTV8@nongnu.org
X-Gm-Message-State: AOJu0Yz7QJI0Nzq1Fw9Wy6kPkTLm6NkWq+mk6rU1P5ITaMmWrdpPqJcG
 tl4+PCP0r62Os54N2XZfAHVB15UNIrYnCCrGc2tgUSsg//+0Qvg720E3kSr7q3g=
X-Gm-Gg: ASbGncvZvIuW9qTiGQbWr6/rcvvlyRZM/UL65eHIe2pt+VDoOa+4cyg1ntkeaEeyd/d
 /XZjr/NddJlOdX37sbJ7zOrMNmbwP3SkDWtCHImwjUGj7n/6mR0ukp80oJikiR5cw7jrCZFzyGD
 jEqISsciuM8z6DidP/LuyhgtBnvF7hi7v+MFY4ptptG9pGz8K94aWOAxMuTZDrBmtYFesiYxFe4
 8W+4RLeTYoQOXRfMw0Dlug3/1ycCSVatxyrJrlaPEQW16JlN2Ofj1fCuKrprt+n+MuDBq5KXzxE
 dDaHHDwuXNNEkqxmdqhHvkSXyJWc017RgtidauQPsEm0Jv3x56Yk08u0K8A3u+XFwPmpV4vSoXz
 yQODTkv5X4VeEiF4HhQ==
X-Google-Smtp-Source: AGHT+IE4vHbPO94ar+fxRmmWot5znQkTAFs5WKYYBmdHcNgDR8Z0P7yQbM9KTvnMqybbIMnoHBwRnA==
X-Received: by 2002:a05:6a00:a1a:b0:736:5f75:4a44 with SMTP id
 d2e1a72fcca58-7403a836358mr4833489b3a.22.1746037736866; 
 Wed, 30 Apr 2025 11:28:56 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a8d256sm2001099b3a.157.2025.04.30.11.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:28:56 -0700 (PDT)
Message-ID: <34184e10-5337-408a-9052-d6796ab14494@linaro.org>
Date: Wed, 30 Apr 2025 11:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] include/system/hvf: missing vaddr include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> On MacOS x86_64:
> In file included from ../target/i386/hvf/x86_task.c:13:
> /Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
>      vaddr pc;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
>      vaddr saved_insn;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>      ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>                   ^
> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
>      QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/system/hvf.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

