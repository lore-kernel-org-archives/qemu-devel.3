Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999A9CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1k6C-0002ic-R8; Thu, 25 Sep 2025 07:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k68-0002d9-QS
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:25:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k60-00070D-MN
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:25:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so912100f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758799504; x=1759404304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAk2rIC5JahxKLiMpbqd84FLx3juxhw/zwYFYDEmdkQ=;
 b=pxbhdRwp234OjVVyyQgZFRx39AQSu0CtDKv+1u77rw+Z3aXk/4g3bTrj/bc8UhBa47
 7wShe4PUorwyOFBMybMwnFCgw8CBwnZFOt4dH9lXZcu4vGUGU+wn7W+XRX+llD62G69M
 AIihO9l8TjDQpUYtBEzPKbKvUix7qpNECG2Td60WHkCRrBd2Gh4Oq1oQLBUnvcvGiCDg
 YPn9yt7udrHtVfU2BZFvskP25b7+RnY4XLbLQGvIsKHar+NQVzkex1heea/0SBpj2Ecv
 dZDb5PxNs6leYQM4nTgJKxyr1Zn0+WgzkFe4G57jrWuWSofiVFIAze/hTIIyjkN61YpF
 SkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758799504; x=1759404304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAk2rIC5JahxKLiMpbqd84FLx3juxhw/zwYFYDEmdkQ=;
 b=g6/T5nXsJlskNieEJTPmIe4m73Pr5c/t6QsgRsOILDWweUKup785MILMm2VcC52rb8
 +mrNyBxPprw9fLSi6CGYbYWGDZdnJ/BhOy37/IKNsY3rJ0PdCVrQP0V1b3yCv7OgI+kl
 8VJloirva7OsORqY6Xg4aJQQCF/xYgVhqO2VJjCY9FtszS4EpxrQ9fZZCFbQ0AtPFGgA
 qTOK3SrkSZDpghhZmKIoiIYW940Pv4Aepnt/RnPGQNoZC9SUwHwc+lRfl3cb52v/B63P
 3vy6OrFlnLIeuGJOeqyXbMlNO/7XTy2PFwmNJ4c4JS+/RwETzdIWRvbb2PFwd11DU+Ir
 nHQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViMQMswxvZ5kgOM4xlOpNcT+ipW+iQoWNUQSNWPaY3ZiaTkBNE0OdhjepcE/FtzInKoWc0PbPuKwLk@nongnu.org
X-Gm-Message-State: AOJu0YwL1zmeUNmJzYHozRdXQYg4TZimg/jLIs99IKFLAoVwbmcqLvRV
 MZy4kc69wh/KDA7we5XkAA7uKdS8S0s9K6xOfz8YQrvIOVcHMSPx1WItn991oufe8uQ=
X-Gm-Gg: ASbGncv5o6ygVmwPhsKlrouTt9NYMhKxbJISlDc7M7ETInGm16T3dW/WNby2VcXrcCw
 +p3OEsjxAFjgRi7gsNI4HJR6aIm6naUnHNAyj9DasHciMWMVKeU7/yqSZvn7GE/EP4DMr1Vvzvl
 5FGpkxkLjgoWcJokiPpYuxWKq17vD7CUiJv0vH8mHgy7m1lULsWbYA28egPbblFRvc4b8NE+JEw
 IGGLsSmaKNgY8FyOEOCQpBKlhLYjOAw8c9oRsflETAkI6ZMiVfe2T2xce9Ees6m22EjH6uawFP/
 sP0wx5/agjgGTn7sVWQcteGsCScSo0VQc8zHsGSMpOaMcelwgNPRz1L6Y+TttKCmUet4hjei4WJ
 8ZK/hN1drZUzQr7mignCSF2zLFh8oz050ieGi/rjlQE3ZEV0eYGdn6cs42fL6ks2sYA==
X-Google-Smtp-Source: AGHT+IH6QZe8wNUu3O6/iFu0XMeKt/h36Zl/JiT8RuHObgcq/nHoHlsjj4h7dqiHPGKMH1DXmnD/6g==
X-Received: by 2002:a05:6000:26c9:b0:3ec:dd26:6405 with SMTP id
 ffacd0b85a97d-40e481be731mr3048751f8f.26.1758799504353; 
 Thu, 25 Sep 2025 04:25:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bede2csm29552815e9.17.2025.09.25.04.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:25:03 -0700 (PDT)
Message-ID: <b91b8cd8-3970-459d-bc2a-1c8346b672b5@linaro.org>
Date: Thu, 25 Sep 2025 13:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/23] util: add support for formatting a workload name
 in messages
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-21-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-21-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 25/9/25 11:44, Daniel P. Berrangé wrote:
> The error_report function can include the guest name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
> 
> This introduces support for a "workload name" in the new
> messages API, which in the case of system emulators will
> be the guest name. The possibility of defining a workload
> name for other binaries is left as an exercise for the
> future.
> 
> This change has no impact on the output of the error_report
> function, but will change the qemu_log function. This can
> be easily seen with the 'log' trace backend, and how it is
> now more closely matching error_report output.
> 
> Before:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/error-report.h |  3 ---
>   include/qemu/message.h      | 10 ++++++++++
>   system/vl.c                 |  6 ++++--
>   util/error-report.c         |  7 -------
>   util/message.c              | 11 +++++++++++
>   5 files changed, 25 insertions(+), 12 deletions(-)


>   void qmessage_context_print(FILE *fp)
>   {
>       if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
> @@ -19,4 +25,9 @@ void qmessage_context_print(FILE *fp)
>           g_autofree char *timestr = g_date_time_format_iso8601(dt);
>           fprintf(fp, "%s ", timestr);
>       }
> +
> +    if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
> +        message_workloadname) {
> +        fprintf(fp, "%s ", message_workloadname);

Here also no formatting used; use fputs + fputc?

> +    }
>   }


