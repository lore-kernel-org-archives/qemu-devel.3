Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYu7-0004rP-KI; Thu, 01 Aug 2024 12:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYu6-0004qS-Ok
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:43:50 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYu5-0007mP-5e
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:43:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so10920356a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722530628; x=1723135428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LuAbgaieZwJhPfCe8PPzJIgx+KXXSVz5ultijqYEues=;
 b=G1tkOvwV91EbVn2GveJiRmR5ONNrtDOW359Z8VRHkRp+8tp7gcuNw6JD+K/tGJJsuX
 D84BV+dTotXHAkCSytVpaFguGL1wiHRgkUD+I1zeiUog4ZLCNhrxgobtNwcRlcAa38L9
 s1xhHntjM7SFskU3zxzjpBSfBfQtw74rsX3JaZFJ2MelounnP07p7y7akQ+dwpdIU5Ye
 s2SPNoMxhbaIUOZxDjmGXqIa/ShZofb+ut/poSysLduFU3/AVnsddf2b0e5ML/aOzw3y
 Oigyoc0Hw5UbB28Y+eXsGT0MAmsx/8PqtUh1DkNNZwJ0TFq6Yo9BhOgOAsSKPrVzhtVt
 giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722530628; x=1723135428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LuAbgaieZwJhPfCe8PPzJIgx+KXXSVz5ultijqYEues=;
 b=a/hm9vI9ytHXT62JzFhQZ7Uiyuhf3xWT4O2G8V4hOY4IX01KVsSCqBsZZWoIr3oKi4
 E3RrV1HQCbCoTmoRObjBibTdslsuinreW5J6zozPsA+DvuZdDYIxgVs2Y5SakBfyoEnC
 n0M3Y/oDR9BJu/IRF3qrNDGuLVxvBXeAfVWQyotmDWxCa2YNUfRMm6OGn8fRPAu2Stbw
 pCCtswP2og4+oC85lc9I6os1xI8K6/HSQgaUrtO9r1/VhxxsAfswdsp3G7U821iTbqZd
 3yb5oZjYRkeyq8XV60kYCILEbouCVHo1qoyX8CYNjA9zaNRmeoNLqArH/RDDCkgV6ayW
 LINA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB7gASdvdC2v4kxeAutXuKARyMeIVt1QJPmPbga1aXzkbgBEMESFhm+Mu1Ea5tbLH7/d3kf52PDrAFkx1jEA7sjc/tDpU=
X-Gm-Message-State: AOJu0Yz/U0lueZZXqupxGq6AcalgvfBQnBYF8inoz5DJmstw4CTjEQUn
 c/5jAl7GCFLMIUHsJZMyYrS/No4XV75wExfSsaq5zzBcmPY1aOCuKiiVBgYhsgU=
X-Google-Smtp-Source: AGHT+IH9Ox+UcTGRael+qyJdEvRArxUg6RRXnmQGhkljbCopnsr2l3gExTII6DGhHTE6QQMjBMQh5g==
X-Received: by 2002:a05:6402:a50:b0:578:60a6:7c69 with SMTP id
 4fb4d7f45d1cf-5b7f5413b46mr637327a12.30.1722530627496; 
 Thu, 01 Aug 2024 09:43:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590ac3sm10402636a12.34.2024.08.01.09.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:43:47 -0700 (PDT)
Message-ID: <afe7df7c-86d8-4347-b3ac-c158a6c7ce04@linaro.org>
Date: Thu, 1 Aug 2024 18:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/24] tests/functional: Convert the
 x86_cpu_model_versions test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-15-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Nothing thrilling in here, it's just a straight forward conversion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  1 +
>   .../test_x86_cpu_model_versions.py}           | 63 ++++++-------------
>   2 files changed, 20 insertions(+), 44 deletions(-)
>   rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
>   mode change 100644 => 100755


> @@ -217,9 +216,8 @@ def test_4_1_alias(self):
>       def test_none_alias(self):
>           """
>           Check if unversioned CPU model is an alias pointing to some version
> -
> -        :avocado: tags=machine:none
>           """
> +        self.machine = 'none'

            self.set_machine('none')

>           self.vm.add_args('-S')
>           self.vm.launch()

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


