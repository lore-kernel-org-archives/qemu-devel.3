Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17750D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1j3-0000Tz-Gy; Sun, 28 Dec 2025 20:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1j1-0000TR-Ua
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:07:08 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1j0-00005I-GK
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:07:07 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78fc84772abso59262217b3.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970425; x=1767575225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X55mHw4g2Ka6gAWM3/Bf2jpjuH/4l03Q/8zDDWsrmco=;
 b=RAv3STmp+0OK+Yn2l/spWjQeuyxWkmsqk4CUxmnBTd72eVtTJtcb/KPlyvS7FvPSsy
 AllDTLs9t/dfhTryl2yGn4VB6HsBCCLA7/min2LXJSOnQLSA0+IM34vVgluSlG1S1QZi
 dLnD1uFG1g5m7apGTkSJ6qzYqKpn13aGDtKFiHPpyZCyc4cl5Gagk0RDIjWjrcUDFu4v
 Kbu1befLbbbKO3nsW/qpq/HovTC6pMg3Dp1k2ZTA5/ajj36lQlXWMFJX0btYNzj7YqSA
 CXRI9rIwUtt0cHA2lciGbWXyjiCcb4Vx+CPl3wEUoeBTHM1SFRxZ6JDK3snenKnOl3S6
 RSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970425; x=1767575225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X55mHw4g2Ka6gAWM3/Bf2jpjuH/4l03Q/8zDDWsrmco=;
 b=sEy/BbTA6fJlCVx+f5YQMIQQjTP6r1kKY53Bkk6z/RYaurDqoxkAH464GoNt5MjVQL
 EhCeM4/mQtlNegT6q82Gm7ePb56R/pPog9BlPDv7o1qMGUTnqnE0tarwpfWGpOc7NgpI
 5plsPNs5n6385YLl9aA9evpqIL5ktQRY3YPTP1EWqlUOc0BFruA3hKWo7nuCa8YjPk62
 AQo8TA+yzwgg1HQwF+ZskPR6m/sl29LRKGX1iO6c1hZ7ZSckHE4i0EdE07toIFWOFzrw
 kYx8Yvmw88fy5MJZ1f151Kx8stqsTQq2eCtOQ5EwQykdtd+7YucKDtvr2MMxNoDRvbxk
 /YKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhWQ3GwCEJw4biva7mLuQZ0inWyHuFSV3aIqBfI5H5h6OtNBKPd0RSRZpvbvDx7LTdnrktxcbhyU7F@nongnu.org
X-Gm-Message-State: AOJu0YwRigkycs55ei/dTAaVqYvW0m2qNAwBNpvfZE1YUtQZq/Sh3sM6
 CmVc3M7X1h0TDKD59/yKjLtUpeAFlCwW3tnEaGIZr8Mus3URvKMeCdj9Rj3DOUZYRps=
X-Gm-Gg: AY/fxX5lQxSbgPZeSVerLXMwWuPPy9MX9gmudqLpQrxXGcUJ3sDzib4jpD/GBPZ1Tnw
 m5ORNtaDVR9VbAjYMDCkQaajkhDOF6zoxizsaBGEK+d+8NhL9yEBPituNNeun98bLAh+Yh4Hu7X
 nwTTsqFjjSpXTsfFyVtDhyJcE83ruQ//YJMAkxUVhSZLMjyr0+bxP7GG38RC9bLlc6j4LQOPp9B
 ALcVCG7lOneqWIXV1fys/QzP6Frkvc4r+UYvgJZEdCaaQLe2ybrZMqbTTJXhnbmYW/dxqnGHiSK
 eGr76QhIrZwWNbfo4wx2u5RqA6TwBRUR+5QWpnGlJCLzXwJWpRZYiAoKF4Bt5c3laQddgLNIPWP
 fYW9eBV6IQckZNgBtNMvVISKo0VXPfMUkWVVNlwM2IJjfVLcxCk0I7dQEarw2f9UU5OxZ06Biiv
 AsuCvgpvoK25Ijp1aMNAcxbZodYg==
X-Google-Smtp-Source: AGHT+IEt5FWbt8GSbunjitutmOugM21l9GjKfJRcCgYM97iYHl4pJHb6R8UrzYn4JJ9vbvp4/pH2oQ==
X-Received: by 2002:a05:690c:4442:b0:78c:5803:f68e with SMTP id
 00721157ae682-78fb400de07mr241527717b3.33.1766970425150; 
 Sun, 28 Dec 2025 17:07:05 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb452c441sm109859747b3.46.2025.12.28.17.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:07:04 -0800 (PST)
Message-ID: <35501b01-f0cb-45a6-b6b5-f85074db96d1@linaro.org>
Date: Mon, 29 Dec 2025 12:06:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/25] system: Allow restricting the legacy cpu_ld/st()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

