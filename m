Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D8FC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 00:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWPRq-0000Oq-04; Tue, 23 Jul 2024 20:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWPRo-0000OK-L6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 20:01:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWPRn-0007UW-3b
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 20:01:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so2041388b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721779293; x=1722384093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTW+uTVPjm4QYea9NwOTIdAOaZQ3MNJMNraedK0Cl2I=;
 b=ZdkUUJNBkMKXfJNbTFmTnbDLOv/Z5Xmr5K+t0fgfVJH1K8x50z9M7Y7qwzHwYVVAct
 M07YjUOXC4KRZm7MyVjUwA97rcsOYR/0U1C0JRajjeVb339AbWqHvgq1WPpWV9LeqoGg
 7meTlA+Sv8BRpTJr2xvJakTesJfGUlgrq3dy94hujzXFN6Xqy6hu8jd1tysGiIn5rzRd
 x7jASL6sUGou/N8Tl07/sVACW2NQr9fgYOn4v91owTMqydE2VcllhSJ/UPnYO0zHXQ5K
 +v+nUyeWMFTetPWnMtciaWe5iHBk6z+ljfs22dioyyt1o7vBykK8r5MclsK5ufJBEH2v
 RNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721779293; x=1722384093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTW+uTVPjm4QYea9NwOTIdAOaZQ3MNJMNraedK0Cl2I=;
 b=MJmtZEy2EH1K+ppwQUBQxrM5Jm/n1F5ma1q6LgxRUQttPVAgxjEP7Wv6Atu+AB27JF
 vM/Hm5pduUTriBRl6owuJyBMXz40VVCPGHS/Av1F0JqjtPD8YdjPyIJhTQezMc6fNJwP
 lCQNOaeS7iXXrqWMaKsrpya2YI7IynjfBSW4thMb8iAc6iL7ZzhAP1t/jh/Gp/Z3zPKM
 WgqhM85uavIgslTITcbCF0XBDFS/v6XnD9eedIG1c0QvSHQ5/p1tY2bNtQ9NjDAR4zfO
 PsACcFSPDXSq6BKugmMWxPaFuPogc8RA7HO/1O5LjhclKZFlkTqxMA88o12vVP9lAdDU
 7QvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSTCzcgiuoM0T0KAcP0UIByyGVFWIBMSgzvpI8WjV7FAxdBbIWqGmP35ZLeqlUmNWkb/IUBsGEo2GNk3m5cw/LepCG7NM=
X-Gm-Message-State: AOJu0Yy3IVC6NDp/xKJqiPTXGobWYViJLX4I8TGYjE//I6JO/cE7EblW
 XIvyAvkj0UnBH4Rn0cUfGJBitLmRZPkEP2NmKAaYzspazK+aPUkvzV/T8Tg2DB8=
X-Google-Smtp-Source: AGHT+IHYHAw8fiIEpAt4T3MEiJb2HIkUoF3lcEntszDTetFeOC1ypfvbTjLYSXF6qSDhouaRhifo8A==
X-Received: by 2002:a05:6a21:394b:b0:1bd:1d15:f089 with SMTP id
 adf61e73a8af0-1c4229a9c48mr16747524637.54.1721779292975; 
 Tue, 23 Jul 2024 17:01:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0bbfd3bfsm6885495a12.54.2024.07.23.17.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 17:01:32 -0700 (PDT)
Message-ID: <1e045ed4-b9ba-4562-a26e-25328c3a7364@linaro.org>
Date: Wed, 24 Jul 2024 10:01:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Remove dead assignment to ss in
 do_interrupt64()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20240723162525.1585743-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723162525.1585743-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/24/24 02:25, Peter Maydell wrote:
> Coverity points out that in do_interrupt64() in the "to inner
> privilege" codepath we set "ss = 0", but because we also set
> "new_stack = 1" there, later in the function we will always override
> that value of ss with "ss = 0 | dpl".
> 
> Remove the unnecessary initialization of ss, which allows us to
> reduce the scope of the variable to only where it is used.  Borrow a
> comment from helper_lcall_protected() that explains what "0 | dpl"
> means here.
> 
> Resolves: Coverity CID 1527395
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/tcg/seg_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

