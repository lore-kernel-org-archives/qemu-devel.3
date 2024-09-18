Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B15CE8D6E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srE1n-0005Mg-W9; Thu, 19 Sep 2024 06:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1j-00059v-KH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:43 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1h-0002HG-OV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:43 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so78140566b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726740280; x=1727345080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkb9RoMieZB7x0grFP61zIkg4zRv8Ds7sTpiRSCuqVY=;
 b=qsZOLYpyDGcvhUGbaqhCso4AeoBNKveChvHX4JNU8xAXuJ76sdgMav24M8Dj0I2MZn
 O1y7JRSg3EFXVq34OBDkYUiPUlPRlWy7xbphgmy/2rSMDmzYAK5drzc4i6fLye8Ts2fb
 7NLdsMklpTEYK1zoAYYNxorZUSF5rcx+mEdMbcLS6grenn7dF2RW+GpmW/XlnarKvuOO
 WgjNzkN0rJ7HFSQ+Gwwk03/CTu0d+3T1AsckHAtVB9vYxiu40izJT7V205kPj6dLkPOz
 UWmTFONPyNzHnKwSKij2AHQuWc7ka0gv20zhv5Ys+6+0SwlRKU8AAZEcggnljyI47VfJ
 CC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726740280; x=1727345080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkb9RoMieZB7x0grFP61zIkg4zRv8Ds7sTpiRSCuqVY=;
 b=PjS3Z8blFfUV8MtZM7dhsefMcdyQ6gS91SKkNCbIC506DwgY12bt+mVMFMMhvqfXov
 vd7Fjs9GdobErndBCPF56Csuwl9tnevEHFuTWl0wmx6IpuFpEpa53ce3NR36bf3ClAw7
 p/ElbKYEVKv10Zfdu+4gYMQ+qrDoalKXexKpA3Eg10AmOFc0OrV6uwBbYRsAXE8inCtK
 /zPJ8+yXz6RymRRgU4NNQafiReoLisfvdPg1o5hXYhXqb/IFw8G0nFqd2yhF6aJLnnuD
 F2+6i9IlDRReslQaQH6LdFhdRBL2PLpdqQCx2vwZnLE7k6grupGYznhxfAKkQ2MCMHsL
 /S6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWmA5SzhsqCWZSncISXvewcOCTeaHXVvq/zkVdf35pmpVyxe2WYwpESccl3+gKCdGsZFS0KfFfpHA6@nongnu.org
X-Gm-Message-State: AOJu0YzFLj4Sk0cWZzruoLc9ZudkHH0dtZwIprs7IgsGfOgw5RWfdCSK
 8h6/LHFWpHxL39sGBmXxdI8oESZIH58j8uODITO2BkgILtBVlirnPYax4MXaGFc=
X-Google-Smtp-Source: AGHT+IEiYf0vDmd1hmiet1Nxw2vKyN16OJHyyFeZTNvhYEY0pShiNSwywlc/0dmN6iRGOqg+E++dtQ==
X-Received: by 2002:a17:907:e295:b0:a86:7e2d:f10b with SMTP id
 a640c23a62f3a-a90294ced3bmr2292115366b.37.1726740279980; 
 Thu, 19 Sep 2024 03:04:39 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f3aaesm701574766b.53.2024.09.19.03.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 03:04:39 -0700 (PDT)
Message-ID: <68b03a32-94f7-4823-9698-9af6f6552a0d@linaro.org>
Date: Wed, 18 Sep 2024 16:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gitlab-ci: Make separate sections for build and test
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240918125449.3125571-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240918125449.3125571-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/18/24 14:54, Peter Maydell wrote:
> Peter Maydell (2):
>    .gitlab-ci.d: Split build and test in cross build job templates
>    .gitlab-ci.d: Make separate collapsible log sections for build and
>      test

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

