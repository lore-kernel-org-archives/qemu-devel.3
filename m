Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B2C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBbK-00018p-BE; Wed, 26 Feb 2025 02:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBbI-00017y-4x
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:13:00 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBbG-0008LQ-4C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:12:59 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2f3so4591343f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740553975; x=1741158775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0RbDguo3dCo7/G2RUUEmVJ5uMry7l5DogAnuIZxaA8=;
 b=KEs/b2xNtIs9TcECxx8nFb7a2x5K+6EHqmdaLNXc+E+oMwxi4au6WiqSYGLdIHByqE
 uLNvMHFhPQpwOMMqr6Ecue8/fMlEu037VDPShXMoi05hpy/2BMdlVQ4w+TQtWeI3oYqo
 qhVz/wClbBiKzrpEOaVfZK+ar1daTpwXuG1DrN4Ilrc7ACH+vCsqe/qOJFZcTnUu1xZW
 INXOlzyrV+QuCpO241TKf5HAIA+1tzm7pfsf00+M9YzQBVu/nwwJGGB7REaiEBsZfwjD
 S23IZY64uaSGmJgtm+Q2oTACneAZP9F72elak1ofZVUCzk5m6fQMPkCM+J8sFev1ArPL
 optQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740553975; x=1741158775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0RbDguo3dCo7/G2RUUEmVJ5uMry7l5DogAnuIZxaA8=;
 b=ODa5dewHnNXyhEblVkX77ySO8po2G+OS4tZDLVvInuZlntmce17aJ6kbqCxuMyhXDa
 ohHGnJbvyH1Hzky7dyl1BUXP8JjCX7ZlqdtlFOJuLC4yuPxJqR/YycR+Ln/cLccqLyIW
 qOVEQWMWihth+UlLbSuro5f4NrRJBFwcLfB+m3ZjxQN/0jas93dKbSi8nNn4R6NzVnjT
 E/fkvSm39hBW/NJjMRkCnSX7kti0G/93+f9prnyG3g1AB93+Qe8z1HGsoEgzZg0H6GpN
 EhCUtjAYYDMTyQvOa3Mf9U5MChxauIuIwNyzJlY5KYaZxlsWG0JAJaAYKMYffXBb6Tdw
 tmqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrGnqY7fYIjtzqDW5bg4tuBHgsAtjf+t1Se/6ezaVhwokkI3wTiI9ZBYQp2ZflGtYjSfzZBhf7naqZ@nongnu.org
X-Gm-Message-State: AOJu0YwHdmmw9KozvLHU5Wh2790bKSW08CqMlLnrnojyo6NtXB1tmHLS
 jpEEFde5q0iK6vdhQqXAvI/3aGsZpziOmabd4VrNTRfuK44X+vJISIf9OqxY5XI=
X-Gm-Gg: ASbGncvSIM+64fUabID15GyrlynUt//RvM8dLUck+clbSiNhdHBHyCUd4Ir7u98BGHs
 9Y67hrzGpXx/WdJywFsTSuq9w4s72NSYwUDhtWAbmhhHuG3BCsgmGnfU/TD55Vq21VXKD05AkAv
 hzx7J/u/E7wA/HUiKGC/Nls/6Y0EJmAF/Gd+LoFhSc71bGQO0AS76GGhS8sPVTncyPn32JcjgpC
 PiJEIsY3OtajaC7VAhqquv+4/5uY7wM1P4hYMyeN0E1NtfH2Sed4J4WIlYRZp0RDxRBVd0Zjbsl
 aAu6fERWJ2UN2mukr4rC7YaEKd3fY59btyRJQTwfWCrTvN0H4iGIwPgR2l9cFPF08wWtdVIKscU
 =
X-Google-Smtp-Source: AGHT+IFjcYke/r7Rxz88j5ekehN5CCFXpEU3q4xWV7ZafQNPSw5zy8elM36GTgWmwRMNS87CJM+mBg==
X-Received: by 2002:a05:6000:18a2:b0:38f:50bd:ad11 with SMTP id
 ffacd0b85a97d-38f707840afmr15594081f8f.5.1740553975138; 
 Tue, 25 Feb 2025 23:12:55 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532d7asm10976175e9.13.2025.02.25.23.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:12:53 -0800 (PST)
Message-ID: <26ca503f-9f35-4043-bf50-3bf7df2e1dd1@linaro.org>
Date: Wed, 26 Feb 2025 08:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] m68k: reset vcpu after it's created
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-4-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207162048.1890669-4-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/2/25 17:20, Igor Mammedov wrote:
> Reseting vcpu before its thread is created, caused various issues in the past
> for other targets. It doesn't cause issues for m68k at the moment but
> to be consistent with the rest of targets, move reset during realize time
> after qemu_init_vcpu().
> 
> That basically prevents reset being run when when vCPU is in incositent state

(typo)

> (i.e. accelerator hasn't initialized vCPU yet).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>   target/m68k/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


