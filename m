Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C73CC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj471-0004BM-QV; Mon, 04 Aug 2025 18:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj46o-00045V-SL
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj46n-0000Fj-Az
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so3972293b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348204; x=1754953004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXmJcDFY/K6kmvJKvRb9yzIOFxWc0d1jqukisbQaPXI=;
 b=Vz/GVFc1HG0nsvV/2H6jyUL2khw3RRSftt6MPuGObWLYO9dwY2S6JCoqhBEIUaOZN0
 oo2LZxHalOjk2G7hq4D7lNMOss94rjztfA1Z1TJuaUrgtNgc6+yH2N6FX7USC0rq9iaY
 B4FOhibQ/XBxnYNy/eKYZE+IqsMwMCPPCqDNdKnTqCZo1cged1YXjPAMSXdwhZQe9v60
 VbpjyDAiIZQyjgqPDzrmbYfWfVxmUtbly8Qlaw4e3D2rhzgoOrr5ADpEdmfCfGr++4XV
 18QqcBhUG/8quVcZTsdC9G493vSnobwPF1NjxUsf82vgmG7EIV5Pybo+GvbOxRCri/O/
 GHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348204; x=1754953004;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KXmJcDFY/K6kmvJKvRb9yzIOFxWc0d1jqukisbQaPXI=;
 b=KoH2Z+FyRQ9oAtC4eljXZrHOSZJzttolcKJWWZ+lj+x7pe1Bixd88YrJ5IplUDbc3u
 6bOH/rsrRRrbYNZcutH/o089olP0xwv2a+R72tT/efY+p7SrnSuMkoWvCjBRkQpnGoSL
 /1iRRzKTi78Hvsk1GSqDEzgEEeoxPIuo+P3TQnblK7SoyX0nHRJd5epvyBIMfJNRDfHq
 GgAqnbVfaTLZarqZGRzWkASfQztWhsda8UsfTOumHeqNQ3CJS+LSPIEz+SwCsfnWUdMR
 oSynGmb6lR3Tf8EYvEKAJ+v9yQfz+kmioCskNqvAGIQDQrNzvDz5X+Mh+jhVmecnytXI
 re8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBG2VxU4SnGx1ThacS+nUI+9CYX3cBD6RuNHSiXBJKt7cn8CYuwpZAdIfenyGP3KvmYSbLVwCXOffP@nongnu.org
X-Gm-Message-State: AOJu0YzVPnTAtstZ4xBaG8xNs5xHL+gDkdNcMKeLG6D++gVPZWVSAf8L
 0z5jO7tfcxpTMuR9rWCOvVMdO9TfD5ZUug1XHjFbpOu/yT2EH5mBCyX7AijMAP7ZnI4=
X-Gm-Gg: ASbGncsYKbFLcKqTsTYxHecWY6AAUPvipUSFOJdSKwVDu7uz8baxCegIVh1xc8FSFRC
 RQC3wJWRXmKW1QQLHA/zqD1WRSqg14/ZxBL9Pza/MP/pBHLMkaWmYneIS14Cg8uMcREvPy0r+uI
 5W7r5vrp5XgWxFTY1CJcAsRkG+VepZ2D9GJKjL8ChKf3piGFfmMJH5VE82jOr4erPAUt9l3Yt9f
 9QwDvWeX9421klAnv6pjlnz63SaupjzYaUcNrBtXH8/as3QY9iIuk8rORlIktHZgQvxW0c4w2iV
 YynaJoz59AnaWtWC4657zYQH41bfWR/as0H2XGBTc8502B9MrBa8BaSRH2GEqIVh6kjSgA1zZdw
 9zv5Rd4vJkfcckIsjhvHS8DuDrxnI7PW12hIdIsEI
X-Google-Smtp-Source: AGHT+IEYwQLXqyJ2ojex8oje4ka/V25DO3QQcq0DaGDHRYahPslLoNdskn7nBHOzVauqw6sC9swNYQ==
X-Received: by 2002:a05:6a20:3d11:b0:23d:58e9:347a with SMTP id
 adf61e73a8af0-23df906a3c7mr13762018637.26.1754348203792; 
 Mon, 04 Aug 2025 15:56:43 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd6aacad9sm10411500b3a.124.2025.08.04.15.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:56:43 -0700 (PDT)
Message-ID: <b7c6b929-ec99-4eb2-9f9b-c91632dd8ac3@linaro.org>
Date: Tue, 5 Aug 2025 08:56:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 03/11] hw/sd/sdbus: Provide buffer size to
 sdbus_do_command()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
References: <20250804133406.17456-1-philmd@linaro.org>
 <20250804133406.17456-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250804133406.17456-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/4/25 23:33, Philippe Mathieu-Daudé wrote:
> We provide to sdbus_do_command() a pointer to a buffer to be
> filled with a varying number of bytes. By not providing the
> buffer size, the callee can not check the buffer is big enough.
> Pass the buffer size as argument to follow good practices.
> 
> sdbus_do_command() doesn't return any error, only the size filled
> in the buffer. Convert the returned type to unsigned and remove
> the few unreachable lines in callers.
> 
> This allow to check for possible overflow in sd_do_command().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/sd/sd.h       | 23 +++++++++++++++++++++--
>   hw/sd/allwinner-sdhost.c |  7 ++-----
>   hw/sd/bcm2835_sdhost.c   |  7 ++-----
>   hw/sd/core.c             |  5 +++--
>   hw/sd/omap_mmc.c         |  5 +++--
>   hw/sd/pl181.c            |  6 ++----
>   hw/sd/sd.c               |  6 ++++--
>   hw/sd/sdhci.c            |  6 +++---
>   hw/sd/ssi-sd.c           | 12 +++++++-----
>   9 files changed, 47 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

