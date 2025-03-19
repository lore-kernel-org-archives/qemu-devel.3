Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C89C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tumvU-0007NI-EW; Wed, 19 Mar 2025 02:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tumvS-0007N6-0V
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:29:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tumvP-0006nF-9c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:29:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so105589955ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1742365744; x=1742970544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cBvWEyq0bkYy5IFnGn4qv0TF7AvwG0ucqEBtMwBnpE0=;
 b=DtcvdzvOnz1B5fTDuPWWX4VPfYyCxxP29lRbGpFCRJS5IF5IAh5x24HOzuiN2fftr1
 kP5BUUsI/GoNetHVxmrjrdrEH+lRp26LM1eAznd2Aql7RyU10baa4ZuO0srU6QYSS3nB
 zGqyny3uEyqFOOz6AoUaPgFzDB2AT0VUZjCTpsrr8SOOEy53ifA7A+EtA+RI9kzr6bl5
 Ps8AedJ8wdmSNTZ48v32+jrEVLJACxqxRaS8a7wly3pgWqF4eKA20YbEwNCBUweSKcad
 bZ+K8f70WKsDIzE3SSqqMjLMOsoFwyefUXrJiBQ6NFAFtVULrkVd/usZuo6sELEpRd5q
 qMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742365744; x=1742970544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cBvWEyq0bkYy5IFnGn4qv0TF7AvwG0ucqEBtMwBnpE0=;
 b=AuJsePT1SdplYgHA/jUK9lBkJMbvDfObUm/HjnacpCbEwlV9OxrRzzx+n2pQG0GTJ5
 jLEs5IiplBwCAzxZkm/CaBlijELbzxWP3NmJOAxClz7s6iAo3BlLog4HuckWSKlazMMS
 KKoUnH3cLuxM0Rh6AVODLRi/o9+t0EUwyQZ2ppWPZIcZ+um++8msSg0iu5f6dhNpwqAi
 YxAWmq0CXdkyfXGZiRZSbAhS9751vEjyB8w2DpPrqnjA49kmYA4CN87eQyvS7T9CfeBx
 WSBnUAPehkNchaAB5EFydZDb3Q/gbW/1U38B0ifCfFGYNR8GWeM2gsjVtpnoTQMfDAh5
 TAvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGhBiZ5XxrXqy12W/p/Sf01DBzpMjznZgiswOEdP42fJ5NOVyw9hdmA8ZTDjp53NDa3EuW2HtcU4LA@nongnu.org
X-Gm-Message-State: AOJu0YzFzy/44ZSJm46lSaNwuz+Fd9m73e/ep9e4uJVM9/JFCfMmr2al
 a1nR7B2GIPx8pVO8hem1De2Tmkg9LlzbAcbZIaXdN93CtSVCfGzDKpqPLtfL9pFM/Ys+wO4cA75
 1
X-Gm-Gg: ASbGncv1l0LnxNhZLRmA2WmQp8vqoZpVtTWAnMY5IfDiu5cvxGt00KUpxuC7mRUnt7k
 NASGmXlErcrQEUmAraDa9cv8GpNHdjmP8uZsiNv4Jnjz5sLm9cCKzU0GQKJmiVZhALPJclva7cJ
 0wvS6F8M7Nw/kU6p90vpSXuFsargd2pfUiW2UpURXatXMKeDZr5PulGrfA8OGBqpNuGBw+MYSdp
 mXRqiZAPVyP27uA3cT7oyNvj98TAxtSjE+oAPAonf3fKcJECz8XGv19l60L73lPTTd/c3A3fzbd
 t6TH/A3qdHZG/uuZRmjxZCWmgACepgpajIzC3LE5U8R3RaDxPw==
X-Google-Smtp-Source: AGHT+IFdm0t29nxe7OdX3S3Ntd2ijWIg7nVLjBkIr+Sok++zSanNwba8A4FgdfvcinrdOYWuUngUxw==
X-Received: by 2002:a05:6a00:298d:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-7376d6d1349mr2606961b3a.16.1742365743710; 
 Tue, 18 Mar 2025 23:29:03 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.9]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694430sm10673034b3a.122.2025.03.18.23.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 23:29:03 -0700 (PDT)
Message-ID: <cb712323-6511-4557-b5a5-0bc29a4dcb85@bytedance.com>
Date: Wed, 19 Mar 2025 14:29:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com
References: <20250312101131.1615777-1-armbru@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250312101131.1615777-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62f.google.com
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

LGTM, thanks!

Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 3/12/25 18:11, Markus Armbruster wrote:
> When cryptodev_lkcf_set_op_desc() fails, we report an error, but
> continue anyway.  This is wrong.  We then pass a non-null @local_error
> to various functions, which could easily fail error_setv()'s assertion
> on failure.
> 
> Fail the function instead.
> 
> When qcrypto_akcipher_new() fails, we fail the function without
> reporting the error.  This leaks the Error object.
> 
> Add the missing error reporting.  This also frees the Error object.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev-lkcf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 41cf24b737..352c3e8958 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -330,6 +330,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>               cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>                                          sizeof(op_desc), &local_error) != 0) {
>               error_report_err(local_error);
> +            status = -VIRTIO_CRYPTO_ERR;
> +            goto out;
>           } else {
>               key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>                                p8info, p8info_len, KCTL_KEY_RING);
> @@ -346,6 +348,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>                                           session->key, session->keylen,
>                                           &local_error);
>           if (!akcipher) {
> +            error_report_err(local_error);
>               status = -VIRTIO_CRYPTO_ERR;
>               goto out;
>           }


