Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F587D75E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEU2O-0001Ff-21; Fri, 22 Nov 2024 08:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEU2L-0001FJ-0m
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tEU2J-0004OK-HM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732283366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3tsec09M1r/BgAM36j8Y/VWomGKw8cXxGUmKJEHu7Ms=;
 b=PQqpFy5SWM1hW38OD8KWh9mvc051yHEfIcjkjP2UQZr8MSVxStQXJXjHOpDD2YUO3BSPL2
 ahNH5U6l34HRr5cT5liIbMoODGEk2V2QY4XtounteOSBuOSPFzW/qzm+j7XosGFmvkCZ2t
 WDfYVhOhJVVeIOnLrhbg2HwmGy4sYOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-B-wLcwvoMOS5tyY0X1qUnQ-1; Fri, 22 Nov 2024 08:49:25 -0500
X-MC-Unique: B-wLcwvoMOS5tyY0X1qUnQ-1
X-Mimecast-MFC-AGG-ID: B-wLcwvoMOS5tyY0X1qUnQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3823326e95aso1165165f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 05:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283364; x=1732888164;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tsec09M1r/BgAM36j8Y/VWomGKw8cXxGUmKJEHu7Ms=;
 b=ulRB3/4zvsPSDiAASMqO4xr/zU/Kcgsk0aEZxJlb0ZMj9Yp2vi3p5YhD2Uj4FNXX2M
 owWV7GrHTaxmh1EmClvEeVulRn3fPbqgVjdkAjV5FwOPa1EPGVytZMCYRKNoJFzmrN/K
 HnBq5tqfOJU5Yaem9zgcrBjsinvZTg3io3o2sEaiVljMCAcaScHSnM8Ib6ei7fX8kpuv
 76KHKyD6Q2vRdOz7WsLNzB0kmx3ibJLqTNGwh9AqbBGMDLNALQ+T9KvfVybqeaUh7ngi
 SfqFhxDr1F7ZzZWehKXZBtZFbBTrr+XXSakaGLbw+mXXZMDFu/bTRNjunfVkashPZ5jn
 ffRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWigV0e/Z+7ttyJ2g43BK2KqvmPaZNm3BrHadxA8hkWixB3ON/gFPewBEzMhEehrOnXHguSXlBP+fBc@nongnu.org
X-Gm-Message-State: AOJu0YwS9bXDJI4cdGGEJXAVzrJYnlKAF85SR+nkH1pCuaC4lARpcYf8
 7vIMziRztgG/B4nZ+X2V3UN6S9WN01ndG96wfFdJhnXQgz7MItq2Ce6q9rkwCS+pEY0RUmZImX2
 Uxq4DPX6mf57efZQ3lrvmWYqDGNn5/BwCsl+SH3cRTsS6WXE6ltCg
X-Gm-Gg: ASbGncsByILDpZR8cq7DFRFf10exHQEx3WTUInxqbvRxjPfiRrc/C/djqIt6+gFtQIs
 JQ5cWvNNaLHd0q9YKhbRkyfLbULFg3YLhUjBqAHwdlCCS2NZlhlj2O652CyXhe9qXrOSUYSjpqU
 qYYi0+FyOtb3/xazikDh3/7uvw3Uuo1LZubYx++HQiXdOIu8MGIlUDr9OSlS0ucK403s0M/lYCI
 IChnY1Aai8p9HTpl7cTXN/49zeBuniwhFAhNy1OUyBEi34Nyu5e6dyYBcl7Qd3LnE0aTniie3Q=
X-Received: by 2002:a05:6000:410e:b0:382:503f:a323 with SMTP id
 ffacd0b85a97d-38260b58dd7mr1897910f8f.19.1732283364044; 
 Fri, 22 Nov 2024 05:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBI/pwKPGzosZogvAumnMxVvXdd9aV8a7GIo1+CEXlcLM18fUnr8t2PeRIti8YuUdP4fMTOA==
X-Received: by 2002:a05:6000:410e:b0:382:503f:a323 with SMTP id
 ffacd0b85a97d-38260b58dd7mr1897759f8f.19.1732283360314; 
 Fri, 22 Nov 2024 05:49:20 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde114d5sm27835805e9.17.2024.11.22.05.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 05:49:19 -0800 (PST)
Message-ID: <a1026443-c8d4-4e07-9d8c-0bd2356e8cf0@redhat.com>
Date: Fri, 22 Nov 2024 14:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Remove sleep workarounds from sh4 test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241122130804.2013662-1-clg@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241122130804.2013662-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/11/2024 14.08, Cédric Le Goater wrote:
> These were introduced in the avocado tests to workaround read issues
> when interacting with console. They are no longer necessary and we can
> use the expected login string instead.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_sh4_tuxrun.py | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
> index 352cb360ef74..dcb49f28b9aa 100755
> --- a/tests/functional/test_sh4_tuxrun.py
> +++ b/tests/functional/test_sh4_tuxrun.py
> @@ -15,7 +15,7 @@
>   import time
>   
>   from unittest import skipUnless
> -from qemu_test import Asset, exec_command_and_wait_for_pattern, exec_command
> +from qemu_test import Asset, exec_command_and_wait_for_pattern
>   from qemu_test.tuxruntest import TuxRunBaselineTest
>   
>   class TuxRunSh4Test(TuxRunBaselineTest):
> @@ -46,10 +46,8 @@ def test_sh4(self):
>                            console_index=1)
>           self.vm.launch()
>   
> -        self.wait_for_console_pattern("Welcome to TuxTest")
> -        time.sleep(0.1)
> -        exec_command(self, 'root')
> -        time.sleep(0.1)
> +        self.wait_for_console_pattern("tuxtest login:")
> +        exec_command_and_wait_for_pattern(self, 'root', 'root@tuxtest:~#')
>           exec_command_and_wait_for_pattern(self, 'halt',
>                                             "reboot: System halted")

Could we also remove the  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS')...) 
now?

  Thomas


