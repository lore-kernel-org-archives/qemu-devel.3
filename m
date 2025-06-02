Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4296FC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 23:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMEmd-0000pI-Gg; Mon, 02 Jun 2025 19:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMEmb-0000ok-Ns
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:41:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMEmZ-00032m-UM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 19:41:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so4008193b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748907690; x=1749512490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Exzvq7SHIhc3TzZ3Cg6oMhRbK5x1AJxDsLqIGXUU+JM=;
 b=IU/RFO+aFrB5fpt18Tzit2v9mSdDYms6ajMjX+U7Bjwn/vXkS3oKtsMH8Bq0MimEsk
 7LGDwKVriWAF7jan7Yg2X/X6jv+CyZATka1N7fbMuRBHZMjUfCtUcnlADFyDFkvvJsdi
 SSUlEXG9lHfaXlMNRnpZfFH8/9K67ooHKCSzQ2dtuxiZYus0dxCyJ3vwMbyYkqh++d+V
 ns0zgFV3veh1xihcELJvOAkIQovli7MaBK32xlfANdG+nhJzeioI/J0IXO8MooFMWmo3
 WFQNno2hPjQxT13NJPA/o+99+Qb+n5WlHQrihQm+Ucw/jbsrYnWz1wkMSfPPTiVXAKgl
 cWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748907690; x=1749512490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Exzvq7SHIhc3TzZ3Cg6oMhRbK5x1AJxDsLqIGXUU+JM=;
 b=epiYsniPXI+WRCqBrwKcIeW843cxZcr6A/A6VI8UrfMA/1W3P6m59xQfkXe/pMVcEZ
 HYxvB2KK3F08gGvx3jOls1YJ4CcH0J7KCoPafauiioZ0uFj/AcMu6OettV1Np8adiFL/
 h1vNORzLmya2jJhev0U+JOGO6UKluhAAIwLUEMQMeJS1g7VF+cer1Q/LniJWHYuGAy60
 WBROXnQ01kgRccdV5v1zceLIiGPsChWiG0zFxD7PChJBL8dXy7QTwxGFcHCpM+7/1AYl
 Zi7m477MJNzdCxH9PecVoF1JnciBK+wuOwqF6XPK7jUzv9vX+j9cVGEp8+dAXSeDGVVr
 huuw==
X-Gm-Message-State: AOJu0Yy5FE8ed25xV2DqPL15gH74iZFt2RPoufNTXNHwMq6Q7TEX0+k/
 hDeuYHY13+BSYdaSJmhBK7CA0N+zEN5RkyQt5MzNIwX9Bf364de6U7QoL9SZrHIf8/AMLZA7X51
 66J3P
X-Gm-Gg: ASbGncv+sdWvXGXqWRFCNyv28+CzbVLpPXgkKCbpuV1MfW3n67vWg3PvKkVGlTnwcds
 ADSYzWQVEu6c61xERNhYxWlwP0m9kxN4l1tyGAex8W3iTidBKUXsfW6NJI0W6pLxTFJhPDN7oIt
 1P+xeIi9bLXxW8tu4wgyRotMJ6sF8FROU7U+6RQ/dFeQr4h69PAdhWgR1tYqeYxzLlHt5qRpQxp
 DTEKuTnxojR6CliSfzRUev9YE0G+omFoSVSinaQTkj/3aIDz2hl6GmQUmyf3oM1scxciIUb7Mwq
 ITlgIoB0RQMsFne7h15pZpmNM1B9jiqpj1szBS6ZY/09+UZJdY2JyRA5HsHc5ryV
X-Google-Smtp-Source: AGHT+IF1gaEM3mM7SJafS5oxCKjlXZK/8RVzzgWDtbBrjhYMrSbHM9FdJOaFEynH+oRRGRNzgerdyg==
X-Received: by 2002:a05:6a00:2195:b0:742:da7c:3f27 with SMTP id
 d2e1a72fcca58-747bd8513c8mr19691973b3a.0.1748907685279; 
 Mon, 02 Jun 2025 16:41:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affd441asm8210517b3a.153.2025.06.02.16.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 16:41:24 -0700 (PDT)
Message-ID: <e10f3c3c-02a2-4ddc-b555-25c8c6e11b19@linaro.org>
Date: Mon, 2 Jun 2025 16:41:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use config_base_arch for target libraries
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: clg@redhat.com, nabihestefan@google.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250602233801.2699961-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/2/25 4:38 PM, Pierrick Bouvier wrote:
> Fixed commit introduced common dependencies for target libraries. Alas,
> it wrongly reused the 'target' variable, which was previously set from
> another loop.
> 
> Thus, some dependencies were missing depending on order of target list,
> as found here [1].
> 
> The fix is to use the correct config_base_arch instead.
> Kudos to Thomas Huth who had this right, before I reimplement it, and
> introduce this bug.
> 
> [1] https://lore.kernel.org/qemu-devel/c54469ce-0385-4aea-b345-47711e9e61de@linaro.org/
> 
> Fixes: 4fb54de823e9 (meson: build target libraries with common dependencies)
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 2df89006f8b..ad9cef99ed9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4142,13 +4142,12 @@ common_all = static_library('common',
>   target_common_arch_libs = {}
>   target_common_system_arch_libs = {}
>   foreach target_base_arch, config_base_arch : config_base_arch_mak
> -  config_target = config_target_mak[target]
>     target_inc = [include_directories('target' / target_base_arch)]
>     inc = [common_user_inc + target_inc]
>   
> -  target_common = common_ss.apply(config_target, strict: false)
> -  target_system = system_ss.apply(config_target, strict: false)
> -  target_user = user_ss.apply(config_target, strict: false)
> +  target_common = common_ss.apply(config_base_arch, strict: false)
> +  target_system = system_ss.apply(config_base_arch, strict: false)
> +  target_user = user_ss.apply(config_base_arch, strict: false)
>     common_deps = []
>     system_deps = []
>     user_deps = []

As arm targets can be impacted by the build bug fixed here, it would be 
nice if this could be merged upstream quickly.

Thanks,
Pierrick

