Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DF0C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1Az-0006dW-E3; Mon, 04 Aug 2025 15:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj17f-0002kJ-2l
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:45:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj17d-0007oc-Cx
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:45:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso71879575ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754336724; x=1754941524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gs+LUTSVN78Ft5+XhpP/Yie4msj5QpR3JFRIjB7Wq3Y=;
 b=hecpoOPZw+RdJS3JJlrjQYxY0REsrQgXCkKcK+o3N8prILr1Hv9FacM5U0Dp55WSLb
 pLLUu7S3LhJ9enFj9IaMyudYiWxLtxRSx7heOIPGp5LQWT2d78CD2LCcaEEPRFvovUMg
 OL7gbf9Kn6FDb6HO7sO2mIc/V6eQny8K1bb4sJmUbO9mazGFeICZw5QY/5CCRu61nzob
 MrTi3+Aol/lwT4Du9HbwIY4alz9kuXTjSaWWjOX/3iWgDMLxYFuGnLVopJy3rMPklPQd
 8kuOHck/thXTj4O7Cw/PNpvqmiQYnvxBr6d2IoleYmSQ39U0nF4YlsHVr7J/QoPg839v
 Gq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754336724; x=1754941524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gs+LUTSVN78Ft5+XhpP/Yie4msj5QpR3JFRIjB7Wq3Y=;
 b=lZoy4iswdLeKo6Q+qlduQwTZPEip+VJR2esq012eaeC1zzuuDlZRCKMQreBzkzPE1M
 aNcIDBdJXX0xJ5NclNRJgw6WeJYH0drRVy0kkC9Gc/ZuGEyIDoXsIPgN78Zs7PyeIg07
 Pibn8CQfXXOnjwSaVOclB/cJRJtyUs+0RQbYLq+KMCewS/+IEH67iRlPhLAOk3cBa4Ti
 YqJedJnbpzX4LeYBsTU8zbCOy3/FCoxQ10mg1DI2l0cyi6xUcThwNz+kq/t78f7hU/BD
 fbXIwccvR+pupOKmv7Boor9DFrnMm/iOEMNs7U77w3+2QOujYvzM2Hjdw51qrAvWwMV6
 Q+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY+Lr2xiTTopmTsFHmw2TRKzgz9zwEJhFMSYHwcyahmH0p8XCn6cxpi4dwtPUGyfx5oddpJ2nVA7po@nongnu.org
X-Gm-Message-State: AOJu0YxwoOEMyxpVS+9JNA5rdRtzBeuljypCUOoRiwI/s8dp/9JTLaxt
 AObGur7UhPdtQb6opot2p4xdbWOAyHadTZjF7qHPTlb1ViTU588H9v1QCgWhT+1A+IE=
X-Gm-Gg: ASbGncsd2wZ1Zln8V0yfjFWSYypl9YvKMIJbKjJbMAzAz2t7wWMT28pBTD1CMOFSDCm
 rN+4zPuWRsMCN2KykNRyWAcr8qHFrEsGHdJf4pc10m+z5PgsixfAdHnSbkdhSXAiZ5p/fmT2OZp
 IBKirVHpSsgFYZsQDYVwgeQz1OpRIdHdkts7NBeHjYYpQ2yplqCgtfp5if+JKsvglIvH+fNWw7U
 ASjhMnW3KKab9/PwoI9MAa4fqU0Jo9gDnsaWDbyT15YC8wfw1f5EYwbVXrCq2FwWvZxtn/Nr+Hx
 qQOhV0OiZMAkDbIxvri0pQQWGv8QJAICuzNfba79UQop3slfocydY1YedrMFlg5AmHpG8HhZnhU
 z5M46Hok2paSfimgHF0GWbGCsXNdRNHlUUm2IsgqSzlkhSrmMdhK/TRY4
X-Google-Smtp-Source: AGHT+IEZrdm8Hr8aXhZrYL4DncI5IsOAFvZ3wFngh28Yx3qBePtghl2fS/vNxQjBqR3D+X6oUUWTgg==
X-Received: by 2002:a17:902:f70b:b0:23c:7c59:c74e with SMTP id
 d9443c01a7336-24246d56f13mr143069685ad.0.1754336723945; 
 Mon, 04 Aug 2025 12:45:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a1csm117814465ad.78.2025.08.04.12.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:45:23 -0700 (PDT)
Message-ID: <a825a455-5606-42fa-b3de-766896991663@linaro.org>
Date: Mon, 4 Aug 2025 12:45:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/17] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS
 define
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-7-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> As of why 0: WHPX on arm64 doesn't have debug trap support as of today.
> 
> Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c     | 2 +-
>   include/system/whpx-common.h | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


