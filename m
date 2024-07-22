Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51331C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1G2-00064i-Do; Mon, 22 Jul 2024 18:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW1G0-00061q-MU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:11:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW1Fx-00016Y-Sb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:11:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso2261287f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721686302; x=1722291102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AIVvv1BDlHnF4wBQD2bsGJRw13ULa3cNiyXd0dz5GxE=;
 b=cxYCKsPlaW0eu9q/MqwivEwLNjTQQelK2KTEMj0vOasxncgxZiLZBTt+1LqJFfmVQQ
 GyEiOVRsyfnXv3hw51vrDRlh9bXYV+i+faMwgVWCw0nBCuAnwdq6rksfUwUpRKGwdy5K
 WmM8LVhOPRIwB40McxqapGvJMwbYp6twWy0HleNrwJRLlh8f4RpueZjPUy+H5KC9RDq7
 Cb+UbNX6ayw2+SgxQiTeht2kUVELi646oMIA7RSBHAxYUOMWJ3p0F9uVjeWORndu/8nn
 PpFfJ2EQebbzOUpp1UFzbeCZPRtf9sQk6Z+9K3Qgp4nUjxoZCJUg0w7Cz5TwwEKBphKb
 bw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686302; x=1722291102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AIVvv1BDlHnF4wBQD2bsGJRw13ULa3cNiyXd0dz5GxE=;
 b=b0IT6VTQslfXWE/8MtHpBNYSve8vftK0pnfq3N5fhn4nP8BC++VZaeezg492QbgnBw
 ALej0flzKjXZP6I8U1mp/bOC5/9ueDxmyRxNrQG7liaCtPyZ3PK4qWfKt7vW0Lft06lg
 fqa61q6QvNT4DMfRl54BB+gbRmRqWHhdmNqBsV9LFTmtHktbZDi8X9f3WhB/yp5Zw4Jz
 apmCabz66z9tFtY7KyghGHvO2ItisrQ28BzayRPVf8yM2SvohhNKPJIBF1VwAsTvFWSa
 L722Yd+/RfyenO6wTkRc2a0GBqjPiBYy9lDRqDY0Q07/ReqnYsPedlYVCAmxvlvti+nu
 UOtw==
X-Gm-Message-State: AOJu0YwhYbayIYovP8HlHC84Cw9fwiLoigiI8pQUHTKU8wr3WKH5RtOp
 DTmHANSgvXIgYAwkadxUjmEgpDEy1QLzmrt8/ccfIpaY7vHPkCTSPdfQ5iNK4r0=
X-Google-Smtp-Source: AGHT+IHZ0XKx0SRLKRGNJGVEd9Xpa0hY4OWrZGew1Qw32CV2wHuTVzIqHQJ1EhUQ6+qEUQLCicsYpQ==
X-Received: by 2002:a5d:6201:0:b0:368:4226:4084 with SMTP id
 ffacd0b85a97d-369dec0488dmr729611f8f.6.1721686301911; 
 Mon, 22 Jul 2024 15:11:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6937fc7sm144956295e9.46.2024.07.22.15.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:11:41 -0700 (PDT)
Message-ID: <f2f6c27e-7625-471f-b888-0f3a870bb0c4@linaro.org>
Date: Tue, 23 Jul 2024 00:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
 <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
 <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 23/7/24 00:06, Warner Losh wrote:
> 
> 
> On Mon, Jul 22, 2024 at 3:54 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Warner,
> 
>     On 22/7/24 23:43, Warner Losh wrote:
>      > Add the aarch64 bsd-user fragments needed to build the new
>     aarch64 code.
>      >
>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>      > ---
>      >   configs/targets/aarch64-bsd-user.mak | 3 +++
>      >   1 file changed, 3 insertions(+)
>      >   create mode 100644 configs/targets/aarch64-bsd-user.mak
> 
>     Can we build aarch64 on Cirrus-CI? (not clear on
>     https://cirrus-ci.org/guide/FreeBSD/
>     <https://cirrus-ci.org/guide/FreeBSD/>). If so, could you add
>     a follow-up patch to build that on our CI, patching
>     .gitlab-ci.d/cirrus.yml?
> 
> 
> We can build aarch64 host for bsd-user for sure. I'll see if we can do 
> it in cirrus CI.
> If so, I'll try to add it to cirrus.yml.
> 
> This patch series adds aarch64 guest...

Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD
aarch64 bsd-user guest and test it. Am I wrong?

