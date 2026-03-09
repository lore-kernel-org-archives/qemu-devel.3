Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C22F3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbOj-0001UO-NO; Mon, 09 Mar 2026 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbOh-0001Sy-SN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:15:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbOg-0001U4-3F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:15:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso7778415e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773065748; x=1773670548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGPhK78NLxRoo55z5nhr91xgJDrLcLdGGT8DAAPSslM=;
 b=bx6Df+tnwsa+yXz/Chl3ABHPQPGIwCDfayJ4wS2HfX/4hcI5E2iTXZFUZ+qr0CIxym
 pDz0iccPztNYO7em03KXcNTlrc09xlINer1O8t5nfRV3E44aJ9vZRdzJFZq7pDEnuN9K
 SkMeZ3tJ2SY6fQnkDff2ZMFm8s9NMpsLR0jn/ha6aIOaehBWO8EFg6vkxoV+EsYWRhLa
 1iOAxKUyrcmj4ByIVkyX2NV7Zc4d7qQCOpOD7xFKy7kGh2VFLOFV7QKOOIenOq64okKq
 hu81HDGVE7lxTlkrQwAbVmS/6kejlpcA2DrLdKahT+wnFqKyoeEyZrQ7HtiiU2v20xkw
 Fw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065748; x=1773670548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGPhK78NLxRoo55z5nhr91xgJDrLcLdGGT8DAAPSslM=;
 b=H5rUqHUyI12G2sbH7NHe8SCmrimAKZjEPviuWh2A32T9w8rVonaL/lDlD2gtcBeZ1n
 RwVOSkmiRRWZHvy83gk+mas9fy+xfPP16EdH+sf47PLtZ0ctuh5sNrCFgqlv88B27dsB
 27D35/jSJq649BgfJ56oLdSNqFyVsWP3ZUfF5cBO0A8Kee6q9fg+S8wNdeQ/JM+qhtGc
 l5Ia+dN5oLxCBf8+03hZShfmWPkJrgDbfrL/QiOSUcXtbtRIqTCobkZx6I7/Ws48o9Jc
 IILolhX72SGSnK3K9o51Ks9DYABCjOsXe41KgjJmPRE8TAVpTzHIGRSv+VTvQqijCe3G
 lYSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgq3wwNUCFCwhkhq30mCf0Pm+1ovkQ1++eemR0Z6dnwuZsWyka/UuGOiI/5AH1b1MfZxaXHv02EJpb@nongnu.org
X-Gm-Message-State: AOJu0Yzf0eQPEk6ecUHFvX+xgkwsVTvQaWsIGNerBEnixKbpS2qYWoC4
 WGh1/Al/sivvl42EG0Sdlxc7x0dcvSGRa+49shgf2pN8vXbrQr/g/6U3ekVcTYxdqyNl8cshih6
 g4N9mVN8=
X-Gm-Gg: ATEYQzxA0xIRU77azodEGCLxi2yphGy9AboS227xFyGu/tLoQ/C422Op6yzf5y2URAL
 gHNUq/EW0WWPqrWUjiigqJyepS+HDtDliKx9V3NHZJEXbHIcGeULGRmU4jJsshSLIejq6irRayb
 xisJSqYJbMHwwk2pjt0SH8Rz+e6GnkdpYsjo4HulgGRINsypLHET+jx/tgXmnIhRstbNuqwMdr0
 bC7O3wEW+HKE+xBYYYul8NvglT9u98MwzNgawGXDvyQL14lNjl5Hl09HBiv4jLH9PDMx5vYnkRN
 thnxkGlOpyLvqbAFDdEb8xxCOF+NC4FNp7xkev37fAwJp7Xt0rq+UFwNHFy+lOzSSNJ+wu+RgOr
 WKp+y5UvX/lbgm6DuglM/yFReUlTNgREY6nLIUiHRFtdD3+kWYSotgGKk5TqBpj6BMwIK7yupiB
 H+KRTjjGTrNPoP7NDLJOAKBy/VUgSvLkgSLV1WMFUw3ZIXW1oNkoN5FLqDU3ZAfnvkrFyGqSFdB
 0qCqvee4A==
X-Received: by 2002:a05:600c:1c17:b0:485:3b00:f93b with SMTP id
 5b1f17b1804b1-4853b00facamr76616915e9.31.1773065746957; 
 Mon, 09 Mar 2026 07:15:46 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853044d849sm304502465e9.11.2026.03.09.07.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:15:45 -0700 (PDT)
Message-ID: <a472bede-f617-483a-99ec-7ef34856efdc@linaro.org>
Date: Mon, 9 Mar 2026 15:15:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Error-handling fixes for passt
Content-Language: en-US
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20260305-passt-v2-0-f0582198afc0@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-passt-v2-0-f0582198afc0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/3/26 17:04, Peter Foley wrote:

> Peter Foley (2):
>        Only kill passt if it wrote a pidfile
>        Don't try to read the pidfile if passt got a signal

I'll queue these via my hw-misc tree, thanks.

