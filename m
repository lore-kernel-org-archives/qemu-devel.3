Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1149BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBpR-0007aH-7v; Fri, 10 Jan 2025 05:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBpQ-0007a1-7g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:01:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBpO-0003hQ-CE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:01:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283dedso18534745e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736503276; x=1737108076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqNXwsBBjRVrnRTVKDJZnSkj54PnJGjlJvQf7Lwyxzo=;
 b=afAA1tOfZSpxrhlXF3Om2IFnqMIjRYi1mwMAhK51xm8OjNy9sl4aGXhgH0+ymQuk1+
 ivEGbI9Z63wPkeEE7GqLmhe2URFyUfJKST6vK9qZVWlR9wCi0ztKOwwQz4/L7C4DNkaV
 753S2Jm58+BOfzmEf/oYSnPYjyDWy624Kx3GNaTIx45b6xDHiF8RibHFm8b0smmXblNO
 Jrd8kzGSz5YK0jH4DWMjRoBPuxgEi7pYvax28IueUbs8UOUkLNGOVJo3HGOEmq48mCnL
 EoqCcnjm5wkwXFHyI7Px3f5UiFkjhGFxN2SDgQ5P4d9B3gStV9UE/tEJXHn3hDBliIa2
 +Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736503276; x=1737108076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqNXwsBBjRVrnRTVKDJZnSkj54PnJGjlJvQf7Lwyxzo=;
 b=a8Vs/aLK8EtNzvSRS0UuK6kUFeWEjGlgL+uFRcF7N7nucrOoruRgJc2ccbNd+0xpMw
 QVHlevkVj7WN6aYYS4cNvrCGHmwcvSyPpU0/9HaO9g32v8EFBjKI+SiU8GGkyg+SA2Sx
 /VZvLfK5Xl+wHKqV8XG0yqxtBdrov8gMY8jQ8iJklAJM16lpBUy3u3D8m2rLXDMi8vhG
 6rohMo6SUH0JRODPMiySb3Ka7+tudhWgWMG1ue8t2Jx4QY3TIDkXtP4mcOkkPyFNm4q4
 ULJ10pBBOpQ2+by5yb0FEacHD+a7ds5OwNFiBxKjjN/jYqgrleZYUxHcQjXMQbIJFKwq
 UzPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsC9M4OKKgh8YD4OF9GWTKMB/vSnxAhosJJDJ0AGlel4hTgUv5yR3SvNzjy320O4YjAtZj9GyKQ0cH@nongnu.org
X-Gm-Message-State: AOJu0YzwAK9lKA8vaOu/F3zJWnPVaLEZXToYfViQUQwPSAkwhbrJWpkn
 /JiRh0l8kHG/OuZM8m7gcxnhk1P5ppoHibPvrd7LclMQcxCAk0cnjk3V3Z97xAU=
X-Gm-Gg: ASbGncuTNz6moDKg0y1vLGh5lvAXraCCa6P/AI/mcbuX3l2CzJwR13fUQZrpCZpPqKY
 B2l9mGG92DXM5u6lL8kGzyZmUFmlaBZlk9zfv9OaXohu9EAyzdh+3KzsV51+CpZSLpYzFdOYfD6
 hGWJjBKpuinM+Kheuk4dMCESt+VF/pXwAD4T8RVahHD4BDiApMuVgLewEHzcP9UeFL0IOFIeVTq
 mJV2WCyQUmJiB88RwyJDlOXm/g7icRziTWO26LD5HOt6UVe8wo13WBSTwQVCTS95ueljJUFXVw6
 92Ji+Yp4RDQ2/Artnooryg==
X-Google-Smtp-Source: AGHT+IHXWN9Z9dykOvTV6ouEKFxaJmZvNZaGQ9zNkagbHLSAGDh3mtW0ErVxn4BZFrdXHOgFsXu8Zg==
X-Received: by 2002:a05:6000:481e:b0:386:37af:dd9a with SMTP id
 ffacd0b85a97d-38a872f534dmr9374207f8f.35.1736503276359; 
 Fri, 10 Jan 2025 02:01:16 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc895esm46937395e9.13.2025.01.10.02.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 02:01:15 -0800 (PST)
Message-ID: <f4438a42-d8d8-4a46-b89e-d7858da35db5@linaro.org>
Date: Fri, 10 Jan 2025 11:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/xen: Add xs_node_read() helper function
To: Roger Pau Monne <roger.pau@citrix.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20250110093531.23221-1-roger.pau@citrix.com>
 <20250110093531.23221-2-roger.pau@citrix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110093531.23221-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/1/25 10:35, Roger Pau Monne wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This returns the full contents of the node, having created the node path
> from the printf-style format string provided in its arguments.
> 
> This will save various callers from having to do so for themselves (and
> from using xs_node_scanf() with the non-portable %ms format string.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> [remove double newline and constify trace parameters]
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony@xenproject.org>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>   hw/xen/trace-events             |  1 +
>   hw/xen/xen-bus-helper.c         | 22 ++++++++++++++++++++++
>   include/hw/xen/xen-bus-helper.h |  4 ++++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> index a07fe41c6d3b..461dee7b239f 100644
> --- a/hw/xen/trace-events
> +++ b/hw/xen/trace-events
> @@ -39,6 +39,7 @@ xs_node_create(const char *node) "%s"
>   xs_node_destroy(const char *node) "%s"
>   xs_node_vprintf(char *path, char *value) "%s %s"
>   xs_node_vscanf(char *path, char *value) "%s %s"
> +xs_node_read(const char *path, const char *value) "%s %s"
>   xs_node_watch(char *path) "%s"
>   xs_node_unwatch(char *path) "%s"
>   
> diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> index b2b2cc9c5d5e..0fba7946c55e 100644
> --- a/hw/xen/xen-bus-helper.c
> +++ b/hw/xen/xen-bus-helper.c
> @@ -142,6 +142,28 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
>       return rc;
>   }
>   
> +char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
> +                   unsigned int *len, Error **errp,
> +                   const char *node_fmt, ...)
> +{
> +    char *path, *value;

Alternatively use g_autofree.

> +    va_list ap;
> +
> +    va_start(ap, node_fmt);
> +    path = g_strdup_vprintf(node_fmt, ap);
> +    va_end(ap);
> +
> +    value = qemu_xen_xs_read(h, tid, path, len);
> +    trace_xs_node_read(path, value);
> +    if (!value) {
> +        error_setg_errno(errp, errno, "failed to read from '%s'", path);
> +    }
> +
> +    g_free(path);
> +
> +    return value;
> +}
> +
>   struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,
>                                       const char *key, xs_watch_fn fn,
>                                       void *opaque, Error **errp)
> diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
> index d8dcc2f0107d..6478d25be5e6 100644
> --- a/include/hw/xen/xen-bus-helper.h
> +++ b/include/hw/xen/xen-bus-helper.h
> @@ -37,6 +37,10 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
>                     const char *node, const char *key, Error **errp,
>                     const char *fmt, ...)
>       G_GNUC_SCANF(6, 7);

While I suppose the same comment still applies here ("/* Read from
node/key unless node is empty, in which case read from key */"), it
would be nice to precise the returned value.

> +char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
> +                   unsigned int *len, Error **errp,
> +                   const char *node_fmt, ...)
> +    G_GNUC_PRINTF(5, 6);
>   
>   /* Watch node/key unless node is empty, in which case watch key */
>   struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,

Mostly nitpicking, otherwise patch LGTM.

