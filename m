Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D76CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 16:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v55KX-0002hF-JF; Sat, 04 Oct 2025 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v55KW-0002h7-9r
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 12:41:56 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v55KT-0000Zu-Uw
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 12:41:56 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so2321000a12.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759596110; x=1760200910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X6ShDkrhfUEWhjlrVbJnRSaGXMiiVRsHkpZ71yrckv4=;
 b=c4F6pdBgw7cKHo7ZNQxpjRbZs27XhD9JhTcsFwkdAMj6I96cI3t3H68pLEBdSrTcU9
 6r4PuR/pSiGLij+N3Y2hNi5qcShieFxUSmH9iJXPWPkshpXBlg7YLf3k40KXsdS1MMIS
 jTc68P5kK1FzSXbP6VfHlriBMNsudlBlqc8OQmcYgaWlF91lNoIRelglp5FG+jmVAAv8
 U8VigPF4JWpmI+uJ/uwSuPUdPoIkZE6tmvMiD99R93zaJPX6iLH1w7Wiuf/si+bIGnxI
 cW/Onfe/R/cLqfsG7jYZ3L59y0mCOw9WaF3INkMP6LVD/xz+eoUpuASphfhkJNL+Up0x
 i27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759596110; x=1760200910;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6ShDkrhfUEWhjlrVbJnRSaGXMiiVRsHkpZ71yrckv4=;
 b=GX7foRRNSrdH6wkxGL0E64/KM6TYCVke0S54NHq6nMBsIZhU8gxqiOnjX7LCScH43M
 AjwBo/naR9LVrWM+pQErmQG4aXuJgSMzm1Ks4h/E1sSrJKHq9OOeHXA1XejbaPpFhcDf
 u3xZFPeqt1dALYge8ceKDfLr6bZ0F5m3SJByEQi0GXqZJU86Gq88VtaEmHuFxhuolSQp
 j49NZXzcUxtEV4q4/cF/Dc1JHhc2LpTX1XlyZRbBlS/icjqpahG+O5jX45u7Lg2J4bUt
 /2M/KsUlrXorvEVyr49K/A1IufktBffafjH5mcSSvtZUe+5MXd9uJJuIbShWefzLv3m6
 Jacg==
X-Gm-Message-State: AOJu0Yy5oSXDa2+b5LPi5m1Eb3EfaLZUgnsTN2+T4lR7YbpwG6whHq7l
 TzlFsWSP9OYRuMm1EcOWY5/P3U8sLf+Jgok6YAN81cb4xq+lkm0d/Jsix85uYprvZQo=
X-Gm-Gg: ASbGncsLi410JtmMvrEXuYNJTpM6yiy5p8iny3Bxiq8B0tyV3gXdy+Ar27zi7SZsvet
 MhTDDVDzF0BYcyooyPeKkY4ekdUb1d6lUmAFs2Uq+3bFBAw4uHfomc4H9OqQr6nQ8y75Acuahey
 Pa7sNdd9l72PMeUORNDoEB2tPq1ggPhoSsdH6/rUYJwaQ4cxzs5WtMM6K2KvbNnD9atxKQlvCR6
 1unPbvKPCLv4kDE1vbHggXTXAph9Jzz26sJfNI0TgjpoTgtQw3R9q/bI8oEbInkIWj3hH5OMOzm
 36oBDAqMvDd47hDB+Uwm7+j7ozhNlY3VzegT0HkTbBhrHwoKf+ddoeGzMQ5DCdbtpGHqgH/2JuM
 YDksOiscJVIYj50TPXu4wwDXHDGYY+z97O6J1qQBbnrOSMFi2XAOB610T/ykGbT1fjzuH19R2x1
 E=
X-Google-Smtp-Source: AGHT+IH53NDw64fqxE+CqnsWAkaWUT+nLX9/OcPBVoSX/fSrcXxc03rRPAB9rmUnar59Gv4UDKzRdQ==
X-Received: by 2002:a17:902:db0f:b0:276:d3e:6844 with SMTP id
 d9443c01a7336-28e9a619e63mr78529025ad.33.1759596110335; 
 Sat, 04 Oct 2025 09:41:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a49b1fsm5514279a91.24.2025.10.04.09.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Oct 2025 09:41:49 -0700 (PDT)
Message-ID: <c5976952-ecdc-420f-9025-c80018b6b123@linaro.org>
Date: Sat, 4 Oct 2025 09:41:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reg. guest unaligned accesses in TCG
To: Pranith Kumar <bobby.prani@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 10/3/25 23:34, Pranith Kumar wrote:
> Hi Richard and Alex,
> 
> I am trying to implement efficient x86 guest on ARM64 host
> virtualization where the host has FEAT_LRCPC2 instructions. If I
> translate every x86 load to LDAPR and every x86 store to STLR, it will
> meet the memory consistency requirements.
> 
> The necessary condition for using these RCpc instructions is the
> alignment. The manual states that alignment fault will be raised if:
> 
> * Not all bytes of the memory access lie within a 16-byte quantity
> aligned to 16 bytes, and
> * The value of SCTLR_ELx.nAA applicable to the current Exception level is 0.
> 
> How does TCG check for alignment? How do I check if the guest memory
> access is within the 16-byte alignment? Will alignment fault be raised
> if it is not?

See prepare_host_addr in tcg/aarch64/tcg-target.c.inc.

a_mask is the alignment required by the guest, s_mask is the access size, so a_mask >= 
s_mask is required to be at least naturally aligned.

That's only enough to get you to the slow path for page crossings or guest misalignment. 
For additional host alignment along the fast path, you'd need to generate additional 
branches, and probably not here.

I'll warn you that I tried this once, and the extra work proving alignment overwhelmed the 
savings from substituting acquire/release for separate memory barriers.  I'd love for you 
to succeed, but this won't be a trivial task.


r~

