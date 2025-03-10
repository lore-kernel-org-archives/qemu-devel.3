Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CFAC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhAa-0007Qi-SB; Mon, 10 Mar 2025 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhAQ-0007DQ-RZ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhAN-0005SY-Hp
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22401f4d35aso81085255ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741628621; x=1742233421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lk+8gKxBMVf3UkRami9FYZhFRWfvuym/g3vvdDoVV6w=;
 b=LBfs55HYJPY9u5EVhbETHrRBS9/dAN0PzY4+l7KlqAMtA75/LSz7ZHvz3Et1w7bVjd
 WO7kT+CoC1H9NE1TZu3oBIZXWe4QoFeXp8HC9tfmSCDnUrBKVmqnjeykENKWP/4K0aAr
 txuEJvXt3M7EtlXn0PklO0b+Cxhp17KjUkkV6JmeIWRhC/BR4Xz4gVuen8YriW5mHoms
 royYbFyTiWShVnv50cPM4xrvj3Hl/6cHGNnsrFzDwOHG9utGJjlOa8eZD1KPrPfPuarB
 fnCjZr1BxyKa868F9jOkdKFVcTFRRpJm+vuUqAMiF5w0kw63o3eJEGIlQoBxW9mCxdQO
 Xs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628621; x=1742233421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lk+8gKxBMVf3UkRami9FYZhFRWfvuym/g3vvdDoVV6w=;
 b=AMpKpAWOghla2Hc9UvKvvlabApsN+qxER3iL9aa+6hWcSXKwo9L53N9HQ/6w39n4R/
 i1rAvpprgl2A7ylFEib5mhP/bIBmdSo0VfNqXsnXAjn8LMJ/IU6bldRC+S9LPOYWpMj8
 mUi9T4ydG6gBrgPApLaklwQBiQ8wsgs3SrrCsh7SS9Mtpbg1tDuIo4cewQckqsN8v8gD
 QDzOo9ofgq1fvpZZ47kbGh0D6Ms6YUBh3vpWicfp5VQE3JnZvF4/RnRuO/qIqxFUfBry
 0cc3JFCefguJpcApWyHNPkjsGQ3+vZzJznDhTm7rw6Ub2jKWubUD4+7doDWA9trzKlhN
 5Ivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjZDE922vrvkvnoPrxk+hm+EahZaAKbrP7Y0AQRFF4Y8vmENpLtC2dCPjaSO9wB/odzodwU1phLRG@nongnu.org
X-Gm-Message-State: AOJu0YwBLdfZLQuGd/J7dxrRWA5OFHQ+sfRoerkj35TQkSKqNbekVDnE
 wsDQAZCliv8uZ3wfJ38+d1Xsyhfl+nM9vvdx0DQqmTtBm3FM9DLG369hUOB0AWM=
X-Gm-Gg: ASbGncuWubtnXpywVKk2njXyZub02F3/2vNb8b/mcwAj8R3izvwNCd4WZS0LCanx01X
 ntbvrCvCVKXYUMV3mjnDZ3drv4tuBcaCnYPQeNnpBou3Uovac4mgXFTDN4s4RRUeB/4mA920CW+
 7Bd7yVz3yd9hfN5OR9rKYShp9jHAtAl3bKxSHnzPPn356+wlKKbzqL7MD5tFdnPEKHZDymRnnXH
 SS5ZLu/+5t45FxhThdmfGJZTt+PxuSYt7tMWA2poCU87yTl7A8MM0NVSXkFst7kWMSGOuXSd0G0
 8QSD/LZuOahTbedi4u1Xhg4TQQ/gbq6cBJYZGmUAnWNXec4th/bveLFMT8nbwYOQDJKJ4U4uWDS
 /94gVv0NO
X-Google-Smtp-Source: AGHT+IEDfBNGUsVlKoaNdSW/sZabx60Mld/aDlfrRINrcRXW9Xfo7e1G/308seo7ZPf2Thoa0rutxg==
X-Received: by 2002:a05:6a20:c6c1:b0:1f5:59e5:8ad2 with SMTP id
 adf61e73a8af0-1f58cb40fa8mr1143980637.24.1741628621616; 
 Mon, 10 Mar 2025 10:43:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736af3a69b2sm6677266b3a.6.2025.03.10.10.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:43:41 -0700 (PDT)
Message-ID: <43a433c9-e556-42a1-b1a3-28473b086496@linaro.org>
Date: Mon, 10 Mar 2025 10:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] system/ioport: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/ioport.c    | 1 -
>   system/meson.build | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

