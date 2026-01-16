Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D8DD47CAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgXQy-0007xP-78; Thu, 15 Jan 2026 19:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXQu-0007u2-Jz
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:11:21 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXQs-0003IH-Tg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:11:20 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfd5d34817so966031a34.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 16:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768522278; x=1769127078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEXqWvyYHBxajM5Ie54wEc6mNyB8beVHMI2CCX/w60U=;
 b=frdC/ay4K66qhSTwwfrBD2v/qrl//5tvJsOLOKNjmnDSbnbmdrqqH7ePgwXDdPX5DN
 r6obYr7XJSx8/N1xQZ2fpeg6eWdLtCi9wXRKqr7Mbpz7Aps2oWpkXdXAZa/395DfhHXb
 1bnPADKf2Lu87qQQTgXgrHM0+F3xF9nokvcXUZUQTRTgBJv9BPWVxY13PoUf1YhoPRxo
 nLaUVz0KMNvqzgE3AuzfqCEiKFXHiYOww8ewkQMB5eRLPUoJ6yoOMdFhI+4ZEr+kJDgn
 grYrWucvNJWTg3F9uxW7jupXMn8AOika7LC6T91d5c+oBSaAWDMwRWOyPs5dPlO5c4+z
 V6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768522278; x=1769127078;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEXqWvyYHBxajM5Ie54wEc6mNyB8beVHMI2CCX/w60U=;
 b=U7hYcdWwyoppBi8soc10noFspb9Gfid1UsFimjfX/JMZcAEgKRauBAm8oRCVW3B/rt
 Idsh7pNVEYbArRbq9XcmDzFUHKpOih8sb7reFJjzvhokdfXvrclhttI+by3kM5UcViKt
 lqAIbumz73iCbLiThyxmxXrN7rWxgfq43p85x/uaj6yxIkl6Sp7T4D1lb32utsxmUljr
 EcCCTQdWsqGrNv9qa/VuqHrUgeoCHD6QsVnALYi1xJgZXsNqhwmG6nPSjyTjUakSEQR9
 T0rz+ULc1f/JGSreJiprpIE0dRuPynL+ZFKJ8Jo0O+GyjwfgQODFe+iPWTfVNy+j81od
 sN9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjFcbLCnTiQcq9VcDLlStBlKxC5GVvNDc01CZWNHbXaUIxF2aVNcnWcC1xN3warcZ8iHpN0QKqY9Tj@nongnu.org
X-Gm-Message-State: AOJu0YxW3g9EVDUVPrfYNlamdPhnvKTh/fLcIr68CyJ4u25tFfsCk6U+
 FVCizQH4xLVlnRfZ/dgwcUudtnOIKRl1vXraCc4NSNnsMGxoZNQGZ6TYAjKzMq6HT5nNPxoEwQm
 Z+vXxBlE=
X-Gm-Gg: AY/fxX4vgAFje4vglO8FQ6LJY0kdNJ4AKD2W2Mi8WIWXpHnlUZtWVbKqsRserzwX4k5
 gUVhJEtcP1Qm1itSdtpw/vAgwSLuMjH7G/zFh2K6cgIDoSEgLp9N5d6QkCTmQ5spshnpEp5pmWi
 0+PBIJmA/tow9/UwoKjdlq52qsVrF8muxXBdccvLukzCTPXR9vF9hn1r9s5xNYaIkGHiYQ9tz3N
 zVk1DEqmUNOikiAnZ7D0nyWfdDngJ+ukIthqvLKjr6A2OYdajsvTSw3x2fNIePJwUPNEVfXbZbP
 fXDQSzEAzdFL5N8mlQdu7hCC6xIsBeBF/nrFAAd3P6CIY87ZCeo3zlsY0wVls98ixJOkQKtxBCY
 gYiEhADN/UdY8vQmmmUNjZ9C8X8PQIplpZd8opsihPi+YR1h8peqv1+LJAC7NBjXvJbFAulyl+4
 6qn3JJnCfm8cc1xEGEKO4XT8a3Qcmm7Yca5BWPsmNZAitNV+23yYLf
X-Received: by 2002:a05:6830:378a:b0:7c9:594f:2d16 with SMTP id
 46e09a7af769-7cfdfc8f7admr427618a34.0.1768522277661; 
 Thu, 15 Jan 2026 16:11:17 -0800 (PST)
Received: from [10.244.221.227] ([172.59.196.187])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf5402sm763721fac.4.2026.01.15.16.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 16:11:17 -0800 (PST)
Message-ID: <0a8f1d66-7c1d-41e2-ba7d-7b872ef97036@linaro.org>
Date: Fri, 16 Jan 2026 11:11:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add co-maintainer for TCG Plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, stefanha@redhat.com,
 pbonzini@redhat.com
References: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 1/16/26 07:25, Pierrick Bouvier wrote:
> I would like to help Alex to maintain TCG Plugins. We talked about it
> and he will keep the priority for merging series, but I can occasionally
> merge some of them when there is a special interest.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..d80cdfbb6e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4039,10 +4039,10 @@ F: include/tcg/
>   
>   TCG Plugins
>   M: Alex Bennée <alex.bennee@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>   T: git https://gitlab.com/stsquad/qemu plugins/next
>   R: Alexandre Iooss <erdnaxe@crans.org>
>   R: Mahmoud Mandour <ma.mandourr@gmail.com>
> -R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>   S: Maintained
>   F: docs/devel/tcg-plugins.rst
>   F: plugins/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

