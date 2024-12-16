Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE714E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGUF-000259-8U; Mon, 16 Dec 2024 14:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNGUD-00024A-3z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:10:33 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNGUA-0002Sw-Q4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:10:32 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e1d7130a5so2209617a34.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734376229; x=1734981029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrMzXbGQ/6saqJjq9+YQdrMgVIjm8J/9nparMXKjcCU=;
 b=voZf0SF4jR3Ik9PfnVlgWZ71kLZH5pD6H1dhPdF8zI9QejUcH5YC/Qn+3HJY9Ks39M
 1EpNQu9KPE4vvnQ9INnUwLZ97T34++lakIezgsvlzeXOYI9Jrpuo3g2R1xvti+6Z7eFz
 HYqN5I/H8TYZoEmDI/9bV7lLkQSnAq+CmvHsskUjVDBSgZo3XA0FA3y0cn6yM7Sfui4N
 qQt9F5F1A1j5Fkp7N2zrsFkWxYdnxp7UK2uGfsywzM5FhtaTra0xbvW0Szcr+RrW1nV9
 UUEAc9QKafJjPbXasDi+XCzNTPXCJGoIqqXPY8WVTrXZ4ZC2nD+e81v455g6MEFRIdxt
 neJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734376229; x=1734981029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrMzXbGQ/6saqJjq9+YQdrMgVIjm8J/9nparMXKjcCU=;
 b=fuMi1Ca1jq5MwudBSV1CQCIU/LVPRBBGVWcBVII/aixTgTENJFd0jDRFqlEuW2XcW/
 4aN1YotrN/eOgdGJdrZZilsi4zoXlyYKy/zJXK397tq22kJ7T5lsnhXH5RtrfXZdIKeh
 IuQp6EJEU4fs19zk9iI4LDriqFQWau+UJOwCMm+IIolJSYdK9FLc0zgk60rUxeGP4tt7
 Wykj6/BT9WFnetov6HtX41nsZPGi3U2RS9xG91XgvzQ2spi41VoLaOCeKm5hjOeGZCOu
 9Nlw1VfFRWSwnoWjSjW1dlhAu1lFuvHinvPtseNOhx8ZHECBk5nojDqdlC2H43Umj1j/
 ZiCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH0DOG4jBztI11c+UbIP2mBQBuYInzdBpWCO7KEL6904UdWgYNoXKpuwnehZJrYAAn1xOTuP0qkZPk@nongnu.org
X-Gm-Message-State: AOJu0Yzf1J4S68k6EuKGiNwOq/xD+8pRSSKQETr5ieG/glCGhWg5vnLJ
 EFDYB6xQOYG+5Xqde0/QyCsZu6rnGcqYmMYwD9bcMWxdaIjjjYfV598ASDbW8cM=
X-Gm-Gg: ASbGnctpbZn4uWqikzvigAn9qH5GPyac5DQ9fTuUDm/UeBSAGpICgFgq0MRFQoxJTZ5
 6XEFuul4TAClHZQ4AIn+DjM6t4B8mDeQOYUoUL1E5bpXNaRZnuN1ZhBtxE8wI5rdU9+hXAE8N32
 He0R7GKJ6ntZGkzaWswujXlmPwufw9lYx5V/i8hXddQdkmncBkAgTffL3jSvw8VIRbD+QL//LJS
 qqZudom6fvk4WaSIW0MKT0kVro179WdcLfMQ6F1RaBylQMwLABep1GCEUodfkKjmKl92+ijiAVg
 cIQeMckDvHYZ12qPybJDTNakpMkVzfykn9A=
X-Google-Smtp-Source: AGHT+IGNNy3SvbQnCH/70Byv4fsxCVwaA8q+xVu9Qw7jp+XKmDKbZVcDMj4AV3JrmsSjmHNJhgOfzQ==
X-Received: by 2002:a05:6830:2641:b0:710:f375:a6c9 with SMTP id
 46e09a7af769-71efdb92b78mr601421a34.7.1734376229525; 
 Mon, 16 Dec 2024 11:10:29 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e48308005sm1545654a34.13.2024.12.16.11.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 11:10:29 -0800 (PST)
Message-ID: <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
Date: Mon, 16 Dec 2024 13:10:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 12/4/24 15:12, Pierrick Bouvier wrote:
> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
> spent up to 50% of the emulation time running it (when using TCG).
> 
> Switching to pauth-impdef=on is often given as a solution to speed up execution.
> Thus we talked about making it the new default.
> 
> The first patch introduce a new property (pauth-qarma5) to allow to select
> current default algorithm.
> The second one change the default.
> 
> Pierrick Bouvier (2):
>    target/arm: add new property to select pauth-qarma5
>    target/arm: change default pauth algorithm to impdef
> 
>   docs/system/arm/cpu-features.rst |  7 +++++--
>   docs/system/introduction.rst     |  2 +-
>   target/arm/cpu.h                 |  1 +
>   target/arm/arm-qmp-cmds.c        |  2 +-
>   target/arm/cpu64.c               | 30 +++++++++++++++++++-----------
>   tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>   6 files changed, 38 insertions(+), 19 deletions(-)
> 

I understand the motivation, but as-is this will break migration.

I think this will need to be versioned somehow, but the only thing that really gets 
versioned are the boards, and I'm not sure how to link that to the instantiated cpu.


r~

