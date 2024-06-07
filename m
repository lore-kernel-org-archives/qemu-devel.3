Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD82C41513
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:04:41 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbjO-0006oT-6N; Fri, 07 Jun 2024 11:42:18 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbjM-0006oD-D4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:42:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbjK-000705-S8
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:42:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7041ed475acso138045b3a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717774933; x=1718379733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ryl4SDic3Xdsa+1AlQvHVKGA2pGUsQoKwtw/sfpLczg=;
 b=LAIO8O2YaoAO4e4n/upJyEaeqZ39qzKvo1fzP5Ipo07jWmsqUmG7x4TDYhMl0VTGMp
 27WrYvCpBr3IX3el3GGFr3PZSDnIHWkd3TONv41rMXXKpmRedCwWKoVJDeK4KwDZ3jki
 /ZVsuZQa7jDwk+aoC+PsaHh1lcA7jxizO+5NCe26K29GcrCqlkPlWRQEFCpVig67MILO
 BETlH82F49v9WAngj1I8pzaYKHPLAcuEQE8FwBaZKLgRYGZsIdv+1QT7exHltVYEt4b9
 PGIRRXVLEWJ+KDFTWxkAj4ozU2ulztxMEujJZ3mfLacf0Ua18VoSdM0+vPNmJkeYhOcf
 Lz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717774933; x=1718379733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ryl4SDic3Xdsa+1AlQvHVKGA2pGUsQoKwtw/sfpLczg=;
 b=gI6PwSDYPvv2HFeUrPKPOs43qGg1IgRlT8WjoSajYXW+PKMAdjHI4+Gzf5aOdlTBm3
 QlEg5oEryczQ8y/5Zw7yHrO3Wumh2D8zBEzahgcxY6WhK05gIfbSKcvyOZ83Khj/AVJm
 D65CZ3E/MmeIUrzJtfwTE8Yqekje7aY6HzAAs8FVnroBlxZCbMUkuej61llmrMwj4YsR
 r0067bpxjmmqz4ZouCbdxpUa2W9kmcIHJ0z6YfO6tHwHhj7duZTPI6KkYBcQLmTsyCtu
 NWPqyeLE+2g5qzBqkFIf/LS5gxOYoxCT43kzkcAEeBGAquHQLC1OZc+LcntUP39+0HkS
 ABaA==
X-Gm-Message-State: AOJu0YxfzEbWTpvSnHytDwy/Dm1rwp5HHMd+oVEaLiqpnE+SF5E1AMNN
 VblhoO7Hvg3vqCU1wrsuEh/hHX2nqXxovLYK+cgWIzTorFi9iJ0RTqb5meBn8bw=
X-Google-Smtp-Source: AGHT+IF5dnPM97e+RfEc6bBfs3MoqsWQZuXmvhVKtFzz1iHVZuHbQimLqdEiRq8/ajR9G2y7E88yIA==
X-Received: by 2002:a05:6a20:a10c:b0:1af:cce1:6fc4 with SMTP id
 adf61e73a8af0-1b2f9a60dc5mr3324566637.29.1717774933208; 
 Fri, 07 Jun 2024 08:42:13 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6de21788251sm2809599a12.30.2024.06.07.08.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 08:42:12 -0700 (PDT)
Message-ID: <9f7b4127-2e5d-4445-b5b5-c3df46fab7ae@linaro.org>
Date: Fri, 7 Jun 2024 08:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Moving VSX scalar storage access insns to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607144921.726730-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/7/24 07:49, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 
> 	lxs{d, iwa, ibz, ihz, iwz, sp}x		: X-form
> 	stxs{d, ib, ih, iw, sp}x		: X-form
> 
> The changes were verified by validating that the tcg-ops generated by those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            | 13 +++++
>   target/ppc/translate/vsx-impl.c.inc | 79 +++++++++++++----------------
>   target/ppc/translate/vsx-ops.c.inc  | 11 ----
>   3 files changed, 49 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

