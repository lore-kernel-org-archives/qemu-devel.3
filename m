Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36337D149EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QcG-0001Ix-QB; Fri, 25 Oct 2024 16:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QcF-0001HO-1A
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QcD-00012o-Ih
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c70abba48so20320945ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729886936; x=1730491736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbUb6ngdrt7cd3FL66J1JQgQ6vqA8vQccN+11IX7wI0=;
 b=L7lTRfKmq/8LuKcuKSwKx47pWHAoZlwgpHc9/KJgIcE67u8HfRZ4NmRNt46xOlWi3h
 sUzeV8SYXyQNpIADQX5SMoFrDWJgnmayAvq9ZmaZLlRRf6/xy/UoL/HLdl61oPolXIfF
 Rqz17ohuBLG4xgiiV0Pl9psj1Jykd1W4SZrbMzjUKS3Vgt/Xju/SCuSp3jyqdXk3Xo5f
 E8UxyilnFObEOi59SpvNb7eOtBlS53sji+NeSYfQ1topoG4CVTTAftiKMcrx0hk5M8U+
 gXafOm2FP6qZ/xMN9b/T8H9yunqJGb7Wp/uEFq/dFawHC5w3Ahae64htj9EAn0VxpYLh
 DwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729886936; x=1730491736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbUb6ngdrt7cd3FL66J1JQgQ6vqA8vQccN+11IX7wI0=;
 b=ZNQgxC8H2NDDQ18mXetYxy2WMshnhJiMXyY3INbDmpZ5EnzYQB+cB18GmV/V71hk/W
 3pPW7b9F+5NjXVxH0qGaUpZ+zKTHniFswAIN9iehquZhH6eKK7wPghS6rmpaEQtQtjym
 GbRBZCoW+RzjXGOCoJCcwHmHG1KXJp6ylxwbuf5zJVpUy6DFBL6tHoZfK8G54+k2z2Wx
 rcGX6fevS2RPPJp1wBNT4Rf5uc3UymA1HTL1OD9HlgwoMY0Lk1qigxPYx1adPnrOjoVy
 I+NwYqAFQDtYSy2BCZwbrCdjP1LqKJzlMtIptbVdwocrB5ozMkxUwyF+GKpStLtAlZaX
 GhAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEovMBPhkfGie24kMQj0HQ+Ng5R1AwW01NJf0sU/PhddkxyisB2/avhTqBHmCI5goC0O6jx+dzgAcF@nongnu.org
X-Gm-Message-State: AOJu0YxGi3QpfHqjge9ozIukDioVoCc2btCf121g8836fQnBfJ4f8UZR
 3w8RYcU3dNBlcrJIWR60tdafFTXXJjtyP+pr5zNMZn6iR0zqC2EoQN520HFFcEo=
X-Google-Smtp-Source: AGHT+IEoiR9EOtVasy/zSIPz/sDj5ItG5+TOlisE6k2pO+kq8VP+lazuw+lJK2L6Bx8OpFqJPzmFcg==
X-Received: by 2002:a17:902:f683:b0:20c:93c2:9175 with SMTP id
 d9443c01a7336-210c6c1e21bmr4562895ad.30.1729886936021; 
 Fri, 25 Oct 2024 13:08:56 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02ecc8sm12994355ad.222.2024.10.25.13.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 13:08:55 -0700 (PDT)
Message-ID: <060dbc04-ca34-4c1d-9272-aff02a70ed01@linaro.org>
Date: Fri, 25 Oct 2024 13:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system
 build job
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-24-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241025160209.194307-24-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/25/24 09:02, Paolo Bonzini wrote:
> We have fixed all incompatibilities with older versions of rustc
> and bindgen.  Enable Rust on Debian to check that the minimum
> supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aba65ff833a..8deaf9627cb 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -40,7 +40,7 @@ build-system-ubuntu:
>       job: amd64-ubuntu2204-container
>     variables:
>       IMAGE: ubuntu2204
> -    CONFIGURE_ARGS: --enable-docs
> +    CONFIGURE_ARGS: --enable-docs --enable-rust
>       TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>       MAKE_CHECK_ARGS: check-build
>   
> @@ -71,7 +71,7 @@ build-system-debian:
>       job: amd64-debian-container
>     variables:
>       IMAGE: debian
> -    CONFIGURE_ARGS: --with-coroutine=sigaltstack
> +    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
>       TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
>         sparc-softmmu xtensa-softmmu
>       MAKE_CHECK_ARGS: check-build

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

