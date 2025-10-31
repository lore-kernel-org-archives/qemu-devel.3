Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A666CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElwI-00088P-KL; Fri, 31 Oct 2025 06:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElvv-00085q-DF
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:00:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElvm-0001HP-9l
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:00:33 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso569846766b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761904819; x=1762509619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5H4whP3No+2YoBD9q40AQQmdXDK+MxbRl3cLFFyWG0=;
 b=wT30+bHlsk/QkQnaodoUurXrf1kvbQjrcjL10bYbdpuFe6vvFM9oVc+1t4rUK9h9/c
 +J8hoRW4yGr8Cv1wU9VRkO/0Ix/pEN98yHJNVy65AtmQM7w03I+Pu9/SGFvo1Fb4INqo
 KrexFenh5k67pWuWcHlG9fWaOpDHvkpZizZ27CR+ki2FV7GfXLYFuZVnBTPKSP6EUVjq
 yaxDTetrtWOqjxcd4PtQY+HkR5nZSXqwM8pkDBPp5tSknovkP/2FeTcbxjsL/DGCiDNC
 IZkArMKDnCcSRfnd9zdB1lrHwdo3h+ogmL/Wa89Wtl13/2Vu7XVGdL/m94+ML9fXZhlm
 dIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761904819; x=1762509619;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5H4whP3No+2YoBD9q40AQQmdXDK+MxbRl3cLFFyWG0=;
 b=CD0kE5LsxcbOFn7CrJdAMYiV++sou+YmVchxWYr+2dLceZFqsLwSnWeBM+IB9o2Tpz
 guy0cO1EdCR57PfFhPPDOASRNW4mA+QryzB1vWsO8jCIUgekwA7kg29u/Aw3p9FdKkgn
 GpVwb/ksGDkVwrFAB/fBG8uETRkzJIOlBLW4bvFBKgYfa2hfDk/WHEuZRwewjL7lws8B
 BXQPJVW7j5ZJZ0jApiZxeSI334zeQexfWXdPNMve/1RxIcTJC4yQdMworSjFWwlKEwmb
 plyqNCuIFpsB5zPr9HyNh94Al7JCPORiDoIBxnQ7hvpKnKa6FPYNoyPgCYUbvUY/SfFT
 MyNw==
X-Gm-Message-State: AOJu0Yzl9fgDfTfmMai8fu8d6UdA/F9hPPEYialcOf1tR59G9sY7ELMM
 XGjhab6voDKIgznZ4pcovmIxp6udXl5QxIdTKCGkUyMH0yVehzxg5HmKateRJtmXzcXAxWGNjTr
 8x7f0ntWhqQ==
X-Gm-Gg: ASbGncuApHUqF5R/iXmUH/ECsFCcjc/FO/maifuZiwB0y6NxK68dtb/QNz8c9TMIwne
 hT71PbSdE5NrWBzKI/i3KGZuCabIeUEiT/EJPAkj9NcDHgaMYFQgVQAguQtKe/nMciCI1GqjpVW
 WSUcHFbrInEJjh8ublU7o9zGWkpBSanigg1VWWrYLIQjSGwwFjTPuV83ecdZ8wE9tHyTKr5+DCc
 2mas98vllnu4yj3+lOLP2C+YCUj9H9uUDp6NZQsg0pMrAKOlNRSD03GiV1lqDgxnrv+yYEsrAgP
 eT/+3As3Ayq6TPC9CqTXjPUZZh8Ke6GeBGpPIZx/pDIxD+ezeZeIb86sz+hasUXsE7HIE/zBrDl
 S9lxD11mXOHbez9MWEncOLqU14W8Av/Z+WjnAuOCi4YBUC8mlsz28WPKwDot6DNQTAlZ2xCpaR+
 m2dFOwfW4SXOOdw+1R2EFe+rTWxhyNgfTdJpMejvJgqrXtI7alLQkIvz+JAmZ/Pg==
X-Google-Smtp-Source: AGHT+IFXUQtv+rPMyOnzwlJkqTiAmvPqpAY2Mo0sb8rdLxEGr/pDkNtu4AIIgcXH7bVscceMxrQepg==
X-Received: by 2002:a17:907:868d:b0:afa:1d2c:bbd1 with SMTP id
 a640c23a62f3a-b706e5b2c55mr365449866b.30.1761904818938; 
 Fri, 31 Oct 2025 03:00:18 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779a92c9sm134800066b.22.2025.10.31.03.00.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:00:18 -0700 (PDT)
Message-ID: <1e445b6d-f1a4-47bb-b34b-38b37967e0c3@linaro.org>
Date: Fri, 31 Oct 2025 11:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Disable flaky MIPS tests on our
 GitLab CI
To: qemu-devel@nongnu.org
References: <20251031094118.28440-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031094118.28440-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/31/25 10:41, Philippe Mathieu-Daudé wrote:
> Disable both replay / wheezy tests which have been reported
> as flaky since too long.
> 
> Philippe Mathieu-Daudé (2):
>    tests/functional: Mark the MIPS replay tests as flaky
>    tests/functional: Mark the MIPS Debian Wheezy tests as flaky
> 
>   tests/functional/mips/test_malta.py      | 2 ++
>   tests/functional/mips/test_replay.py     | 2 ++
>   tests/functional/mips64/test_malta.py    | 2 ++
>   tests/functional/mips64el/test_malta.py  | 1 +
>   tests/functional/mips64el/test_replay.py | 2 ++
>   tests/functional/mipsel/test_malta.py    | 2 ++
>   6 files changed, 11 insertions(+)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

