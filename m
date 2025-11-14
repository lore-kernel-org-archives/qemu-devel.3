Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3378BCE7AEF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJuri-00068q-10; Fri, 14 Nov 2025 09:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vJuqK-0005O7-Mu
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 09:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vJuqI-0002yS-V4
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 09:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763130721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PaQvRhwpu1lql8dAu63K6E3PuoqaQVCtwZhlrw9ThqI=;
 b=OPCM0bUQVmBnIe8g+Y9BszLH9bpecs/WeS/amoQDUeD4j3SAqYOjSqw24/gn1Jh79HZkl/
 0gwDzebx+OaoOm1IFo/kBuAkxnb2VG+OvNd5E81l1hPXjFHaTdMzeRAmr+Le9YONweScuy
 h5eV6KDC83ximA/DixtYoI40YF5W1mA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-FbE0RySHOSmJUnpGaZ9egw-1; Fri, 14 Nov 2025 09:30:11 -0500
X-MC-Unique: FbE0RySHOSmJUnpGaZ9egw-1
X-Mimecast-MFC-AGG-ID: FbE0RySHOSmJUnpGaZ9egw_1763130610
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471201dc0e9so14331815e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 06:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763130610; x=1763735410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PaQvRhwpu1lql8dAu63K6E3PuoqaQVCtwZhlrw9ThqI=;
 b=GdykDWh3iYunfdVa6MgmerOTIy/j4Nf1Ad7Fv46egM4KnC07IogKCkjxZIjx7kg77L
 c8fnZO1LF63xayjXUiskOoaTYUUibmTZf3bJPD3MGph3qkQn7nwFYXVB8vvBnob3gBZU
 4NS1c5IpbpX2Rl9ZND73+rWO4/KBHX6tnral6FQhyEZ/J1WxzGN43aOp0uje2TD7ZA94
 nJtexobs+xMmLBo+9GaPWeM3M159b+ubGa4HiNUa4wVC/aahObqcirwuLYRUoU5DpUUE
 bDm+gWbigOMQQouhe9jdfPJPrehPhlE0/j0nT4f/DxE1dYyFmT/KJDmtwKUu7LOw46XI
 IWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130610; x=1763735410;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaQvRhwpu1lql8dAu63K6E3PuoqaQVCtwZhlrw9ThqI=;
 b=GweVoBxE9aTlNg+q6A9b6v5F6yRUXNYoIqxqsJXoOhKEC+mNox6veVEiQijK/Q7x8W
 wXq+MT1FJiMRcgIC7bcw6zNIjglgNEzDAjwgC1iR17lW0c+zs5bX5+d+7Lw+I431+j+A
 cIi+Weu69mLvw5Hs5cjEGvg/2VSM9WdyXA6P5rtZK2o7/ajx3g1aeKhJtAmBBXfQpmK4
 kFwxBiroIa4aHrgm0sCKXyL0yvoi2q2CV6zDKTvusfrGjJ17At5ejj0cfjBzB6Wuisrk
 H3WU1kVn6KCRR084eLjv2SUySmlLw9v41c3dZ9nYaZlHg7V9z+UfwfWRh6bMrJ4wkWTD
 5eLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs7Jvo1QnRSWll3+gNNS9192OB4MjWtbFAqldE7VMCuM7t5h7MpUoEh+F7J/hoVlcGgZXv6zn/EM1G@nongnu.org
X-Gm-Message-State: AOJu0YzIaLu84qeC3y4/mT8o0dqYeAWV/x/6r78gcCTXhAmbjnJC5GB7
 ZbH9V+VEu/4M+GlOIy66+lkZY7rHpV3qDU/K94uWGZWeEVIYSHPRIcWhf19suY3l9T2Wj+hnkgZ
 Q7OhYkCgSuwzVhR/IlZvp0Qt+bmg+mDh3JVZ0odYKPfCAEzVHn6/V27TX
X-Gm-Gg: ASbGnctX6CJL9ls/Ozh33JPgrt0xrMn8a/cUl1W8wb25VCtE2GDLCVG4vi9XBtLJy7w
 lm6FLrr+bcMs/eKTTjWv6OJe0GPels2sbqyGPm9sJAh+DRQzeuhw60JH0J/EKyTYB+QIm2Fvo5Z
 BJ/yio4tZRfRRO9txUZgYiA9wqFw4MU9qBKtfThUv+FcFbW3dGfP1TOFIFzPbmO7OwNk/Lny8Bx
 0sr5oMcXH7CwwhkD/bMA6ojcK7xWsCzcmifz1m3+iQ8qpYEgmWZqHFD7F+gYP96QD/YDJDntCqp
 pTQkPM/6BNm4WOpPl03FtizKT1wskvdZWUYbI1K2aaQc7ufcolDtBQJcVutqs2PeqE11pKqVZfd
 yHL9gAE0AOG/h29/t2uUeBJJUOBBDr+zEFgVdI5MUgfezp7MY
X-Received: by 2002:a05:600c:1c1a:b0:477:7a62:9e5e with SMTP id
 5b1f17b1804b1-4778fea6d05mr36218305e9.29.1763130610063; 
 Fri, 14 Nov 2025 06:30:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdPD4rYkSl7iYmrmAK2dAxaUolXoWNerm0Q1nUd6K34tj0pQYsU60rYye8KazzlzpKwB6J3w==
X-Received: by 2002:a05:600c:1c1a:b0:477:7a62:9e5e with SMTP id
 5b1f17b1804b1-4778fea6d05mr36217975e9.29.1763130609657; 
 Fri, 14 Nov 2025 06:30:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f174afsm10044983f8f.33.2025.11.14.06.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 06:30:09 -0800 (PST)
Message-ID: <90845f42-5a44-4d0c-8a4c-e9caec6b0641@redhat.com>
Date: Fri, 14 Nov 2025 15:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251107174306.1408139-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20251107174306.1408139-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/7/25 18:43, Peter Maydell wrote:
> In the qtest_event() QEMUChrEvent handler, we create a timer
> and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
> log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
> can send us more than one CHR_EVENT_CLOSED if we're reading from
> a file chardev:
>   * the first one happens when we read the last data from the file
>   * the second one happens when the user hits ^C to exit QEMU
>     and the chardev is finalized: char_fd_finalize()
> 
> This causes us to call g_timer_elapsed() with a NULL timer
> (which glib complains about) and print an extra CLOSED log line
> with a zero timestamp:
> 
> [I +0.063829] CLOSED
> qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
> [I +0.000000] CLOSED
> 
> Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
> processed one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/qtest.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/system/qtest.c b/system/qtest.c
> index baef06d4d1b..67e2385f4b0 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -815,6 +815,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
>           }
>           break;
>       case CHR_EVENT_CLOSED:
> +        if (!qtest_opened) {
> +            /* Ignore CLOSED events if we have already closed the log */
> +            break;
> +        }
>           qtest_opened = false;
>           if (qtest_log_fp) {
>               fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


