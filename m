Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb2KE-0001c8-Iv; Mon, 05 Aug 2024 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2K5-0001DQ-29
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:20:45 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2K3-0000Cq-CC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:20:44 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so12548405e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722882041; x=1723486841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=irwYreD+uPrCZ5hV5heBFP5fiow3VgRJ4RHd7MTnLxg=;
 b=R3O2XXYmKWcyu8mW9A/CSbxbh2UtT5zPnRBQmRh+rIP3l2Mvb02Nv8izGgWPVvTlIT
 P3z/ialHPsq3LPid43AE7JcpsC/gdeSD1iR5Xm6QcEBIvHvARD/3lCJPCTTfV7QF6ubD
 DRQ97S4/K5tg2jUwNO7LjGrQ6Zttj3h0ZTv3UPi0lMG8AjV+yLnhgoa0qnbtyYr64qaV
 dbU4+7pQyhh+KGoePgLWa21Z9Ohl0tlsBmbaNXVsU1oTbAdoE2acFT/9nLOoZCsBdUvc
 I9eDtVsDWrfgKmq8ZZaDXXunoEFqjMEh0zgUA5fcVRC6MnSmsKA0DUthE35g4wk26yGB
 ervA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722882041; x=1723486841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=irwYreD+uPrCZ5hV5heBFP5fiow3VgRJ4RHd7MTnLxg=;
 b=FfbOQfrBc1EPLNtoMRcz6Dnm0SC9yYGr7HMhmffdYza5hWdNgJazQNs2KnQkioMjAT
 HnVTobfSIB7EwMvKsbtEmnC8QZ2wIuFi/Mewbk8PSKatJ0ZtfT6CtKIxnV5XzySXPC4g
 0NK0SyItDUlNlnKn42wgOARQhy/pfl9lN+ffDbLaXc81G/rnq/Ak61roBgmPIpWd+SLq
 KIuBT8aROlKLvI0/KKSm5lOTW8Cm8KRUSG4gX+qy+vLD0uFdbk8LuCPi4JhGVVeNe8N+
 /d++UljfUouv3sGkSiY/NfqmvRcLdY9OWih5IH6YmdIGRuEOsN0WIRImZLOKHDwY7mic
 0aTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPoFmAlQdi0jndI9l0rsg42qb5YeBuS/KPlAbW+e85TMWaAHsw7mCmY33ULkax8KpvRnW6mjhpO4iUhG3kRdqX1Q8umg=
X-Gm-Message-State: AOJu0YwgmVh8bMR0PSNBfvdN/2/eAw8+h7JzM+N9YM9NIagV1ZbfHolB
 KACoEQa44ENBqAb0S5Bner+YYBXgX7n28ctTjuHHl6wa8ZW38IUTLimBbJeKZrQ=
X-Google-Smtp-Source: AGHT+IFUrypcV9n8z8tCUvwqmLHNMyLvzelmBpCphhhji26cviVjDNsqa4inluIH3p/VStp0CxtfDg==
X-Received: by 2002:a05:6512:15a0:b0:52c:b479:902d with SMTP id
 2adb3069b0e04-530bb392926mr8490702e87.4.1722882041127; 
 Mon, 05 Aug 2024 11:20:41 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec886esm477011366b.203.2024.08.05.11.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 11:20:40 -0700 (PDT)
Message-ID: <aa7d0d31-415f-4c50-a77c-1beef1da9196@linaro.org>
Date: Mon, 5 Aug 2024 20:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/block/pflash_cfi01: Don't decrement pfl->counter
 below 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731143617.3391947-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 31/7/24 16:36, Peter Maydell wrote:
> In pflash_write() Coverity points out that we can decrement the
> unsigned pfl->counter below zero, which makes it wrap around.  In
> fact this is harmless, because if pfl->counter is 0 at this point we
> also increment pfl->wcycle to 3, and the wcycle == 3 handling doesn't
> look at counter; the only way back into code which looks at the
> counter value is via wcycle == 1, which will reinitialize the counter.
> But it's arguably a little clearer to break early in the "counter ==
> 0" if(), to avoid the decrement-below-zero.
> 
> Resolves: Coverity CID 1547611
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/pflash_cfi01.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


