Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8400ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Ps-0003IL-V1; Wed, 29 Oct 2025 09:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Pr-0003Hj-7J
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:40:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Ph-0002A0-B7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:40:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso31920695e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745224; x=1762350024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2rIOv0MNcMBqR3sa6je2kdt9WMKqEsPnfpCTJTNjr2c=;
 b=C/lhhQ3noKkcvjvd/mmofIACf/tLqE4xVPGftWWFIDKA86zyRMBA0WdUyMDHqnDPJP
 AIoy6RAG9zIXZRvJoZxOeqEWq0wJnD3Lor9IcDVAnk66z4n8PwsK506GLxKVh0JpinnM
 LcGKLmh6t+lnyoR6Q2SlF6Q4dd8yAIrpB8o06bdDOQRoaRCkhlnPv846PjOw+Dw52EDf
 rA7cmwOYF3yY9k8RDmZoMV6YSBkWAXy0SzVbT4JPV1pnjnSjhLnUAU/a7LocDAept+Yp
 YJl6+flY5NnH4TFQg3CuPFDLaN9dSLEEt6Z0Q2ZAPKIzmw/biYMVtrh5REyjbU0CArpm
 XcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745224; x=1762350024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2rIOv0MNcMBqR3sa6je2kdt9WMKqEsPnfpCTJTNjr2c=;
 b=bVwzRzFOcu4xlaZjtdCOSsa+nbkuuxarGLVTfan4v8LnSb/qYlR2xq62GJFE9kEgXJ
 lVDziaFziXp4s9TDpw+X2H8ZsqUyaLnmZpDdI8qL3m+u97y+Ljf3ym2Y8v0NNzUMNbJS
 V/A+/fs0XSXwDAjGTJUVDNVa1Ku0H90wjRXW1C90ESIzqxdBuqOSEwCNW/z0KS9QWnmw
 iHHCmnWTs6mJpXhAoU1L6S4lwmwbgZVuSMVm0xVGCZmSC1ilmT4BGnSsmdhbXjBOCzj7
 tjn6dpamxLsHpA8L/FU93VsDJaUJ1xU/qUxzpgsBWPuYx8VIcPTaG9t8xX0miL+vCD5J
 xS8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKKEvgTyVasK9+ZlqdNHRnXFcmifVON2h1tQmKL5eVdLxSl8ktgobhhqPdUmp83dyJ6/1Q2v9ZPc7A@nongnu.org
X-Gm-Message-State: AOJu0YyKBp2T0TCSHvR6tNtmdMQs2KkAYI20a3+PHe2BTBegfLAmY5wX
 zhaDW0JBWFXh+c830sfNlOIswX2LaIc5qE4V3gWTAccyEv6Yjn+TCQK1RkzSt5/BqRo=
X-Gm-Gg: ASbGncu3kZB2wvWOETH69+xIwa9Y9zv3AGnt0GW8myqTTg4shy7WKgzXM/AVBvEg+e3
 76aHQPP0KImEc+efgMU9J0Jo6N3AcIFGu2Njk27Sj5A1ArKD01UjjwO+xUtfrBI0QobZbeEypWL
 7Dqc04obr+xLvolAbtdfMZGV9MlpaCbaRT6688lvh/Z9xhyNSFr8sVdQKHFM8PiQV4eovjBrx6J
 EaXS7/ZrORCYyzXPDocLUXQNPbsyB3K+0UFR9jEFYkavUijK4LM6YxoqZ7ajhsHtPue3J2byT6R
 xXX8ugoQq/1HqhIDf1cf355+75uGN/gCRxNQ/0imT5mMApe0RP2SvG+MbByFUY2U0coiLYzECVT
 eIcUnwDjqdn2gMKBir1ez2BWCLUx7C2RQhfJMHKRHMGsUOlC0qSQlzEX+z28KLirzRiIqlhtTmE
 dTwC/+01EhA3N5eRvXpp1gO6i7eH0i0XDDM98IQhVqlrs=
X-Google-Smtp-Source: AGHT+IHbZD4bhigiZ9keP/jpzmnyR1hTwly0W76qSUHYeI2NgIp7PlAHHfnEWfNvx9X3hfl2HA+LJA==
X-Received: by 2002:a05:6000:2281:b0:3eb:8395:e2e0 with SMTP id
 ffacd0b85a97d-429aefca8a9mr2467911f8f.51.1761745223886; 
 Wed, 29 Oct 2025 06:40:23 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3b7cb9sm58683485e9.15.2025.10.29.06.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:40:22 -0700 (PDT)
Message-ID: <1006abaa-39c5-4254-9b16-994208740bbd@linaro.org>
Date: Wed, 29 Oct 2025 14:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/35] audio: drop needless error message
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The only reason it would fail to add the handler is if it's calling a
> stub. But this cannot happen as audio is only supported with system qemu.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


