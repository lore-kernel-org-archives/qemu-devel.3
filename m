Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C61C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXM5S-0004wJ-7C; Thu, 03 Jul 2025 11:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXM5Q-0004vi-80
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:42:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXM5N-00052l-Uz
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:42:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453647147c6so87341795e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751557371; x=1752162171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ntlonvLeCaKhhtUx/ayDLB+iJ8zvvDDgN8XCnp0Kqf8=;
 b=l7sqYBrmqMiMTh5/fNIPde2pUCwRmtdh/obMyag4yrUOehWls37rOgvzeZrjaGfSkR
 /O/7W97et2TLKcISDRvW2aeT3Pmh3K3ZqbCt+ziAmzzvA+WZl3XQId4yP3CxdN5WlZQ9
 KEExS8Cj+8f0JPR9GNlqsdizDMui/ZXaPp+0NEXMCj7Fmb6CD7pnd+D4h76xgqZBUeMa
 evlRT3fekFOtE1mvjOlTQFRTix3GLYJ7zDQTpGQ+CjQ45jRmFFB6/1ZZsLrdwEn1TTUX
 XiAKzJ6tZBT3L9BR5SyqZB6t3tmjGz3dp9NsVPZWgIweYOLr6RLKKcqHdTxpNKvsa53v
 yHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751557371; x=1752162171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntlonvLeCaKhhtUx/ayDLB+iJ8zvvDDgN8XCnp0Kqf8=;
 b=WfsGmTRfob54eLubmT9txqSo5xIbItgshUXvl3lUcotpnIqXz9azIWX2MG6MOg/goW
 8Qn7fB6wUEBgd9qhjr7yHhOh2lDE6NzhnLI5hF0XU8WzCP4Y2gP9hiEo4JvVDqVPitLw
 tM1CZDY/ymaKVWPm62WuFruRgBD5MwOqnA3xUdfgRP9dSbzjr/F10rpvypa8fvgQel4N
 4Jg49NXuJGymCNZ9JsHJL+5T9f2xYFIo7Is+sFHk3NxqZCq7k1AER2sVy2VAe4LiSlt9
 H98qY/8uWHQWU2mJ26vH/v5FmZxqAhaRz9EIqde9KwkwB3Wp2azdv/RuZ1a2HR5h2Th4
 2Ynw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRz+P8LfmADRw4bnMSIA9YnBwV8Rpcgm3d6D8lsQqtw72/6UIIw9Ob4qmX2Y1wR7kGOXwxK9ORZmzX@nongnu.org
X-Gm-Message-State: AOJu0Yzbm+I0c5gqxdk97yOyrlQRbIVeWEs/wNVU5hREVWc5ROWkb2vH
 s3v0P7GiDyLCF6f1Ig7YW/iu1JHvQxur4RQw8sD9fqq9lXa6q3yZt4fJV9sdHTJ0zlY=
X-Gm-Gg: ASbGnctsE/mRXI8LUVdR4xxLV1QOArl98NfynoesDqJvcxK4VdNVtFnRuzpkRvYEp9H
 h/d92Qvta2XWAFr6ROGFbNROoPRwZ3H0w88KZPcUfA5KPVbPQrwB2kJcsliD8EX5xCJuG2704xL
 FmNnNWmG1WUwyTmi+/IVEP0/iaX296nwkQEHdauXHJGX6i+z0qdzW7xXqStL7CDgMofaGp7Frdv
 bXFNvvzmxEZbgmxwlDTnZUQ5y0LtyOvA1/xPCpIFbnr+KFOJ3NB5yi6x1ECGJ1m4fv+7z9QX4pf
 c0RW1MkMCJyKGUkvP8LZr9J9Yv2gRLIx3Psv8tWwk3wJOJ2J9LexdTU9sKb924f7wpVMzBpsgY6
 ONTMOPPc+kNBH0IbI36GFY9tlBKV3AZmd/R0GmD2i
X-Google-Smtp-Source: AGHT+IHqAxkDw4k5ySFbRhB9iq50aBVHRWqsssUVzLGsjgyA1DuPYmM0JUsTGYsCZmkxBxuldqrp5A==
X-Received: by 2002:a05:600c:1909:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-454a3c0740dmr72460755e9.7.1751557371101; 
 Thu, 03 Jul 2025 08:42:51 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9be0bacsm29120195e9.32.2025.07.03.08.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 08:42:50 -0700 (PDT)
Message-ID: <4def8695-076c-4348-9bba-c3c62d2f25de@linaro.org>
Date: Thu, 3 Jul 2025 17:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/7/25 15:58, Manos Pitsidianakis wrote:
> Convert MemTxResult defines into an enum. This will allow bindgen to
> generate a bitflag using the enum variants as its domain of values.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/exec/memattrs.h | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


