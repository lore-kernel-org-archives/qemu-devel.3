Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C0DC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LfU-0004wo-Eo; Mon, 14 Apr 2025 11:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4LfS-0004wL-C9
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:24:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4LfQ-000336-IW
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:24:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1104607b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644249; x=1745249049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QRbmsoNip6ndbKJoJI/SLntL1+eGwnbKXnNN3Vqyb4U=;
 b=C7l7ukVUn9YxVxjX763Y+b+bHzXj3IChGdTGMrnMmY0UC9jh/eGKVZ2ne5ocy0Ebr9
 WEL3W/zsBzWtgmW+Pd7F9ZmY8UHt0p9O2dmizdeYmYIGyKAYRG1Ag/YcUKjShGULxJPK
 +D5MhdOjETaBnWNMemoeJe0c0i9ZaqRPkY6WMbvTYTzTGa+SCsc2F3aj9pQdy0dgC1Bk
 VeKj5YYB9YLvn6INyWM91ZEq5eAbAEdYL6R4X3J5gEEJPEx+yHxls4cqs80Rqn/mMRmI
 qqYm1TquueVLIDP811BuQ/KP6hGEvCKUvrbyj8x7LscuX28mbipZeHrjmy5GWVAxSsKy
 1muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644249; x=1745249049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRbmsoNip6ndbKJoJI/SLntL1+eGwnbKXnNN3Vqyb4U=;
 b=ibXmZsZXrYzeyTihdOCWjvWgLh+dGty+2Bhu0MBenfSZ1cDrRWxaugr8DkDxzh1Ak+
 FLA+NpBn61jNYpMKuDy1mL46GmIndDEyfHNyitnIqSzZXYCzCZ0ANs9dL4l8tYveMgbC
 cogrEYVRycNF4H+gOYNXyY26bmRnTcORVuIlcBxQNk6z3aBGNAE49rXHBUaSvKPMK2wm
 uabIwdhSluBtmszTcDP7SpXAmuKTZwTDZseNFWDXpS6b5esBMhb/2Jso9GdelQEkEHqX
 iHQPMzedHiWVa6b6H82z84Gu0iDtf+lTT8wdu9GHgZq4KWQ9gSMjkWMGJ7FbBQhoHGEa
 DRdw==
X-Gm-Message-State: AOJu0YwdeKtVEBJwbq6QgIr74oZXVqKmqV3eAoGe6H5rfYnVgUpE4mc0
 k8n8Zj4d/xMqCjyUNYGKC65vsgAu2tp5Xl2QTImVA27R5aZKU6u9XtqHEBP7MKI=
X-Gm-Gg: ASbGncvU6EvIVdKPFeQ18I3jnYLBT2cd9y9Am+qPG5vAtBQonlzN7jG4h4AKlTkd3bC
 WkbKxQ699/7MVbN+ITi1w+OMwffY2sMl+yy5Da8ZyHCePrWDbVx1IEWvIEWTRjca2qo9EwqgW9K
 r2dnRiOHVx1uT7zkx6DxghdRY1ronqajP2UL2/2DEgG6/0scseSGUgU+UylCCss7EDCA0dssU18
 RorEXiRtDe4VGY8izJtfV30Df2i6vNwEWG82ECXvw3eXZxFL7mo99pgKl8lvvqEFHqMYA5OIAuL
 aIzIwgOKZeqkk5p24+QnVCzbEA8z6ml0i72pvwZcW9wykGQzluqioiOI6n68PQlMZcv79HtFcMY
 DrAmoPL0=
X-Google-Smtp-Source: AGHT+IHkf5tdbhz70QoXqTePteIvJRSgq8QZyPUV//8ZQPcVG4fqBuutrI+tRmZOnlK0hIpky+VdyQ==
X-Received: by 2002:a05:6a20:9c97:b0:1f5:8eec:e500 with SMTP id
 adf61e73a8af0-201797809cdmr18621377637.9.1744644249138; 
 Mon, 14 Apr 2025 08:24:09 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a11d2f78sm9334539a12.44.2025.04.14.08.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 08:24:08 -0700 (PDT)
Message-ID: <a52db1b0-4ee2-4d96-bc7a-288028c35ac7@linaro.org>
Date: Mon, 14 Apr 2025 08:24:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit
 emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250412164315.36161-1-richard.henderson@linaro.org>
 <CAJSP0QWHv5uQ0n=re42+whWgPyASPThMYoT3VOqPbYY67fgE8g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJSP0QWHv5uQ0n=re42+whWgPyASPThMYoT3VOqPbYY67fgE8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/14/25 08:16, Stefan Hajnoczi wrote:
> On Sat, Apr 12, 2025 at 12:43 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> With acce728cbc6c we disallowed configuring 64-bit guests on
>> 32-bit hosts, but forgot to document that in removed-features.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   docs/about/removed-features.rst | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Merged for 10.0 via Michael Tokarev's trivial patches pull request.

Thanks, guys.


r~

