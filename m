Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB31AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qQD-0003QW-1m; Thu, 24 Apr 2025 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qQA-0003Q9-Q6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:50:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qQ9-0000cW-2Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:50:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so3909435e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477451; x=1746082251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TjgDewITqQzSvr7spidvPTauWdF0QZmMDWy3kEJPNts=;
 b=FQmjwGBlARBFK2r/7ISzSQ0e4ohs7mQNHqOuph+/OuvWfIn9D1OcHHph1gyK+I8zYp
 wH6kkcY+dJX9pD47lnmnNrSPG8huFgatwfyXlNm8X6fYLDq+qIChfwLvFOmGCXjgQy64
 FcI+u82Q8l19AmdlHwUm8j+uxAkaUv3SMoN7KoR4XjqCQte+UVAbBwSyoTDhaBVeXgjF
 aKWjt3gAVQxcmSGH7hhYQRdrfzevE55G1Y4LC4ug1Jek2dRiVrqraBwCvZWRQo6vR5hr
 19w8IfpO3hj9c1xm3QTy0GH8Di3jq8tQ3JGCgzOQE023uJ4gAsvoGSLqQiwHvP07QDLq
 PB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477451; x=1746082251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjgDewITqQzSvr7spidvPTauWdF0QZmMDWy3kEJPNts=;
 b=vnfXXnGeY+Dfeu7uWgpjGvU2NxCB+6H8QVRoxBZFgiRiLOYL22Vze3fe1pbYfTihc4
 VQplu8n09eZ4J2vantT70tSqgNdjOc7ZYYxEwOUojkgkYhauhxCh0NWu0t0200TWU8Bt
 KQlSTQhG4NlrhlznCjzQVzK3SHDAq8ygO3pKoluts16VoeaxVho8H6kTDX4vWiSOoI1A
 i5D2R3pl7MYy6P5HZVf1MqWxprjcO0bfKHLxYuCdjYRjXt04w2ZOi82XCGMP+xPJPAgR
 yiP/V3yOZr3iKP4v2R35ZGzx0ltNs3d1xiTJx1FOFW1+ZHtjF/kypqxpWqXw5CUihFK8
 1xPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77eOGhw2c8uVu5pfdBS/9E+zcrC+jDez7k7RqXB03kkfe+MD/W06xRycgNK0supIkZWEes3hNN6B3@nongnu.org
X-Gm-Message-State: AOJu0Yzvd2JJ1ChSRMKwoHG3ptoeSSEcb00nt8Vct+sq/KzN8pyZZ1zC
 h6McPdJO/RH6b+zGdUuQ6pILpPN3tUJUPDzYUL9QGXCvrkVsThBssqHdCD9TiyU=
X-Gm-Gg: ASbGncvrg0CcYFcMsD+AIc8VM6573idHkAoGdKV2qi8XQ731JeuuU1gMIiOdgj9Y6iU
 TGxcc8WnYTzZQG/ASe9sGs5281xVxgfa/ujhHRvEqdvDVLlbkn555UY8hqQmV15Oez6OkfGzQE8
 GmB95mKTGSHoydow1LRbIbcQTAAWCuFCNvkdeh3iHb1qriALBJjAydtb3623Yw4ButgYYlyO3hJ
 hqowKyIuXRu7G0iKQSeq39ufCGGwupELCZwj7z2gy6C2R+n0UCczUZjZsYRuLxeqEtf4tgn8z71
 wMa/mMs7UD6eBVuH2PSTrotX+lFQehKZH2PZ2A2tATnzpHgKRlyCpQ0F3paRllsti0wi9kw94VB
 3bDMsidzOoYXMvQ==
X-Google-Smtp-Source: AGHT+IHsVcdH7PNiqJ81lsPxc4HKS0lQRc+JVfAzJopUVLvaS7jFE+/Bz8s6hVAtjn3QHtZ/hwKWSA==
X-Received: by 2002:a05:600c:1547:b0:43d:7588:66a5 with SMTP id
 5b1f17b1804b1-4409bd8de81mr11768045e9.31.1745477451058; 
 Wed, 23 Apr 2025 23:50:51 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c7cfcabsm43004705e9.0.2025.04.23.23.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:50:50 -0700 (PDT)
Message-ID: <40c52afe-dbeb-427e-9f88-ac848e9c38a7@linaro.org>
Date: Thu, 24 Apr 2025 08:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 devel@daynix.com
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
 <20250424-buildsys-v1-2-97655e3b25d7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424-buildsys-v1-2-97655e3b25d7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 24/4/25 06:50, Akihiko Odaki wrote:
> CONFIG_STATX and CONFIG_STATX_MNT_ID are not used since commit
> 8ab5e8a503b5 ("virtiofsd: Remove build and docs glue").

since commit e0dc2631ec4 ("virtiofsd: Remove source"), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build | 10 ----------
>   1 file changed, 10 deletions(-)


