Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FFBCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76eB-0007gC-DI; Fri, 10 Oct 2025 02:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v76e6-0007eJ-AR
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v76e0-0004yD-WA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760077820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dQ44zPR7lzFQ8ZMHUR6r1NQezEPL1ak9Ksbq/ruhtWg=;
 b=LB9TyOLTckxswWaRkPhxmyIgdBe22RGJGprotZYwfYQNZ+b7J0TcD4aJt9UCfQXJ76tqjW
 s9nn8bZ+FddNTCtbn5QKbRfOeGpgkoipYp9z0EA0yk5BBE6QWPnytH7gNb1H+pzw4aOM/5
 tI9UOSBc5+74VU8x2b2b5AN8MflQozE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-j8WYmz6aMSiXbzfmYexwjw-1; Fri, 10 Oct 2025 02:30:18 -0400
X-MC-Unique: j8WYmz6aMSiXbzfmYexwjw-1
X-Mimecast-MFC-AGG-ID: j8WYmz6aMSiXbzfmYexwjw_1760077817
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2f989de76eso324964766b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077817; x=1760682617;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQ44zPR7lzFQ8ZMHUR6r1NQezEPL1ak9Ksbq/ruhtWg=;
 b=FPEIrCFSlXJTQRKAJKN+U8kHGA/uENkSf7zn81fXH8d3vT2ZxMoQGCt6zKamdtqIgW
 WI9idYgxU1kqydkAgR14JD+pboizuYjLqTL3UykcpVnsgvXz8qNMFWegDvZURg7nhaie
 ser7xV9nltYu15M7b6irvMJki/cFE35p4V1cdHs1/1SyKFBadsl/G+7jnUy1PwT2rAT5
 7fA8Z4IyWGJJJoycS3eyp0UREAUyPP7SBy71m2dehOjP4guL+l8NnOoJ5TapaHlOhoSP
 t+LHjL84rt7W3uu5y9jzk5hFGoJhWr1jJzmUbUlyx3iedLTiExrTP5saiI9LUO38L1Dx
 L/Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQOUWpRh0gf4lCE4Bi2N+MmPIviqcIwjlTBaDkOiCMhw1Md4w1xMa2IFQw3OYnUvyh+7Kz4TnJj7mq@nongnu.org
X-Gm-Message-State: AOJu0Yw82SpzlwnPWYEWrj+1csYhYd2z9mCZ8C6XOQj3p3A/7iS1oWsL
 laQ+VJ4QpXjn0qiXpFT4ZW+ZE87yUtjQ1nRbHJ8TcI3fGJ57SooudzceMpeTlWcqWYO+cH/sqwh
 3KRJlffFVZUq+O5DKcqsrMUYqJ2Mv1JOQvSLPVSGjJp7siGL3Nh5wpvnv
X-Gm-Gg: ASbGnctLz1OwO5FIvuHU04T6QRo9UhtTa63sbaWxRxuUaAIvEt11f733zL1kXuxy50o
 z3NXoQeZum53r9thh3pLSZ3JJcmwvp2YVgoRDQVig7vR5x/LwrkH6H4+/K6qF73ifSOGbZL2w5U
 pQ09gppgUUonSSlybWSLDqtAi+FgwlSyRwCgSecsz0LvrBFneEI35nJmjG00nPc7NtkWEl4ONrz
 6lSFPd9RrvFLIj1n7uAoDDrWgNpWZr04gIu2ThQ4bXMoUpZqQEV0l+C9vq6Aq+XgtL2EQ60pPPh
 Y7I40nxinTFyJYmQU5qkc64Evq4f4DQoE1q1Lcio6iGVtYhhd8QrpIQ3hSY+a3gq2MkUb8cv4Lu
 a/PnR
X-Received: by 2002:a17:907:3f95:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b50bf7f13d2mr1321933866b.31.1760077817004; 
 Thu, 09 Oct 2025 23:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1w+s9da7sFYt1X3HT/5+HKfb0DYyObittaXHNnzF9FQCMuSfmrBmYYlMBFS4I27O+tWuvRw==
X-Received: by 2002:a17:907:3f95:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b50bf7f13d2mr1321931966b.31.1760077816620; 
 Thu, 09 Oct 2025 23:30:16 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d61cbcb9sm155315366b.20.2025.10.09.23.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 23:30:16 -0700 (PDT)
Message-ID: <d17e5041-198e-4a5a-a5a4-6ea226c6ea81@redhat.com>
Date: Fri, 10 Oct 2025 08:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 viktor.prutyanov@phystech.edu, hreitz@redhat.com, kwolf@redhat.com,
 maochenxi@bosc.ac.cn, berrange@redhat.com, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251009141026.4042021-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/10/2025 16.08, Richard W.M. Jones wrote:
> curl_easy_setopt takes a variable argument that depends on what
> CURLOPT you are setting.  Some require a long constant.  Passing a
> plain int constant is potentially wrong on some platforms.
> 
> With warnings enabled, multiple warnings like this were printed:
> 
> ../block/curl.c: In function ‘curl_init_state’:
> ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
>        |             ^
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   block/curl.c               | 10 +++++-----
>   contrib/elf2dmp/download.c |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)

Thanks, this seems to fix the broken freebsd job in our gitlab CI!

Reviewed-by: Thomas Huth <thuth@redhat.com>


