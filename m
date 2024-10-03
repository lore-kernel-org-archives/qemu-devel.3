Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD6CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swT5g-0000Un-Fc; Thu, 03 Oct 2024 17:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swT5e-0000Tx-NY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:10:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swT5d-00022S-6B
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:10:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so1153813f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727989823; x=1728594623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWpFlUxud6FVqSHTfZdybQl4lOYLhx3nrQzHyzM3D8E=;
 b=D++m8fAaxdMPT5E/JfbglV44ICe0fQ5QkGDuHN506X880h6gXPXYZKdlZo4kiK/e/2
 yU+FMUMJN0LEitnBji18uzxs1FYZEn/DQuTN+nvvWPccpeGGfAGPZqdZqbeHsR2rNIwg
 GQ/OYtvh0fzYPFvNbl4Uz3eKPWCPbfR9C0/jns8HyBUy/AgsZVQwnYMjDGEHZQvY/Um5
 icyxTkBkOViUm9FAw941RBHwqZbEkWC8l6ANyC9ToikoYp7aGzNQrArpdiOV+C9G7tet
 raIY8ffIgAK2KbmvbOAoYTEsPpKf00G9Toci84tWjVSaEUmsOMazk2DK0x6n5RpWehaN
 vxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727989823; x=1728594623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWpFlUxud6FVqSHTfZdybQl4lOYLhx3nrQzHyzM3D8E=;
 b=ijtGbhmKdN1DZSXQ+/bRy+VM9uYmhFJAHaN9/7TBQGJm4ewBhClCpAzDnPFuKOtlNG
 F9lgDK1QSnrnrWX9tiUGeCX+Us8tq03Mdogs0uR4Vd9CDDxE27EmjFXRp4ZVA1ptVzv7
 R25iBPkTes9JUxG1Sou8s3Qhwy+ldiJqC/sj8HUJVNffH2dLhIV5C+kQMYIffQtv4fD+
 IEphwZFVj9VJm9JR1B9ayOEQXUqc2aSsXPq8BAla8aw+NkbP8Hgo/2h3H66/qyXhFVdf
 cjvQu4C+0pgPr84PmuO05EcgfWM8MHgHIuWTQ3iTqDNbKgNs9yPVOK4gp/q8yAuW1tnA
 3Tlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbx3uA6j49VVZoj2S2P+rUzNw1MOuC3xGevKhyEEHCRBGTjilYaA4Wclb1C9GQUppkRYgQkXguagyT@nongnu.org
X-Gm-Message-State: AOJu0Yx7LEEjvxAw7mXNF4IElL2nbpxdja4IJDQXMnCV28VWqLFuzA9G
 W16+6xYDk1F3xabi480py7H05Mps15husw6dqhH/4gpqDvi1RvnvPQJsQEpZZTY=
X-Google-Smtp-Source: AGHT+IFp0a2f0n6FBkuG+uCtOg0mFvfTSgYqChzN+spfUEA0oLcR4bJ9ehYy2llqoGtqU9l6rq/6mQ==
X-Received: by 2002:adf:e9cd:0:b0:37c:d20d:4481 with SMTP id
 ffacd0b85a97d-37d0e6f2658mr429870f8f.4.1727989823359; 
 Thu, 03 Oct 2024 14:10:23 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082a6bd4sm1994061f8f.84.2024.10.03.14.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:10:22 -0700 (PDT)
Message-ID: <7381d79a-1087-459f-a4bd-9ccf94949114@linaro.org>
Date: Thu, 3 Oct 2024 23:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/plugins: Remove remainder of the cris target
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org
References: <20241002143708.376707-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241002143708.376707-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/10/24 16:37, Thomas Huth wrote:
> The cris target has recently been removed (see commit 44e4075bf4 -
> "target/cris: Remove the deprecated CRIS target"), but apparently this
> line has been forgotten. So clean it up now.

Crossed pull request ¯\_(ツ)_/¯

Thanks for cleaning.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/tcg/plugins/syscall.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 89dc7f49b1..ff452178b1 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -34,7 +34,6 @@ static const struct SyscallInfo arch_syscall_info[] = {
>       { "arm", 4 },
>       { "armeb", 4 },
>       { "avr", -1 },
> -    { "cris", -1 },
>       { "hexagon", 64 },
>       { "hppa", -1 },
>       { "i386", 4 },


