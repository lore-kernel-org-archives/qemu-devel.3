Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E6C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkTD-0004ve-Dz; Wed, 24 Jan 2024 16:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkT4-0004nQ-Pw
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:07:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkT2-0001xg-1L
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:07:30 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6dbce74f917so2748961b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706130446; x=1706735246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=waKoU6FzM38PjxmkthCNgVIQE2lcoOobxUOj/sb72RQ=;
 b=vwyF94I8DYe/tB7CRDeVqnq+/unc8cV7o6QRBL16JbSf3gt+Bw4bcuQU56megXKybc
 tMUM2/3lf7PPsVYcpWWeIi4GkVzmvpXr1LVEzR5SaDTF+JxYIiWLsfN3IDydVSzsHfaG
 mzg0fKEawrQE3P8QhjYC8hmXQpKo9VGNLVL156gEdnUM25wN6pIygwjoN/99SeD89HyC
 KGzNYEon3u84f2BApo8cLEkcb+83zqlTznKAv7z3tv5QG9n1HFAfH5dbElu6OYHOmC9Z
 /Nx5/Y3CWYWmT41I10W/derQSlG3HsnYGeYbFCjGgYPJanAf1+QVyCJjN0RkT2M3jS/t
 /gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130446; x=1706735246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waKoU6FzM38PjxmkthCNgVIQE2lcoOobxUOj/sb72RQ=;
 b=liEZpEu3FcI92w49HCERGJXO636ONmHUWp8f8P7xf4pFreBsmi1SSsyBlrGDAl/yB2
 PaYNbmSKjOL7nGFHqxCXcBN4Bahe7outymIxDYxr7IAors+h54mQCN+G6Af9ApYJwTqT
 0K0nRbN1DiVMW+Up7oGqMjrpQk3d4Q0/DnVcb2ZzsGKtr9gqlNLuBTwGzp0/uqJ9pMLC
 JROeQg/Au5gsHE3Zf4ep828uN2NWYBO0JJ0Din6oYBH/zVTY70dADJm656/KQsP+Wb81
 QwJZyDYBVTB/gpuUzOk8u8F2cBV8JkY7fHhxzuzhQt7L9w472U1EwIBx8itQlJWMOlB4
 xiSQ==
X-Gm-Message-State: AOJu0YwHZz4khBL0nXPor19YvXOUAzbsKhZyfkVUQCc73TwQDu5+GSZA
 +PQsOkl5/3KtQZYG+fHM41bjGBar91nS0Jz8am5raL+Y4NQmaZHhCSE1hlv9meE=
X-Google-Smtp-Source: AGHT+IFPDEDlLbW7AsypZIrSo81MmAi9PiOXZKk5UFzVXlN8897fqbCQzWqu/SjglKjkpllUHnICjw==
X-Received: by 2002:a05:6a20:d41e:b0:19c:68b9:ae96 with SMTP id
 il30-20020a056a20d41e00b0019c68b9ae96mr33154pzb.122.1706130446586; 
 Wed, 24 Jan 2024 13:07:26 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a63d90d000000b005ce033f3b54sm12497610pgg.27.2024.01.24.13.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:07:26 -0800 (PST)
Message-ID: <712c22e4-6000-4af5-9487-287b2d1fed02@linaro.org>
Date: Thu, 25 Jan 2024 07:07:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] tcg: Make tb_cflags() usable from target-agnostic
 code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124075609.14756-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 17:56, Philippe Mathieu-Daudé wrote:
> From: Ilya Leoshkevich<iii@linux.ibm.com>
> 
> Currently tb_cflags() is defined in exec-all.h, which is not usable
> from target-agnostic code. Move it to translation-block.h, which is.
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> Message-ID:<20231208003754.3688038-3-iii@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/exec-all.h          | 6 ------
>   include/exec/translation-block.h | 6 ++++++
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

