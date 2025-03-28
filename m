Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B45C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 18:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyEDZ-0003wM-0l; Fri, 28 Mar 2025 14:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyEDP-0003ux-Mm
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:14:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyEDM-0006y9-Vu
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:13:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3996af42857so2410997f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743185635; x=1743790435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWmjWbJTtIAYNYUQ2u82us1cHERqhSJInUITv5oEV0M=;
 b=cJ4Be6kuc4IJzmpcuwFh+GjuXFuekiklw8XqAX1xs19ZUN8O6Jx1ir9Pds9Otldxme
 BICQjmmgIRtxlNeu1Al6SOY0xTkCX3qzXT4+GK8+FxZuBJRH98+JaFiOL2KB1pqrOawU
 +CDaYxiUWGg75EUdu+42uFZClymIXQa5Tec8iexQcDyroNnAuXlD/pe+N56pX14lVLTr
 hJW8c+M0Z7WX+2SwEiiQCA0u5qEz/izuEUsQh830sgaLycnZtpDld8Qwy34eavc0NX59
 UpBmkfYpJ0wA+hCAiZebAFjNUZHbN8QZcn6k18VsRRz7pwvGcn7Rzx4RQXJNnYk8Wtrz
 GhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743185635; x=1743790435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWmjWbJTtIAYNYUQ2u82us1cHERqhSJInUITv5oEV0M=;
 b=BYHt/ADM6qhu2C7HWH9BJjWLGQzf2zN26AHWFLoh8cmFbZOSNirwf2XOwdFbVJFzZu
 mPdk+b6/q77TBsgKB90mmB7/tKLA8iQLpvUBYhdDNGESnbaGYfsLXrfiYurycfrcdEyE
 KyLkChHhmGfpugRmAIQbTdu4fxFW7q4iNXBtU5dyt7V4JBU4dYWccsImqSg+1iPEjAXs
 rvGg/2eDzP2ZreIj3fNtx/GmgMqt+D8dBCiBr3QU4acAYJTfF1ngGq5PB32zN36GiHOC
 WIqVQoMm5hixCGIiYmJjkVBnNaVISomjlfn6ZdFSG2FsEB0Ip/EtGt26O5obopisArpc
 Fxjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECIeDW6YIBTe1A6D5y85OS06OncsOLIUgFcAJ+LbSow7d9K9CSQoF3FUzOSnd2QQ01MiF/oHQUtba@nongnu.org
X-Gm-Message-State: AOJu0Yzrt+drYlkmNhwprfrOtri00ztx52f/2YMZN1OBOZDgJ08uFS1F
 mCp27YuE1fda4QPgEr19NHsee+6IXGlzHXlfKc7HOh0T0Mi6WxBAcRXiSGoYGPY=
X-Gm-Gg: ASbGnctyRZ328kJVvLpkuAPShJXYA6zgc8vEQeFyR0okEI1WPfdZI/kEUGxKV7YhKJP
 29c4IA55+kWGj0CQe8wpKysVO2VCttqqALI8469gsxN/crWaBZnoBaWyzDl0MmlN8xaD/qtmmKl
 5C0Sz2hnAB1QJxm1IqGP89PmeoxnMbhLZ3PwVliPM4lZs94ooLozVooCa5bPlMGgXUZ6QkubR2j
 vdBnPM6FvGhXC1dCVDK38EVfksAIU2sXIeXBKYmgZnC7qKY2CMFKRi0I5C9qbi9DSET7uZO8G94
 mAqLbSXveMW6ZTpuhiTyWx7LGNfwVmUtVX2oqlTA3AtqoOzSnsdrqPs9hc0f+0cot7+DX4t8g6q
 /b7msqpgkiAw3
X-Google-Smtp-Source: AGHT+IETBXYuQdwBimcByRFMgVSPr6LB9zpS0MOygS7dNGhnW4wcovJusS2mk1PBPj90STsz2S76Cw==
X-Received: by 2002:a05:6000:4203:b0:39b:3c96:80df with SMTP id
 ffacd0b85a97d-39c0bf2a117mr3414285f8f.11.1743185635212; 
 Fri, 28 Mar 2025 11:13:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4351sm3363741f8f.98.2025.03.28.11.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 11:13:54 -0700 (PDT)
Message-ID: <b4f50fde-b339-4345-824c-98abcf62bf2f@linaro.org>
Date: Fri, 28 Mar 2025 19:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Remove semicolons at the end of lines
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20250327201305.996241-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250327201305.996241-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 27/3/25 21:13, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Yes, we are all C coders who try to write Python code for testing...
> but still, let's better avoid semicolons at the end of the lines
> to keep "pylint" happy!

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/aspeed.py                    |  2 +-
>   tests/functional/test_aarch64_aspeed.py       |  2 +-
>   tests/functional/test_arm_aspeed_ast2500.py   |  6 ++--
>   tests/functional/test_arm_aspeed_ast2600.py   | 36 +++++++++----------
>   tests/functional/test_arm_aspeed_bletchley.py |  4 +--
>   tests/functional/test_arm_aspeed_palmetto.py  |  4 +--
>   tests/functional/test_arm_aspeed_romulus.py   |  4 +--
>   .../functional/test_arm_aspeed_witherspoon.py |  4 +--
>   tests/functional/test_arm_bpim2u.py           |  2 +-
>   tests/functional/test_arm_cubieboard.py       |  2 +-
>   tests/functional/test_arm_orangepi.py         |  2 +-
>   tests/functional/test_s390x_topology.py       | 12 +++----
>   12 files changed, 40 insertions(+), 40 deletions(-)


