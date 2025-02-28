Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF44C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3cj-0003ln-Af; Fri, 28 Feb 2025 11:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3ch-0003az-1d
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:54:03 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3cf-0006bk-H0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:54:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2234e4b079cso46603625ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740761640; x=1741366440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYVucpfXxNhO3Sw0ZjefQ7DTOCWo8nPo1hJR78ZWBhI=;
 b=jcWCSqu7/VV/U8b9uVc+P40Rck4guF3IPbUPgrAS+lab21H3ojiOvj9JT9Ux0hxKJe
 43c4znQ7vjjaDBNAaD0CDeGjjWzscPTBsx06UV1gvmGduoGiudnAitpZ2u4Ma22E3p3t
 0CAaWgRSjQfkBaAoO0e3TkadfLAIDqalH14ta2ueU6eAAnW8UGw9pRttbsF2LC560EOY
 GoApwV6PCNU2FP6Z1VWnt86Ba+8Szq1TBJ78cmrLZChZJGHgz/6A05b0X5feG93Iarw+
 v9ZwZH7lWcC1pV+LUzLtH0ywFIADCh4ybKQZ6QaXcdNQ7Jd9Hy30OkarqixV5LJ0L9Bk
 fJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740761640; x=1741366440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IYVucpfXxNhO3Sw0ZjefQ7DTOCWo8nPo1hJR78ZWBhI=;
 b=E2NX7veaozLGn+7LF+n9tfYvyDKFsnmXf1NdUYgLtp17hLJKF9ioh4bh1W74RoHt9O
 MwKTLCtWk7qS9Oe1Y6JzEoaosL46NRxZi38FyAsrxnzzznpyDz4OC47sGF0MrE29XaQj
 M6J922AynYt6Ie+xkULgx9bQfS/zyGENoEVXuc4EpPYxglLlhu5Vg1JCv3mNy6ugW6aZ
 CnrGntbaudWBPS8rClp/a2fxXycG+2v722TAweklw4UvcWc8X2L48ApKbVLsVNeStGZI
 TA3VYjC7QB2jZ+WPbXLfVgQtVS8cIwU6VcUpcjVpxmtk0EqRU+lSvXAs6muFu1M6hNCN
 e+tA==
X-Gm-Message-State: AOJu0YzmKHKFqZBm5KblBnB85XAwol1M7h3B1Bu4wxX5QqtaCuFhfFaH
 3FWexK74k1UphxfyN10lZL2QsjYhKsNOvYv0dIFcBoNFG+l0n9gb2xODPfmdmy6dXxlNpEavEW+
 j
X-Gm-Gg: ASbGncsiJ3BE/tC1MG6F35QEtJxQ8thHdpuTP2VclRaTcxDxdjHaOYZ5JqW42rljsiY
 6Dew1vSjyLeMJ7FFAZfR+C47yajF1kKfemxOYk8zgUd5pe4cEl86TBAykz8eInUIj1p5xtVWqnP
 Hj6yhaG22VXLP2oTVG3HzipjMyMgpUNPkAHgT/jf6EEVMedJ50TRtI6swK0t1LNdfDHh4mKf43i
 kXLjYzuDEWzNHAjcqdnxLwKe1OOJwkQ8/dpvItAxomeWjFXfzHZaA32Jr9ZSbwnyv4SY0OTy3p1
 dzeusunXoVtXO5cfIdJ8LbJHcLZVKA2uA8G3H/axPQcy4ouKP4zLC+NyLrOGS65tE/UzXelUD4x
 AtYD+L51cKOrwLHzzRmV39uKNGw==
X-Google-Smtp-Source: AGHT+IHKaBiJ51yIk2UNePMBrwOaimbIbWp8Q1QvfPEbWy/9KkCcrZsi42gwgZZGj3jzZA56wcvP4Q==
X-Received: by 2002:a05:6a00:178a:b0:734:b8f:a425 with SMTP id
 d2e1a72fcca58-734ac45c624mr5607327b3a.23.1740761640017; 
 Fri, 28 Feb 2025 08:54:00 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736290957f1sm1213495b3a.67.2025.02.28.08.53.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 08:53:59 -0800 (PST)
Message-ID: <c8a10180-dccf-4779-a0d6-3b96da6f9b0b@linaro.org>
Date: Fri, 28 Feb 2025 08:53:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] tests/functional: remove all class level fields
To: qemu-devel@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-4-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102738.3064045-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/28/25 02:27, Daniel P. Berrangé wrote:
> A number of fields are set at the class level on QemuBaseTest, even
> though the exact same named field is then set at the object level
> later in most cases.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

