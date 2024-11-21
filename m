Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C3E6400D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDgl-0000LH-33; Thu, 21 Nov 2024 15:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDgg-0000IU-MH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:22:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDgf-0005As-0u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:22:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so11503415e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220519; x=1732825319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEIek/GTGC0FcjCOtFGPv2eSMl1zfe3ZVhEw7RVaSfQ=;
 b=fH75CDTM/1ItgwOVgqF4/NAst9JaAnXY4A9JrCzuVjyDT5ZheDw4cU68xpYDhWdzLS
 ggKmMNQdGgKeMyy+t0EEDZA0Ww78z/qRZVMQhH/XwPuEadMATAwcaTyGtB3q1bhobS+e
 zOtr9IoD/A+XdBVgVUb0R6Momqq56XPTSxDFoN8ZXxj0nfrvq+c90mzhJlDc5Cly85bX
 gbkyje4n5LhAeGik49cf5cCYrWdSrPvyHr7DMlfn6nOe6memBeo/1WitVIBn3Jk1t0c0
 Tg08ctpt4ES8XWt1M/VRbkxJ1pgGYBSKGCHj1mSe7XT4OqapxvUt9r9iV2YWmTzYMfZL
 zGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220519; x=1732825319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PEIek/GTGC0FcjCOtFGPv2eSMl1zfe3ZVhEw7RVaSfQ=;
 b=nU1CbCQUziSUmlUZ3ElC0VjXrkzrpMJQbIMO5ts4vgXpGwLLMAWNDcIVtSWg5PTH/E
 3PWA55DE22an2tDoho4DCXf3YXH/M48dVT5M+7gU8Ias9MB4zacp+MKsXXbJkWsjQkzn
 LZhPdxHOBlMZ9MwQ+PvEkssG+EGsPuLo/D5BoJLc3qx7zDJvDBSktGptx9Zm4S1ypd+o
 IodN3X/qaEPXgT0qggIiQo0Qj1dKp3VWybzrLlCA6XepMUSm5RDeR2pqaIjPTHcSnmqg
 FOb1i6zyWKnJBXTwjvCKS87MrDjIMyeu8ptcsZ2ckDeSmU6kYm3uhaeVve0m1N+Vm2JX
 0+xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBWSnJ82uIUmEnYEk47IoxIsZcHrD7L6RzSii6JZo0AnXvVX6v/OZLaYO2v6Rmzy7KB5rH0Z7X188w@nongnu.org
X-Gm-Message-State: AOJu0YwIMH9lwxH7/D9VODozeoRpJn4X3PLj2fH621eOS73pzWiIXwhi
 oW1p/Sk29kbvZcLUKfgimUkkDoZ9AK2rssjWFyrLjKZMxuFl6OjaAFfC/tiBh9Q=
X-Gm-Gg: ASbGnctu0/bQlXicEewrrfZWzDiP9xdDq74BgAKv9DITJGR7/fIYLjSDOLCSf97/44M
 bA4jABrJEPk5kanWeRdetKtsplqUZgnka+857l+SJHuX/UlXLnq7DimBm1HrlKSjpCIFjmSScb2
 Y2kfHxmqctlTVOKIoDfn1coxdycY4uodMQQGfZ2hodeaZMLXTYFJIgDHazNkx7nk1LVzPvEtz10
 E2zkJk8AFzUfbNU5BBjv6604PDUhRjG2eWSKMVL90W4Lq4eeqgHnGb1iLe3yAw=
X-Google-Smtp-Source: AGHT+IElJrw296F85lQGMd7fu31Fcz0FRRTTNHwP4UFWwrHm+TsqcCJHQUiPnf2OI1swAKfyw9xpFg==
X-Received: by 2002:a05:600c:511c:b0:431:47d4:19c7 with SMTP id
 5b1f17b1804b1-433ce417b36mr1530795e9.3.1732220519384; 
 Thu, 21 Nov 2024 12:21:59 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45adde1sm70650135e9.10.2024.11.21.12.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:21:58 -0800 (PST)
Message-ID: <7954d9e1-0281-4272-a3a9-0341eab4847c@linaro.org>
Date: Thu, 21 Nov 2024 21:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use
 container_get()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-9-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-9-peterx@redhat.com>
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

On 21/11/24 20:21, Peter Xu wrote:
> Currently, qdev_get_machine() has a slight misuse on container_get(), as
> the helper says "get a container" but in reality the goal is to get the
> machine object.  It is still a "container" but not strictly.
> 
> Note that it _may_ get a container (at "/machine") in our current unit test
> of test-qdev-global-props.c before all these changes, but it's probably
> unexpected and worked by accident.
> 
> Switch to an explicit object_resolve_path_component(), with a side benefit
> that qdev_get_machine() can happen a lot, and we don't need to split the
> string ("/machine") every time.  This also paves way for making the helper
> container_get() never try to return a non-container at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/qdev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


