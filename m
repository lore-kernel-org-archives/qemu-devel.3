Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94A9C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlipU-0002t7-8r; Mon, 20 Jul 2026 03:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlipT-0002sy-7J
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlipR-0006R3-EJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=72LgIGz5p2bwvLqG6dmw1qKf1cAUcPzxiaTAyTgnJSQ=;
 b=F7F1yoaTfgbRAM1deAId3TyLKqEZMfqW45EK0Xxj5HLqzM1Bi+5S4KsWCaP20KkJoJyzS/
 tdPkDEI9i8DsJ8RvkEfXHAn0OhVUtfRd7QBWUq3iSIwZOug+TvOcsfJC7cmQVm3Nd9VoY6
 WO2SXaGlSMj28mWlmkDgO5kY0ngycss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-keecBrtVOOiHYmtgoE-NlA-1; Mon, 20 Jul 2026 03:54:18 -0400
X-MC-Unique: keecBrtVOOiHYmtgoE-NlA-1
X-Mimecast-MFC-AGG-ID: keecBrtVOOiHYmtgoE-NlA_1784534057
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955ce558d8so8321145e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784534057; x=1785138857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=72LgIGz5p2bwvLqG6dmw1qKf1cAUcPzxiaTAyTgnJSQ=;
 b=oZ5Vr7MszVnpYTXQGicXuZZOB6OuAqeOtuvMd55pXAQcBRfU3cUjd12vrlOI/hIX1g
 dBwTc6KHJQrK9UCW2iv+17hhp4vIMzVU5VIoTBQFKTcxdxUydsE0EoJOE2qzvPCBH7Gk
 P+Iwy7XD2kLWbizzcKkFvfGE2YFHD8TrQHDsMU61ShPc+rw7eoZ16ILY1m8yxWguAHCp
 oAfHXnEY6cZ2mw2jGxdqoGwJqw6WXrmVzB3z7jBlwUO7dD8X+2IdCMjBqMszVuY0NY+/
 y5PBZfNkTZIstTAWI92wN4JT9b9oLcsg4hE2a/lyjBZn3qEhqPrVusomzMZgZU0inE0/
 KHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534057; x=1785138857;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=72LgIGz5p2bwvLqG6dmw1qKf1cAUcPzxiaTAyTgnJSQ=;
 b=Gh6AWlsUabj5RpnoHpwyJjehnQ4cvEUUcCrbU1+3WrsrjBeJErBr8mXmmxYoR1fytl
 s3XwZQ5gj3FuuajNScpK4JNY1cNpRZFQUlgvpwpB9Fl3AV2t0r6UiirKmwcqTgl98y7S
 /9enxzbsRxoOjpYlQanqnd9ocBYK3PgeQ5SGQD/otxJu4BYB48UQK+s3gCYqZXSzFwk7
 QLM6jJMUywPoEhhTVGsVOWHYX5LnLVoNSM7jtZdA7f6zb7cpQ0naFMlHZ4LsfI/OkUP5
 6ILYxHaTW1BcEeGtd89opV/BYmGzHOYeUmFhbGeTmbACDEOO5ik+A8T7+bf+Wtifh9ub
 vjuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAxMNxOf0zYzVDc6fCKFylknuZ0DV0BscBj5/MHCU7KuQuwpFbZSdS9pdTXv9NGhouPnSJD71qE4WQ@nongnu.org
X-Gm-Message-State: AOJu0YzzrwuNbYtlnJlzEovDkn/PM2PCuAoVWOeUGN0iUT7I3E2F62nR
 SZwwaGQ/XAiYDoUh4eTnl18NVtypkWuazVBACgZEvCOyyUdSbNm2ntbPWmDduKPcRb6tQZBNd72
 21K0zCFpx5YtsUSe6EzG7d0a/LcjWM2wzMtDs+7JZYApbvYoG1w3xq5nD
X-Gm-Gg: AfdE7ckKgL0KveZwCffuxVv4mlJMr0qF4Zg7rVTG8qcWIAjbDheQbJm8kdUEd2+c3OE
 kRYORlIBYjZ9nJtCSwFc223RzPqgxoczvia7taxTgCEy4PdE+Kv1EcUtN3/wyiM9SLGHd1kKorc
 N7ajaT5ongW/sfiop4xoCiHirPvA/3aNnYLprW4D8jirmHY6XzsemAqAKj1wsLP9Tzrn/Ww4FoN
 jG2wOEJG98/BNxkL/l8eqMRT07QkdG+ubHJp4EH+iwv6JUXohqaFtZpVClBk5jDCNFP/4thpDgN
 f6A/sWT9RP6jXmUSoUKAOqwdSME2EnFoA6ol4AEiumdehkHagSQiE0Fd8JKsHKXQmsFHXEC7cw=
 =
X-Received: by 2002:a7b:c055:0:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4954a516ae6mr90938245e9.37.1784534057448; 
 Mon, 20 Jul 2026 00:54:17 -0700 (PDT)
X-Received: by 2002:a7b:c055:0:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4954a516ae6mr90938035e9.37.1784534057065; 
 Mon, 20 Jul 2026 00:54:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm269916095e9.3.2026.07.20.00.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:54:16 -0700 (PDT)
Message-ID: <483f9f02-a03a-4ba3-8442-934023561c59@redhat.com>
Date: Mon, 20 Jul 2026 09:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vhost-user-gpu: validate message payload sizes
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260713125130.101787-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260713125130.101787-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/07/2026 14.51, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> A malicious or buggy vhost-user-gpu backend can send messages with
> undersized payloads, leading to out-of-bounds reads when the handler
> accesses struct fields beyond the allocated buffer. However,
> vhost-user-gpu is considered trusted by QEMU by design (it has access to
> shared memory etc).
> 
> Add a centralized minimum payload size check in vhost_user_gpu_chr_read()
> that rejects messages before dispatch, and a per-pixel bounds check in
> the VHOST_USER_GPU_UPDATE handler to ensure the variable-length data
> covers the declared width x height.
> 
> Fixes: 267f66465 ("hw/display: add vhost-user-vga & gpu-pci")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3866
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


