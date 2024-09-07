Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35D1CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnD3-0008LQ-Ox; Sat, 07 Sep 2024 00:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnD2-0008Ka-O5
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:38:04 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnD1-0003qO-6R
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:38:04 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso3327215a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725683882; x=1726288682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Lg7M0oFQOS5nOzvqDPAhzRLVdfTSpNbLSqGsYqEMn8=;
 b=pO3UpmN44/vRJeoYTgSOWcQdigM9rSmSRl2Cc3rI+hoi3gAU5V6U68ptx2ol4YEf2t
 Ds2qD8ZbYxaWELcaaKZPonIfMsZcXB0u4UzMGyyNQg7pQHN9XJ0CMTEXa4sJvE75/kAQ
 nitQQCOFk/+QlVlHhP63DP70GhgJpfm04N/gnle+MkUqcQX7kX6DefyGNb9O/R5OaYZt
 Pqu99YKr6rIGCb1hgXdaAlYiU3GUz3fuGcaILNjka7VKpps8GprniKzqfbEboE2iICj4
 FNkIK7Oun9z5K5ibvCCSYCRJljTZBsxj5Yfcl5Rj1NXTPcziDjUpFDrn4JyU7zhIO2P+
 WtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725683882; x=1726288682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Lg7M0oFQOS5nOzvqDPAhzRLVdfTSpNbLSqGsYqEMn8=;
 b=VitHmDidOVRoduE912rJ7X/yEIlqSaNila80b3n7wDh95X0TdLcjxEe2cTr6yYcCRE
 n8imLvmxIwDcQjXtLaCuEvbJ04zYVrSDt5jj1qVAoFIygmvbFHlLMevaprVmSiLKCfFD
 gR0OA5AgmDn5soMIdMOnRjxrYUmJTVDky6St7STNjbTHzg4ucs3v1YdLA9H9pEUB06wu
 OyF+bxMWSt+sCGdicQA3+3NURpytAl0hjsPjE83juF4tWlB82jauhZu6ixqEJ27rOrkf
 H3a+aHdhCeSXmygZiLTN2oSkbbVBPdX1PdKFUw7sRNX9/8BYkNPcWmcgAoBPWftF++Hv
 6dvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfKbBdItob9zmuZYgQwX8bhlysiWbenXuoa2TX8/RBB5p8dcFkrP+UUHwu4hbTLAf+OvS9eh4Cc5wh@nongnu.org
X-Gm-Message-State: AOJu0Yy3RdoUbkCmKRQ/sVKWsq5ZYYmtaS9ji+emDSvC88e1UlcgKg4k
 9Zf8GDgaYr6qmHSGzqtIHpvArCSdW0iqOg60UJ6cnw1OBTcEX3J2Bnvfd+jviac=
X-Google-Smtp-Source: AGHT+IHJPLoMm9ixl1lsCHB5p9J9RCY78F/qTErYfhrPHnexKuXdLTDFOe5MjiMgnCP2pJAg2EWUSw==
X-Received: by 2002:a05:6402:35ca:b0:5a2:6e1c:91e9 with SMTP id
 4fb4d7f45d1cf-5c3dc785c13mr3125447a12.7.1725683881585; 
 Fri, 06 Sep 2024 21:38:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebce3448sm235779a12.0.2024.09.06.21.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:38:00 -0700 (PDT)
Message-ID: <fec71415-d44e-4657-ad0e-75f8208cebdf@linaro.org>
Date: Sat, 7 Sep 2024 06:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional: Convert the or1k-sim Avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
 <20240906180549.792832-15-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906180549.792832-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 6/9/24 20:05, Thomas Huth wrote:
> We've got to do_test_advcal_2018() here now that the test resides
> in a separate file. Also switch back to the original URL (since
> the site did not vanish as originally expected) and update the
> hashsum to use SHA256.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py |  8 --------
>   tests/functional/meson.build        |  4 ++++
>   tests/functional/test_or1k_sim.py   | 29 +++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+), 8 deletions(-)
>   create mode 100755 tests/functional/test_or1k_sim.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


