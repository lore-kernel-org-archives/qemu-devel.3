Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5390F3ED66
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgrU-0005Do-JR; Sat, 11 Apr 2026 18:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgrS-0005D5-Nn
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:31:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgrQ-0004yI-Uo
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:31:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so20540265e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946686; x=1776551486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OWIvz3K1FuP2bukaRG2WwlQn/bsgrX6xMK0lKtMfsIs=;
 b=UdEb9mJ+XocKE47ygHgRTNjfzLm3c+YTyvJjQgwA+X30AdNTQEA/F9T0VwlxkqSEEH
 MScdo7rc9X85y9kcCymRyxigwq2kDuHxGBJkryb/koZrQYIIApdklHUqFXvagkT497B4
 b7J6fIO01/J2Qm0I05htYYeQBW0MzH9d5HDygH8pk9tVXDR3x84XGM8zqCwk6ptweZ0o
 EcIzDBBYCfERbug1ZOcybJ1z+j/pdla6x/ybzU4XdYw0SvONfAlU06k5B9vpn3DIuri/
 j8LHcq/ZBZ4p+k7axyny4O34XMpUjA6XOqJJAtQjGmBiUBZZNvAnjs91MrphpUzJ50h/
 4onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946686; x=1776551486;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWIvz3K1FuP2bukaRG2WwlQn/bsgrX6xMK0lKtMfsIs=;
 b=pmNtyYlYKk+WLgqvw7FJSt1o7KfPyfVAqq3b6UZap0n+87BMCOAXSAu48Y6MQvJ45E
 IAPMz6Xsfr7M/zW0Awo0x2PquQ7vDW/iiQvKC/wgAxLYMJNaMPeyGAUGQnH7BRuZrWH3
 bqSperNJGNnwKicnqCQ7G0Ty/I0AIy+Wr1m214zDeqEPiOvj7kwXpBTdN5vYWuXFVCk0
 4zF+Ity4+CdWON42lp+uoloRh7vGZ48B+AFxPpMvm+o919gCCP42/4wLbhVpsWlsEIgG
 KaFcmHQmdzHWx050oUsQdME7/RsGf0IlPX8OhTNkKirrGz120v0gkJnUZuWcmyoZdzCg
 HDkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbxYVe7icUD97xy6d4tqxAjHur6dR9247eVSjpZG/whrqqZaYwVuXDo5XInznRc75KJ5ecHP/2r1Q1@nongnu.org
X-Gm-Message-State: AOJu0Yx6/T4it3lV53q3Oi6dpt/I/2XzeT/6yLR7hHg/NSUHT++Sy/BA
 7KN/FebqBx+wK76VB6YcPRFyNwi6E9gev0ACfWZac5WvqYoG5bEIwwpVsJ1UuxbMdwq3bJUmNZA
 M1bhsRog=
X-Gm-Gg: AeBDietfqBjgPCZ2JORqiJAbh9KtSU5ywy6DteVOgxfT0huav7lmKmKgT0KAAE2KB88
 qfpGBMcxztAc+l6pAeO0w2YRzpX6yPKl48fcTk7rVtbT5eq4P4Dbnn1uxxaV8zPqVlOtuVd+5TB
 IXORSZ3nD8a+L1w5Gem+4R6Ih1s7oLTb3r5RNnsMn7+8rm+3nLhcbn9pkR30DMHok+496ec7j0i
 MOw1tmRCSEU5mxRqvaihnmvzdadvN3GM9oukL3RjiOErEcQDo6oXViPfYrQA9l5v+5r7ClZa2zd
 kAANvZ1pLxrUbY84Zt4RjsOAdyoGh9HrKyQovW1owS5iE3W/oythBso7+eH5CXfHmKnQTFayEnv
 QoXZ8DhrwBfA7+wooaUZ/0a0uoJ+Fy/n/cBeqsiGLO3w+Q51qLd0449b9e2ndKBCXXtL3BkZlHp
 mBfpgsafu7d3r5TBV4np3f5hrTCr61Ka0hXCNE2ZO/QsM1dheXRxHKI5wlJWtz8UIxzQ==
X-Received: by 2002:a05:600c:444b:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-488d6acd9fbmr86323445e9.15.1775946685932; 
 Sat, 11 Apr 2026 15:31:25 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67e685csm86736035e9.6.2026.04.11.15.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:31:25 -0700 (PDT)
Message-ID: <4dabec5f-1700-41a4-a36c-526b9f096460@linaro.org>
Date: Sun, 12 Apr 2026 00:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 48/67] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Combine the two-step vnc_display_init()/vnc_display_open() sequence
> into a single vnc_display_new() function that returns VncDisplay*.
> This simplifies the API by making vnc_display_open() an
> internal detail and will allow further code simplification.
> 
> vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
> Add vnc_display_free() for consistency, and it will be later used.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  2 --
>   ui/vnc.h             |  3 +++
>   ui/vnc.c             | 75 ++++++++++++++++++++++------------------------------
>   3 files changed, 35 insertions(+), 45 deletions(-)


> -bool vnc_display_init(const char *id, Error **errp)
> +VncDisplay *vnc_display_new(const char *id, Error **errp)
>   {
>       VncDisplay *vd;
>   
>       if (vnc_display_find(id) != NULL) {
> -        return true;
> +        return NULL;

Can you explain why we don't return the VncDisplay found here?

>       }
>       vd = g_malloc0(sizeof(*vd));
>   
> @@ -3451,7 +3451,7 @@ bool vnc_display_init(const char *id, Error **errp)
>   
>       if (!vd->kbd_layout) {
>           vnc_display_free(vd);
> -        return false;
> +        return NULL;
>       }
>   
>       vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> @@ -3464,8 +3464,13 @@ bool vnc_display_init(const char *id, Error **errp)
>       vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
>           &vmstate_change_handler, vd);
>   
> +    if (!vnc_display_open(vd, errp)) {
> +        vnc_display_free(vd);
> +        return NULL;
> +    }
> +
>       QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> -    return true;
> +    return vd;
>   }

