Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32AAE92FF7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMA1-0002Ho-Hu; Mon, 29 Dec 2025 17:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaMA0-0002GH-8l
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:56:20 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9x-0001Ho-Rs
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:56:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so94209715e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048976; x=1767653776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PljzS5mHObQKNZoDCnGt8Ab6Z+bMs20yKVXLtQSSPbA=;
 b=OjwKH+DGakqe8DMXiB7Ob4uDzn36+sXaSb/f54qByUQQElO8IQmtEQDUAJTt/91O1D
 AQfANPZRyirYwRPwa8691TpfX6l/IfzhZrfaYJ9losUEEkGgGt0VQOICelTCjuTT2dl7
 Y8GnWejlqUUt5Rp9nubcKYDR5ud1Yqb6h1Uoo9fjZ1ODiRRmpTQ5U7O84wqKm+KFnWfn
 PRYEkY4Dx1sXyth0LqHUA5/LbIkngWoy/2NzpdfEWUYWczLqm4pxnKCzMSu5Teg3ULPo
 cg+pH3i/4j5vaYH1fJa0dSMZV4+uKzrqy4AU7P/O+soX9QFVmLco3R2G9iXAh0gqVnAo
 AJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048976; x=1767653776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PljzS5mHObQKNZoDCnGt8Ab6Z+bMs20yKVXLtQSSPbA=;
 b=glchijsOH2Bh+T69QqTS7MgncDiM/W5iJ/1Pqg7ia2cBUkDUu0jj5CI/SMrwV7I5rx
 uD685s1UYea5LOZS4o6vWHkqU55I9JjV/SLPz7mI3Qy3Z3Yuzpxl5gGQ+uUhNzEEdZ/0
 vH0nJ9XxYdbNZFGp1Z/3I3h7J+2QdQ/deJfur/srYoBz7xu5v5/8V+iXkc1SXWBUEDwc
 InxkOMpDO7CX1u9evJMvJW+KO9WUQIudydZeqdBF9Q7M3rZjOuT2E9UBLXQXsSbH1djd
 mL3eQ/7XVaI53DHD+jintD3b8x2FxDNf6GsjFVoRG5pEwoSweL1sG8GeuXsokRPNEhyf
 uriA==
X-Gm-Message-State: AOJu0Yz/95X5izzOSJJRDet0Q3mx6Uz8kHWL2tZNd0q5zthjUpdBG1Wt
 qx1nsccYe2R1hBhbeyyMSmNr2yo9Xc9djXTD+TE59MkkqAlJDqLmLYX61aQPda6cFSULOQgVefW
 SZmhykbI=
X-Gm-Gg: AY/fxX4sTK+BE2PP/pWHKwg3F5qLsu+GGL/5UirMwJ+/Od2RC3lqYU0c2VBuAvC24yF
 nv3bz4ikT8ADvngeiGe0VtfV5BtpacTwWzQQrjSBfru0HOFEyrPaQxokFp2ZUVmVu7gdX+ZtQzq
 xn9LHDpFTrWb6LAjeFO1bGZ3PYUm2x8k4ob9ypcj4ieQouufzvjYZLsxE1rexKu/mGKmNbalrTM
 TXl8L3mhQMlblI1CA0y+jzVgOZ/SFIN3GqoCIQdACJVeIZNcpq0IBZm076Xc/6sYzDVTG7mFxOI
 o55PejaJn8TwINb1vvHEJOOx620QLI/L0XGDEtC88sBXK5wI5CDdY8Hoq/o01uMJQlkkj/dnsPh
 YMjdPfM9acunEVSldfF1tW1/t1r5WjqdfFxYqr93eQ5TFOu0kfRCT0z2llAZoyojzFFytBcZ6Bc
 BPr66Xpsz0ZnoAnA9MpGVcirSN01aCFIHWkzYJFPge99uVO9vu1joN0Evm+hzxTp4O
X-Google-Smtp-Source: AGHT+IEWwq+TYnjTyIOHdUkmFXPDq5JpgFfvxRNyufR17jp+JmfZGfwF88HttXRjOgWWpZJIfNpaoA==
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-47d195c1a71mr401321205e9.34.1767048975792; 
 Mon, 29 Dec 2025 14:56:15 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa8fd9sm239053635e9.10.2025.12.29.14.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 14:56:15 -0800 (PST)
Message-ID: <3dabccb2-f216-483e-ba65-33f9b816cbd7@linaro.org>
Date: Mon, 29 Dec 2025 23:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] target/hppa: Use explicit big-endian LD/ST API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251229225517.45078-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 29/12/25 23:55, Philippe Mathieu-Daudé wrote:
> Missing review: #2 and #3
> 
> Since v1:
> - Rebased on commit 83202ca7227 (hppa-updates-qemu-v11-pull-request)
> 
> PA-RISC is big-endian. Use the explicit 'big'
> endianness instead of the 'native' one.
> Forbid further uses of legacy APIs.
> 
> tag: https://gitlab.com/philmd/qemu/-/tags/endian_hppa-v1

   https://gitlab.com/philmd/qemu/-/tags/endian_hppa-v2 ;)

> CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066
> 
> Philippe Mathieu-Daudé (5):
>    target/hppa: Use big-endian variant of cpu_ld/st_data*()
>    target/hppa: Remove unnecessary @cpu variable by using cpu_env()
>    target/hppa: Use explicit big-endian LD/ST API
>    target/hppa: Inline translator_ldl()
>    configs/targets: Forbid HPPA to use legacy native endianness APIs
> 
>   configs/targets/hppa-linux-user.mak |  1 +
>   configs/targets/hppa-softmmu.mak    |  1 +
>   target/hppa/gdbstub.c               |  8 ++----
>   target/hppa/int_helper.c            |  2 +-
>   target/hppa/op_helper.c             | 44 ++++++++++++++---------------
>   target/hppa/translate.c             |  3 +-
>   6 files changed, 30 insertions(+), 29 deletions(-)
> 


