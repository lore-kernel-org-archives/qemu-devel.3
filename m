Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE355E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBBU-0005D6-QT; Fri, 13 Dec 2024 14:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9M-00027I-LH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:32 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9K-00086Q-JO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso3817585e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117389; x=1734722189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkwtbKYN92Edw6prtIY013lMT+VdTEfLqeuDLCwuhdg=;
 b=FuD2KPfFDMvmOopMLuYpng0Tieuf5rsLqaXJ/KtyHJoGI/RkpM0RrY96/PMCPINMZH
 PUsy9gq7HTEjGH2rAXe/zDdKxw58mvPYhPNoKJzicVC7nm99WDhxdAvTsF610ip+UESo
 pE3KYkNp4vvTXgY7LIB9msKi2GBXItduo3HSlRsAkbkeDCjoyFmYQxgBhthowdE5KYGx
 SLr4OvBRvnWfXa4tL8kkO024Iq631cpAChu44oltcoTCbJXcnY3r6bbA5fA+qC/WaNzW
 t4CdKMuTom0Hyq7cH1uYdJQakQEUj4B9optJME6Fzhy4mOVrq3xVLxzeBd0PJ3exLHKf
 jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117389; x=1734722189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MkwtbKYN92Edw6prtIY013lMT+VdTEfLqeuDLCwuhdg=;
 b=rOWWm+Rp9ax1ETLLnom5CPqY7JR0kt0K8c0gJ2hUSUJsJjA+Lw2sKsrBCb49qYeWZK
 foLJHge+xtOhwfv3IDp6KSQV9NyhGpuzcw+K/3r/tfwmKMVLEbIbD+Bq4lmQ7lSl225T
 0m30upuGWyEt2Cd/q+BkLF1bwLmEkjyMMYp91/pcZHJlMnXQKJ+KVfiKPMrJpvIA/NUV
 uv85rq97L2AVGR2YQCoSxoMIRfbcCI0BH9JV9Ug5hrOBQW85DV3QbYXHG6pHWfoDFKAg
 kXFfchSvMB/v5oiLIH6lXUhezm0Q/yQs9QA4sbZFQrizwV6d0EjyKUYHSFruJpedHoUj
 1aBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0eD1H7i1yQb7nkqB/qxo0++hDMKJKAo1Xo7YPKYBqNctjSjKrd6wUxc2l5axcrfJzNNfV5lQXDEu7@nongnu.org
X-Gm-Message-State: AOJu0YxcKdgBJ6IwCeHK++IwfA9jq4LMdY8MIFyHtSXrgPwLd20HbSxO
 qshkoTIuq+rTvdNJ/S/hY/lvznnWcV0QBlbHyXZHJ/9V+wHNm+YdVNpKGD9WXm8=
X-Gm-Gg: ASbGncvL0m+BpEuOqt/+cP1THpzKAdr5GNS4BMh6wAaLwubdStq4bOvUUUJSqjxlmPU
 zlsUkZ/zmYXWHu7dItEqB2vNS7FL/O9ESiKR74VtbSrqLXCBH9CUIR0h8gZdl/7KXtUtcoDSn+Q
 39fnpW85XrHkH0tZgggiRVoYWY3CPVurWnyFlTRQkCpRQY9fegTlGRJiNoLhjwD9sf4uSIIiDUx
 jTzdAe+n0qFxu5rcoOdnVDXXIxkD3nwHq7eS69tl+nSE/3KSIyvOPafgtYKVjCsbq8p6jofbVbh
 RrLjTENM46LDyqJnhLqb
X-Google-Smtp-Source: AGHT+IG2xhki/qLW54coKokgzLcQo94AgqnF2lAdaoHbBAJ8MonLO+12ttdlsrZlGtKmIUY0ihzdNw==
X-Received: by 2002:a05:600c:154c:b0:434:f3a1:b214 with SMTP id
 5b1f17b1804b1-4362aab48c4mr28461915e9.28.1734117388701; 
 Fri, 13 Dec 2024 11:16:28 -0800 (PST)
Received: from [192.168.224.213] (127.47.205.77.rev.sfr.net. [77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046ca6sm297070f8f.83.2024.12.13.11.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:16:27 -0800 (PST)
Message-ID: <7af8a419-745e-4348-a564-8ef078fd456b@linaro.org>
Date: Fri, 13 Dec 2024 20:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct my email address
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com
References: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/12/24 19:12, Brian Cain wrote:
> Mea culpa, I don't know how I got this wrong in 2dfe93699c.  Still
> getting used to the new address, I suppose.  Somehow I got it right in the
> mailmap, though.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks!

