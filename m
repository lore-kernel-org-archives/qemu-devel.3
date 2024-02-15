Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FF1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raaa8-00084J-EX; Thu, 15 Feb 2024 07:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raaa7-000849-Dd
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:11:11 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raaa5-0003f7-Rp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:11:11 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so1038449f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 04:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707999068; x=1708603868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qgyij43pW2u0XqfAwohm9orFra1CGpEia2Ff/Mepovs=;
 b=fwot25nZgukKuMTz/uRsXPp5WbNgM7qzjE0qJT1kH3QcwSJI5Y+Ox81KlVgLOCBMOf
 JLvAcdFzB25NNycUwF+og2MKl/Hdq5NF1vdilS0nq7wJLsavF+bxp9gU88wkYNGAqCSy
 vGYa8NXfjo/AC6qJpRhwIWRhfXZNEq7I8ivhYuXQs2VnYkRW/Y9vYX5DTdhSnlNyio91
 18/jdMdaDM3AeJUNn29p3ujrlLzPujVNbNNjw4pWCoO6jEjpGxC3OiRY6Yt9Qz/tvGEE
 40Or1V760Cyj9Data+PEx6XLdHFIzIuCGEkSpVgSOXDgKWhm+o1XtaZPPQljAP2tE+Hk
 mY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707999068; x=1708603868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qgyij43pW2u0XqfAwohm9orFra1CGpEia2Ff/Mepovs=;
 b=ATie3k2O+DPTXmRan0aNeB8QvhBxsw6oq2ClT0Mu0LfsAaoBBbGpZe+CabIkLo7ihm
 H/X3phLP2a+6ivFBOS0wfDXsPd4CrHWexc0zYxmX4TcbhZ20vRnkjD8hIAYbTh1FqptP
 YwmQrnhgD+Jiq3TxgP2AT7C6pLWS0HtCXgiV8YM2sqCFYPNs/IdTUxLRb3XfdkoI8quF
 LW8YWI/XfnwKI17OXfvq3zlDjuE2g5x1JjjMeO/sxgeyVq/GWYVTQxibgDD8kwST868F
 LopG0KNDkAj7CLxafwPmKsEOP2KH2r7Ke2/x/XJNMwDrXDEetFk+BVHmsTksmfZlbtRp
 eNyQ==
X-Gm-Message-State: AOJu0YwYjml6nX8ZrckfItLvhoZGwyDV2/PZ6mjUpsUrfW7NG6GYtQy5
 zdUJhNWA7QW5LCOxxVD9uRh5lMp3Wuh3udrRV75hzeNZ7knFPfvxLe3r+kb7vqy0Lsb6A8X/qKJ
 R8ik=
X-Google-Smtp-Source: AGHT+IGv8qmuvoVO42RmecOODIoj9AdMHbOH9GaFqmxQI71W3e7jjRZ8wMNsxZe+sTkeujigbrd9Ow==
X-Received: by 2002:a5d:5046:0:b0:33c:f677:a637 with SMTP id
 h6-20020a5d5046000000b0033cf677a637mr1494403wrt.18.1707999067799; 
 Thu, 15 Feb 2024 04:11:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a5d5f02000000b0033afe816977sm1651901wrb.66.2024.02.15.04.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 04:11:07 -0800 (PST)
Message-ID: <23427b45-abd7-4f3c-9e81-d9c45499cf03@linaro.org>
Date: Thu, 15 Feb 2024 13:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] target: New binary to prototype heterogeneous
 machines
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240215084654.56297-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215084654.56297-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Forgot to Cc Anton :/

On 15/2/24 09:46, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Run check-qtest instead of check-unit in CI (Alex)
> 
> Almost 2 years later we got hundreds of cleanups patches
> merged, so we can get this patch in. Building the 'any'
> target has to be explictly requested in ./configure
> target-list argument.
> 
> This binary will be use to rework QEMU startup code,
> paving the way toward dynamic machines. It might also
> allow experimenting with multiple TCG target frontends
> and possibly prototyping concurrent HW/SW accelerations.
> 
> The corresponding CI jobs takes <3min!!!
> https://gitlab.com/philmd/qemu/-/jobs/6177909577
> Duration: 2 minutes 50 seconds
> 
> v1: https://lore.kernel.org/qemu-devel/20220215002658.60678-1-f4bug@amsat.org/
> v2: https://lore.kernel.org/qemu-devel/20240209152945.25727-1-philmd@linaro.org/
> 
> Philippe Mathieu-Daudé (1):
>    target: Add system emulation aiming to target any architecture



