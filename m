Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C4C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgFl-00054i-Vk; Mon, 24 Jun 2024 05:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLgFk-00054G-6P
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:44:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLgFi-0001Km-Ny
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:44:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so2832044f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719222285; x=1719827085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LM1zqwG0qVVj/aYY64cZFNVJLh0Zy0mhN0dAF+NUZ2I=;
 b=rBWv/aX2NAfVX+B2zG9SuT6+SJyYudDKYaB4ua9F8lRuDar49e4HF3YI3UVnod17J9
 +7ytOpXBhVcaDykrKbpDA9N8BHb9zBN6E/bDVxu+LJzmRXJ03j17YBvBBMJbQcLAuPi0
 IgVVuenpEUoh0woWSiW+FBeWxg6hDtdU0oe0nxVlITcqSEq+mxcnuRfTtd4PWbBPi0V6
 693mHb0n8+ZVqh7XGdsBx6pdc3Cv/9Ho89lydA4KF3zjH5jlaaAJtRHMdUdLYAD9i08b
 3KV1Rl9C3sJ9x7gpReJ6Alayxp+llT4sLTY7LGI8kO+4nlIfOD80E4j8KyZ7tSTiW01P
 zrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719222285; x=1719827085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LM1zqwG0qVVj/aYY64cZFNVJLh0Zy0mhN0dAF+NUZ2I=;
 b=DrlUL31cK1orKKjvraqsRkg9UvafhIcdvqzm1w8QbBYez8noE3incv1Mni06S1Gayw
 9htiEIeAGv/TanTXWn6Az+af1RMPKPk1hRawOXKqwENSc5rSS79+iK9An1sNylSICWKP
 ksCQdimGOsp02unQWkYB6vsxOPm5YyQkOLiArmSmDs5l5QnD9mI0jgjtpBHZ04Q05UCy
 deF7UOEJzVZBd8R+A99awC76YB7vaPmwCXq3lzj0ESLRN3s26RRH6CErEMeLD9aagFKq
 T9h9e+ZSXV+RM0jk3kk7Rt6m21Y25g3aBg3iDRN3LK39q+MrhewrooKprp8iJZw8Y9dK
 VOsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/eaqA+WWm+ExLTpwFldIGd4IrAOkPGuCoc093f5deHDn/bKtjOnOwD66NExADsGOX7576msxH+ZPlA7UOMPoLOBnMQU=
X-Gm-Message-State: AOJu0YzbTJUMgOJyzxSx2dNgvL6B002NYo1pIJ5AIsnplEsX/3Ka3246
 lWKSPecWmITIqr7K5Raf0ITCbPe2Yo1ktIhxIsVRVfBpu9YzaUXj6mSxgsARSPI=
X-Google-Smtp-Source: AGHT+IGrtefBk4dCeSdhJSdr+YFzN6moDdKOYR+zvKp2OY1bIl/kMA1eds/PTJ9H3sFFsCf8jrEbKw==
X-Received: by 2002:a5d:484a:0:b0:363:c25:ddc9 with SMTP id
 ffacd0b85a97d-366e7a639dbmr3218010f8f.65.1719222284648; 
 Mon, 24 Jun 2024 02:44:44 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c1d1sm9534424f8f.51.2024.06.24.02.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 02:44:44 -0700 (PDT)
Message-ID: <78125cf4-ab43-467b-ae84-fd2e4eba05ce@linaro.org>
Date: Mon, 24 Jun 2024 11:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/sev: Fix error message in sev_get_capabilities()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, michael.roth@amd.com
References: <cover.1719218926.git.mprivozn@redhat.com>
 <b4648905d399780063dc70851d3d6a3cd28719a5.1719218926.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b4648905d399780063dc70851d3d6a3cd28719a5.1719218926.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 24/6/24 10:52, Michal Privoznik wrote:
> When a custom path is provided to sev-guest object and opening
> the path fails an error message is reported. But the error
> message still mentions DEFAULT_SEV_DEVICE ("/dev/sev") instead of
> the custom path.
> 
> Fixes: 16dcf200dc951c1cde3e5b442457db5f690b8cf0
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   target/i386/sev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


