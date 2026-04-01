Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CF5D2ED08
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vwj-0004DG-9Q; Wed, 01 Apr 2026 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vwg-0004Ag-3t
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:49:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vwe-00013y-NX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:49:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso2068529f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775051359; x=1775656159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heggDzAGN+LCYoNVrVVFKX61MluniPs8j/9lG8gE19E=;
 b=PX/uCPGsPkBDeBMBCeVDbW5n7Ho8jVukKCzypMZyUvbqW49eEpi1oo27b1f7RDQ3Es
 gp9X5yus1bzhxDqJSMt9JNOm/4r0LlekbNFO52L8CPDSs4sn/4YkQAWAmgb3PgUnroD1
 lvyP2iRrYymAwevl2luLOBjj8iglaQB0yLm1lirdhWsTb7t1w+P5XhVUlwKTgi7zZcfQ
 MJciM3yDYzCh51vc1OVXKTP33rCVqt8u/1WfxmfrUQlWaGcjbXxME0sp7kUZEM8a58Yv
 j9jlwCXDJJmaSe+WeqY0v48G9mjwBmqt/H6wbVEyIxpBEBxZ/mnofFQRprCA9F+pUSyJ
 PcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775051359; x=1775656159;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heggDzAGN+LCYoNVrVVFKX61MluniPs8j/9lG8gE19E=;
 b=nYe1eGmxmgIAB+UGidS8XmJdT/DZUjZYFaxaAhYEMZTMYWQt/JqqCcTh7s7FFFlR5q
 dOA6unfTkwS+8z1zSvpNd6hKcFzSnna1CTairhCmMTyCsGfD4TcM4eXRo0xHMJ1JYz3B
 jU5EzJ5ugMvBoScLrbXVgROnjfe71e0pfltYFU0bmbev1t1jZSGamI/pFPUsHeX8M70l
 28d9Nqh2nJlT7RuzDLarm8+btykxptvD09Hpmrh2O6OwQSUjJThXmEiqX3f+9h0EMoxb
 eJ3hhUaGCC4fSXw9+pgBNwl5zo38gEOA223TsLsDorfguMlZkVCSjWgZupLmyPBreJzg
 FSpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlOIBq7fumlE/yR8aEtMKjXFVpMVDmGbYmfRiIT3yMNvnp4XIV3r5/uC2+qRJscVMsr0z2fcqDI9Bi@nongnu.org
X-Gm-Message-State: AOJu0YyTTIzANpKuRiHC5HmEwjvnB7wO0MZ9UDgHa2ahpD62LWdpQNYa
 W0sw0n8Gc6VHJWYKwnON/ZdcN0ka1KCtCFLqff9mFO/JBklbS3fDtQegi5NXLs/mAu8=
X-Gm-Gg: ATEYQzwC6FlofXMJQlSDHQc4YAKgyhlyZEP05c53wFfn5TSGVATM7oIXhbIBueneaG6
 ShGL6qyAXYlOIRd3mopuOvCA8Ba/cYtnImzNhDjhsphWjyIFxDdkhaXudULQHVcEOsEQVkFN+Ji
 YP1aVTfnlOoVwUBmIBE/M3+VKehJQc6H6Qxzb1WIxMglstJbfBWOafcwqDK5j4mxKj8Iw1gtVgz
 BRSztQjVQLhwvo3nHv0HIzLk7h+7p5+y8WLUIi13Ii6OA1yi5C98jD4eIZdBGLq3wlWAfaETCTP
 ZxJOWBCuFnnto8tTHgwXtl12Bsvlo4Hmz5VSQCLTyQQ2wPNi9OabFhPE35FrFVB1v0Q7alsiyq8
 BWUeKbLXJS1NCcNiUrOo1BoPBOksQyRnAkxoPmeM1FWXV1juXhjJWvKyxK1Adb5pXAR+nrK/jFl
 iDiiclxBh/iocwdOgfVsGkApJ40M7QcR3ROQMUmd6f9/uDvdDEvqkAkp1TBIt7kueiQw==
X-Received: by 2002:a5d:64e7:0:b0:43c:f90b:5669 with SMTP id
 ffacd0b85a97d-43d150d5a8amr6979882f8f.41.1775051358945; 
 Wed, 01 Apr 2026 06:49:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257b72dsm36598535f8f.34.2026.04.01.06.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:49:18 -0700 (PDT)
Message-ID: <7e042233-1d2d-4812-b381-9c5121a43ec5@linaro.org>
Date: Wed, 1 Apr 2026 15:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/60] ui/vnc: simplify vnc_init_func error handling
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-43-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-43-48eb1dcf7b76@redhat.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 09:50, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

