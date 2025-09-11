Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF94CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlmY-0005gM-Dd; Thu, 11 Sep 2025 14:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlmK-0005b2-8S
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:12:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlmE-00055C-CF
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:12:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso892282f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757614329; x=1758219129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHIrNID+tkvNaJJYQVHQcGccjCnjaJgpv9H/TBaqlns=;
 b=w7bqPKmRkZg0u5ITs080GEm0+WK1ATgC07LrNKZ+VpNUWlmDNzN9uHbyvDzp0Gs/V5
 FPpUvmL4tdW0esS46cdf9H0e0Yb9cXPtHvTztWscO5234Uy8/wGVDqMz0baAD4xZXOYW
 APTKLhvjSbw8Xvb3251tCMBh0io6imnZSDFOap1ST0h40JcXAXZe59+tCk4oY8mskXIJ
 if2E4oZ08eFblSTireO5pLP3j6RMTroCZSMswZ+ImaS7UgdJHSzvH8R82v6SDY2tJ0vn
 6X2uO3XuBvJEGTafG89x0t6K5KciJb2BoP8ENPc1cTpThvBk8/iO1CuPYoeiu9KGjqjl
 pv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614329; x=1758219129;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHIrNID+tkvNaJJYQVHQcGccjCnjaJgpv9H/TBaqlns=;
 b=bQ+nbZfpirie3hhEwGrdaPGgrq9vdMy+W0UWd/ePD7TG+SyxjZF/W/MgFh2707eysC
 hL67jt0Mnx8QCGqhmSIu5shmxb6F8slQDvuf0J/KLqmgMEHy1T6e6+CHgXxs0mXDiXOj
 7e63XPh+uTL3KQF5L7T7b0TMNtv9Ub1lQRO6Rvf18Wm2CY2wVz6VbNd4dCuysVWtdTFi
 jfc/amjkGE2GqjOHu4KsL23yfeu0a92a/8A0c6mrS30F34e8dxeHB9HoB9iIPuPB3nCj
 vj/eS5YUThBRWMHYFUP94jpI7Y9/PyuMeJXXcVkdXm5JFpOeHHGRj6LLy14+GP673USc
 9YAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+3Z8jGauMLxoOMCkqFYNVIn1M6XXGCUoTE3tSEHNsqpKbpWshALuUXmtxZpGXQUjparyJgI9N5t4p@nongnu.org
X-Gm-Message-State: AOJu0YxJeTm7pyYS1I4S+wbRLE4iYurYiF7E0BjGMQMxsn9x1leT5olY
 xFXX/UhcRN+L2GLAlnXvtTXYIBsB8ANor0uo4GGJ4Aan6s3NFqpulQR4t/2Ms2yFmdw=
X-Gm-Gg: ASbGncuwPXTGwfPy0ROjwUdyU1IeHg0/pzchFriEsoyG+6vzk6c+s4qk0yzyf+rnuw7
 iRN5HBav98gWGe2Qp+f9MRNuDE69clUPr5RmAHCHNGl3KRro3sQfRoSc/GjooJ2WKJOQBTCArho
 v/abMSFF2bcLWc0029U2jhqcdezjY+cdgFCMObkbWu/LMMjaZPALJxrLp+VVsih56oYG8FFGvUs
 4erWKXodk6UWmtBdalO048+nTNhUv4HP20cUb87mR8hVw3jzZ4oTORsooSYPD8h0vufArKWA4Z2
 KbwVEQsGCHu2ji8pzveHHBiBnOWbVGo3fls/m3w8JbY8dFr/X8Vapb0piyHL6HimODjsFhLMMhb
 wGw31wU5UTNghjAiyTocXoKNvINkU9XD2/UBQbqjO6JdfTkjZSZelSPzVFABC/XZHJ5Gd
X-Google-Smtp-Source: AGHT+IGkiwzdEXrfqTIg537MxIS44JmTjWuSINRver3HKTHggJUNep6vJDFCMfyAKzwnKjQ1J79nFQ==
X-Received: by 2002:adf:8b5d:0:b0:3e7:5206:bdc4 with SMTP id
 ffacd0b85a97d-3e765780ae2mr197223f8f.4.1757614328676; 
 Thu, 11 Sep 2025 11:12:08 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e015775f1sm35771235e9.8.2025.09.11.11.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:12:08 -0700 (PDT)
Message-ID: <7708f678-4e8a-4ed1-a5b9-6b17797493aa@linaro.org>
Date: Thu, 11 Sep 2025 18:12:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] util: add brackets around guest name in message
 context
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-21-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-21-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> The message context can optionally include the guest name if the
> argument '-msg guest-name=on' is given. The formatting, however,
> does not look good if the guest name contains whitespace. Change
> the output to include square brackets to demarcate the name.
> 
> Before:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>    fish food qemu-system-x86_64(1146846:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55657e94e690 dir=fish
>    fish food qemu-system-x86_64(1146846:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55657e94e690 filename=ca-cert.pem path=<none>
>    fish food qemu-system-x86_64(1146846:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>    [fish food] qemu-system-x86_64(1144713:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5604ada2c950 dir=fish
>    [fish food] qemu-system-x86_64(1144713:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5604ada2c950 filename=ca-cert.pem path=<none>
>    [fish food] qemu-system-x86_64(1144713:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   util/message.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

