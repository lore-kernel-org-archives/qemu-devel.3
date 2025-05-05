Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56230C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0lM-0002nM-61; Mon, 05 May 2025 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0lK-0002mS-Is
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:41:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0lI-0005zm-Tn
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:41:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22c3407a87aso71361005ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470515; x=1747075315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hz3YfAN/v/roHV/d/6p4A5MsxD0Hnsa3hZReJcliBIk=;
 b=jQX9Cz+ETRhVc8xHOeeHRxSzMmjQ/u93DP3KKYd/qLphT6bk+5bsbgObkZj45pWfFz
 2o4XPlgdyE6+rLjQQ5tP7k2kCxstwmtin9H4+oglSLHg5SlfZtyh7RcltU/g8d89TJCa
 4DNhPxWI99bIBfVxV1WtGC+7Of4kv9GK0HyBquKKL3g4oK6PbxwkTE/c5V/hHBj9hUC4
 0++PkN2EMNx4yF1KA7c0xGBfpuNj+kFJvAzzutEzkXGuUllzpqAExuhW17lVc9RY9Amz
 EDnkbw94Jg0Hv/3VY5w3nbVTF8ezoms20DSWETm+0/TK7UNmwMj4O5m/DMJiTq++FURU
 6JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470515; x=1747075315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hz3YfAN/v/roHV/d/6p4A5MsxD0Hnsa3hZReJcliBIk=;
 b=ZjPg2J8kcdDpPovkt+f+/Na8rizqBmhVAbeP3Z629G0DhVSt/copN7SI72kdjvXCVj
 LiYo1XJJnPQPIY557O/ejjnxGK3t7hMHPD73LVoUz3iBeQdR61VeJAOtpsIjgm1A8FAc
 ivoZn5WU9PaaWwrBByYhLz8oxOGILivWPZp4ewXzS+yVcp8DILEnXaoR5EGg4PCEOsiT
 VjkpSWEj8gLOTqp3mUG4QWCdzrN6F0uiaDQM3NdHEBxAfoiojbDFoYTy9FFOjWtZkkIA
 NjVRq3BljRWmbyHGYFI+/wPz8CGm8SUAEn57hTcz6xpdM9s62FATv01a3gmS0TNWB9qR
 zO7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaiaj61++YdScZXkfBsIo9Bur2VL/95Nvj8fY4V4E7VVm86oUDCh7A4z0VC2teTMv1kraAPvV2R5jm@nongnu.org
X-Gm-Message-State: AOJu0YwdrmqK7utvruPDZ1wC9sIrdmBgAp8uZlCUCOAI0yAkIz4yKCa/
 4ZVu67FNu9cXRYOshYD00TORrFb1VTcW8jXskbwl7Ss0ZaVuMHtBPPt+OmAMKx4=
X-Gm-Gg: ASbGncsNYqEfWcXgPk960JdB79xflR2AWqEtBQuRspVG3Vh2L8kqsl5TmOilg2qAL3r
 J8EwhVndL1KAajvmk4i8IjkMIgqMDshY6bmOyrluMtTvOdxHuECc8hadinBK76h1WCX7ZSUySro
 WI3qX3n0rxrF6fIToHqp4tlnpZF6v/ZdNKox2mk3s7Iv5rMpKDJdf6akp/j8/+RdCF4HFZ7AbCS
 4iTiL62UvVUJz5ngO2DxEeMTGiGVxqsJzkkA0NIxqQK3jSvrxMHG9GCaZcJxdmvqrqclw8zkLNK
 dDtqKaUfAkf8hgYpkc3tePOA48RtZGfOaZn0heGWWCvEtU1SLU1EPuNXmKczVhnEaYVgljrlBYX
 MmvIbaGpE0mI4Q4c6CQ==
X-Google-Smtp-Source: AGHT+IGp9Lyl8EaufIN5bAJEVq5LU8JhfWf77OkXZf4gRl0aZ+kGddzDwCFSLhDMEOK/vgzcuYc6kA==
X-Received: by 2002:a17:902:dacf:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22e1eaeecf4mr154391995ad.48.1746470515597; 
 Mon, 05 May 2025 11:41:55 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405905cf4asm7415678b3a.135.2025.05.05.11.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:41:55 -0700 (PDT)
Message-ID: <cc6d8613-e0de-4b70-acc1-22bb30549ff8@linaro.org>
Date: Mon, 5 May 2025 11:41:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 42/48] target/arm/tcg/hflags: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-43-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-43-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/hflags.c    | 4 +++-
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

