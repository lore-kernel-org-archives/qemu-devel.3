Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D00CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kA8-0004Pv-IP; Thu, 25 Sep 2025 07:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kA5-0004Nz-Bm
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:29:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kA0-0007dT-Qp
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:29:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so5832925e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758799750; x=1759404550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2kjqP/T0aAKnXWDCWagYfiH+NQyxKDWzpeUyQu3sm/M=;
 b=Mmuv4FmHXuk6V01sxGR6wsL4UIxWWu8X/9PdYg3cz86IBVj5gw8XaANNYZ8S0cON3N
 9bMEZLMFyMM1ZRRqeo9Dq88946QZgT0epdBkeC9i0bzn1QMEpJfpuRi2aYP1Cc1kHmYU
 j0sfvY/PA4P3WPkQOHo9KgygquWzzPQWtK2X7A0HHnT/swhcNU3wEz9td50Lq80bsMPG
 OlZWWAf+6Oh9iF9qVDX0gWsM07CpsxnswePvlQCtapphM+A1rF7qtcGni5yzXhaVRFW1
 fPrwiq/XWKt+9TZoXzc5tBwWx1g93lnWWdQY/1WKVGTVhFXHDnrx3BLFqaRTbxcsBZFm
 RgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758799750; x=1759404550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2kjqP/T0aAKnXWDCWagYfiH+NQyxKDWzpeUyQu3sm/M=;
 b=cyYUFl8oGq4tjKSx6TkX9jgyQcATZPNmDAYKyZvRzWV2JDUnPS986p6Z2/M4i540Oi
 i++UfPw59r6yFKWtocwVg5UVuRRJmbHfdqsjU4QcDi+cOK8i2OlJtz23wpSrtAlivUbv
 NaMIcjUeeBj96QCtJAqKW+y0aJC7iNW4B7QY+oI890QDAnucJyhzu5lwBr7dTZI+9aOO
 iHGKpiuXiVTHIdnt1wI0O9Z6jkE3f2SnWs8eGOdsuWrXlEzmwAJeuCt5busK+tT8HwNs
 ZUePbn24z883x3jWiILMitQacRbK3ygWkBTVLAQ/KKqHPSSflTKlN7RyNQhbh2shnw/P
 zXrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX29PjAKHNL8rT3LHYhnFpUWrzrG5/I7vGHC9NMPK+nVBp9kbBaryvRZO2YL+7AiFow1azw44UGauTc@nongnu.org
X-Gm-Message-State: AOJu0YxU9MdwDK5JtVPus1fs7deI7gncm2wX3XwtdiOfUWWBq0/rC0Tk
 F7/xuJq5abBegfHSZ2yW4nRehz3yZQKIjYUARos9Cxz83S1Bnq9Kfrd9cOc523OR4ZA=
X-Gm-Gg: ASbGnct8JBJug85By+DhY4HlXGvccYKNn+Fg4DckvSu+OHfFSkmcGx3+APT1mol66+A
 EG9HDKPuGuOoT6FAWuy9wi5WmhpiQjVQK1X3QaVzei/ih7/GQ8no9S7YTdBRiRtkvNwidkNSoE1
 nIlhW7Seri9UiK+yNrjVPsQb9DCqOsTi/Jk/20f6gCsvMw57naaMEv8+ywjNHthBzjGCr8rNJfI
 Ipb2aN+qIkj83cKXpPjFlhbm0KoZk3X/9m9sZ9lZet15wKc9dcwUu8jtu4EuE5VwxirvgduZ5Iu
 ggfiYLLQzOTSvYJn6Bx2Ge4isMNsFfZOdAoOt2r8QIKw9Tv3b1E0pYszu0BwlzsPE8gplb8E0Pp
 DtfbqfQG6X1OjafI8ibIox624lRQDJB6xMaKI3uQq8oLnNiMYrWoq/TS6ZMHexDhaXIKF4dgOOt
 0V
X-Google-Smtp-Source: AGHT+IGmptrpcotGLYpn/sK0VRLVzmvPzJP4F1tXCI9eGvmk5c/ZqWERik9eSAp/p86qHlKz0noJiA==
X-Received: by 2002:a05:600c:3ba7:b0:46e:34f9:993 with SMTP id
 5b1f17b1804b1-46e34f90b0emr21060375e9.13.1758799749974; 
 Thu, 25 Sep 2025 04:29:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab48b40sm72014785e9.19.2025.09.25.04.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:29:09 -0700 (PDT)
Message-ID: <0126273c-4598-4a0e-b86a-da4b742bc30b@linaro.org>
Date: Thu, 25 Sep 2025 13:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/36] target/arm: Rename TBFLAG_A64_NV2_MEM_E20 with
 *_E2H
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Install e2h in tbflags and compute nv2_mem_e20 from
> that in aarch64_tr_init_disas_context.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               | 3 +--
>   target/arm/tcg/translate.h     | 2 ++
>   target/arm/tcg/hflags.c        | 8 +++++---
>   target/arm/tcg/translate-a64.c | 3 ++-
>   4 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

