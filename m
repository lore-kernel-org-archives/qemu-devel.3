Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC09CFD2F6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLdF-0002YC-Qw; Sat, 29 Nov 2025 09:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLdC-0002Wh-QS
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:08:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLdB-0005Vn-6x
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:08:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso1525918f8f.1
 for <qemu-devel@nongnu.org>; Sat, 29 Nov 2025 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764425335; x=1765030135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9G6POTo9sEtvHUBM47IxolVawTQMbNYA2QBBChmkmE=;
 b=pZLVbC1NlR9wSaMCT10UfEbdbWr0m364V4y2PhXprIANXRe7FapD4xDlGcGjmeahCg
 raqC6HmpC9lc7fJeUsb8rCJ3aSUwACJNpkVnnNXHh7yj2qj3lTfZZLXWIhUFp5BnZ8nh
 evjc2Y8uecaHiIdDGrkjgrVCDE4zXQHNeH7ZGNvqLzMKM12mVk8Ztr4MnJ3CtbKV9/Hk
 2jQP1kmdLZl0CY76QSBUV/BOw3M9kCOB1AY6FtgDYCCdmphobS1CL6uQGpuIDUnmUtmv
 0XDgrQrqAAxcW/h1NOmDRQW+A5IBqYSqxaCO/MKACekT3INGt2E0FAII49GjPuW2IJhr
 rCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764425335; x=1765030135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9G6POTo9sEtvHUBM47IxolVawTQMbNYA2QBBChmkmE=;
 b=uScyk15cKY0AlGBD6l8SuRsCJOtK8z0/8u0BZhcN+SLsX/iDjVeT2vwD5El8MdeC/P
 h0bVRdWf8I0YQQ8GTg92jg7k1kRLQ3lUDSUMNO9vkgoa3br5rFZXuKbFDe5J9pe7uCZS
 czN1uLKJsvJVniN4hdmtpfFS0z7TPHAQRPBAJzEF3LcI5UCZK2QyXl6PCKdBVQD3PW4G
 7KmUJPsXOpMI2genvuKYbYMks2PUysF6u9aSTgehCdl71ZV0mfPMga9VS3SXE+O2imh8
 eQRGCqeuoWfS54s2NuBUASgtTvJkJKIfFulPePOMGwsnH+Ou/4dzRbqiBRP3IvWnfvt9
 9E1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNXWseU77pdxwHTR73KhKKAv4NgGac5675BHF0nrAcu1Zr+llaz7AV9tiiyXEHo3T7GmRwpuJsVIz/@nongnu.org
X-Gm-Message-State: AOJu0Ywq8uTDYS5oMC6b08egyM+EwXYZ7EQCiO8tkfh60dWKkusVoFty
 iZ9FmdNKVkFB1M2j+0qtx1fx3Wxc4oTR+ctGBoiw5SIrtKnA4vqnD2DDI9SE2y4cK+c=
X-Gm-Gg: ASbGncufitKgv9SPDi1yDMQHw4HvVlegKAQbre/Bq5hQsniuOY13QeD9Aof9A/njO/p
 1cUjGL8fadydeRdPlsLfGNsvXxBWRrLdmJh3PLqeoDTQPmbJ4v18ioBaEQm4hjEBN4qOKYoggkN
 atMgDTsvatCk66TJvD2sasOB6rS4i9EtHylZzqucOdSxORFkIv9OsouM+O6u5oD+s9pWmGRAr0n
 kVkbhX9AEa4kWjNG/g10MEwmyGjjtW4jSqn/GMMQ8/Qg5Exq/HCAEDS+QG62UHi5dVEuWb/kfJy
 cYeyq2yMxKr1wR6mBi8ZMBr+Uk97Nxj6JjiSLXJN4XxplASoDT3vXMFwqBxMiSjIbtnwJ0sR+Rg
 y1Nwf8RQHtbX7b/sYD1geYrl1UNCrQoyUDCVEfKSQ90dvd8JjsvkaR49IdolpRqBw9ZMdw/lOAu
 3bv+cn+8q5tWV74WN6iiio7m1TQbgYAkA=
X-Google-Smtp-Source: AGHT+IF2DHlGgOQ9nokNkwik2iaX+AMdYR9ZA8oZl8qvS3J3f6TBpWgrUD0cK7g5Vhvwe7AHHcvK+w==
X-Received: by 2002:a05:6000:40dc:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-42cc1ac9d4dmr33576423f8f.3.1764425335354; 
 Sat, 29 Nov 2025 06:08:55 -0800 (PST)
Received: from [192.168.1.152] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm15334207f8f.14.2025.11.29.06.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Nov 2025 06:08:54 -0800 (PST)
Message-ID: <6b47721f-0fb5-4546-abff-30746df5826b@linaro.org>
Date: Sat, 29 Nov 2025 15:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] chardev: .chr_open(): add boolean return value
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
 <20251129134350.487839-5-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251129134350.487839-5-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 29/11/25 14:43, Vladimir Sementsov-Ogievskiy wrote:
> Add boolean return value to follow common recommendations for functions
> with errrp in include/qapi/error.h
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   chardev/baum.c           |  5 +++--
>   chardev/char-console.c   |  1 +
>   chardev/char-file.c      | 13 +++++++------
>   chardev/char-hub.c       | 11 ++++++-----
>   chardev/char-mux.c       |  8 +++++---
>   chardev/char-null.c      |  4 ++--
>   chardev/char-parallel.c  | 14 ++++++++------
>   chardev/char-pipe.c      | 12 +++++++-----
>   chardev/char-pty.c       |  9 ++++++---
>   chardev/char-ringbuf.c   |  5 +++--
>   chardev/char-serial.c    | 15 +++++++++------
>   chardev/char-socket.c    | 17 +++++++++--------
>   chardev/char-stdio.c     | 11 ++++++-----
>   chardev/char-udp.c       |  5 +++--
>   chardev/char-win-stdio.c |  7 ++++---
>   chardev/msmouse.c        |  3 ++-
>   chardev/spice.c          | 13 ++++++++-----
>   chardev/wctablet.c       |  3 ++-
>   gdbstub/system.c         |  3 ++-
>   include/chardev/char.h   |  2 +-
>   ui/console-vc.c          |  3 ++-
>   ui/dbus-chardev.c        |  6 +++---
>   ui/gtk.c                 |  5 +++--
>   ui/spice-app.c           | 10 ++++++----
>   ui/vdagent.c             | 10 +++++-----
>   25 files changed, 113 insertions(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


