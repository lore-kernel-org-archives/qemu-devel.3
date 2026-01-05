Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A04C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYJS-0002Yu-G0; Sun, 04 Jan 2026 19:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYJQ-0002YU-FT
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:19:08 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYJO-0007rW-Sa
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:19:08 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso17216409a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767572345; x=1768177145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRBxSXBDRV/DGi6f4JPRhbP6zaMkeG5We5M1tpm7wPs=;
 b=DO7wf6MvIYC1cDOkjAq//HqHkXjgPK/QIsf3F3rJ+mf50242ClWoh8ORKBHr3kra6q
 zQZL+zuoo8xlFxcPxLiOGYkGmuu9nIgArZn5TsKeNYEOMxBqyGPLCd9AKQunW7MiuB58
 HeqNiYxfZDh0A/sd9SQQS+3ZUJ3aUp/GmNBAptHAFLCULvOH+nu00rKpKLupg3uHZAw9
 4lpx1pfPKqbOWRnRdR7+tBfGFe6+fDnapvLAEZnbeSLMw3urxpl7pcsWFYqgSG0Xckmg
 PWVxT4DgvdRpCfPTO8xlWf8LTisrkyloWBkfox3fFv/7yvMjZJlr8F3FhdrFgqVLskl5
 wflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767572345; x=1768177145;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRBxSXBDRV/DGi6f4JPRhbP6zaMkeG5We5M1tpm7wPs=;
 b=oIosOUS51qboJbB9zvWLWRvYWeuu7O/45xBkqq+N88rfnJlfWbh7qdp4VqNGDncm/X
 WWBMUT34SuQ9Xd006T937+F5JO1TkWiIbRHwS5pyj1ou3xvAAIDz2YFlejITIvWG/WK7
 ud3q51Gcx6mz4UQcXH8RpvQE4tHyB27SVTGL4XcWqI5Co3e/f47O4o5k4CdeekyOwd4e
 ISwefaNLfLf0NIMbi1iNffLtKota1R8SaHZ7vb7pBDlWT5S515UyaVxUx5ihnrcxpl2w
 GjcIw/9dl+RjrTrVcWFT4HutWqbzoYecHbdlnMwMJihIkrIQuTDyPLnSXWaRiwXuU7PD
 S3sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdCpOt78Mv8Y1S7ulaDne4MmFmm4kpbC4me+8/GIAsxC27CzCluY+yChJykAG8L5QhcTcfrMTNqtBf@nongnu.org
X-Gm-Message-State: AOJu0YzAAUY4jR792pbJqfGJanm8tQkKXtfnyfcnx79+EBWSHqe0EErr
 aj+xgZi0Qzlx9batkOlweSUJ+x91mdvaz6Xjv1yLspt0D+01sychfLjM1QAHffuuSc0=
X-Gm-Gg: AY/fxX4RH8Hpr1ZKiEFcd6DMjIUeF7gcUugPfU41PKEqKHvH/hW17ewg60R7APx2Qne
 jF7D12sjKRpX65heXLrRBioBfXuv7xv9MSHJb4h4AvxhG8z7iR/TsGrh3UIr/wnRA8jbtUTiP9Q
 MEnmrjCT5Uwk4S5Ofz8DM4tucQK8d4PWuc6f+VUXwgNtafLv4Es9CIEIiIM+G4VeFsQZHqVJbC9
 zC0FO63m59Pun4Mx38JPwQco54Ij9JJ0JPUWPIs9R8igTNJyX/SFvfT2eqASwjbOssGyarjvTJF
 /Y32qaq8WWJMew0Oew1LlOhh87u28HZj/AuGbaRyzXlSFqeLMCcPev0O67FuGQjMAASqXVJ/vrC
 sT+R79VViFLKKbyJQK8Uu6GTIEjMHLnS0zZTS/VVXGIHsCsfaSb2MnBDqtk7UfMSnHbsYDX2I4N
 tXunJx+HWEGN7qKs2oWok8aIFJa3YrbEz3NoZOFsVD
X-Google-Smtp-Source: AGHT+IENLUtw5DZwQ4rOhILp2R/D9vWIZY07FyjvnkJBJe525111qr6ACtCsfAb9VgGO5Gq9qSJ+3g==
X-Received: by 2002:a17:90b:224a:b0:34c:99d6:175d with SMTP id
 98e67ed59e1d1-34e92122004mr35184959a91.2.1767572345239; 
 Sun, 04 Jan 2026 16:19:05 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f45062d7fsm2783212a91.2.2026.01.04.16.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:19:04 -0800 (PST)
Message-ID: <f78a4f65-8556-4c09-b1e5-bfdb7572cf5f@linaro.org>
Date: Mon, 5 Jan 2026 11:18:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] hw/sparc: Mark SPARC-specific peripherals as
 big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> These devices are only used by the SPARC target, which is
> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/audio/cs4231.c        |  2 +-
>   hw/char/grlib_apbuart.c  |  2 +-
>   hw/display/cg3.c         |  2 +-
>   hw/display/tcx.c         | 14 +++++++-------
>   hw/dma/sparc32_dma.c     |  2 +-
>   hw/intc/grlib_irqmp.c    |  2 +-
>   hw/intc/slavio_intctl.c  |  4 ++--
>   hw/misc/eccmemctl.c      |  2 +-
>   hw/misc/slavio_misc.c    | 16 ++++++++--------
>   hw/rtc/sun4v-rtc.c       |  2 +-
>   hw/timer/grlib_gptimer.c |  2 +-
>   hw/timer/slavio_timer.c  |  2 +-
>   12 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

