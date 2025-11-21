Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDA1CFA477
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLfL-0004ga-3X; Fri, 21 Nov 2025 02:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMLfI-0004fB-Ip
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMLfG-0001sh-7C
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763710480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PsPZxyVRSXKSYEVoB9t5DBDGSvTafIe0jJvJ4sBKi+A=;
 b=ga/Pshd13oipAwijTylMwLdKBI6vREqYhCYC6u3BmbE/XXflKYEwIo1aGpsbNLBD+jzcn9
 6WbDuWELJYIkkQ785hm0BWr3/6PkL6Y+9YhgOnIwuf4qy4zSQ49jfGKH+nIskpzlx24E0Y
 WGUZRZKcdDDN+K2EDcWCsexz/XVL1s8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-9AFmcrYkN-elKQFXV_w6DQ-1; Fri, 21 Nov 2025 02:34:38 -0500
X-MC-Unique: 9AFmcrYkN-elKQFXV_w6DQ-1
X-Mimecast-MFC-AGG-ID: 9AFmcrYkN-elKQFXV_w6DQ_1763710477
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so9309085e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763710477; x=1764315277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PsPZxyVRSXKSYEVoB9t5DBDGSvTafIe0jJvJ4sBKi+A=;
 b=bkim86M1f1LX4g7a5tA7U1uFYdCK4mQSxqdcQhY6nbXG2IC1K2thWqJGI2sm387iWp
 AbehHFU6qgF0fvEok+BNGkX8xrRbQFFLaH2+5RhKAZ1I2UI8vT2DHwTXRWJprp6qeCp4
 v0XMh8C79SJ40P27Vl1fw2uvtIe0WHiAjaI2kphoM+/NqBQpqONUhl++UEl7rWdN5pvf
 Qjg7naBnGiJWL95+9f/+nciCCooK2c+rS4q0SU/a2xNzhuTrnd1wPYOoX6eoHWqoFXbI
 Vk/n5rZdS7EcOeT1tyblPGovvrkN2dzS1k2aqVrj4WRL9xcqUESM1oGVBESpelYaTAO/
 ROGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763710477; x=1764315277;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsPZxyVRSXKSYEVoB9t5DBDGSvTafIe0jJvJ4sBKi+A=;
 b=FjpOrgPlpQh+myoO1R9gy+V9C0MUdxe6Hs/G9/sB00AcV7ckbeD2LO61ILoVFofKMk
 5llH5d6ZhzIQvmb/oyVk1nMrCoXjbyK31Klc6vmnIqLhIDYXtr8OZyLITBW/BcfwPcVN
 lynZupwta8luIOOJu7f3IjS5fJwxadR/yCPHhwh1iLR7kjRDHdseDRDOGw5j29+FNZQo
 XQ3SI1HIwtrgodd0Z3cnNzozgOFsKjTQM1GfAl/gOA0ieRsuIUyM5zWu6NfGXuk/hMae
 puQ9ihL44Jyo/97fpao4RJxxbI5OazkEYlzMZ0DBYEWXJTVmmOLICWKXOff9fsaYwZw6
 qCqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHzfDx43XkMFhVU2wp8wbYVU1H1csu7VGVdr4CrzFfkhD5VOjJrfrRCzoJhG8DYtNF8eHomBAZzSHz@nongnu.org
X-Gm-Message-State: AOJu0YwqQfIbEpcL+Q2P+4vLm28ciFlSkBxOe2o5A399VmcTLHR/bDwG
 H3bjcIrqnDrpreisCJDhnCwSrQYpX00zDE+/RvXUwEua4YlDnCZ+Buncf9lGiaZRKheLYLLWrUK
 96PYoIyKaWcBQEMorIy6KvGbd48fwyh5eJfOp/ERCk2ahlDFh6MXesLZ4
X-Gm-Gg: ASbGncs6vIk1JdGBwLfN/X3wTQBuwZ6tK44rtYMEXm0GR4QCtyDUr1mWv6PyZiEiCNY
 6K29zsRBK3NaILH9aXo/QcjBxCDEiuRHA/X4A5hLG77bV5veuEyt0yee/2N43GJu7p3RNpj0zeq
 fUzMP9AHVnfnbQbPLalOsLXjDSAhENc/0luSv0s7qlG5E+lmz9sap3xp23KJb8RdJiJ/6JENSCW
 LAXG95A6B6b/aa/Kc9rIWntc9ba6eLfKmgrQthFotsfOxs15eWOTfhww9TrF+mWMWYjANNDeZ6o
 14XoJtAwPEDyBS7vbBI4o2bH2EPWJXEzNK/+llgAgbAgoP7zqo5bCfKhcEUpD05WzHD0j0ZEqLH
 mt+cYUA==
X-Received: by 2002:a05:600c:3ba8:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-477c018b2fdmr16290175e9.15.1763710477064; 
 Thu, 20 Nov 2025 23:34:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqh7E/CxBNll5I/E6LkdNp60BjPrnxPZLAuZ/YYHGeyNCe2fRGmG2X9NvTEqTDkpyUsPbFuQ==
X-Received: by 2002:a05:600c:3ba8:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-477c018b2fdmr16289765e9.15.1763710476645; 
 Thu, 20 Nov 2025 23:34:36 -0800 (PST)
Received: from [192.168.0.5] ([47.64.114.57]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3558d5sm28371445e9.1.2025.11.20.23.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:34:36 -0800 (PST)
Message-ID: <5ef76d62-ff82-4766-9ce2-dd2c3e21c8d4@redhat.com>
Date: Fri, 21 Nov 2025 08:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: s390 maintainer updates
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20251120104602.205718-1-david@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251120104602.205718-1-david@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 20/11/2025 11.46, David Hildenbrand (Red Hat) wrote:
> Unfortunately, I don't have a lot of capacity lately to take good care of
> s390 in QEMU like I used to; and it doesn't look like that situation
> will change. So let me convert myself to a reviewer in the s390 areas I
> co-maintain.
> 
> Fortunately, we still have two other maintainers for "S390 floating
> interrupt controller", so no action needed on that front.
> 
> For the other sections we get two new maintainers: Hendrik will
> maintain "S390 CPU models" and Ilya will co-maintain "S390 TCG CPUs".
> 
> Thanks Hendrik and Ilya for stepping up!
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>   MAINTAINERS | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Thank you so much again for your past work, David!

Reviewed-by: Thomas Huth <thuth@redhat.com>


