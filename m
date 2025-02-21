Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7CFC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWVq-0008PA-8a; Fri, 21 Feb 2025 12:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWVk-0008Od-4Y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWVi-0002OP-GI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Puo49MYq2vFwIUP57UvTgwp6rYtElwpOxt8s83r61Xk=;
 b=E/lk0SwB+Wtrid559Onyag/xhEeZLfaQVIwJdegU74zPNLvnfIBK9x6CUV7yjhCPSqfwoT
 keQQc8ktSXpgQBQ3o5v8B/GDcr9DEl9/qjYpy6VMxAW71Oj96tx1vWbdFnilppDPQ+L5Gk
 h2303XQoUOBHz49Iue4eh80I7GdrIi8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-numntcX0P8CQjyBPg0d5uA-1; Fri, 21 Feb 2025 12:08:18 -0500
X-MC-Unique: numntcX0P8CQjyBPg0d5uA-1
X-Mimecast-MFC-AGG-ID: numntcX0P8CQjyBPg0d5uA_1740157697
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43945f32e2dso20932385e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157697; x=1740762497;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Puo49MYq2vFwIUP57UvTgwp6rYtElwpOxt8s83r61Xk=;
 b=xB0K8sA0DfhP8UipIKJM3HynYyUnvxRvuMceBNOJyek3XhS6O46P0IU+3MDjbeqzU6
 yLr5hmoqa9JkKFf4w5Dk/fuP6U2hYwDR9XerQmSIvxsTKD9dl8FldzMlOgu965ic+7jO
 Bu6sWZ6NUFm8n1GSs5MoWdjYrv49GEYq7jLOeEVqdRSUi4hfEf8eQRkRAHB6DtK4F23O
 /U10n6epnGJOXhZq6J2fMeIrsoiT084WIQF/h+JA8wxLwHGRZWwCaeBDjXRGAXLZBJa+
 s1McQ7Ojp+p/4U4nJg2s7hfud8Sgw7P+++aCtqd5Db9vDCncAnHqFoEBaaxXbOp1uauh
 iqBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqEURfvAzNkPzLSPeSAIOgoaHxEN/BHxcg9b8pxOGjyKXahD5gq4RdTqtMWNMPyCipUeiRKWFcQVdG@nongnu.org
X-Gm-Message-State: AOJu0YxVA6a3ZiBmUrgVBfPhWvk2KbTMSzhz+NCe34tCzO57A3fvxhPi
 ro4mOxdAUym1nJtUw737fk5j6TxLI+GuGZ3/R3saHkJYqSmaUS+CiVAjmBE4BKq4QzfKH2A65wx
 kHakqoYbbio91sUvbZbIqB6zZeOOOLfVHxqzWOFM6gakUJ/21QXp2
X-Gm-Gg: ASbGnctGIsAWjbJBoTMdbllGH/0kLiIZXcn7aNQT5y2ff7Vh6NYr/AaGs0qRaqBUOOP
 8ZZe8uOSeZhQNwNAzy43cNlh7/+dV6ACQeM06hjWz5ILLXvBG0r3ZiEEskXWgWLm2uRg5weRLSx
 yVk7f5+nn43bsUjJ5XYw2/0kLrCyekG/kAAO9LLhQSTDT/i3KLnz5/Rmv8r8BsWLV2eAk4ycDwL
 rc3tR9atB3KZvQviff8kb+36lw5CZiJsqi/K7hh/JOJqaQoNRSLDBjyjL0TkT7YRVlyRhbKowX2
 dtxZFkJTWAIOfwULs5Q=
X-Received: by 2002:a05:600c:1ca0:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-439ae1f09c8mr51315635e9.14.1740157697184; 
 Fri, 21 Feb 2025 09:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/B6JLd+TYBX/ehrBvc3KdD1y6zRJBhy9nvxRfFE8DFUAQWaqDNm9waY2/j217Ld4Ypc1EZw==
X-Received: by 2002:a05:600c:1ca0:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-439ae1f09c8mr51314635e9.14.1740157696515; 
 Fri, 21 Feb 2025 09:08:16 -0800 (PST)
Received: from [192.168.10.81] ([151.95.61.185])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce60asm23921575e9.7.2025.02.21.09.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 09:08:16 -0800 (PST)
Message-ID: <f546596d-1899-4445-adba-3e38fd43b91a@redhat.com>
Date: Fri, 21 Feb 2025 18:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] MAINTAINERS: remove widely sanctioned entities
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250221161443.2321327-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250221161443.2321327-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/21/25 17:14, Alex Bennée wrote:
> The following organisations appear on the US sanctions list:
> 
>    Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
>    ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890
> 
> As a result maintainers interacting with such entities would face
> legal risk in a number of jurisdictions. To reduce the risk of
> inadvertent non-compliance remove entries from these organisations
> from the MAINTAINERS file.
> 
> Mark the pcf8574 system as orphaned until someone volunteers to step
> up as a maintainer. Add myself as a second reviewer to record/replay
> so I can help with what odd fixes I can.

pcf8574 could actually be removed because it's unused in the boards we 
have; it could be added on the command line but its usefulness is 
doubtful without GPIO connections.

I'm sure everyone would rather avoid this but, given that neither person 
was particularly active, it doesn't change much to go for the safer option.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3848d37a38..55b2ef219e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2523,8 +2523,7 @@ F: hw/i2c/i2c_mux_pca954x.c
>   F: include/hw/i2c/i2c_mux_pca954x.h
>   
>   pcf8574
> -M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
> -S: Maintained
> +S: Orphaned
>   F: hw/gpio/pcf8574.c
>   F: include/gpio/pcf8574.h
>   
> @@ -3621,10 +3620,10 @@ F: net/filter-mirror.c
>   F: tests/qtest/test-filter*
>   
>   Record/replay
> -M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>   R: Paolo Bonzini <pbonzini@redhat.com>
> +R: Alex Bennée <alex.bennee@linaro.org>
>   W: https://wiki.qemu.org/Features/record-replay
> -S: Supported
> +S: Odd Fixes
>   F: replay/*
>   F: block/blkreplay.c
>   F: net/filter-replay.c


