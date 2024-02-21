Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEE1C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqUP-00026X-QC; Wed, 21 Feb 2024 12:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqUN-0001zD-6h
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:34:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqUH-0002YZ-Ck
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:34:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4126f486429so15413485e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708536864; x=1709141664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opygqFMxwKpFcrJotDyy+OC7GLFJ9LkeAWNcIi6WAlw=;
 b=Y2+mXbAzNhzXWI4kD6Uo2p6AXl3qPFPDckHNobH356BEIQWrJ0CMwjQgFZI9H4qFNm
 Fdg2Em9TkS7oCNxflMSCS0Rpe4/JsWtlIpPI2CyJ46Ejyk/9bgoKgoFlLg6tnINbUl6F
 recwcFLmasBRwJ3s+LSHZgENLgta5Wjl3YH4J8hGPh3tNh6PLVc1lwOo4tBvWU+uAA2a
 EWmtpBf4r6OSDyVQcgruTFtEcP9IsoU4UPMXG+CwCPaXK6tkFs05iFptfLLDZLXeS/6y
 Zeyxpjymyr4/aX/MlEKDJgZEPr4eYdm/bLzzfZHTJwDXDmh5gjWXxbT3vgyGwNGy++N+
 6b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536864; x=1709141664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=opygqFMxwKpFcrJotDyy+OC7GLFJ9LkeAWNcIi6WAlw=;
 b=OafMHc1T16zMnXb165bzd0ffLDIZuh8DbVXcrJP97xwkMLQbAQM+qxJovChxxxZVuo
 Kdca6UC9/Tz9Ee5dKe0CJJTUZvg0QeYuqga+aIXYANWJZAxntjV+e9Wu+6vHrKdjkyEf
 jhBDIP5nC5F14XeckMH90OUDfHmoNOq1p9jLerGOfRvv2ch9unkZf4SpyF6PrZye6Jxc
 CBQ4uYXn4WoGmLeN40dvYzDcyM+TBmCreCBsBNFCSqXR6ZJWF19dXcJ6jtLMZMq4auSI
 r63AcY9nAVKajM4PFp/XkoSekWq8+y8+i2uUfTIarCQ90eCFxANWfuZx3vsyTutxnhdA
 UpVw==
X-Gm-Message-State: AOJu0Yy1Drhl4BMPZrzo6GBFAIcBrkEosUtvOrRwkJisp/7LWsc/MGqL
 o3PYnQxSW+l26e6DTy29ANilCw+cdrXqYx+i7Scdh4cKVRbxahqesjgE8tZGdlw=
X-Google-Smtp-Source: AGHT+IElZo7+oKOyxDS7RBYSbpyDhD5ZFWh/xeE1n2Qu53aoIjPB4+odrbppF24EIJieGRdEASqPFg==
X-Received: by 2002:a5d:658f:0:b0:33d:513a:9247 with SMTP id
 q15-20020a5d658f000000b0033d513a9247mr5906750wru.55.1708536864212; 
 Wed, 21 Feb 2024 09:34:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bq28-20020a5d5a1c000000b0033d73e1505bsm4174412wrb.18.2024.02.21.09.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:34:23 -0800 (PST)
Message-ID: <1ce84d4b-876a-4f9c-a4b6-3bfd2f30d378@linaro.org>
Date: Wed, 21 Feb 2024 18:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240220155352.416710-1-pbonzini@redhat.com>
 <8FECF57F-7897-4AF8-9AC1-46A927C0FEC0@gmail.com>
 <CABgObfb+BK4s0VtwQUDkdzvwhTwRAXim-pJ-Lg1nWvbhuOm55w@mail.gmail.com>
 <1A0875D0-5135-4F16-A252-BC9EBA9C567B@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1A0875D0-5135-4F16-A252-BC9EBA9C567B@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 21/2/24 10:47, Bernhard Beschow wrote:

> Great! I'll rebase my PC initialization series on top of Peter's reset cleanup series which probably results in folding cmos initialization into pc.c.

Don't, already done.

