Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB97CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1vvP-0006rO-VQ; Thu, 25 Sep 2025 20:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1vvM-0006q6-1z
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:02:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1vvF-0004F1-4D
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:02:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-780292fcf62so1274804b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758844959; x=1759449759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dX34KFoiiTp61asmLbfrnTCpD5CdzFUQjNeyyD0cNgo=;
 b=tn+syQj7i6AQwE7XZ5EMY/Pve1AUYyQxkNP9w3cP04dOc3WO+ryIynFHtsp/QYjSKg
 bjv7p+V0dzy6uXNN/TecVO49TEZK3KB+TJcAEiY0691DSSLP+I8zKVKYUBfLgjglhkmH
 q9AWuD+J3/faGXxYt5RKVRPfOUrhP9Y6Ef0omghbaQzsn/HV/AIC+Ue0uiSrz25WZn1/
 eWwg7ZoNNOgdWYbweUodmIdpz7Egnv5vD6C2F91CCGTMc6LC3HkcH9CbGeDpRAO+JuQz
 qjv/rFGg2iw9gGw+od5kS31k9bEsX2wue3i/y2Sn40wZMFSUEZN73XdL43SLZngU2IR1
 JghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758844959; x=1759449759;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dX34KFoiiTp61asmLbfrnTCpD5CdzFUQjNeyyD0cNgo=;
 b=Y0vwbZ1UzLDzkOkelJ+GUyHAju9HCZ1mSbmObav3vqiUoD9zaGL1+jBPyp4mK1OENm
 fI30jh5RNKJ+1QJjnEjzm0o3wcjj6TACgKgjye0Ak6UnrW6D1+hRF2I+PuzRv2IOoQFn
 JkIvZI6iFoGl7h4cSgXpjPWX5IVGD7y2GXycRZh8IB8356RX7+pQV6Ua33UPnEdhHIXg
 WS/j2+PKUVz3gf6o82FMbsFrYEiObcJ6x2z5FkdCuQIeR3dsT4zqvoQEus/J0IAn/gpA
 vgnS1GGDsrukRVv0dOYwKy6oI1OWGld3OK9ytD0g6/tt3gPUOAt48XsKGJaTWsD4TDRW
 lj3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxil2ZY8lJiSoQVER0aSpWKdda6+If8LvmyRpRD4MdhwxZEPV5j4ZTgssSqZ+xOJqeYALrGVdB4k2l@nongnu.org
X-Gm-Message-State: AOJu0Yy5f2bTDGPvEC1tW7Wv2PaTmIn4NJtlhzrFHtjD02PjufXb3u1o
 vrUeGKec6o0OhfKcv8/Z11NXkv/IgrYSFsu5F5gN12D3kFMynR0r6GgNiYDCrgWl8fo=
X-Gm-Gg: ASbGnctoijHp1sL/SDVV6iH6Zb7ti6gBG8G58Xp4i8UEYtuYTcvQCfjbT4WZwoUAnd+
 FM8AVx31udM59GVE4LsIAadZEAIWlVkKOisrJIH4eayD37ezvTEgLnO7ZlbKcMlMkCBDOIBmfYR
 17NyqgmwOJsQt9hGzDDroSd56ZmcmdH/q+OqVYje/PoZ4F+zu8b5DpPNb4crF9ANxss3LQWfwe/
 h8thJ7gs0zUoHjCM/O82ZaLDFc8iqI6WseFRUQJrZsKlCboHGkCOzAAWdkMD2K2NItzXZloCg5p
 yZYVjeBEtoAZdhI0FjMMSUwYhNIrR0vEFtiSQe15F/u3OGOOaz2+rumbPnpaTZY7jfVlWh2rM8L
 /1+bbdpKuqvtByBbp6r5Mq3wPXfPkDMIb/35Z3PFpRDE6MOU=
X-Google-Smtp-Source: AGHT+IFgtGZjQowmJ0g0CWV7OJfHjy4gTJZt+K9oPfLX+/uNiNHHwUGthlbVs5OSFnw5ryjLchbRlg==
X-Received: by 2002:a05:6a00:2e18:b0:774:1fd4:1007 with SMTP id
 d2e1a72fcca58-780fcec0a5bmr4109880b3a.23.1758844958995; 
 Thu, 25 Sep 2025 17:02:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102c2b76esm2884652b3a.102.2025.09.25.17.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 17:02:38 -0700 (PDT)
Message-ID: <a27a8ca5-ad86-44a5-8849-e28e1e3271c0@linaro.org>
Date: Thu, 25 Sep 2025 17:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/23] util: introduce some API docs for logging APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-10-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> This addresses two key gotchas with the logging APIs:
> 
>   * Safely outputting a single line of text using
>     multiple qemu_log() calls requires use of the
>     qemu_log_trylock/unlock functions to avoid
>     interleaving between threads
> 
>   * Directly outputting to the FILE object returned
>     by qemu_log_trylock() must be discouraged because
>     it prevents the inclusion of configured log message
>     prefixes.

I disagree with this point.

> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/log-for-trace.h | 35 ++++++++++++++++++++++++++++++++++-
>   include/qemu/log.h           | 26 ++++++++++++++++++++++++++
>   rust/util/src/log.rs         |  7 +++++++
>   3 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index d47c9cd446..4e05b2e26f 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -29,7 +29,40 @@ static inline bool qemu_loglevel_mask(int mask)
>       return (qemu_loglevel & mask) != 0;
>   }
>   
> -/* main logging function */
> +/**
> + * qemu_log: report a log message
> + * @fmt: the format string for the message
> + * @...: the format string arguments
> + *
> + * This will emit a log message to the current output stream.
> + *
> + * The @fmt string should normally represent a complete line
> + * of text, ending with a newline character.
> + *
> + * If intending to call this function multiple times to
> + * incrementally construct a line of text, locking must
> + * be used to ensure that output from different threads
> + * is not interleaved.
> + *
> + * This is achieved by calling qemu_log_trylock() before
> + * starting the log line; calling qemu_log() multiple
> + * times with the last call having a newline at the end
> + * of @fmt; finishing with a call to qemu_log_unlock().
> + *
> + * The FILE object returned by qemu_log_trylock() does
> + * not need to be used for outputting text directly,
> + * it is merely used to associate the lock.
> + *
> + *    FILE *f = qemu_log_trylock()
> + *
> + *    qemu_log("Something");
> + *    qemu_log("Something");
> + *    qemu_log("Something");
> + *    qemu_log("The end\n");
> + *
> + *    qemu_log_unlock(f);
> + *

And I really don't like documenting this as the "right way".

I believe that qemu_log *should* be used only for single-line output, all in one piece. 
Larger blocks *should* always use qemu_log_trylock and fprintf.  The compiler has 
optimizations transforming fprintf to fputs and fputc as appropriate.

If we can manage to transform all existing usage of multiple qemu_log, then we can remove 
the '\n' detection added in patch 8.

As far as adding the new prefixes... perhaps we should have something like

FILE *qemu_log_trylock_and_context(bool suppress_context)
{
     FILE *f = qemu_log_trylock();
     if (f && !suppress_context) {
         qmessage_context_print(f);
     }
     return f;
}

where qemu_log would do

     f = qemu_log_trylock_and_context(incomplete);


r~

