Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEEECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYQX-0001Yj-K5; Fri, 19 Sep 2025 06:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYQW-0001XW-6K
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYQR-0008OP-JP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758277987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AKUzlIa57qeDstT/csSjTuWpcmj9ekBLUlNiavNOXS4=;
 b=KMwDTIV5rdIb3S6jQej/r+lzB8VMmMmnuoNTt3XbiAJW2WaeRYNXuffb9tUSC1lZDCuTov
 219nAqgyPJVxspYuRm2YwfS0JCmMb7MNYU9B37RQswbvk98J4ianp9J2dNwsMxI5IIVU0m
 5Xniefqf4GNa9e+WURPRKIjsQhbZ9s4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-_GYYEA9BMHSOgx6WeOf4KQ-1; Fri, 19 Sep 2025 06:33:06 -0400
X-MC-Unique: _GYYEA9BMHSOgx6WeOf4KQ-1
X-Mimecast-MFC-AGG-ID: _GYYEA9BMHSOgx6WeOf4KQ_1758277985
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-62f9cfb8075so2193580a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758277985; x=1758882785;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKUzlIa57qeDstT/csSjTuWpcmj9ekBLUlNiavNOXS4=;
 b=IirP2u+uXZt+EXoT5ixkcDxwUjhyQx0NoFTc0hsuluJzFXBLMmoiYF47paTAVy/mVE
 g8RgSc6tWf59GAssAGOU9x9KPrRERhZypc0a0PQp6xQZefmecgdDhxJkxNnYgUMaGyXo
 ZhjqkXOEqg4MtEzCkDvkOSduaoK8JrsOPI/N806gwxX7E1tdTNH6P1A0miK5g6xdacsj
 0hNef4xasXIsIKAReghh0mrjjKj6aqHdGPYhuusrQE9U+v4Auzfq+pDcxMVy2ujAgg/y
 9E7m8OJP1NwRWYp++jJ8rmeJSGiMGtQWwRPxbPzJZ/we/NTfkZqthQQ9GcvzczL1LH1r
 ZxjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9v1oBeytmPdFaZ41yXfJCe0jXpu4BPRXOe/LnE5jPHiGe9wic3w3CvVKiGgl+ZdhSVUhixAY73XTF@nongnu.org
X-Gm-Message-State: AOJu0YzAoVgP/eWlrxf4JleHJAMy2rO5BRaEs1DnHUErOPPFCFwdUHc4
 kGOpHICQbuoJ6LyLzU7saVpLE75CTRHLXOfsGC9+mmP64nSTDDQ8qzePhxoMiNAGedppapELEkd
 T6Aw3P/B8P2KBKSRuYXEKjuwF5ip+RgMYO7PWdFnO9/I2WBpraYt9o++x
X-Gm-Gg: ASbGnctD6mhRQw2FrZxrXB1oZmHYNRTvz/HBQGpVC/ziqGsp9ESj8BhldPi5ONLQLKl
 C7NLk/w7y4IHlxK1RZc5/diF4l3hwjTemLzVNP/+8MUiyjDWNc7YjEOb1wEaSz+KdnhtHfAHrVG
 bah/+pP9EmcvEkofphz307uAKpQBjTbzZkkf37+Xvuh3ZiZXmImRki7sIFKEe6JiI7007m+voGp
 Zd3xcLJzAJK7Nf6OiE74Fb3/j345MuMoiQ+V4vrtpS5hE2GFmPNN9sG+cxDMNjWnsmhNEni+pFr
 J0/LAU0MOVfOG6Fy+FA+YfEnLm/VQQ2kv+W9qyhChWARU3MvqyaeEeZoAqMk9i9TACBwW8688Mn
 CeWVbF/C5aCridKOar8s9M+nsYvxK15aEBnS1nStGWMABZf3pHdHN/ruRS5Djks2wFr0jt9Vvk+
 FQA/PA
X-Received: by 2002:a17:907:3d8d:b0:b04:3302:d7a8 with SMTP id
 a640c23a62f3a-b24f50aabb5mr288337866b.58.1758277984908; 
 Fri, 19 Sep 2025 03:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaLIJnncF813UZ3nZgDTi72CjL3rWZ7m1OV+mOcZdfqsdzYqS7l1/yoCD0KXrU7uo1TMW5mQ==
X-Received: by 2002:a17:907:3d8d:b0:b04:3302:d7a8 with SMTP id
 a640c23a62f3a-b24f50aabb5mr288335666b.58.1758277984512; 
 Fri, 19 Sep 2025 03:33:04 -0700 (PDT)
Received: from [10.108.146.123] (93-45-222-212.ip104.fastwebnet.it.
 [93.45.222.212]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b1fd271f895sm400414666b.97.2025.09.19.03.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 03:33:03 -0700 (PDT)
Message-ID: <230e44a6-8e8f-4ff8-99a3-7e1438dc84ee@redhat.com>
Date: Fri, 19 Sep 2025 12:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: use ERRP_GUARD in user_creatable_complete
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250919101504.1503735-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250919101504.1503735-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/19/25 12:15, Daniel P. Berrangé wrote:
> With error_propagate, the stack trace from any error_abort/fatal
> usage will start from the error_propagate() call, which is largely
> useless. Using ERRP_GUARD ensures the stack trace starts from
> the origin that reported the error.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qom/object_interfaces.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 1ffea1a728..415cbee8c5 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -24,13 +24,12 @@
>   bool user_creatable_complete(UserCreatable *uc, Error **errp)
>   {
>       UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
> -    Error *err = NULL;
> +    ERRP_GUARD();
>   
>       if (ucc->complete) {
> -        ucc->complete(uc, &err);
> -        error_propagate(errp, err);
> +        ucc->complete(uc, errp);
>       }
> -    return !err;
> +    return !*errp;
>   }
>   
>   bool user_creatable_can_be_deleted(UserCreatable *uc)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


