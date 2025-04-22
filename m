Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC39C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DXz-00089Z-8Q; Tue, 22 Apr 2025 09:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7DXo-00083V-6n
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:20:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7DXm-0002aK-84
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:20:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso56556985e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745328008; x=1745932808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HcBU7cPdXrzzIYlWGZmrxt68iF6kiNY+7kM6Z0tpie8=;
 b=vgZQT2RXLYdWpGLWEzk9jJLueX2n2+LTnb5q8Vm9PtYA8RgGh6Kyc2UkHWaEOOanEH
 2vT98A+gOT8p9QVoANQXDc6r8sq+t7m0/5Bpuc8phTpFaS+dBZnLJXbLcycMMwMgtfXw
 flbCcFh/p/Fb9ns1mlTMnC76DPGCMDO3bjileKU8STGKx4Ggm+J7Tq5CV2V5w5TSsqhb
 lwBEdB6dTHp2JG8TR14xFaUW9Qey5QfgLuJua8JKIhwPNo6fX8l6komqQ7sxE0n5Xw7O
 Kq5OUyWNu5rY+QWV7SoyWyx9QshIUWgT85t/0HnIFzUUM3vTkMZ2PDLEHAeI8jqWtBAJ
 dAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745328008; x=1745932808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcBU7cPdXrzzIYlWGZmrxt68iF6kiNY+7kM6Z0tpie8=;
 b=NLyETgB0ihncw34fEyMixgcNBPJQPG7NdLSnJpqRgUBZ7LqQRgc0wH6rCxnmSEy9aT
 SOTw6RQVWg05MOa9rURWaHP86mT3nhTb9haVkY1xXTflbEGK9jGWgRCuwStVDweOnOjF
 2TJhfCxL5Pk8HYw5c8y/6a/F9sKAY/V++GLOcbnHlmwp9Mf1IbecKYUKI4Qd8VuBWPlt
 EfJQjs6k/fm4R5fTb1iSTF8Au+Sl3tfuzmMRRPHxiRHjWy3Aeys8/IgTOgIxtyBGz/3D
 kqywlI75zgjLQet1nSJQsB1c7m6DDTsPz+BUnaTLj249THBdLUmwGFu53bDUyGe1n1du
 h9vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5e4boLP5KjG6z4ComGDaF8RA/aCDRoPooP7biD7FfNunzLQZJtKoMbalg2ovHIsD6ZEHha7OIu+pP@nongnu.org
X-Gm-Message-State: AOJu0YyJrc2rk78yNWWuDwTOCvMgvxP64WpFPG3D+NNqk9y+5JSv/QEY
 v3DEHNtPBSGVka4bOErdws29s/slrQ/2TPpTAtUmPCTXEf5FfzObYNVVuRKKs2U=
X-Gm-Gg: ASbGnctwRDtYAIxpp3Re5tOhZ6IsOaIktZzRSZKQfm08oKfV0WTif/BC4Wb9Qvuf6EQ
 uzMracqzf+4JA7jKBBn2Yc9or1o8fq6jZ/AU8kX5LuNeWCC+HNay6JP9+trEOqZETsMOzkKneft
 Px5AXzw96eoeWx/F5Y6UuEes9VC3vpXHlHterrsNBrmP1lc8XyHpjOPaUNrBlX9fgIfJ5SJi03b
 Dq1l9odl5a/lnqBniRODllW+JsCyIWIYWjPWj4yzTjy5uykgg2yOnLz+DMYqmWDkCGMXQUHK9PJ
 qpyyNpdCjePI9ltHf63+UKRVpENnsILKpeIq0UNTU+/4XUjkZGemMyvXZgILSdX40VQzQOwhsMu
 5z5tylFRppHxsFE9JmN4=
X-Google-Smtp-Source: AGHT+IFgSL7rgeEArhin88r9qe34SNp2P+nWo8iSnspRRdhoWmt/z8RV9lmC7H3OkOatGCW8YIEV1A==
X-Received: by 2002:a5d:5985:0:b0:39d:8d54:5eac with SMTP id
 ffacd0b85a97d-39efba38477mr12701948f8f.11.1745328007699; 
 Tue, 22 Apr 2025 06:20:07 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43bf20sm15013285f8f.48.2025.04.22.06.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 06:20:07 -0700 (PDT)
Message-ID: <0645c51e-fb07-49ff-8a58-49b29ab59a33@linaro.org>
Date: Tue, 22 Apr 2025 15:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Pass down do_connect param in
 qtest_init_with_env()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250422120420.3068159-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422120420.3068159-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/4/25 14:04, Xiaoyao Li wrote:
> The @do_connect parameter of qtest_init_with_env() is not used. Fix it
> by passing it down to qtest_init_with_env_and_capabilities() instead of
> hard coding a true.
> 
> Fixes: 5357ef823a1f ("tests/qtest: defer connection")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   tests/qtest/libqtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


