Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5FAC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcptm-0004p3-SM; Tue, 28 Jan 2025 13:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcptW-0004ms-8v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:01:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcptU-0001nj-O9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:01:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f796586so66599185e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738087259; x=1738692059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=05uJkEou8LnjRIak/KJvbpOpqYGb8Ck0gf8nNDEYKjU=;
 b=t2xEoShVEQQck9tXSxXtGotzlcs3C/yB2Nn9x/7JjIBs8GIylZEBMqPcLjl4cW5W6x
 SNfljHvymqUbTLVhS5yR4bAjrTYZXftOYR3m4s9fdbcpjQP0pptx4CBweZK/pqq/TCGJ
 OpjMqPWiH5AKRlrRkMuHcuageIU6aMWh5O301w4FLYJq8T8MYnnbnaLJSO+NCImBWWJ7
 IOxa0Qmv6fsRCujCJ8S972haHnQTiDVXEi2Cy0kWrZL62lEJJbJR2n/hvSlL73NExZwB
 CdRx/eet3UoJEbM0f2WK2S9Cgk35j2SXPO84u3G3FWFzO1Z9gVX4OVIU9haFIqyJ4TkF
 shmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738087259; x=1738692059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05uJkEou8LnjRIak/KJvbpOpqYGb8Ck0gf8nNDEYKjU=;
 b=Qi8PEBz/HPrZwhI47mxiLA8Ge/jbyUFcx8DZMqkVloYtS0nnP+puueLB9AqFkkhxXl
 WeWj+0eULyJjtgbci2OB2abUzCWYxGRMxEcDNSzZphYeX0t0JSX6cf576SPXsEXpAkcg
 LjWsBBr0ykmDV6uzVfoAcjAUg1cm3AeKM7tRAcr5ltcFM8coHhzbeFynfiTXDwgJU4S1
 mkzdt3isPp6ISHKff3iNVzTvsLlVC/2yVOyfVpRy/Jg4o1L8Bg1aSbC/GDeI+EgdQ1+Q
 9FkI6ay9UeV0wlKqUfSqHuU+yRh26jmObDoJ2PZr5XPTHoV6YkKAD0WlkVoujuHjS9BC
 pu0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9F0bVH3OMz/fEIZQ00RsAABtBf7qFQO4VRWzoLJbVQFdP8xKp4QOycBwwxZgD2fQia6qaDmGA8TCL@nongnu.org
X-Gm-Message-State: AOJu0Yxe0qA0/UZ6dK7rkhRGxsNlyUAFPmPghGddfwsUNbyY4CQZ9GcX
 EWqGB6Q61AwO+GiWrNFMB5qKANoCB06HGpbjoo2BmfccnUyCf+oefqtDiHjWsOQ=
X-Gm-Gg: ASbGncsrlYkxjye4mVTX6/XGRF2478/cwNle9J+qUz300AeRQX0ltJacMPmtsqgvChG
 GY+UuL/lNpw/4z6JKtguCCIsyD359A4helfagaWAdba6Q532Yl00l+inyLs+y25GvX4Z8iF6SQW
 mWOhv7K8mNusAhQsnbyWXL+edvGbvl9BWawqoU2QBF5Gvi+mL/6IuS9zpS+qsQGpZImtD+iJIa7
 cRhQLSayQHdyeJOgz60P54PBZDtO24e2PtGhYc8mWm3Ligcy72SGoqxmNt7gd8E8unnSzYuD0Vb
 xEpUJvnUAYGUrMdNZLe0oxIZeG2gSkgSaY1jexzPVHMOyCr3fuLfzrfQS5k=
X-Google-Smtp-Source: AGHT+IHPijWpGLOt1WdKW/7rFHRk/0LxpYzC6SIxTG1rj6v2hdThvktP06oNmWghTVuNIsy5eFsPSw==
X-Received: by 2002:a05:6000:184e:b0:38a:1ba4:d066 with SMTP id
 ffacd0b85a97d-38bf566a1cbmr44536252f8f.27.1738087257029; 
 Tue, 28 Jan 2025 10:00:57 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb04csm14940718f8f.73.2025.01.28.10.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:00:56 -0800 (PST)
Message-ID: <bcea60d4-2525-4eec-a1d7-2accf56dd7e5@linaro.org>
Date: Tue, 28 Jan 2025 19:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
To: deller@kernel.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128170914.13353-2-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128170914.13353-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/1/25 18:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Since I contribute quite some code to hppa, I'd like to step up and
> become the secondary maintainer for HPPA beside Richard.
> Additionally change status of hppa machines to maintained as I will
> take care of them.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


