Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4hq-0005oE-Vs; Tue, 10 Dec 2024 13:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4hl-0005nh-Lm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:11:30 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4hj-0002fW-2j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:11:28 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb34c20667so1441673b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854284; x=1734459084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xNCAZCmzTIS1DDd1dp6cPLo6uaK+hWhPDAepblsyRtM=;
 b=zu3UjfbM3wIqN/y9dAR9xO6eKiO82Q01YnHzGLhWKNDuOscZXN6DCKNejyDS7fEGrk
 TAMx73veKgYvXkmp5QarVjRW+S+DbaqYIJ7LumxAgfxzu3zi34d9UZxWsszGAyIczyt4
 dZh2q0vZYFEVLbtIKCrkn0uDzyzNQo161UUQdrtrZ0Ebp5F/FLXgps6CfBCaF7ZjYh1o
 kNPyOLxYB7KYh1cGwFaaKumGwTgkKP+2dkNNQE27god32RFoB6EFExg3vbxc5JsbhXNo
 RVPXIJl6bILUZ8WdDIkB2apEZbMQ4BkrFUZfKUk414vXVPURphzldm0kVbxH7szBZwl6
 wniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854284; x=1734459084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNCAZCmzTIS1DDd1dp6cPLo6uaK+hWhPDAepblsyRtM=;
 b=qJrGHqj6d9uWiFxUXIKkCVJ4XVgF0VhQilEEvO1e8o2THFw1t3Rc7TuRzVbbwEQEwr
 9LOce4Evp5yJXDmpD2a6pV2CSzaxZ6YSvqGeZgSGGD1QZQtv+VpbU8qfz3LY97RMy4S3
 7aSXxqu/l70SB0f3lgfariP3kIIm+6cVqni+BQ/D6RYeXPpAkIB8lIyJhRvWkGRORmhs
 8lBHPFO4U13MeFyvUIzSFbguwy4IknDYLYrsXINVKJq29a9RWxlv4Yy1BH1SxZPcUy7j
 fDsVsxt/YAO59vbmKNe+iIexl24gX8jdI0Rs4MacTv89Ao5AvheCCzydhcY42Hzbefib
 7FWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0FRdOdDY7vzi7Sikn9fw2zXQual602h/Ti6IRSCa9qZc1V8uRCWQckFbz3FmPDQE2jB+34mDaKckr@nongnu.org
X-Gm-Message-State: AOJu0YwbLEwBMhi5yNWE6VYneuMjlZx1h7IW6jujjei2HvBEQ7m/nPk0
 AF1TZNtHQCQaxqG4sgQZeUa8e+LQc8u5YNbulad6ljNFnc4kSZ1kzmLntAsW/Cw=
X-Gm-Gg: ASbGncuAJHs9udc7w+iHp6KvH7d9wZ1CCsp5A8H49jZbyWAxKmEpZW8SPxTllhrA5+6
 9T07K6zZUbDbThescG/haDFa2b9ZDBDV8LE7Asj3M+3rsq8K7mOhgwbYCo0WVikm2yHPcXSsJ6k
 m4iXSWSA+yJ+GXEuhwLdpdiukppJ5PGj/Uf3Zb7gRpveYnTyNVUlaHitvqNHMgZB7TuRsFUGl3o
 UYAVbiBdva3H6rMQZJ//mZBvsB2GC7MJ47c3i1+e+UmDErObBF3MwUK0AAVGqpxidJbqy4=
X-Google-Smtp-Source: AGHT+IEH7zSOyFVv09GzucwBer+N2GhqvJzLKJKdmX9BUUIQm68j28Q1/fd8M0iXxBB6gFOE+bzRjQ==
X-Received: by 2002:a05:6808:1919:b0:3eb:66a1:9dab with SMTP id
 5614622812f47-3eb66a1a7a4mr4121263b6e.10.1733854283145; 
 Tue, 10 Dec 2024 10:11:23 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb6dc15475sm500104b6e.39.2024.12.10.10.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:11:22 -0800 (PST)
Message-ID: <bdbf12a9-0e34-4924-88a5-80b2f7eb1961@linaro.org>
Date: Tue, 10 Dec 2024 12:11:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/arm: Move TLBI insns for AArch32 EL2 to
 tlbi_insn_helper.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the AArch32 TLBI insns for AArch32 EL2 to tlbi_insn_helper.c.
> To keep this as an obviously pure code-movement, we retain the
> same condition for registering tlbi_el2_cp_reginfo that we use for
> el2_cp_reginfo. We'll be able to simplify this condition later,
> since the need to define the reginfo for EL3-without-EL2 doesn't
> apply for the TLBI ops specifically.
> 
> This move brings all the uses of tlbimva_hyp_write() and
> tlbimva_hyp_is_write() back into a single file, so we can move those
> also, and make them file-local again.
> 
> The helper alle1_tlbmask() is an exception to the pattern that we
> only need to make these functions global temporarily, because once
> this refactoring is complete it will be called by both code in
> helper.c (vttbr_write()) and by code in tlb-insns.c.  We therefore
> put its prototype in a permanent home in internals.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  4 --
>   target/arm/internals.h     |  6 +++
>   target/arm/helper.c        | 74 +--------------------------------
>   target/arm/tcg/tlb-insns.c | 85 ++++++++++++++++++++++++++++++++++++++

Subject has an out-of-date filename.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

