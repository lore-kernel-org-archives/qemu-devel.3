Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D96CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOQh-0004Zl-RO; Tue, 05 May 2026 18:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKOQg-0004ZO-43
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:39:50 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKOQe-00063B-A8
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:39:49 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dccb8644c4so3040101a34.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778020786; x=1778625586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNdgCTdGWg+T/Fc/y6uGvKfPabIGsrUgHTvDSW4nOI0=;
 b=lpERvfxGZ42nHN1VmU2012TTi6YAw/8Ibkd4I5Xo1XgGygsr5CAx1e6VKpH7/JLnf5
 jWPpDZ2+qLNp02R9+rS6xMpmE0YQAoq1joKpKDFis1tnumajto3PBsAfn+WeiL74RD1U
 PNi0WSVfHGr2MbLM2KAWNs3J+Xb4igwNH9kovXFuFJUArBr73whk3L7zoZxF4/dd9XP7
 yK4rutrw4nWTjXOzz8JVFlQpd/Kssecdnu05iAQCewdyMJts9eFiLb1FLdWgtwIr63Bt
 fn9URnJZi27yzNdful18KY6CA8AaOaSOp4NGaEaD2JE3BTAbSz5oP5bwTZD+DMFxVGD7
 dXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020786; x=1778625586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNdgCTdGWg+T/Fc/y6uGvKfPabIGsrUgHTvDSW4nOI0=;
 b=eEubFu7eWMney7EanRTGUf5/ihJ1DsQDkyJIM1aZHMF321nd0KKVpG961OimLgfFm9
 KizIE7h0MGtGAqs8xQ4wZB87R+01jKltiPytKj7tr1Abjw6NFBqaaxX5oosFY0/Ti6PO
 USDJbwaHD+rKxGnc0c98ngP3/TuZUGiBG5PREIwVYM5y6Y4qMnQBouGY2zI0W4Gu4w3n
 XfiYln8yE9hxJtQRbnRwh0JhQxlODq3CEXLDkbpvLmvLcr64rvGluJt2gSplOuXfQYEo
 iPzaiBrAxU0L+jyF1agM1HqjPpRdc7vfQNhTdxAmAk1W6kxa8FYd5afXzP/QfYIadvdE
 GN2A==
X-Gm-Message-State: AOJu0Yz2A4RQLvPU5wQlcRqb6Ajeu4jbSa8GnlaMl15i76OXxwIoccPU
 QUsKSk0mcpPfKW2j8Fbtz1dEtLePNs0LUE3AOGNmyoaHAACiUDM4c6aTo16r6O7pNl0qODMbquT
 7/rr7
X-Gm-Gg: AeBDievJPlX1Ut+1ogK63e5yEEdm/Zw7XEDH/OUKVVx64ZXOmfO7YWAgjhBMAC6hKeA
 y/OC62u1msQZcORk+jqE9DvsvSxoNoaZP56uLNYv5JDoquH5B61SEn+kJCD6vp4MvOAHxqT5OQM
 jWCqpFx4NYrPdV+ZRungmvSZNjsO/RHUln0IRY6KMAt3NeRGMmGEjQMrwVfkFe4eF738YbnbEsz
 BRQSODDkU8mMa5SK+ziC+9rDE82nT1xoq49r6ZBN+T2UQ3KzHK9ZlczuCqgG2Clisan1OmIUYaH
 XEW3IN9e7N9MhSwS9c+K4sdcEyHf5qv2Z3t7Mr5dtQ625Ue4AO3RmSBKslO4BIl6rnSaQWkPdUO
 4yk2rIyvekickkEyhxuvBklQ3K4jEBRHESvDdx1CqX6eF+N9GVR00/gVaZpNQHA/BLddKVs1WAw
 onYpNIl9uxllqnn5ci2xGMKLU9MtB/YHGogfVl6rdP4Oc+k/hsSs85e6c6fSCgU/QwK5+EPjK9Z
 qmkts6JOw8S3C/4QPgMOI0upQ==
X-Received: by 2002:a05:6830:6ad3:b0:7e1:cba6:9837 with SMTP id
 46e09a7af769-7e1deefaccemr496676a34.6.1778020786344; 
 Tue, 05 May 2026 15:39:46 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:8e44:9fa:a15c:eb9?
 ([2600:381:c938:6375:8e44:9fa:a15c:eb9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deced80854sm10559724a34.18.2026.05.05.15.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 15:39:46 -0700 (PDT)
Message-ID: <c7a83814-1ce7-4092-8df5-0a845bdf5b41@linaro.org>
Date: Tue, 5 May 2026 17:39:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: qemu-devel@nongnu.org
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 5/1/26 11:11, Mohamed Ayman wrote:
> +++ b/bsd-user/qemu.h
> @@ -44,12 +44,10 @@ extern char **environ;
>   #include "accel/tcg/vcpu-state.h"
>   
>   #include "qemu-os.h"
> -/*
> - * TODO: Remove these and rely only on qemu_real_host_page_size().
> - */
> -extern uintptr_t qemu_host_page_size;
> -extern intptr_t qemu_host_page_mask;
> -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> +
> +#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE)
> +#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)

This is a bad idea, hiding the true size of the host page.

There are oodles of corner cases that require the exact size of the host page.  If you 
hide this in a macro, you are going to stumble over them all of the time.


r~

