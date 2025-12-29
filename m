Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8CBE784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1sZ-0004iZ-QZ; Sun, 28 Dec 2025 20:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1sV-0004iH-Oh
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:16:55 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1sS-00013I-HF
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:16:54 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6446c924f9eso7692793d50.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766971011; x=1767575811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7sWmpLytq81vjdmTZDhI6/te3RLAgTP3BaTBjOqUkLc=;
 b=uOesusgsWxdxFzqScj3jzTLQnekz08EPv7cMSR+pMlz9SHyysiTMXn9KQQda2VPXPK
 jKJRzHpq1Uj0szuu7v3qa1TbNOzP+FqO64YGE1XwcRYQxuzdQMvfzPTbiCJAekZvrRuX
 WNMMaggS6f5mUJvKbkf/dbrMBXivoTCqkml8I0Xuigg+I5pImT38kZqxe2ZMzI/jyUGU
 Mx5AtPqr+fw+I15TKD8FgBYf0JTxU+pc7XstVS/+pkKe3b3UFbVX2ozTDbwXhjPgJwuE
 8OtkvUWWXxgV5qGc+GmEgJFjiyfmuMnVEzD6P/myH4XE6FK5NeV4ovwW/StWP5cm2FF2
 x24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766971011; x=1767575811;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7sWmpLytq81vjdmTZDhI6/te3RLAgTP3BaTBjOqUkLc=;
 b=okrxqVE2IvOWYAmXX4fU8AfTP1bl5NT+55TyHB5itCSgFwQmF4csEX0xvjBRwUxS98
 foTrQ0Y9p6Gro+tFDM/EQozzpCuuc9i2CNDDHq/2LpmQ0wWZ8lrIFqEa55bYeEfsEpAl
 luwte3UbgRIRngZN1LT1vGandxk3x7/0T3x+jdkJJzhYPmCdLtyzN+RdlVgYDhjPATHo
 UNLGhWXlYyXqDlyWa3GGrcesFa7YRFDUSvxn0/64dhhtTLyvR++D8/+wuCaKBMJQ9mpC
 Wg5UF8kGJWWz4SrfY/+PcVlYefDJ08YXQCw0nCDE5Pc5Ds5GHGt2mh9Ck/yhioJ5lUpE
 ZBaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj0ABcVGl2DS6ek/7ENz4OElx0z0Kkmh8YxPs5fvxd789We4ux2RHioYIZs/b6CoyLicoYRm2GcXOD@nongnu.org
X-Gm-Message-State: AOJu0YwwcPUwBOQwBXAiWNec5YIwOXdozbQFcMYAL42uS5DZs+7xbB85
 t3NZzI9e3f4mSjMYsBY44KPt0lfYE23DCJuHaXs0pwTQddf4YPFRI9nkOsVla4wxc7bxeCixkj6
 xsYhVyvo=
X-Gm-Gg: AY/fxX5SeKS3EO4o7AiM30OgMn1zN29tmMK716MhFyMqANmPidOp7eaKlkgaXhvc4Hv
 UEBOUYZgWdXzumbVF1nb3ReCI60ytLKUFBnhQeb3e2Vu9UXUrV6WS5VOEplvbQNGZEQisicPqU0
 JBjHYLGneHYZPrmW/Ums327b1BRDsgV2HrQJWV8Qh5QLcC/1c1LQqUQTnuMuZlOg1b3cOx1dzhS
 f+yvl+TnJ+XDy/sRSoB/C4cPwE+enqu3eX9inQID1kWogXZ0l2DPHRHenjEkrDRaDdlm40AfLWQ
 HPX+ynDH1XpOC3J28Fbba19f3TtvQvfjS2r+Xc93J4yXnlhb/QHNUAdKAwVX3VtlgbVsuSsHlsY
 q0GQP2GJVlEOv07+9kkhbEpfn1/yjPPMl7uMgRLfqRlWhRhksBc6c1FZn6+X/+sWNEzPgx3d9Dg
 CGcLBze4d4DPIfpLA8rIAAffvhfNry+rOwFPV93UfEBAOOC0r5UTanUIfjaktMsFT6UOxmSg==
X-Google-Smtp-Source: AGHT+IFbETjgK9bGHnCFMDGkqI8KO3xTagVobX9vPD3ggf1PHzLfYNbPWQv/QiPl+T12juOxgYNRZA==
X-Received: by 2002:a05:690e:4012:b0:63f:a95d:66f0 with SMTP id
 956f58d0204a3-6466a8f2f34mr28120458d50.44.1766971011255; 
 Sun, 28 Dec 2025 17:16:51 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb43a9cc9sm108965647b3.17.2025.12.28.17.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:16:50 -0800 (PST)
Message-ID: <bdfaa88a-139b-4b99-8560-0bc2bf3b23cc@linaro.org>
Date: Mon, 29 Dec 2025 12:16:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/25] system/ioport: Declare x86-specific I/O port in
 little-endian order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-25-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12d.google.com
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
> X86 in/out port (related to ISA bus) uses little endianness:
> - enforce little endianness in x86 cpu_in/out() accessors,
> - serialize QTest in/out port accesses as little-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/ioport.c               | 10 +++++-----
>   tests/qtest/endianness-test.c | 10 ++++++----
>   tests/qtest/libqtest.c        | 13 +++++++++----
>   3 files changed, 20 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

