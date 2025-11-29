Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6290D116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLbz-0001Yo-Kx; Sat, 29 Nov 2025 09:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLbx-0001WQ-RS
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:07:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLbw-0005Kr-9k
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:07:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so28219735e9.1
 for <qemu-devel@nongnu.org>; Sat, 29 Nov 2025 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764425256; x=1765030056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPPrI4cdHUETE01tQcoQ0prV0rHBNj7Q1PQoGj/hnbs=;
 b=uvfzDM/qfl1we/G511er4A215uzavqqDqvxaKiHunZ7STAsfM5r4trh6Dk2MBbvNR/
 JdQbrZ8ghPUyLdhoINidZ8IUIP0cMw5zk4qFqBcSVBIEH1F5QVB2L9A8XVTcHq1FbIkk
 sPd1wMrGhmFe1mnDrJOJB9qg9Rvc0A6Vat3MC+YMsHE+90R46VEY9B4TvygFB+ECgnp+
 65scQM21MA/vNKEnmBUqwosCE6oVPiwVHbK4QZ2KRCocGJHYU4TIPpI3hie6XieA2oKf
 e2Mg/SQwylmB0qJUFLNLpWZUkSW5g4uR/5OC97wWv8DD+SZ0BcTrG+98TGRA4fU7/+h2
 32eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764425256; x=1765030056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPPrI4cdHUETE01tQcoQ0prV0rHBNj7Q1PQoGj/hnbs=;
 b=HONd36G544gau2AbnRU0GJAFNRyocACbLSeB1fPCPcNdeQgMiqZEJb5XJVCmvi54pG
 6tnzjOK34KD3CQ96RWR1bDL14212koFVoLSG+/JjrZImbVyPbddpMDGnnBTPxB68+4gG
 7K6AFKZFe8E6il1B7KvJoE/co6M7k5XAlq8sb5uie6fGzAalxXBqwcKvcZjiXuuzHyl9
 WlnkRKJRteaxu0dVLJbB6aqBH62UMppSztti+OSnaok+RVI7T7tnninJ8BPfLIpcKurv
 O9aM6LvrEoYQnEcrU4H0HutYWJbFPuUPIZ2tD5SRb96/OftqZVSJgQD5fzX9iWqgh53/
 U+fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0r+a86GKXizW45Sk/971DrHk+X0scfArWO8wc/srPirYoqE0gOhgI4vC4Wqoo5G89OavUZinY8nxe@nongnu.org
X-Gm-Message-State: AOJu0YyqmFVwO2HNccmTkZn/qgoKevhi5GxIF9J9zpgf1JCpMYBq43Qt
 +JuxCbEvX3EmcGRPlCIfD+LpI9f7O43EWSt3LfGG34WIusLYoVXbDdoxch4NC+fu4K8=
X-Gm-Gg: ASbGncsNybcExr+QVAZu8HAr95qqLhWGz7p7Z22LMXwo/EEtcSgqCgxuC6ZyxXRL6S8
 nQK0gJz8hZP9b1WbgyaXoQAsC93fDQGNoSgjhIW8Ri6luF/+EwKsTsA8PD8QkLIGqgtaVksH1Eg
 DuZGHXglXmRfnDupJ26GAZNc8+D9H5XerU7FrEWiieJW6/Oo4Q3HqBCcObPelN6nyZPl549VJ6r
 8un99FgocCqUQ60SHNklrrIAHGv+Ich57/1CziGkOmmDv7e71mBJGlJ0bhxuIzmQ9VlE+3FP0Bk
 ClQL+RiXZxfsOvPZvilNQsdOpAY1hkhqVTwIhkkiDmRYqIAMUz4CEByMS9lu4AtTVRxJc6ZGMZr
 IM2HlHF2DTjubTe2Jo50hl029IbFfMxFstaJ2w3xIqLG9if4uiab26zc56RIK4KM6rjNnoGjFUn
 nLfEOXhVTJa5NYDz+ddDWA
X-Google-Smtp-Source: AGHT+IHKI3Fa07sqI8ozMTtOEtG5GPXOI8HuHwQkYtf+Cibk7tO3oq6zWsQZIrO5rqSxZ9piJyeg+g==
X-Received: by 2002:a05:600c:474a:b0:477:b0b9:3137 with SMTP id
 5b1f17b1804b1-477c10c8886mr313813105e9.1.1764425256306; 
 Sat, 29 Nov 2025 06:07:36 -0800 (PST)
Received: from [192.168.1.152] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4791115caa7sm137457515e9.6.2025.11.29.06.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Nov 2025 06:07:35 -0800 (PST)
Message-ID: <fafc689e-f3d3-42b1-8d03-58d266ce19b5@linaro.org>
Date: Sat, 29 Nov 2025 15:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] chardev: consistent naming for ChardevClass handlers
 implementations
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
 <20251129134350.487839-3-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251129134350.487839-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Most handlers implementations has name like {unit_name}_{handler_name},
> which is usual and well-recognized pattern. Convert the rest (especially
> with useless qemu_ prefixes and misleading qmp_ prefixes) to the common
> pattern.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   chardev/char-console.c                        | 10 ++---
>   chardev/char-file.c                           | 16 ++++----
>   chardev/char-hub.c                            | 15 ++++---
>   chardev/char-mux.c                            | 15 ++++---
>   chardev/char-parallel.c                       | 28 ++++++-------
>   chardev/char-pipe.c                           | 24 +++++------
>   chardev/char-pty.c                            | 19 +++++----
>   chardev/char-ringbuf.c                        | 16 ++++----
>   chardev/char-serial.c                         | 28 ++++++-------
>   chardev/char-socket.c                         | 25 ++++++------
>   chardev/char-stdio.c                          | 22 +++++-----
>   chardev/char-udp.c                            | 15 ++++---
>   chardev/char-win-stdio.c                      | 20 +++++-----
>   chardev/msmouse.c                             |  4 +-
>   chardev/spice.c                               | 40 +++++++++----------
>   gdbstub/system.c                              |  8 ++--
>   .../codeconverter/test_regexps.py             |  2 +-
>   ui/gtk.c                                      |  4 +-
>   18 files changed, 153 insertions(+), 158 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


