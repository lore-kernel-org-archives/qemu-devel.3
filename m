Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E8ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSE4J-0006qP-K2; Wed, 27 May 2026 09:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSE4I-0006q6-20
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:13:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSE4G-0001OE-H7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:13:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45edc09f51bso449425f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779887583; x=1780492383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faOgX34INBbyR5/aRCdgs3MwvJozzj5awDp8cbYPdxU=;
 b=yXPdPoJOedVzmgP4lSM74KoWwC1TewC2ocwfF/Hz5OUnDD0GhzsWU6GB8BDOENHyot
 asaMBJuvzxb+uiu/R46jq0g1kKuElP9ddns62LoSmv9tHZJWz/agl8ubxG5X3SplJHdT
 tnnCptyDc19FxbFcpJNkYVAJHyErQCW90EYvOoGQD2JCxAr2AweQC1Z5nCZBGO15EAk+
 onTk5OFmlt4tsYMS/jXjX5+m08YBUsgMDPjW7V0hLdc3oNJ3TLTWzVVMkzHXc9qbUpmv
 O9RVPOEVZYM0C77ZxwCYLuEG5fAbGvHWWJ3bZU7jB15M3uC0ncoBnCClvuJ2BspGREMO
 /jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887583; x=1780492383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=faOgX34INBbyR5/aRCdgs3MwvJozzj5awDp8cbYPdxU=;
 b=UHxQ88xU3T/xYgaypEp2K0OgVSwohMNa4K6KwOoo/gZmQlJ/6BgiZ/HjBk+UDTcQHw
 A7Xus+N2adXoptlcJ7wQy5L3Sk15cMGbfOUAfGm5ZlFI3AhZ1pcmhSRT0RqBsg4PTCA2
 YZcozqrd9QeoJTLdyejYueiWeOYLaJs0B4/j6zd77S6DxxjvtXy7U66RQQnGZHquEq/1
 s2s7Md3yyp4HH9sKaUi0NJZJhQ/m3farfZH3u0qtk/om1VTnJvkjHGHGdog8ztcxCHd8
 BP+yl3KMHr8ApWcigqXrPwByR1oyToQ4YWm9InYTLyNANWJiey/3uz9OIJ0BxQb3d4ju
 oe+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hQa3NO0OBZd9jieKlTAKP7lJlhDWsfvRB51O9F9RYkNCUS3rUKIrAXtw139uVDgZ19nsghmGNSAhF@nongnu.org
X-Gm-Message-State: AOJu0YyyZjIc/qNaV/Es+GMvOgZ3zKCm4EV8cyfmHYLBQl2ZyxCggFxd
 D0MvjQskSLc6mv8+HEfOZRzrcSJgadecUWWlG/TSrkql/Ff5LkirkzdXeLgZG5iru1g=
X-Gm-Gg: Acq92OHbL333K94x8MmVaWkNEaW53J1myEw47mNLE6iEnf9BsSUrbkKBcxeV6KjlBEi
 l0FJvtFqPR2R+40zh1wXk5TwmbwOocIaJj464tVu5flXIMLkQ7qajoUaztkUWujeGujSkxY0UMp
 FLhhOv6kH0mCKaeSypGTtZsBQu94bGn6QoFqjpAuOd7+TY6cYmQhqpdY3ZBa2tlL9hwdWk0NjLi
 ZP3yXis6rLtpYqCDy1CZWJpqDFGcUHyw751XBgWC9UqeS/i/FiwHIWZOK85xTbF5xiFwxwqCgZ/
 HNdna/z96BDfu031YvNJqeW8w8vns9imQ/LcSNs4y5UkicbymmX/hHMl7y8Oiv1V9TDEhSSWRem
 sreNhaI8ZH1EBiM8wU4K/n4ojeBm0n0QkBiJTOl3/cpym43OQ68h00Xa9lCuW6YMRcuVWZRbY+I
 kmhd3tyTZAT5a01mkYpwLbNzLruJxWSk6DXmDD74m34QvqxhpeANc8fTm9EQhNDQjet4Vq0Ai/t
 tee
X-Received: by 2002:a05:6000:2007:b0:44a:247e:67b4 with SMTP id
 ffacd0b85a97d-45eb3689031mr38508623f8f.18.1779887582699; 
 Wed, 27 May 2026 06:13:02 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b19aasm6634589f8f.25.2026.05.27.06.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:13:01 -0700 (PDT)
Message-ID: <1d26770b-0fe5-431e-9ddd-66b5f02c9fee@linaro.org>
Date: Wed, 27 May 2026 15:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/7] target/riscv: Add endianness test for RISC-V BE
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
 <20260527083151.17876-8-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260527083151.17876-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 27/5/26 10:32, Djordje Todorovic wrote:
> Add functional test for RISC-V big-endian.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/riscv64/meson.build        |  1 +
>   tests/functional/riscv64/test_endianness.py | 57 +++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100644 tests/functional/riscv64/test_endianness.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


