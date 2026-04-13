Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E5F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQQR-0001ED-HS; Mon, 13 Apr 2026 19:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQQM-0001Cu-2O
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:35 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQQI-0007cq-RP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:33 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so5014414a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121829; x=1776726629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uMLBHkbqIoy3/o8oR/uJ1QAa6rhaTedm9bKoVhZfLQ=;
 b=nttXkYZwzhZVJB/LTF/FJoXVH2v2aAvo3OzzLaL7UTwatUW6c0ZKTDlPV0fTr/h4vx
 7uink/bR4e+QQSXt4UZU8SDkOlG2MVx1FhaRT4K0nI3VW/L9c3J2WJknsCH1Ky9tnT9F
 LJgfahuLkHGeIGTNnEtdUuW8/aCPeOaODYp/DLzsUk2EOnxAsf9Or9CKloN+aR7w1hws
 uUCL2pYzYS+vggQuRak2tS7iJRJYf8A/mAo0lmW2wAMefhJLe6Vm8GXXNBPbXaQjzn8g
 IUt0ZakmmAcf842CzAWPYL+3vSP5jkqQdFYmADwMFZqUBOfvIhlseouwYvdTcPPYkTHW
 ouYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121829; x=1776726629;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+uMLBHkbqIoy3/o8oR/uJ1QAa6rhaTedm9bKoVhZfLQ=;
 b=J3C7iHNTCagOhTX7oEPVPDSRiXyuxVTDfxcgOGNCFScYvgC/3j+DVvE/AImkYrKiTx
 dkOHnFpA7IonENA8NgnO2BJQlH3JvivRgMFHgSzqgIHoR0bF82SehX5UzMNV+FOBdBFL
 s7hGVIwQ5IPFewza1S1vU8tqzpMmTM4TZtpGbEcZ1/LubD0cz6B/ThBTEmMRNz0+tR2Q
 ptkzFt2kAGNnkBtWhMo3lrVCcs+Yc/8n4HvNBJ158OG1ME1EGMrHr5agiKLfXuQbUp0i
 b3H8QWyhezLXgWYCX2fKn/JziwvsWPzLPH2KrKiUIqJK70SYRWIPf0ADPvis4YnYRV7z
 Bs7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BRBy1oVHAZjVPHArQrEkTFOPEqQiOmtNbFC5XkX9FrQGIjL+cQAAdB+Mz5YDkmNdUQr4zBGxpga+Z@nongnu.org
X-Gm-Message-State: AOJu0YzZvf6QeuYLt50GYhy93GIhc1Lv4og7xEQwHhCBk1Sj73ABw0l5
 KjwhyMRx3LNp3oAB9Ob/7rFfwBSwrabd0+uCe8i4V+t5hqGcUZVMdlW5K4UxMDqLfDU=
X-Gm-Gg: AeBDiesdDI4/aaEx1Js6fXeNkiWMrLiZ8zJ7E/Wer3uyaSDjViVXRp/rpZPlW/O62rN
 SZkxRX7dwCr73LLoLcuMh6yU922Ze0nz3Iz2g2pG9S3sCkCebQ1wNZZFVZnqqCmqPQIOo7jGIAj
 8yG1lswXeEQZ8hzOBZ1EiB72nL6kE4/N27Y0yasfKY+T1l4XpTeQN+/V7AM71K6pXS0Q0BinhKr
 Ot9YcSKHpEJe1hbeme9YLSv5nOZYVqkcxrcyb/jrkjKkJSiXxdoiJAv0bZt9AKk5VvTWUKXcw8C
 liB0AKSyciY10xMbztMEbo3f0VPJ+rDqDmn1J+9Hq5x8gcdqiAXdn5noVaRHyxvvhjjJr+qv4dG
 5uFS8P3Bn/We4zf8VNRCnuvvq6jX/aLGJGwcCL1uF35Brpk7FbV8s2XaTsmdEibbKfWO0FQ8kYl
 AIgzSA6lP5jo7aJpVYa0+273zo88j6hCrQJwSrGSLs8Myuf8PHzrP2ZQC+zcnv+2Dsn1ncWwhk8
 UdivQLb6NMc+A==
X-Received: by 2002:a17:903:2ac5:b0:2b4:62bd:ee3 with SMTP id
 d9443c01a7336-2b462bd139emr43128415ad.33.1776121829123; 
 Mon, 13 Apr 2026 16:10:29 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3b65asm130466665ad.76.2026.04.13.16.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:10:28 -0700 (PDT)
Message-ID: <79d2c8e2-8ee7-41d5-8fbf-ec859032783c@linaro.org>
Date: Tue, 14 Apr 2026 09:10:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 ?] docs: Deprecate Arm OABI and NWFPE support
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260413103754.45745-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260413103754.45745-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/13/26 20:37, Peter Maydell wrote:
> Linux for 32-bit Arm has had two major ABIs: the original OABI and
> the more modern EABI.  OABI support was marked as obsolete in GCC 4.7
> and dropped in GCC 4.8.  In the Linux kernel, compatibility handling
> for OABI (OABI_COMPAT) is not generally enabled by default and is not
> compatible with building a Thumb2 kernel.  Distros dropped OABI
> support fifteen years or more ago.
> 
> NWFPE floating-point emulation handles the ancient FPA11 coprocessor,
> which is only needed/supported with OABI.  Our implementation is old,
> untested and not thread-safe.
> 
> Mark OABI and NWFPE support as deprecated so we can remove it in a
> future release.  Our main motivation here is to be able to drop the
> 2500+ lines of NWFPE emulation code.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This just came up today; it's tempting to squeeze the deprecation
> notice into 11.0 so we don't have an extra three months before
> we can delete it, but we could just deprecate in 11.1 instead.
> 
>   docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)

Thank you.  This is better worded and more complete than what I just posted.  I look 
forward to removing env->eabi as well.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

