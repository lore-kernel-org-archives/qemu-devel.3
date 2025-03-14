Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C3EC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8Qz-0003J1-Lf; Fri, 14 Mar 2025 13:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt8Qe-0003D3-2E
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tt8Qc-0004B2-0f
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741971750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qOXYfshuosOKEfrQLUoqo2MSqWv2OmsUad71rZA/oNY=;
 b=BxM+LTuC62oVpsWGDXWmZ2FfMhrNjlK8snZJ4VlYnyCeFRxPtR444vmr8PlcV6QrtLzb3y
 fFsuwicB1RYnWvSaWKR1Gc6ZWH6lWXQh7sUIZ6xF5jjvd5CQNyv5ASs4tSsrn9F/JcyZnO
 1NFdSE6r5ycq/4rPSpfkMocYwP52hNo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-pgNXQbl-NASjPOoifNRajg-1; Fri, 14 Mar 2025 13:02:28 -0400
X-MC-Unique: pgNXQbl-NASjPOoifNRajg-1
X-Mimecast-MFC-AGG-ID: pgNXQbl-NASjPOoifNRajg_1741971748
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso202604366b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971747; x=1742576547;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOXYfshuosOKEfrQLUoqo2MSqWv2OmsUad71rZA/oNY=;
 b=vFWQHvkR1jxBw2cTY8HCVgcC3l3ciFzJtxOepA9MRD1cXQ6SkdFe0z/oNhTvRWA2k9
 1Xb2OiT86O6FMu4q5dhZJhWrdLTqLFGsaluUKEya+Wn6i9TeTfxx3gzf04Q3TzFkYDV2
 pnX0vKi3tQ0vGLBxFa4q6lrtSZbP72Pm86/DAeaIMVObjRdvrrQ3vQlMeukaEfKSKlXb
 0WVBk0MNvT/Dp1YUyhvkLcOCcCZuyj70Q0FjLQ5UZgGEgg7gQOefsz3htdbRP23L0UKK
 pplsM2EAOvoS31R2j1uxG0EV3OQsLC3TU+H+a9TEbMixkzxHd+Ll+RtGeYmWjIin0OA3
 OlxA==
X-Gm-Message-State: AOJu0YwLmyo8SmUsFP0GUu2R3DwXpvzDPa2C1u5kIBV94NXj+APCRns/
 WKM3sr/Crc+yQfxRAbSPLWmSFrz8k5/T9KCyLXdZzVZYSa69L+0tE2d9k5IpWTkcY29gMCXOp/P
 tkejZwAw6OTiZZ9yAK/O822QgXfbx8WlU057QKDnQzQi61rgZVO3o
X-Gm-Gg: ASbGnctkgYUF/7Tz/8nx/zXnUSq9rdSb8XUdL/J2VgMK6PNhVpG6iCpbx6WraQmYtV5
 +XCcVtL4iy0EAQdlwF6FCZWNgM2jZdlgw6kgmmpQEPW4XRcVQiv3Qw1JxqCum4m9oElzf7FsCo7
 5rAGRjJ1MIGLiJjkRcSV+7Nv8M+E7PlZFhZVLZNRZdkF1A17nRNENO+KPlw29j1K2B4U80eY2HS
 VAyGpCua/Q7hSl2NVWfDF8hzYxlkYIR4Qlt0CUXIp76x3LMcmKXZarIqK+cLo6g6VRZXos7wMLm
 YF6WDk39fMYlg/VVDdvk6Q==
X-Received: by 2002:a17:906:6a0b:b0:ac3:45b5:f4cc with SMTP id
 a640c23a62f3a-ac345b5f616mr28314266b.44.1741971747397; 
 Fri, 14 Mar 2025 10:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA+ippjV1f9fvVhIgKYN/qsFzA6QvvkBJbFtYzxuc4EjwZVxyr+Bup+9vkZRP8Ne213noVcw==
X-Received: by 2002:a17:906:6a0b:b0:ac3:45b5:f4cc with SMTP id
 a640c23a62f3a-ac345b5f616mr28309266b.44.1741971746886; 
 Fri, 14 Mar 2025 10:02:26 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ac314a9db94sm252364266b.171.2025.03.14.10.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 10:02:26 -0700 (PDT)
Message-ID: <74429b0b-e012-4219-a74b-ed91fc524859@redhat.com>
Date: Fri, 14 Mar 2025 18:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20250314153824.65303-1-pbonzini@redhat.com>
 <CAFEAcA8J05Mp+VB9j+PEcB=ttpeAVZ-rJOPRAP53jhSqnp4oMA@mail.gmail.com>
 <Z9RfMALft87pBv70@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z9RfMALft87pBv70@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/14/25 17:54, Daniel P. Berrangé wrote:
>> Same remark as on the other patch: can we have a comment
>> explaining why we disable this on Windows, please, ideally
>> with a URL of a bug report against the toolchain ?
> 
> Two likely candidates open a long time....
> 
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59474
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99973

OMG...  Given this I think it should rather be reverted, and people can 
use --extra-cflags=-gsplit-dwarf.

(And in fact, since it's just an objcopy trick, it is even possible to 
put a gcc wrapper in ~/bin that will do it for you).

Paolo


