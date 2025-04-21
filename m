Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2233C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6tNJ-0006fu-An; Mon, 21 Apr 2025 11:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6tN7-0006f4-GE
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:47:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6tN2-0006GR-6u
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:47:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso38714295ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745250461; x=1745855261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7HSbrkWBqipOotE9nMhQ3nELqUNR2YC+0Lf0jmYHJU=;
 b=oCGXwjXzoUp5S58ptHCINmqtTiDPaDzr6KYtCuW3UHTNZ2CMwhKmdjqnTB3n31WIYs
 2I9hRgpA4exoTrKomfXL/BKovS8DXo/Iveswec0atMNj6/0ooTR+p42fR1KYuWJq8y0x
 CCvv5edyA7SSgRH9wjGs8qzrY/vaIiRp8qTnttTPhgmkKAzn+QUAxtxdv4oXIZI0wdjR
 J7a6F+GTrfFcGr+q8PzO1G0R4HUf2FL1abP9dyhuc8z/ntSTWIjrThlqSCQXRJgoHZGy
 GOEfT4RghQd8LuQ5s+L7Pq35dp+yLAKvDWZChufKYXgohRHdXbK5hPaK+ILsVc/UoW6Z
 zeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745250461; x=1745855261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7HSbrkWBqipOotE9nMhQ3nELqUNR2YC+0Lf0jmYHJU=;
 b=tile3oSFyeB6nJbMd4WJ6eplfWLVE2firYqL3265BRJU1T4hTwP6NrZWJZZnTqF3z+
 2ZLFANnWlUOl32hKNxXHjdR02ppEy3SrZwkCiB732C9yfjcGuZbyMj/5yOjrI+PZ5shh
 E63XrajkYulVIUDOSsirAo7vF8oYqC3i7armuJxBBTIInkdT7lCYcxOJCIzoMKz6m7W/
 K239IDb1MywWp33CQAB+loZqnwmT2sTE7Evp/pasQsiGa7j1hr0rTuUgAOOVDzBXwyMJ
 GbB99SoL0xZGkfyIQAi3C5QpuaN6+6cd0g36UpTUnxPU1Bi5CClhVkHhBw3nhF1dptVI
 dVhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDklD+fWTgQLyPqAYls2TMCNof61uXqxz5UvPIdmgfi6MrSJpVMivSz/M/kkHbFE1PpyTgunoubcNB@nongnu.org
X-Gm-Message-State: AOJu0YxRvsjeMpO/ErsmIhzVIxH6vV7W7NwGoZCrfA4fSRum9DlVjtU3
 hB0OYItIUwpSXdhhj42A3Msw1/wTL0l9ahfFDetZoTlvzTJTTWhKCDUq0t5NbzM=
X-Gm-Gg: ASbGncuIYVxVA0DjwUCZUWD/8BH0hwV4w0G57yCr1GsfGSYheJp8ZRu62jXWXr032e2
 aUpOV3n2gmZLHZnDIa79cDtCMRZDPe06msVEts9lhv/YQzSm83cCJWcW6a2x/pNw8cSJ+/pB8Qi
 MGE4gO9eCNQMXIFzezpWHCpYNKl74yq6epqKclPB5pWzmlcpJ8nsxXshbM0g6t1f2d5HyDWpGeQ
 FVrv4ypv/FssuvBQfgN9s08TRsrZkX1773UfuiSXb5O3W4hWh0r0VA/YJrUOrQoWc7kYjjlJooR
 mdnCW0foa6vwrzEmvKnXcmTGHPA5XR07VOOHxhizQjmz+H+fYs4+Bw/+FW+Ib7XbG3gU9m+738S
 UhlMn7i8=
X-Google-Smtp-Source: AGHT+IHeuTPUse7eHZ/t7BKr8q6d9MJzOA0ueq5o/VKfBUoRZRqvMWVyRoefcXtniXSYOjz/7IbnUw==
X-Received: by 2002:a17:902:dace:b0:223:42ca:10ef with SMTP id
 d9443c01a7336-22c5361d5b9mr183692425ad.43.1745250461218; 
 Mon, 21 Apr 2025 08:47:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ecf216sm67057735ad.170.2025.04.21.08.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 08:47:40 -0700 (PDT)
Message-ID: <da9f3aa3-7cb7-448a-bead-ee7dd356b3ef@linaro.org>
Date: Mon, 21 Apr 2025 08:47:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250418172908.25147-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/18/25 10:28, Philippe Mathieu-Daudé wrote:
> The QAPI-generated 'TargetInfo' structure name is only used
> in a single file. We want to heavily use another structure
> similarly named. Rename the QAPI one, since structure names
> are not part of the public API.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/machine.json          | 12 ++++++------
>   hw/core/machine-qmp-cmds.c |  4 ++--
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

