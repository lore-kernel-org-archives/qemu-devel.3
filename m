Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0CAE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuU2-0006Jq-86; Wed, 18 Dec 2024 08:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuTn-0006DR-D0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:52:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuTl-0000Jx-4V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:52:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161eb95317so60537485ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529963; x=1735134763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Oyg1T7MQCRZRVxQ3fI2sGjbPGs31sO+h++Cjx41b/U=;
 b=K7SJ0ZEJCbPpzfkLN+50rOv1qgeernCnPdOZR/sYHwP7k2WyVbKwQhYJBEuL3P6ogv
 VLt/AX0rM8eSZ5n0SNSs4lPYju6NHfMSCXmBJiZEYzv0GLEo62S+ugTQQNseeSzCTaIy
 cUl+vsAhZ1qEIwk0DGGsnxfbztx3HehwxQtVPA84yTPEATFvdg5eK8TlkIjTArKuddBr
 xImKSMMxX5IJwsr2v7q6vflw3FJjRSP4sDk0bdPZRy425GFTDamYf4XXBMV/h7GIz149
 yNrYNx5vmqv5uZFmYUlBjhj2wbV6pH76fK3YhQmu4eht6KFO6t+hje98nh5wO1FqJzWJ
 zy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529963; x=1735134763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Oyg1T7MQCRZRVxQ3fI2sGjbPGs31sO+h++Cjx41b/U=;
 b=KsQEAPiy0pPZjer22SxBwD29frT+XSDxQljAyfO4dsVypGpinGzJ/2qw/20m8cfFgV
 fOmW76hILsFwmcRj5bmrvYjFRVTVaTLfMYiujIxh2czn9AV/DHd+iGRgV8eCRWxhzlo5
 CyL3ia7KaroZv69zsg804GQpmLlOKC+X5IqA4cq/1fhRUcNzrHYC4Y9h3BqDTNtWqv2o
 mckr+FnD3/OTP5NVWF1md6rtcPNwNw+/JtUh/RHBemQot1I8AcrWQyD+zYMwgCSBFCQn
 RCqoCdNrr0Bf97oxDxFM7/dr0cUBZj9btsp4eRhjSP57mDfWra/fWVwVTEpHTt4Wzpa2
 1/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn8Dcj9bfF8oU29k+8FRd4mG6YTI1W1xVbOzDv2QfxbbiCgoaZWL3jvnNcl29CbBfRJutCDJaPXd+w@nongnu.org
X-Gm-Message-State: AOJu0YwBtfTW8jGeEvZo/8RwlN8KhSGquHXzEBNFa2TLxfiPb1bYKe1T
 JDoAPMQ0TOJOwZPMIUi3Rhn2vM600n3kzilasml7OP//FkA3X+dUGwUC56IBYaI=
X-Gm-Gg: ASbGncsNy0e4lWkkyURNxXfTcPVJ6TvDknTdF9Gyj1giQnB7Muz/nbP8raPeNP3QJEf
 Db/UNxF4DMZ6JdqvMei6YuAcK1uHEv3nPoPtr/FZJCfJ6sdu3lKVpNvS2mYAZDVDYWsVBYDhWlL
 dEK4vOmzkHCwZrFgsD/JsZMDdV416XiH5rI760EJRm4fWefkQMsDT36mRx/7VsRA1dwGt+IFjP1
 lgmHceDo+Zxxa60m+1aRhndCPE+X+UgxGfDaFTRpMSeKV8pjr6HA0pYcGlc7r/rKOLJJ9KF
X-Google-Smtp-Source: AGHT+IHXOihy8bJ14JCiPf/+RyIKtWUIhwX2CKJ9OXM0VxbhpHviIb3ZFnaIsURL8YxhcvWCKDRC0w==
X-Received: by 2002:a17:903:2a8f:b0:215:5240:bb3d with SMTP id
 d9443c01a7336-218d7244595mr41046655ad.42.1734529963677; 
 Wed, 18 Dec 2024 05:52:43 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb3ffsm76323415ad.75.2024.12.18.05.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:52:43 -0800 (PST)
Message-ID: <54bf65a8-e813-4e47-a832-3f47948436e1@linaro.org>
Date: Wed, 18 Dec 2024 14:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/24] hw/core/qdev-properties: Constify Property
 argument to object_field_prop_ptr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> This logically should have accompanied d36f165d952 which
> allowed const Property to be registered.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/qdev-properties.h | 2 +-
>   hw/core/qdev-properties.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


