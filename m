Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF520D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfu6-0003Q0-7B; Sun, 01 Feb 2026 17:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfu5-0003Pd-9o
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:26:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfu3-00085w-SE
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:26:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so50824835e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769984806; x=1770589606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWjwsvrFEh8UGqfhXPeBPhcKpj//ohUuL8iaBKOXrEM=;
 b=JTxrb2giuWNSkqI7C6bcxbtEQXrI62xcLqQxzGlRIeoA6BBJn8IEchSQSnmYGAZFKu
 vunWm5rhHDjcb6qiHfE7TMDPgY6ulmGtIPQHNlSEuFyvS7WcxakDloONGSc0grUlRUT4
 gw2cR4laOurm7tOCrN1RMUSD2kAqlb9Zm37J+jvZzbqfb6rhnGmIIa0GY/tUE4EATkbH
 MNU6YcBzrYEwvDfRCt1eg3kMXdlHrclo8xy0+IoDDKH6jZg+CCjkXfb+aL784YFXN3k9
 rjegCz4ppZ1o90YHzsb4yxPTP/4aJGlMOTJIRkKC8gL6aHO3uzdkPUv16mSLfM4vPYwT
 Fb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769984806; x=1770589606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWjwsvrFEh8UGqfhXPeBPhcKpj//ohUuL8iaBKOXrEM=;
 b=ZUKTmU5c9IbKsuOYuxFTdxlqzusK8GZLBoPRf1ciDkLH00NcTO55/OlrvjGiGVGrLI
 rszYbUGATM0JTDvYAsG6mX8eusW2fjRUvUKgkLqbLHvCR+TGEoE3hYCJZ5hVvxedxqF5
 /nmCfmCvu8oZr16eKoXHO0DsPtnzoyatT1pKGshgCQFH/XjX64OFDjkevgbHvaIBd1f5
 dgxwoQYQpFEgHekHzBkMMPmZ6Qu222R4YXfNqW1nFqd6b1aEc6qnykT6DjYz8RqqQpNr
 E/gkxK7HV/4x8m5H0phdVb0C7mqd2qvm6KYZ1nrLwBUC+uaYp4MK4zu67+tKUqTrwuQw
 zDsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYnqin8QvzjBN54kLHGfm8kL/7krIfLfAEkq9BLiQmfosSbDcbBBVD7G5tZzEoEFMzfXZS4umKKoc@nongnu.org
X-Gm-Message-State: AOJu0YzMz69WRIzciBZC+9hXXyWjInLdtlUKNDwaQq3UgE1IVQAWE0Bw
 Wz+0pO2pxh4IWM+HgDyl6qYDbuQJJIXtdL0NRCvTqI8ZNXo/Mk48kLQWy0KZ9LtFJ9Q=
X-Gm-Gg: AZuq6aJRh5lWpSaQYML6wm6rNG9J56s+7d+DL+tKy5M7w+6t0hb1+0DbJHfE9XJ93oz
 xRixmZi/9adUpz9OhvM1YPCMERlV/5+Pn5t4ocxosbN0/8RBGPDtVfhv+8xZ6AyO46ctIbQTRbU
 5Xcj/M7amwvlRXp/OyHX6nbR31B/y/J8QjoQ9ZfiPazNrfLa14+d+8JEbbCRucuSmXl5GUpY7hX
 HPmn+PI4yOEIH9skhjARnDQaDhwAHwzH7hoecn6lI9Z00r5GNRPuxnoERRmbe/Qu74B9pod2df+
 tZpMJByV8NTGW4YhD4+Sqmdjtl5BH8M31vL6GeO2cqiikXhgeTXlpyR4M/KgC/HHnN0TX2/m5J0
 KFW7b7z6bRPMuDF0jDHz9LtjaSxKZjLLWoK26t6IS1DJcmlp+29ku8SCQn/GIGiJf9Usvk0FIyl
 P7CtGu0W/6EeW4M+9pTal7v4h5Icw4+0zG8n1HqXeAJdZDTbPGiiE59A==
X-Received: by 2002:a05:600c:8b0a:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-482db49993bmr117689445e9.27.1769984806087; 
 Sun, 01 Feb 2026 14:26:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04ed4d2sm75876775e9.7.2026.02.01.14.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:26:45 -0800 (PST)
Message-ID: <a31c785e-099f-4fec-bd17-81397c5ac793@linaro.org>
Date: Sun, 1 Feb 2026 23:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in
 a new header
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131020100.1115203-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/1/26 03:00, Pierrick Bouvier wrote:
> Allow to include it from common code (vhost-user, in next commit), else
> it pulls ppc/cpu.h which has target specifics.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/ppc/spapr.h        |  8 +-------
>   include/hw/ppc/spapr_common.h | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 7 deletions(-)
>   create mode 100644 include/hw/ppc/spapr_common.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

