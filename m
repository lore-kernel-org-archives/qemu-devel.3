Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46075C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ReR-0008KU-3Q; Fri, 25 Apr 2025 18:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8ReH-00089A-5V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:35:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8ReF-00068O-CP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:35:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso16932215e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620554; x=1746225354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGQq+Y71tM+giZAaBHOJOE0+P6uBfAt6Rl6hXPG++qU=;
 b=AD/IlGpon0/E2uKENUPVtk7XhMk7J710Uo6sBM8qLdRbbSNW9BC0RdaACsrjjICJsl
 dX2QiW3wRtoebObgMzWYLEtmbMehB2/7OMXfQxzLvaeb/2WfDcID/6gKjmFubfvMRk5y
 3mBGoNXl6TlBNDyC/Vt6m6vm+vEtoF7+FtV4Js7ZUKhi4uZhqjUlEKXtiiIXgk+T9Gx/
 Eokt1rlnME0xFMcYFfIb+6Qonf2CdQVz0jwo+TBAhHy2TyB4/8CFc/Mmygyk4YXYnAce
 8qGhKjQn6X/EfwNfd6LbzPx6dPMBy80JXTxTwFhNhx6wHgeVZ4jP9RAOPjRZiLO6pizg
 XY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620554; x=1746225354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGQq+Y71tM+giZAaBHOJOE0+P6uBfAt6Rl6hXPG++qU=;
 b=Pi6ztcgryOmzFiWU1EEszczoSTkw9HDc/hhLHXa+m8nY92/dMaGFdCkNXpEY96rSUy
 hWexZm6yc69pmklA4rMgaMnEaKBPh5KKT1mSSLtlOh5Kht7mDYbySsWPw+I9AEosLnYi
 xTxaGeG0I/Ppk7t8+v2NDUpVrqQIVmfHDWrhWqx3w1cZtxXUarN+i4M9WnOTkxZavrsZ
 GAolh2GQdd24w/Ld1lRi935449RNiyVEh2a/ajpiHSIQ0aBdkTe2k1wFe64AgFoxSFtk
 7YqAIZJYd6aUdiFjFTZaLy0N01zLC9Zz6VRdYNxE8K9ixI/bv077GiLC9sCydQVjR/i2
 P9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV541QT73rXLR5zkAHcwGRPG/HwpnBGu5wDn9fq9Gt60RvtTGgruNfcdKGWlBZsxu3v7sI4b5KoyIpQ@nongnu.org
X-Gm-Message-State: AOJu0YxhsqJfTYXypICa/nl3OfwRePLtqVI1urAYLvbwBd9VY/q/0GLE
 gwrl+uB/mfLy6yIg0DTG3IknrsB1bE1s4XhsMmVm4y7kEXVHS7D3HRfRrzVKjTqfb7KOtV2h0Cq
 v
X-Gm-Gg: ASbGncsWIILhZAaZitY79t1jf3XL0ZUEiWENCYQR/ELmI02I0qE8b5stFvOwNz3YsIf
 kDRnMleulidNu5bnl3T1LiQKZFYPtgisFgX+x0PECGvfGroQ4kRhuKyqTBmeadzneFyjP8gZlo4
 zvWJf3LGP6PAquKzqlX9LcE9KVb82DkObvT5Aa1ZK6JD4KeNlKz1fqHCm6w0Dj4ZN3XviZTxzpp
 9M+YXCv+sMgWHPkvkQhJAqBQJj9sr+ps/RvQUzyNWsz80GpAl6x3lWDyDSzKWP4Xb/dddCs3DGw
 7FP/c6z4GKuSaq7z7vJlfFm2yzU0OfEQHoVVf5DGJqHgWhejckaurbEe2j/3M1yYi/8Plz6lW8q
 iYGjOnILd
X-Google-Smtp-Source: AGHT+IHiqRvnBBcQat+Z3TCjfAi/JTfJKuQyZ/XuA4sM1fsR7pbyV1E+h780ulO/uJoCiLVsif/W+A==
X-Received: by 2002:a05:600c:1c09:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-440ab872047mr8237075e9.30.1745620553934; 
 Fri, 25 Apr 2025 15:35:53 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca556bsm3585046f8f.37.2025.04.25.15.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:35:52 -0700 (PDT)
Message-ID: <4cfc3a69-bae7-41ae-9f82-13eee8a8164e@linaro.org>
Date: Sat, 26 Apr 2025 00:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH alternate 0/2] target/riscv: Fix write_misa vs aligned
 next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425165055.807801-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425165055.807801-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/4/25 18:50, Richard Henderson wrote:
> This is an alternate, but less exact approach.  It assumes that there
> will never be a 16 or 48-bit csr write instruction.  This feels dirtier,
> but it's a fair assumption involves much less faff.

I prefer the other safer version which properly propagate $ra, which
could be useful for callees.

