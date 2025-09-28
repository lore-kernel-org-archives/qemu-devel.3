Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD16CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nzt-0001UD-48; Sun, 28 Sep 2025 05:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2nzr-0001TT-JS
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2nzj-00067E-E7
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759052820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P9BnxB2/1IsSxyqvYeT8c9KEdMlAuz7MeUcAH/r6eSY=;
 b=DMALzGJoxhg5cGoPLN4wvNHeMsoQ1cwLOHwgI02S7Lpk1p7yLf54sjg8qbYY5bOhc/gLWM
 kGRUehZ7DeK+8+CiXdfPXuWPumLefBldAQCFkLY+7OLFCEkZs89P9egUdTmZrtY2DrkrVw
 20+IEQCO/azI6mSUxa3Q9FgdXWzUJ18=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-1nUEQXHXNamhyPojBkIhNg-1; Sun, 28 Sep 2025 05:46:57 -0400
X-MC-Unique: 1nUEQXHXNamhyPojBkIhNg-1
X-Mimecast-MFC-AGG-ID: 1nUEQXHXNamhyPojBkIhNg_1759052816
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6341958f08fso2976079a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 02:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759052816; x=1759657616;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9BnxB2/1IsSxyqvYeT8c9KEdMlAuz7MeUcAH/r6eSY=;
 b=n0g3R2hUYFW9rqG1v/Wph9IE3zDoOqrgnKHqtnxRZIAjWgomMAFAS5TBuccveg4GFp
 tfAOG4w8TNaybCRBSAAf9zNngnFBmFCQNUt4naCjGVKhW8ruqnerT77sz0G75nMnXcew
 avNWh9bpuCGadDWsQDO+x84BXiA3exPpiVoIju7C8Jt9nEPvVuphjl4+DwwJ1PVN94wX
 dSiGLfsUAK9avrqyO1Ea21s+7HkRwESJAQ0QnusjnRUASkFPikDVoxDPlKNLPMbropI2
 5inOxVaPwevNndpzhcjUIwdXrd5TSNj7IfLzEqPZiHL/kJ/0UuoFZAVJBPhW5waaN9Ud
 dSrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYr5hBvO72tVJ1v2nTtQQ2cI6ZB5RZaNY2+A7Ws94x+4DjwanZl8rfYMQbBuywnk+lF0IMImhUD95o@nongnu.org
X-Gm-Message-State: AOJu0Yws23S9HEIFYi+viTognyIlWClRRfUQzsH1TgwYe3mg4pbxu2iO
 LtkdL8307fqaTOe02/8JaBwmtelVWnssk6fX1nCDczFsY7yytj+7TFhBAyJIay2wqXW0EqjHB7w
 iBU2TAuNchooPvDDjjBWiCXrjX9IMJsgg5QJ6MGq8BCneUoQrphGOIojhukmTx8Wg
X-Gm-Gg: ASbGncsqEj/pBTbBRq2oXj4Rvto4tec/MS+I5pBkxaXLrY0icd51jpBhIIuZkMe10N+
 LrlZf1y7RhevC+93U4DgnO7Q90GuReHt9iG75jnDbKjX7bnI5cbow/448oqnpqrAAmwImNwitFh
 FIKUnfokcy4j0610Xci7WZ8hn+VeQPG52+OfXStgCcbCW5k61h2ij5Y/tB2Dg2H1feJRnX2F96q
 a8G5MV3FsSSkYYEBu10RVvFbRynf3WikEfSjW3eMcDgQBIyjDpauUKflPkce2Lzhh8hRuE05VxX
 9X8B2Zq2eQ3FA0dhGKfSqn1BDBacSv6J5nmE/C6aVEThoHO1GmTL+6e2l3hLkj4cHjKhdt42DdH
 hnxMJcFXhAJO0OrMilDKiRKyoK2i/juqTL4K2kQqDLlgIyg==
X-Received: by 2002:a05:6402:180c:b0:632:bc36:db59 with SMTP id
 4fb4d7f45d1cf-6349f9cb7demr9380129a12.1.1759052816088; 
 Sun, 28 Sep 2025 02:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIWX5DzHyoAzSRTSYa2MXKWGdP07J8O07umEhHDn2Z9x+RKGMbeXbEmI4AMks00Iksppc79A==
X-Received: by 2002:a05:6402:180c:b0:632:bc36:db59 with SMTP id
 4fb4d7f45d1cf-6349f9cb7demr9380113a12.1.1759052815642; 
 Sun, 28 Sep 2025 02:46:55 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-634bffdf857sm3713615a12.16.2025.09.28.02.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 02:46:55 -0700 (PDT)
Message-ID: <b1c2c737-2382-4fad-8942-5a69ee3f4b40@redhat.com>
Date: Sun, 28 Sep 2025 11:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
To: Hector Cao <hector.cao@canonical.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CABjvBV4Lgih8dJneZnz66Yd0LGmrmJgeRvN1CZHFKLcbaCcb_Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABjvBV4Lgih8dJneZnz66Yd0LGmrmJgeRvN1CZHFKLcbaCcb_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 10:40, Hector Cao wrote:
> I can confirm that the migration we had for Intel CPU (Haswell) is fixed 
> with these 2 patches.

Great, thanks for testing.

> I can see that for arch-capabilities, in addition to the 
> compatibility property, you did slightly change
> the behavior by limiting it to AMD CPU (other x86 CPUs like Intel will 
> have the old behavior prior 10.1 so no migration issue).
> Do you think it is good to make it clear in the commit log ?

Sure:

     To preserve the functionality (added by 10.1) of turning off
     ARCH_CAPABILITIES where Windows does not like it, use directly
     the guest CPU vendor: x86_cpu_get_supported_feature_word is not
     KVM-specific and therefore should not necessarily use the host
     CPUID.

Paolo


