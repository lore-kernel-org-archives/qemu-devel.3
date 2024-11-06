Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C41D59F67
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8nIk-0006vw-9N; Wed, 06 Nov 2024 16:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8nIi-0006vj-PM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:10:52 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8nIh-0000dL-4d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:10:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so1921165e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730927449; x=1731532249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DuyFFlUy2Flju1Pj7j7H72q20jJwwcAQhxq2lpJk7M=;
 b=iw68Iet69fI6D9uq9OBfmFLq+S5VWWj5c0pA98BnrUWXi3S+SWmg3Wla7cZyD9OwFL
 A6N1wJD1xuhVyrQBbXZl2+94GsHNOHzpsmXArrO6iLS72KEUigEy3lnn0IfBak4k9b35
 4HsMmBGAhgAsbms8NzzGmG/aLfVau1ujY5bgFucs9tzg+e2MQlKpTvNzotTbOXIHYp2M
 Yyrjdl03t8aojZ7nEJb3xuSbZe2O9BBvPVBZVUQXmv5GwJZUY38XkNt3PNfkmb+WihoY
 6tehCjf+FfaxiNIEIEtAt9VYNRPF/8yluwfutcOL4IlFy4YzTXt05V36Nz1EYXfdd7I0
 iB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730927449; x=1731532249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DuyFFlUy2Flju1Pj7j7H72q20jJwwcAQhxq2lpJk7M=;
 b=k6N7Wv/GIZIeqTLlmx6XiZhKVB5f6KeL419fNyr3xQFdrk9ZrpueX7UxhP3McLN/Sm
 InvU+uhsRb++QGPLlFjPISl4Gbuq+IqfJutTI6BuOS8M43BedXqP5IfKXVZKeot8Mxev
 Ov/rP915IdrU5nimdLBAPG7xt45BqisLTAgfHXlBD3qQwNAzxXHjGDq48NVlQVJ//l6M
 wS+Qedlp3nhXdbarGmvkic8XEgyZQviZNiOSTaFr94sQU7//CAMAvjjKmUn4v+BEs5mN
 DbaYWMRaYNk3JmWhw5hAg2TxEbBhamFDsLtUCS0n4MQg/jqiGx3WzPII6DSdIs9bMphn
 uXpA==
X-Gm-Message-State: AOJu0YxT1nGf7+ZJk5D9wx8GTw7ToS8Hu/pO46pRfkwlPa2VhHQ9AbWE
 XlLBQ6EhSrNZK0sWlu4P38kWO8F1O1/VBBWx5rSayTSdeINiUotb8jei9yyK7jc=
X-Google-Smtp-Source: AGHT+IFmHbh2BQ00AgWN07eFsPe5P4bAyTj1jp7MD5ZVBW2q3W7h9aHC6Ohoi2XxE53mW9vN/iDksQ==
X-Received: by 2002:a05:600c:1c09:b0:431:4fbd:f571 with SMTP id
 5b1f17b1804b1-432af5909b1mr4746995e9.13.1730927448569; 
 Wed, 06 Nov 2024 13:10:48 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c0f9bbccsm20482051f8f.0.2024.11.06.13.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 13:10:48 -0800 (PST)
Message-ID: <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
Date: Wed, 6 Nov 2024 21:10:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
 <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/6/24 18:13, Noah Goldstein wrote:
> Question about impl regarding handling of `-execfd` with/without a program name.
> 
> 1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
> 2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.
> 
> Do you want to allow both of these? If you want to allow (1), what should
> we use for `argv[0]`/`exec_path`. The program pass ("ls") or
> `readlink(<some_fd>)`?

The canonical response is, examine the kernel source.
We're not implementing this in a vacuum, you're replicating execveat(2).

I suspect the answer is (1), to be compared with

     syscall(__NR_execveat, some_fd, "", &["ls", "-a"], env, AT_EMPTY_PATH);


r~

