Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BB7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 08:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNpn8-0001nt-9D; Wed, 18 Dec 2024 03:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNpn6-0001nU-BA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNpn1-00041h-Oa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 03:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734511937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yR/KVXFXaMBlTlUWcYZcm30UlFJaN5qjXzDioC0/yZk=;
 b=HPktRf/w6hgQFRfGrXa1vcH8jZYA72aMis3l7dA0TkBloQjprRSDeY2qDdB9vMfIP185cS
 U1zRmyv8qLNjmXjYUPFpeEB4Be5t6WQhWdY8/cGlQqVUxY92fFDbT9LpiAUe0q5Rf6I6pp
 voQwdPEPeO9+RPjh2NjJa2T9+jV6T00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TmRpeeXKMQSMrlO421ylRA-1; Wed, 18 Dec 2024 03:52:15 -0500
X-MC-Unique: TmRpeeXKMQSMrlO421ylRA-1
X-Mimecast-MFC-AGG-ID: TmRpeeXKMQSMrlO421ylRA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862b364578so249675f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 00:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734511934; x=1735116734;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yR/KVXFXaMBlTlUWcYZcm30UlFJaN5qjXzDioC0/yZk=;
 b=Tlk4FSPqSozgm+mD3b9aLrelG6GXODcMmXewV7ZBZY4c6MI0zhlGqXqv5cCdTIy4K+
 3WzDi5fpG1s52Pqg9MN/KUpvZSgSqdmCuw98MXIgjl6cQtYhK86+UYKxaUgZmWt8xLTk
 k5MuJP51PdV/WBMYeNqOpTMbnvSXl0+wVkTU+yAUDqwfb74jUVyXXJE7EfCsTXemD7OJ
 0fx6JcWO0vXuupuIvlbibZ+KgMUfjBWli7wOEgkh7u3m4m3tCeBv5rQa1zpiXypdrpcI
 RbqaMHx3CqXnaaMgfJQALdqKZ8DZihhWN+SS7w5+O/JnFVtQu8NG9gF1E5YrbvlT0pYb
 6b0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV931g9hKD+ZELyG0rs3L0F3TVW7miszNNxpzXeWJdIMjjT8IHozsPYDhp3UncbWqgtvjrN6SLOCpVU@nongnu.org
X-Gm-Message-State: AOJu0YyM2S2XUyGro8+mE9HabNVht9h5iDoNSZmwBKbrChDN6/LFysQN
 62Akr6XGZkc+gv6tA6TCOrGRjnVVePUEFUyOFzNpUOvR0d+xBbSRqNwYL1ISwSNIFoy0mRKjPRY
 hyLOFysjxvwLVjUIOCR3JcB8D5sJhOYRBj8kf1bxKnIzI7x0h5QUt
X-Gm-Gg: ASbGncv1c6Uvc6AhyJ+4R32eTMYPlbDH8MpmxhbR2SJT5uiL6mXAYkSk0As45WNLU9Q
 9jQxtaN6729VrHmDlm0tPbk01TEAV8lZnqAO0LfpF52BWi141NQRSAMgPQ+dFTtRLJrj3A9Omfq
 oxnulS1CC1j3HqhL7BYjXwOf8sWjulatIBD+FyGIimpUKVa+ASUo6NSOToT6zdgn3iKEfISyb1w
 tNFg2rPwmxpTwJ8WDJwtNT+iCiQEmgAmeFbBSlbGoSbmwauvZepaDz4v4d2EaRlfvZiZCxWNNjR
 C2fVvL4O9saP
X-Received: by 2002:a05:6000:1788:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-388e4e79278mr1310779f8f.21.1734511934467; 
 Wed, 18 Dec 2024 00:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmp1m5rcW6vZua1861pMo4Q07PCASaCOW8uiuUvVsbfjARWXVFq98vOUCaRMs6QbE7OF0qbw==
X-Received: by 2002:a05:6000:1788:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-388e4e79278mr1310757f8f.21.1734511934157; 
 Wed, 18 Dec 2024 00:52:14 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046ca6sm13639641f8f.83.2024.12.18.00.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 00:52:13 -0800 (PST)
Message-ID: <531e762c-691e-487b-b786-886c688d3f90@redhat.com>
Date: Wed, 18 Dec 2024 09:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/lcitool: remove temp workaround for debian mips64el
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241217133525.3836570-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241217133525.3836570-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 17/12/2024 14.35, Daniel P. Berrangé wrote:
> The workaround applied in
> 
>    commit c60473d29254b79d9437eface8b342e84663ba66
>    Author: Alex Bennée <alex.bennee@linaro.org>
>    Date:   Wed Oct 2 10:03:33 2024 +0200
> 
>      testing: bump mips64el cross to bookworm and fix package list
> 
> Is no longer required since the affected builds are now fixed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .../dockerfiles/debian-mips64el-cross.docker  |  9 ++++++
>   tests/lcitool/mappings.yml                    | 29 -------------------
>   2 files changed, 9 insertions(+), 29 deletions(-)

Tested-by: Thomas Huth <thuth@redhat.com>


