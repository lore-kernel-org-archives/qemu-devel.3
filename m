Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0141C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0CQ-0007g7-BQ; Thu, 06 Feb 2025 06:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0CC-0007Uw-Rh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:37:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0C7-0002Bg-7i
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:37:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so7732155e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841838; x=1739446638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VRYtZ8A2Hx3mPjrXktacs5lE0DqixVFFnkf2kuyqSo=;
 b=UTJzO3MJfZPIeGjqaWuKABLYERVWliuKDoV1KnHApVrd77c6+XLXp0ItTJZXhV111/
 A9diJruqrUFLGHuft3Ks9nFhQi9FiaS6khuSQysUhDobWUk7t2tLQvyRcJrknGrO1n2j
 YmonQFQpO9XwNkY1BwJOE8aZ36PWHAyXEOhTONVul/99y+SsMjgY/LvC7UQEdvtde0JM
 rTS0aH/mN8vawkLG9SzwgQYeyKzdhPywhlM66k22t+Y1JkqHbPw9QqgAlxXxUXM4E7RO
 CcuxeKYB+LHBXqVYIDrtqxqr+if0d+cQq7A45/rp3jnq5l1S1pk7a9nL/B5Uk6LC3/Zp
 XetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841838; x=1739446638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VRYtZ8A2Hx3mPjrXktacs5lE0DqixVFFnkf2kuyqSo=;
 b=rD0xc+17dyCEWsM4imzRxbEwilM9YV9FyVnjX61t+y5hQwC6h2HjNy0/PG0/wyt3C3
 IRJe5IBq822mhfaWe9rIEGRTAvags0IaIepwueFmNLPaap5zq2PiyTW+lDRqdOW0C9aB
 Ex7KH5/Z0roTIXj+JuSRi9ZRJK4CxA+JXC6rqlPL3qF7VXPi79Qt672B7r7gs+Kc8SDz
 gbQw38CMzlSAa0gFFVXrd8WoAAEB9VZMasugtjPWHDVu0GTjg2KPgHznn/f7B3XmR6Kw
 o+Pm4ef03tkGYN3TCutAJT8itSXJT80rMY/cyJZkOqHM5vC+nQg07pjU638QR8kXRb1z
 9IMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUALkNkaSmhtwRNLoZfcutcZcdoKM4fyQCaDBLKqERdYUgP/QNqqkzod1I4vMbS/vO6D1A5y8q8B3Oo@nongnu.org
X-Gm-Message-State: AOJu0Yzz2A5Jxz8hjG7Hw6F1pv65Sx3+Qm2PEnJTmetzc4TSBK7+pszp
 uvQlCC8WFbXA10tt0AWIAJzfLkQ6443jGB2VsKvB2MopnpNTNyYY4nd5FwnVcYM=
X-Gm-Gg: ASbGnct7RRqlVyWog6rpSQ8Emy0eEecmJqW5GhAB5nDyqM2PYigjbg3EjGUHivevize
 rhSIkFKHSWHjE/PRgq9CvGOZE+Da2zm0DmWj/OooyOvY4JXwgDCC/IAAkOC3B+4ihhD9O59kuQm
 YUZACWB4AfgIMp2bhedCOceEYUOg0FgDEYjeslE/FPNHVk3NZm86doKKHabGHtQo/0v1ukgu/bj
 T1LWMeazDMfA1Xeh8/lGAtzy60xZKcLev59bDrh9AfRAbvDpAHoehuJ55KZpQu2GQLoJs0skqOL
 iNwoeKcYppGjY8DG+bkUXhePsMs0WKmbUVJ4WYMETiaGHztLpPOFOWrIDis=
X-Google-Smtp-Source: AGHT+IELu6Je7WgWWWBTlKn28mKM9F4JDWhUMDYiOkkRcMccovqsEWCYyRxBnPl9hTzQ3cPEf0wbIA==
X-Received: by 2002:a05:600c:3111:b0:438:a20b:6a2a with SMTP id
 5b1f17b1804b1-4390d43d9b6mr61169915e9.14.1738841837782; 
 Thu, 06 Feb 2025 03:37:17 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d7d4sm53535695e9.10.2025.02.06.03.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 03:37:17 -0800 (PST)
Message-ID: <298a7473-e5e5-418d-8902-2cbd30730db6@linaro.org>
Date: Thu, 6 Feb 2025 12:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: add --rust-target option for bindgen
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250206111514.2134895-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206111514.2134895-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/2/25 12:15, Paolo Bonzini wrote:
> Without it, recent bindgen will give an error
> 
>     error: extern block cannot be declared unsafe
> 
> if rustc is not new enough to support the "unsafe extern" construct.
> 
> Cc: qemu-rust@nongnu.org
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 2c9ac9cfe1e..131b2225ab6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4054,6 +4054,9 @@ if have_rust
>         bindgen_args += ['--formatter', 'none']
>       endif
>     endif
> +  if bindgen.version().version_compare('>=0.66.0')
> +    bindgen_args += ['--rust-target', '1.59']
> +  endif
>     if bindgen.version().version_compare('<0.61.0')
>       # default in 0.61+
>       bindgen_args += ['--size_t-is-usize']

Should this be merged directly on master as build-fix?

