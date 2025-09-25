Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5876CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ilz-0007VY-Kg; Thu, 25 Sep 2025 06:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ilw-0007V7-SE
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:00:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ils-0005FS-Eh
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:00:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-468973c184bso4617475e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758794411; x=1759399211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kbg/olOfDDAJizAOGCeWDXq3GdRfvd3vml9WOGx5tlE=;
 b=jZVWC1WGbQ2czocglAS3hA/++HWJNSD0IKcMK3yG6albH+jAeeEfbVcvA+REe5Cjrg
 P9fG/xfUrExfeo/jXtJ32BlkeHZD0dB5C4XTVSXGGW5/gEyV29Mf7gzmUegdMMmXxcAr
 1lGZnhTEJiFtU7Ld7cdx0S6iopxGjZJ67t5IvjGxYa14GAMsGpXnxbwS3UEnNr3SG8bB
 u/pcy09Xp/wRUqqoFmHdpWak6xrDm7feUoYYh47Lvm008bVrevgSD1COgz0V7Ekt09xa
 xM8SEgi0p9NfRJ3rMG4Fz6INato5555DkeRYOrMQRVYr6odpNsrsTUlwTLwobLc7RcWv
 t6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758794411; x=1759399211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kbg/olOfDDAJizAOGCeWDXq3GdRfvd3vml9WOGx5tlE=;
 b=slF/BSmHJL61scMrf8Cj1b8Ul9An3CccOv1Dpso2zjtfw1e5TiFIRaBzvVdS0kbf0l
 wlt30oxlGA33si6zKGhXHJzY8PH4cpwHhnKmk6NzLyRknYq58JYym1YihCwXei0gY1qU
 vu6fs9bxQzv0Uov0/4qdDjAckXB2LdjGF17TGPvnxCxF0N8mvgt5t02v8BsivyTb8Xw6
 cVikK9mCBg1s+IRsjrKU2iXaNifJxs/6koKYDWqxNUsLRBNckC2u6+XH68LBqt7hBxBj
 jlsWrB/B8Ei4X+NmtQ5Z/C+VdNKEPDnpPEeClNJEypp7DhtFB1Vd+Qd8zh3h7Bc6DV1L
 BCJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/qxEsBHwYGwYyb0EAq8ytbvq1FtHEKOfRDPP6xWTRbuD/fKzTLRxo4Gd02UIhsspcwmSb+rk2Yb7c@nongnu.org
X-Gm-Message-State: AOJu0YwBypDVraV37LvM2v/2BbGDbZ83iGSDxTZLiMK/p9i+qDCd+C94
 HqoQr8Y923FPPNh1y70cap/4JPLgNnXQ/6Jz6tUO/07FbsuRW9zBROVOLCxMZi0Ip3o=
X-Gm-Gg: ASbGncu16o/TKY8nFs9rs2DJxeu9UybxWFzKPC6E+72iosyvyULUNxNS4/193KbSqtc
 rg7QXImycvXiEQS9iJEvo0O5L44xklACHtJde4fWg1KI5QxcBXRdN4gkgr/U6MeU/JQ0FipzgUA
 Ht34fgAy0B4WIYIKWUcoR96X2Y4hSteqPsVoYJhAUBve+BkFbHI7qc5T3GgIsLHLQcJXFyKBD6L
 5sFYI0h3kRUNoeLVBqn54TRDxD90g/egsoARqSmkCB+SxflieMrPod6xGDl2YR5g2zEAwlGK4zI
 6ukWRkrklY7HjY2/C9W406f/Aim03ZwmXxeyxZ8zShxVZU12fviqsTNl56CePd7bGol7mQ6OE0R
 zhvd1fmsL0Z++nO/UVKBDddEerr3IIu3YIrz8ubGZvjzZ3/2QCMn1cMb1WdLla20IVw==
X-Google-Smtp-Source: AGHT+IHDpvitrKKvon1jR7YJ8fPY5liFFhfX8fBbZq/lvk1t7t1t28KENnJPDEN09jH/W7nIhTT2Kw==
X-Received: by 2002:a05:600c:45d4:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46e32a26e4emr28246165e9.36.1758794410980; 
 Thu, 25 Sep 2025 03:00:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb711sm2369336f8f.11.2025.09.25.03.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:00:10 -0700 (PDT)
Message-ID: <b1fb0134-7e41-4e82-8de0-ac9e7800ea70@linaro.org>
Date: Thu, 25 Sep 2025 12:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/23] util: add support for formatting thread info in
 messages
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-23-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-23-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/9/25 11:44, Daniel P. Berrangé wrote:
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
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/message.h               | 1 +
>   storage-daemon/qemu-storage-daemon.c | 6 ++++++
>   system/vl.c                          | 8 ++++++--
>   tests/qemu-iotests/041               | 2 +-
>   tests/qemu-iotests/common.filter     | 2 +-
>   util/message.c                       | 7 +++++++
>   6 files changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


