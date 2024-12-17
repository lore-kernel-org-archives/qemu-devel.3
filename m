Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B50E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYTI-0005gb-7v; Tue, 17 Dec 2024 09:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYTF-0005gP-BP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:22:46 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYT9-0003tS-UJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:22:44 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f362c3950dso805700eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734445357; x=1735050157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uBKuHqA/qyrDiNo07oh9qkrQvc4ChoPXQi+6bQZNC0Y=;
 b=hRlN/HOtL+gzfzj0YkmVRbWoQqp0Tq10hzzuLEw7aJe54FJjDWyXFJ5bZKK6m8AT1z
 zoudtv/UEgp7bRbzc50xtqVpGKtpacdcD3M2dsuhcPlPZd5wQ4AbraOoLvZ+JYNoOq4j
 zHQpbO7YH7MMC75vtsWr5yv4SpK8q+F3biWgRsLkdtYOnj/K6anAvV3SJ0KKoHJ5byVx
 fIaUQc4PegeoWpblvUyqx7xFDFZh5Y2hQctymg/Bju6Jtb0d7o2UTGRWBSrF3MmO6hwD
 vjfhiOgWL90Ufu8iTZRqaJVN7vMM9MbROrYt4jyo8Jr2PDBW+Dab4C+ML+FZ5LRDJV6K
 3F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445357; x=1735050157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBKuHqA/qyrDiNo07oh9qkrQvc4ChoPXQi+6bQZNC0Y=;
 b=eV3lp895wn0mHYtdsXszf0t8EDUlMJDPJ9a9idWybGtaf76pvWdZBLCGGJPZa6qWGg
 euKs/lkQblB3n1FF3Q/R9pQz2QVVljWiDZ5kEdkKOoCkhXFKzQkjabpgNMZfTtxpyTnJ
 NJkvMjhNJc7fk/pMf7cnN8zMC9OxB6qhZOOfCyzN/zATYmcrM1rISDKtknjey37PR56p
 KNBOhdFYPD0m3RrVVdIHcXm9Xga5M/R55RX9/RKbNZk99BxeDc0wUlGpX/ic9pipO4HR
 PrL/pxhpOMAsQJtrH4czG4n3wxx/Gxs8PdnB9PaN0kN2/urUbIjcgG2RW4c6kZhWg3iN
 r6cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBxGZ6b1LHb127xxLRLKuB4ZhwxAgMl/zNc5sOAoEhF6Y8xUmFgOy52DA4pWQms29iXjNsqmGhg8t/@nongnu.org
X-Gm-Message-State: AOJu0YxCoLfVEeslAEEZPyR61B0M70b/jcIr3C3r7bQQQ7MWTBX4TuM9
 OlYb7f7DQEt+Pie9n5rzpWi5rnYOFCih/hdrPk2+K9g1vq1ykTNZjFUfkv6EMZuAUn+wW42JC7G
 obNCAOgrU
X-Gm-Gg: ASbGncvpZQ5BXTT6/hWjPJEaXK78aeFQodjrmi1q1y4mMjlGktZnhnnRF8E7H4y3Rop
 EFf7YGltAgPW9sv/PbH9omw0gj4CUsf1GjZzOlcYrQFqAtTvKVOgjLZ+j18vQf0+TxzTwR55o8S
 izBAsGAbXdd9IPmxhEMzwE8X7Epf+WcLwU7kZUI+6pgGj9JWznrMPGhxaOy8P7i2f2KvFz8cqxJ
 F5lD8oRZQT2aferZNFKqV3G5QWDxR5r8d54MAmtf4+kQSp1fPWMXB+Mw7w/q+hbMM808hA7CQEP
 8ArSmtBfrIU6zA07QqqUelGH3nHwPQgCWe4=
X-Google-Smtp-Source: AGHT+IHVcOFW67oHBK3Csg0Uh/Ha9434FQSDPLpctWe0mqFkwrq9Lm41Rw7TuJ0WC2vvJXc61ZohKQ==
X-Received: by 2002:a05:6820:2006:b0:5f2:c518:bace with SMTP id
 006d021491bc7-5f329646be9mr10254716eaf.3.1734445356752; 
 Tue, 17 Dec 2024 06:22:36 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a6e1baasm2089243eaf.10.2024.12.17.06.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 06:22:36 -0800 (PST)
Message-ID: <eeeca090-5d4e-4366-a565-3f705ed3bf31@linaro.org>
Date: Tue, 17 Dec 2024 08:22:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Restrict curr_cflags() declaration to
 'internal-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241216214030.59393-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241216214030.59393-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 12/16/24 15:40, Philippe Mathieu-Daudé wrote:
> curr_cflags() is only used within accel/tcg/,
> move its declaration to accel/tcg/internal-common.h.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 3 +++
>   include/exec/cpu-common.h   | 3 ---
>   accel/tcg/watchpoint.c      | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)


Thanks, queued.


r~

