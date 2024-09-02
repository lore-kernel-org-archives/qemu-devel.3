Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47919CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 09:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl3UO-0006TN-BD; Mon, 02 Sep 2024 05:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3UL-0006HK-Qq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:36:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3UJ-0001n4-Vp
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:36:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so653609f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725269802; x=1725874602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZXuWsHW6/LxNc0n38ynd4lMvu+4T0fp2E59f4Kww/XM=;
 b=VtV7KmYpiimlyDHZyWEwg6ibbB2ItEyp7vA3Xzb02oYkroUbdPsddPe9o1Qq9lDr8l
 AGheuPhPw/B13ub1XtMuOEszn+AxI7mUnJRewJSROr5Y6P8/Jrwgw1/o8AYLrcFukD4K
 ZBPQxLUYfGlDV1upVldp8ticHER09Kl7rCt7y8tAS4P2YFT83CM33U9p8Zj/l9G44vAB
 ZQmwzBicyJ2NYPIJFxfZ8es9u1s0kCnV6OLvTU7/4d8JVWW4n8O+IRS2gqCWdAH2ojhX
 NzkOTfVKAc+a9RuXib1HCooRwQNQNDED8SdvVS8KuwgOLKeJOq5dgfuNg0MqxQ+KJp6Z
 W+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725269802; x=1725874602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXuWsHW6/LxNc0n38ynd4lMvu+4T0fp2E59f4Kww/XM=;
 b=NtvmchuaVpZPwoqVH0yGTKeSbQQmqVQhnI2TRcxhZMLrwcqO0ghIhzzRHa1CECcicE
 95+TAOH6vLE3Cs+Gr9CD3sRAnSyO/RT8HikbNAlNuXTOzvJN1A1+T5AMqd3Ix4qtyZBw
 6OnvJy43DgiLT52V1MjcNbe9UJPoxCiKaJKl819v9mMBRm1iIYZAsTtzb8ZYgBtigR8q
 k28o2S4agl6rE6dem7BjhRhIqC+3vBNviRg+dQuriQ3ueKCYI4KrutKAoQuh9cQ5oZXL
 4ZFprF81ODxJQBBqFFQEhL4+8OcwF1lS3QL7fFt6nULW/QMazLuWvwYXbmHd91FpylbB
 4uGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyd/5p84SpSytXvaWcn8F7kQvCGkdU/J00q+nMmA32gwpRp0VzuTZmav94NfWj4JdvCNbplJSg8cn@nongnu.org
X-Gm-Message-State: AOJu0Yyhr3C3DrxuCpHbqorin1Jv6qrsyjHgPJFCNqUOCqGyO8g6Rz/x
 YStFvEjB/GnRJVFaCFec3MoYt4CMGvm1UsxRJNG9m9bqPuyJM2QMw/fvOyrI53w=
X-Google-Smtp-Source: AGHT+IFw7oyycpgWXbvsfWXuL7FBTCAvfJxQJNl4jUthDL2bGLozkC2t7/RsKZ2IqnYxSjYzdOGYaQ==
X-Received: by 2002:a5d:4f0a:0:b0:374:c2bb:8387 with SMTP id
 ffacd0b85a97d-374c2bb848bmr3642316f8f.30.1725269801991; 
 Mon, 02 Sep 2024 02:36:41 -0700 (PDT)
Received: from [192.168.89.175] (104.165.185.81.rev.sfr.net. [81.185.165.104])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee71650sm10832340f8f.40.2024.09.02.02.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 02:36:41 -0700 (PDT)
Message-ID: <731e1b48-096e-44a4-be4c-82b9fa0444cd@linaro.org>
Date: Mon, 2 Sep 2024 11:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/44] tests/functional: Convert most ppc avocado tests
 into standalone tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-26-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830133841.142644-26-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 15:38, Thomas Huth wrote:
> Nothing thrilling in here, just straight forward conversions.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  9 +--
>   tests/functional/meson.build                  | 11 ++++
>   .../test_ppc64_powernv.py}                    | 56 +++++-----------
>   .../test_ppc64_pseries.py}                    | 56 +++++-----------
>   .../test_ppc_40p.py}                          | 65 +++++++++----------
>   .../test_ppc_mpc8544ds.py}                    | 29 +++++----
>   .../test_ppc_virtex_ml507.py}                 | 29 +++++----
>   7 files changed, 113 insertions(+), 142 deletions(-)
>   rename tests/{avocado/ppc_powernv.py => functional/test_ppc64_powernv.py} (71%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_pseries.py => functional/test_ppc64_pseries.py} (76%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_prep_40p.py => functional/test_ppc_40p.py} (51%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_mpc8544ds.py => functional/test_ppc_mpc8544ds.py} (55%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_virtex_ml507.py => functional/test_ppc_virtex_ml507.py} (60%)
>   mode change 100644 => 100755

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


