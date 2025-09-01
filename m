Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C3CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2lN-00085y-5d; Mon, 01 Sep 2025 07:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2lL-00085b-0R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:31:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2lH-0007TQ-JF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:31:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b8e28b3c5so4318935e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726303; x=1757331103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5nltoXv1Ty4Vrha1PBcGyW0fmFuugPfbNd3aYhKRn/A=;
 b=JNN93hRgr/kc64jrqBgXwrmA0TVUd+1jhYFbzJ8dC0ar63lBeKEQ3tZrOrFUou2mwY
 pZSqz1RQdTPfTkL5qMsSZRJ1OB963528U3HP4x9G0mYvDqZB0+JUAraMLKgZcrpYl27F
 WX5/lDJN6kxZvFtg7286Q+oVDzcncCRKAebY1hHI4JQ+IKzmUIrkU9KexevPx89KijED
 IR+n/BDdKDa/dYLj2QnsC8M1gDGJksA2AKeAFqm2LsWYfT4/yTLFoFBliHccgEYLKNGJ
 abCx82Dlo0pgVSlVbeqk0Kgjr36mWot37wD1VmM+jimaSMqSvGVI93ToZo9dBjyreQdk
 hAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726303; x=1757331103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5nltoXv1Ty4Vrha1PBcGyW0fmFuugPfbNd3aYhKRn/A=;
 b=D9gsbC+VzsLWAJUb5PbCbxLD8UGbxQJpUlgeus1FAM9wnZjRpIEE4tA+Pyoz1vFz6C
 +6YD7S7GYHHiAvbZMSVDYjKpqvzEf8Dxw9hv1Y2xhP9z8aJbqiK+Ntc9f+KEWcDLR8ZO
 YxuAn2YnxECSIJ+mlQJko6QRRTwu28pPRjlY5EirSvSPNeHs8h2fVvYcLNIiD35jb2M3
 x4njHY1jOY8HiNbjYgFYtUSTA6vWdo2zFE+Uwb8+n0RIZb2iviNXrPXDddNBohuhDOQM
 FMe3vV3zVKpOtWqNHNCv+qC+mAnYgPFbaNkLgDUFmkAMSW9wRsrYiu1UsBdsrYcQvUai
 Teng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1P7sMvK4bkKZQ2Hx5QFufWsz/z/LjALV35VH5jI2LP0uwDm9Le/Muu8T+gcVtkEU66/+TSoP7ri3z@nongnu.org
X-Gm-Message-State: AOJu0Yx/yDe/nagfqDBWuxXnxEKS6ZbyhaXYC8NMQLdZgVR/KdrT+r2c
 iWoadeRbc8GVW+evHbSDK2WzzmRBtCsFUkEUmCdp9CmDrL0BjUxCJgyo1mGrKkj8Q50=
X-Gm-Gg: ASbGncuXQiiL8w6PGV/fbM78JTig3wZOoN4yl0nS+id9I/+UlaWk9u/xZ1MG8ahYg4u
 sLUIUWNGgTvJYzxm0drVh+I4VGlmPhD0hPjGbER5/a/3QBweHPWKpLzih5taaDYmGfRnKn+Ch5y
 HbcAz/eL7VehzbulTGH4e+F9Ad/vXI8RjxGATuQiLtTLAX/UQa34SyegfWGCMdZeqvI8AvuDeuY
 /uwHj9YIth5ckcPGcIw+Bv7vTVa8FFphnlDWXck4YhAQl7x/hELWXvTuDQdsyDoYUzz5rQBH2cg
 N7GoXMYK/xmaM/H0XzcGENnwLmTlX4Elxc6ZWQj3qkKjmLQNgG8Zy86+5m3mAvV4Ygr64kC7JLQ
 BHGbjReW0Y19Bb2vY6LgyWLSvtgV3gB90A8WpwSW6tFFrUop0nDWbOHl/mkSCvd4FX4lQWmf/zW
 Ji1xW2DW/yEY8=
X-Google-Smtp-Source: AGHT+IH9UPWvgem+TiaqdQIiQ+Ci2gT+m7HlBEWw5dTdm1mCmi0/j5V39yo1F0iuIXerNzHDGbLuvw==
X-Received: by 2002:a5d:64cb:0:b0:3d4:1acb:aeda with SMTP id
 ffacd0b85a97d-3d41acbb2d4mr3947845f8f.15.1756726302826; 
 Mon, 01 Sep 2025 04:31:42 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d1007c0dc8sm13204993f8f.53.2025.09.01.04.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:31:42 -0700 (PDT)
Message-ID: <5b34feb2-b9ef-4b95-8e6e-dc15eefa710a@linaro.org>
Date: Mon, 1 Sep 2025 13:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] accel: make all calls to qemu_wait_io_event look
 the same
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-13-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> There is no reason for some accelerators to use qemu_wait_io_event_common
> (which is separated from qemu_wait_io_event() specifically for round
> robin).  They can also check for events directly on the first pass through
> the loop, instead of setting cpu->exit_request to true.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/dummy-cpus.c                |  2 +-
>   accel/hvf/hvf-accel-ops.c         |  2 +-
>   accel/kvm/kvm-accel-ops.c         |  3 ++-
>   accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
>   accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
>   target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>   target/i386/whpx/whpx-accel-ops.c |  6 ++---
>   7 files changed, 30 insertions(+), 39 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


