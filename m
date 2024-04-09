Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA86CC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 01:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru0e9-0005zs-1H; Mon, 08 Apr 2024 21:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ru0e7-0005zV-87
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:51:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ru0e4-0003j8-5Z
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:51:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so30267455ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712627488; x=1713232288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ljs/7JiSa5S3nADxqIvjYXYQh00O6OmkQTKb3VdGWFA=;
 b=d8pF90KxpzwDo+JGwkZPoueLI144V8nU5LZk/UccuqEOgxdhGbEqyFm2c0GHw4BFHE
 ozowPo1QYXABQHMICaEgsg8f84aWt+RNV/zeMQFUKLNycNm2oGWp1tUZE7rbzEU2ny+k
 QzRVi+wTpDpHNAAZLXLs+CLwHNrYl4tE3lW+KALoKvlaSdzoJQlHicG9+Oyuo6MccMqX
 lGwU/WCxa0zhuZGrmzLqwe6r/31//kcsBNlykUApvPQrQuezbrp8E0GFujS7VXGYpCDA
 A2q3Qa8/QmcentPKiugJXMEGUKpw+ZeXYB/u9HEZ5NCF3HjyaQZXR6f6E/hk+PqGnyGi
 Sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712627488; x=1713232288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljs/7JiSa5S3nADxqIvjYXYQh00O6OmkQTKb3VdGWFA=;
 b=Ke2E2sNpnUcFrIq7YYRB9uiVrZODjVZjH2g+q3aZsxFBoZGx5c96Q9QfMJ1KoSBK6r
 LHSa3+EejZNuzASmZvUmr9qrw28dcQ3yeA98ZWYeeXHnrmJ/dpRSLtjJ5y/K+JFs3xyd
 OD+4wmRP97IJ/2G6e39QiDspV2QuLdapCLj0QnDadJtOm13BUyn8VJtSz4tAuic238dp
 8gXe69XeXJzQEgLyB6+nNW4Wdm5cdDj7iAcHLXZEJTufJRN231xl81JlyIeOCzBzTPnw
 nvZ9q9X9XGbi0+B6CgfhmQodkIhO/O8gMUaH0NFzVThDgmea1eLvbCWVuKyZzrTQB4Ic
 fprg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpGQMdJfqqZMVLjJeWPeNhwLLyr5+kE6epKsEb02qOmiVKnUCmoNJMFiSVfDCNMMJwzROxedfegRuqXURwnPYRY4+3bUg=
X-Gm-Message-State: AOJu0YyCbuC6isdKDAztenib4HjwVe8Cfo2ch5MjGiG4ZiDbghq8kSOn
 Buw0epgph3G6ZYa3RfhD2bYk4Y8bonQFWMoBIkFXdm9pZtAdOeJsCaY/+rOt/yU=
X-Google-Smtp-Source: AGHT+IE3hMf9MR+5qDvX87oF5RBRNtjYcgKMYd/4DO1pu/zeA4mRI5gKNfrmsmLMZVdHDl0oM7fl+w==
X-Received: by 2002:a17:902:fc4e:b0:1e4:9db3:fc9 with SMTP id
 me14-20020a170902fc4e00b001e49db30fc9mr403389plb.36.1712627488236; 
 Mon, 08 Apr 2024 18:51:28 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 ix5-20020a170902f80500b001e24a287d66sm7725956plb.117.2024.04.08.18.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 18:51:27 -0700 (PDT)
Message-ID: <3aa35c49-b8e6-4fce-a1c8-315cc37fc53d@bytedance.com>
Date: Tue, 9 Apr 2024 09:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0?] backends/cryptodev: Do not abort for invalid
 session ID
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Zheyu Ma <zheyuma97@gmail.com>
References: <20240408154508.67307-1-philmd@linaro.org>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240408154508.67307-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

VIRTIO_CRYPTO_INVSESS has a quite clear meaning: invalid session ID when 
executing crypto operations.

Uplayer would get an explicit code once failing to close session, so I 
suggest no error log printing in this function.

On 4/8/24 23:45, Philippe Mathieu-Daudé wrote:
> Instead of aborting when a session ID is invalid,
> report an error and return VIRTIO_CRYPTO_INVSESS
> ("Invalid session id").
> 
> Reproduced using:
> 
>    $ cat << EOF | qemu-system-i386 -display none \
>       -machine q35,accel=qtest -m 512M -nodefaults \
>       -object cryptodev-backend-builtin,id=cryptodev0 \
>       -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
>       -qtest stdio
>    outl 0xcf8 0x80000804
>    outw 0xcfc 0x06
>    outl 0xcf8 0x80000820
>    outl 0xcfc 0xe0008000
>    write 0x10800e 0x1 0x01
>    write 0xe0008016 0x1 0x01
>    write 0xe0008020 0x4 0x00801000
>    write 0xe0008028 0x4 0x00c01000
>    write 0xe000801c 0x1 0x01
>    write 0x110000 0x1 0x05
>    write 0x110001 0x1 0x04
>    write 0x108002 0x1 0x11
>    write 0x108008 0x1 0x48
>    write 0x10800c 0x1 0x01
>    write 0x108018 0x1 0x10
>    write 0x10801c 0x1 0x02
>    write 0x10c002 0x1 0x01
>    write 0xe000b005 0x1 0x00
>    EOF
>    Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
>    function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/cryptodev-builtin.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index 39d0455280..3bbaabe86e 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "sysemu/cryptodev.h"
>   #include "qapi/error.h"
>   #include "standard-headers/linux/virtio_crypto.h"
> @@ -427,7 +428,10 @@ static int cryptodev_builtin_close_session(
>                         CRYPTODEV_BACKEND_BUILTIN(backend);
>       CryptoDevBackendBuiltinSession *session;
>   
> -    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
> +    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
> +        error_report("Cannot find a valid session id: %" PRIu64 "", session_id);
> +        return -VIRTIO_CRYPTO_INVSESS;
> +    }
>   
>       session = builtin->sessions[session_id];
>       if (session->cipher) {

-- 
zhenwei pi

