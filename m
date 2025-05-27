Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65ADC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJodd-0000Lm-PO; Tue, 27 May 2025 03:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJodb-0000Ld-AF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:22:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJodX-0004wa-J0
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:22:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso32140015e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748330528; x=1748935328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JmuEUmzHdfHVsWs2Fnb68DnEH/4Pyo0nzrEYHMsAIEA=;
 b=ojygOE5P3TBhklD3zuf0peLhF8Id8+oH/tp8cGV9tK6ZnWLwWIHhAlkdePLqwaqGIj
 moXaDmj8NFlnoaFyQZsdJKJ/4wpeXFiMwwuz2/TjlN9xUYLKPoVtzQ50eVy2WHJxxHxc
 VIykoedETjTiGZz1cMQYPBKzNqZSam6uxFhKaDklvGCzMwfn9UFztmyex6Xx0KPmGUk3
 dtrJ3k/9mWHnLUpAcauG+ix+QMWHLQGvKU+5oE1rkzBU9QcXr1oqtnceRj0ERgWzL7E0
 pvAP5KwrAmNLe+DpZlpi3d5cTf60eCpu4whFQwYN6fQXvPsQTQjLocxRBc2x2u+4DVSN
 rdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748330528; x=1748935328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JmuEUmzHdfHVsWs2Fnb68DnEH/4Pyo0nzrEYHMsAIEA=;
 b=WUGIkcyL+nyWHvnycX0Hh1DWsHvz+cjB/Cok4xGFvT5lMtIPvHrtKoYaN8pbwTWPg2
 N1WCaPtOXX95WanbGaGdvgAe991s6rwl/UPL7gWnhjA7c/0o3ejn0kkKLZcvTs56UEbe
 5JreynT88TAhnVoZ7bTNOMLZAAUh2oMjDyTNUjiJM9g9kjtTKsv5jBT/UuI6of52VMMV
 bn74A7wDXMQpzg4eK7yXpat2vrpup2jnww0zsdeVR89GPigSog/8hoGFmUp0pX0gUklz
 Sx1popdmlFg0Wr3wF0pntOQO6FJ1ZqxwQQPHH5JoUSm3j1O+I/KmBG5bkv594ynCai6S
 yIEg==
X-Gm-Message-State: AOJu0YzYb1YN6ZT6et9B1UJ9LCWtSpfiEjVOQO2rrMUiged1lHYy+iFy
 Rp9r19eBp9xs3n7oTV5KUV9Kur8xbPz/RlNNQVLvuV/SIx1wMqm9y1nhx2etWa8oWaHHm719pxP
 p/YAF0/n94A==
X-Gm-Gg: ASbGncvO6/ySc8xAAjEMYsLwa7B+KkP2/qj563Jg7B1qrqML3Gf0fNyBfO7ZTN09paD
 B8xsDqx3Pj+Ot18VObL2b1P+ze62GdQQi6wWlV9IPsOYMTQgjnLvOaC+lEupTFnjQbnKmbNuOhZ
 hE59ca+mTe2O2+PgzblxA7ehd5XQUht2esruKEgSnkwivmqh+zO6e/XlVfinjQBy5kyCLusZFK5
 ZIipPSZf0H9UiCpzMPEG7xXBqyBJ24Ncw8Pbcpbkxrc1KZY7E3XQ0rPBjeWVKUCxrHHX+Iv3mnB
 v/3ICXEp1JHR3b2IjW3UlWMv0im6HiItCe14DotNNeuRemGpQpFta6q0PqIfZLnh1g==
X-Google-Smtp-Source: AGHT+IEeiayBOKuHvaDqtMtsVi3bRNyOlTPMhVngFSfbxjY4c3rQHeSLiIyB4QsXLQIaY/ckpf3biw==
X-Received: by 2002:a05:600c:37c4:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-44c92d351e0mr91509935e9.24.1748330527952; 
 Tue, 27 May 2025 00:22:07 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29672sm271338315e9.3.2025.05.27.00.22.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 00:22:07 -0700 (PDT)
Message-ID: <a5ca62bb-9cfd-4ae4-be96-58e43bb53fe1@linaro.org>
Date: Tue, 27 May 2025 08:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Fix trace_xs_node_read() params
To: qemu-devel@nongnu.org
References: <20250523160134.218997-1-liam.merwick@oracle.com>
 <3a7386f9-a4ba-4268-a3fe-45c18360d878@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3a7386f9-a4ba-4268-a3fe-45c18360d878@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/26/25 19:10, Philippe Mathieu-Daudé wrote:
> Alternatively, since this is an error path:
> 
> -- >8 --
> diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> index 288fad422be..1e49e60e147 100644
> --- a/hw/xen/xen-bus-helper.c
> +++ b/hw/xen/xen-bus-helper.c
> @@ -143,7 +143,8 @@ char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
>                      unsigned int *len, Error **errp,
>                      const char *path_fmt, ...)
>   {
> -    char *path, *value;
> +    g_autofree char *value;
> +    char *path;
>       va_list ap;
> 
>       va_start(ap, path_fmt);
> @@ -151,12 +152,11 @@ char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
>       va_end(ap);
> 
>       value = qemu_xen_xs_read(h, tid, path, len);
> -    trace_xs_node_read(path, value);
>       if (!value) {
>           error_setg_errno(errp, errno, "failed to read from '%s'", path);
> +        return NULL;
>       }

Auto-free variables must be initialized.


r~

