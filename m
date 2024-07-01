Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF024C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJ7v-0001tq-3y; Mon, 01 Jul 2024 11:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOJ7t-0001tG-OM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:39:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOJ7s-0003Zk-8T
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:39:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso22770795e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719848371; x=1720453171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5YHRXvRLlF0wnThOFqhk+2ny5mfy9mI1V/EzXQdkRBg=;
 b=MRFvfE1rgsXG8jChcmejq9sJCSA2mtbKyDXOxd/Izw26DmFOc8j0FMxReUk53JHjNw
 h3yrC5BMlZUIzzGgk37cFw0pqV1EE2qmv4Gb0x7Ui7Y7rnJvt+pa3j+wio8If0+8YEvT
 u3/YVSSfvMw2+nr2VO6kWJ2qRyyTxhPiFK+F/ZGoXoVObYFi50zFifzGO8eziXxg3EMU
 2GOAc2zGGZRGIATZ2nxTTx1+JUcaQ4VerMsb019EXZHQ30uXFTTnuMqLJjg/qQAtTLe7
 xiWWp74IKX8t+uXgG1RfN22tUoheLmLRwgy4/L0O9hKM6heyfDK5Z5iy42Fj2Rich3QZ
 gqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719848371; x=1720453171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YHRXvRLlF0wnThOFqhk+2ny5mfy9mI1V/EzXQdkRBg=;
 b=o6tLDRsQTerHx3+BznM8dfuWB6UeJQZEK5oflaUhTSIELR165p549fX8s2rCIKSLbV
 Ajq4TUD8p97n95gRtIpmfH1Y8cG4++YcQrhx3QB5wa44IRe/6oatd9ywkK8dmw9yQMeH
 0wrnwtDpqN9Xx4rafBmoUyxlPspgwedIwANtktZsNLr4u3QsKPF2qdCJnTx7Q5WU/XgS
 o/62fhrHzz+rouM5uXilOKwZhyxRRrlDygmKn45ixaeadyAxK8ls39VQrUVNfoyH6u5W
 B4XczDm9hwHwb1p5zipFfZW5HJsg0Z5hsCUWrBS3/jg2GfJfhmJ+IIyrig2GhGLMQqp6
 w++w==
X-Gm-Message-State: AOJu0YxdStc3Y0sAFWQfmsvsAbO7x5T8aQ4y0F18qxAMaGNpA3SrRh4E
 jiw2o1uMnvYI/pkCk+YevDSAwl6yEgnWbVBa2c6XRzP26gqT3UuegemJLnVYusM=
X-Google-Smtp-Source: AGHT+IELfU0SsmoRw6XdBxFrwcMH74Ir40cQzhJaoTZNDCaCRfYviLRswrw3AXS4lQhBwt60IP7m8Q==
X-Received: by 2002:a05:600c:54e7:b0:424:aa41:4c15 with SMTP id
 5b1f17b1804b1-4257a0111b5mr40820865e9.22.1719848370776; 
 Mon, 01 Jul 2024 08:39:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12fcsm10347747f8f.48.2024.07.01.08.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:39:30 -0700 (PDT)
Message-ID: <6f6a7594-f177-4cb3-9ec8-2cd3ec600318@linaro.org>
Date: Mon, 1 Jul 2024 17:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 29/6/24 08:24, Akihiko Odaki wrote:
> macOS versions older than 12.0 are no longer supported.

> Akihiko Odaki (4):
>        hvf: Drop ifdef for macOS versions older than 12.0
>        audio: Drop ifdef for macOS versions older than 12.0
>        block/file-posix: Drop ifdef for macOS versions older than 12.0
>        net/vmnet: Drop ifdef for macOS versions older than 12.0

Series queued, thanks!

