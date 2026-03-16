Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E0F53D80
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Bkl-00055p-NS; Mon, 16 Mar 2026 13:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2BkW-00053t-HD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2BkU-00042H-BS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773682141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXrQIa13b7QxNKs+9OUNdIlo2yGWwbStFwOO0XO8Hpc=;
 b=VNSn7wdiNaO9Ddwxx5k4vWF5t/Tz7uhx06WGSKfUZMSScAEz7cpCkPeZfbyZ0ElSYk8ntK
 oINiDusgGYAIXSU+s+AFcpBcot/MC4eo4AQWhnlnAIqjqDVa0GpXR4BRa5j6qN3GA5ZTXb
 yHewBeF5CeJzpVj/MbwenMEFWaMMZ24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-TZwQGb_HMN2Mme7FZ_R8bQ-1; Mon, 16 Mar 2026 13:28:56 -0400
X-MC-Unique: TZwQGb_HMN2Mme7FZ_R8bQ-1
X-Mimecast-MFC-AGG-ID: TZwQGb_HMN2Mme7FZ_R8bQ_1773682136
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48541cac34dso45579165e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773682136; x=1774286936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yXrQIa13b7QxNKs+9OUNdIlo2yGWwbStFwOO0XO8Hpc=;
 b=t8u4mY/H3OsN1bD+wAZSh3D4tsUlvzw36wUZLtGKMEmRD3Onz2lzIa0U7Le7Ru6RK6
 6xNgTQIa2hRJSOmNIbKO4vCQVLNPAR02CL0XKbPendDLu1t8/ELV9UUjkQ44llcZk52k
 mpuTO7JMqia6BOviLJIWrnjpMd4pReN9Dp/d/YAeI26qGvjsVxRmacclr+dHtKXwBbMd
 ql4ZQwlqeQ4lwqk6tYjl5OLP55HCztmN1NX7O2bCDrx6BZdPafZtjsYhNQ/N8HMgdkag
 /Nc/wfgSYA+WFBFL88Ve90IGF76FRR890d/nN5F6TE4aFWw7YeBTJqtWbVv9PJeNiqMx
 GMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773682136; x=1774286936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXrQIa13b7QxNKs+9OUNdIlo2yGWwbStFwOO0XO8Hpc=;
 b=sjqSFMn55206PxoPonchhlgR2GDXOFwZXjIR6SAmxycn22gzEXKW7asfpPgN6wCoTc
 9kI5hC9R7NsgkkhnNGGVaSfBwJOyJPAXOaSpoBFj/BVXfKnOpRk+jY0Ema1VgKykw+8v
 tW4AZDBuSF2PdRtYIrU+WG6Ku1+BczQ5DTmBV2GWn1fx1TvCu4/wba6txISLXRmchzJc
 5WlZurabUeHAUtilW4xkSta7KYldIOLHxpIwKBxw59zp4n9VUFJirAIL5fgBg/WqEOQ0
 JN8thQ36vg6/++kiehzDwOjLFF9CTNXOBDV6q+7xdd6ImmWU30o/1RpT6kNbto3oZpMw
 Pfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6kLv2IKDjBGWTVUzk18WbJtjAm8smjvU/vBYhtgkePuJvCSVt1Cbt1A8CXcgZ+D4GZR8UmyJ4h9s@nongnu.org
X-Gm-Message-State: AOJu0YwtpoLFRyBeLbnEiW9sFC5pRVtL9Ia7JmFbO1hFDaBB5V2XeZrh
 GbHH5wTVPJLYenHgSBuMQFQBs5eSUe3rtHNbDLsg+HmhJ+6hO1uPX9tNBpC1UbYmVcCoStwJlJa
 GM/zTrt2G11mP2yyfsijFLak7kSVa6pj5a4Fq6fbXF8RSUeMw87A0Z00w
X-Gm-Gg: ATEYQzxdHeH3/0LxJphBHfuNGJWzhS7nuzf2M1IXq4d9R6Kq9VJimVlAegmc1Fi893c
 l2oib9ciLKmpqCxRQcmoLv1KveX+WKv7jcUBxFW+RR8RrB1eu6lV5GYyw+3Ya3hHjvjCzgBS8Qu
 HLU2ndf6HlSAA4Fk4xtTrZO9f630tE/RlS+vJEWjfUwi5d/kFvW5uAuF2shonMDZi2M8RBm7apg
 m66yFwOa6kKZvZfaOQ9DdpvpVeYRk0FOPHnJ0QrbmvEGslH5Si+De2cBnSIFiz+E14EfuWOkIur
 I0hlO6lDeS4r69YAmmFCPKBl1XhsBB7X3Do9F/d5gDLBVLYee4TjGVgtB4vcW7puUjE2hHAi5FF
 mHUhm1aTKt0QYhoksmFQ6lt3ob7Gxe+cKeiaoQmjurFVf/4E4Rrn7EJ2v37R+syYDrBsheHI92k
 zeUU4G/4LlW825zFJ3q06KZvgHUFX35AseNnw+f2h0jBAIcPSq1yE=
X-Received: by 2002:a05:600c:8a0c:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-485566facebmr179045085e9.18.1773682135633; 
 Mon, 16 Mar 2026 10:28:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8a0c:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-485566facebmr179044715e9.18.1773682135159; 
 Mon, 16 Mar 2026 10:28:55 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d02c:3210:ed4b:e671:ceb9?
 (p200300cfd737d02c3210ed4be671ceb9.dip0.t-ipconnect.de.
 [2003:cf:d737:d02c:3210:ed4b:e671:ceb9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563f619csm158829295e9.1.2026.03.16.10.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 10:28:54 -0700 (PDT)
Message-ID: <9399d034-eb77-4dad-9c55-4993ea738a42@redhat.com>
Date: Mon, 16 Mar 2026 18:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iotests/041: add test for duplicate job-complete with
 throttled target
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
 <20260311145717.668492-4-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260311145717.668492-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11.03.26 15:54, Fiona Ebner wrote:
> This would fail without commit "block/mirror: fix assertion failure
> upon duplicate complete for job using 'replaces'".
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qemu-iotests/041     | 41 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |  4 ++--
>   2 files changed, 43 insertions(+), 2 deletions(-)

Looks good in principle, but there is the same problem with QSD not 
speaking qtest here.

Hanna


