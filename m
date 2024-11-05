Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111D6D2B928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jg8-00052C-FC; Tue, 05 Nov 2024 08:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jg5-0004zp-Sk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:33:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jg4-0007X4-Cs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:33:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so64747565e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813579; x=1731418379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJrClJZVW5JpUQ94DExDgaggJsOe5PVA4ZSfA6mYt4E=;
 b=isyJy0U7bKd30lVgO/IZgO8jQ3hQ+sGj6OSa4BKuwSNnE+S+A4FQe9pwBytZcG3sVL
 qReYESLZGcYuCPNET+7LqJOrOImlTBzaBD3PTnaLGcV4bFZQW+Qhq91YC+wmEESLwsed
 bjoXIjGuiG2xBuAZRUcw17hcjbhBCKpPKFKOKvAIggylQiv86+D1pnIoZgHcFKSr0VZI
 ANM2c6pWZZ3YHv4j5QC529OeShxFBKry3vjGrx6Wv+VdpenYU1MSBy6e0V9r7JiXw8Dx
 f1igJlU+vQd1FiVpuYP6R3siEDw9G/OVBZeausQVunn38nr4gpkkxnMXvjVu+7EB2dUl
 JYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813579; x=1731418379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJrClJZVW5JpUQ94DExDgaggJsOe5PVA4ZSfA6mYt4E=;
 b=QulKsMuFhco9rZ+8BqIHoglEIenh434J9dlnEcGt8sdmVo1o/BxIbM/DHdiKQMHov7
 rOAl52XyIjLN0w1m+fEiVOp/hdSAjeAuIuemYR980ryWELVAmo2xI1WCz2/SJPrH5OvP
 F8wLPILnrKl7gM5Y2rSfWOvNw/kxT04dlmNRNKLzB/HdB5bPHwiO25EkjgXkIF0wCPsE
 BCYVQLmD90fGU3SzW0w1eq2P5wVU2oPN9X3I2qFil26UNmJUynz+KuYTxtomybMVRr91
 WjmtvKc5ZEaIlM6X7Z2EH2GeOvQzKWvY9n3wjGtuqWV5v9nwhsqSMY0qC2tM2GhHY9K3
 O+2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYV+6rCrnTy7NYP5T6g8wxWbRD8ICMQIp8arH/POqCiw2a4UDTzJMVdkBEa8XqKC8Re1d3SmiI/wu+@nongnu.org
X-Gm-Message-State: AOJu0Yzen41GQGUTD++jPxxOUjRn7BEIjXaQPT2nlHHJS5QAhNRc1Oek
 HwNklJfRCELRa42lOuXIo9xHoBwvmpHGpHxn1Aac9AIm/YcjbeFpwgkwP/GuYXA=
X-Google-Smtp-Source: AGHT+IHBVijnoHnODR+Arqw2/3/iFrck71zFNhYUPw/fm+SQjsr9iOlrtVkTvoc0sM6VM1mOGzygxQ==
X-Received: by 2002:a05:6000:782:b0:37d:542a:7995 with SMTP id
 ffacd0b85a97d-381c7a6d37amr17165013f8f.34.1730813578634; 
 Tue, 05 Nov 2024 05:32:58 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116af7esm16231533f8f.103.2024.11.05.05.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:32:58 -0800 (PST)
Message-ID: <ffb56b46-cae2-4428-a3ac-89576046f32c@linaro.org>
Date: Tue, 5 Nov 2024 13:32:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] target/microblaze: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> mo_endian() returns the target endianness, currently static.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

