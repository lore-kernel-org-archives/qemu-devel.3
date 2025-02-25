Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF60C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Ae-0005aW-Vy; Tue, 25 Feb 2025 15:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn1Ac-0005Zp-46
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:46 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn1Aa-00042f-0g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:45 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220c665ef4cso106723585ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740513882; x=1741118682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eafRUFXF5KaoeWxrpiU1cINE1gCRLGDzjj7kyk58lY4=;
 b=cjPU1jbPIcX/B3vixSpI+RXF2cg/bGSva8zGvwBShXoPMOx4Gn+OBeU5FJS1B2qfu/
 L3G+0eNNzWFkcscuyqwcP37hf3nqiqyaygeEfzRhVQ/oID3uAbhah9P/21IvHBB+MZZz
 ccMblrhAiqvXWo/9mg2/2piBx9gH9dYN9CWFTAu/PM+13vvvf7itRW55bAFvzsEWZXi2
 CzdRU4cpklwxz3+K26pkFUbHQNTZIDLo8WLYVgdzB4i0+mN2wI7mqq02wV3bV82g3tvs
 q/m81ECW3rqvorFIBvayuxwLTK4Y1mz9JmIps2UoFayEFnaCumNHBCcOjL9N6cRIc0yO
 AZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740513882; x=1741118682;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eafRUFXF5KaoeWxrpiU1cINE1gCRLGDzjj7kyk58lY4=;
 b=eYjGe/x8BAxkXB0ooe84p8l/UR8xr0ohWNJcscfzKPamSHCw0Tr6L9pAm12XfJx4An
 dVDyGl8DlkdXQ9Axiekbx19tPWmI+VYPk1p7lURNja+EDQ1q4L/Snltulcsxw1HZE1Jv
 HmQqcbC7yy656GTBUFehFwqPUs5vQQ6De0/t9z3J8rkj5PegSnIYkjCzIwZINEEoPzfa
 4OL4LBy35YNcyNNtTMr3sluIoTjstGe6PEZfZF2V0fafne4BA73zfOebFUeynOrmmqAF
 ydZ6oi2qJ/rCK7gE59S5WervUaQxS5lMEGkWt6rc5pMwBOPGt9HoE4MeaJfKTNXjWKM2
 mdLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRaU+M5DLuvnRa+ubjHgE4WaHrss47YdgKhcbSGU35g3S4bDam3v5HJsgXXylNWwbknykqsFNPV3nm@nongnu.org
X-Gm-Message-State: AOJu0YxZeEwWopGjJWTrIBVExz3/NBQm8D3riJdG4xg2ssRAkLHiaWNC
 WwVXEzNglEjwBdObj9ZQ6IryJ8wVrg3hoi8k+K5x5Al6IkBOzT5Ql5I1QCVJDhw=
X-Gm-Gg: ASbGncvMXePEaCoRh6AiUpVs729JnviBp3CN33Ti6TcsbqZoKGTwUM773SoLLgJv6hJ
 ADOm9my/D7N99jeuCqKdTKlWcP3yfduMU4yKC9ue1DN5kWPj+BEZtfqKI5/jsqyfquS8NVn4wO6
 /x3OmzCuceRPi0dfsO47CS9fdXcATawARDNtc/YTNrm6XP+StNqzxrzZ1Z2GHDg7wKR3lZdwBRB
 c/iqgrp4ppYpcrI3gzSQshRaG6LKYSOzQILZVp0TBRt0NLDvyP159EJspEXWy7RqCITmUwQdLlv
 LM471o4SjACW4s2jwiWsXqfoFwIOiJylw47uJ+aSN7PJ1ubfd8861dnHuE/naOKwE1x4Gb+Id00
 Nr77fGxc=
X-Google-Smtp-Source: AGHT+IG82hBc2mg3kpttkrnaLF9MyBuqZD4iMLfGRJwTrhdwwIupTS67P48At/jb4zydEhP9MF4o1Q==
X-Received: by 2002:a17:903:2ecb:b0:220:e9ac:e746 with SMTP id
 d9443c01a7336-221a003b2dcmr332903585ad.53.1740513882617; 
 Tue, 25 Feb 2025 12:04:42 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0b0efesm18174325ad.250.2025.02.25.12.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:04:42 -0800 (PST)
Message-ID: <07c147b4-67e0-4dd6-8ce1-9badf5706e42@linaro.org>
Date: Tue, 25 Feb 2025 12:04:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-5-alex.bennee@linaro.org>
 <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
Content-Language: en-US
In-Reply-To: <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/25/25 12:02, Richard Henderson wrote:
> Not checked here are any of the other reasons a flush might be ok:
> 
> (2) The system as a whole is stopped, on the way in from migration/vmload.
> (3) The cpu is offline, on the way in from poweroff/reset.
(4) Running in round-robin mode, so there is *never* a race between cpus.

Anything else I've forgotten?


r~

