Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3638C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrWa-0005Nc-6G; Sat, 24 Feb 2024 07:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrWY-0005N4-1P
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:53:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrWR-0008MT-Rl
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:52:57 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d71cb97937so19554545ad.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708779174; x=1709383974;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIavSNyiB25TEOX1x/gl18rUkI3SgYhH1jQmrJtWc8g=;
 b=ukfChCoPzDArn5O2CeQVaQ3Ws0jnJaZMcXn9HPgQGg7Xx7adyFQG8mpVCYYEtx9R3O
 uc7NN2wyaQc3PL9c3V58/sLHHMV5NA5iMeHjD0SaYrRLV1cJ7etkZnP5aXW7UjnzuCMX
 ZHzhNHezbRJw1EcJZOA0T11AlLuxh4vqY9+ZyqrXZrCVz/2vk2T4xo+DYbhbTTvOang5
 T+D8xs5BtkkrdK3OamS2dGoUQxX6EuhXhIDnNIpTISQ89YUdbq1x0/gvKrVmddB4hCLg
 eOrx2vqkyzgk1/EMYWHnABOuFw3AwBhZp8TItGz0zrCMuw+W3Y/SupyowhRQLb8SvBzS
 kUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708779174; x=1709383974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIavSNyiB25TEOX1x/gl18rUkI3SgYhH1jQmrJtWc8g=;
 b=G/dpHkvfRqkckg1Nzgr5AHXUTW5FfXIl6fNvicZtWH9DhWFfezCG4XQavrglAuWPqC
 2PZ6BWLK7jOqRdCj9Imqxv0G/527WqyTJjW2q4GjMIX1WRevPIxq5vDTiWzn8TzB7T4E
 S/JAcCGFyaA5dAeUlRprJFB0/nryi54qPlGVAcWlMhatXnVN8tc4hCx8MB2WOH7TC4Ej
 Qyj3ji3z29rHaZiH3q7A7MWpYc/GzdYxjxEYDsJzukeRbwvxnwEGmwEUrmTK7E/l9X4u
 Nwu7flTYKzHwHR+i/MsjHEPc1XaJPKRVF/Ow0JAGYY3VjWcJFtdbkabZFHiPE6lTlTW8
 dsvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUj8sd2leEmbTWJWMgtDekldFfgZE93gR1VNcB4N4bWSkXm9rVEVO/PvIFU2U4Fdp0EzQfF3TkGnUjs8RM6BrZXS1thfQ=
X-Gm-Message-State: AOJu0Yz8Svqc2rJ08rB/QgHM9Ofk2ygfYxV1a71KoRcx+dcaYSfF7RaJ
 fViYza5QIYtBe/zm8hvLpjZdhdt6fWSMm/qc+wv2CBv8kMLkXC3GFHzE9xLKBtI=
X-Google-Smtp-Source: AGHT+IEvJyzn1e53pXs6TUmNZ7fynRAJt5ZOPhjAqIC5pnqrzoY3hIpxvXHzHdldth8z5lNMVZL/CQ==
X-Received: by 2002:a05:6a21:3118:b0:1a0:dfc4:a8c8 with SMTP id
 yz24-20020a056a21311800b001a0dfc4a8c8mr2879744pzb.20.1708779174233; 
 Sat, 24 Feb 2024 04:52:54 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 pl1-20020a17090b268100b0029a4f1335d1sm3265074pjb.0.2024.02.24.04.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:52:53 -0800 (PST)
Message-ID: <9df821ff-1ab9-4ae0-b954-6da095d48c4f@daynix.com>
Date: Sat, 24 Feb 2024 21:52:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/6] ui/cocoa: Let the platform toggle fullscreen
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-3-0a17a7e534d4@daynix.com>
 <CAFEAcA-P_kX_wM9VxTCLgOPp-Sw4VmvUJzC3ZyYrEgppUAqXow@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA-P_kX_wM9VxTCLgOPp-Sw4VmvUJzC3ZyYrEgppUAqXow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/23 1:56, Peter Maydell wrote:
> On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> It allows making the window full screen by clicking full screen button
>> provided by the platform (the left-top green button) and save some code.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   ui/cocoa.m | 423 ++++++++++++++++++++++++++++++-------------------------------
>>   1 file changed, 207 insertions(+), 216 deletions(-)
> 
> This is a big patch and I'm having difficulty figuring out what
> it's doing. Is it possible to split it up a bit?

Not really. It indeed does a few different things:
1. Removes fullScreenWindow
2. Changes mouse event handling.
3. Changes coordinate calculations.

Unfortunately we have to do these at once because how window is 
organized affects both of mouse event handling and coordinate calculations.

Regards,
Akihiko Odaki

