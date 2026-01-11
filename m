Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CB0D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3zB-00007c-Au; Sun, 11 Jan 2026 17:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3z9-00006c-A2
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:32:35 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3z6-0002lM-Ae
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:32:35 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so4846588a91.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768170751; x=1768775551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=968TPBV7ZHk1pT1hJPYejxTybirnqoIcqqfUXHVKDU8=;
 b=Bnu97BU/MpxxYl/9Dxpi5wn0s7/d95IwZeZMjev+hl36xCYjWKGD4rViVflxI1RWBk
 JJAycopH1JORy/oUIXqdEBrOOwba7GAP9KZIXxOvftPDv3M32n0ZrVeqNklKyT/85MFc
 Z/L3VoDmfYzPftCSYFotm+Lx+inTGcpSh457xuEF+fq08RQi1ropFHgKBFj+21hu8Xkj
 qHfHCxIPIKDH2aZy9Vr8ZPHQAmTxtyapymT0VRrWyqYv6S8m3fbDq6igYT3+A8G1Gvtx
 mJe7ah8kRpM7GhlHm1zrM3qrMIkHNSv+sxx918zZDf0kPMvrq7LXj+ihj20L1Z+hDRJS
 UqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768170751; x=1768775551;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=968TPBV7ZHk1pT1hJPYejxTybirnqoIcqqfUXHVKDU8=;
 b=CLnVdBZcPWXMu1EiizJYVaYANjmuQCJ+HODvP3gtFhF4AndjAeKmMHQYn1w+cB774C
 qEcsKAIor/sU48egmru1sJB4Z4D1FgPfDiWu7j93slW+qDDS4i/QyRVNdn8yS7V9w0iZ
 ZVov/mFPvlSR5tsdNWKncli4WFZE0jSgskO5U5hr52RRycI3k7sWk+359zvQEfF7kPvT
 1RDIM4EVw04memnZXCFYKjJjiJtBKEkjGV81sRPS0UxjWq3BT7uQgoTGZvnN6Z+GbsWa
 ehtU7GJGN9FWDI8oDSsTa0UDYikr4Xxt+iWMJIS9NMxql9ZBMb1TC9A9YopYqHT6dtHZ
 ntiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAQk+BXLh8sVolCL64lFz2uA4HodmEqfGfliSpGuXgZCo9Qb5+fwTWUquQQHnrlukXHfVM2o8Lcw2l@nongnu.org
X-Gm-Message-State: AOJu0YxmNWRSuhSLift76buRvCTOU0bj2FcufJXxc9dLiJHfq8LiWQBE
 1l5NtguNoUUYewWFOqczjnchNhHJnJzZ3k0Auv8uPTmIoUozh7hTseRq5Cj5QL58tPQ=
X-Gm-Gg: AY/fxX5RBgnVqXSSIYRcDskcSH5F24E0wT2ZsXp1oNq18wE0rq3OOvBLzJpCdBD3/1a
 mMl86MD7sOrvBkALTPjPGb6QFn/fH4sWkm8hQqVQKlDN5ED9YAl/7LTb/d2gi7gZpUDHW64fMas
 cxXph2JXJ7EgFBgZTbt7k8lW1aVu8nfjxsoO8urVA9oHGgTkyAY4Dx3MiJuLYQT1hkjhEPN/b1o
 99OSm5jTsaSPYRGilIZ8CzxB5tZqt+Wx1lUqQHTs/TkdFqiwPgAgnoStUyKMVK0M1iNQjPjyJ5Z
 45X6UVMOpOWkxhw/jWG7a9Pb8LzzfBmAlvr4ph9DesoaSjfFWEZzFG7rsAkH29gzQ1So7SSmrL0
 YItywvhe8YOB4HBg2ArrhWlgKtKvt0TGSlHmfWbMbshUVgts68PXj//vizihKA6OlbcP6tNX6l0
 xrl1KIdQkpE54T0lcVf2dgRkIMTw==
X-Google-Smtp-Source: AGHT+IFksuJSlQm2rVy4+P3EmyV8Grx1rpOCAEXimX+GByB9wUWv31eXhVPq70Qr8I3o1nA7/v/yNw==
X-Received: by 2002:a17:90a:da85:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34f68c4d6e2mr16642060a91.17.1768170750729; 
 Sun, 11 Jan 2026 14:32:30 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d292fcsm15496211a12.20.2026.01.11.14.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 14:32:30 -0800 (PST)
Message-ID: <1220fd98-8d11-4217-989d-b71bead76da2@linaro.org>
Date: Mon, 12 Jan 2026 09:32:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/24] util: add support for formatting thread info in
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-24-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108170338.2693853-24-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 04:03, Daniel P. Berrangé wrote:
> The message context is now extended to be able to include the
> thread ID and thread name, after the program name. On Linux
> the thread ID will match the process TID visible in /proc,
> while on other platforms it will merely be an integer repr
> of the system thread object address/ID.
> 
> This changes the output for both error_report and qemu_log,
> when running under the system emulators or the QEMU storage
> daemon. Other programs omit the thread information since
> they are largely single threaded, though potentially it
> would be useful to enable in all of them, given that the RCU
> thread will always get spawned by a constructor function.
> 
> Before:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
>    qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qemu-system-x86_64: (772366:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
>    qemu-system-x86_64: (772366:main): qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64: (772366:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> The '-msg thread-info=on|off' argument is introduced to allow this
> new default output to be supressed if desired.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/message.h               |  1 +
>   qemu-options.hx                      | 10 +++++++---
>   storage-daemon/qemu-storage-daemon.c |  6 ++++++
>   system/vl.c                          | 17 +++++++++++++++--
>   tests/qemu-iotests/041               |  2 +-
>   tests/qemu-iotests/common.filter     |  2 +-
>   util/message.c                       |  7 +++++++
>   7 files changed, 38 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

