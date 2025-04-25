Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC3AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GfW-0003fa-8W; Fri, 25 Apr 2025 06:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GfQ-0003eV-My
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:52:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GfM-0001Xm-Bi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:52:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso2257409f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745578339; x=1746183139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eso8jOrK5VodkMze1LgDrB6dXFF0uzS4SRH6lKFkbFQ=;
 b=KWkELokj/XB8D/i5qSJdc2dTHs9RND1AN1xU4yPCMpvI+s73aikW/CIasJWimooqry
 NjxKqdr7dRfvfd6dvu3/HkPomXMwF+0UdHuGTPZD9V2x/Rh7o2Xw9ePKMfIhtwMQs9PF
 KTlidfZGpp2mJrnwPEs4rijxXevHHuYlHxjmos9JvRMht63Drs92FM3R//yj/t/vY9NY
 /kHXXBgPnxv3FX8KoHAN6DnhoxnVVkDbVKuBdSOkIEToauWiHVWl/kORF8MUIQFa8JlQ
 6guWMyDPCjHuY1anFAysmYm1nOhr8SiU4Nuhh1UufTz2TkZL19XaZV1m5mpneQK6EeT9
 zzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578339; x=1746183139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eso8jOrK5VodkMze1LgDrB6dXFF0uzS4SRH6lKFkbFQ=;
 b=QDXe/VUvbtyMU/mTbgoUAo1YrCRtJ2DKnY2/LjGe5Tl3GQ22BkuL4+j89DKWKSHbXW
 1Wbh084KYb6HS016DDLAgJGR7FBZ23uzR3pjdZBXTtDQ9XiabB+nmqOIU/FQgHU3UwRH
 3Ay1Q5uo+ielO6DJsM9SB9WHNPA8S5g0yuDdb6+FDaJ37f646S1+VtLkAJGzL7KPwC2m
 qUGJcf5QSll2pl5etSre74P8PUxn8SiELQhxKGCLMm30PHofOcCGivbYJhL6v1CGr4nN
 3zPMVEtpEYhdWpJquOVPV+kWllYbU1jx2BpCiko6Cgxgm4uG0vV3MreW1N1fTHUfJW0W
 74cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlFz9EnecWwD59Rlo/y46hf2LYW2b5XLRKxv+kn1kGjwL4hJvnWGJSs8L8ENhmABkdP/3rTh9inzhy@nongnu.org
X-Gm-Message-State: AOJu0YxbVkffuQeYuVGfoGyqxlIVFvlEGCNB+CZ0W8vDd+8jrV8a9cFf
 vrwOpwt3DjTltRsJ4ylJ5Ez06tnUZA/fUQQ1G/pbtcRu09E1mtqIPrADCkVeMldcKzS7FxjSvAn
 5
X-Gm-Gg: ASbGncvU5z5A6i8kCa+ovZcl+B+H9T6mfCrglyY5UEkBKfPc/FlOBRSjeLSNPG9et/B
 in33OvwWnUfCIs9ZU4syOW7vMT40SNfNEumkNJPWImHSezeSM+s56XaaRAxkeaEn3AfdP6AIZN+
 HoD/o11YIrjtKucf86XvSYbGzVHrse0rX2qAHjoAR/KaB3qeGNKIn39/19UCA4b6ntH134IdPme
 ptjdBEkGlt2/QoJ9pCW4muV0XNXu3b8ZjepJ+jJlv7Q5woI6gKzEV5WtFvEUNY0oNKEqbljwq/D
 4MrXyJW7WY23DdTlGWupeTdk/rEQSXn74UhObbxwd/k+XtQkfojVg572y2pqAgHI/UddLcOp3Rc
 7mW0dQQsa
X-Google-Smtp-Source: AGHT+IFqmkOYxBeBqaq8D77M3QmxL32pwgNeWTCawEbgbcw9TUXZFn6PZZDemblDmr3zJYaGdri9lQ==
X-Received: by 2002:a5d:6da5:0:b0:39c:13fd:ec44 with SMTP id
 ffacd0b85a97d-3a074e14995mr1489718f8f.5.1745578338720; 
 Fri, 25 Apr 2025 03:52:18 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46a49sm1983531f8f.61.2025.04.25.03.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:52:18 -0700 (PDT)
Message-ID: <ca139831-0461-4fe2-9639-89d1020f4f63@linaro.org>
Date: Fri, 25 Apr 2025 12:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] meson: Use osdep_prefix for strchrnul()
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 devel@daynix.com, qemu-stable <qemu-stable@nongnu.org>
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Paolo, Pierrick,

On 24/4/25 06:50, Akihiko Odaki wrote:
> macOS SDK may have the symbol of strchrnul(), but it is actually
> available only on macOS 15.4 or later and that fact is codified in
> string.h. Include the header file using osdep_prefix to check if the
> function is available on the deployment target.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (4):
>        meson: Use has_header_symbol() to check getcpu()
>        meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
>        meson: Share common C source prefixes
>        meson: Use osdep_prefix for strchrnul()

If you don't have objections, I'm queuing this series as a hotfix
because multiple users are complaining building QEMU on macOS fails
by default. Unfortunately Apple made their SDK change the week we
released v10.0.0, I recommend it gets in v10.0.1 soon enough.

Thanks,

Phil.

