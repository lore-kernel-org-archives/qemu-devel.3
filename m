Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687F5E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOL8u-0006OR-0d; Thu, 19 Dec 2024 13:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOL8q-0006Ni-Ia
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:20:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOL8n-0000nH-72
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:20:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so12583655e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734632451; x=1735237251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Z3a/iUUQ/+HAOnE58VpMrFLLzUdy8IgiVqmWGeiITo=;
 b=wU1jjCUlqRo1KHR98sDPDFnuXqxFVQyMxrZR2i9hWVT6x/4nd8Xl3GM1X1a0Mou5aO
 OjJuhtr81NEpin60DBxNdJcXfKZRPZ37jqt7YFX/DIXsyoJI0KXO7RANeZumPUZI3Rb+
 z2KIi8RFokrlziExNKdz6UD+FpLrcIlDDObKHa47tKr4xfVUaTKMpESk1EPjdkEyp+eL
 YobnuYN77MKtZ7itBM0FwLcrJT6ZNV9FNj37Ue19gM+LQzEogXttbT4wgdgMglcMQ6NZ
 EHa1Z8s9Hw5yaHMWr4t/dA/FN0helCA/Kl3gOleg05B8KOb3t1ZJPhhdn3QpbCClTJA5
 S23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632451; x=1735237251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Z3a/iUUQ/+HAOnE58VpMrFLLzUdy8IgiVqmWGeiITo=;
 b=ZnjQ1JC0IN6Pg19xja+0XaIY6eGurSoYmTuwXQUQcgILzqFB8Oih11raGlc5JjnLwP
 T10bMRCWkkH7L7XcKnJjh4g40FUyCJGbc3nauVb8tJV1KO5UygttwfrY1tVzVVPDQhOX
 wvOMHRCyTJ3VMfICfyXliHL6Hv703YOxEaHpu72veDY+4ItrZ91Tx++6FnKO1y0J0IWK
 tJSOXOmYbVJS313NcBzkKuAoSuybaEWAVbHfX7ju3FkLmJPs4olPm9sjFbyUcgcGTClD
 +he07OOY2p9OOHQfZhsScRTzTEIXFKek77qH3TfWxgfVPqEnExMVzf7Uxd5vH3H0qyQl
 Gd4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGsizHWkCNG0BnVZqSv/OXe0LrMkpRveRMxPS9LAD9HdJQlop1K6dkfd2ExZiA90F/FJQJlF4tHLtl@nongnu.org
X-Gm-Message-State: AOJu0YxGoLVzC7pUfqCqIYdLhRcHew+V4isPKW1udEK5Qa9cHuzeVJzD
 uxRaFPP42oe2SzS3BmooYJ9N7qfEnYLbHrW4XOQmN3Qab//YIBnQT8G7cO31M98=
X-Gm-Gg: ASbGncuURkRon3CSR6k2QaW8/RAmY3zYqXr0t/3FH5fbsH+3O1UpAmDL0aWL0ChzLiA
 SDFYXIOT6Sl11rKsDaViJ6WAqJTdojObY9Y60wK7cKxrW7Ib76CcJXg09poCQeqcvCv/irrlTi6
 VFf4dSK2x52YZCuFts5XeCOhzOMIO9/HlegpCX3rgSOFdtTAHY2g3w2GeIBu7AoWK5EvdMy/pVG
 2vHvzumTVZxxre/0f+M+GqtsIwjcx7esymkVOyvlXgpErsbLUKO52jKb+pXSHQE//FobJQ=
X-Google-Smtp-Source: AGHT+IHTcXrx3tS5FwyLnSmeKl1xlO7j3CAqNVr7ev+gQY3xrXQOaB7KB8asEN8y0fDpXmzvIZuu9w==
X-Received: by 2002:a05:6000:2cf:b0:386:3263:6c76 with SMTP id
 ffacd0b85a97d-38a223fd4a8mr70214f8f.54.1734632451333; 
 Thu, 19 Dec 2024 10:20:51 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366120088esm24531575e9.13.2024.12.19.10.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:20:50 -0800 (PST)
Message-ID: <dbe21846-ea9e-47b6-83c4-6ee350e891e5@linaro.org>
Date: Thu, 19 Dec 2024 19:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 21/11/24 20:21, Peter Xu wrote:
> Currently, qdev_get_machine() has a slight misuse on container_get(), as
> the helper says "get a container" but in reality the goal is to get the
> machine object.  It is still a "container" but not strictly.
> 
> Note that it _may_ get a container (at "/machine") in our current unit test
> of test-qdev-global-props.c before all these changes, but it's probably
> unexpected and worked by accident.
> 
> Switch to an explicit object_resolve_path_component(), with a side benefit
> that qdev_get_machine() can happen a lot, and we don't need to split the
> string ("/machine") every time.  This also paves way for making the helper
> container_get() never try to return a non-container at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/qdev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5f13111b77..b622be15ee 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
>       static Object *dev;
>   
>       if (dev == NULL) {
> -        dev = container_get(object_get_root(), "/machine");
> +        dev = object_resolve_path_component(object_get_root(), "machine");
> +        /*
> +         * Any call to this function before machine is created is treated
> +         * as a programming error as of now.
> +         */
> +        assert(dev);

This fails for user-emulation:

./qemu-x86_64 /bin/echo foo
qemu-x86_64: ../../hw/core/qdev.c:825: qdev_get_machine: Assertion `dev' 
failed.
Aborted (core dumped)

We need to skip this test for user emulation, but this file is in
hwcore_ss[] so the CONFIG_USER_ONLY definitions is not available.

Any simple enough idea to not block this?

>       }
>   
>       return dev;


