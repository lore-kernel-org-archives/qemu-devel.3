Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B73BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwbH-0006na-I8; Wed, 19 Mar 2025 12:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwbF-0006nG-KV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:49:01 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwbD-0003FI-PY
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:49:01 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4767e969b94so59421071cf.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742402938; x=1743007738; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ezCJcNJjoERxSNx7F4KSMf5FdTUBDlXKpgNx/dc6lc=;
 b=XXbTIPPhAXEvwuDux8b1j31Gj/N1SkRROeMme5Infjz4UGlLvDknvvBT63p+B/gD+q
 5jncgq9rubrbMTwsAzpSkMBUIxmUM0Y2MzPm/XE+hH22JfYTcLybp0dgN7fhcRJolE1H
 u7Wro3lTiXLljXRWca6i3yEFc29CdlbUHwTdF1hy4ivHcVzQ/j6YLl3sChsIbHqGNHOr
 wGV4i2ciUlbcqfVPv7874Np6CDmmnc73bH3R0PCrrW56JodyOYKaPcyuydiQGNCE1bIr
 2+xFqYQTRhc7giOwja+4DJXyDlKRFglJwLiQyRGexgrOS0tPNQ5I3hX301GwdzFzJAAn
 AFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402938; x=1743007738;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ezCJcNJjoERxSNx7F4KSMf5FdTUBDlXKpgNx/dc6lc=;
 b=et3R5Jr9gj96aT4qXMSGCYC1sCasfLuSl+TgwOeZFzOpBMTZOH7tV4VdM9rH6T41+U
 mGvKBXN0QF/++l4shgolrpc69SjoxEAXyPnjPY2rDyVOP0MJklwvHgl+tap92sCcLXp2
 AKqoRja3x5vlIg/KIcTg+ULELVgaXn+q3cCYAlh5B6kIuiFcTjK/kquNhB6G6a6e8z9N
 6bN9AO11Oye+5jsXlVwIWDvoo71XClPWzKtSYsuS72zd2FZF72K3Myie0vG4a2K2XfqH
 SGleARcFMU85n1YeB4z5davIoeULuUbeHJkDYH7Ps1WH1+K/IlAxQt4N3QLQ0w9sWZD9
 YMUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVruUo2TattnV8ZMNimsPvaBUF6b2s5XpJg9e61kDJfJLOAAIq9rRBNjSDFZrFy5azIXLNWNFxrISRr@nongnu.org
X-Gm-Message-State: AOJu0YwMwJVAfIL33w8eN9Z84s1SfO1B2JNN8uT0d8iksLA2LdMLLOss
 XA5ff7AGvXDv94BbAiq5NSuV8g8VqxvZfiO3eiearzV6/MtMI2k2
X-Gm-Gg: ASbGnctjCJZ4W3EAtpo9fibcgecfZTdNL4JScbOH1YY09WnqGlPjHWzYVK6EAU3JYST
 9vYIVOnQrHg4UC/DvEIjEvLZH8xlu+KNFYC1bxI9zq9LrV4BUp/BwE8sNtS8UOxz2Cym64bEZqw
 kFkEXJZtnBHTQ4WxTTbqApsnHKEQFGKlfOw1aycdGqsfFdlyf0bqL1I46wjaGnofkqWI2F4nFNv
 V5T00aYVxZXJ7J2k0eGVNn1/Or3fEJZ6mCSzcMJAq9k2LiWifhRdPaw95yP11Mpm6J37e5HGHDj
 yHe3cz17pbnGWkGlZkxmbVhy9jB6/dGOJ4PEIAMyF191jBJrdeDIorvvSc0Epw==
X-Google-Smtp-Source: AGHT+IEGgU1Jhx/UgtBQrjmDHB2VhAIDu4ZGghBKwXoTssOpMYsIh1nSLvwlPFsCiuNjLISGdB4yHw==
X-Received: by 2002:a05:622a:114b:b0:476:90ee:bc6a with SMTP id
 d75a77b69052e-477083cc50amr59728661cf.28.1742402938588; 
 Wed, 19 Mar 2025 09:48:58 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4770db5697bsm4417941cf.8.2025.03.19.09.48.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:48:58 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-33-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-33-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 32/39] target/hexagon: Define system, guest reg names
Date: Wed, 19 Mar 2025 11:48:56 -0500
Message-ID: <02be01db98ee$cef60670$6ce21350$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQKDHQUJsvEdLLA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 32/39] target/hexagon: Define system, guest reg names
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/internal.h |  2 ++
>  target/hexagon/cpu.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h index
> 120cfde7b9..fd2397b9ef 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -34,6 +34,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int
> regnum);  void hexagon_debug(CPUHexagonState *env);
> 
>  extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
> +extern const char * const hexagon_sregnames[]; extern const char *
> +const hexagon_gregnames[];

Guard these with #ifndef CONFIG_USER_ONLY


> 
>  void G_NORETURN do_raise_exception(CPUHexagonState *env,
>          uint32_t exception,
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> c7c470b099..3c4776232e 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -85,6 +85,35 @@ const char * const
> hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
>    "c24", "c25", "c26", "c27", "c28",  "c29", "c30", "c31",  };
> 
> +#ifndef CONFIG_USER_ONLY
> +const char * const hexagon_sregnames[] = {
> +    "sgp0",       "sgp1",       "stid",       "elr",        "badva0",
> +    "badva1",     "ssr",        "ccr",        "htid",       "badva",
> +    "imask",      "gevb",       "vwctrl",     "s13",        "s14",
> +    "s15",        "evb",        "modectl",    "syscfg",     "segment",
> +    "ipendad",    "vid",        "vid1",       "bestwait",   "s24",
> +    "schedcfg",   "s26",        "cfgbase",    "diag",       "rev",
> +    "pcyclelo",   "pcyclehi",   "isdbst",     "isdbcfg0",   "isdbcfg1",
> +    "livelock",   "brkptpc0",   "brkptcfg0",  "brkptpc1",   "brkptcfg1",
> +    "isdbmbxin",  "isdbmbxout", "isdben",     "isdbgpr",    "pmucnt4",
> +    "pmucnt5",    "pmucnt6",    "pmucnt7",    "pmucnt0",    "pmucnt1",
> +    "pmucnt2",    "pmucnt3",    "pmuevtcfg",  "pmustid0",   "pmuevtcfg1",
> +    "pmustid1",   "timerlo",    "timerhi",    "pmucfg",     "rgdr2",
> +    "rgdr",       "turkey",     "duck",       "chicken",

The last 5 names look strange and don't match what's in hex_regs.h.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



