Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F27C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 05:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vccy7-0002UX-9K; Mon, 05 Jan 2026 00:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccrd-00019O-7D
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:10:45 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccrb-0003Bg-HR
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:10:44 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a110548cdeso183232845ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 21:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767589841; x=1768194641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRy3HONEYwC1mqP/GAJHcY9YIUl99FBhsZBSeIWx594=;
 b=XJ3/Gis47W5UGjRHiV5TrW7XRJ/JaP5eL5NbNsxQY4Tv0eyMEVXZt41SYo5v0oNFkl
 3pL8eNnZjSp7NRTtJmAKk9eTOjdSF7IP5U1ccDQcQlbAm9wPynPhErQDuprY8pg4zbDK
 hLZbmifW0oYxCo0VWFYqsKR1PLYwA/WOnT2fA/DXDGlVQfLgVA6M0zM2rxs+voNvMwVb
 ifKS9H1A2VmE+FqaUr8LCue3/lMrXmr9tvuUYpMtuia7CkWTO3+8LB+KlidSFhVbHC5N
 jMmK33VrdJdWWSfDIKucbjQbIGpnnPJndY+1J0OWB5cUBdEVo/ts63m+EsxMz60adMgY
 TKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767589841; x=1768194641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRy3HONEYwC1mqP/GAJHcY9YIUl99FBhsZBSeIWx594=;
 b=Z1JHdsCLfrgKBkpcihKXu3Gzdu5Qb4McwjO6P9R0wyiqy5uS6nI7QBq8xBf8O9kF6H
 GrKVzs7VOje3pA20Bryy01x9yIzP2P9rg4WShhOt40a6pxG0d3FIsK+Ps+WTUBsfU6pg
 ehMw+R6bFbEmGQIfBaB9Ir205Ahk9zM4lbEHHWQ/Kv8o7IuRiO/JuQvl0by2CD+rPtCy
 gNqzD4sUWl5UTTUYaXyV1PVt6g2hLwW5yuoilhGbY34a5WRbd8HRqnlMSIbnsLIHMLZJ
 VuuSFMmQX8lHK4pH/I01814wlS2HUEIt6iji/fT4XEYSJHe2FpZe66GMZ72mMMEwyJ1O
 AXEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzpNV2clIN8jz4M4AMcffVqXisy8bYuuPYBL+/JKljYb5rxqnQF49YHn9aKsA2oNsawDxgDvAL0IS@nongnu.org
X-Gm-Message-State: AOJu0Yy+gSiuCe3icbuIr/6MU/U4eZ3wNLfzALIxkJgl323+Puvfswmz
 9qW8ypEKgRkmTpI+9eAZMSGL9Pufs/MVqz+GGoHS7PCvqBZpQgI1YHgyEK29HaU1bM0=
X-Gm-Gg: AY/fxX4dxpbuqKfzUe7Wnu7TY0a5UZn8ZysX9ABzGNMjf8RzLLPYhZRlU8/96Aqlb/L
 vVruIT9C3Z9K8OSuARbmiwbR4GnRE2zm3lC5+N92cd9P/jBy2mKXGXC2rt6kxAgnI62Qnmsnu5e
 Vgch8Ja07zrrOeNcf2BfVlF10a9sUAgnCE1tXylgliIiXjFoMnUNtJqE1V0OoxP8WzAnq4sEPLs
 KHbLoVoVnOcPlt5nRU1x0L8x5kwUwV8zOVeOgggXXMdAkLNM3EFUvFxk64lYloPX9scZbSJTXUs
 OOV2A5QNGjVrsBK8pMHgrIAzf/SH4DxmX8fwXpdXVwUowvLQ5TqLxu/q7N88iLYO9b1r/ob3zU1
 k99lF5smApXPWZEgmLx8TM3sZDA/FEcYKJz61bBTRnSV2jX/1fepyZT54PYG6uwStQo4yPd3mjp
 DmbKJ8F0yi/TGiEYSffO1ycRwg2sVHZw==
X-Google-Smtp-Source: AGHT+IFoYeN7XfGrB2LQM9zYUaBIHImJrnYL2ZF2bBYzXgHGoVh7yMD6fVitJR0MOxQ+sCcsPa9OwQ==
X-Received: by 2002:a17:902:ec8b:b0:2a2:c1a3:63df with SMTP id
 d9443c01a7336-2a2f2830da5mr494894355ad.31.1767589841464; 
 Sun, 04 Jan 2026 21:10:41 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66634sm440432245ad.12.2026.01.04.21.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 21:10:41 -0800 (PST)
Message-ID: <2f52ebc1-4627-438a-b443-58dbe159bd8c@linaro.org>
Date: Mon, 5 Jan 2026 16:10:34 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] plugins: define plugin API symbols as extern "C"
 when compiling in C++
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260102214724.4128196-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

On 1/3/26 08:47, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 60de4fdd3fa..e44f863d839 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -16,6 +16,10 @@
>   #include <stdbool.h>
>   #include <stddef.h>
>   
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
>   /*
>    * For best performance, build the plugin with -fvisibility=hidden so that
>    * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
> @@ -1210,4 +1214,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
>   QEMU_PLUGIN_API
>   uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
>   
> +#ifdef __cplusplus
> +} /* extern "C" */
> +#endif
> +
>   #endif /* QEMU_QEMU_PLUGIN_H */


