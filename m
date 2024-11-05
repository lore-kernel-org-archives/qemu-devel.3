Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AB2D2C12D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LIl-0000Zc-Mo; Tue, 05 Nov 2024 10:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8LIj-0000WZ-Qh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:17:01 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8LIi-0002Qj-AG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:17:01 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso7108039a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819818; x=1731424618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5m3jDscsQtPnNRyJGwKWEzca7pqADuKvKJuzj4lZkQ=;
 b=EweSQCMVLyRbHL8RT61r+/KF9RiVDUPaCPmQyAfIO6aw31UlWBmW5nw7eubM3WezUP
 0gb1WH0wIQIHw7ZvZMl1V9rfc8pvRpPQH5HNPA5GSOxl0IRk9rpFXwLodIQOhlF5Rj1z
 yzI6foC8kEJrK/Qtmf59q57QdkFk/6riruLEaBznM741VcPP9+JqlXxSETSUVFjTnvr8
 OvV5Bpk0119Uf4i8v+ziWzAwjqNsmE3d2K8gPxiGWM1DDpUru2ZjeAXNYgBRfAjzAV49
 7oMn1cvq5Eq648nR9YnWW8XOLlWZtbfgtmeXIDt8xLsGcXIAqKhTvsheIVZe8lWcfMik
 A1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819818; x=1731424618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5m3jDscsQtPnNRyJGwKWEzca7pqADuKvKJuzj4lZkQ=;
 b=EKyWEqEHZrc1jWg/vrnPr1EH2svOwgOh88YpWLxSH1z9QEnEo37sCmeSrx0j+vQY8Y
 xoMJjxANmJolFtFPnB2RvOp+7DqxdnOv5SXydM9O4EV7+j9HySVgcqGPKxlmNw1RLcD6
 jTcdgSU/FKPTZksn+4q9gJkO13KcnG/2us8Zx0QOf22M2Umw80WIm4gw3VA56AA617mi
 ZpcregR37vGayAqjgOQJC3bkF9c9ol6Cc6HHZ4OoqCj0Km3dhKtsdD+E9pwwXBzAKcfd
 BQt1RdxeHKkb0ygY5ehaFoytvIHnGBOOQMQOlf07roc6ajIHPm8C8O7I5k6eZIh1nusi
 04+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEEY4XsSxEfYLlcjVhLHNJtexT2DZ/qB98UHhYMecybBjD16UEoWzCItZ3hV+Jdsg61ZKWkj/99bH+@nongnu.org
X-Gm-Message-State: AOJu0Yxw4uiMOFGTATFwccJR7XEuH7r2r7B7SLxHGfB5Brkf0njv2rHY
 c9UDsPHtXxqzhG5jF/fEWwJLFX2Tf1ibeD1DeF4b/qiIeDuMtbsiuuMEeYWsNGI=
X-Google-Smtp-Source: AGHT+IE5QKhFbI0/cUDpwWAzjG5ZdVSQ60svdiISSPtc/2xHwoc48hBenaziXOmDDdkkJl8F5DFpiQ==
X-Received: by 2002:a05:6402:51cd:b0:5ce:e005:5efe with SMTP id
 4fb4d7f45d1cf-5cee0055f23mr3108613a12.13.1730819818414; 
 Tue, 05 Nov 2024 07:16:58 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6aafc8dsm1448991a12.24.2024.11.05.07.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 07:16:58 -0800 (PST)
Message-ID: <08655269-610c-4337-920e-c1f55f2504e7@linaro.org>
Date: Tue, 5 Nov 2024 15:16:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: explain more verbosely why we forbid Clang on
 Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241105150114.334985-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105150114.334985-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
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

On 11/5/24 15:01, Daniel P. Berrangé wrote:
> Contributors are repeatedly sending patches to remove the blockage of
> clang on Windows, ignoring that we need 'gcc_struct' support. Put some
> more explicit comments in the code to discourage people from doing
> this.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/compiler.h |  7 +++++++
>   meson.build             | 11 ++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

