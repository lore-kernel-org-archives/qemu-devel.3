Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A432BCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlge-0002Zw-C2; Thu, 11 Sep 2025 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlgT-0002DG-JO
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:06:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlgP-0004Jf-Hx
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:06:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso885295f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613968; x=1758218768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wC/l/0eF1fF9Hbl+CcfWv/Ta3f7x17R91szPSVszkvs=;
 b=vm3TJtVAYM5OlfBVH8d/A0QfsGnmXHN908K8c3ez/Tg5UpsxEq3tJVAQdOfQUXCkVf
 cxhQyTkP972kTNUCM+i/tsUmVujHgHfq08t+LTxCjnz+YyC90HABkdlLyifR0rUtBMtN
 K1vifaFJjfBP1775ka8qr7bNTtDYOlPbWGRjAJ063Mi1lSpDAonNtUoMYZQzxh2GFxu9
 bt4ujMHNfe5iEy/c0EuuBboO0kx2E0OGPB7L8Ugi+9+OWOwllb707PC5EbF06jaeYH+f
 sEBz7+w+rnTK5fqmggAKpX40k0aQVUXBQhSrIExENPYfRPbujT3B9QGjLdPtUpgfmYey
 VAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613968; x=1758218768;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wC/l/0eF1fF9Hbl+CcfWv/Ta3f7x17R91szPSVszkvs=;
 b=Dx4aSx4diG6DP7av73TYtVZCAgFzT4RqojhYmUKu1HTp3PfCPQvC5hFcpsE7J3QGVW
 Wb146Cx3+AkQVdM2tpw4rzDLaEQXn4T2I/XrdSlaYxsLr8z7wZRVsiBVuEKfmGfgYywZ
 Rz3uIqj5sKOhBjQ3ctW0AHU+S91KjUD9M0HJ20A+jUTGUNulHt0f4Atk9A9CudcEoFxM
 GafqqUC9YiOLMdVuX6LElLzEqvbWu9/+fu55nyPaEPAhKvVMJWF+iBLlLPodnF1UlffC
 zsOqQXOuY0o0BUa6jKjWHZ11qhGVUl8JG/jWQ84IV0r5T1Iwf3SNTLnAp5twG0FqWf/f
 WCxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT6JEGkuf8W2NUs0rXjeDEJGlTsRXDRp42NwENwgujKonK+vdX29x5Vy8XAWbquP1H0p0UejFRobQa@nongnu.org
X-Gm-Message-State: AOJu0YwZRxL9E/rZCtvKyXAA6yLM10bWm3k/aW1xHxLNS0Dv0dbsPpIN
 8KH2ZWLWKjd6Wt6p/e6njopfSL+wGU/bPNWxYEQcErk9pb1enGUal2nS0gN0pUyA8YQ=
X-Gm-Gg: ASbGnct5F7u/BgAZd56kz8NRvXIYhlXiFIU3OZnHRmPbseqJee/Sx0R8Aa4x8Dyy3o5
 NQWujg4XfS8dU+sY5Ajp8P858xEzy8fmTfFT9uf0uinFE2tWL9G9yeOxrhVsYehj5Kbel+xcTdh
 Ayyd/gCxaRhqGMSXPoUluy7qHy1nTtYEk0mswEN/QcebaIJz4W3AJuuujgdgBiMLCQzL/MMBoEm
 Oaxlgh2OfB2QG5+P5YOyKaIZJpCFN25unbuZ+qCbDkAxV/+kWWmj3J9vmwWcvoSBpAygOBJlnDC
 TB4KnJvGV5XaeUllPhLP69TpEGEYeKyBSweucUAiA6/xTBNweF/llYSydK2HsbeJvANUBim8+Bn
 nfpeCd4xwfR7t/+qe+5bngrJyP3etkWM3EAc839qE1nvuq+D+JsinIB6hYiDZsz7XztQy
X-Google-Smtp-Source: AGHT+IEx4LkhrBqTOvedC5OHALY5btWwtHJ3WfomECP/keBJR1aSQiYY/dwENXbTOTb13hlmGqEAmg==
X-Received: by 2002:a05:6000:2212:b0:3e7:471c:b11a with SMTP id
 ffacd0b85a97d-3e7659c44d9mr195091f8f.19.1757613967750; 
 Thu, 11 Sep 2025 11:06:07 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607cd9fasm3263803f8f.35.2025.09.11.11.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:06:07 -0700 (PDT)
Message-ID: <bab17a17-37ce-4163-8065-a454d368aa21@linaro.org>
Date: Thu, 11 Sep 2025 18:06:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/20] util: add support for formatting a workload name
 in messages
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
 <20250910180357.320297-18-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
> The error_report function can include the guest name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
> 
> This introduces support for a "workload name" in the new
> messages API, which in the case of system emulators will
> be the guest name. The possibility of defining a workload
> name for other binaries is left as an exercise for the
> future.
> 
> This change has no impact on the output of the error_report
> function, but will change the qemu_log function. This can
> be easily seen with the 'log' trace backend, and how it is
> now more closely matching error_report output.
> 
> Before:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/error-report.h |  3 ---
>   include/qemu/message.h      | 10 ++++++++++
>   system/vl.c                 |  6 ++++--
>   util/error-report.c         |  7 -------
>   util/message.c              | 12 +++++++++++-
>   5 files changed, 25 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

