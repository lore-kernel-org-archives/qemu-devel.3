Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373C2C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1Lk-0005YK-Kw; Mon, 03 Feb 2025 13:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1Li-0005Y5-2I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:39:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1Lg-00046d-9m
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:39:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385df53e559so3474157f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738607946; x=1739212746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DOs0LwRub4b/yyHZ8GrD/+t39yLGy9Twur4JuqdfU64=;
 b=y3QVThYR8AREmvI7O1lIUK3TuROLtgKuX94d0DT9AofK9fwGM+FYMO6jW1qKcsBKP5
 p2nOMqHYhD+hPtkcwn3tEcDohAu+6vngjRi6iS+WRRCcnGMDhDYu+U43xcRlKeSQ3Si5
 And17+/EO1XFRUylURKt7XzVfllUWrj/gt2Z7mZPHmXnDfY9Hxhz+hmgkOuYXYxoU5Kj
 IL1IDFevqRtTBR8FQWbkRKE9wxvA76Hfa2zh8MoO/UaYWc5vJ7OxczqsoMdwtNulgIrl
 El8pEoCRUUrgydKCDVtQqI4uPPaqBP+/OHRBFmVObIi8kE3FwoUTWg/sZZYF1HowNxd4
 AWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738607946; x=1739212746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DOs0LwRub4b/yyHZ8GrD/+t39yLGy9Twur4JuqdfU64=;
 b=LnrhsxtjCgxuErkm3bqZ5dG+Eqodgd4CXy/Ehbp6afV55fIVuq97zCphKmWFUIkPIW
 05hp912U2cs2pIIuXl/edQBsD5AAJ5q/ioftAKWDmIshgsevLFaeH2SgGDQL6VfR6Gux
 GoZPN63frLw42fWaKt3rwbXlORPkjc3Y+RwfPib6p8n6yxXX7HAgXAd463+5aRGFXPwJ
 8kEm63yIaXMhwM4Mz5YW4JSWpEBjSl4ROCJ9O0tzNXA+1/XDCANF84pU8dgWDc4wUen7
 ENg2QhCGbS3484ZkbB5U+B43Qhio8OwDNdL1PmBMLpDEo1CbsjLk1VgSRPnor1q2V1tg
 TVXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFETsW0QMAlQski1yvI4n/LkX6hcGSHmsf1DL+l6rK8/nptWZNE0aCK52bjIIsM/VyvPYkRgrL5LP2@nongnu.org
X-Gm-Message-State: AOJu0YwMFhIXi8OLvOZrCtqGaZv3sFdHqFnwN6/MsQmtrfmFYUYFTOYv
 ynwmmgWcwR0IJsztcwfTQWYXer9VTJA4DiSgPdY3tTjMBr1A3Sfy58K+PLWRWjY=
X-Gm-Gg: ASbGnct8lbZa+AYnOEjD34QV5HV0FftXf4gwVtMYb5ZUo7qaUOkhcg3d45Umo9Cws4z
 1c32Zy/9Mki7MDtjRsyYQ/dGU5lHMBA9MRCX/ipYAnC4nKaxThYOEvBCB50WkfLftMIyoFvzq8q
 5Ums2XrfGI2K3//Q4EEV0VQjhM5KvKk+wufnk0hx2MiHfKngJzMbuXBRiLGSs+bn7MTBkNK6JIt
 mD9N5Mtxf6u25x2IbzyUAmEcyUGV/wCCBM0YJ90wOvg1bzeVMZ8vvtpcopKL7Y3Ncm3YKwrIf+p
 WNEQhSSxU9KPHIfl8YfVOBtfKuJ5WDB77TZrgbgWkgx1aKqUx1eisYiXxMg=
X-Google-Smtp-Source: AGHT+IFmEmW3sdWQouu9OihAnnGhC8o2tO2SHkCmZuZRIkM+2v/PBHImRXG1w49rZIPcv1OnAHdl5g==
X-Received: by 2002:a05:6000:1ac7:b0:382:5141:f631 with SMTP id
 ffacd0b85a97d-38c5195ccc4mr15531891f8f.29.1738607946347; 
 Mon, 03 Feb 2025 10:39:06 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26b15sm199092365e9.11.2025.02.03.10.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:39:05 -0800 (PST)
Message-ID: <9e727388-8c1f-4247-a6af-bb42a953de07@linaro.org>
Date: Mon, 3 Feb 2025 19:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] meson: Drop tcg as a module
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 "Jose R. Ziviani" <jziviani@suse.de>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-2-richard.henderson@linaro.org>
 <49d601e0-9a35-4c70-ace7-415dc6175a9a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <49d601e0-9a35-4c70-ace7-415dc6175a9a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 3/2/25 10:58, Thomas Huth wrote:
> On 03/02/2025 04.18, Richard Henderson wrote:
>> The fact that this is only enabled for x86 probably means it
>> was done incorrectly.  Certainly the set of files selected to
>> go into the module is woefully incomplete.  Drop it for now.

Maybe add:

This mostly revert commit dae0ec159f9 ("accel: build tcg modular").

>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/meson.build | 11 ++++-------
>>   meson.build           | 18 +-----------------
>>   2 files changed, 5 insertions(+), 24 deletions(-)
> 
> Looking at the cover letter https://lore.kernel.org/qemu- 
> devel/20210624103836.2382472-1-kraxel@redhat.com/ it indeed only 
> mentions "a small fraction of tcg (x86 only)", and since there were no 
> follow up patches, it sounds like an incomplete conversion to me. So 
> reverting it three and a half years later sounds reasonable.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


