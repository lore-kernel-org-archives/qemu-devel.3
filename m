Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F79E6400D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDfy-000886-4q; Thu, 21 Nov 2024 15:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDfv-00081t-R2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:21:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDfu-00058U-2X
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:21:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so11188135e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220472; x=1732825272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/DnjGimTMJwPuLr6CTL7FfHBG5tYfJhWgLa22GOBWZ8=;
 b=bbgsXt5o5Y3cWgc3HbyFswfyA5ngQE0CpUfiWNP55zkqET5M3VQiJsnNpCgmGPBgbM
 f7xmum7dJnIghFfU2iYfPklYAspzGhru/BzfULP+zbooLznGk/mdqNKFFQVgJhT3XK0k
 C4phLitu1CbKd41psBY9dcVHlG8lXTn5R6AJgs1w2EmvEW2A2UY/+Hz4MxWtJ195Fil9
 cmkCkODOhOyhhKq1aoe5fMq3JKg9wohf9xYiNkoGuwbc0GsC52gbzZfnEVLUJdwf5wts
 JrfpawxFzwHnT8tH+uF7YHCpz4EpBdE86PyLaZrOkF3mPT1pb9IFUjtVg9vWcMBmAaAm
 Tm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220472; x=1732825272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/DnjGimTMJwPuLr6CTL7FfHBG5tYfJhWgLa22GOBWZ8=;
 b=PsfR1+9aAfyKjVWQo0q/bC1vyD5HwQdl8cJ8VrL2/GqDUbTS8TFXYn6cJM7638elGF
 3tiuuF8G7CIOJRjTp6DiLbym02ePNXso14pvBolH63iltwzKQi+AwfIBIIGcbzZvh8mh
 vwAeVpzGqWsJzwM10BlsPYvhJRLfvzuw9WQtuNIDKmApeGGkwWjkS4Q988vtFIUM4pZF
 WyUh9VQpYqMio+kV3CCwgVCfiwUib5C+OhiU9lFscqBygXUY5wl7u6NwjsDhxrPHY1bn
 m+Ct9EKYUqOOFVK/Xl6wEZWGreqFnDPmpV+uI4I+I0tytVlgkd2aQy1+nNb2JXlKBoJY
 36cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw7/wX6ScJkfYk09sabw9DqZedDlKZDNTb3zd3qPdzNQ40EOgPqDfK/DFdRG14nfa62nYlOg90ZMGH@nongnu.org
X-Gm-Message-State: AOJu0YyZD8d+SKkmCARqqHpxlQugR4PElxFBh6F49uhK5uVFv79ncgYr
 LRRjj2E2NP3rci1zPS/TABUy9cWnejdyOZG4QQfr3+qv7gr0t46xaKzaCR5d2QE=
X-Gm-Gg: ASbGncvPBFFIvd8/FNBG6XchUIdGk8fsQAoawz48cb1NQiF+WBhj0OoD/OTdncRA7MP
 OcOB/oAF5rDmZ3mYQCejEA44/LTW6mq/r6e3smXPfTQzWP3llZ2kPC2flqDJIb2Qtx6WEt6576i
 V7jo/b/NWbYcnDEAyNiwuJQ6g7H6qRK1jRGPlKHLop9ApBxybCXYYeO3UANwNw2pNZjoMWQ2GoE
 irA0Za5n1J7HSG40F9ic3cU+tw8loAPtbAKESWbcRuwgkPBBTpp/T0xhiqAowM=
X-Google-Smtp-Source: AGHT+IEr4t/o88u6XJdsuMKyRxKclWLlrKPfUF13ko5lAT7tITDysyZTIDVZuhUl90W0VHCgYKqGXw==
X-Received: by 2002:a05:600c:5251:b0:431:5459:33c2 with SMTP id
 5b1f17b1804b1-433ce42c7ddmr1499535e9.17.1732220472123; 
 Thu, 21 Nov 2024 12:21:12 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46430f1sm66706845e9.43.2024.11.21.12.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:21:11 -0800 (PST)
Message-ID: <65899e30-5f07-4a00-940a-7ce87f792223@linaro.org>
Date: Thu, 21 Nov 2024 21:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] qom: New object_property_add_new_container()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-3-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
> To move towards explicit creations of containers, starting that by
> providing a helper for creating container objects.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object.h | 12 ++++++++++++
>   qom/container.c      | 14 +++++++++++---
>   2 files changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


