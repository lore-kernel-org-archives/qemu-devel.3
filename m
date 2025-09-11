Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6FCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwczx-00033O-6A; Thu, 11 Sep 2025 04:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwczv-000334-JD
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:49:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwczo-0004Zz-MQ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:49:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3dcce361897so333537f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757580572; x=1758185372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pFcqO3G4bt95C8X7bgNW11HxlHtsvOfsnIcISPdzHCM=;
 b=buqqRQTWBEOopUf7RHt3TcqwsyOqYo3phdY39qveQKT3W01Na3MpRIIfIwL1CxAsj9
 MdJpfMQTNBtB0MJPzR116RLm8Dvnm0TOfP5qxUu+xmWTFv1m660ZJvCBe6ABTgKAthMP
 t2KByNwJ5C3uDUrWtzaCRd7n8EX3Go93tGp+UtP7ok4xart+Wrplb2Koo2FwCGbpgqQT
 pxeUUM7yVwj3Ivl3+Ex6Xbb1jyylyLrlynQ27rE6h948ovsVL+DvIOkxwHK2zF6js+y+
 56hSbdRs09JgSpcC2iWJLNDo1/zUudDjEJsM3qEB6BQgMnlJEPfLOFRxeU1NF0K4V5Y9
 mCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757580572; x=1758185372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pFcqO3G4bt95C8X7bgNW11HxlHtsvOfsnIcISPdzHCM=;
 b=Kdpduh7bbLK5HKkO+HVQPNjJXdSC1bpz67aYsb9nDtSP7Ya2WlI6yPcNJe+4QkiIAy
 rYHMCyB2p/YQjJgQR0/YSR9l9ED2AeLWJfpd9PUcgcwB4qma8iJ4c6sRhYHoIvmtrqzT
 7aJ5jXYvmiOp7sLC0Qzo8kmrMi0N3wIFpj5MgyfaMCCQanl9iFQw1i7ui/aADVWl1cZm
 RalN10zMZgpCUccM9MY7a9TOqBBRSkWn2hIgjufVmUWTJ9PYqwnKQvBPwZiG0SCayTkf
 5xSW7lxy8cGcXh/lB0blZqKAB+3d4zzPFZzj3pt5O2jbL4yMCzraLkqFb4dNdyR2WYRQ
 d4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTWqd4++dNw2DgVQ3Xo/YbAuBmzcirFVcoSZo8u9vpcGmxw8IOL3nRFxYBvdSQSqJzhA4x2kOC8wIP@nongnu.org
X-Gm-Message-State: AOJu0YxR78QLzqXNFAIQRpN2BWqYD5W02SqycMZSkhAWOP+N3VFTix/9
 V1dTmkSqTdt9PVtxoehO5fu3MChPNhCob3asHDSdcor7Bq2q5djc4pSBJt7A7we3fMc=
X-Gm-Gg: ASbGncuGrIEFQCC0RPrV+ebekEQTCyskhfGgUG903lvtWzE3kuLBHifLm7bwSB8xr60
 9zufuaNhGpsdEWYicF36Oj93JyiPReWs9a0A3ZFaOao77AbZ0MrxmWnMl1Nfu6cPmf5RfxhoiwB
 BUd3qL51fpC6Wz5VUe6L3wAQFHdmPBwLek7LiFuWztIUTNhB4A709aFTp0kUt2lITq3fEGwt0Hv
 1SB53uXZCdDYIZ7ZDDYIX6dT55P+3UuSIKMG2zwXaKqEPwhf+z8+ZHfhfjOddxVpGNQl6UbJV75
 7JkWjwIhdXWdEKJ3G46qDehyYnK6w4u+pSa2Fhhi5Vo0UPo1xOoAgW9BdIaMv9KDnX2fGEsNZ9u
 3wBOmrVlNA2b5VCSnjejjf/l2sK8R4LgilaJO
X-Google-Smtp-Source: AGHT+IGs8m1Yfhi6QKC0fxefl6h9o7Z3NJwjJJ/prOivfk5bU+nIn96ZU7LLvUAHpnPsGJRM1HOVYw==
X-Received: by 2002:a05:6000:2508:b0:3cd:e7de:c51e with SMTP id
 ffacd0b85a97d-3e64cd592f0mr14785092f8f.61.1757580572511; 
 Thu, 11 Sep 2025 01:49:32 -0700 (PDT)
Received: from [10.20.51.75] ([88.149.120.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e40a5sm1560921f8f.60.2025.09.11.01.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 01:49:32 -0700 (PDT)
Message-ID: <a306a44e-60b8-400c-9633-4b53ed949eac@linaro.org>
Date: Thu, 11 Sep 2025 08:49:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> Some code makes multiple qemu_log calls to incrementally emit
> a single message. Currently timestamps get prepended to all
> qemu_log calls, even those continuing a previous incomplete
> message.
> 
> This changes the qemu_log so it skips adding a new line prefix,
> if the previous qemu_log call did NOT end with a newline.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/log.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~>
> diff --git a/util/log.c b/util/log.c
> index abdcb6b311..2642a55c59 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
>       }
>   }
>   
> +/*
> + * 'true' if the previous log message lacked a trailing '\n',
> + * and thus the subsequent call must skip any prefix
> + */
> +static __thread bool incomplete;
> +
>   void qemu_log(const char *fmt, ...)
>   {
>       FILE *f;
> @@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
>        * was emitted if we are delayed acquiring the
>        * mutex
>        */
> -    if (message_with_timestamp) {
> +    if (message_with_timestamp && !incomplete) {
>           g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>           timestr = g_date_time_format_iso8601(dt);
>       }
> @@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
>           va_start(ap, fmt);
>           vfprintf(f, fmt, ap);
>           va_end(ap);
> +        incomplete = fmt[strlen(fmt) - 1] != '\n';
>           qemu_log_unlock(f);
>       }
>   }


