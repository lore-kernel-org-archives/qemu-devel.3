Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84453E83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn721-0001ih-KX; Mon, 02 Feb 2026 22:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn71z-0001iP-9I
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:24:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn71x-0002KM-4f
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:24:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso34712625ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089084; x=1770693884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RINyX8ZCtnuiMQ9LOdWB/qhp7JvgZGe1eMv1s7y/yps=;
 b=H82dsdet+bWLB7rdUnBQD0NpgVPVVp0/QpAV4hK/GL9NfnQDk7cdvp/odTzSK0Wtf0
 iYgfFFsaBB7pb8ConQt6dkuLkwzxcXWrmF0Hml4kMGCVcKByoBZka1319fb5gEIzkWbr
 GSpwamkg986s27jVkdo4dZ0H9txzwIiivdnZpuwq1jjMc0ubdslcS5tMe7eOg3LE7Kmy
 kyf5pw5mIuusky+0iECeyfsjUJdN14VrwH1pcN+8RBhM1m8Q4Cp7YQldtNqiu3Q3qa+l
 +GF3DDeC+bvqn9BLNdRxd67fcYqy9NbWDug4+ORAurifoO2RVfH0wXQvqi+FUzWawFgv
 UGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089084; x=1770693884;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RINyX8ZCtnuiMQ9LOdWB/qhp7JvgZGe1eMv1s7y/yps=;
 b=K5jBNe7yPcYZMXQ12ROXPbWm15rfLl+N6inKuYB97Fs2ih+OJ1YlhrM0WSwNf6eAVr
 D2JhuWYh8qswaKNeNKCyS9ofWJq3U9rvGl5iNZame225ymLRULw6VkhPWOAy9qt9i2+b
 V+67pAAyUklAO5E1hIoFz96yQc16GlC3ZjA/oIkp3evSWbymq8FinXgF1EO+JZm644Qt
 2x6/8aL2l6JjwYCqB4dcezJWErkzGe5NjeC1Oq848uCXHCTSIZBBeYWm1OE8wEht3kXQ
 hceCzUyA6FfVSd8JgNR2uUq3yLq5+Papdwv6/qxxvporVfpN43QlUsBUObJ25sv8uaVb
 URJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDVOcZewY+iBDkP/wg8k2ll+GFaZbY4OVFgxLZmOaxkh75C9wN3KmBVEDn8Q7KtuTisF8TqQnxC7u5@nongnu.org
X-Gm-Message-State: AOJu0YwooVfdoBi2MOyvudhXnPWMo+nUz/3aDbn6l8mZZS5vS/gz32Yp
 oJCk/I38/wBvGd+uNCDnLLr4jZvfBsB+4U2Q5G3y5G7EZilBXsjFsnA+tEl/gCwWfljYZJhHlXO
 jh3iu8nfpNQ==
X-Gm-Gg: AZuq6aJJayCmsT4Xf9afHR2PuS7HoVX1JyE3R+QGcFuTSyadF7mtx95qs4NVQhOkhGx
 OJo4RNjcOIXLHTTbcynWgKiGAa/kL7l50pNjkvtVRW7CsA2P25QNDdb4PYFWoGDPGvekvC3rEaG
 4T8ODDJqG2PUKakvZ4g/9scpMTLY9cqQuGgFteXmwTP4NgmJMxJSV6QGad2+OZW2xeyWDZpMhqd
 Hof4IlukLhJEm2g2ZVPxdjLk7Ck8hak+XLWH4+5+bbEXgXslW4udAl2ya6jJaZvbzDOIXFJCf7/
 jIyMYXkyF2Kv1bnq0gWx6GHMmTe+E5HRThAp/2Sawr9orQBoaHLVM5viDxcTWhUBEDPNJ1Q8KjS
 Ax/xV6sKXqXO82z+L6nYV9CgBeqOU3hlRESQcxZ0d19FSMI9KUinJthEF6BEVZYlAYS8cEjuR6n
 3wJbDd3+HAidPtnx6J5nxMvW594plyH00p6GTVch9QiM1NZ+OJEIF7pUS0uR2p//hzWvLIbQrts
 U2KbRPZwpBFG0yj+3f1fjdMApOojxdvILuPbRCWl/slyZy8FBN7
X-Received: by 2002:a17:903:a8f:b0:2a5:8c1c:744f with SMTP id
 d9443c01a7336-2a8d99285cemr145142405ad.40.1770089083655; 
 Mon, 02 Feb 2026 19:24:43 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b5d88f0sm168363955ad.67.2026.02.02.19.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:24:43 -0800 (PST)
Message-ID: <7ab6be04-44c8-4467-a206-534fd3cd968b@linaro.org>
Date: Tue, 3 Feb 2026 13:24:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Inline translator_ld[uw,l,q]() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260202213348.96754-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202213348.96754-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/3/26 07:33, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the x86 targets, expanding MO_TE -> MO_LE since
> the architecture uses little endian order.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, MO_LE)
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, MO_LE)
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, MO_LE)
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/tcg/decode-new.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

