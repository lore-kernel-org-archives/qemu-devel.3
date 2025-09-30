Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A97CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3aRp-0003ec-CG; Tue, 30 Sep 2025 09:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3aRm-0003dE-50
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3aRh-0001kk-NY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759239058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lFU4jwb4O+Gafo8LIruaF7QCKdW8K65arkiOFCQFTjY=;
 b=cDWN6PEG7YZ1BwJYWJSKXzIBmOngkzqzg0G/iAAvuCrgltYBvlRtjVXhJ+RLdXdtK31LRB
 4Fr0riNW4PCwrbgVE09gw/roLcfe7JaG9+yxCEVIhHei+BVVxK6/MRefRcyKftGvFZtjRP
 Kqj4RAlYJXJESFx/hNNkfYk9QFkA/AE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-2O9VyEvKMoeZ3JHKPQFruA-1; Tue, 30 Sep 2025 09:30:57 -0400
X-MC-Unique: 2O9VyEvKMoeZ3JHKPQFruA-1
X-Mimecast-MFC-AGG-ID: 2O9VyEvKMoeZ3JHKPQFruA_1759239053
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so37438955e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759239053; x=1759843853;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFU4jwb4O+Gafo8LIruaF7QCKdW8K65arkiOFCQFTjY=;
 b=VUr+uCakQu06hRt3W8LbH1v0AqiTMhQDFuwd5cqBz2VIStqlgmr7F1Qw8/+nxLA9mo
 8fFiupGj7HF4XCC9Z8tRWNxMwwZJgkx9rXGFwyn3W5lwI0KBGRFBTem1dH1dH5L7Mq2A
 2H8eVKkB9gqZ+yZK9nkwSJ+FBHK53gCHm4rIM7FWyGtQKVd2+VWr5sdiDuG8h/ZiKFhP
 fb0uc/4RRREP4TssmFL1lDFo+MGSGC7jJmjlhW0TYrZ9+REoqqF4P/DHvjUuurzDneqE
 pcZL8q93K7XB1DmA+sHoN/heA4/CrDRnhwRwwL6FK7G+580NG0PhLTVlf2HEcVvEPeCk
 XtNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC64pAdwS7Ad1abQMbB5Fn+KPDoWE+pwstkfFKtnXEcjP+ZzadqyzHd2IPz7MGLycNuOObSZTJ2Xpa@nongnu.org
X-Gm-Message-State: AOJu0YyrVA9B2CRyOX3RsGlc8Ux8UdMoTAU8uJY9wNt8LdsjezwaedOz
 3uOVvzEK2xI9Q1MsoOipImLmjnxqoKHpNj9fpAn9t3CDl6zto1Uw56wtR3MiBx/y5WsAQHZ5nH2
 9oy0HgIcu47mhH8PTFnB7SreU7u4US9x4SrbmR/KJ5JPbEIiHO6/p5hSf
X-Gm-Gg: ASbGncs5r8wMY5SUddltpP3ibRMQ2R/hgwxQwI2/+WGyE64SU1n/oTCf3a0ef4cDVvT
 j0Hxrjq+J7Sy3sviH6k63CeNoKbmDmLbrl4WNtwThSa2yQ+1zUNn6cet/T5Bs2iOojk8e7skB0h
 aFEWV1adZwc6URkDXnQeLENI3CjTYvnFz+9EEElvR2jljDmcsCrbZo1spXPagOgnRrX3jbJvnLF
 aMyOTZSNeG5ZOEKGfwDenPMC2A6GC7tXfHGHcTsgLh+L4kK+AhO92TMzyUFuyleekvGr/bZLiBa
 H31r3Momv5mG5HoAlf+4D2zzV1NfdpxFKnZs1GvmhhrT4EbqEHUjdgAblUGowB5cizkZKJb/OTs
 PMD3CHKEeug==
X-Received: by 2002:a05:600c:3d96:b0:46e:385c:3e0e with SMTP id
 5b1f17b1804b1-46e385c412bmr159846315e9.29.1759239052954; 
 Tue, 30 Sep 2025 06:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXcZuSrG/5DhdEqgJvEUNRiBdrk2sz78sf9PQ6kzQuJCHYZt8N7hzDHD5C7xUE10UVYwmavw==
X-Received: by 2002:a05:600c:3d96:b0:46e:385c:3e0e with SMTP id
 5b1f17b1804b1-46e385c412bmr159846055e9.29.1759239052540; 
 Tue, 30 Sep 2025 06:30:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac5basm308521125e9.7.2025.09.30.06.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:30:51 -0700 (PDT)
Message-ID: <a4314455-69c5-4aba-af0a-b6f7bf239df5@redhat.com>
Date: Tue, 30 Sep 2025 15:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/28] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-8-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates from the
> certificate store.
> 
> Upon successful completion, this subcode returns information of the current
> cert store, such as the number of certificates stored and allowed in the cert
> store, amount of space may need to be allocate to store a certificate,
> etc for verification-certificate blocks (VCBs).
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully. A VCSSB
> length of 4 indicates that no certificate are available in the cert
> store.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 10 ++++++
>   include/hw/s390x/ipl/diag320.h  | 22 ++++++++++++
>   target/s390x/diag.c             | 59 ++++++++++++++++++++++++++++++++-
>   3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 30ddc81c2b..4217f19c84 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -25,3 +25,13 @@ Subcode 0 - query installed subcodes
>       Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>       subcodes block (ISB). This mask indicates which sucodes are currently
>       installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory needed to
> +    store one or more verification-certificates (VCs) from the certificate store (CS).
> +
> +    Upon successful completion, this subcode returns various storage size values for
> +    verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
> +    A VCSSB length of 4 indicates that no certificates are available in the CS.

limit to 80 columns, please.

  Thomas


