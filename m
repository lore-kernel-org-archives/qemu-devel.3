Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30BAC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 04:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYe8D-0003fE-Mh; Thu, 16 Jan 2025 23:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYe8C-0003Wn-CB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 23:38:52 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYe89-0003hq-JA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 23:38:50 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so2945977a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 20:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737088727; x=1737693527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbfLSzi78u3BXbt3P04f4CtHx+66htR7Nmtw6hv3ryw=;
 b=cVs5tluQwRqzaSwhtKKTunOryjUyiDyRivL+3dFibcw+rdi2VMQFClCYbKncWRCp3v
 Zrqk6QWErWOrkFy+MExcLuMNJ08rhOD+VC81IokRlXFTW4h+Ksu+OfeTbiPibwdz5KD1
 DT2LaFjGXexKWlSkmgQ9L6G6iGerjnip07CQ51LrWj0JrqPrpzG/FiUwuSYwnifc3ejB
 tXq6xLRpxOcuJYtEBRFgnUJBME/pkh2INRvXF2qUw1q/a3/NLGN3uhTjFIxcOSVZUsQ8
 bPUw1rEKPA4WrQJHjj9wpIfI1fYcxwQLFNYjlF+JrsuPb2yHiKZGQMVqkwjhXwWJFNGo
 znDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737088727; x=1737693527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbfLSzi78u3BXbt3P04f4CtHx+66htR7Nmtw6hv3ryw=;
 b=KGDFFCTR1f46/HlG4/CJZH0htvP4PB9iOLe0YWEcCrT0MKbUV5HCfZ2mznx/Qjo/js
 1X2ew8C5dIuxaQdMl/T5mxdvZb79u6Zhml52dX9h1AEIhWjal4QL96x9dOxQW4799QDE
 T0aeqv3gjir7p694L0Z1/yoeReUP13XcDWlfYghiAZ+D4nQgyiqxcUoQVZK3h4D/2iA2
 /QTAI0cmLiFTNCZVQzUkhv/g8hMyRAxb9O99rJ+XRxW1NCakwBb1B/6CqbODSZHkrwLV
 Tj+L7Rn/KohhqbVn+QS+RpO/HhfKoBmYTcS2EHNBRJEypK/Ai6fQ136cbDlkJyoC/8sQ
 8HWw==
X-Gm-Message-State: AOJu0YzvY01XRt1Jdv//8AsS6AqGWW2EFumpaF3JwaGdOqGbEQwPhmzE
 WTIhs4mtAVS2e+0F8C87OLnP01lyUfzkqdShk+sGSe90Ec2oc6VndI4wllsj4S4VFK6jFMAJawf
 r
X-Gm-Gg: ASbGncvQUKYiBgmKHUlCMjT0MMF9Dmb/iqe3Wz3HkyxAK4XnMXHIX/euRhRv5Bt983S
 mDd2R4ZSZLmW9JDXEJDxMCjq+aM8sd1pEyj4Cz6Bkc1hyHp+Wfbs2VXwfxHvL6XyTzzGP/ZtTic
 CvUyDd4+sZ+svj4Zd5tATnT2dyNFO/QYKIta/VhPOg68GyPGOnAAc4hgZvh/5SCZGcnePrpovFZ
 uPJ1FJe1MPDzBx6NehwRgYWbIM2gb4qlcnoBHCMngg/ds2wTrfUPKoXch3MTX3uQaB2tRUKwKpY
 UNwdr8cYXlD5vNtdI8J9MrE=
X-Google-Smtp-Source: AGHT+IHg+S1Y198rmzHBcEeQ8yPFxFY4PA/qqHEofasMNQhJ1vxlMASFi17VUCu5noKjjB4+0kB7ig==
X-Received: by 2002:a05:6a00:2443:b0:726:c23f:4e5c with SMTP id
 d2e1a72fcca58-72daf9be6a8mr1820117b3a.1.1737088727363; 
 Thu, 16 Jan 2025 20:38:47 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba5406asm828903b3a.155.2025.01.16.20.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 20:38:46 -0800 (PST)
Message-ID: <fb992a91-0a26-49ec-9ec4-4e81bc5e15f0@linaro.org>
Date: Thu, 16 Jan 2025 20:38:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softfloat: Constify helpers returning float_status field
To: qemu-devel@nongnu.org
References: <20250116214359.67295-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116214359.67295-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/16/25 13:43, Philippe Mathieu-Daudé wrote:
> These helpers don't alter float_status. Make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

