Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A80E8B383
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnQGK-0004nY-Hp; Tue, 03 Feb 2026 18:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnQGH-0004mS-NT
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:56:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnQGG-0007BH-5U
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:56:49 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso3211286b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770163006; x=1770767806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lNx0LWCuOquhHOhYbWLoXGsOLtJCmaRjrx4n4I8iFhU=;
 b=WK2C9+/tD3zYTuPcpOY6yqJcwORhLav8+xsQczQc19mXT5TrTaj52ovuGuPUrdnELX
 5Fm8LDsfgcJr9KSp5H5Ech5dcXoBkq2IuiXctYBWf1hfdeBs2IA+VglK19gI1ztwBLlg
 iBbyvq9oFjicXB9pjmQk8SSaUQhkdmwNWBez8Dfl1ac6Ad5Xe2UMdWWeWwHVaPvRxCBw
 a9XnNIVffjBGvmSPY7D1sBCus+zGeuDXDAB3PWhg3IVM9qhBy2XMptu/dEs5Tl0g+Gbw
 tfZdTl4rbSAGvOG68yW7igYQc/hxmMsCnR9BDpUktq/hhkI5IJc1sZlB9waIhQNGwR70
 DEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770163006; x=1770767806;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNx0LWCuOquhHOhYbWLoXGsOLtJCmaRjrx4n4I8iFhU=;
 b=JlbrrSm4sFGWaGTiB9tW/Yv2tEd8w+o8VnMexOW0hcHJMpasHU3+P7LaCJcklfPqLP
 lV1l4mqSiQp9+BGia+iykDIG7ZrVrZFkST+2Av+o/k89VPBb4DSOng28My/zehe5nD3v
 tjvKgJaRuTrN2fiwOQ3+pJifa09En9nO4D6/QAkAteF97WbW7RnBxcNWK0p8k5CQUaXO
 AaP/EkHYnM5am5USgJ7GnbIDzi8/ez70Wan/niJB0pgbIrDeUH+q6JbL5i0GyiJMUl6h
 VCDrG/j/230Gk4KTmUK8mT+oLuxmmcFCVCcoIT4WkFFITyDOyo7keLv7i85hWwhSWkMC
 znvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ha/wgtn1X0KVf2mXkkDZ1yD85bBvLEp2vMT9QpF7nYt/3s40XDWYyhkGIpZT251TIplJoMryil20@nongnu.org
X-Gm-Message-State: AOJu0YxqP1oABEF6AQqjIn0PaDXey+AUNzPkwyGW6Ewu9f3jVFTPQP6e
 5A3lFtr4FtzNgdNBhE0tQyiaiYdBe2fgi5mWVrj4d5yECH7QhNa5gdnj08lCmA9C/Rs=
X-Gm-Gg: AZuq6aIeVq2XYXr19o5i74I2yHCTsCsukZI9wGMlbT82qnNYKRdANp9p4jRWYxciKzp
 ZLLZ/a8XG/N+VVdYuUwv+QRWIwFUy4lRJIZp00DMq1Wwz8Tgh9hB8eT/Z9fOXrZcfCE+Qz4pQ6B
 2JIt8wFP5Zx2SwqJ+NQUgli/guy1sSh7pD+28c8UNWidHe8ZvptuYGD3kdktjYGs/VRKj5wRJE2
 MW56HWpAuy9METVUKfEmoHWTSOO8LliCIckqs+tcVZxD8j/NIywPM+wgC1UfwfQQU7ND/69jyyJ
 DA7OvcV4m/nrTN3Vo8U+dFmd3p+J1MCOkX6DwVIfglKQym9hOR++d7y9R2mrEiyzNDFYWFfRQo4
 IDYeTBO+5zRu3c7bErqevuzn9JhaOhBlHo7R1rVQ/Y+AztahcKea0w+Dy88zV6Dnkh1Bde/EBqZ
 1zBVFSEYsTaigPWXyulEfcjrleoxky4NAi/Cmdn7KAjGQE9PKspL216aemyF6pI8k3xbGz5UvYu
 95K1hd1zMl6yrU+nR15A5yFspolErWThZpH
X-Received: by 2002:a05:6a00:1415:b0:81f:5037:a310 with SMTP id
 d2e1a72fcca58-8241c1dc060mr999279b3a.17.1770163006100; 
 Tue, 03 Feb 2026 15:56:46 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d163845sm465715b3a.12.2026.02.03.15.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 15:56:45 -0800 (PST)
Message-ID: <cc4b9034-c5d0-4478-82c2-1d262fd4dba8@linaro.org>
Date: Wed, 4 Feb 2026 09:07:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Single binary patches for 2026-02-03
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260203150436.71907-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

On 2/4/26 01:04, Philippe Mathieu-Daudé wrote:
> The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
> 
>    Merge tag 'hw-misc-20260202' ofhttps://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/single-binary-20260203
> 
> for you to fetch changes up to a63b90ca6ce8d00dee5150b84bbc65428519ef2b:
> 
>    disas: Have disas_set_info() take a const CPUState (2026-02-03 14:57:34 +0100)
> 
> ----------------------------------------------------------------
> Various patches related to single binary effort:
> 
> - Endianness cleanups on various targets (PPC in particular)
> - Few cleanups around target_ulong type on Alpha
> - HaveCPUClass::disas_set_info() take a const CPUState

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

