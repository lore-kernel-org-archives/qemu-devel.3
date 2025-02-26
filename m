Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F4C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 22:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPks-0004Vs-6g; Wed, 26 Feb 2025 17:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPkq-0004V2-8i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:19:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPko-0005Q2-8Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:19:47 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f6287649eso163877f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740608383; x=1741213183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I+p9gOhEHGVoC9nVh64I6Ojhb1aZ2tfzH956ceNDxus=;
 b=u3YKqHZnnQx75So29+CKZ1OC34Yuoir63V795Se3jYjnfmvn0wI+trOtL3sYCWeAh+
 Kw8IPVSYlo7zoc5BY/+oEQlwo4AFJtgnZKNDdcXfDf7HSczAfCYEQDVjtqMdLRYe7+/o
 04/wLhZABLU6khx9iGF7unAvug/doH6scUYlfdBGO5CG7xQz+ezhen1mP2cydnN317Wb
 aIvZ9/H7OJGRH9RZWLt6cmHQWWRDYFJH4J8mEDHu0Pkfo9T4q/jtVf7Kdy9hsYkRAg7f
 wl37YabD/a0BMLnR6uhNIab1MbbAK2ExNSlbh4JvxGsdgJ032IVca8KpLUklpkpOuDR+
 061A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608383; x=1741213183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+p9gOhEHGVoC9nVh64I6Ojhb1aZ2tfzH956ceNDxus=;
 b=s2O2M2mDTzgx2x+rMYa9j1iUNJ/1/LervuTBtCWG+sny4bg0UkhmiZyvaEEXsP40JJ
 iraqPkuDMQ/2CYdX7JYRivKaB4UeomGKGaRLR9Ak7NkaOdfPwL9cZ7zdV/Vmrqe3Bl5I
 M0N6nRku2LuNOwDJOm0/johkvF6AMKt3VYKaVtQgzqZxHlGZn7bdo2ZAUP9WP6WQdjxw
 HRFLEee592yqME9TDg10RxRswHZNyRQFASUNL7eJW+Tjap/Ab0jVkSWzUnWXpvfOI3Io
 C5BaVzFCFz7+9+H4BVddvCZgWOb3B8zm4ypsmwIizqhJXCB9i6vjLM8SStWsg8wyJbNf
 9SYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRtVoPW+/lw3hf5gh4S090cLp3icxL+LA6jbxhzNh3XC8cDi6Dcjp/TMRpBR57mO4pDRZT+2QRpPhn@nongnu.org
X-Gm-Message-State: AOJu0YwEiThb7cgic/KFF/9r8GZ6sbIATJWoi051rICztKb0b6m9gEc1
 wUUUUX96/II47tbdJRv3uAOASg09yPGTQUee4pfBbvPM2QQA7PicbfOLDJb/aeY=
X-Gm-Gg: ASbGncsllB1fIWOtL959/lxnd5acQ7lSeYLHy8hAIZfexnlYy9NQNVMZZx6U6GEK0kb
 sX+d6lsSfohbbAh6B0fZ9OsQISFjcZVp4Itx50n3aAeFQItwdp4/pyNEcY8FJuG4lrND3/eqNP4
 8W0Y/gg4Kxi0mRx8YhKIe4dZA2oPjVIsemhgR3OyyTjsF6xasu20Q03w8krsejvebLg/EFw5ZMu
 vgME6OXT1Sph7Ijbuc7CoLkN4epGSILx0VnYPZ+7jHozTklIrh6zyN5IAeGwKuhQyuhnq1OdC7e
 KOSxyJQLnxDao/FqTpiYnoh2gm9QOBwpw5CTNPxcV5rnoxJPAilKEUrlO0FD6uVdc394Tw==
X-Google-Smtp-Source: AGHT+IFYpE4nJBQqZGIKSb9Eib5UVSiLyPwaOANLz5VD/BYC0hGWhHGiSgWe0udZR9AhqRZ0+alpmA==
X-Received: by 2002:a05:6000:1447:b0:38f:2ffc:10b0 with SMTP id
 ffacd0b85a97d-38f707b0b03mr19834487f8f.27.1740608382910; 
 Wed, 26 Feb 2025 14:19:42 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e46f580bsm162691f8f.0.2025.02.26.14.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:19:42 -0800 (PST)
Message-ID: <02154f4f-954c-4e38-a473-f1d1b752257d@linaro.org>
Date: Wed, 26 Feb 2025 23:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] plugins/api: use qemu_target_page_mask() to get
 value
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-16-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250226140343.3907080-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/2/25 15:03, Alex Bennée wrote:
> Requiring TARGET_PAGE_MASK to be defined gets in the way of building
> this unit once. qemu_target_page_mask() will tell us what it is.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250225110844.3296991-2-alex.bennee@linaro.org>
> 
> ---
> v2
>    - use the proper qemu_target_page_mask() api
> ---
>   plugins/api.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


