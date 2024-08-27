Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B469DC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sikDE-0007s0-0W; Mon, 26 Aug 2024 20:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikD7-0007no-2F
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:37:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikCx-00015d-D7
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:37:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71434174201so4081418b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 17:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724719033; x=1725323833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3StNBRcr1YuZMBkyjtFS7lWI39cX47NjdBiSreabw0=;
 b=WHS/tdkstS8nRvNPMdLEhdH+0HC0DOL9Fruw26qFXwNt+LqCCEiyfuQR5tBZ85Iopm
 Uq1ux7+FZeKVuyTlTftpUcRhOMBRGoPLgY0ciNyW5fCa7XnkWCue0cNoqsaLS1KBt3V2
 WXJdTW6BW0gjUjtV5ss1WY49nlcBOsOiGu3UYgHONEIzZ7X36d03hEJlFgjaHoW0+VdT
 Ln16ZjAKA6GxAK/c+pdOM09s8drRTPnzkgkx/EjQxJiCKBdEtx281kO7LPnIy5M8rUHf
 l6P8+4yhRSdvWD2VZq8CM4TlOfFuGAEMcUW1qwXkKw8JnsSYLnTzWVKfTE7oWErX3Ibr
 9Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724719033; x=1725323833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3StNBRcr1YuZMBkyjtFS7lWI39cX47NjdBiSreabw0=;
 b=wyxFColscv5DVj9JXItli5g9WCkfPV4FcGbXglFwfTtwL9GE+f/xJfwoduB+gwweLh
 8hEYVPsLqLDCavAlS9s+8vDLbz7Amn3CpjVul5SZ6XCzJBxYBXQJIZRjdOQNxGqro5OD
 51o0sTggtzJJt8qkHdvBrV/kqPWcyMdBe6uwpt0UCzeoLi+rguZUzqaOfrETf1E1bEgH
 2ycdcjBcvMlEbM81c+FzSO0KK2g4CCNpSzi2Txj3am/8FIhO8Mr6Y5K7flLg7HHC6YoA
 ifyzO6sdMLnxz+1WvRJWYATS7sh+LdDgHdcW8JLxhh4AOtAjMtOxkH/Nz1EwPNnM5wlO
 weDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9K7eZdKlEkAAtUE38d2Aql4RN5nNImpDoOo/U+D9AEqHmLjJ+tJHHS5rlpsTJS+dyvlvAxM3rrzgt@nongnu.org
X-Gm-Message-State: AOJu0YwvH3IIw487vsOgysmdhA6J01mEok45OULNBDY+AtZGMwF8xC/h
 Ce0ag8DSlbDuIVVBGKLZSgtF7L0OYczepi2MTt8eyTe2wXyukrtmI2TwU4vKmvCF8ae29exj2Eg
 UMpk=
X-Google-Smtp-Source: AGHT+IFT1CwmOOeGDr95Dlu5tqxs3WeXCobTEfGbQPyp8+exXFTfgdambH5wTr+6Sw55dAr6imaNFQ==
X-Received: by 2002:a05:6a21:e95:b0:1c4:d4b2:ffe5 with SMTP id
 adf61e73a8af0-1ccc09b0157mr1221438637.54.1724719033056; 
 Mon, 26 Aug 2024 17:37:13 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855df501sm72809115ad.132.2024.08.26.17.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 17:37:12 -0700 (PDT)
Message-ID: <b41ce648-b4e3-41de-9ecf-163fe59207cf@linaro.org>
Date: Tue, 27 Aug 2024 10:37:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/17] target/riscv: compressed encodings for sspush
 and sspopchk
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-16-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826152949.294506-16-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/27/24 01:29, Deepak Gupta wrote:
> sspush/sspopchk have compressed encodings carved out of zcmops.
> compressed sspush is designated as c.mop.1 while compressed sspopchk
> is designated as c.mop.5.
> 
> Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
> c.sspopchk x5 exists while c.sspopchk x1 doesn't.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> ---
>   target/riscv/insn16.decode | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


