Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95588E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsogo-0004EB-VU; Wed, 18 Feb 2026 16:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsogg-00048b-72
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:02:24 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsoge-000244-Nz
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:02:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so2150855e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771448536; x=1772053336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ax0WZJhgm03egGi8O0uUj/31ocAxvK/Gf1NQcxRnj5w=;
 b=hxJ+MxeXwY28eh4v9KOGWrX1sSKZAqQ5ZwXa2Zb2n5O5N3fSOiZl2OaAbPXqfq0gnw
 2qOdCXKYXlsNcLTOxqQWcJM0vBtsnO1lP+DI26iDpHHUgsnlPnVz4LHwfVjLlNZEUhDt
 xttdiQseY6fvwUUotVDFXk37Czs+j95jkjM/WAZ4J3Z9uAfY4isdTw3sZnNnFhdFX9XT
 G9VIwJdqaIevx9oZNAjI2YZADptSKge3GNa7e3XFQcBBB9hx07QhRctIj+h7fV4CyJia
 9R2y/IbHusyIO2asoL+WYj1oSPOcgxnAiADCr2cs/ADBfZX5gaTik3CUyOBEwvSZZnM+
 ARAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771448536; x=1772053336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ax0WZJhgm03egGi8O0uUj/31ocAxvK/Gf1NQcxRnj5w=;
 b=TqwXVDqlibwdjqorBJK9WSn2WkNbDjFjVvhdh6jFkQwDs2SH8+6xTpEOQ3lgJCW6bk
 eOEPepSjBAorf1WD8zDDHvFdTFRu/HwK1MwhQilmLH5IuE26kdd/qnYKrRczPleOfT9X
 bZkxeeqCJuD8pXx0cQZ4zTpLhkqo/LJwOFzQosrR2Ka0Bj7iRXwWy4jEZCR5NhSRnEIM
 2xxOAfJJW+pI/PwWNXRlxT5zRpBi1Y1mMwndaPsnqHPQXvyWqnuX6YFCGvrkEPNXurwu
 MYFde0zOC2/3f+1IKQb0K15uRMQ5OrdTVr/HshAVdJ2FJpz/Fl5WKDzW6S9nzYDaOVto
 701A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAoDY2CsviSTYRJewID1GWsvd1ZgT6Y+x48JPIWVHEEloQqyzIYf3gkPE7N9ufcnqXDxpVqEbIY7j6@nongnu.org
X-Gm-Message-State: AOJu0YzASR0oB6kixvkvBaWUZHlc8TC14Rf7MLDXc93y2ZSB/VRwjxoh
 D7bmMgAWDARFFLCC6t/kpfp84VX41midghpX9zgb698sO6CunJy5hAzyhO3jZaOlnL4=
X-Gm-Gg: AZuq6aIErU8nCThJ+zLZUTx5HEAgLUoYZHXUHXgk2zA6DMdX2ibh2hsDspv52oq4NJt
 gUObVOmu+M2WLmGSWVZRDtdUSeUv0j8w4nQDVLIFUCK9tQVVGH67EF8mFntZxUOYJ74LI8dzUax
 HUNk07x6jXR7BmCIAF2jeWuzq3YzjHX+Wqjc5YKItIi0w2dUeXFHSvRCHiWZL8rfsYBBZqcnMrm
 4YlNPgsEZbFnB1jAtRE1kySMtKE2revvQjjm4Jc71RzSSiBYDyX59q5fkv8wzLDC9RhLXSJ/6zT
 fP5PGztTXjpkyp4gfThP7lz5YOK8U7OoHGUTthsvUyR55JDUXQOGUwAfnfGZ6WKBZepvpIYfGUf
 FqB6Kx6l/fH1SYob1FvqsQ5Hwr/0dxOm9iVTYM1XCdCs+K4HM+Bv+QtoNGNXy4UsR7SLlS2khcn
 cZhDLd6JWoEQjFdoyCz6+WVt4BK6rheNlAgcnmd5pB70Ra/ZZ5dmCcHIUFzXEHnp2J8A==
X-Received: by 2002:a05:600c:6814:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-48379c42d00mr250988325e9.36.1771448535624; 
 Wed, 18 Feb 2026 13:02:15 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837e565f5esm452032465e9.10.2026.02.18.13.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 13:02:15 -0800 (PST)
Message-ID: <0186402d-ae7b-48d6-a890-53762a617fe2@linaro.org>
Date: Wed, 18 Feb 2026 22:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/virtio: remove virtio_access_is_big_endian
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212234602.338131-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 13/2/26 00:46, Pierrick Bouvier wrote:
> Thanks to previous refactoring, we can see more easily it is strictly
> equivalent to always call virtio_vdev_is_big_endian.


> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 42 +++++++++----------------------
>   hw/virtio/virtio.c                |  4 +--
>   2 files changed, 14 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

