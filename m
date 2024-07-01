Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48224C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIoi-0004cq-ER; Mon, 01 Jul 2024 11:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIog-0004LG-25
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:19:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIoe-0000wd-1f
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:19:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-364cdfdaf91so1799939f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719847178; x=1720451978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmkMzPE5NTH74ppdsACIW6tR2KlDQdkgFUs15vGMRi8=;
 b=pHgJ6VCiKha8lSMa8NXnf0UQhsaXzs5N8Othc/Sqc7GqgqGJ93rXUuo51GRVi/USUa
 on32Vlij1DdLmXd88LfylFRBRhKiwMwWfx0TPQkqs31wbIB3khHKO7aK1lLcAmUGKrSL
 N5+PidEWkiVMhe96J386AMAUpCZGqqdUgHJrscnGdM/fBW54UCIjR44PSUnuYub0w5do
 BN9KjWVxG5b816KHtX58k/CrXyN261aVigtZaOPLFExN6whQtjWyZpjdXsrLPaASj/hl
 kkm56I23jG0xTJPqAzOQGiHPE4Z9tF1iAcLgN+AaKyxW0Sd2YWquSt/K/9yk/nPfWCmK
 BHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847178; x=1720451978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmkMzPE5NTH74ppdsACIW6tR2KlDQdkgFUs15vGMRi8=;
 b=Hy+hZoWhSBBjT4zSZrQf/hiJ+TdNBMpHOlrmrdYo33AKx2nPOSx+0jxYE2LJVzetA6
 pVmF8d9JcYjpGg5KpLGLE22JC8KwPNJQTISyrpCOru25gP5NqckqJhZri61ztEyIIW7Q
 sQjT+U0rF4i6pZ4y4+PMGr3UqVSXGmybLiDwz0rU4cvpoELkeE8MV0esVZuhySAFZkzG
 nl6gjcTw09l9BzRCSuuMq04CHYp9SgEPh0IeX7Yv6YmMcIMsHLgzS1nShLXRwBcdcUtp
 R3M0bB44FvWR+OV+2dp/wUB03ThcJI+WjksSEyVlICRj/YtjvkECuxNAj+r8A3Wz2lvE
 Bh1w==
X-Gm-Message-State: AOJu0YwT6SsILYGBhhQ7aECdb4WS4Tc4y7B+IeenfEa8AcpPBCc7165y
 TFj/T//zQrGzPSSMkvrdwyJ2KX4uqNzsko0scH8WA+iGXbrpcdYUzHHmitP/g3Q=
X-Google-Smtp-Source: AGHT+IHaLLlVFV91BbI+eb/iVPMocq2qaF4A0eWayexNFw7lmsTWjxFPCFsjl5gvwgwvvrP3JTwAng==
X-Received: by 2002:adf:f406:0:b0:35f:1161:e1a3 with SMTP id
 ffacd0b85a97d-3677569dd84mr3878102f8f.5.1719847178197; 
 Mon, 01 Jul 2024 08:19:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389efsm159096135e9.7.2024.07.01.08.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:19:37 -0700 (PDT)
Message-ID: <69dd0d18-8e2f-4741-8c95-f9d32fa7fb8d@linaro.org>
Date: Mon, 1 Jul 2024 17:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] net/vmnet: Drop ifdef for macOS versions older than
 12.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <20240629-macos-v1-4-6e70a6b700a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240629-macos-v1-4-6e70a6b700a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 29/6/24 08:24, Akihiko Odaki wrote:
> macOS versions older than 12.0 are no longer supported.
> 
> docs/about/build-platforms.rst says:
>> Support for the previous major version will be dropped 2 years after
>> the new major version is released or when the vendor itself drops
>> support, whichever comes first.
> 
> macOS 12.0 was released 2021:
> https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   net/vmnet-host.c    | 24 +-----------------------
>   net/vmnet-shared.c  | 13 -------------
>   net/vmnet-bridged.m | 13 +------------
>   net/vmnet-common.m  |  3 ---
>   4 files changed, 2 insertions(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


