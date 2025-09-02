Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO9v-0007gd-EF; Tue, 02 Sep 2025 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utO9k-0007Z6-Oz
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:22:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utO9i-000873-P5
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:22:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d6afso2103172f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808544; x=1757413344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jw/1eNJgIOcepbKCObytsQWFr5tm+skVjNTS9u7cY+4=;
 b=PvTBR5uVvuW2VcMD1k3gTShWh1/M44PT5F4bA2SUeMda2C+J0u4qmkUyVb9Ph4IZQS
 xLV33BqLcX20GJlMpqbgo/xKgLc+e/uCSLf0Mi0nTMr4C1DK4FHNv2vkmR2Cqb2/0U69
 zfvBsCdIYmzTfyQkiEyuGa2PlAfzLEnSZirezSzz5duzwtwibp8ZDE3kw514jXVLDHAj
 NtbWxkfeTR3DsYU8PPQs0I+0tGSn5JqiHkzOiK+6ibRiTTJ0nRAwF1JYL7dN6M5ZAUM1
 WHic61kItc4OU1/VnTUzUoY/3drNs8tJodMHxfgYetztOFALUpLzDgxbKPwFZ8LY8Z1B
 BuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808544; x=1757413344;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jw/1eNJgIOcepbKCObytsQWFr5tm+skVjNTS9u7cY+4=;
 b=cmXw2q3O4jD24RRE7LJKaQ7rC2fEI9RuCHetS6EkIW49fR9h8eXJcUNdOkCh8yAUeE
 Iua0JPeQL6o3Rn7igWLSQILgwlCBTPcbVRPFyezhUHYwLCTL0Atv2r9pY1zpnWbWT0XC
 0ccEQiGC/wZqtg5JWKaaBb8vZBHOcbazng+MGge10iPmPAhp5z2R0gsa9EjrUwVHrwa9
 +ckvOgJPrxUz3lH//B5qzNWxtxcEFn3w/e/cCt+qddvQ9HkVy63uVVArQxOJQk6xIXGC
 rc5IAwdpsAO9dZWR/yOSCk9tqfc5i//H2RiIE6LUbzksLnS9Jq0fixZWlJ2ADMjCJ4cb
 dCuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFQu2GQlhpJSiQmYJf0cUvCHHpRAEplGrWOR8aT8eAv+ZjZwaA+PK83mCXIZBg6s+Fd10hGaWDw593@nongnu.org
X-Gm-Message-State: AOJu0YyLFMyZVkY5OPkg3Dr92rfAgFFQ5R5MQlImtmZ4jkpwVytZ6MFD
 YM4qnHA8ogGl6Ahn3A5CB69H0uJOySD3o39gyrRkrI7gaQQwQ9QF+cbrnODXaC3Hgiw=
X-Gm-Gg: ASbGncuJZ/gTtvJnsNLoWSVd1fJAS3wFJUjKcnBwQti2LYue6G4YaA8K5kfAeBvP+ch
 sgk624gxoGNODym7RHop5yrDrunIwzdcy9fJaE+UV9C8/+dKsf+Re61TObRcmCkNBuj9JL3SPCJ
 IioiJ1kRo+fMsag3BGP/5tQoQWbNbEshY2yW3IrNwY9c3gGw4/tqmDDBY18jkyri+vGguTO9g3x
 325M0ONGeC+xL0UDiLyr3uO9Ze5CZUkkHYEe5QT1aBUnpJvkgGW8+WFgYei2ckCVLUTuUYYRbTR
 Cti63qIGf2/fL4dnAx7AzP8cQsPX/qtlGwV6cYhXVQ2/Zi+/Ry4PkRk2Fla96ELVlns7B/yd2NT
 7RemBJYR5iqMQ4I6N9vhFLcDerkPdG1h+I1AUXh3SjBLEZhK3gwOcdFh8Kz+3KP2eBMt0hHlWgW
 BledT+wA==
X-Google-Smtp-Source: AGHT+IHO3rNvFzx4zkkfn6w7oI99x2Oe6RDZif7TY37w4X2aQYpGbtFQSgasYeC+SgfkBSG+P1D0Ug==
X-Received: by 2002:a05:6000:24c4:b0:3d5:787e:fd91 with SMTP id
 ffacd0b85a97d-3d5787f062emr5258636f8f.2.1756808544410; 
 Tue, 02 Sep 2025 03:22:24 -0700 (PDT)
Received: from [10.20.0.233] (151-0-205-164.ip282.fastwebnet.it.
 [151.0.205.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d21a80c723sm14162215f8f.9.2025.09.02.03.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:22:23 -0700 (PDT)
Message-ID: <1fb279c6-7512-4d95-9c0f-29d69d3564da@linaro.org>
Date: Tue, 2 Sep 2025 12:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] util: introduce common helper for error-report &
 log code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-10-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 8/29/25 04:03, Daniel P. Berrangé wrote:
> +enum QMessageContextFlags {
> +    QMESSAGE_CONTEXT_SKIP_MONITOR = (1 << 0),
> +};
> +
> +/*
> + * qmessage_context:
> + * @flags: the message formatting control flags
> + *
> + * Format a message prefix with the information
> + * previously selected by a call to
> + * qmessage_set_format.
> + *
> + * If @flags contains QMESSAGE_CONTEXT_SKIP_MONITOR
> + * an empty string will be returned if running in
> + * the context of a HMP command
> + *
> + * Returns: a formatted message prefix, or empty string;
> + * to be freed by the caller.
> + */
> +char *qmessage_context(int flags);

I don't like QMESSAGE_CONTEXT_SKIP_MONITOR.
It's just as easy to check monitor_cur in the single user and not call qmessage_context.

The comment is out-of-date, since you can now return NULL.
That said, I have a follow-up suggestion.


r~

